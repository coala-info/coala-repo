# Code example from 'esetVis-vignette' vignette. See references/ for full tutorial.

## ----options, echo = FALSE----------------------------------------------------------------------------------------------------------------------------------------------
	
	library(knitr)
	opts_chunk$set(echo = TRUE, results = 'asis', warning = FALSE, 
		error = FALSE, message = FALSE, cache = FALSE,
		fig.width = 8, fig.height = 7,
		#out.width = '0.7\\textwidth', 
		fig.align = 'center')#, out.height = 0.5\\textwidth', fig.path = 'graphs/') 
	options(width = 170)#, stringsAsFactors = FALSE
	options(warn = 1)#instead of warn = 0 by default -> to have place where warnings occur in the call to Sweave function
	

## ----loadLibraries, results = 'hide', echo = FALSE----------------------------------------------------------------------------------------------------------------------

	library(esetVis)
#	library(xtable)
	library(pander)


## ----ALL-loadAndFormatAllDataset----------------------------------------------------------------------------------------------------------------------------------------

	library(ALL)
	data(ALL)
	
	# to get gene annotation from probe IDs (from the paper HGU95aV2 gene chip was used)
	library("hgu95av2.db")
	library("AnnotationDbi")
	probeIDs <- featureNames(ALL)
	geneInfo <- AnnotationDbi::select(hgu95av2.db, probeIDs, 
		c("ENTREZID", "SYMBOL", "GENENAME"), "PROBEID")
	# 482 on the 12625 probe IDs don't have ENTREZ ID/SYMBOL/GENENAME

	# remove genes with duplicated annotation: 1214
	geneInfoWthtDuplicates <- geneInfo[!duplicated(geneInfo$PROBEID), ]

	# remove genes without annotation: 482
	genesWthtAnnotation <- rowSums(is.na(geneInfoWthtDuplicates)) > 0
	geneInfoWthtDuplicatesAndWithAnnotation <- geneInfoWthtDuplicates[!genesWthtAnnotation, ]
	
	probeIDsWithAnnotation <- featureNames(ALL)[featureNames(ALL) %in% 
		geneInfoWthtDuplicatesAndWithAnnotation$PROBEID]
	ALL <- ALL[probeIDsWithAnnotation, ]
	
	fData <- geneInfoWthtDuplicatesAndWithAnnotation[
		match(probeIDsWithAnnotation, geneInfoWthtDuplicatesAndWithAnnotation$PROBEID), ]
	rownames(fData) <- probeIDsWithAnnotation
	fData(ALL) <- fData

	# grouping variable: B = B-cell, T = T-cell
	groupingVariable <- pData(ALL)$BT
	
	# create custom palette
	colorPalette <- c("dodgerblue", 
		colorRampPalette(c("white","dodgerblue2", "darkblue"))(5)[-1], 
		"red", colorRampPalette(c("white", "red3", "darkred"))(5)[-1])
	names(colorPalette) <- levels(groupingVariable)
	color <- groupingVariable; levels(color) <- colorPalette
	
	# reformat type of the remission
	remissionType <- ifelse(is.na(ALL$remission), "unknown", as.character(ALL$remission))
	ALL$remissionType <- factor(remissionType,
		levels = c("unknown", "CR", "REF"), 
		labels = c("unknown", "achieved", "refractory"))


## ----ALL-loadAndFormatAllDataset-extraNotes, echo = FALSE---------------------------------------------------------------------------------------------------------------

	fvarMetadata(ALL)$labelDescription <- paste(rownames(fvarMetadata(ALL)),
		"obtained from the Bioconductor hgu95av2.db package")	


## ----rmAnnotObjectsFromMemory, echo = FALSE-----------------------------------------------------------------------------------------------------------------------------

	rm(list = c("fData", ls(pattern = "^(geneInfo|probeIDs)")));tmp <- gc(verbose = FALSE)
	#for testing: sort(sapply(ls(), function(x) object.size(get(x))))


## ----ALL-someDataCharacteristics, echo = FALSE--------------------------------------------------------------------------------------------------------------------------

	varLabelsUsed <- c("cod", "sex", "age", "BT", "remissionType")
	pander(head(pData(ALL)[, varLabelsUsed]),
		caption = "subset of the **phenoData** of the ALL dataset for the first genes")
	
	pander(head(fData(ALL)), 
        caption = "**featureData** of the ALL dataset for the first genes")


## ----ALL-esetSimple-----------------------------------------------------------------------------------------------------------------------------------------------------

	print(esetSpectralMap(eset = ALL))


## ----ALL-esetSampleAnnotation1------------------------------------------------------------------------------------------------------------------------------------------

	print(esetSpectralMap(eset = ALL, 
		title = "Acute lymphoblastic leukemia dataset \n Spectral map \n Sample annotation (1)",
		colorVar = "BT", color = colorPalette,
		shapeVar = "sex", 
		sizeVar = "age", sizeRange = c(0.1, 6),
		alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
		topSamples = 0, topGenes = 0, cloudGenes = TRUE))


## ----ALL-esetSampleAnnotation2, fig.height = 8--------------------------------------------------------------------------------------------------------------------------

	gg <- esetSpectralMap(eset = ALL, 
		title = "Acute lymphoblastic leukemia dataset \n Spectral map \n Sample annotation (2)",
		colorVar = "age",
		shapeVar = "BT", shape = 15+1:nlevels(ALL$BT),
		sizeVar = "remissionType", size = c(2, 4, 6),
		alphaVar = "age", alphaRange = c(0.2, 0.8),
		topSamples = 0, topGenes = 0, cloudGenes = TRUE)
	# change color of gradient
	library(ggplot2)
	gg <- gg + scale_color_gradientn(colours = 
		colorRampPalette(c("darkgreen", "gold"))(2)
	)
	print(gg)


## ----ALL-customGeneRepresentation---------------------------------------------------------------------------------------------------------------------------------------

	print(esetSpectralMap(eset = ALL,
		psids = 1:1000,
		title = "Acute lymphoblastic leukemia dataset \n Spectral map \n Custom cloud genes",
		topSamples = 0, topGenes = 0, 
		cloudGenes = TRUE, cloudGenesColor = "red", cloudGenesNBins = 50,
		cloudGenesIncludeLegend = TRUE, cloudGenesTitleLegend = "number of features"))


## ----ALL-genesSamplesAnnotation-----------------------------------------------------------------------------------------------------------------------------------------

	print(esetSpectralMap(eset = ALL, 
		title = paste("Acute lymphoblastic leukemia dataset \n",
			"Spectral map \n Label outlying samples and genes"),
		colorVar = "BT", color = colorPalette,
		shapeVar = "sex",
		sizeVar = "age", sizeRange = c(2, 6),
		alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
		topGenes = 10, topGenesVar = "SYMBOL",
		topGenesCex = 2, topGenesColor = "darkgrey",
		topSamples = 15, topSamplesVar = "cod", topSamplesColor = "chocolate4",
		topSamplesCex = 3
	))


## ----ALL-extractGeneSets------------------------------------------------------------------------------------------------------------------------------------------------

	geneSets <- getGeneSetsForPlot(
		entrezIdentifiers = fData(ALL)$ENTREZID, 
		species = "Human", 
		geneSetSource = 'GOBP',
		useDescription = TRUE)


## ----ALL-geneSetAnnotation----------------------------------------------------------------------------------------------------------------------------------------------

	print(esetSpectralMap(eset = ALL, 
		title = "Acute lymphoblastic leukemia dataset \n Spectral map \n Gene set annotation",
		colorVar = "BT", color = colorPalette,
		shapeVar = "sex",
		sizeVar = "age", sizeRange = c(2, 6),
		alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
		topGenes = 0,
		topGeneSets = 4, geneSets = geneSets, geneSetsVar = "ENTREZID", geneSetsMaxNChar = 30,
		topGeneSetsCex = 2, topGeneSetsColor = "purple"))


## ----rmGeneSetsFromMemory, echo = FALSE---------------------------------------------------------------------------------------------------------------------------------

	rm(geneSets);tmp <- gc(verbose = FALSE)


## ----ALL-dimensionsBiPlot-----------------------------------------------------------------------------------------------------------------------------------------------

	print(esetSpectralMap(eset = ALL, 
		title = "Acute lymphoblastic leukemia dataset \n Spectral map \n Dimensions of the PCA",
		colorVar = "BT", color = colorPalette,
		shapeVar = "sex",
		sizeVar = "age", sizeRange = c(0.5, 4),
		alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
		dim = c(3, 4)))


## ----ALL-interactivePlot-plotly-----------------------------------------------------------------------------------------------------------------------------------------
esetSpectralMap(
	eset = ALL,
	title = paste("Acute lymphoblastic leukemia dataset - spectral map"),
	colorVar = "BT", color = unname(colorPalette),
	shapeVar = "sex",
	alphaVar = "remissionType",
	typePlot = "interactive", packageInteractivity = "plotly",
	figInteractiveSize = c(700, 600),
	topGenes = 10, topGenesVar = "SYMBOL",
	topSamples = 10,
	# use all sample variables for hover
	interactiveTooltipExtraVars = varLabels(ALL)
)

## ----ALL-interactivePlot-ggvis, cache = FALSE---------------------------------------------------------------------------------------------------------------------------
library(ggvis)

# embed a static version of the plot
esetSpectralMap(
	eset = ALL,
	title = paste("Acute lymphoblastic leukemia dataset - spectral map"),
	colorVar = "BT", color = unname(colorPalette),
	shapeVar = "sex",
	alphaVar = "remissionType",
	typePlot = "interactive", packageInteractivity = "ggvis",
	figInteractiveSize = c(700, 600),
	sizeVar = "age", sizeRange = c(2, 6),
	# use all phenoData variables for hover
	interactiveTooltipExtraVars = varLabels(ALL)
)

## ----ALL-tsne-----------------------------------------------------------------------------------------------------------------------------------------------------------

	print(esetTsne(eset = ALL, 
		title = "Acute lymphoblastic leukemia dataset \n Tsne",
		colorVar = "BT", color = colorPalette,
		shapeVar = "sex",
		sizeVar = "age", sizeRange = c(2, 6),
		alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
		topSamplesVar = "cod"
	))


## ----ALL-tsne-preProcessing---------------------------------------------------------------------------------------------------------------------------------------------

	print(esetTsne(eset = ALL, 
		title = "Acute lymphoblastic leukemia dataset \n Tsne",
		colorVar = "BT", color = colorPalette,
		shapeVar = "sex",
		sizeVar = "age", sizeRange = c(2, 6),
		alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
		topSamplesVar = "cod",
		fctTransformDataForInputTsne = 
			function(mat)	as.dist((1 - cor(mat))/2)
	))


## ----ALL-Lda, fig.keep = 'first'----------------------------------------------------------------------------------------------------------------------------------------

	# extract random features, because analysis is quite time consuming
	retainedFeatures <- sample(featureNames(ALL), size = floor(nrow(ALL)/5))
	
	# run the analysis
	outputEsetLda <- esetLda(eset = ALL[retainedFeatures, ], ldaVar = "BT",
		title = paste("Acute lymphoblastic leukemia dataset \n",
			"Linear discriminant analysis on BT variable \n",
			"(Subset of the feature data)"),
		colorVar = "BT", color = colorPalette,
		shapeVar = "sex",
		sizeVar = "age", sizeRange = c(2, 6),
		alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
		topSamplesVar = "cod", topGenesVar = "SYMBOL",
		returnAnalysis = TRUE
	)

	# extract and print the ggplot object
	print(outputEsetLda$plot)

## ----ALL-Lda-topElements------------------------------------------------------------------------------------------------------------------------------------------------

	# extract top elements labelled in the plot
	pander(t(data.frame(topGenes = outputEsetLda$topElements[["topGenes"]])))
	pander(t(data.frame(topSamples = outputEsetLda$topElements[["topSamples"]])))


## ----ALL-Lda-changeSomeParameters---------------------------------------------------------------------------------------------------------------------------------------

	# to change some plot parameters
	esetPlotWrapper(
		dataPlotSamples = outputEsetLda$analysis$dataPlotSamples,
		dataPlotGenes = outputEsetLda$analysis$dataPlotGenes,
		esetUsed = outputEsetLda$analysis$esetUsed,
		title = paste("Acute lymphoblastic leukemia dataset \n",
			"Linear discriminant analysis on BT variable (2) \n",
			"(Subset of the feature data)"),
		colorVar = "BT", color = colorPalette,
		shapeVar = "remissionType", 
		sizeVar = "age", sizeRange = c(2, 6),
		alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
		topSamplesVar = "cod", topGenesVar = "SYMBOL"
	)


## ----rmOutputEsetLdaFromMemory, echo = FALSE----------------------------------------------------------------------------------------------------------------------------

	rm(outputEsetLda);tmp <- gc(verbose = FALSE)


## ----ALL-Lda-BcellOnly--------------------------------------------------------------------------------------------------------------------------------------------------

	# keep only 'B-cell' samples
	ALLBCell <- ALL[, grep("^B", ALL$BT)]
	ALLBCell$BT <- factor(ALLBCell$BT)
	colorPaletteBCell <- colorPalette[1:nlevels(ALLBCell$BT )]
	
	print(esetLda(eset = ALLBCell[retainedFeatures, ], ldaVar = "BT",
		title = paste("Acute lymphoblastic leukemia dataset \n",
			"Linear discriminant analysis on BT variable \n B-cell only",
			"(Subset of the feature data)"
		),
		colorVar = "BT", color = colorPaletteBCell,
		shapeVar = "sex",
		sizeVar = "age", sizeRange = c(2, 6),
		alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
		topSamplesVar = "cod", topGenesVar = "SYMBOL",
	))


## ----rmALLBCellFromMemory, echo = FALSE---------------------------------------------------------------------------------------------------------------------------------

	rm(ALLBCell);tmp <- gc(verbose = FALSE)


