SHELL=/bin/sh
FC= ifort
#FFLAGS= -O -Mvect=sse -Mextend -Msecond_underscore -Mlfs -Bstatic_pgi
FFLAGS= -O2 -xHost -extend_source 132 -assume underscore -module -qopenmp

LNKFLGS= -qopenmp

PROGRAM= mgn2mech
LIBS = -L$(WRF_CMAQ_HOME)/build/CMAQ/lib/x86_64/intel/ioapi/lib -lioapi -lnetcdff -lnetcdf
INCLUDE = -I$(WRF_CMAQ_HOME)/build/CMAQ/lib/x86_64/intel/ioapi/include_files/fixed_src/ -I$(CURDIR)/INCLDIR  

OBJS = \
     checkmem.o \
     growseason.o \
     $(PROGRAM).o

MODULES= *mod.f

#-----------------------------------------------------------------------
# line to allow file.mod files to be recognised by GNU make
%.o : %.mod
#-----------------------------------------------------------------------

.SUFFIXES : .f .f .o 

.f.o:
	$(FC) -c $(FFLAGS) $(INCLUDE) $<
.F.o:
	$(FC) -c $(FFLAGS) $(INCLUDE) $<

#-----------------------------------------------------------------------

$(PROGRAM):	$(OBJS)
	$(FC) $(LNKFLGS) $(INCLUDE) -o $(@) $(OBJS) $(LIBS)

#-----------------------------------------------------------------------

clean:
	rm -f $(PROGRAM) *.o *.mod *.core
#-----------------------------------------------------------------------


