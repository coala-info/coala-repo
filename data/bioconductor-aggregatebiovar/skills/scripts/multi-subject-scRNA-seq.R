# Code example from 'multi-subject-scRNA-seq' vignette. See references/ for full tutorial.

## ----vignette, include = FALSE------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
knitr::opts_knit$set(
    eval.after = "fig.cap"
)

## ----setup, message=FALSE-----------------------------------------------------
# For analysis of scRNAseq data
library(aggregateBioVar)
library(SummarizedExperiment, quietly = TRUE)
library(SingleCellExperiment, quietly = TRUE)
library(DESeq2, quietly = TRUE)

# For data transformation and visualization
library(magrittr, quietly = TRUE)
library(dplyr, quietly = TRUE)
library(ggplot2, quietly = TRUE)
library(cowplot, quietly = TRUE)
library(ggtext, quietly = TRUE)

## ----links, echo=FALSE--------------------------------------------------------
link_sce <-
    paste0(
        "https://bioconductor.org/packages/release/bioc/",
        "vignettes/SingleCellExperiment/inst/doc/intro.html"
    )
link_se <-
    paste0(
        "https://bioconductor.org/packages/release/bioc/",
        "vignettes/SummarizedExperiment/inst/doc/SummarizedExperiment.html"
    )
link_ncbi <-
    paste0(
        "https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/",
        "wwwtax.cgi?mode=Info&id=9823"
    )
link_DESeq2 <-
    paste0(
        "https://bioconductor.org/packages/devel/bioc/",
        "vignettes/DESeq2/inst/doc/DESeq2.html"
    )

## ----captions, echo=FALSE, message=FALSE--------------------------------------
cap_metadata <-
    SummarizedExperiment::colData(x = small_airway) %>% tibble::as_tibble() %>%
    dplyr::select("orig.ident", "Genotype") %>%
    dplyr::distinct() %>% dplyr::arrange(.data$orig.ident)

# Figure 1
cap_pheatmanp_cell <-
    paste0(
        "Gene-by-cell Count Matrix. ",
        "Heatmap of *secretory cell* gene expression with log~2~ counts ",
        "per million cells. Includes ",
        length(grep("Secretory cell", small_airway$celltype)),
        " cells from ", length(unique(small_airway$orig.ident)), " subjects",
        " with genotypes `WT` (n=", length(grep("WT", cap_metadata$Genotype)),
        ", cells=",
        length(
            intersect(
                grep("WT", small_airway$Genotype),
                grep("Secretory cell", small_airway$celltype)
            )
        ),
        ") and `CFTRKO` (n=", length(grep("CFTRKO", cap_metadata$Genotype)),
        ", cells=",
        length(
            intersect(
                grep("CFTRKO", small_airway$Genotype),
                grep("Secretory cell", small_airway$celltype)
            )
        ),
        ")."
    )

# Figure 2
cap_pheatmanp_subj <-
    paste0(
        "Gene-by-subject Count Matrix. ",
        "Heatmap of gene counts aggregated by ",
        "subject with `aggregateBioVar()`.",
        "The `SummarizedExperiment` object with the *Secretory cells* subset ",
        "contains gene counts summed by subject. Aggregate gene-by-subject ",
        "counts are used as input for bulk RNA-seq tools."
    )

# Figure 3
cap_volcano <-
    paste0(
        "Differential expression analysis of scRNA-seq data. ",
        "Comparison of differential expression in ",
        "secretory cells from small airway epithelium ",
        "without aggregation (A) and after aggregation of gene counts ",
        "by subject (biological replicates; B). ",
        "Genes with an absolute log~2~ fold change greater than 1 and an ",
        "adjusted P value less than 0.05 are highlighted in red. Aggregation ",
        "of counts by subject reduced the number of differentially expressed ",
        "genes to CD36 and CFTR for the secretory cell subset."
    )

# Figure 4
cap_counts <-
    paste0(
        "Normalized within-subject gene counts. ",
        "Gene counts aggregated by subject for significantly differentially ",
        "expressed genes from the secretory cell subset."
    )

## ----singleCellExperiment-----------------------------------------------------
small_airway

## ----assays-------------------------------------------------------------------
assays(small_airway)

# Dimensions of gene-by-cell count matrix
dim(counts(small_airway))

# Access dgCMatrix with gene counts
counts(small_airway)[1:5, 1:30]

## ----subjects, echo=FALSE-----------------------------------------------------
sbj_cf <-
    grep(pattern = "CF", x = unique(small_airway$orig.ident), value = TRUE)
sbj_wt <-
    grep(pattern = "WT", x = unique(small_airway$orig.ident), value = TRUE)

## ----metadata-----------------------------------------------------------------
# Subject values
table(small_airway$orig.ident)

# Cell type values
table(small_airway$celltype)

# Subject genotype
table(small_airway$Genotype)

## ----columnData---------------------------------------------------------------
colData(small_airway)

## ----countsBySubject----------------------------------------------------------
countsBySubject(scExp = small_airway, subjectVar = "orig.ident")

## ----subjectMetaData----------------------------------------------------------
subjectMetaData(scExp = small_airway, subjectVar = "orig.ident")

## ----summarizedCounts---------------------------------------------------------
summarizedCounts(scExp = small_airway, subjectVar = "orig.ident")

## ----aggregateBioVar----------------------------------------------------------
aggregateBioVar(scExp = small_airway,
                subjectVar = "orig.ident", cellVar = "celltype")

## ----DESeq2Example------------------------------------------------------------
# Perform aggregation of counts and metadata by subject and cell type.
aggregate_counts <-
    aggregateBioVar(
        scExp = small_airway,
        subjectVar = "orig.ident", cellVar = "celltype"
    )

## ----pheatmapFxn--------------------------------------------------------------
#' Single-cell Counts `pheatmap`
#'
#' @param sumExp `SummarizedExperiment` or `SingleCellExperiment` object
#'   with individual cell or aggregate counts by-subject.
#' @param logSample Subset of log2 values to include for clustering.
#' @param ... Forwarding arguments to pheatmap
#' @inheritParams aggregateBioVar
#'
scPHeatmap <- function(sumExp, subjectVar, gtVar, logSample = 1:100, ...) {
    orderSumExp <- sumExp[, order(sumExp[[subjectVar]])]
    sumExpCounts <- as.matrix(
        SummarizedExperiment::assay(orderSumExp, "counts")
    )
    logcpm <- log2(
        1e6*t(t(sumExpCounts) / colSums(sumExpCounts)) + 1
    )
    annotations <- data.frame(
        Genotype = orderSumExp[[gtVar]],
        Subject = orderSumExp[[subjectVar]]
    )
    rownames(annotations) <- colnames(orderSumExp)

    singleCellpHeatmap <- pheatmap::pheatmap(
        mat = logcpm[logSample, ], annotation_col = annotations,
        cluster_cols = FALSE, show_rownames = FALSE, show_colnames = FALSE,
        scale = "none", ...
    )
    return(singleCellpHeatmap)
}


## ----pheatmapCells, fig.cap=cap_pheatmanp_cell--------------------------------
# Subset `SingleCellExperiment` secretory cells.
sumExp <- small_airway[, small_airway$celltype == "Secretory cell"]

# List of annotation color specifications for pheatmap.
ann_colors <- list(
    Genotype = c(CFTRKO = "red", WT = "black"),
    Subject = c(RColorBrewer::brewer.pal(7, "Accent"))
)
ann_names <- unique(sumExp[["orig.ident"]])
names(ann_colors$Subject) <- ann_names[order(ann_names)]

# Heatmap of log2 expression across all cells.
scPHeatmap(
    sumExp = sumExp, logSample = 1:100,
    subjectVar = "orig.ident", gtVar = "Genotype",
    color = viridis::viridis(75), annotation_colors = ann_colors,
    treeheight_row = 0, treeheight_col = 0
)

## ----pheatmapSubject, fig.cap=cap_pheatmanp_subj------------------------------
# List of `SummarizedExperiment` objects with aggregate subject counts.
scExp <-
    aggregateBioVar(
        scExp = small_airway,
        subjectVar = "orig.ident", cellVar = "celltype"
    )

# Heatmap of log2 expression from aggregate gene-by-subject count matrix.
scPHeatmap(
    sumExp = aggregate_counts$`Secretory cell`, logSample = 1:100,
    subjectVar = "orig.ident", gtVar = "Genotype",
    color = viridis::viridis(75), annotation_colors = ann_colors,
    treeheight_row = 0, treeheight_col = 0
)

## ----DESeq2Aggregate----------------------------------------------------------
subj_dds_dataset <-
    DESeqDataSetFromMatrix(
        countData = assay(aggregate_counts$`Secretory cell`, "counts"),
        colData = colData(aggregate_counts$`Secretory cell`),
        design = ~ Genotype
    )

subj_dds <- DESeq(subj_dds_dataset)

subj_dds_results <-
    results(subj_dds, contrast = c("Genotype", "WT", "CFTRKO"))

## ----DESeq2Cells--------------------------------------------------------------
cells_secretory <-
    small_airway[, which(
        as.character(small_airway$celltype) == "Secretory cell")]
cells_secretory$Genotype <- as.factor(cells_secretory$Genotype)

cell_dds_dataset <-
    DESeqDataSetFromMatrix(
        countData = assay(cells_secretory, "counts"),
        colData = colData(cells_secretory),
        design = ~ Genotype
    )

cell_dds <- DESeq(cell_dds_dataset)

cell_dds_results <-
    results(cell_dds, contrast = c("Genotype", "WT", "CFTRKO"))

## ----logPadj, message=FALSE---------------------------------------------------
subj_dds_transf <- as.data.frame(subj_dds_results) %>%
    bind_cols(feature = rownames(subj_dds_results)) %>%
    mutate(log_padj = - log(.data$padj, base = 10))

cell_dds_transf <- as.data.frame(cell_dds_results) %>%
    bind_cols(feature = rownames(cell_dds_results)) %>%
    mutate(log_padj = - log(.data$padj, base = 10))

## ----dgeCounts, echo=FALSE----------------------------------------------------
dge_cells <-
    filter(
        .data = cell_dds_transf,
        abs(.data$log2FoldChange) > 1, .data$padj < 0.05
    )
dge_subj <-
    filter(
        .data = subj_dds_transf,
        abs(.data$log2FoldChange) > 1, .data$padj < 0.05
    )

## ----plotVolcano, fig.cap=cap_volcano-----------------------------------------
# Function to add theme for ggplots of DESeq2 results.
deseq_themes <- function() {
    list(
        theme_classic(),
        lims(x = c(-4, 5), y = c(0, 80)),
        labs(
            x = "log<sub>2</sub> (fold change)",
            y = "-log<sub>10</sub> (p<sub>adj</sub>)"
        ),
        ggplot2::theme(
            axis.title.x = ggtext::element_markdown(),
            axis.title.y = ggtext::element_markdown())
    )
}

# Build ggplots to visualize subject-level differential expression in scRNA-seq
ggplot_full <- ggplot(data = cell_dds_transf) +
    geom_point(aes(x = log2FoldChange, y = log_padj), na.rm = TRUE) +
    geom_point(
        data = filter(
            .data = cell_dds_transf,
            abs(.data$log2FoldChange) > 1, .data$padj < 0.05
        ),
        aes(x = log2FoldChange, y = log_padj), color = "red"
    ) +
    deseq_themes()

ggplot_subj <- ggplot(data = subj_dds_transf) +
    geom_point(aes(x = log2FoldChange, y = log_padj), na.rm = TRUE) +
    geom_point(
        data = filter(
            .data = subj_dds_transf,
            abs(.data$log2FoldChange) > 1, .data$padj < 0.05
        ),
        aes(x = log2FoldChange, y = log_padj), color = "red"
    ) +
    geom_label(
        data = filter(
            .data = subj_dds_transf,
            abs(.data$log2FoldChange) > 1, .data$padj < 0.05
        ),
        aes(x = log2FoldChange + 0.5, y = log_padj + 5, label = feature)
    ) +
    deseq_themes()

cowplot::plot_grid(ggplot_full, ggplot_subj, ncol = 2, labels = c("A", "B"))

## ----plotGeneCounts, fig.cap=cap_counts---------------------------------------
# Extract counts subset by gene to plot normalized counts.
ggplot_counts <- function(dds_obj, gene) {
    norm_counts <-
        counts(dds_obj, normalized = TRUE)[grepl(gene, rownames(dds_obj)), ]
    sc_counts <-
        data.frame(
            norm_count = norm_counts,
            subject = colData(dds_obj)[["orig.ident"]],
            genotype = factor(
                colData(dds_obj)[["Genotype"]],
                levels = c("WT", "CFTRKO")
            )
        )

    count_ggplot <- ggplot(data = sc_counts) +
        geom_jitter(
            aes(x = genotype, y = norm_count, color = genotype),
            height = 0, width = 0.05
        ) +
        scale_color_manual(
            "Genotype", values = c("WT" = "blue", "CFTRKO" = "red")
        ) +
        lims(x = c("WT", "CFTRKO"), y = c(0, 350)) +
        labs(x = "Genotype", y = "Normalized Counts") +
        ggtitle(label = gene) +
        theme_classic()
    return(count_ggplot)
}

cowplot::plot_grid(
    ggplot_counts(dds_obj = subj_dds, gene = "CFTR") +
        theme(legend.position = "FALSE"),
    ggplot_counts(dds_obj = subj_dds, gene = "CD36") +
        theme(legend.position = "FALSE"),
    cowplot::get_legend(
        plot = ggplot_counts(dds_obj = subj_dds, gene = "CD36")
    ),
    ncol = 3, rel_widths = c(4, 4, 1)
)

## -----------------------------------------------------------------------------
sessionInfo()

