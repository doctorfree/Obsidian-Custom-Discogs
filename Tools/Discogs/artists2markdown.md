# artists2markdown

```shell
#!/bin/bash
#
# artists2markdown - written by Ronald Joe Record <ronaldrecord@gmail.com>
#
# Generate a markdown format profile for every artist in your Discogs collection
#
# Set your Discogs username and API token in ~/.config/mpprc as:
# DISCOGS_USER and DISCOGS_TOKEN
# Alternately, they can be provided on the command line or set here.
#
#-----------SET DISCOGS USERNAME-----------------------
DISCOGS_USER=
#
# Discogs API token
# See https://www.discogs.com/settings/developers
# API requests are throttled to 60 per minute for authenticated
# requests and 25 per minute for unauthenticated requests.
#
#-----------SET DISCOGS API TOKEN-----------------------
DISCOGS_TOKEN=
#
# A Discogs username is required.
#
# A Discogs API token is not required. However, API requests for
# unauthenticated users are throttled to 25 per minute and images
# are not available to unauthenticated users.

# Dot in the user configuration file if it exists
[ -f ${HOME}/.config/mpprc ] && . ${HOME}/.config/mpprc

usage() {
  printf "\nUsage: artists2markdown [-F] [-R] [-U] [-u username] [-t token] [-h]"
  printf "\nWhere:"
  printf "\n\t-F indicates force overwrite of previously generated files."
  printf "\n\t-R indicates remove previously generated files."
  printf "\n\t-U indicates run an update, only newly added Discogs artists will be processed."
  printf "\n\t-u 'username' specifies your Discogs username."
  printf "\n\t-t 'token' specifies your Discogs API token."
  printf "\n\t-h displays this usage message and exits.\n"
  printf "\nA Discogs username is required."
  printf "\nA Discogs username and token can be added to ~/.config/mpprc as the variables"
  printf "\n\tDISCOGS_USER and DISCOGS_TOKEN"
  printf "\nor specified on the command line with '-u username' and '-t token'\n"
  printf "\nUpdates can be accomplished either with the '-U' option or '-F' option."
  printf "\nAn update scenario is when 'artists2markdown' has previously been run"
  printf "\nbut new artists have been added to the Discogs collection since then."
  printf "\nUpdate with '-U' is faster as it does not generate markdown for existing artists."
  printf "\nIf both '-F' and '-U' are provided, only '-F' is used.\n\n"
  exit 1
}

mkartists=
numcols=1
overwrite=
remove=
update=
# Command line arguments override config file settings
while getopts "FRUu:t:h" flag; do
    case $flag in
        F)
            overwrite=1
            ;;
        R)
            remove=1
            ;;
        U)
            update=1
            ;;
        u)
            DISCOGS_USER="$OPTARG"
            ;;
        t)
            DISCOGS_TOKEN="$OPTARG"
            ;;
        h)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ "${overwrite}" ] && update=

[ "${DISCOGS_USER}" ] || {
  echo "Discogs username required."
  echo "Set DISCOGS_USER in ${HOME}/.config/mpprc or on the command line."
  echo "Exiting."
  exit 1
}

VAULT="${DISCOGS_USER^}"
HERE=`pwd`
PARENT=`dirname "${HERE}"`
GRANDP=`dirname "${PARENT}"`
TOP="${GRANDP}/${VAULT}"
TOOLS="${GRANDP}/Tools/Discogs"
ASSETS="${GRANDP}/assets"
ARTISTS="${ASSETS}/artists"
OUT="${GRANDP}/Discogs_${VAULT}_Artists.md"

# URL="https://api.discogs.com/releases"
URL="https://api.discogs.com"
ART="${URL}/artists"

AGE="github.com/doctorfree/MusicPlayerPlus"
UAG="--user-agent \"MusicPlayerPlus/3.0\""

[ -d "${TOP}" ] || mkdir -p "${TOP}"

cd "${TOP}"
[ -d "${ASSETS}" ] || mkdir "${ASSETS}"
[ -d "${ARTISTS}" ] || mkdir "${ARTISTS}"
[ -d "${TOOLS}/json" ] || mkdir "${TOOLS}/json"
[ -d "${TOOLS}/json/artists" ] || mkdir "${TOOLS}/json/artists"

[ "${remove}" ] || [ "${overwrite}" ] && rm -f ${OUT}

if [ "${update}" ]
then
  echo "Generating markdown for newly added artists in Discogs user ${DISCOGS_USER} collection"
else
  echo "Generating markdown for all artists in Discogs user ${DISCOGS_USER} collection"
fi
if [ "${DISCOGS_TOKEN}" ]
then
  echo "API token in use, requests will be faster and images downloaded"
else
  echo "No API token in use, requests will be slower and no images downloaded"
  echo "Set an API token in ~/.config/mpprc with DISCOGS_TOKEN=token"
fi
echo "Please be patient. A large Discogs collection may take a while."

[ -f ${OUT} ] || {
  mkartists=1
  echo "# Discogs Artists" > ${OUT}
  echo "" >> ${OUT}
  echo "## List of Discogs Artists in Vault" >> ${OUT}
  echo "" >> ${OUT}
  echo "| **Artist Name** | **Artist Name** | **Artist Name** | **Artist Name** | **Artist Name** |" >> ${OUT}
  echo "|--|--|--|--|--|" >> ${OUT}
}

for artist in *
do
  [ "${artist}" == "*" ] && continue
  [ -d "${artist}" ] || continue
  artistpage="${artist}_Artist"
  [ -f ${artist}/${artist}_Artist.md ] && {
    grep "title:" ${artist}/${artist}_Artist.md > /dev/null && artistpage="${artist}_Artist_Page"
  }
  [ "${remove}" ] && {
    rm -f ${artist}/${artistpage}.md
    continue
  }
  if [ "${overwrite}" ]
  then
    [ -f ${artist}/${artistpage}.md ] && {
      grep "title:" ${artist}/${artistpage}.md > /dev/null && continue
    }
    rm -f ${artist}/${artistpage}.md
  else
    [ -f ${artist}/${artistpage}.md ] && continue
  fi
  generate=1
  [ "${update}" ] && {
    [ -f "${artist}/${artistpage}.md" ] && generate=
  }
  [ "${generate}" ] && {
    cd "${artist}"
    echo "Creating artist markdown for ${artist}"
    echo "" > /tmp/sa$$
    echo "## See also" >> /tmp/sa$$
    echo "" >> /tmp/sa$$
    artistname=
    release_id=
    for disc in *.md
    do
      [ "${disc}" == "*.md" ] && continue
      [ "${disc}" == "${artistpage}.md" ] && continue
      [ "${artistname}" ] || {
        artistname=`grep "artist:" ${disc} | head -1 | \
          awk -F ':' ' { print $2 } ' | sed -e 's/^ *//' -e 's/ *$//'`
      }
      [ "${release_id}" ] || {
        release_id=`grep "releaseid:" ${disc} | head -1 | \
          awk -F ':' ' { print $2 } ' | sed -e 's/^ *//' -e 's/ *$//'`
        [ -s "${TOOLS}/json/${release_id}/${release_id}.json" ] || release_id=
      }
      title=`grep "title:" ${disc} | awk -F ':' ' { print $2 } ' | \
        sed -e 's/^ *//' -e 's/ *$//' -e "s/^\"//" -e "s/\"$//"`
      echo "- [${title}](${disc})" >> /tmp/sa$$
    done
    echo "# ${artistname}" > /tmp/au$$
    echo "" >> /tmp/au$$
    [ -s "${TOOLS}/json/${release_id}/${release_id}.json" ] && {
      artist_id=`cat "${TOOLS}/json/${release_id}/${release_id}.json" | \
        jq -r '.artists[0].id'`
      # Retrieve artist profile
      if [ "${DISCOGS_TOKEN}" ]
      then
        artist_profile=$(curl --stderr /dev/null \
          -A "${AGE}" "${ART}/${artist_id}" \
          -H "Accept: application/vnd.discogs.v2.plaintext+json" \
          -H "Authorization: Discogs token=${DISCOGS_TOKEN}" | \
          jq -r '.')
        sleep 1
      else
        artist_profile=$(curl --stderr /dev/null \
          -A "${AGE}" "${ART}/${artist_id}" \
          -H "Accept: application/vnd.discogs.v2.plaintext+json" \
          jq -r '.')
        sleep 2.4
      fi
      echo "${artist_profile}" > "${TOOLS}/json/artists/${artist_id}.json"
      [ -f "${ARTISTS}/${artist}.png" ] || {
        avatar_url=`echo ${artist_profile} | jq -r '.images[0].uri'`
        wget -q -O "${artist}.jpg" "${avatar_url}"
        [ -s "${artist}.jpg" ] && {
          convert "${artist}.jpg" "${artist}.png" 2> /dev/null
        }
        rm -f ${artist}.jpg
      }

      [ -f ${artist}.png ] && {
        mv "${artist}.png" "${ARTISTS}"
      }

      [ -f "../../assets/artists/${artist}.png" ] && {
        echo "![](../../assets/artists/${artist}.png)" >> /tmp/au$$
        echo "" >> /tmp/au$$
      }

      echo "## Artist Profile" >> /tmp/au$$
      echo "" >> /tmp/au$$
      description=`echo ${artist_profile} | jq -r '.profile_plaintext'`
      echo "${description}" >> /tmp/au$$
      echo "" >> /tmp/au$$

      echo "## Artist Links" >> /tmp/au$$
      echo "" >> /tmp/au$$
      while read url
      do
        echo "- [${url}](${url})" >> /tmp/au$$
      done < <(echo ${artist_profile} | jq -r '.urls[]?')
      echo "" >> /tmp/au$$
    }
    cat /tmp/au$$ /tmp/sa$$ > ${artistpage}.md
    rm -f /tmp/au$$ /tmp/sa$$
    cd ..
  }
done

cd "${TOP}"
for artist in *
do
  [ "${artist}" == "*" ] && continue
  [ -d "${artist}" ] || continue
  [ "${mkartists}" ] && {
    artistpage="${artist}_Artist"
    [ -f ${artist}/${artist}_Artist.md ] && {
      grep "title:" ${artist}/${artist}_Artist.md > /dev/null && artistpage="${artist}_Artist_Page"
    }
    [ -f "${artist}/${artistpage}.md" ] && {
      for disc in ${artist}/*.md
      do
        [ "${disc}" == "${artist}/*.md" ] && continue
        [ "${disc}" == "${artist}/${artistpage}.md" ] && continue
        grep "artist:" ${disc} > /dev/null && {
          artistname=`grep "artist:" ${disc} | head -1 | \
            awk -F ':' ' { print $2 } ' | sed -e 's/^ *//' -e 's/ *$//'`
          break
        }
      done
      [ "${artistname}" ] && {
        if [ ${numcols} -gt 4 ]
        then
          printf "| [${artistname}](Discogs/${artist}/${artistpage}.md) |\n" >> ${OUT}
          numcols=1
        else
          printf "| [${artistname}](Discogs/${artist}/${artistpage}.md) " >> ${OUT}
          numcols=$((numcols+1))
        fi
      }
    }
  }
done

[ "${mkartists}" ] && {
  while [ ${numcols} -lt 4 ]
  do
    printf "| " >> ${OUT}
    numcols=$((numcols+1))
  done
  printf "|\n" >> ${OUT}
}
```
