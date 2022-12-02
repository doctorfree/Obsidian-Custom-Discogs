# get-discogs-profile

```shell
#!/bin/bash
#
# get-discogs-profile
#
# Get the Discogs user profile and create a markdown profile

# Get to the Discogs username and a Discogs API token
[ -f "${HOME}/.config/mpprc" ] && . "${HOME}/.config/mpprc"

usage() {
  printf "\nUsage: ./get-discogs-profile [-N] [-t token] [-u user] [-h]"
  printf "\nWhere:"
  printf "\n\t-N indicates do not use Discogs API token"
  printf "\n\t-t 'token' specifies the Discogs API token"
  printf "\n\t-u 'user' specifies the Discogs username"
  printf "\n\t-h displays this usage message and exits\n\n"
  exit 1
}

usetoken=1
while getopts "Nt:u:h" flag; do
    case $flag in
        N)
            usetoken=
            ;;
        t)
            DISCOGS_TOKEN="${OPTARG}"
            ;;
        u)
            DISCOGS_USER="${OPTARG}"
            ;;
        h)
            usage
            ;;
    esac
done
shift $(( OPTIND - 1 ))

[ "${DISCOGS_USER}" ] || {
  echo "Discogs username required"
  echo "Set DISCOGS_USER in ${HOME}/.config/mpprc"
  echo "Exiting."
  exit 1
}

[ "${DISCOGS_TOKEN}" ] || usetoken=
[ "${usetoken}" ] || DISCOGS_TOKEN=

[ "${DISCOGS_TOKEN}" ] && [ "${usetoken}" ] || {
  echo "Discogs API token required"
  echo "Set DISCOGS_TOKEN in ${HOME}/.config/mpprc"
  echo "Exiting."
  exit 1
}

DUSER="${DISCOGS_USER^}"

URL="https://api.discogs.com"
USR="${URL}/users/${DISCOGS_USER}"
VAL="${URL}/users/${DISCOGS_USER}/collection/value"
AGE="github.com/doctorfree/MusicPlayerPlus"

# Retrieve user profile
if [ "${usetoken}" ]
then
  profile=$(curl --stderr /dev/null \
    -A "${AGE}" "${USR}" \
    -H "Authorization: Discogs token=${DISCOGS_TOKEN}" | \
    jq -r '.')
else
  profile=$(curl --stderr /dev/null \
    -A "${AGE}" "${USR}" \
    jq -r '.')
fi

avatar_url=`echo ${profile} | jq '.avatar_url' | sed -e "s/\"//g"`
wget -q -O "${DISCOGS_USER}_discogs_avatar.jpg" "${avatar_url}"
[ -f "${DISCOGS_USER}_discogs_avatar.jpg" ] && {
  convert "${DISCOGS_USER}_discogs_avatar.jpg" \
          "${DISCOGS_USER}_discogs_avatar.png" 2> /dev/null
}
rm -f "${DISCOGS_USER}_discogs_avatar.jpg"

# Retrieve collection value fields
values=$(curl --stderr /dev/null \
  -A "${AGE}" "${VAL}" \
  -H "Authorization: Discogs token=${DISCOGS_TOKEN}" | \
  jq -r '.')

minimum=`echo ${values} | jq '.minimum' | sed -e "s/\"//g"`
median=`echo ${values} | jq '.median' | sed -e "s/\"//g"`
maximum=`echo ${values} | jq '.maximum' | sed -e "s/\"//g"`
[ "${minimum}" == "null" ] && minimum=
[ "${median}" == "null" ] && median=
[ "${maximum}" == "null" ] && maximum=

filename="${DUSER}_Discogs_User_Profile.md"
echo "# ${DUSER} Discogs User Profile" > "${filename}"
echo "" >> "${filename}"
[ -f ${DISCOGS_USER}_discogs_avatar.png ] && {
  echo "![](assets/${DISCOGS_USER}_discogs_avatar.png)" >> "${filename}"
  echo "" >> "${filename}"
}
echo "" >> "${filename}"

showvalue=
[ "${minimum}" ] || [ "${median}" ] || [ "${maximum}" ] && showvalue=1

[ "${showvalue}" ] && {
  echo "## Discogs user ${DISCOGS_USER} collection value" >> "${filename}"
  echo "" >> "${filename}"
  echo "| **Minimum** | **Median** | **Maximum** |" >> "${filename}"
  echo "|-------------|------------|-------------|" >> "${filename}"
  echo "| ${minimum} | ${median} | ${maximum} |" >> "${filename}"
  echo "" >> "${filename}"

}
echo "## Discogs user ${DISCOGS_USER} profile" >> "${filename}"
echo "" >> "${filename}"

id=`echo ${profile} | jq '.id' | sed -e "s/\"//g"`
uri=`echo ${profile} | jq '.uri' | sed -e "s/\"//g"`
name=`echo ${profile} | jq '.name' | sed -e "s/\"//g"`
home_page=`echo ${profile} | jq '.home_page' | sed -e "s/\"//g"`
location=`echo ${profile} | jq '.location' | sed -e "s/\"//g"`
desc=`echo ${profile} | jq '.profile' | sed -e "s/\"//g"`
num=`echo ${profile} | jq '.num_collection' | sed -e "s/\"//g"`
email=`echo ${profile} | jq '.email' | sed -e "s/\"//g"`
rank=`echo ${profile} | jq '.rank' | sed -e "s/\"//g"`
releases_contributed=`echo ${profile} | jq '.releases_contributed' | sed -e "s/\"//g"`
buyer_rating=`echo ${profile} | jq '.buyer_rating' | sed -e "s/\"//g"`
buyer_rating_stars=`echo ${profile} | jq '.buyer_rating_stars' | sed -e "s/\"//g"`
seller_rating=`echo ${profile} | jq '.seller_rating' | sed -e "s/\"//g"`
seller_rating_stars=`echo ${profile} | jq '.seller_rating_stars' | sed -e "s/\"//g"`

[ "${name}" == "null" ] && name=
[ "${home_page}" == "null" ] && home_page=
[ "${location}" == "null" ] && location=
[ "${email}" == "null" ] && email=

echo "Discogs user **${DISCOGS_USER}** has the following profile:" >> "${filename}"
echo "" >> "${filename}"
echo "${desc}" >> "${filename}"
echo "" >> "${filename}"
echo "- **Discogs ID:** ${id}" >> "${filename}"
echo "- **Discogs URL:** ${uri}" >> "${filename}"
echo "- **Name:** ${name}" >> "${filename}"
echo "- **Home Page:** ${home_page}" >> "${filename}"
echo "- **Location:** ${location}" >> "${filename}"
echo "- **Email:** ${email}" >> "${filename}"
echo "- **Number of items in Discogs collection:** ${num}" >> "${filename}"
echo "- **Discogs Rank:** ${rank}" >> "${filename}"
echo "- **Discogs Releases Contributed:** ${releases_contributed}" >> "${filename}"
echo "- **Discogs Buyer Rating:** ${buyer_rating}" >> "${filename}"
echo "- **Discogs Buyer Rating Stars:** ${buyer_rating_stars}" >> "${filename}"
echo "- **Discogs Seller Rating:** ${seller_rating}" >> "${filename}"
echo "- **Discogs Seller Rating Stars:** ${seller_rating_stars}" >> "${filename}"
echo "" >> "${filename}"

mv "${filename}" ../..
[ -f ${DISCOGS_USER}_discogs_avatar.png ] && {
  mv ${DISCOGS_USER}_discogs_avatar.png \
     ../../assets/${DISCOGS_USER}_discogs_avatar.png
}
```
