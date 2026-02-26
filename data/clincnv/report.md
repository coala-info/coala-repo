# clincnv CWL Generation Report

## clincnv_clinCNV.R

### Tool Description
Run the clinCNV R script. Requires absolute paths for input files. At least normal coverages and a BED file path must be specified.

### Metadata
- **Docker Image**: quay.io/biocontainers/clincnv:1.19.1--hdfd78af_0
- **Homepage**: https://github.com/imgag/ClinCNV
- **Package**: https://anaconda.org/channels/bioconda/packages/clincnv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clincnv/overview
- **Total Downloads**: 342
- **Last updated**: 2025-09-16
- **GitHub**: https://github.com/imgag/ClinCNV
- **Stars**: N/A
### Original Help Text
```text
[1] "We run script located in folder /usr/local/bin/clincnv . Please, specify ABSOLUTE paths, relative paths do not work for every machine. If everything crashes, please, check the correctness of this path first."
[1] "You need to specify file with normal coverages and bed file path at least. Here is the help:"
Usage: /usr/local/bin/clincnv/clinCNV.R [options]


Options:
	--normal=NORMAL
		path to table with normal coverages

	--tumor=TUMOR
		path to table with tumor coverages

	--normalOfftarget=NORMALOFFTARGET
		path to table with normal offtarget coverages

	--tumorOfftarget=TUMOROFFTARGET
		path to table with tumor offtarget coverages

	--out=OUT
		output folder path [default= ./result/]

	--pair=PAIR
		file with pairing information, 1st column = tumor, 2nd column = normal [default= pairs.txt]

	--bed=BED
		bed file with panel description (chr 	 start 	 end 	 gc_content 	 annotation). has to use same notation as .cov files.

	--bedOfftarget=BEDOFFTARGET
		offtarget bed file with panel description (chr 	 start 	 end 	 gc_content 	 annotation). has to use same notation as .cov files.

	--colNum=COLNUM
		column where coverages start

	--folderWithScript=FOLDERWITHSCRIPT
		folder where you put script

	--reanalyseCohort
		if specified, reanalyses whole cohort [default= NULL]

	--scoreG=SCOREG
		minimum threshold for significance germline variants

	--lengthG=LENGTHG
		minimum threshold for length of germline variants

	--scoreS=SCORES
		minimum threshold for significance somatic variants

	--lengthS=LENGTHS
		minimum threshold for length of somatic variants

	--maxNumGermCNVs=MAXNUMGERMCNVS
		maximum number of germline CNVs allowed (increase thresholds if does not meet criteria)

	--maxNumSomCNAs=MAXNUMSOMCNAS
		maximum number of somatic CNAs allowed (increase thresholds if does not meet criteria)

	--maxNumIter=MAXNUMITER
		maximum number of iterations of variant calling

	--bafFolder=BAFFOLDER
		folder where you put BAF frequencies (one per normal, one per tumor sample)

	--normalSample=NORMALSAMPLE
		name of normal sample to analyse (if only one sample has to be analysed)

	--tumorSample=TUMORSAMPLE
		name of tumor sample to analyse (if only one sample has to be analysed, normal has to be provided too)

	--triosFile=TRIOSFILE
		file with information about trios, child-father-mother

	--fdrGermline=FDRGERMLINE
		number of iterations for FDR check (more - better, but slower, 0 = no FDR correction)

	--numberOfThreads=NUMBEROFTHREADS
		number of threads used for some bottleneck parts, default=1

	--minimumNumOfElemsInCluster=NUMBER
		minimum number of elements in cluster (done for germline), default=100, clustering happens only if number of samples bigger than 3 by number of elements in cluster

	--visulizationIGV
		if you dont need IGV tracks as output, specify this flag (as printing out IGV tracks slows down the program)

	--clonePenalty=CLONEPENALTY
		penalty for each additional clone (if you feel that you have some false positive clones, increase this value from default 300)

	--purityStep=NUMBER
		step of purity we investigate (from 5% to 100% with the step you specify, default=2.5)

	--degreesOfFreedomStudent=DEGREESOFFREEDOMSTUDENT
		number of degrees of freedom of Student's distribution for somatic analysis (a lot of outliers => reduce the default value of 1000 to e.g. 10)

	--polymorphicCalling=POLYMORPHICCALLING
		should calling of polymorphic regions be performed, YES = calling is performed, NO = no polymorphic calling (default), any other string = mCNVs taken from the file with that path (it must have at least 3 columns chrom-start-end)

	--mosaicism
		if mosaic calling should be performed

	--minimumPurity=MINIMUMPURITY
		minimum purity for somatic samples

	--superRecall=SUPERRECALL
		Super recall mode - after calling normal CNVs it tries to find CNVs with any length that are better than pre-specified threshold

	--clonalityForChecking=CLONALITYFORCHECKING
		Starting from which clonality BAF-based QC-control has to be applied (no allelic balanced variants with smaller purity will be detected!)

	--shiftToTry=SHIFTTOTRY
		change only if you have a sample with lots of allelic imbalance (if you think that the diploid baseline should be different, number of options for choosing will be provided during calling)

	--filterStep=FILTERSTEP
		This value indicates if ClinCNV should perform QC internally (starting from threshold specified by --clonalityForChecking). Value 0 means no, value 1 - only for finding clonality, value 2 - for clonality and final calls too

	--guideBaseline=GUIDEBASELINE
		For complex samples with potential whole-genome duplication - string denoting which region you suspect to be diploid so tool will take it is a baseline (format chrN:12345-67890)

	--notComplexTumor
		Sometimes some CNAs happen in the same region twice and leave the signature unrecognizable by simple models. Specify this flag if you don't want the 2nd CNAs to be recognized by ClinCNV.

	--pnealtyHigherCopy=PNEALTYHIGHERCOPY
		How big should be penalty for higher copy? This is penalty for each additional copy, one per CNV. (smaller values: more big copy-number allowed, lower clonal cancer cell fraction)

	--pnealtyHigherCopyOneSegment=PNEALTYHIGHERCOPYONESEGMENT
		How big should be penalty for higher copy? This is penalty for each additional copy, one per region in CNV. (smaller values: more big copy-number allowed, lower clonal cancer cell fraction)

	--par=PAR
		coordinates of chrX paralogous regions (format chrX:60001-2699520;chrX:154931044-155260560 )

	--sex=SEX
		override the sample's gender (active only when you specify --normalSample flag)

	--clusterProvided=CLUSTERPROVIDED
		Use external clustering (file with lines, sample ID 	 cluster ID

	--maximumSomaticCN=MAXIMUMSOMATICCN
		The highest allowed somatic copy-number (higher = more accurate, but slower), [default= 30]

	--onlyTumor
		if tumor only calling is to be performed

	--noPlot
		Do not perform additional plotting

	--hg38
		Work with hg38 cytobands switch

	--polymorphicGenotyping=POLYMORPHICGENOTYPING
		should genotyping of polymorphic regions be performed, YES = genotyping is performed, NO = no genotyping. The BED file with polymorphic regions should be supplied via --polymorphicCalling command!

	--panelGC
		Remove less GC extreme regions, useful for panels, almost does not effect for genomes

	-d, --debug
		Print debugging information while running.

	-h, --help
		Show this help message and exit
```

