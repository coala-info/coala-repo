# Visualizing Large-scale Copy Number Variation in Single-Cell RNA-Seq Expression Data

Timothy Tickle1, Itay Tirosh1,2, Christophe Georgescu1, Maxwell Brown1 and Brian Haas1

1Klarman Cell Observatory, Broad Institute of MIT and Harvard, Cambridge, MA, USA
2Weizmann Institute of Science, Rehovot, Israel

#### 2025-10-30

#### Abstract

InferCNV is used to explore tumor single cell RNA-Seq data to identify evidence for large-scale chromosomal copy number variations, such as gains or deletions of entire chromosomes or large segments of chromosomes. This is done by exploring expression intensity of genes across positions of the genome in comparison to the average or a set of reference ‘normal’ cells. A heatmap is generated illustrating the relative expression intensities across each chromosome, and it becomes readily apparent as to which regions of the genome are over-abundant or less-abundant as compared to normal cells (or the average, if reference normal cells are not provided).

#### Package

infercnv 1.26.0

# Contents

* [1 Installation](#installation)
  + [1.1 Required dependencies](#required-dependencies)
  + [1.2 Installing](#installing)
  + [1.3 Optional extension](#optional-extension)
* [2 Running InferCNV](#running-infercnv)
  + [2.1 Create the InferCNV Object](#create-the-infercnv-object)
  + [2.2 Running the full default analysis](#running-the-full-default-analysis)
* [3 Additional Information](#additional-information)
  + [3.1 Online Documentation](#online-documentation)
  + [3.2 TrinityCTAT](#trinityctat)
  + [3.3 Applications](#applications)
* [4 Session info](#session-info)

# 1 Installation

## 1.1 Required dependencies

*inferCNV* uses the *R* packages *[ape](https://CRAN.R-project.org/package%3Dape)*, *[BiocGenerics](https://bioconductor.org/packages/3.22/BiocGenerics)*, *[binhf](https://CRAN.R-project.org/package%3Dbinhf)*, *[caTools](https://CRAN.R-project.org/package%3DcaTools)*, *[coda](https://CRAN.R-project.org/package%3Dcoda)*, *[coin](https://CRAN.R-project.org/package%3Dcoin)*, *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)*, *[doparallel](https://CRAN.R-project.org/package%3Ddoparallel)*, *[edgeR](https://bioconductor.org/packages/3.22/edgeR)*, *[fastcluster](https://CRAN.R-project.org/package%3Dfastcluster)*, *[fitdistrplus](https://CRAN.R-project.org/package%3Dfitdistrplus)*, *[foreach](https://CRAN.R-project.org/package%3Dforeach)*, *[futile.logger](https://CRAN.R-project.org/package%3Dfutile.logger)*, *[future](https://CRAN.R-project.org/package%3Dfuture)*, *[gplots](https://CRAN.R-project.org/package%3Dgplots)*, *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)*, *[HiddenMarkov](https://CRAN.R-project.org/package%3DHiddenMarkov)*, *[leiden](https://CRAN.R-project.org/package%3Dleiden)*, *[phyclust](https://CRAN.R-project.org/package%3Dphyclust)*, *[RANN](https://CRAN.R-project.org/package%3DRANN)*, *[reshape](https://CRAN.R-project.org/package%3Dreshape)*, *[rjags](https://CRAN.R-project.org/package%3Drjags)*, *[RColorBrewer](https://CRAN.R-project.org/package%3DRColorBrewer)*, *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*, *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)*, *[tidyr](https://CRAN.R-project.org/package%3Dtidyr)* and imports functions from the archived *[GMD](https://CRAN.R-project.org/package%3DGMD)*.

## 1.2 Installing

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("infercnv")
```

## 1.3 Optional extension

If you want to use the interactive heatmap visualization, please check the add-on packge *R* *[inferCNV\_NGCHM](https://github.com/broadinstitute/inferCNV_NGCHM)* after installing the packages *[tibble](https://CRAN.R-project.org/package%3Dtibble)*, *[tsvio](https://github.com/bmbroom/tsvio)* and *[NGCHMR](https://github.com/bmbroom/NGCHMR)*. To install optional packages, type the following in an R command window:

```
install.packages("tibble")

install.packages("devtools")
devtools::install_github("bmbroom/tsvio")
devtools::install_github("bmbroom/NGCHMR", ref="stable")
devtools::install_github("broadinstitute/inferCNV_NGCHM")
```

And download the NGCHM java application by typing the following in a regular shell:

```
wget http://tcga.ngchm.net/NGCHM/ShaidyMapGen.jar
```

# 2 Running InferCNV

## 2.1 Create the InferCNV Object

Reading in the raw counts matrix and meta data, populating the infercnv object

```
infercnv_obj = CreateInfercnvObject(
  raw_counts_matrix="../inst/extdata/oligodendroglioma_expression_downsampled.counts.matrix.gz",
  annotations_file="../inst/extdata/oligodendroglioma_annotations_downsampled.txt",
  delim="\t",
  gene_order_file="../inst/extdata/gencode_downsampled.EXAMPLE_ONLY_DONT_REUSE.txt",
  ref_group_names=c("Microglia/Macrophage","Oligodendrocytes (non-malignant)"))
```

```
## INFO [2025-10-30 00:35:29] Parsing matrix: ../inst/extdata/oligodendroglioma_expression_downsampled.counts.matrix.gz
## INFO [2025-10-30 00:35:31] Parsing gene order file: ../inst/extdata/gencode_downsampled.EXAMPLE_ONLY_DONT_REUSE.txt
## INFO [2025-10-30 00:35:31] Parsing cell annotations file: ../inst/extdata/oligodendroglioma_annotations_downsampled.txt
## INFO [2025-10-30 00:35:31] ::order_reduce:Start.
## INFO [2025-10-30 00:35:31] .order_reduce(): expr and order match.
## INFO [2025-10-30 00:35:32] ::process_data:order_reduce:Reduction from positional data, new dimensions (r,c) = 10338,184 Total=18322440.6799817 Min=0 Max=34215.
## INFO [2025-10-30 00:35:32] num genes removed taking into account provided gene ordering list: 399 = 3.8595473012188% removed.
## INFO [2025-10-30 00:35:32] -filtering out cells < 100 or > Inf, removing 0 % of cells
## WARN [2025-10-30 00:35:32] Please use "options(scipen = 100)" before running infercnv if you are using the analysis_mode="subclusters" option or you may encounter an error while the hclust is being generated.
## INFO [2025-10-30 00:35:32] validating infercnv_obj
```

## 2.2 Running the full default analysis

```
out_dir = tempfile()
infercnv_obj_default = infercnv::run(
    infercnv_obj,
    cutoff=1, # cutoff=1 works well for Smart-seq2, and cutoff=0.1 works well for 10x Genomics
    out_dir=out_dir,
    cluster_by_groups=TRUE,
    plot_steps=FALSE,
    denoise=TRUE,
    HMM=FALSE,
    no_prelim_plot=TRUE,
    png_res=60
)
```

```
## Warning: Data is of class matrix. Coercing to dgCMatrix.
```

```
## Finding variable features for layer counts
```

```
## Centering and scaling data matrix
```

```
## PC_ 1
## Positive:  PSMD14, GCA, TANK, SCN2A, MARCH7, CSRNP3, TTC21B, SCN1A, SPC25, DHRS9
##     BBS5, FASTKD1, PPIG, AKIRIN1, NDUFS5, RRAGC, MACF1, UTP11L, PPIEL, PHOSPHO2
##     FHL3, PABPC4, SF3A3, PPIE, INPP5B, KLHL23, TRIT1, C1orf122, CAP1, MANEAL
## Negative:  PPM1A, DHRS7, MNAT1, TRMT5, SLC38A6, HIF1A, SNAPC1, LINC00643, PCNXL4, DDHD1
##     FERMT2, WDR89, GNPNAT1, GMFB, PPP2R5E, CGRRF1, STYX, RTN1, SOCS4, PSMC6
##     MAPK1IP1L, FBXO34, ATG14, TXNDC16, JKAMP, KTN1, L3HYPDH, PELI2, C14orf166, KIAA0586
## PC_ 2
## Positive:  TMEM219, KCTD13, ASPHD1, TAOK2, SEZ6L2, HIRIP3, CDIPT, ALDOA, MVP, PAGR1
##     PPP4C, PRRT2, MAZ, YPEL3, KIF22, QPRT, MAPK3, SULT1A4, SLX1B, CORO1A
##     BOLA2, BOLA2B, SPNS1, SLX1A, NFATC2IP, SULT1A3, TUFM, CD2BP2, ATXN2L, TBC1D10B
## Negative:  SEL1L, DIO2, NRXN3, ADCK1, GALC, SNW1, SPATA7, SLIRP, ZC3H14, ALKBH1
##     TTC8, SPTLC2, FOXN3, AHSA1, EFCAB11, VIPAS39, TMED8, PSMC1, GSTZ1, POMT2
##     CALM1, ZDHHC22, KIAA1737, RPS6KA5, ANGEL1, VASH1, C14orf159, GPATCH2L, TGFB3, SMEK1
## PC_ 3
## Positive:  CAND1, TMBIM4, DYRK2, MDM1, NUP107, RAP1B, LLPH, SLC35E3, LEMD3, MDM2
##     CPM, GNS, CPSF6, LYZ, TBK1, YEATS4, XPOT, FRS2, C12orf66, SRGAP1
##     CCT2, TMEM5, PPM1H, MON2, RAB3IP, USP15, CTDSP2, CNOT2, TSFM, METTL1
## Negative:  RPL23A, SUPT6H, TRAF4, SDF2, FAM222B, KIAA0100, ALDOC, PIGS, ARHGEF26, ARHGEF26-AS1
##     RAP2B, P2RY1, RNPC3, DPH5, MBNL1, SLC30A7, SLC44A1, ABCA1, FSD1L, EXTL2
##     NIPSNAP3A, FKTN, RTCA, TMEM38B, HIAT1, P2RY12, SMC2, SLC35A3, ZNF462, KLF4
## PC_ 4
## Positive:  MRPL46, NTRK3, KLHL25, AKAP13, MRPS11, DET1, AEN, MFGE8, ABHD2, POLG
##     PEX11A, AP3S2, IDH2, C15orf38-AP3S2, C15orf38, CIB1, NGRN, CRTC3, MAN2A2, UNC45A
##     HDDC3, VPS33B, CHD2, RGMA, IGF1R, LRRC28, MEF2A, LINS, ASB7, VIMP
## Negative:  RBM12, NFS1, CPNE1, ROMO1, ERGIC3, CEP250, EIF6, RBM39, EDEM2, TRPC4AP
##     PHF20, GSS, SCAND1, ACSS2, LINC00657, GGT7, EPB41L1, TP53INP2, AAR2, NCOA6
##     DLGAP4, PIGU, C20orf24, NDRG3, MAP1LC3A, SOGA1, DYNLRB1, SAMHD1, ITCH, RBL1
## PC_ 5
## Positive:  STX17, ERP44, NR4A3, INVS, SEC61B, TEX10, ALG2, MSANTD3, MSANTD3-TMEFF1, TGFBR1
##     LPPR1, TBC1D2, MRPL50, TRIM14, ZNF189, NANS, ANP32B, TMEM246, C9orf156, RNF20
##     XPA, SMC2, NCBP1, NIPSNAP3A, TSTD2, ABCA1, TMOD1, SLC44A1, ZNF510, FSD1L
## Negative:  ZNF160, ZNF415, ZNF83, ZNF331, MYADM, ZNF528, NDUFA3, ZNF880, ZNF610, ZNF480
##     TFPT, PRPF31, LENG1, MBOAT7, TSEN34, RPS9, LILRA4, LAIR1, TTYH1, LENG8
##     LILRB4, RDH13, HSPBP1, RPL28, SHISA7, ISOC2, ZNF580, ZNF581, ZNF542, ZNF583
```

```
## Computing nearest neighbor graph
```

```
## Computing SNN
```

```
## Warning: Data is of class matrix. Coercing to dgCMatrix.
```

```
## Finding variable features for layer counts
```

```
## Centering and scaling data matrix
```

```
## PC_ 1
## Positive:  RFC1, RPL9, KLHL5, LIAS, UGDH, TMEM156, UGDH-AS1, TLR1, KLF3, SMIM14
##     PGM2, RELL1, UBE2K, ARAP2, TBC1D19, PDS5A, RBPJ, APBB2, ANAPC4, DHX15
##     UCHL1, PACRGL, LCORL, DCAF16, LIMCH1, MED28, LAP3, TMEM33, QDPR, TAPT1-AS1
## Negative:  PNPLA2, RPLP2, CD151, PIDD, SLC25A22, CEND1, POLR2L, PDDC1, TALDO1, CHID1
##     TMEM80, TOLLIP, DEAF1, IRF7, MOB2, PHRF1, SNHG9, RPS2, IFITM10, TBL3
##     NDUFB10, NTHL1, MSRB1, FAHD1, NUBP2, HAGH, SPSB3, MRPS34, TSC2, CRAMP1L
## PC_ 2
## Positive:  APC2, C19orf25, MBD3, UQCR11, SCAMP4, BTBD2, MOB3A, AP3D1, PLEKHJ1, RNPS1
##     ECI1, E4F1, ABCA3, TBC1D24, ATP6V0C, MLST8, TRAF7, AMDHD2, SF3A2, PKD1
##     TSC2, NTHL1, TBL3, SNHG9, CEMP1, RPS2, NDUFB10, OAZ1, MSRB1, FAHD1
## Negative:  ZNF131, NIM1, NIPBL, SLC1A3, SEPP1, HMGCS1, SKP2, C5orf42, FBXO4, LMBRD2
##     C5orf28, C5orf51, NUP155, BRIX1, PAIP1, WDR70, RAD1, OXCT1, NNT, LIFR
##     AMACR, RPL37, RICTOR, TARS, FYB, MRPS30, DAB2, PRKAA1, SUB1, TTC33
## PC_ 3
## Positive:  PSMC5, TEX2, CCDC47, POLG2, FTSJ3, STRADA, DDX42, DDX5, TACO1, MIR3064
##     MIR5047, DCAF7, CEP95, TANC2, SMURF2, PLEKHM1P, METTL2A, LRRC37A3, MED13, AMZ2P1
##     INTS2, BCAS3, GNA13, PRKCA, PPM1D, CACNG4, APPBP2, HELZ, PSMD12, USP32
## Negative:  PODXL2, MCM2, TPRA1, MGLL, PLXNA1, SEC61A1, CHCHD6, ZXDC, RUVBL1, SLC41A3
##     CCDC14, KALRN, OSBPL11, UMPS, SNX4, ZNF148, EEFSEC, MYLK, PTPLB, RPN1
##     SEC22A, RAB7A, SEMA5B, ACAD9, HSPBAP1, ISY1, DTX3L, CNBP, PARP9, COPG1
## PC_ 4
## Positive:  MOSPD3, ACTL6B, GNB2, GIGYF1, TSC22D4, POP7, C7orf61, MEPCE, ZCWPW1, SLC12A9
##     PILRA, PILRB, TRIP6, SRRT, ACHE, AP1S1, PLOD3, ZNHIT1, FIS1, RABL5
##     CUX1, PRKRIP1, ORAI2, ALKBH4, NDN, MKRN3, SNRPN, SNURF, HERC2P7, UBE3A
## Negative:  SYNJ2BP, MED6, COX16, SMOC1, SRSF5, PCNX, KIAA0247, ZFYVE1, RBM25, PSEN1
##     NUMB, ACOT2, PNMA1, ELMSAN1, PTGR2, CRY1, MTERFD3, ZNF410, C12orf23, RIC8B
##     POLR3B, FAM161B, TCP11L2, CKAP4, COQ6, C12orf75, ALDH6A1, APPL2, LIN52, ABCD4
## PC_ 5
## Positive:  FGFR1OP, RNASET2, RPS6KA2, MLLT4, MPC1, SFT2D1, THBS2, QKI, C6orf120, CAHM
##     LINC00574, AGPAT4, DLL1, FAM120B, MAP3K4, PSMB1, TBP, LPAL2, PDCD2, MRPL18
##     TCP1, SRD5A1, MTRR, NSUN2, CCDC127, MED10, SDHA, FASTKD3, MRPL36, PDCD6
## Negative:  SEC61B, NR4A3, ALG2, STX17, TGFBR1, TBC1D2, ERP44, TRIM14, NANS, INVS
##     ANP32B, ECHDC1, RNF146, TEX10, KIAA0408, TRMT11, HINT3, NCOA7, C9orf156, MSANTD3
##     PTPRK, MSANTD3-TMEFF1, EPB41L2, XPA, LPPR1, AKAP7, MRPL50, ZNF189, TMEM246, NCBP1
```

```
## Computing nearest neighbor graph
```

```
## Computing SNN
```

```
## Warning: Data is of class matrix. Coercing to dgCMatrix.
```

```
## Finding variable features for layer counts
```

```
## Centering and scaling data matrix
```

```
## PC_ 1
## Positive:  NTHL1, TBL3, SNHG9, RPS2, NDUFB10, MSRB1, FAHD1, HAGH, NUBP2, SPSB3
##     MRPS34, NME3, MAPK8IP3, CRAMP1L, TELO2, CLCN7, C16orf91, UNKL, GNPTG, BAIAP3
##     UBE2I, SOX8, LMF1, CHTF18, RPUSD1, NARFL, HAGHL, WSCD1, MIS12, C1QBP
## Negative:  NFASC, MDM4, CNTN2, PIK3C2B, RBBP5, PPP1R15B, DSTYK, TMCC2, SNRPE, ZBED6
##     CDK18, ZC3H11A, NUCKS1, ATP2B4, RAB7L1, BTG2, SLC41A1, ADORA1, SRGAP2, TMEM183A
##     GLMN, BTBD8, RPAP2, CDC7, ZNF644, RPL5, ZNF326, CYB5R1, LRRC8D, EIF2D
## PC_ 2
## Positive:  GBA2, CREB3, TLN1, CCDC107, RUSC2, STOML2, PIGO, FANCG, VCP, DNAJB5
##     IL11RA, KIAA1161, FAM219A, GALT, NUDT2, RPP25L, DCTN3, SIGMAR1, UBAP1, ATP5H
##     ARMC7, DCAF12, ICT1, NT5C, HN1, UBAP2, CDR2L, SUMO2, HID1, UBE2R2
## Negative:  CD27-AS1, TNFRSF1A, TAPBPL, VAMP1, NACA, MRPL51, PRIM1, SNORA48, PARP11, LRP1
##     TULP3, RHNO1, SHMT2, NRIP2, R3HDM2, ITFG2, FKBP4, ARHGAP9, DCP1B, MARS
##     ADIPOR2, DDIT3, ERC1, RAD52, DCTN2, WNK1, KIF5A, PIP4K2C, NINJ2, DTX3
## PC_ 3
## Positive:  IFI27L2, KIAA0196, SQLE, NSMCE2, DICER1, MTSS1, DDX24, TRIB1, NDUFB9, DICER1-AS1
##     FAM84B, TATDN1, SNHG10, RNF139, UNC79, GLRX5, TRMT12, MYC, FAM91A1, UBR7
##     C14orf132, FAM49B, WDYHV1, ATG2B, ZHX1, ASAP1, C14orf142, C8orf76, GSKIP, EFR3A
## Negative:  TSTD2, NCBP1, XPA, C9orf156, ANP32B, NANS, TRIM14, TBC1D2, TGFBR1, ALG2
##     SEC61B, NR4A3, STX17, ERP44, INVS, TEX10, MSANTD3, MSANTD3-TMEFF1, LPPR1, MRPL50
##     COMMD1, CCT4, B3GNT2, FAM161A, EHBP1, WDPCP, TIA1, C2orf42, XPO1, ZNF189
## PC_ 4
## Positive:  ACSS2, GSS, GGT7, TRPC4AP, TP53INP2, NCOA6, EDEM2, PIGU, EIF6, CEP250
##     MAP1LC3A, ERGIC3, CPNE1, DYNLRB1, RBM12, NFS1, ITCH, ROMO1, RBM39, PHF20
##     AHCY, VPS29, SCAND1, FAM216A, LINC00657, EIF2S2, GPN3, EPB41L1, AAR2, ARPC3
## Negative:  POLG, ABHD2, PEX11A, MFGE8, AEN, AP3S2, DET1, C15orf38-AP3S2, MRPS11, C15orf38
##     MAN2A2, UNC45A, CRTC3, IDH2, NGRN, MRPL46, HDDC3, CIB1, VPS33B, NTRK3
##     CHD2, RGMA, KLHL25, AKAP13, IGF1R, ZNF592, SEC11A, NMB, LRRC28, WDR73
## PC_ 5
## Positive:  SGTB, NLN, TRAPPC13, TRIM23, PPWD1, CWC27, RNF180, IPO11, DIMT1, KIF2A
##     ZSWIM6, SMIM15, ADAMTS1, NDUFAF2, APP, N6AMT1, LTN1, GABPA, ATP5J, RWDD2B
##     ERCC8, JAM2, USP16, PLK2, CCT8, MRPL39, BACH1, TIAM1, NCAM2, GPBP1
## Negative:  MFNG, CDC42EP1, GGA1, PDXP, LGALS1, H1F0, GCAT, ANKRD54, EIF3L, POLR2F
##     PLA2G6, MAFF, TMEM184B, CSNK1E, DDX17, CBY1, TOMM22, JOSD1, GTPBP1, SUN2
##     DNAL4, NPTXR, PDGFB, RPL3, SYNGR1, TAB1, ATF4, RPS19BP1, TNRC6B, ADSL
```

```
## Computing nearest neighbor graph
```

```
## Computing SNN
```

```
## Warning: Data is of class matrix. Coercing to dgCMatrix.
```

```
## Finding variable features for layer counts
```

```
## Centering and scaling data matrix
```

```
## PC_ 1
## Positive:  BANP, KLHDC4, MAP1LC3B, IRF8, COX4I1, EMC8, CRISPLD2, USP10, COTL1, SUDS3
##     TAOK3, PEBP1, VSIG10, WSB2, TAF1C, RFC5, FBXO21, JRK, FBXW8, CASP2
##     GSTK1, FAM131B, MTRNR2L6, RNFT2, ZFYVE27, ARC, CRTAC1, AVPI1, ZYX, R3HCC1L
## Negative:  SCFD2, FIP1L1, DANCR, SGCB, DCUN1D4, OCIAD1, CHIC2, FRYL, PDGFRA, NFXL1
##     SRD5A3, COMMD8, GNPDA2, TMEM165, GUF1, CLOCK, ATP8A1, EXOC1, AASDH, PPAT
##     SLC30A9, PAICS, SRP72, NOA1, POLR2B, LPHN3, UBA6, YTHDC1, TMEM33, UTP3
## PC_ 2
## Positive:  PLD2, PSMB6, SLC25A11, CXCL16, RNF167, ARRB2, PELP1, MED11, PFN1, MYBBP1A
##     XAF1, SPAG7, UBE2G1, C17orf100, TXNDC17, RNASEK, WSCD1, ANKFY1, CAMTA2, MIS12
##     C17orf49, ZFP3, DERL2, RPAIN, ZNF232, CYB5D2, ACADVL, C1QBP, ZNF594, NUP88
## Negative:  COG1, FAM104A, CD300A, SSTR2, C17orf80, BTBD17, SLC39A11, SOX9, CDC42EP4, SLC9A3R1
##     KCNJ16, TTYH2, RPL38, ABCA8, PRKAR1A, NAT9, AMZ2, LINC00674, KPNA2, TMEM104
##     C17orf58, BPTF, FDXR, NOL11, PSMD12, HID1, HELZ, CDR2L, CACNG4, PRKCA
## PC_ 3
## Positive:  APLP2, NFRKB, ZBTB44, SNX19, NTM, IGSF9B, JAM3, NCAPD3, VPS26B, THYN1
##     ACAD8, B3GAT1, SYNJ2BP, MED6, PCNX, ZFYVE1, RBM25, PSEN1, NUMB, ACOT2
##     PNMA1, EML1, CYP46A1, ELMSAN1, EVL, YY1, CCNK, PTGR2, FAM161B, COQ6
## Negative:  FAM21C, AGAP4, PARG, ZNF485, ALOX5, VSTM4, CXCL12, ZNF32, ZNF22, ZNF239
##     NCOA4, RASSF4, ARHGAP22, BMS1P1, HNRNPF, GLUD1P7, MAPK8, FAM21B, BMS1P2, BMS1P6
##     AGAP9, ZNF488, BMS1P5, CSGALNACT2, TIMM23, BMS1, ZNF33B, AGAP6, ZNF37BP, HSD17B7P2
## PC_ 4
## Positive:  GEMIN2, TRAPPC6B, PNN, CTAGE5, SEC23A, KLHL28, LINC00639, FAM179B, TMX1, TRIM9
##     NIN, PYGL, PRPF39, MBIP, ATL1, MAP4K5, FKBP3, ATP5S, MDGA2, RPS29
##     MIS18BP1, BRMS1L, RPL36AL, L2HGDH, MGAT2, DNAAF2, ARF6, NEMF, KLHDC1, KLHDC2
## Negative:  TBXAS1, SLC37A3, LUC7L2, HIPK2, C7orf55, MKRN1, UBN2, NDUFB2, ZC3HAV1, BRAF
##     TRIM24, AHSA2, USP34, CREB3L2, C2orf74, XPO1, MRPS33, PEX13, FAM161A, DGKI
##     REL, CCT4, AGK, TMED8, PTN, VIPAS39, AHSA1, COMMD1, GSTZ1, SPTLC2
## PC_ 5
## Positive:  SYNJ2BP, MED6, PCNX, ZFYVE1, RBM25, PSEN1, NUMB, ACOT2, PNMA1, ELMSAN1
##     PTGR2, ZNF410, FAM161B, COQ6, ALDH6A1, LIN52, UBIAD1, MTOR, EXOSC10, SRM
##     TARDBP, DFFA, PGD, KIF1B, ABCD4, UBE4B, NMNAT1, CNTLN, PSIP1, SNAPC3
## Negative:  NUP88, RPAIN, RABEP1, ZNF594, C1QBP, ZNF232, DERL2, ZFP3, CAMTA2, MIS12
##     SPAG7, WSCD1, PFN1, TXNDC17, RNF167, SLC25A11, PLD2, C17orf100, PSMB6, CXCL16
##     XAF1, MED11, ARRB2, RNASEK, PELP1, MYBBP1A, UBE2G1, C17orf49, MARCH5, EXOC6
```

```
## Computing nearest neighbor graph
```

```
## Computing SNN
```

```
## Warning: Data is of class matrix. Coercing to dgCMatrix.
```

```
## Finding variable features for layer counts
```

```
## Centering and scaling data matrix
```

```
## PC_ 1
## Positive:  CHRNB1, NLGN2, ZBTB4, TMEM256, POLR2A, GPS2, EIF4A1, EIF5A, CTDNEP1, GABARAP
##     PHF23, DVL2, ACADVL, C17orf49, RNASEK, XAF1, ZNF594, RABEP1, C17orf100, ZNF232
##     NUP88, TXNDC17, RPAIN, DERL2, ZFP3, MIS12, C1QBP, WSCD1, CAMTA2, AMZ1
## Negative:  MRPL42, UBE2N, CRADD, EEA1, CCDC41, ACTR6, SCYL2, BTG1, TMCC3, ANO4
##     ATP2B1, NDUFA12, ARL1, NR2C1, GNPTAB, POC1B, CCDC53, NUP37, DUSP6, ASCL1
##     NT5DC3, C12orf29, HSP90B1, RSU1, STAM, C12orf73, FAM188A, NSUN6, CCDC59, ARL5B
## PC_ 2
## Positive:  PTPN1, ADNP, TMEM189, DPM1, UBE2V1, MOCS3, ATP9A, RNF114, ZFP64, BCAS1
##     SLC9A8, ZFAS1, ARFGEF2, PFDN4, CSE1L, ZNFX1, STAU1, DDX27, DOK5, CSTF1
##     RTFDC1, BMP7, RAE1, MTRNR2L3, VAPB, STX16, NPEPL1, ATP5J2, ZNF789, ZNF394
## Negative:  ING2, RWDD4, CDKN2AIP, AGA, TRAPPC11, SPCS3, STOX2, GPM6A, SH3D19, PET112
##     RPS3A, ARFIP1, TRIM2, FBXW7, KIAA0922, DCLK2, GLRA3, TLR2, PRMT10, ZKSCAN8
##     PLRG1, IRF2, TMEM184C, CTSO, SLC10A7, CEP44, LSM6, PDGFC, ZSCAN9, FBXO8
## PC_ 3
## Positive:  ATP6V1H, RB1CC1, TCEA1, PCMTD1, LYPLA1, UBE2V2, MRPL15, TMEM68, TGS1, ERLIN2
##     PROSC, DUSP26, BRF2, RNF122, RPS20, EIF4EBP1, MAK16, ASH2L, TTI2, FUT10
##     LSM1, CHCHD7, PPP2CB, BAG4, IMPAD1, DDHD2, ZCCHC8, UBXN8, CLIP1, VPS33A
## Negative:  TBK1, GNS, XPOT, LEMD3, C12orf66, LLPH, TMBIM4, CAND1, DYRK2, SRGAP1
##     MDM1, RAP1B, TMEM5, NUP107, NMI, RND3, RIF1, SLC35E3, PPM1H, MMADHC
##     KIF5C, ARL5A, EPC2, CACNB4, STAM2, MDM2, MON2, PAPOLA, VRK1, GSKIP
## PC_ 4
## Positive:  TRPC4AP, GSS, EDEM2, EIF6, ACSS2, CEP250, CPNE1, ERGIC3, GGT7, RBM12
##     NFS1, TP53INP2, ROMO1, NCOA6, RBM39, PIGU, PHF20, MAP1LC3A, DYNLRB1, SCAND1
##     ITCH, LINC00657, AHCY, EPB41L1, AAR2, EIF2S2, DLGAP4, RALY, C20orf24, PXMP4
## Negative:  GCC2, ST6GAL2, LIMS1, UXS1, RANBP2, NCK2, SEPT10, C2orf49, RGPD5, GPR45
##     LINC00116, MRPS9, MERTK, MAP4K4, RNF149, ZC3H8, RPL31, PDCL3, TTL, CHST10
##     AFF3, REV1, EIF5B, TXNDC9, MRPL30, MITD1, MGAT4A, LIPT1, NR1H3, ACP2
## PC_ 5
## Positive:  GOT1, SLC25A28, CUTC, COX15, DNMBP, HPS1, ERLIN1, CHUK, CWF19L1, BLOC1S2
##     SFXN2, WBP1L, SCD, ARL3, R3HCC1L, C10orf32, TRIM8, LINC00263, AS3MT, NT5C2
##     DCTPP1, LDB1, SEC31B, ACTR1A, PPRC1, NOLC1, GBF1, INA, FBXL15, TMEM180
## Negative:  MED28, DCAF16, LCORL, PACRGL, LAP3, DHX15, ANAPC4, QDPR, RBPJ, TBC1D19
##     TAPT1-AS1, ARAP2, RELL1, FAM200B, PGM2, FBXL5, KLF3, TLR1, CC2D2A, TMEM156
##     RAB28, KLHL5, WDR1, RFC1, RPL9, ACOX3, LIAS, SH3TC1, UGDH, UGDH-AS1
```

```
## Computing nearest neighbor graph
```

```
## Computing SNN
```

Basic ouput from running inferCNV.
![](data:image/png;base64...)

# 3 Additional Information

## 3.1 Online Documentation

For additional explanations on files, usage, and a tutorial please visit the [wiki](https://github.com/broadinstitute/inferCNV/wiki).

## 3.2 TrinityCTAT

This tool is a part of the TrinityCTAT toolkit focused on leveraging the use of RNA-Seq to better understand cancer transcriptomes. To find out more please visit [TrinityCTAT](https://github.com/NCIP/Trinity_CTAT/wiki)

## 3.3 Applications

This methodology was used in:

[Anoop P. Patel et al. Single-cell RNA-seq highlights intratumoral heterogeneity in primary glioblastoma. Science. 2014 Jun 20: 1396-1401](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4123637/)

[Tirosh I et al.Dissecting the multicellular ecosystem of metastatic melanoma by single-cell RNA-seq. Science. 2016 Apr 8;352(6282):189-96](http://www.ncbi.nlm.nih.gov/pubmed/27124452)

# 4 Session info

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] future_1.67.0    infercnv_1.26.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RcppAnnoy_0.0.22            splines_4.5.1
##   [3] later_1.4.4                 bitops_1.0-9
##   [5] tibble_3.3.0                polyclip_1.10-7
##   [7] fastDummies_1.7.5           lifecycle_1.0.4
##   [9] fastcluster_1.3.0           edgeR_4.8.0
##  [11] doParallel_1.0.17           globals_0.18.0
##  [13] lattice_0.22-7              MASS_7.3-65
##  [15] magrittr_2.0.4              limma_3.66.0
##  [17] plotly_4.11.0               sass_0.4.10
##  [19] rmarkdown_2.30              jquerylib_0.1.4
##  [21] yaml_2.3.10                 httpuv_1.6.16
##  [23] otel_0.2.0                  Seurat_5.3.1
##  [25] sctransform_0.4.2           spam_2.11-1
##  [27] sp_2.2-0                    spatstat.sparse_3.1-0
##  [29] reticulate_1.44.0           cowplot_1.2.0
##  [31] pbapply_1.7-4               RColorBrewer_1.1-3
##  [33] multcomp_1.4-29             abind_1.4-8
##  [35] Rtsne_0.17                  GenomicRanges_1.62.0
##  [37] purrr_1.1.0                 BiocGenerics_0.56.0
##  [39] TH.data_1.1-4               sandwich_3.1-1
##  [41] IRanges_2.44.0              S4Vectors_0.48.0
##  [43] ggrepel_0.9.6               irlba_2.3.5.1
##  [45] listenv_0.9.1               spatstat.utils_3.2-0
##  [47] goftest_1.2-3               RSpectra_0.16-2
##  [49] spatstat.random_3.4-2       fitdistrplus_1.2-4
##  [51] parallelly_1.45.1           codetools_0.2-20
##  [53] coin_1.4-3                  DelayedArray_0.36.0
##  [55] tidyselect_1.2.1            futile.logger_1.4.3
##  [57] farver_2.1.2                rjags_4-17
##  [59] matrixStats_1.5.0           stats4_4.5.1
##  [61] spatstat.explore_3.5-3      Seqinfo_1.0.0
##  [63] jsonlite_2.0.0              progressr_0.17.0
##  [65] ggridges_0.5.7              survival_3.8-3
##  [67] iterators_1.0.14            foreach_1.5.2
##  [69] tools_4.5.1                 ica_1.0-3
##  [71] Rcpp_1.1.0                  glue_1.8.0
##  [73] gridExtra_2.3               SparseArray_1.10.0
##  [75] xfun_0.53                   MatrixGenerics_1.22.0
##  [77] dplyr_1.1.4                 formatR_1.14
##  [79] BiocManager_1.30.26         fastmap_1.2.0
##  [81] caTools_1.18.3              digest_0.6.37
##  [83] parallelDist_0.2.7          R6_2.6.1
##  [85] mime_0.13                   scattermore_1.2
##  [87] gtools_3.9.5                tensor_1.5.1
##  [89] dichromat_2.0-0.1           spatstat.data_3.1-9
##  [91] tidyr_1.3.1                 generics_0.1.4
##  [93] data.table_1.17.8           httr_1.4.7
##  [95] htmlwidgets_1.6.4           S4Arrays_1.10.0
##  [97] uwot_0.2.3                  pkgconfig_2.0.3
##  [99] gtable_0.3.6                modeltools_0.2-24
## [101] lmtest_0.9-40               S7_0.2.0
## [103] SingleCellExperiment_1.32.0 XVector_0.50.0
## [105] htmltools_0.5.8.1           dotCall64_1.2
## [107] bookdown_0.45               SeuratObject_5.2.0
## [109] scales_1.4.0                Biobase_2.70.0
## [111] png_0.1-8                   phyclust_0.1-34
## [113] spatstat.univar_3.1-4       knitr_1.50
## [115] lambda.r_1.2.4              reshape2_1.4.4
## [117] coda_0.19-4.1               nlme_3.1-168
## [119] cachem_1.1.0                zoo_1.8-14
## [121] stringr_1.5.2               KernSmooth_2.23-26
## [123] parallel_4.5.1              miniUI_0.1.2
## [125] libcoin_1.0-10              pillar_1.11.1
## [127] grid_4.5.1                  vctrs_0.6.5
## [129] gplots_3.2.0                RANN_2.6.2
## [131] promises_1.4.0              xtable_1.8-4
## [133] cluster_2.1.8.1             evaluate_1.0.5
## [135] mvtnorm_1.3-3               cli_3.6.5
## [137] locfit_1.5-9.12             compiler_4.5.1
## [139] futile.options_1.0.1        rlang_1.1.6
## [141] future.apply_1.20.0         argparse_2.3.1
## [143] plyr_1.8.9                  stringi_1.8.7
## [145] viridisLite_0.4.2           deldir_2.0-4
## [147] lazyeval_0.2.2              spatstat.geom_3.6-0
## [149] Matrix_1.7-4                RcppHNSW_0.6.0
## [151] patchwork_1.3.2             ggplot2_4.0.0
## [153] statmod_1.5.1               shiny_1.11.1
## [155] SummarizedExperiment_1.40.0 ROCR_1.0-11
## [157] igraph_2.2.1                RcppParallel_5.1.11-1
## [159] bslib_0.9.0                 ape_5.8-1
```