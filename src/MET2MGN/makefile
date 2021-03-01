SHELL= /bin/sh
PGF90= ifort
WRF_CMAQ_HOME=/home/599/nah599/ir04/WRF-CMAQ
#FCFLGS = -O -Mextend -Mlfs -Msecond_underscore
FCFLGS= -O2 -extend_source 132  -assume underscore -qopenmp
#FCFLGS2 = -O -Mbyteswapio -Mextend -Mlfs -Msecond_underscore
FCFLGS2= -O2 -convert big_endian -extend_source 132 -assume underscore -qopenmp

LNKFLGS= -qopenmp

OBJCTS= \
met2mgn.o \
readpar.o \
readmcip.o \
micromet.o \
caldate.o \
lcpgeo.o \
interp_lcp.o \
procmm5.o \
readmm5.o \
xtod.o \
vertmap.o \
juldate.o \
utmgeo.o

LIBS= -L$(WRF_CMAQ_HOME)/build/CMAQ/lib/x86_64/intel/ioapi/lib -lioapi -lnetcdff -lnetcdf
INC= -I$(WRF_CMAQ_HOME)/build/CMAQ/lib/x86_64/intel/ioapi/include_files/fixed_src/ -I$(CURDIR)/INCLDIR

met2mgn: $(OBJCTS)
	$(PGF90) $(LNKFLGS) $(OBJCTS) $(LIBS) -o met2mgn
met2mgn.o:
	$(PGF90) -c $(FCFLGS2) $(INC) met2mgn.f
readpar.o:
	$(PGF90) -c $(FCFLGS) $(INC) readpar.f
readmcip.o:
	$(PGF90) -c $(FCFLGS2) $(INC) readmcip.f
micromet.o:
	$(PGF90) -c $(FCFLGS2) $(INC) micromet.f
caldate.o:
	$(PGF90) -c $(FCFLGS2) $(INC) caldate.f
lcpgeo.o:
	$(PGF90) -c $(FCFLGS2) ${INC} lcpgeo.f
interp_lcp.o:
	$(PGF90) -c $(FCFLGS2) ${INC} interp_lcp.f
procmm5.o:
	$(PGF90) -c $(FCFLGS2) ${INC} procmm5.f
readmm5.o:
	$(PGF90) -c $(FCFLGS2) ${INC} readmm5.f
xtod.o:
	$(PGF90) -c $(FCFLGS2) ${INC} xtod.f
vertmap.o:
	$(PGF90) -c $(FCFLGS2) ${INC} vertmap.f
juldate.o:
	$(PGF90) -c $(FCFLGS2) ${INC} juldate.f
utmgeo.o:
	$(PGF90) -c $(FCFLGS2) ${INC} utmgeo.f
clean:
	rm -rf *.o met2mgn

