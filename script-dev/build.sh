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

############################
# Miscellaneous Conveniences
############################

# pretext/pretext executable

declare PTXPTX=${PTX}/pretext/pretext

#####################
# Directory Locations
#####################

# Convenience locations for various directories

declare EXAMPLESOUT=${STAGED}/examples

##################
# Source Materials
##################

# Convenience locations for various source material

declare SA=${PTX}/examples/sample-article

###############
# Overall Setup
###############

# Create staging area (especially since it should be regularly trashed)
install -d ${STAGED}

##############
# Repositories
##############

# Various repositories are assumed to live under ${REPOS} 
# locally.  We catalog them here, by their GitHub names

# 1.  PreTextBook/pretext

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

# Sample article
echo
echo "BUILD: creating sample article :BUILD"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
install -d ${EXAMPLESOUT}/sample-article/html
# PDF
${PTXPTX} -v -c doc -f pdf -d ${EXAMPLESOUT}/sample-article -p ${SA}/publication.xml ${SA}/sample-article.xml
# HTML
${PTXPTX} -v -c doc -f html -d ${EXAMPLESOUT}/sample-article/html -p ${SA}/publication.xml ${SA}/sample-article.xml
