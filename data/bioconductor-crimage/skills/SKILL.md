---
name: bioconductor-crimage
description: CRImage performs image analysis and calculates tumor cellularity for biological and histological images. Use when user asks to perform color space conversion, segment cell nuclei, classify cell types, calculate tumor cellularity, or correct copy number data.
homepage: https://bioconductor.org/packages/release/bioc/html/CRImage.html
---

# bioconductor-crimage

name: bioconductor-crimage
description: Image analysis and cellularity calculation for biological images. Use this skill to perform color space conversion, image thresholding, cell segmentation, and classification of cell types (e.g., malignant vs. normal) in histological images. It is specifically designed for calculating tumor cellularity and correcting copy number data based on cellularity estimates.

# bioconductor-crimage

## Overview
CRImage is a specialized package for the analysis of biological images, particularly histological sections. It provides tools for image processing, cell segmentation using watershed algorithms, and cell classification via Support Vector Machines (SVM). A primary use case is the calculation of tumor cellularity (the proportion of tumor cells in a sample), which is critical for downstream genomic analyses like copy number correction.

## Core Workflows

### 1. Image Pre-processing and Thresholding
Before segmentation, images often require color space conversion or thresholding to create a binary mask of nuclei.

```r
library(CRImage)
library(EBImage)

f = system.file("extdata", "exImg2.jpg", package="CRImage")
img = readImage(f)

# Color Space Conversion
imgHSV = convertRGBToHSV(img)
imgLAB = convertRGBToLAB(img)

# Thresholding (Otsu or Phansalkar)
imgG = EBImage::channel(img, "gray")
# Define mask for white/background pixels to exclude
whitePixelMask = img[,,1]>0.85 & img[,,2]>0.85 & img[,,3]>0.85
imgB = createBinaryImage(imgG, img, method="otsu", numWindows=4, whitePixelMask=whitePixelMask)
```

### 2. Image Segmentation
The `segmentImage` function identifies individual cell nuclei.

```r
# Returns a list: [[1]] original, [[2]] segmented mask, [[3]] feature table
segValues = segmentImage(filename=f, maxShape=800, minShape=40, failureRegion=2000, threshold="otsu")

# Display segmented nuclei
# display(segValues[[2]])
```
- `maxShape`: Maximum size of a nucleus; larger objects are re-segmented.
- `minShape`: Minimum size; smaller objects are discarded.
- `failureRegion`: Size threshold to remove large dark artifacts.

### 3. Classification and Cellularity
To calculate cellularity, you must first train a classifier or use an existing training set.

**Creating a Classifier:**
```r
# Load training data (table with features and a 'class' column)
tFile = system.file("extdata", "trainingData.txt", package="CRImage")
trainingData = read.table(tFile, header=TRUE)

# Create SVM classifier
classifierValues = createClassifier(trainingData)
classifier = classifierValues[[1]]
```

**Calculating Cellularity:**
```r
# Calculate proportion of tumor cells
cellularity = calculateCellularity(classifier=classifier, filename=f, 
                                   KS=TRUE, maxShape=800, minShape=40, 
                                   cancerIdentifier="1", # Label for tumor class
                                   numDensityWindows=2)
```

### 4. Copy Number Correction
Adjust copy number log-ratios (LRR) and BAF values based on the estimated cellularity (p).

```r
# z is a data frame with Chrom, Pos, LRR, and BAF
res = correctCopyNumber(arr="Sample1", chr=1, p=0.75, z=z)

# Visualize results
plotCorrectedCN(res, chr=1)
```

### 5. Processing Large Slides (Aperio)
For large-scale images saved in CWS format (subimages), use `processAperio`.

```r
processAperio(classifier=classifier, inputFolder="path/to/images", 
             outputFolder="AperiOutput", identifier="Da", 
             cancerIdentifier="c", maxShape=800)
```

## Tips and Best Practices
- **EBImage Integration**: CRImage relies heavily on `EBImage`. Use `display()` to visualize intermediate steps and `readImage()` for loading files.
- **Training Sets**: When creating a training set with `createTrainingSet`, ensure you have representative examples for every class. You can use up to 10 classes.
- **Kernel Smoothing (KS)**: Setting `KS=TRUE` in classification functions enables a kernel smoothing approach, which is often more robust for spatial density estimation but may require specifying a specific cancer class.

## Reference documentation
- [CRImage](./references/CRImage.md)