# brainImageRdata

#### *Sara Linker*

#### *2018-11-01*

BrainImageRdata provides the brainmaps and gene expression data to be used with the companion package brainImager. BrainImageR will internally reference these datasets. They do not need to be accessed by the user directly.

To load the brainImageRdata datasets into your workspace:

```
hub <- ExperimentHub::ExperimentHub()
a <- list()
a[1] <- hub[["EH1434"]]
a[2] <- hub[["EH1435"]]
a[3] <- hub[["EH1436"]]
a[4] <- hub[["EH1437"]]
a[5] <- hub[["EH1438"]]
a[6] <- hub[["EH1439"]]
a[7] <- hub[["EH1440"]]
a[8] <- hub[["EH1441"]]
a[9] <- hub[["EH1442"]]
a[10] <- hub[["EH1443"]]
a[11] <- hub[["EH1444"]]
a[12] <- hub[["EH1445"]]
a[13] <- hub[["EH1446"]]
a[14] <- hub[["EH1447"]]
a[15] <- hub[["EH1448"]]
a[16] <- hub[["EH1449"]]
a[17] <- hub[["EH1450"]]
a[18] <- hub[["EH1451"]]
```

## brainImageR Experiment Hub Objects:

For a full description of each object please run make-metadata.R. In brief:

**EH1434:**

* **Title**: DevHum\_low
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: Prenatal
* **General Description**: A list of low resolution image masks of the developing human brain. Each element in the list is a different section of the brain. Each matrix within a list element is a segment of the brain to be colored based on enrichment information.

**EH1435:**

* **Title**: AdHum
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: Adult
* **General Description**: A list of low resolution image masks of the adult human brain. Each element in the list is a different section of the brain. Each matrix within a list element is a segment of the brain to be colored based on enrichment information.

**EH1436:**

* **Title**: Dev\_DIM
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: prenatal
* **General Description**: A list of the original dimensions of each image mask. Required to reconstruct the image.

**EH1437:**

* **Title**: ad\_DIM
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: adult
* **General Description**: A list of the original dimensions of each image mask. Required to reconstruct the image.

**EH1438:**

* **Title**: dev\_abrev
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: prenatal
* **General Description**: A list of the tissues in each brain section. Each element in the list corresponds to the same brain sections as in DevHum\_low.

**EH1439:**

* **Title**: ad\_abrev
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: adult
* **General Description**: A list of the tissues in each brain section. Each element in the list corresponds to the same brain sections as in AdHum.

**EH1440:**

* **Title**: dev\_outline
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: prenatal
* **General Description**: A list of matrices containing the outline for each brain section. Each element in the list corresponds to the same brain sections as in DevHum\_low.

**EH1441:**

* **Title**: ad\_outline
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: adult
* **General Description**: A list of matrices containing the outline for each brain section. Each element in the list corresponds to the same brain sections as in AdHum.

**EH1442:**

* **Title**: ad\_conversion
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: adult
* **General Description**: A matrix containing the conversion between microdissected brain regions and the more general brain regions that are plotted in the final heatmap.

**EH1443:**

* **Title**: dev\_slices
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: prenatal
* **General Description**: A vector of the different sections available for the prenatal brain

**EH1444:**

* **Title**: ad\_slices
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: adult
* **General Description**: A vector of the different sections available for the adult brain

**EH1445:**

* **Title**: dev\_abatissuesBygenes
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: prenatal
* **General Description**: Expression information for each microdissected region in the prenatal brain.

**EH1446:**

* **Title**: ad\_abatissuesBygenes
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: adult
* **General Description**: Expression information for each microdissected region in the adult brain.

**EH1447:**

* **Title**: dev\_colmeta
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: prenatal
* **General Description**: sample metadata provided by the Allen Brain Institute for the prenatal brain

**EH1448:**

* **Title**: ad\_colmeta
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: adult
* **General Description**: sample metadata provided by the Allen Brain Institute for the adult brain

**EH1449:**

* **Title**: rowmeta
* **For use with**: BrainImageR Spatial Analysis (ie: SpatialEnrichment, CreateBrain, PlotBrain)
* **Developmental Timepoint**: prenatal and adult
* **General Description**: gene metadata provided by the Allen Brain Institute

**EH1450:**

* **Title**: alldev\_colmeta
* **For use with**: BrainImageR Temporal Analysis (ie: predict\_time). T
* **Developmental Timepoint**: 8 weeks post-conception - 40 years
* **General Description**: sample metadata provided by the Allen Brain Institute

**EH1451:**

* **Title**: alldev\_scale
* **For use with**: BrainImageR Temporal Analysis (ie: predict\_time).
* **Developmental Timepoint**: 8 weeks post-conception - 40 years
* **General Description**: sample expression data for all timepoints provided by the Allen Brain Institute