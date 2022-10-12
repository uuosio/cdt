#! /bin/bash

NAME=$1
PROJECT=cdt
PREFIX=release

CDT_PREFIX=${PREFIX}
SPREFIX=
BUILD_DIR=$(pwd)

rm -r ${PREFIX}

mkdir -p ${CDT_PREFIX}/bin
mkdir -p ${CDT_PREFIX}/include
mkdir -p ${CDT_PREFIX}/lib/cmake/${PROJECT}
mkdir -p ${CDT_PREFIX}/scripts
mkdir -p ${CDT_PREFIX}/licenses

#echo "${PREFIX} ** ${SUBPREFIX} ** ${CDT_PREFIX}"

# install binaries
cp -R ${BUILD_DIR}/bin/* ${CDT_PREFIX}/bin || exit 1
cp -R ${BUILD_DIR}/licenses/* ${CDT_PREFIX}/licenses || exit 1

# install cmake modules
sed "s/_PREFIX_/\/${SPREFIX}/g" ${BUILD_DIR}/modules/CDTMacrosPackage.cmake &> ${CDT_PREFIX}/lib/cmake/${PROJECT}/CDTMacros.cmake || exit 1
sed "s/_PREFIX_\/bin\//${SPREFIX}/g" ${BUILD_DIR}/modules/CDTWasmToolchainPackage.cmake &> ${CDT_PREFIX}/lib/cmake/${PROJECT}/CDTWasmToolchain.cmake || exit 1
sed "s/_PREFIX_/\/${SPREFIX}/g" ${BUILD_DIR}/modules/${PROJECT}-config.cmake.package &> ${CDT_PREFIX}/lib/cmake/${PROJECT}/${PROJECT}-config.cmake || exit 1

# install scripts
cp -R ${BUILD_DIR}/scripts/* ${CDT_PREFIX}/scripts  || exit 1

# install misc.
cp ${BUILD_DIR}/cdt.imports ${CDT_PREFIX} || exit 1

# install wasm includes
cp -R ${BUILD_DIR}/include/* ${CDT_PREFIX}/include || exit 1

# install wasm libs
cp ${BUILD_DIR}/lib/*.a ${CDT_PREFIX}/lib || exit 1

echo "Generating Tarball $NAME.tar.gz..."
tar -cvzf $NAME.tar.gz ./${PREFIX}/* || exit 1
