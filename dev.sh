#!/bin/sh

modname="EvenMoreTextPlates"

if [ ! "${FACTORIOPATH}" ]; then
    echo "no factorio path found"
    exit 1
fi

if [ ! -d "${FACTORIOPATH}/mods" ]; then
    mkdir -v "${FACTORIOPATH}/mods"
fi

modversion=$(grep '"version"' "${modname}/info.json"| cut -d ":" -f2 | sed 's/[",]//g')

echo "${modversion}"

ln -sfv "${PWD}/${modname}" "${FACTORIOPATH}/mods/${modname}_${modversion}"
