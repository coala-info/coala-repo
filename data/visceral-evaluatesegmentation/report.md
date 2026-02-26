# visceral-evaluatesegmentation CWL Generation Report

## visceral-evaluatesegmentation_EvaluateSegmentation

### Tool Description
Evaluate a segmentation against a ground truth.

### Metadata
- **Docker Image**: quay.io/biocontainers/visceral-evaluatesegmentation:2021.03.25--h287ed61_0
- **Homepage**: https://github.com/Visceral-Project/EvaluateSegmentation
- **Package**: https://anaconda.org/channels/bioconda/packages/visceral-evaluatesegmentation/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/visceral-evaluatesegmentation/overview
- **Total Downloads**: 12.2K
- **Last updated**: 2025-09-22
- **GitHub**: https://github.com/Visceral-Project/EvaluateSegmentation
- **Stars**: N/A
### Original Help Text
```text
USAGE:

1) For volume segmentation:

EvaluateSegmentation groundtruthPath segmentPath [-thd threshold] [-xml xmlpath] [-unit millimeter|voxel] [-use all|fast|DICE,JACRD,....]

where:
groundtruthPath	=path (or URL) to groundtruth image. URLs should be enclosed with quotations
segmentPath	=path (or URL) to image beeing evaluated. URLs should be enclosed with quotations
-thd	=before evaluation convert fuzzy images to binary using threshold
-xml	=path to xml file where result should be saved
-nostreaming	=Don't use streaming filter! Streaming filter is used to handle very large images. Use this option with small images (up to 200X200X200 voxels) to avoid time efort related with streaming.
-help	=more information
-unit	=specify whether millimeter or voxel to be used as a unit for distances and  volumes (default is voxel)
-use	=the metrics to be used. Note that additional options can be given between two @ characters:

	all	:use all available metrics (default)
	DICE	:Dice Coefficient (F1-Measure)
	JACRD	:Jaccard Coefficient
	AUC	:Area under ROC Curve
	KAPPA	:Cohen Kappa
	RNDIND	:Rand Index
	ADJRIND	:Adjusted Rand Index
	ICCORR	:Interclass Correlation
	VOLSMTY	:Volumetric Similarity Coefficient
	MUTINF	:Mutual Information
	MAHLNBS	:Mahanabolis Distance
	AVGDIST	:Average Hausdorff Distance
	bAVD	:Balanced Average Hausdorff Distance (new proposed metric, publication submitted)
	HDRFDST	:Hausdorff Distance, HDRFDST@0.95@ -> use 0.95 quantile to avoid outlier, default 1 (=exact distance)
	VARINFO	:Variation of Information
	GCOERR	:Global Consistency Error
	PROBDST	:Probabilistic Distance
	SNSVTY	:Sensitivity (Recall, true positive rate)
	SPCFTY	:Specificity (true negative rate)
	PRCISON	:Precision (Confidence)
	FMEASR	:F-Measure (FMEASR@0.5@ -> beta=0.5, defalut beta=1)
	ACURCY	:Accuracy
	FALLOUT	:Fallout (false positive rate)
	TP	:true positive
	FP	:false positive
	TN	:true negative
	FN	:false negative
	REFVOL	:reference volume
	SEGVOL	:segmented volume
```

