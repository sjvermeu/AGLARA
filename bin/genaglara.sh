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
xsltproc --xinclude --param chunk.section.depth 0 --param use.id.as.filename 1 /usr/share/sgml/docbook/xsl-stylesheets/html/chunk.xsl aglara.xml >> ${LOGFILE} 2>&1;
collateindex.pl -o genindex.sgm HTML.index >> ${LOGFILE} 2>&1;
echo "done";

# Adding style information
echo -n "Adding style information... ";
for F in *.html;
do
  sed -i -e 's:</head:<link type="text/css" rel="stylesheet" href="style.css" title="default" media="all" /></head:g' ${F};
done
echo "done";

# Fix oasis-open.org URLs 
echo -n "Fixing oasis-open.org link... ";
grep -v "oasis-open.org/docbook" index.html > T;
mv T index.html;
echo "done";

# Building OneHugeXML
echo -n "Generating the single-XML source... ";
xsltproc --xinclude ~/Development/Centralized/AGLARA/src/copy.xsl aglara.xml > aglara.xml~;
xmllint --format aglara.xml~ > AGLARA.xml;
rm aglara.xml~;
echo "done";

# Building epub
echo -n "Generating ePub format... ";
xsltproc /usr/share/sgml/docbook/xsl-stylesheets/epub3/docbook.xsl AGLARA.xml >> ${LOGFILE} 2>&1;
zip -r aglara.zip META-INF OEBPS >> ${LOGFILE} 2>&1;
mv aglara.zip aglara.epub;
echo "done";

if [[ ${DOPDF} -eq 1 ]];
then
  # Building book
  echo -n "Enabling scalefit=1 to render images in PDF properly... ";
  sed -i -e 's:scalefit="0":scalefit="1":g' AGLARA.xml >> ${LOGFILE} 2>&1;
  echo -n "Building book PDF... ";
  xsltproc --output aglara.fo \
  		--stringparam paper.type A4 \
  		--stringparam shade.verbatim 1 \
  	/usr/share/sgml/docbook/xsl-stylesheets/fo/docbook.xsl AGLARA.xml >> ${LOGFILE} 2>&1;
  fop aglara.fo aglara.pdf >> ${LOGFILE} 2>&1;
  echo "done";
fi

cp ~/Development/build/tmp/aglara-build/*.html ~/Sites/swift.siphos.be/aglara/;
cp ~/Development/build/tmp/aglara-build/aglara/images/* ~/Sites/swift.siphos.be/aglara/images/;
cp ~/Development/build/tmp/aglara-build/aglara.pdf ~/Sites/swift.siphos.be/aglara/;
cp ~/Development/build/tmp/aglara-build/aglara.epub ~/Sites/swift.siphos.be/aglara/;

echo "All files are moved into ~/Development/build/tmp/aglara-build and synchronised with the site local backup";
