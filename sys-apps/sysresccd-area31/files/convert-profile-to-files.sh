#!/bin/bash
PROFILE_DIR="/etc/portage"

if [ ! -e ${PROFILE_DIR} ]; then
  mkdir ${PROFILE_DIR};
fi;

for PACK_DIR in package.accept_keywords package.keywords package.use package.unmask package.mask; do
  CUR_DIR="${PROFILE_DIR}/${PACK_DIR}"
  if [ ! -e ${CUR_DIR} ]; then
    mkdir ${CUR_DIR}
  fi

  if [ -e ${CUR_DIR} -a ! -d ${CUR_DIR} ]; then
    mv ${CUR_DIR} ${CUR_DIR}.moving
    mkdir ${CUR_DIR}
    mv ${CUR_DIR}.moving ${CUR_DIR}/monolithic
  fi
done

echo "Completed!"

