#!/bin/bash

# Scrape covers for books in Gallery and add to website source.
# The COVERS location is peculiar to RAB's setup and would need to be generalized.

declare COVERS=${HOME}/mathbook/PreTeXt-website/site/images/covers

install -d ${COVERS}

wget -O ${COVERS}/clp-cover.svg        http://www.math.ubc.ca/~CLP/images/clp1-cover.svg
wget -O ${COVERS}/dmoi-cover.png       http://discrete.openmathbooks.org/assets/images/cover.png
wget -O ${COVERS}/ula-cover.jpg        https://davidaustinm.github.io/ula/cover.jpg
wget -O ${COVERS}/ac-cover.jpg         https://activecalculus.org/wp-content/uploads/2025/12/ACS2E-cover.png
wget -O ${COVERS}/mfg-cover.png        https://yoshiwarabooks.org/mfg/external/images/cover.png
wget -O ${COVERS}/orcaa-cover.png      https://spot.pcc.edu/math/orcca/ed2/html/images/ORCCAbrandlogo.png
wget -O ${COVERS}/aata-cover.png       https://judsonbooks.org/aata-files/aata-html/external/cover/cover_aata_2022.png
wget -O ${COVERS}/eight-cover.svg      https://mphitchman.com/images/surface8.svg
wget -O ${COVERS}/mt21c-cover.svg      http://musictheory.pugetsound.edu/mt21c/images/unit6/enh-mod-waltz-of-flowers-all.svg
wget -O ${COVERS}/bogart-cover.png     https://bogart.openmathbooks.org/assets/images/cover.png

exit 0


