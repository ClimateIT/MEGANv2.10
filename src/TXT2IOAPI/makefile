SHELL= /bin/sh
FC= ifort

WRF_CMAQ_HOME=/home/599/nah599/ir04/WRF-CMAQ
#FFLAGS= -O -Mvect=sse -Mextend -Msecond_underscore -Bstatic_pgi -Mlfs
FFLAGS= -O2 -xHost -extend_source 132 -assume underscore -module -qopenmp

LNKFLGS= -qopenmp

PROGRAM= txt2ioapi
LIBS= -L$(WRF_CMAQ_HOME)/build/CMAQ/lib/x86_64/intel/ioapi/lib -lioapi -lnetcdff -lnetcdf
INCLUDE= -I$(WRF_CMAQ_HOME)/build/CMAQ/lib/x86_64/intel/ioapi/include_files/fixed_src/ -I$(CURDIR)/INCLDIR

RAW= parsline.o \
      checkmem.o \
      cnvt_efs.o \
      cnvt_pft.o \
      cnvt_lai.o \
      $(PROGRAM).o

.f.o:
	$(FC) $(FFLAGS) $(INCLUDE) -c -o $@ $<

.F.o:
	$(FC) $(FFLAGS) $(INCLUDE) -c -o $@ $<

$(PROGRAM):	$(RAW)
	$(FC) $(LNKFLGS) $(INCLUDE) -o $(@) $(RAW) $(LIBS)

clean:
	rm -f $(PROGRAM)  *.o *.core
