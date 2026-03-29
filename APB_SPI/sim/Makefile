
#Makefile for UVM Testbench - Lab 10

# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS

#SIMULATOR = Questa
SIMULATOR = VCS

FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64


RTL= ../rtl/*
work= work #library name
SVTB1= ../tb/top.sv
INC = +incdir+../tb +incdir+../test +incdir+../apb_agent +incdir+../spi_agent
SVTB2 = ../test/test_pkg.sv
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
VSIMBATCH1      = -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2      = -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3      = -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4      = -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"
VSIMBATCH5      = -c -do  " log -r /* ;coverage save -onexit mem_cov5;run -all; exit"
VSIMBATCH6      = -c -do  " log -r /* ;coverage save -onexit mem_cov6;run -all; exit"
VSIMBATCH7      = -c -do  " log -r /* ;coverage save -onexit mem_cov7;run -all; exit"
VSIMBATCH8      = -c -do  " log -r /* ;coverage save -onexit mem_cov8;run -all; exit"
VSIMBATCH9      = -c -do  " log -r /* ;coverage save -onexit mem_cov9;run -all; exit"
VSIMBATCH10     = -c -do  " log -r /* ;coverage save -onexit mem_cov10;run -all; exit"
VSIMBATCH11     = -c -do  " log -r /* ;coverage save -onexit mem_cov11;run -all; exit"
VSIMBATCH12     = -c -do  " log -r /* ;coverage save -onexit mem_cov12;run -all; exit"

help:
        @echo =============================================================================================================
        @echo "! USAGE          --  make target                                                                                 !"
        @echo "! clean          =>  clean the earlier log and intermediate files.                                               !"
        @echo "! sv_cmp         =>  Create library and compile the code.                                                        !"
        @echo "! run_test       =>  clean, compile & run the simulation for base_test in batch mode.                            !"
        @echo "! run_test1      =>  clean, compile & run the simulation for apb_rst_seq_test in batch mode.                     !"
        @echo "! run_test2      =>  clean, compile & run the simulation for cpol_cphase_00_test in batch mode.                  !"
        @echo "! run_test3      =>  clean, compile & run the simulation for cpol_cphase_01_test in batch mode.                  !"
        @echo "! run_test4      =>  clean, compile & run the simulation for cpol_cphase_10_test in batch mode.                  !"
        @echo "! run_test5      =>  clean, compile & run the simulation for cpol_cphase_11_test in batch mode.                  !"
        @echo "! run_test6      =>  clean, compile & run the simulation for cpol_cphase_00m_test in batch mode.                 !"
        @echo "! run_test7      =>  clean, compile & run the simulation for cpol_cphase_01m_test in batch mode.                 !"
        @echo "! run_test8      =>  clean, compile & run the simulation for cpol_cphase_10m_test in batch mode.                 !"
        @echo "! run_test9      =>  clean, compile & run the simulation for cpol_cphase_11m_test in batch mode.                 !"
        @echo "! run_test10     =>  clean, compile & run the simulation for repeat_test in batch mode.                          !"
        @echo "! run_test11     =>  clean, compile & run the simulation for low_power_test in batch mode.                       !"
        @echo "! view_wave1     =>  To view the waveform of base_test                                                           !"
        @echo "! view_wave2     =>  To view the waveform of apb_rst_seq_test                                                    !"
        @echo "! view_wave3     =>  To view the waveform of cpol_cphase_00_test                                                 !"
        @echo "! view_wave4     =>  To view the waveform of cpol_cphase_01_test                                                 !"
        @echo "! view_wave5     =>  To view the waveform of cpol_cphase_10_test                                                 !"
        @echo "! view_wave6     =>  To view the waveform of cpol_cphase_11_test                                                 !"
        @echo "! view_wave7     =>  To view the waveform of cpol_cphase_00m_test                                                !"
        @echo "! view_wave8     =>  To view the waveform of cpol_cphase_01m_test                                                !"
        @echo "! view_wave9     =>  To view the waveform of cpol_cphase_10m_test                                                !"
        @echo "! view_wave10    =>  To view the waveform of cpol_cphase_11m_test                                                !"
        @echo "! view_wave11    =>  To view the waveform of repeat_test                                                         !"
        @echo "! view_wave12    =>  To view the waveform of low_power_test                                                      !"
        @echo "! regress        =>  clean, compile and run all testcases in batch mode.                                         !"
        @echo "! report         =>  To merge coverage reports for all testcases and  convert to html format.                    !"
        @echo "! cov            =>  To open merged coverage report in html format.                                              !"
        @echo ====================================================================================================================

clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
run_test : run_test_$(SIMULATOR)
run_test1 : run_test1_$(SIMULATOR)
run_test2 : run_test2_$(SIMULATOR)
run_test3 : run_test3_$(SIMULATOR)
run_test4 : run_test4_$(SIMULATOR)
run_test5 : run_test5_$(SIMULATOR)
run_test6 : run_test6_$(SIMULATOR)
run_test7 : run_test7_$(SIMULATOR)
run_test8 : run_test8_$(SIMULATOR)
run_test9 : run_test9_$(SIMULATOR)
run_test10 : run_test10_$(SIMULATOR)
run_test11 : run_test11_$(SIMULATOR)
view_wave1 : view_wave1_$(SIMULATOR)
view_wave2 : view_wave2_$(SIMULATOR)
view_wave3 : view_wave3_$(SIMULATOR)
view_wave4 : view_wave4_$(SIMULATOR)
view_wave5 : view_wave5_$(SIMULATOR)
view_wave6 : view_wave6_$(SIMULATOR)
view_wave7 : view_wave7_$(SIMULATOR)
view_wave8 : view_wave8_$(SIMULATOR)
view_wave9 : view_wave9_$(SIMULATOR)
view_wave10: view_wave10_$(SIMULATOR)
view_wave11: view_wave11_$(SIMULATOR)
view_wave12: view_wave11_$(SIMULATOR)
regress : regress_$(SIMULATOR)
report : report_$(SIMULATOR)
cov : cov_$(SIMULATOR)

# ----------------------------- Start of Definitions for Mentor's Questa Specific Targets -------------------------------#

sv_cmp_Questa:
        vlib $(work)
        vmap work $(work)
        vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1)

run_test_Questa: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=base_test
                vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

run_test1_Questa: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log  -sv_seed random work.top +UVM_TESTNAME=apb_rst_seq_test
run_test2_Questa: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test3.log  -sv_seed random work.top +UVM_TESTNAME=cpol_cphase_00_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3

run_test3_Questa: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave_file4.wlf -l test4.log  -sv_seed random work.top +UVM_TESTNAME=cpol_cphase_01_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov4

run_test4_Questa: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH5)  -wlf wave_file5.wlf -l test5.log  -sv_seed random work.top +UVM_TESTNAME=cpol_cphase_10_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov5

run_test5_Questa: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH6)  -wlf wave_file6.wlf -l test6.log  -sv_seed random work.top +UVM_TESTNAME=cpol_cphase_11_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov6

run_test6_Questa: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH7)  -wlf wave_file7.wlf -l test7.log  -sv_seed random work.top +UVM_TESTNAME=cpol_cphase_00m_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov7

run_test7_Questa: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH8)  -wlf wave_file8.wlf -l test8.log  -sv_seed random work.top +UVM_TESTNAME=cpol_cphase_01m_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov8

run_test8_Questa: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH9)  -wlf wave_file9.wlf -l test9.log  -sv_seed random work.top +UVM_TESTNAME=cpol_cphase_10m_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov9

run_test9_Questa: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH10)  -wlf wave_file10.wlf -l test10.log  -sv_seed random work.top +UVM_TESTNAME=cpol_cphase_11m_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov10

run_test10_Questa: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH11)  -wlf wave_file11.wlf -l test11.log  -sv_seed random work.top +UVM_TESTNAME=repeat_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov11

run_test11_Questa: sv_cmp
        vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH12)  -wlf wave_file12.wlf -l test12.log  -sv_seed random work.top +UVM_TESTNAME=low_power_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov12

view_wave1_Questa:
        vsim -view wave_file1.wlf

view_wave2_Questa:
        vsim -view wave_file2.wlf

view_wave3_Questa:
        vsim -view wave_file3.wlf

view_wave4_Questa:
        vsim -view wave_file4.wlf



view_wave5_VCS:
        verdi -ssf wave5.fsdb

view_wave6_VCS:
        verdi -ssf wave6.fsdb

view_wave7_VCS:
        verdi -ssf wave7.fsdb

view_wave8_VCS:
        verdi -ssf wave8.fsdb

view_wave9_VCS:
        verdi -ssf wave9.fsdb

view_wave10_VCS:
        verdi -ssf wave10.fsdb

view_wave11_VCS:
        verdi -ssf wave11.fsdb

view_wave12_VCS:
        verdi -ssf wave12.fsdb

report_VCS:
        urg -dir mem_cov1.vdb mem_cov2.vdb mem_cov3.vdb mem_cov4.vdb mem_cov5.vdb mem_cov6.vdb mem_cov7.vdb mem_cov8.vdb mem_cov9.vdb mem_cov10.vdb mem_cov11.vdb mem_cov12.vdb -dbname merged_dir/merged_test -format both -report urgReport

regress_VCS: clean_VCS sv_cmp_VCS run_test_VCS run_test1_VCS run_test2_VCS run_test3_VCS run_test4_VCS run_test5_VCS run_test6_VCS run_test7_VCS run_test8_VCS run_test9_VCS run_test10_VCS report_VCS

cov_VCS:
        verdi -cov -covdir merged_dir.vdb

clean_VCS:
        rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h urgReport* *.fsdb novas* verdi*
        clear

# ----------------------------- END of Definitions for Synopsys's VCS Specific Targets -------------------------------#


# ----------------------------- Start of Definitions for Synopsys's VCS Specific Targets -------------------------------#

sv_cmp_VCS:
        vcs -l vcs.log -timescale=1ns/1ps -sverilog -ntb_opts uvm -debug_access+all -full64 -kdb  -lca -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(INC) $(SVTB2) $(SVTB1)

run_test_VCS:  sv_cmp_VCS
        ./simv -a vcs.log +fsdbfile+wave1.fsdb -cm_dir ./mem_cov1 +ntb_random_seed_automatic +UVM_TESTNAME=base_test
        urg -dir mem_cov1.vdb -format both -report urgReport1

run_test1_VCS:  sv_cmp_VCS
        ./simv -a vcs.log +fsdbfile+wave2.fsdb -cm_dir ./mem_cov2 +ntb_random_seed_automatic +UVM_TESTNAME=apb_rst_seq_test
        urg -dir mem_cov2.vdb -format both -report urgReport2

run_test2_VCS:  sv_cmp_VCS
        ./simv -a vcs.log +fsdbfile+wave3.fsdb -cm_dir ./mem_cov3 +ntb_random_seed_automatic +UVM_TESTNAME=cpol_cphase_00_test
        urg -dir mem_cov3.vdb -format both -report urgReport3

run_test3_VCS:  sv_cmp_VCS
        ./simv -a vcs.log +fsdbfile+wave4.fsdb -cm_dir ./mem_cov4 +ntb_random_seed_automatic +UVM_TESTNAME=cpol_cphase_01_test
        urg -dir mem_cov4.vdb -format both -report urgReport4

run_test4_VCS:  sv_cmp_VCS
        ./simv -a vcs.log +fsdbfile+wave5.fsdb -cm_dir ./mem_cov5 +ntb_random_seed_automatic +UVM_TESTNAME=cpol_cphase_10_test
        urg -dir mem_cov5.vdb -format both -report urgReport5

run_test5_VCS:  sv_cmp_VCS
        ./simv -a vcs.log +fsdbfile+wave6.fsdb -cm_dir ./mem_cov6 +ntb_random_seed_automatic +UVM_TESTNAME=cpol_cphase_11_test
        urg -dir mem_cov6.vdb -format both -report urgReport6

run_test6_VCS:  sv_cmp_VCS
        ./simv -a vcs.log +fsdbfile+wave7.fsdb -cm_dir ./mem_cov7 +ntb_random_seed_automatic +UVM_TESTNAME=cpol_cphase_00m_test
        urg -dir mem_cov7.vdb -format both -report urgReport7

run_test7_VCS:  sv_cmp_VCS
        ./simv -a vcs.log +fsdbfile+wave8.fsdb -cm_dir ./mem_cov8 +ntb_random_seed_automatic +UVM_TESTNAME=cpol_cphase_01m_test
        urg -dir mem_cov8.vdb -format both -report urgReport8

run_test8_VCS:  sv_cmp_VCS
        ./simv -a vcs.log +fsdbfile+wave9.fsdb -cm_dir ./mem_cov9 +ntb_random_seed_automatic +UVM_TESTNAME=cpol_cphase_10m_test
        urg -dir mem_cov9.vdb -format both -report urgReport9

run_test9_VCS:  sv_cmp_VCS
         ./simv -a vcs.log +fsdbfile+wave10.fsdb -cm_dir ./mem_cov10 +ntb_random_seed_automatic +UVM_TESTNAME=cpol_cphase_11m_test
        urg -dir mem_cov10.vdb -format both -report urgReport10

run_test10_VCS: sv_cmp_VCS
        ./simv -a vcs.log +fsdbfile+wave11.fsdb -cm_dir ./mem_cov11 +ntb_random_seed_automatic +UVM_TESTNAME=repeat_test
        urg -dir mem_cov11.vdb -format both -report urgReport11

run_test11_VCS: sv_cmp_VCS
        ./simv -a vcs.log +fsdbfile+wave12.fsdb -cm_dir ./mem_cov12 +ntb_random_seed_automatic +UVM_TESTNAME=low_power_test
        urg -dir mem_cov12.vdb -format both -report urgReport12


view_wave1_VCS:
        verdi -ssf wave1.fsdb

view_wave2_VCS:
        verdi -ssf wave2.fsdb

view_wave3_VCS:
        verdi -ssf wave3.fsdb

view_wave4_VCS:
        verdi -ssf wave4.fsdb

view_wave5_VCS:
        verdi -ssf wave5.fsdb

view_wave6_VCS:
        verdi -ssf wave6.fsdb

view_wave7_VCS:
        verdi -ssf wave7.fsdb

view_wave8_VCS:
        verdi -ssf wave8.fsdb

view_wave9_VCS:
        verdi -ssf wave9.fsdb

view_wave10_VCS:
        verdi -ssf wave10.fsdb

view_wave11_VCS:
        verdi -ssf wave11.fsdb

view_wave12_VCS:
        verdi -ssf wave12.fsdb

report_VCS:
        urg -dir mem_cov1.vdb mem_cov2.vdb mem_cov3.vdb mem_cov4.vdb mem_cov5.vdb mem_cov6.vdb mem_cov7.vdb mem_cov8.vdb mem_cov9.vdb mem_cov10.vdb mem_cov11.vdb mem_cov12.vdb -dbname merged_dir/merged_test -format both -report urgReport

regress_VCS: clean_VCS sv_cmp_VCS run_test_VCS run_test1_VCS run_test2_VCS run_test3_VCS run_test4_VCS run_test5_VCS run_test6_VCS run_test7_VCS run_test8_VCS run_test9_VCS run_test10_VCS report_VCS

cov_VCS:
        verdi -cov -covdir merged_dir.vdb

clean_VCS:
        rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h urgReport* *.fsdb novas* verdi*
        clear

# ----------------------------- END of Definitions for Synopsys's VCS Specific Targets -------------------------------#


                                                                                         
