# Code example from 'MetNet' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----env, include=FALSE, echo=FALSE, cache=FALSE------------------------------
library("knitr")
opts_chunk$set(stop_on_error = 1L)
suppressPackageStartupMessages(library("MetNet"))

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("MetNet")

## ----load_MetNet,eval=TRUE----------------------------------------------------
library(MetNet)

## ----data,eval=TRUE,echo=TRUE-------------------------------------------------
data("x_test", package = "MetNet")
x_test <- as.matrix(x_test)

## ----transformation_example,echo=TRUE,eval=TRUE-------------------------------
## define the search space for biochemical transformation 
transformations <- rbind(
    c("Hydroxylation (-H)", "O", 15.9949146221, "-"),
    c("Malonyl group (-H2O)", "C3H2O3", 86.0003939305, "+"),
    c("D-ribose (-H2O) (ribosylation)", "C5H8O4", 132.0422587452, "-"),
    c("C6H10O6", "C6H10O6", 178.0477380536, "-"),
    c("Rhamnose (-H20)", "C6H10O4", 146.057910, "-"),
    c("Monosaccharide (-H2O)", "C6H10O5", 162.0528234315, "-"),
    c("Disaccharide (-H2O) #1", "C12H20O10", 324.105649, "-"),
    c("Disaccharide (-H2O) #2", "C12H20O11", 340.1005614851, "-"),
    c("Trisaccharide (-H2O)", "C18H30O15", 486.1584702945, "-"),
    c("Glucuronic acid (-H2O)", "C6H8O6", 176.0320879894, "?"),
    c("coumaroyl (-H2O)", "C9H6O2", 146.0367794368, "?"),
    c("feruloyl (-H2O)", "C9H6O2OCH2", 176.0473441231, "?"),
    c("sinapoyl (-H2O)", "C9H6O2OCH2OCH2", 206.0579088094, "?"),
    c("putrescine to spermidine (+C3H7N)", "C3H7N", 57.0578492299, "?"))

## convert to data frame
transformations <- data.frame(
    group = transformations[, 1],
    formula = transformations[, 2],
    mass = as.numeric(transformations[, 3]),
    rt = transformations[, 4])

## ----structure, eval=TRUE,echo=TRUE-------------------------------------------
struct_adj <- structural(x = x_test, transformation = transformations, 
    var = c("group", "formula", "mass"), ppm = 10)

## ----structure_dir, eval=TRUE,echo=TRUE---------------------------------------
struct_adj_dir <- structural(x = x_test, transformation = transformations, 
    var = c("group", "formula", "mass"), ppm = 10, directed = TRUE)

## ----visualization_directed---------------------------------------------------
g_undirected <- igraph::graph_from_adjacency_matrix(
    assay(struct_adj, "binary"), mode = "directed", weighted = NULL)
plot(g_undirected, edge.width = 1, edge.arrow.size = 0.5,
     vertex.label.cex = 0.5, edge.color = "grey")
g_directed <- igraph::graph_from_adjacency_matrix(
    assay(struct_adj_dir, "binary"), mode = "directed", weighted = NULL)
plot(g_directed, edge.width = 1, edge.arrow.size = 0.5,
     vertex.label.cex = 0.5, edge.color = "grey")

## ----rt_correction, eval=TRUE, echo=TRUE--------------------------------------
struct_adj <- rtCorrection(am = struct_adj, x = x_test, 
    transformation = transformations, var = "group")

## ----eval=TRUE,echo=TRUE------------------------------------------------------
struct_df <- as.data.frame(struct_adj)
struct_df <- struct_df[struct_df$binary == 1, ]

## ----mz_summary,eval=TRUE,echo=TRUE-------------------------------------------
mz_sum <- mz_summary(struct_adj, var = "group")
mz_vis(mz_sum, var = "group")

## ----mz_summary_filter--------------------------------------------------------
mz_summary(struct_adj, filter = 4)
mz_summary(struct_adj, filter = 5)

## ----eval=TRUE,echo=TRUE------------------------------------------------------
data("x_annotation", package = "MetNet")
x_annotation <- as.data.frame(x_annotation)

## add annotations to the structural AdjacencyMatrix object
rowData(struct_adj) <- x_annotation

## display annotation for the feature "1856"
rowData(struct_adj)["x1856", ]

## ----spectral,eval = TRUE, echo = TRUE----------------------------------------
# required for ndotproduct calculus
library(MsCoreUtils)
library(Spectra)

## create spectral similarity matrix
f <- system.file("spectra_matrix/ms2_test.RDS", package = "MetNet")
sps_sub <- readRDS(f)
 
adj_spec <- Spectra::compareSpectra(sps_sub, FUN = ndotproduct)
colnames(adj_spec) <- sps_sub$id
rownames(adj_spec) <- sps_sub$id

spect_adj <- addSpectralSimilarity(am_structural = struct_adj, 
    ms2_similarity = list("ndotproduct" = adj_spec))

## ----threshold structural,eval=TRUE,echo=TRUE---------------------------------
## the assayNames in spect_adj are used to define the filter criteria
assayNames(spect_adj)

## return edges with normalized dotproduct > 0.10
args_thr <- list(filter = "ndotproduct > 0.1")

## return edges with normalized dotproduct > 0.10, even if no mass-difference 
## was detected between pairs of features
args_thr <- list(filter = "ndotproduct > 0.1 | binary == 1 & is.na(ndotproduct)")

## pass the filtering criteria to the args argument and set type to "threshold"
spect_adj_thr <- threshold(am = spect_adj, type = "threshold", 
    args = args_thr)

## ----statistical,eval=TRUE,echo=TRUE------------------------------------------
x_int <- x_test[, 3:ncol(x_test)] |>
    as.matrix()
stat_adj <- statistical(x_int, model = c("pearson", "spearman"))

## ----threshold,eval=TRUE,echo=TRUE--------------------------------------------
## type = "threshold" 

## the assayNames in stat_adj are used to define the filter criteria
assayNames(stat_adj)

## return edges with positive Pearson correlation coefficients > 0.95
args_thr <- list(filter = "pearson_coef > 0.95")

## return edges with positive Spearman correlation coefficients > 0.95
args_thr <- list(filter = "spearman_coef > 0.95")

## return edges with absolute Pearson correlation coefficients > 0.95 and 
## associated p-values <= 0.05
args_thr <- list(filter = "abs(pearson_coef) > 0.95 & pearson_pvalue <= 0.05")

## return edges with absolute Pearson OR Spearman correlation coefficients > 0.95
args_thr <- list(filter = "abs(pearson_coef) > 0.95 | abs(spearman_coef) > 0.95")

## return edges with absolute Pearson AND Spearman correlation coefficients > 0.95
args_thr <- list(filter = "abs(pearson_coef) > 0.95 & abs(spearman_coef) > 0.95")

## pass the filtering criteria to the args argument and set type to "threshold"
stat_adj_thr <- threshold(am = stat_adj, type = "threshold", 
    args = args_thr)

## alternatively, use the types "top1", "top2", "mean"
## retrieve the feature pairs which have the 100 highest coefficients
args_top <- list(n = 100)
## type = "top1" 
stat_adj_top1 <- threshold(am = stat_adj, type = "top1", 
    args = args_top)

## type = "top2"
stat_adj_top2 <- threshold(am = stat_adj, type = "top2", 
    args = args_top)
 
## type = "mean"
stat_adj_mean <- threshold(am = stat_adj, type = "mean", 
    args = args_top)

## ----combine,eval=TRUE,echo=TRUE----------------------------------------------
comb_adj <- combine(am_structural = struct_adj, am_statistical = stat_adj_mean)

## ----combine spect,eval=TRUE,echo=TRUE----------------------------------------
comb_spect_adj <- combine(am_structural = spect_adj_thr, 
                          am_statistical = stat_adj_mean)

## ----visualisation,eval=TRUE,echo=TRUE,fig.cap='_Ab initio_ network inferred from structural and  quantitative mass spectrometry data. Vertices are connected that are separated by given metabolic transformation and statistical association.'----
adj <- assay(comb_adj, "combine_binary")
diag(adj) <- 1
g <- igraph::graph_from_adjacency_matrix(adj, mode = "undirected", diag = FALSE)
plot(g, edge.width = 2, vertex.label.cex = 0.5, edge.color = "grey")

## ----session,eval=TRUE,echo=FALSE---------------------------------------------
sessionInfo()

## ----ttransformations,eval=TRUE,echo=TRUE-------------------------------------
transformations <- rbind(
    c("Alanine", "C3H5NO", "71.0371137878"),
    c("Arginine", "C6H12N4O", "156.1011110281"),
    c("Asparagine", "C4H6N2O2", "114.0429274472"),
    c("Guanosine 5-diphosphate (-H2O)", "C10H13N5O10P2", "425.0137646843"),
    c("Guanosine 5-monophosphate (-H2O)", "C10H12N5O7P", "345.0474342759"),
    c("Guanine (-H)", "C5H4N5O", "150.0415847765"),
    c("Aspartic acid", "C4H5NO3", "115.0269430320"),
    c("Guanosine (-H2O)", "C10H11N5O4", "265.0811038675"),
    c("Cysteine", "C3H5NOS", "103.0091844778"),
    c("Deoxythymidine 5'-diphosphate (-H2O)", "C10H14N2O10P2", "384.01236770"),
    c("Cystine", "C6H10N2O3S2", "222.0132835777"),
    c("Thymidine (-H2O)", "C10H12N2O4", "224.0797068840"),
    c("Glutamic acid", "C5H7NO3", "129.0425930962"),
    c("Thymine (-H)", "C5H5N2O2", "125.0351024151"),
    c("Glutamine", "C5H8N2O2", "128.0585775114"),
    c("Thymidine 5'-monophosphate (-H2O)", "C10H13N2O7P", "304.0460372924"),
    c("Glycine", "C2H3NO", "57.0214637236"),
    c("Uridine 5'-diphosphate (-H2O)", "C9H12N2O11P2", "385.9916322587"),
    c("Histidine", "C6H7N3O", "137.0589118624"),
    c("Uridine 5'-monophosphate (-H2O)", "C9H11N2O8P", "306.0253018503"),
    c("Isoleucine", "C6H11NO", "113.0840639804"),
    c("Uracil (-H)", "C4H3N2O2", "111.0194523509"),
    c("Leucine", "C6H11NO", "113.0840639804"),
    c("Uridine (-H2O)", "C9H10N2O5", "226.0589714419"),
    c("Lysine", "C6H12N2O", "128.0949630177"),
    c("Acetylation (-H)", "C2H3O2", "59.0133043405"),
    c("Methionine", "C5H9NOS", "131.0404846062"),
    c("Acetylation (-H2O)", "C2H2O",  "42.0105646863"),
    c("Phenylalanine", "C9H9NO",  "147.0684139162"),
    c("C2H2", "C2H2", "26.0156500642"),
    c("Proline", "C5H7NO", "97.0527638520"),
    c("Carboxylation", "CO2", "43.9898292442"),
    c("Serine", "C3H5NO2", "87.0320284099"),
    c("CHO2", "CHO2", "44.9976542763"),
    c("Threonine",  "C4H7NO2",  "101.0476784741"),
    c("Condensation/dehydration", "H2O", "18.0105646863"),
    c("Tryptophan", "C11H10N2O",  "186.0793129535"),
    c("Diphosphate", "H3O6P2", "160.9404858489"),
    c("Tyrosine", "C9H9NO2", "163.0633285383"),
    c("Ethyl addition (-H2O)", "C2H4", "28.0313001284"),
    c("Valine", "C5H9NO",  "99.0684139162"),
    c("Formic Acid (-H2O)", "CO", "27.9949146221"),
    c("Acetotacetate (-H2O)",  "C4H4O2", "84.0211293726"),
    c("Glyoxylate (-H2O)", "C2O2",  "55.9898292442"),
    c("Acetone (-H)", "C3H5O", "57.0340397826"),
    c("Hydrogenation/dehydrogenation", "H2", "2.0156500642"),
    c("Adenylate (-H2O)", "C10H12N5O6P", "329.0525196538"),
    c("Hydroxylation (-H)", "O", "15.9949146221"),
    c("Biotinyl (-H)", "C10H15N2O3S", "243.0803380482"),
    c("Inorganic phosphate", "P", "30.9737615100"),
    c("Biotinyl (-H2O)", "C10H14N2O2S", "226.0775983940"),
    c("Ketol group (-H2O)", "C2H2O", "42.0105646863"),
    c("Carbamoyl P transfer (-H2PO4)", "CH2ON", "44.0136386915"),
    c("Methanol (-H2O)", "CH2", "14.0156500642"),
    c("Co-enzyme A (-H)", "C21H34N7O16P3S", "765.0995583014"),
    c("Phosphate", "HPO3", "79.9663304084"),
    c("Co-enzyme A (-H2O)", "C21H33N7O15P3S", "748.0968186472"),
    c("Primary amine", "NH2", "16.0187240694"),
    c("Glutathione (-H2O)", "C10H15N3O5S", "289.0732412976"),
    c("Pyrophosphate", "PP", "61.9475230200"),
    c("Isoprene addition (-H)", "C5H7", "67.0547752247"),
    c("Secondary amine", "NH", "15.0108990373"),
    c("Malonyl group (-H2O)", "C3H2O3", "86.0003939305"),
    c("Sulfate (-H2O)", "SO3", "79.9568145563"),
    c("Palmitoylation (-H2O)", "C16H30O", "238.2296655851"),
    c("Tertiary amine", "N", "14.0030740052"),
    c("Pyridoxal phosphate (-H2O)", "C8H8NO5P", "229.0140088825"),
    c("C6H10O5", "C6H10O5", "162.0528234315"),
    c("Urea addition (-H)", "CH3N2O", "59.0245377288"),
    c("C6H10O6", "C6H10O6", "178.0477380536"),
    c("Adenine (-H)", "C5H4N5", "134.0466701544"),
    c("D-ribose (-H2O) (ribosylation)", "C5H8O4", "132.0422587452"),
    c("Adenosine (-H2O)", "C10H11N5O3", "249.0861892454"),
    c("Disaccharide (-H2O) #1", "C12H20O10", "324.105649"),
    c("Disaccharide (-H2O) #2", "C12H20O11", "340.1005614851"),
    c("Adenosine 5'-diphosphate (-H2O)", "C10H13N5O9P2", "409.0188500622"),
    c("Glucose-N-phosphate (-H2O)", "C6H11O8P", "242.0191538399"),
    c("Adenosine 5'-monophosphate (-H2O)", "C10H12N5O6P", "329.0525196538"),
    c("Glucuronic acid (-H2O)", "C6H8O6", "176.0320879894"),
    c("Cytidine 5'-diphosphate (-H2O)", "C9H13N3O10P2", "385.0076166739"),
    c("Monosaccharide (-H2O)", "C6H10O5", "162.0528234315"),
    c("Cytidine 5'-monophsophate (-H2O)", "C9H12N3O7P", "305.0412862655"),
    c("Trisaccharide (-H2O)", "C18H30O15", "486.1584702945"),
    c("Cytosine (-H)", "C4H4N3O",  "110.0354367661"))

transformations <- data.frame(group = transformations[, 1], 
            formula = transformations[, 2],
            mass = as.numeric(transformations[, 3]))

