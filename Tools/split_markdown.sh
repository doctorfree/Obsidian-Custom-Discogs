#!/bin/bash
#
# split_markdown - split a markdown file into smaller parts
#
# usage: split_markdown filename.md number_of_parts
#
# assumes the first two lines of the input file are table heading and divider

inputFile=$1
[ -f "${inputFile}" ] || {
  echo "Missing input file ${inputFile}. Exiting."
  exit 1
}
numFiles=$2
[ "${numFiles}" ] && [ ${numFiles} -gt 1 ] || {
  echo "numFiles = ${numFiles} missing or not greater than 1. Exiting."
  exit 1
}
numLines=`cat ${inputFile} | wc -l`
baseFile=`echo ${inputFile} | sed -e "s/\.md//"`

split -da 2 \
      -l $((numLines / numFiles)) \
      ${inputFile} ${baseFile}_ --additional-suffix=".md"

rm -f ${inputFile}
firstFile=`echo *_00.md`
table_heading=`head -1 ${firstFile}`
table_divider=`head -2 ${firstFile} | tail -1`

for inputFile in *.md
do
  [ "${inputFile}" == "*.md" ] && continue
  [ "${inputFile}" == "${firstFile}" ] && continue
  echo -e "${table_heading}\n${table_divider}\n$(cat ${inputFile})" > ${inputFile}
done
