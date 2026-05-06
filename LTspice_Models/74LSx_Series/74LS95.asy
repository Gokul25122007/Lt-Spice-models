* 74LS95 4-BIT SHIFT REGISTER (RE-CHECKED & NORMALIZED)
* Pin Order: DS P0 P1 P2 P3 MC GND CP2 CP1 QA QB QC QD VCC
.subckt 74LS95 DS P0 P1 P2 P3 MC GND CP2 CP1 QA QB QC QD VCC

* 1. INPUT NORMALIZATION
Bclk clk_int 0 V=if(V(MC)>2.5, if(V(CP2)>2.5,1,0), if(V(CP1)>2.5,1,0))
Bds_n ds_n 0 V=if(V(DS)>2.5, 1, 0)
Bmc_n mc_n 0 V=if(V(MC)>2.5, 1, 0)

* 2. EDGE DETECTOR (Negative Edge)
Bed ed 0 V=if(V(clk_int)<0.5 & delay(V(clk_int),1u)>0.5, 1, 0)

* 3. INTERNAL STATE BUFFERS (Normalized to 1.0V)
* QA State
Bqa_i qa_i 0 V=if(V(ed)>0.5, if(V(mc_n)>0.5, if(V(P0)>2.5,1,0), V(ds_n)), V(qa_s))
Rqa qa_i qa_s 100
Cqa qa_s 0 1n ic=0

* QB State
Bqb_i qb_i 0 V=if(V(ed)>0.5, if(V(mc_n)>0.5, if(V(P1)>2.5,1,0), delay(V(qa_s),2u)), V(qb_s))
Rqb qb_i qb_s 100
Cqb qb_s 0 1n ic=0

* QC State
Bqc_i qc_i 0 V=if(V(ed)>0.5, if(V(mc_n)>0.5, if(V(P2)>2.5,1,0), delay(V(qb_s),2u)), V(qc_s))
Rqc qc_i qc_s 100
Cqc qc_s 0 1n ic=0

* QD State
Bqd_i qd_i 0 V=if(V(ed)>0.5, if(V(mc_n)>0.5, if(V(P3)>2.5,1,0), delay(V(qc_s),2u)), V(qd_s))
Rqd qd_i qd_s 100
Cqd qd_s 0 1n ic=0

* 4. OUTPUT SCALING
* Math: Output = VCC * InternalState
B1 QA GND V=V(VCC)*V(qa_s)
B2 QB GND V=V(VCC)*V(qb_s)
B3 QC GND V=V(VCC)*V(qc_s)
B4 QD GND V=V(VCC)*V(qd_s)

.ends 74LS95
