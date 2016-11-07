#/bin/tcsh

source /usr/share/modules/init/tcsh

module purge

module load hdf5/1.8.16  gsl/2.1 isl/0.16 cloog/0.18.4 mpc/1.0.3 gmp/6.1.0 mpfr/3.1.4 gcc/5.3.0 

#module load openmpi/1.8.6

limit stacksize unlimited

#######################################
# SETTING ENVIRONMENT VARIABLES       #
#######################################

# INTEL Studio 2016.3
setenv INTEL_LICENSE_FILE "28518@irsdev01"

setenv INTEL_PATH /mnt/appsource/intel_studio/intel_studio-2016.3
source ${INTEL_PATH}/bin/compilervars.csh intel64

setenv PATH ${INTEL_PATH}/bin/:${PATH}

setenv FC ifort
setenv CC icc
setenv CXX icpc
setenv CFLAGS '-O3 -xHost -ip'
setenv CXXFLAGS '-O3 -xHost -ip'
setenv FCFLAGS '-O3 -xHost -ip'

setenv LD_LIBRARY_PATH /mnt/appsource/intel_studio/intel_studio-2016.3/lib:${LD_LIBRARY_PATH}
#setenv MANPATH ${MANPATH}:/mnt/appsource/intel_studio/intel_studio-2016.3/man


# ZLIB environment
setenv LD_LIBRARY_PATH /mnt/scratch2/CAS/apps/zlib/zlib-1.2.8/lib:${LD_LIBRARY_PATH}
setenv PATH /mnt/scratch2/CAS/apps/zlib/zlib-1.2.8/bin:${PATH}
#setenv MANPATH ${MANPATH}:/mnt/scratch2/CAS/apps/zlib/zlib-1.2.8/man

# NETCDF environment
#setenv NETCDF /mnt/appsource/netcdf/netcdf-4.4.0
setenv NETCDF /mnt/scratch2/CAS/apps/netcdf/netcdf-4.4.0

setenv LD_LIBRARY_PATH /mnt/scratch2/CAS/apps/netcdf/netcdf-4.4.0/lib:${LD_LIBRARY_PATH}
setenv PATH /mnt/scratch2/CAS/apps/netcdf/netcdf-4.4.0/bin:${PATH}
#setenv MANPATH ${MANPATH}:/mnt/scratch2/CAS/apps/netcdf/netcdf-4.4.0/man

# SZIP environment
setenv LD_LIBRARY_PATH /mnt/scratch2/CAS/apps/szip/szip-2.1/lib:${LD_LIBRARY_PATH}
setenv PATH /mnt/scratch2/CAS/apps/szip/szip-2.1/bin:${PATH}

# HDF5 environment
#setenv HDF5_DIR /mnt/scratch2/CAS/apps/hdf5/hdf5-1.8.17
#setenv HDF5_ROOT /mnt/scratch2/CAS/apps/hdf5/hdf5-1.8.17
setenv LD_LIBRARY_PATH /mnt/appsource/hdf5/hdf5-1.8.17/lib:${LD_LIBRARY_PATH}
setenv PATH /mnt/appsource/hdf5/hdf5-1.8.17/bin:${PATH}
#setenv MANPATH ${MANPATH}:/mnt/appsource/hdf5/hdf5-1.8.17/man

# OPENMPI - INTEL COMPILATION environment
setenv LD_LIBRARY_PATH /mnt/scratch2/CAS/apps/openmpi/openmpi-1.10.3/lib:${LD_LIBRARY_PATH}
setenv PATH /mnt/scratch2/CAS/apps/openmpi/openmpi-1.10.3/bin:${PATH}


# NCL
setenv NCARG_ROOT /mnt/appsource/ncl/ncl-6.2.0
setenv PATH NCARG_ROOT/bin:$PATH

# PVM3
setenv PVM_ROOT /home/monkk/pvm3
setenv PVM_ARCH LINUX64

# CMAQ
setenv M3HOME /home/monkk/CMAQv5.1

# IOAP
setenv BIN Linux2_x86_64ifort


module unload hd5f/1.8.16


