#!/bin/bash
#
# PreTeXt Website construction
#
# History
#
#  2025-11-12  Fresh start

#######################
# Script Infrastructure
#######################

# Source a custom file with relocation path names
# See paths.sh.template, copy to paths.sh and edit
# "dot" syntax is POSIX for "source"
# Alternatives: http://stackoverflow.com/questions/192292
DIR="$(dirname "$0")"
. ${DIR}/paths.sh

# Default is to use public repositories, for the best fidelity.  
# But sometimes we want to test a change using the current 
# version/branch of some repositoreies, principally pretext itself.  
# So we allow a single command line option "local", which if present 
# will adjust some components of the build.

if [ "${1}" = "local" ] ; then
	declare PTX=${LOCALPTX}
else
	declare PTX=${REPOS}/pretext
fi

###############
# Prerequisites
###############

# Certain tasks are required to build everything here.  This is
# a list of reminders, precise instructions will be elsewhere.

# 1.  Building the PDF of the PreTeXt Guide requires
#     the Libertine Serif OTF font.
#
# 2.  Output formats which depend on "offline" MathJax
#     to render LaTeX will first need to have the
#
#         pretext/script/mjsre/update-sre
#
#     script run in the pretext/script/mjsre directory of
#     the  pretext  repository used from ${REPOS} (${PTX}).
#     This in turn requires having  npm  for installation,
#     and  node  for use.  These formats include EPUB and braille.
#
# 3.  For the examples of the sample article as HTML output
#     with different themes, as a one-time setup step, run
#
#         npm install
#
#     in the pretext/script/cssbuilder directory of
#     the  pretext  repository used from ${REPOS} (${PTX}).
#     This in turn requires having  npm  for installation,
#     and  node  for use.

############################
# Miscellaneous Conveniences
############################

# pretext/pretext executable
declare PTXPTX=${PTX}/pretext/pretext

# PreTeXt formatting repository
declare LTL=${REPOS}/LaTeX3LaTeX


#####################
# Directory Locations
#####################

# Convenience locations for various directories

declare EXAMPLESOUT=${STAGED}/examples
declare DOCOUT=${STAGED}/doc

# variant destinations for sample book versions
declare SBNP=noparts
declare SBDE=decorative
declare SBST=structural

##################
# Source Materials
##################

# Convenience locations for various source material

declare SA=${PTX}/examples/sample-article
declare SB=${PTX}/examples/sample-book
declare G=${PTX}/doc/guide
declare ES=${PTX}/examples/epub
declare SLP=${PTX}/schema

###############
# Overall Setup
###############

# Create staging area (especially since it should be regularly trashed)
install -d ${STAGED}

# Scratch directory for formatting source material
install -d ${SCRATCH}

##############
# Repositories
##############

# Various repositories are assumed to live under ${REPOS} 
# locally.  We catalog them here, by their GitHub names

# 1.  PreTextBook/pretext
# 2.  davidfarmer/LaTeX3LaTeX

# PreTeXt, master branch of *public* repository
# Do not touch a local version, it might be in 
# any sort of state for testing purposes
if [ "${1}" != "local" ] ; then
	echo
	echo "BUILD: PreTeXt repository update :BUILD"
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	cd ${PTX}
	git checkout master
	git pull
fi

###############
# Documentation
###############

# The PreTeXt Guide, primary documentation
echo
echo "BUILD: creating The Guide :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d  ${DOCOUT}/guide/html
# PDF
# "fancy" vertsion via a LaTeX style file given in a publisher file
${PTXPTX} -v -o ${DOCOUT}/guide/pretext-guide.pdf -c doc -f pdf -p ${G}/publication-styled.xml ${G}/guide.xml
# HTML
${PTXPTX} -v -d ${DOCOUT}/guide/html -c doc -f html -p ${G}/publication.xml ${G}/guide.xml

echo
echo "BUILD: creating the schema literate program :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${DOCOUT}/schema-litprog/html
# PDF
${PTXPTX} -v -c doc -f pdf -d ${DOCOUT}/schema-litprog -p ${SLP}/publication.xml ${SLP}/pretext.xml
# HTML
${PTXPTX} -v -c doc -f html -d ${DOCOUT}/schema-litprog/html -p ${SLP}/publication.xml ${SLP}/pretext.xml

##########
# Examples
##########

# Sample article
echo
echo "BUILD: creating sample article :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${EXAMPLESOUT}/sample-article/html
# PDF
${PTXPTX} -v -c doc -f pdf -d ${EXAMPLESOUT}/sample-article -p ${SA}/publication.xml ${SA}/sample-article.xml
# HTML
${PTXPTX} -v -c doc -f html -d ${EXAMPLESOUT}/sample-article/html -p ${SA}/publication.xml ${SA}/sample-article.xml

echo
echo "BUILD: creating sample article with themes :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# Available themes for HTML builds
THEMES=("default-modern" "tacoma" "greeley" "boulder" "salem" "denver")

# Loop over themes, building sample article into different directories
for THEME in "${THEMES[@]}"; do
    echo "## Sample Article with $THEME theme"
    install -d ${EXAMPLESOUT}/sample-article/${THEME}
    ${PTXPTX} -v -c doc -f html -d ${EXAMPLESOUT}/sample-article/${THEME} -x debug.html.theme-name ${THEME} -p ${SA}/publication.xml ${SA}/sample-article.xml
done

# Sample article, HTML, with "View Source" annotations
echo
echo "BUILD: creating annotated sample article :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# place to work on formatting
install -d ${SCRATCH}/sa/annotated
cd ${SCRATCH}/sa/annotated
# copy creates a "sample-article" directory
cp -a ${SA} .
# Pretty-print will just massage top-level XML files
# from source, and then will drop them in this
# scratch location *overwriting* parts of copy above
${LTL}/ltol.py xml_pp ${SA} ./sample-article
# location in final tree
install -d ${EXAMPLESOUT}/sample-article/annotated
# reset, then drop down one more level
cd -
cd ${SCRATCH}/sa/annotated/sample-article
${PTXPTX} -v -c doc -f html -x debug.html.annotate yes -d ${EXAMPLESOUT}/sample-article/annotated -p publication.xml sample-article.xml
cd -

# Sample book
echo
echo "BUILD: creating sample book :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
# Tests/illustrates: no parts, decorative parts, structural parts

# no parts
install -d ${EXAMPLESOUT}/sample-book/${SBNP}/html
${PTXPTX} -v -f pdf  -c doc -p ${SB}/publication-noparts.xml -d ${EXAMPLESOUT}/sample-book/${SBNP}      ${SB}/sample-book.xml
${PTXPTX} -v -f html -c doc -p ${SB}/publication-noparts.xml -d ${EXAMPLESOUT}/sample-book/${SBNP}/html ${SB}/sample-book.xml
# decorative
install -d ${EXAMPLESOUT}/sample-book/${SBDE}/html
${PTXPTX} -v -f pdf  -c doc -p ${SB}/publication-decorative.xml -d ${EXAMPLESOUT}/sample-book/${SBDE}      ${SB}/sample-book-parts.xml
${PTXPTX} -v -f html -c doc -p ${SB}/publication-decorative.xml -d ${EXAMPLESOUT}/sample-book/${SBDE}/html ${SB}/sample-book-parts.xml
# structural
install -d ${EXAMPLESOUT}/sample-book/${SBST}/html
${PTXPTX} -v -f pdf  -c doc -p ${SB}/publication-structural.xml -d ${EXAMPLESOUT}/sample-book/${SBST}      ${SB}/sample-book-parts.xml
${PTXPTX} -v -f html -c doc -p ${SB}/publication-structural.xml -d ${EXAMPLESOUT}/sample-book/${SBST}/html ${SB}/sample-book-parts.xml

# Sample book, as HTML, with "View Source" annotations
echo
echo "BUILD: creating annotated sample book :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

# place to work on formatting
install -d ${SCRATCH}/sb/annotated
cd ${SCRATCH}/sb/annotated
# copy creates a "sample-book" directory
cp -a ${SB} .
# Pretty-print will just massage top-level XML files
# from source, and then will drop them in this
# scratch location *overwriting* parts of copy above
# We need to cover subdirectories with source material
${LTL}/ltol.py xml_pp ${SB}           ./sample-book
${LTL}/ltol.py xml_pp ${SB}/exercises ./sample-book/exercises
${LTL}/ltol.py xml_pp ${SB}/sage      ./sample-book/sage
# text files being included, just copy
cp ${SB}/code/symmetric-group-8.sage  ./sample-book/code
cp ${SB}/tikz/cyclic-roots-unity.tex  ./sample-book/tikz
# location in final tree
install -d ${EXAMPLESOUT}/sample-book/annotated
# reset, then drop down one more level
cd -
cd ${SCRATCH}/sb/annotated/sample-book
${PTXPTX} -v -c doc -f html -x debug.html.annotate yes -d ${EXAMPLESOUT}/sample-book/annotated -p publication-structural.xml sample-book-parts.xml
cd -

# EPUB sampler, PDF, HTML, EPUB (SVG)
echo
echo "BUILD: creating the EPUB Sampler :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d  ${EXAMPLESOUT}/epub-sampler/html
# PDF
${PTXPTX} -v -o ${EXAMPLESOUT}/epub-sampler/epub-sampler.pdf -c doc -f pdf -p ${ES}/publication.xml ${ES}/epub-sampler.xml
# HTML
${PTXPTX} -v -d ${EXAMPLESOUT}/epub-sampler/html -c doc -f html -p ${ES}/publication.xml ${ES}/epub-sampler.xml
# EPUB
${PTXPTX} -v -o ${EXAMPLESOUT}/epub-sampler/epub-sampler.epub -c doc -f epub-svg -p ${ES}/publication.xml ${ES}/epub-sampler.xml