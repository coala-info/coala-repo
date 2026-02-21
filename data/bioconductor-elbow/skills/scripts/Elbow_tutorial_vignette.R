# Code example from 'Elbow_tutorial_vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'Elbow_tutorial_vignette.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: analyze_excel
###################################################
    # load the ELBOW library
    library("ELBOW")
	
    # Set the filename (change everything after the <- to ``csv_file'',
    # where csv_file is the filename of your CSV data file)
    filename <- system.file("extdata", "EcoliMutMA.csv", package = "ELBOW")
	
    # Read in your CSV file
    csv_data <- read.csv(filename)

    # set the number of initial and final condition replicates both to three
    init_count  <- 3
    final_count <- 3

    # Parse the probes, intial conditions and final conditions
    # out of the CSV file.  Please see: extract_working_sets
    # for more information.
    #
    # init_count should be the number of columns associated with
    #       the initial conditions of the experiment.
    # final_count should be the number of columns associated with
    #       the final conditions of the experiment.
    working_sets <- extract_working_sets(csv_data, init_count, final_count)

    probes <- working_sets[[1]]
    initial_conditions <- working_sets[[2]]
    final_conditions <- working_sets[[3]]

    # Uncomment to output the plot to a PNG file (optional)
    # png(file="output_plot.png")

    # Analyze the elbow curve.
    sig <- analyze_elbow(probes, initial_conditions, final_conditions)
    
    # uncomment to write the significant probes to 'signprobes.csv'
    #write.table(sig,file="signprobes.csv",sep=",",row.names=FALSE)


###################################################
### code chunk number 2: load_limmma
###################################################
	####
	# Uncomment the lines below to install the necessary libraries:
	####
	#if (!requireNamespace("BiocManager", quietly=TRUE))
    	#install.packages("BiocManager")
	#BiocManager::install("GEOquery")
	#BiocManager::install("simpleaffy")
	#BiocManager::install("limma")
	#BiocManager::install("affyPLM")
	#BiocManager::install("RColorBrewer")
	####
	
	# retrieve the data from GEO
	library("GEOquery")
	getGEOSuppFiles("GSE20986")
	untar("GSE20986/GSE20986_RAW.tar", exdir="data")
	cels <- list.files("data/", pattern = "[gz]")
	sapply(paste("data", cels, sep="/"), gunzip)
	
	# reading in the CEL data into R (w/simpleaffy)
	library("simpleaffy")
	pheno_data <- data.frame(
		c(    # Name
			"GSM524662.CEL", "GSM524663.CEL", "GSM524664.CEL",
			"GSM524665.CEL", "GSM524666.CEL", "GSM524667.CEL",
			"GSM524668.CEL", "GSM524669.CEL", "GSM524670.CEL",
			"GSM524671.CEL", "GSM524672.CEL", "GSM524673.CEL"),
		c(    # FileName
			"GSM524662.CEL", "GSM524663.CEL", "GSM524664.CEL",
			"GSM524665.CEL", "GSM524666.CEL", "GSM524667.CEL",
			"GSM524668.CEL", "GSM524669.CEL", "GSM524670.CEL",
			"GSM524671.CEL", "GSM524672.CEL", "GSM524673.CEL"),
		c(    # Target
			"iris", "retina", "retina",
			"iris", "retina", "iris",
			"choroid", "choroid", "choroid",
			"huvec", "huvec", "huvec")
		)
	colnames(pheno_data) <- c("Name", "FileName", "Target")
	write.table(pheno_data, "data/phenodata.txt", row.names=FALSE, quote=FALSE)
	celfiles <- read.affy(covdesc="phenodata.txt", path="data")
	
	# normalizing the data
	celfiles.gcrma <- gcrma(celfiles)


###################################################
### code chunk number 3: limma_chip_qc
###################################################
	########
	# quality control checks (chip-level)
	########
	# load colour libraries
	library("RColorBrewer")
	
	# set colour palette
	cols <- brewer.pal(8, "Set1")
	
	# plot a boxplot of unnormalised intensity values
	boxplot(celfiles, col=cols)
	
	# plot a boxplot of normalised intensity values, affyPLM is required to interrogate celfiles.gcrma
	library("affyPLM")
	boxplot(celfiles.gcrma, col=cols)
	
	# the boxplots are somewhat skewed by the normalisation algorithm
	# and it is often more informative to look at density plots
	# Plot a density vs log intensity histogram for the unnormalised data
	hist(celfiles, col=cols)
	
	# Plot a density vs log intensity histogram for the normalised data
	hist(celfiles.gcrma, col=cols)
	########


###################################################
### code chunk number 4: limma_probe_qc
###################################################
		########
		# quality control checks (probe-level)
		########
		# Perform probe-level metric calculations on the CEL files:
		celfiles.qc <- fitPLM(celfiles)
		
		# Create an image of GSM24662.CEL:
		image(celfiles.qc, which=1, add.legend=TRUE)
		
		# Create an image of GSM524665.CEL
		# There is a spatial artifact present
		image(celfiles.qc, which=4, add.legend=TRUE)
		
		# affyPLM also provides more informative boxplots
		# RLE (Relative Log Expression) plots should have
		# values close to zero. GSM524665.CEL is an outlier
		RLE(celfiles.qc, main="RLE")
		
		# We can also use NUSE (Normalised Unscaled Standard Errors).
		# The median standard error should be 1 for most genes.
		# GSM524665.CEL appears to be an outlier on this plot too
		NUSE(celfiles.qc, main="NUSE")#'
		########


###################################################
### code chunk number 5: limma_sample_qc
###################################################
	########
	# quality control checks (sample vs. sample)
	########
	eset <- exprs(celfiles.gcrma)
	distance <- dist(t(eset),method="maximum")
	clusters <- hclust(distance)
	plot(clusters)
	########


###################################################
### code chunk number 6: limma_data_filter
###################################################
	########
	# data filtering
	########
	celfiles.filtered <- nsFilter(celfiles.gcrma, require.entrez=FALSE, remove.dupEntrez=FALSE)
	# What got removed and why?
	celfiles.filtered$filter.log


###################################################
### code chunk number 7: limma_extract_diffexp
###################################################
	########
	# Finding differentially expressed probesets
	########
	samples <- celfiles.gcrma$Target

	# check the results of this
	#samples

	# convert into factors
	samples <- as.factor(samples)

	# check factors have been assigned
	#samples

	# set up the experimental design
	design <- model.matrix(~0 + samples)
	colnames(design) <- c("choroid", "huvec", "iris", "retina")

	# inspect the experiment design
	#design


###################################################
### code chunk number 8: feed_limma
###################################################
	########
	# feed the data into limma for analysis
	########
	library("limma")

	# fit the linear model to the filtered expression set
	fit <- lmFit(exprs(celfiles.filtered$eset), design)

	# set up a contrast matrix to compare tissues v cell line
	contrast.matrix <- makeContrasts(huvec_choroid = huvec - choroid, huvec_retina = huvec - retina, huvec_iris <- huvec - iris, levels=design)

	# Now the contrast matrix is combined with the per-probeset linear model fit.
	huvec_fits <- contrasts.fit(fit, contrast.matrix)
	huvec_ebFit <- eBayes(huvec_fits)


###################################################
### code chunk number 9: elbow_limma
###################################################
	# load the ELBOW library
	library("ELBOW")

	# find the ELBOW limits	
	get_elbow_limma(huvec_ebFit)


###################################################
### code chunk number 10: load_deseq
###################################################
	# load the ELBOW library
	library("ELBOW")
	
	# install the DESeq libraries
	#if (!requireNamespace("BiocManager", quietly=TRUE))
    	#install.packages("BiocManager")
	#BiocManager::install("DESeq")

	## download the table
	library("DESeq")
	
	# the following bam file dataset was obtained from:
	# http://cgrlucb.wikispaces.com/file/view/yeast_sample_data.txt
	# it has been downloaded into this package for speed convenience.
	filename <- system.file("extdata", "yeast_sample_data.txt", package = "ELBOW")
	
	count_table <- read.table(filename, header=TRUE, sep="\t", row.names=1)
	expt_design <- data.frame(row.names = colnames(count_table), condition = c("WE","WE","M","M","M"))
	conditions = expt_design$condition
	rnadata <- newCountDataSet(count_table, conditions)
	rnadata <- estimateSizeFactors(rnadata)
	rnadata <- as(rnadata, "CountDataSet")
	## rnadata <- estimateVarianceFunctions(rnadata)
	rnadata <- estimateDispersions(rnadata)
	
	# this next step is essential, but it takes a long time...
	results <- nbinomTest(rnadata, "M", "WE")


###################################################
### code chunk number 11: get_elbow_deseq
###################################################
	limits <- do_elbow_rnaseq(results)


###################################################
### code chunk number 12: plot_elbow_deseq
###################################################
	# plot the results w/elbow
	plot_dataset(results, "log2FoldChange", limits$up_limit, limits$low_limit)


