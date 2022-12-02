# mkdiscogs

```shell
#!/bin/bash
#
# mkdiscogs
#
# Generate various indexes into the Markdown format files created in the
# Obsidian vault with the previous script. This script can generate lists
# of records sorted by artist or title in list or table format.

HERE=`pwd`
PARENT=`dirname "${HERE}"`
VAULT=`dirname "${PARENT}"`

# Dot in the user configuration file if it exists
[ -f "${HOME}/.config/mpprc" ] && . "${HOME}/.config/mpprc"

usage() {
  printf "\nUsage: mkdiscogs [-a] [-A] [-T] [-U] [-d] [-f] [-m] [-t token] [-u user] [-v vault] [-h]"
  printf "\nWhere:"
  printf "\n\t-a indicates run albums2markdown and artists2markdown"
  printf "\n\t-A indicates sort by Artist"
  printf "\n\t-T indicates sort by Title (default)"
  printf "\n\t-U indicates perform an update of the Discogs collection"
  printf "\n\t-d indicates generate dataviews from templates"
  printf "\n\t-f indicates overwrite any pre-existing username index markdown"
  printf "\n\t-m indicates generate markdown table rather than list"
  printf "\n\t-t 'token' specifies the Discogs API token"
  printf "\n\t\t(token='none' indicates no token should be used)"
  printf "\n\t-u 'user' specifies the Discogs username"
  printf "\n\t-v 'vault' specifies the folder name for generated artist/album markdown"
  printf "\n\t-h displays this usage message and exits\n\n"
  exit 1
}

all=
mkdv=
mktable=
overwrite=
sortorder="title"
updateopt=
vault=
vaultopt=

while getopts "aATUdfmt:u:v:h" flag; do
    case $flag in
        a)
            all=1
            mkdv=1
            ;;
        A)
            sortorder="artist"
            ;;
        T)
            sortorder="title"
            ;;
        U)
            updateopt="-U"
            ;;
        d)
            mkdv=1
            ;;
        f)
            overwrite=1
            ;;
        m)
            mktable=1
            ;;
        t)
            DISCOGS_TOKEN="${OPTARG}"
            ;;
        u)
            DISCOGS_USER="${OPTARG}"
            ;;
        v)
            vault="${OPTARG}"
            vaultopt="-v ${vault}"
            ;;
        h)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ "${DISCOGS_USER}" ] || {
  echo "Discogs username required."
  echo "Set DISCOGS_USER in ${HOME}/.config/mpprc or on the command line."
  echo "Exiting."
  exit 1
}

DUSERCAP="${DISCOGS_USER^}"
DUCAPSTR=`echo "${DUSERCAP}" | sed -e "s/_/ /g"`
if [ "${vault}" ]
then
  DUSER="${vault}"
else
  DUSER="${DUSERCAP}"
fi
DUSERSTR=`echo "${DUSER}" | sed -e "s/_/ /g"`
TOP="${VAULT}/${DUSER}"

tokenopt="-N"
[ "${DISCOGS_TOKEN}" ] && [ "${DISCOGS_TOKEN}" != "none" ] && {
  tokenopt="-t ${DISCOGS_TOKEN}"
}

[ "${all}" ] && {
  [ -x ./albums2markdown ] && {
    ./albums2markdown ${updateopt} ${vaultopt} ${tokenopt} -u ${DISCOGS_USER}
  }
  [ -x ./artists2markdown ] && {
      ./artists2markdown ${updateopt} ${vaultopt} ${tokenopt} -u ${DISCOGS_USER}
  }
  if [ "${sortorder}" == "title" ]
  then
    [ -x ./mkdiscogs ] && {
        ./mkdiscogs -A ${updateopt} ${vaultopt} ${tokenopt} -u ${DISCOGS_USER}
    }
  else
    [ -x ./mkdiscogs ] && {
        ./mkdiscogs -T ${updateopt} ${vaultopt} ${tokenopt} -u ${DISCOGS_USER}
    }
  fi
}

[ "${mkdv}" ] && {
  [ -x ./get-discogs-profile ] && ./get-discogs-profile ${tokenopt} -u ${DISCOGS_USER}
  append=
  numindex=`/bin/ls -1 "${VAULT}"/*_Index.md 2> /dev/null | wc -l`
  [ ${numindex} -gt 0 ] && append=1
  for mdown in "${VAULT}"/assets/templates/Dataviews/*.md \
               "${VAULT}"/assets/templates/*.md
  do
    [ "${mdown}" == "${VAULT}/assets/templates/Dataviews/*.md" ] && continue
    [ "${mdown}" == "${VAULT}/assets/templates/*.md" ] && continue
    [ "${mdown}" == "${VAULT}/assets/templates/Main_Index.md" ] && continue
    base=`basename "${mdown}"`
    path=`dirname "${mdown}"`
    opath=`echo "${path}" | sed -e "s%/assets/templates%%"`
    [ -d "${opath}" ] || mkdir -p "${opath}"
    cat "${mdown}" | sed -e "s/__USERNAME__/${DUSER}/g" \
                         -e "s/__USERNSTR__/${DUSERSTR}/g" \
                         -e "s/__DISCOGSUSTR__/${DUCAPSTR}/g" \
                         -e "s/__DISCOGSUSER__/${DUSERCAP}/g" > /tmp/md$$
    cp /tmp/md$$ "${opath}/${DUSER}_${base}"
    [ "${base}" == "Index.md" ] && {
      if [ "${append}" ]
      then
        [ -f "${opath}/Main_${base}" ] && {
          [ -f "${path}/Main_${base}" ] && {
            cat "${path}/Main_${base}" | \
              sed -e "s/__USERNAME__/${DUSER}/g" \
                  -e "s/__USERNSTR__/${DUSERSTR}/g" \
                  -e "s/__DISCOGSUSTR__/${DUCAPSTR}/g" \
                  -e "s/__DISCOGSUSER__/${DUSERCAP}/g" > /tmp/index$$
            grep "${DUCAPSTR} Discogs User Profile" \
                 "${opath}/Main_${base}" > /dev/null || {
              # Append new Discogs user profile after existing one
              sed -i "/Discogs User Profile.*/a - \[${DUCAPSTR} Discogs User Profile\](${DUSERCAP}_Discogs_User_Profile.md)" "${opath}/Main_${base}"
            }
            cat /tmp/index$$ >> "${opath}/Main_${base}"
          }
        }
      else
        [ -f "${opath}/Main_${base}" ] || {
          cat /tmp/md$$ | \
            sed -e "s/${DUSERSTR} Vault Index/Vault Index/" > /tmp/index$$
          cp /tmp/index$$ "${opath}/Main_${base}"
        }
      fi
      rm -f /tmp/index$$
    }
    rm -f /tmp/md$$
  done
}

[ -d "${TOP}" ] || {
  echo "$TOP does not exist or is not a directory. Exiting."
  exit 1
}

if [ "${mktable}" ]
then
  if [ "${sortorder}" == "title" ]
  then
    discogs_index="Table_of_${DUSER}_by_Title"
  else
    discogs_index="Table_of_${DUSER}_by_Artist"
  fi
else
  if [ "${sortorder}" == "title" ]
  then
    discogs_index="${DUSER}_by_Title"
  else
    discogs_index="${DUSER}_by_Artist"
  fi
fi

cd "${TOP}"

[ "${overwrite}" ] && rm -f ${VAULT}/${discogs_index}.md

if [ -f ${VAULT}/${discogs_index}.md ]
then
  echo "${discogs_index}.md already exists. Use '-f' to overwrite an existing index."
  echo "Exiting without changes."
  exit 1
else
  echo "# ${DUSERSTR}" > ${VAULT}/${discogs_index}.md
  echo "" >> ${VAULT}/${discogs_index}.md
  if [ "${mktable}" ]
  then
    if [ "${sortorder}" == "title" ]
    then
      echo "## Table of ${DUSERSTR} by Title" >> ${VAULT}/${discogs_index}.md
    else
      echo "## Table of ${DUSERSTR} by Artist" >> ${VAULT}/${discogs_index}.md
    fi
  else
    if [ "${sortorder}" == "title" ]
    then
      echo "## Index of ${DUSERSTR} by Title" >> ${VAULT}/${discogs_index}.md
    else
      echo "## Index of ${DUSERSTR} by Artist" >> ${VAULT}/${discogs_index}.md
    fi
    echo "" >> ${VAULT}/${discogs_index}.md
    echo "| **[A](#a)** | **[B](#b)** | **[C](#c)** | **[D](#d)** | **[E](#e)** | **[F](#f)** | **[G](#g)** | **[H](#h)** | **[I](#i)** | **[J](#j)** | **[K](#k)** | **[L](#l)** | **[M](#m)** | **[N](#n)** | **[O](#o)** | **[P](#p)** | **[Q](#q)** | **[R](#r)** | **[S](#s)** | **[T](#t)** | **[U](#u)** | **[V](#v)** | **[W](#w)** | **[X](#x)** | **[Y](#y)** | **[Z](#z)** |" >> ${VAULT}/${discogs_index}.md
    echo "|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|" >> ${VAULT}/${discogs_index}.md
    echo "" >> ${VAULT}/${discogs_index}.md
  fi
  echo "" >> ${VAULT}/${discogs_index}.md
  if [ "${mktable}" ]
  then
    if [ "${sortorder}" == "title" ]
    then
      echo "| **Title by Artist** | **Title by Artist** | **Title by Artist** | **Title by Artist** | **Title by Artist** |" >> ${VAULT}/${discogs_index}.md
    else
      echo "| **Artist: Title** | **Artist: Title** | **Artist: Title** | **Artist: Title** | **Artist: Title** |" >> ${VAULT}/${discogs_index}.md
    fi
    echo "|--|--|--|--|--|" >> ${VAULT}/${discogs_index}.md
  else
    heading="0-9"
    artist_heading=
    echo "### ${heading}" >> ${VAULT}/${discogs_index}.md
    echo "" >> ${VAULT}/${discogs_index}.md
  fi

  if [ "${mktable}" ]
  then
    if [ "${sortorder}" == "title" ]
    then
      ls -1 */*.md | sort -k 2 -t'/' > /tmp/discogs$$
      while read discogs
      do
        artist=`echo ${discogs} | awk -F '/' ' { print $1 } '`
        filename=`echo ${discogs} | awk -F '/' ' { print $2 } ' | sed -e "s/\.md//"`
        [ "${artist}_Artist" == "${filename}" ] && continue
        artistname=`grep "artist:" ${discogs} | head -1 | \
          awk -F ':' ' { print $2 } ' | sed -e 's/^ *//' -e 's/ *$//'`
        [ "${artistname}" ] || {
          echo "${discogs} needs an artist: tag. Skipping."
          continue
        }
        title=`grep "title:" ${discogs} | awk -F ':' ' { print $2 } ' | \
          sed -e 's/^ *//' -e 's/ *$//' -e "s/^\"//" -e "s/\"$//"`
        [ "${title}" ] || {
          echo "${discogs} needs a title: tag. Skipping."
          continue
        }
        if [ ${numcols} -gt 4 ]
        then
          printf "| [${title}](${DUSER}/${discogs}) by [**${artistname}**](${DUSER}/${artist}/${artist}_Artist.md) |\n" >> ${VAULT}/${discogs_index}.md
          numcols=1
        else
          printf "| [${title}](${DUSER}/${discogs}) by [**${artistname}**](${DUSER}/${artist}/${artist}_Artist.md) " >> ${VAULT}/${discogs_index}.md
          numcols=$((numcols+1))
        fi
      done < <(cat /tmp/discogs$$)

      while [ ${numcols} -lt 5 ]
      do
        printf "| " >> ${VAULT}/${discogs_index}.md
        numcols=$((numcols+1))
      done
      printf "|\n" >> ${VAULT}/${discogs_index}.md
      rm -f /tmp/discogs$$
    else
      for artist in *
      do
        [ "${artist}" == "*" ] && continue
        [ -d "${artist}" ] || continue
        cd "${artist}"
        artistname=
        for discogs in *.md
        do
          [ "${discogs}" == "*.md" ] && continue
          [ "${discogs}" == "${artist}_Artist.md" ] && continue
          [ "${artistname}" ] || {
            artistname=`grep "artist:" ${discogs} | head -1 | \
              awk -F ':' ' { print $2 } ' | sed -e 's/^ *//' -e 's/ *$//'`
          }
          title=`grep "title:" ${discogs} | awk -F ':' ' { print $2 } ' | \
            sed -e 's/^ *//' -e 's/ *$//' -e "s/^\"//" -e "s/\"$//"`
          if [ ${numcols} -gt 4 ]
          then
            printf "| ${artistname}: [${title}](${DUSER}/${artist}/${discogs}) |\n" >> ${VAULT}/${discogs_index}.md
            numcols=1
          else
            printf "| ${artistname}: [${title}](${DUSER}/${artist}/${discogs}) " >> ${VAULT}/${discogs_index}.md
            numcols=$((numcols+1))
          fi
        done
        cd ..
      done

      while [ ${numcols} -lt 5 ]
      do
        printf "| " >> ${VAULT}/${discogs_index}.md
        numcols=$((numcols+1))
      done
      printf "|\n" >> ${VAULT}/${discogs_index}.md
    fi
  else
    if [ "${sortorder}" == "title" ]
    then
      ls -1 */*.md | sort -k 2 -t'/' > /tmp/discogs$$
    else
      ls -1 */*.md | sort -k 1 -t'/' > /tmp/discogs$$
    fi
    while read discogs
    do
      artist=`echo ${discogs} | awk -F '/' ' { print $1 } '`
      filename=`echo ${discogs} | awk -F '/' ' { print $2 } ' | sed -e "s/\.md//"`
      [ "${artist}_Artist" == "${filename}" ] && continue
      artistname=`grep "artist:" ${discogs} | head -1 | \
        awk -F ':' ' { print $2 } ' | sed -e 's/^ *//' -e 's/ *$//'`
      [ "${artistname}" ] || {
        echo "${discogs} needs an artist: tag. Skipping."
        continue
      }
      title=`grep "title:" ${discogs} | awk -F ':' ' { print $2 } ' | \
        sed -e 's/^ *//' -e 's/ *$//' -e "s/^\"//" -e "s/\"$//"`
      [ "${title}" ] || {
        echo "${discogs} needs a title: tag. Skipping."
        continue
      }
      if [ "${sortorder}" == "title" ]
      then
        first=${title:0:1}
      else
        first=${artistname:0:1}
      fi
      if [ "${heading}" == "0-9" ]
      then
        [ "${first}" -eq "${first}" ] 2> /dev/null || {
          [ "${first}" == "#" ] || {
            [ "${first}" == "?" ] || {
              [ "${first}" == "_" ] || {
                heading=${first}
                echo "" >> ${VAULT}/${discogs_index}.md
                echo "### ${heading}" >> ${VAULT}/${discogs_index}.md
                echo "" >> ${VAULT}/${discogs_index}.md
              }
            }
          }
        }
      else
        [ "${first}" == "${heading}" ] || {
          heading=${first}
          echo "" >> ${VAULT}/${discogs_index}.md
          echo "### ${heading}" >> ${VAULT}/${discogs_index}.md
          echo "" >> ${VAULT}/${discogs_index}.md
        }
      fi
      if [ "${sortorder}" == "title" ]
      then
        echo "- [${title}](${DUSER}/${discogs}) by [**${artistname}**](${DUSER}/${artist}/${artist}_Artist.md)" >> ${VAULT}/${discogs_index}.md
      else
        [ "${artistname}" == "${artist_heading}" ] || {
          artist_heading=${artistname}
          echo "" >> ${VAULT}/${discogs_index}.md
          echo "#### ${artist_heading}" >> ${VAULT}/${discogs_index}.md
          echo "" >> ${VAULT}/${discogs_index}.md
        }
        echo "- [${title}](${DUSER}/${discogs})" >> ${VAULT}/${discogs_index}.md
      fi
    done < <(cat /tmp/discogs$$)
    rm -f /tmp/discogs$$
  fi
fi
```
