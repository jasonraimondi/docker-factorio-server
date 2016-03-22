#!/bin/bash
. /opt/config

# Refresh save code from https://github.com/Bisa/factorio-init/blob/master/factorio
refresh_save(){
  savedir="${FACTORIO_PATH}/saves"

  # Check to see if save dir actually exists
  if ! [ -e "${savedir}" ]; then
    echo "Error! Save directory missing: ${savedir}"
    exit 1
  fi

  # Find the last modified save file
  lastsave=$(ls -t ${savedir}/*.zip 2> /dev/null | head -1)

  # Sanity check, did we even find any save files?
  if [ -z "${lastsave}" ]; then
    echo "Unable to find any saves in ${savedir}"
    ${BINARY} --create "${SAVE_NAME}" && echo "Save ${SAVE_NAME} created"
    return 0
  fi

  echo "last modified save: ${lastsave}"

  # If the last modified save is our own, keep using it
  if [ "${lastsave}" == "${savedir}/${SAVE_NAME}.zip" ]; then
    echo "using existing ${SAVE_NAME}.zip"
    return 0
  fi

  # Else we copy the latest save to our own save file
  echo "using refreshed save"
  if ! as_user "cp ${lastsave} ${savedir}/${SAVE_NAME}.zip"; then
    echo "Error! Failed to refresh saves"
    exit 1
  fi
}

refresh_save
${BINARY} --start-server ${SAVE_NAME} \
          --autosave-interval ${AUTOSAVE_INTERVAL} \
          --autosave-slots ${AUTOSAVE_SLOTS} \
          --latency-ms ${LATENCY} \
          ${EXTRA_BINARGS}
