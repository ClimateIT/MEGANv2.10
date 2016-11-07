SHELL= /bin/sh
FC= ifort
#FFLAGS = -O2 -Mdalign -Mnoframe -byteswapio -Mlfs -Bstatic_pgi
FFLAGS= -O2 -align dcommons -fomit-frame-pointer -convert big_endian -Bstatic -qopenmp

LNKFLGS= -Bstatic -qopenmp

PROGRAM= ioapi2uam
LIBS= 	-L/home/monkk/ioapi-3.1/Linux2_x86_64ifort -lioapi \
	-L/mnt/scratch2/CAS/apps/netcdf/netcdf-4.4.0/lib -lnetcdff -lnetcdf \
	-L/home/monkk/pvm3/lib/LINUX64 -lpvm3 \
	-L/mnt/scratch2/CAS/apps/hdf5/hdf5-1.8.17/lib -lhdf5_hl -lhdf5 \
	-L/mnt/scratch2/szip/szip-2.1/lib -lsz \
	-L/mnt/scratch2/zlib/zlib-1.2.8/lib -lz 
INCLUDE= -I/home/monkk/ioapi-3.1/ioapi/fixed_src 

RAW = $(PROGRAM).o

.f.o:
	$(FC) $(FFLAGS) $(INCLUDE) -c -o $@ $<

.F.o:
	$(FC) $(FFLAGS) $(INCLUDE) -c -o $@ $<

$(PROGRAM):     $(RAW)
	$(FC) $(LNKFLGS) -o $(@) $(RAW) $(LIBS)

clean:
	rm -f $(PROGRAM) *.o
