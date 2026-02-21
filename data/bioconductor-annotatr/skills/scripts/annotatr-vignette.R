# Code example from 'annotatr-vignette' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("annotatr")

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github('rcavalcante/annotatr')

## ----echo=FALSE---------------------------------------------------------------
suppressWarnings(suppressMessages(suppressPackageStartupMessages(library(annotatr))))

## ----warning = FALSE, message = FALSE-----------------------------------------
# Create a named vector for the AnnotationHub accession codes with desired names
h3k4me3_codes = c('Gm12878' = 'AH23256')
# Fetch ah_codes from AnnotationHub and create annotations annotatr understands
build_ah_annots(genome = 'hg19', ah_codes = h3k4me3_codes, annotation_class = 'H3K4me3')
# The annotations as they appear in annotatr_cache
ah_names = c('hg19_H3K4me3_Gm12878')

print(annotatr_cache$get('hg19_H3K4me3_Gm12878'))

## ----warning = FALSE, message = FALSE-----------------------------------------
## Use ENCODE ChIP-seq peaks for EZH2 in GM12878
## These files contain chr, start, and end columns
ezh2_file = system.file('extdata', 'Gm12878_Ezh2_peak_annotations.txt.gz', package = 'annotatr')

## Custom annotation objects are given names of the form genome_custom_name
read_annotations(con = ezh2_file, genome = 'hg19', name = 'ezh2', format = 'bed')

print(annotatr_cache$get('hg19_custom_ezh2'))

## ----warning = FALSE, message = FALSE-----------------------------------------
print(annotatr_cache$list_env())

## ----warning = FALSE, message = FALSE-----------------------------------------
# This file in inst/extdata represents regions tested for differential
# methylation between two conditions. Additionally, there are columns
# reporting the p-value on the test for differential meth., the
# meth. difference between the two groups, and the group meth. rates.
dm_file = system.file('extdata', 'IDH2mut_v_NBM_multi_data_chr9.txt.gz', package = 'annotatr')
extraCols = c(diff_meth = 'numeric', mu0 = 'numeric', mu1 = 'numeric')
dm_regions = read_regions(con = dm_file, genome = 'hg19', extraCols = extraCols, format = 'bed',
    rename_name = 'DM_status', rename_score = 'pval')
# Use less regions to speed things up
dm_regions = dm_regions[1:2000]
print(dm_regions)

## ----warning = FALSE, message = FALSE-----------------------------------------
# Select annotations for intersection with regions
# Note inclusion of custom annotation, and use of shortcuts
annots = c('hg19_cpgs', 'hg19_basicgenes', 'hg19_genes_intergenic',
    'hg19_genes_intronexonboundaries',
    'hg19_custom_ezh2', 'hg19_H3K4me3_Gm12878')

# Build the annotations (a single GRanges object)
annotations = build_annotations(genome = 'hg19', annotations = annots)

# Intersect the regions we read in with the annotations
dm_annotated = annotate_regions(
    regions = dm_regions,
    annotations = annotations,
    ignore.strand = TRUE,
    quiet = FALSE)
# A GRanges object is returned
print(dm_annotated)

## ----warning = FALSE, message = FALSE-----------------------------------------
# Coerce to a data.frame
df_dm_annotated = data.frame(dm_annotated)

# See the GRanges column of dm_annotaed expanded
print(head(df_dm_annotated))

# Subset based on a gene symbol, in this case NOTCH1
notch1_subset = subset(df_dm_annotated, annot.symbol == 'NOTCH1')
print(head(notch1_subset))

## ----warning = FALSE, message = FALSE-----------------------------------------
# Randomize the input regions
dm_random_regions = randomize_regions(
    regions = dm_regions,
    allow.overlaps = TRUE,
    per.chromosome = TRUE)

# Annotate the random regions using the same annotations as above
# These will be used in later functions
dm_random_annotated = annotate_regions(
    regions = dm_random_regions,
    annotations = annotations,
    ignore.strand = TRUE,
    quiet = TRUE)

## ----warning = FALSE, message = FALSE-----------------------------------------
# Find the number of regions per annotation type
dm_annsum = summarize_annotations(
    annotated_regions = dm_annotated,
    quiet = TRUE)
print(dm_annsum)

# Find the number of regions per annotation type
# and the number of random regions per annotation type
dm_annsum_rnd = summarize_annotations(
    annotated_regions = dm_annotated,
    annotated_random = dm_random_annotated,
    quiet = TRUE)
print(dm_annsum_rnd)

# Take the mean of the diff_meth column across all regions
# occurring in an annotation.
dm_numsum = summarize_numerical(
    annotated_regions = dm_annotated,
    by = c('annot.type', 'annot.id'),
    over = c('diff_meth'),
    quiet = TRUE)
print(dm_numsum)

# Count the occurrences of classifications in the DM_status
# column across the annotation types.
dm_catsum = summarize_categorical(
    annotated_regions = dm_annotated,
    by = c('annot.type', 'DM_status'),
    quiet = TRUE)
print(dm_catsum)

## ----fig.align='center', fig.cap='Number of DM regions per annotation.', fig.height=6, fig.width=6, fig.show = 'hold', warning = FALSE, message = FALSE----
# View the number of regions per annotation. This function
# is useful when there is no classification or data
# associated with the regions.
annots_order = c(
    'hg19_custom_ezh2',
    'hg19_H3K4me3_Gm12878',
    'hg19_genes_1to5kb',
    'hg19_genes_promoters',
    'hg19_genes_5UTRs',
    'hg19_genes_exons',
    'hg19_genes_intronexonboundaries',
    'hg19_genes_introns',
    'hg19_genes_3UTRs',
    'hg19_genes_intergenic')
dm_vs_kg_annotations = plot_annotation(
    annotated_regions = dm_annotated,
    annotation_order = annots_order,
    plot_title = '# of Sites Tested for DM annotated on chr9',
    x_label = 'knownGene Annotations',
    y_label = 'Count')
print(dm_vs_kg_annotations)

## ----fig.align='center', fig.cap='Number of DM regions per annotation with randomized regions.', fig.height=6, fig.width=6, fig.show = 'hold', warning = FALSE, message = FALSE----
# View the number of regions per annotation and include the annotation
# of randomized regions
annots_order = c(
    'hg19_custom_ezh2',
    'hg19_H3K4me3_Gm12878',
    'hg19_genes_1to5kb',
    'hg19_genes_promoters',
    'hg19_genes_5UTRs',
    'hg19_genes_exons',
    'hg19_genes_intronexonboundaries',
    'hg19_genes_introns',
    'hg19_genes_3UTRs',
    'hg19_genes_intergenic')
dm_vs_kg_annotations_wrandom = plot_annotation(
    annotated_regions = dm_annotated,
    annotated_random = dm_random_annotated,
    annotation_order = annots_order,
    plot_title = 'Dist. of Sites Tested for DM (with rndm.)',
    x_label = 'Annotations',
    y_label = 'Count')
print(dm_vs_kg_annotations_wrandom)

## ----fig.align='center', fig.cap='Number of DM regions per pair of annotations.', fig.height=8, fig.width=8, fig.show = 'hold', warning = FALSE, message = FALSE----
# View a heatmap of regions occurring in pairs of annotations
annots_order = c(
    'hg19_custom_ezh2',
    'hg19_H3K4me3_Gm12878',
    'hg19_genes_promoters',
    'hg19_genes_5UTRs',
    'hg19_genes_exons',
    'hg19_genes_introns',
    'hg19_genes_3UTRs',
    'hg19_genes_intergenic')
dm_vs_coannotations = plot_coannotations(
    annotated_regions = dm_annotated,
    annotation_order = annots_order,
    axes_label = 'Annotations',
    plot_title = 'Regions in Pairs of Annotations')
print(dm_vs_coannotations)

## ----fig.align='center', fig.cap='Methylation Rates in Group 0 for Regions Over DM Status.', fig.height=6, fig.width=6, fig.show='hold', warning = FALSE, message = FALSE----
dm_vs_regions_annot = plot_numerical(
    annotated_regions = dm_annotated,
    x = 'mu0',
    facet = 'annot.type',
    facet_order = c('hg19_genes_1to5kb','hg19_genes_promoters',
        'hg19_genes_5UTRs','hg19_genes_3UTRs', 'hg19_custom_ezh2',
        'hg19_genes_intergenic', 'hg19_cpg_islands'),
    bin_width = 5,
    plot_title = 'Group 0 Region Methylation In Genes',
    x_label = 'Group 0')
print(dm_vs_regions_annot)

## ----fig.align='center', fig.cap='Methylation Differences for Regions Over DM Status and Annotation Type.', fig.height=6, fig.width=6, fig.show='hold', warning = FALSE, message = FALSE----
dm_vs_regions_annot2 = plot_numerical(
    annotated_regions = dm_annotated,
    x = 'diff_meth',
    facet = c('annot.type','DM_status'),
    facet_order = list(c('hg19_genes_promoters','hg19_genes_5UTRs','hg19_cpg_islands'), c('hyper','hypo','none')),
    bin_width = 5,
    plot_title = 'Group 0 Region Methylation In Genes',
    x_label = 'Methylation Difference')
print(dm_vs_regions_annot2)

## ----fig.align='center', fig.cap='Methylation Rates in Regions Over DM Status in Group 0 vs Group 1.', fig.height=6, fig.width=6, fig.show='hold', warning = FALSE, message = FALSE----
dm_vs_regions_name = plot_numerical(
    annotated_regions = dm_annotated,
    x = 'mu0',
    y = 'mu1',
    facet = 'annot.type',
    facet_order = c('hg19_genes_1to5kb','hg19_genes_promoters',
        'hg19_genes_5UTRs','hg19_genes_3UTRs', 'hg19_custom_ezh2',
        'hg19_genes_intergenic', 'hg19_cpg_islands', 'hg19_cpg_shores'),
    plot_title = 'Region Methylation: Group 0 vs Group 1',
    x_label = 'Group 0',
    y_label = 'Group 1')
print(dm_vs_regions_name)

## ----fig.align='center', fig.cap='Group 0 methylation Rates in Regions in promoters, CpG islands, and both.', fig.height=5, fig.width=12, fig.show='hold', warning = FALSE, message = FALSE----
dm_vs_num_co = plot_numerical_coannotations(
    annotated_regions = dm_annotated,
    x = 'mu0',
    annot1 = 'hg19_cpg_islands',
    annot2 = 'hg19_genes_promoters',
    bin_width = 5,
    plot_title = 'Group 0 Perc. Meth. in CpG Islands and Promoters',
    x_label = 'Percent Methylation')
print(dm_vs_num_co)

## ----fig.align='center', fig.cap='Differential methylation classification with counts of CpG annotations.', fig.height=6, fig.width=6, fig.show='hold', warning = FALSE, message = FALSE----
# View the counts of CpG annotations in data classes

# The orders for the x-axis labels. This is also a subset
# of the labels (hyper, hypo, none).
x_order = c(
    'hyper',
    'hypo')
# The orders for the fill labels. Can also use this
# parameter to subset annotation types to fill.
fill_order = c(
    'hg19_cpg_islands',
    'hg19_cpg_shores',
    'hg19_cpg_shelves',
    'hg19_cpg_inter')
# Make a barplot of the data class where each bar
# is composed of the counts of CpG annotations.
dm_vs_cpg_cat1 = plot_categorical(
    annotated_regions = dm_annotated, x='DM_status', fill='annot.type',
    x_order = x_order, fill_order = fill_order, position='stack',
    plot_title = 'DM Status by CpG Annotation Counts',
    legend_title = 'Annotations',
    x_label = 'DM status',
    y_label = 'Count')
print(dm_vs_cpg_cat1)

## ----fig.align='center', fig.cap='Differential methylation classification with proportion of CpG annotations.', fig.height=6, fig.width=6, fig.show='hold', warning = FALSE, message = FALSE----
# Use the same order vectors as the previous code block,
# but use proportional fill instead of counts.

# Make a barplot of the data class where each bar
# is composed of the *proportion* of CpG annotations.
dm_vs_cpg_cat2 = plot_categorical(
    annotated_regions = dm_annotated, x='DM_status', fill='annot.type',
    x_order = x_order, fill_order = fill_order, position='fill',
    plot_title = 'DM Status by CpG Annotation Proportions',
    legend_title = 'Annotations',
    x_label = 'DM status',
    y_label = 'Proportion')
print(dm_vs_cpg_cat2)

## ----fig.align='center', fig.cap='Differential methylation classification with proportion of CpG annotations and random regions.', fig.height=6, fig.width=6, fig.show='hold', warning = FALSE, message = FALSE----
# Add in the randomized annotations for "Random Regions" bar

# Make a barplot of the data class where each bar
# is composed of the *proportion* of CpG annotations, and
# includes "All" regions tested for DM and "Random Regions"
# regions consisting of randomized regions.
dm_vs_cpg_cat_random = plot_categorical(
    annotated_regions = dm_annotated, annotated_random = dm_random_annotated,
    x='DM_status', fill='annot.type',
    x_order = x_order, fill_order = fill_order, position='fill',
    plot_title = 'DM Status by CpG Annotation Proportions',
    legend_title = 'Annotations',
    x_label = 'DM status',
    y_label = 'Proportion')
print(dm_vs_cpg_cat_random)

## ----fig.align='center', fig.cap='Basic gene annotations with proportions of DM classification.', fig.height=6, fig.width=6, fig.show='hold', warning = FALSE, message = FALSE----
# View the proportions of data classes in knownGene annotations

# The orders for the x-axis labels.
x_order = c(
    'hg19_custom_ezh2',
    'hg19_genes_1to5kb',
    'hg19_genes_promoters',
    'hg19_genes_5UTRs',
    'hg19_genes_exons',
    'hg19_genes_introns',
    'hg19_genes_3UTRs',
    'hg19_genes_intergenic')
# The orders for the fill labels.
fill_order = c(
    'hyper',
    'hypo',
    'none')
dm_vs_kg_cat = plot_categorical(
    annotated_regions = dm_annotated, x='annot.type', fill='DM_status',
    x_order = x_order, fill_order = fill_order, position='fill',
    legend_title = 'DM Status',
    x_label = 'knownGene Annotations',
    y_label = 'Proportion')
print(dm_vs_kg_cat)

