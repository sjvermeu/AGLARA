#!/bin/sh

typeset LOGFILE=~/Development/build/tmp/aglara-build/build.log;
typeset -i DONETWORK;
typeset -i DOPDF;

if [[ "${1}" = "-n" ]] || [[ "${2}" = "-n" ]];
then
  DONETWORK=1;
else
  DONETWORK=0;
fi

if [[ "${1}" = "-N" ]] || [[ "${2}" = "-N" ]];
then
  DOPDF=0;
else
  DOPDF=1;
fi
  

# Create temporary directory
echo -n "Creating temporary directory... ";
rm -rf ~/Development/build/tmp/aglara-build
mkdir ~/Development/build/tmp/aglara-build
cd ~/Development/build/tmp/aglara-build
echo "done";

# Copy over files
echo -n "Copying files... ";
cp -r ~/Development/Centralized/AGLARA/src/aglara* .
echo "done";

echo -n "Generating index file... ";
collateindex.pl -N -o genindex.sgm > ${LOGFILE} 2>&1;
#jade -t sgml -d /usr/share/sgml/docbook/dsssl-stylesheets-1.79/html/docbook.dsl -V html-index /usr/share/sgml/xml.dcl aglara.xml >> ${LOGFILE} 2>&1;
xsltproc --xinclude --param chunk.section.depth 0 /usr/share/sgml/docbook/xsl-stylesheets/html/chunkfast.xsl aglara.xml >> ${LOGFILE} 2>&1;
collateindex.pl -o genindex.sgm HTML.index >> ${LOGFILE} 2>&1;
echo "done";

# Adding style information
echo -n "Adding style information... ";
cp ~/Development/Centralized/AGLARA/style.css .;
for F in *.html;
do
  sed -i -e 's:</head:<link type="text/css" rel="stylesheet" href="style.css" title="default" media="all" /></head:g' ${F};
done
echo "done";

# Updating encoding
#if [[ "${DONETWORK}" = "1" ]];
#then
#  echo -n "Setting encoding straight... ";
#  for F in *.html;
#  do
#    iconv -f iso-8859-1 -t utf-8 ${F} > ${F}.2;
#    mv ${F}.2 ${F};
#  done
#fi

# Fix oasis-open.org URLs 
echo -n "Fixing oasis-open.org link... ";
grep -v "oasis-open.org/docbook" index.html > T;
mv T index.html;
echo "done";

# Generate tex file
echo -n "Building tex file... ";
docbook2latex -T simple -d aglara.xml >> ${LOGFILE} 2>&1;
echo "done";

# Create b5 size file
echo -n "Fixing tex file to create B5 book... ";
typeset TEMPDIR=$(tail -n 1 ${LOGFILE} | awk '{print $1}');
cd ${TEMPDIR};
. ./env_tex;
sed -e 's:documentclass:documentclass[b5paper]:g' aglara.tex > t.tex;
mv t.tex aglara.tex;
echo "done";

# Fix TOC depth
echo -n "Updating TOC depth to 2... ";
sed -e 's:\\setcounter{tocdepth}{5}:\\setcounter{tocdepth}{2}:g' aglara.tex > t.tex;
mv t.tex aglara.tex;
echo "done";

# Fix indentation
echo -n "Fixing indentation or paragraphs... ";
sed -e 's:^\\title:\\setlength{\\parindent}{0cm}\\setlength{\\parskip}{0.25\\baselineskip}\\title:' aglara.tex > t.tex;
mv t.tex aglara.tex;
echo "done";

# Fix image path
echo -n "Fixing image paths... ";
sed -e 's:images/:aglara/images/:g' aglara.tex > t.tex;
mv t.tex aglara.tex;
echo "done";

# Copy images
echo -n "Copying images... ";
cp -r ~/Development/Centralized/AGLARA/src/aglara/images .;
echo "done";

mv ${TEMPDIR}/* ~/Development/build/tmp/aglara-build;
rmdir ${TEMPDIR};

cd ~/Development/build/tmp/aglara-build;

# Building OneHugeXML
echo -n "Generating the single-XML source... ";
xsltproc --xinclude ~/Development/Centralized/AGLARA/src/copy.xsl aglara.xml > aglara.xml~;
xmllint --format aglara.xml~ > AGLARA.xml;
rm aglara.xml~;
echo "done";

if [[ ${DOPDF} -eq 1 ]];
then
  # Building book
  echo -n "Building book PDF... ";
  xsltproc --output aglara.fo --stringparam paper.type A4 /usr/share/sgml/docbook/xsl-stylesheets/fo/docbook.xsl AGLARA.xml >> ${LOGFILE} 2>&1;
  fop aglara.fo aglara.pdf >> ${LOGFILE} 2>&1;
  echo "done";
fi


echo "All files are moved into ~/Development/build/tmp/aglara-build and synchronised with the site local backup";
