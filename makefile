myOBJDIR=./obj
mySRCDIR=./src
mySRCFILES= exciton_td_main.f95 read_in_para.f95      \
            index_fe.f95 index_ct.f95 build_hfe.f95   \
			build_hfect.f95 build_hct.f95             \
			diagonalize.f95 para_out.f95 td_setup.f95 \
			get_current_state.f95
myOBJFILES=$(mySRCFILES:.f95=.o)
myEXE=exciton1D_td.exe
myDEP=commonvar.mod
vpath %.o ${myOBJDIR}
vpath %.mod ${myOBJDIR}
vpath %.f95 ${mySRCDIR}
FLINKER = gfortran
LIBLINKER = -llapack -lblas

${myEXE} : ${myOBJFILES}
	-${FLINKER} $(addprefix ${myOBJDIR}/,$(^F)) ${myOBJDIR}/${myDEP:.mod=.o} -o $@ -I${myOBJDIR} ${LIBLINKER}

%.o : %.f95 ${myDEP}
	-${FLINKER} -c ${mySRCDIR}/$(<F) -o ${myOBJDIR}/$(@F) -I${myOBJDIR} ${LIBLINKER}

${myDEP} : ${myDEP:.mod=.f95}
	-${FLINKER} -c $< -o ${myOBJDIR}/${@:.mod=.o} -J${myOBJDIR}

clean:
	@echo cleaning up
	@-rm ${myOBJDIR}/*.o ${myOBJDIR}/*.mod 2>/dev/null || true
	@-rm ${myEXE}
