# Code example from 'ccfindR' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install('ccfindR')

## -----------------------------------------------------------------------------
library(ccfindR)

## ----echo=T-------------------------------------------------------------------
# A toy matrix for count data
set.seed(1)
mat <- matrix(rpois(n = 80, lambda = 2), nrow = 4, ncol = 20)
ABC <- LETTERS[1:4]
abc <- letters[1:20]
rownames(mat) <- ABC
colnames(mat) <- abc

## ----echo=T-------------------------------------------------------------------
# create scNMFSet object
sc <- scNMFSet(count = mat)

## ----echo=T-------------------------------------------------------------------
# create scNMFSet object
sc <- scNMFSet(assays = list(counts = mat))

## -----------------------------------------------------------------------------
# set row and column names
suppressMessages(library(S4Vectors))
genes <- DataFrame(ABC)
rownames(genes) <- ABC
cells <- DataFrame(abc)
rownames(cells) <- abc
sc <- scNMFSet(count = mat, rowData = genes, colData = cells)
sc

## -----------------------------------------------------------------------------
# read sparse matrix
dir <- system.file('extdata', package = 'ccfindR')
mat <- Matrix::readMM(paste0(dir,'/matrix.mtx'))
rownames(mat) <- 1:nrow(mat)
colnames(mat) <- 1:ncol(mat)
sc <- scNMFSet(count = mat, rowData = DataFrame(1:nrow(mat)),
               colData = DataFrame(1:ncol(mat)))
sc

## -----------------------------------------------------------------------------
# read 10x files
sc <- read_10x(dir = dir, count = 'matrix.mtx', genes = 'genes.tsv',
               barcodes = 'barcodes.tsv')
sc

## -----------------------------------------------------------------------------
# slots and subsetting
counts(sc)[1:7,1:3]
head(rowData(sc))
head(colData(sc))
sc2 <- sc[1:20,1:70]       # subsetting of object
sc2 <- remove_zeros(sc2)   # remove empty rows/columns
sc2

## ----cells, cache=T, fig.small=TRUE,fig.cap="Quality control filtering of cells. Histogram of UMI counts is shown. Cells can be selected (red) by setting lower and upper thresholds of the UMI count."----
sc <- filter_cells(sc, umi.min = 10^2.6, umi.max = 10^3.4)

## ----genes, cache=T, fig.small=TRUE, fig.cap="Selection of genes for clustering. The scatter plot shows distributions of expression variance to mean ratio (VMR) and the number of cells expressed. Minimum VMR and a range of cell number can be set to select genes (red). Symbols in orange are marker genes provided as input, selected irrespective of expression variance."----
markers <- c('CD4','CD8A','CD8B','CD19','CD3G','CD3D',
             'CD3Z','CD14')
sc0 <- filter_genes(sc, markers = markers, vmr.min = 1.5, 
            min.cells.expressed = 50, rescue.genes = FALSE)

## ----rescue, cache=T, echo=T, fig.small=TRUE, fig.cap='Additional selection of genes with modes at nonzero counts. Symbols in blue represent genes rescued.'----
sc_rescue <- filter_genes(sc, markers = markers, vmr.min = 1.5, min.cells.expressed = 50,
                          rescue.genes = TRUE, progress.bar = FALSE)

## ----cache=T------------------------------------------------------------------
rownames(sc_rescue) <- rowData(sc_rescue)[,2]
sc <- sc_rescue

## ----cache=T------------------------------------------------------------------
set.seed(1)
sc <- factorize(sc, ranks = 3, nrun = 1, ncnn.step = 1, 
                criterion='connectivity', verbose = 3)

## ----cache=T------------------------------------------------------------------
sc <- factorize(sc, ranks = 3, nrun = 5, verbose = 2)

## ----cache=T------------------------------------------------------------------
sc <- factorize(sc, ranks = seq(3,7), nrun = 5, verbose = 1, progress.bar = FALSE)

## -----------------------------------------------------------------------------
measure(sc)

## ----measure, fig.large=TRUE, fig.cap='Factorization quality measures as functions of the rank. Dispersion measures the degree of bimodality in consistency matrix. Cophenetic correlation measures the degree of agreement between consistency matrix and hierarchical clustering.'----
plot(sc)

## ----cache=T------------------------------------------------------------------
sb <- sc_rescue
set.seed(2)
sb <- vb_factorize(sb, ranks =3, verbose = 3, Tol = 2e-4, hyper.update.n0 = 5)

## ----cache=T------------------------------------------------------------------
sb <- vb_factorize(sb, ranks = seq(2,7), nrun = 5, verbose = 1, Tol = 1e-4, progress.bar = FALSE)

## -----------------------------------------------------------------------------
measure(sb)

## ----lml, fig.small=TRUE, fig.cap='Dependence of log ML with rank.'-----------
plot(sb)

## -----------------------------------------------------------------------------
optimal_rank(sb)

## -----------------------------------------------------------------------------
ranks(sb)

head(basis(sb)[ranks(sb)==5][[1]]) # basis matrix W for rank 5

## ----sb, cache=T, fig.small=TRUE, fig.cap='Heatmap of basis matrix elements. Marker genes selected in rows, other than those provided as input, are based on the degree to which each features strongly in a particular cluster only and not in the rest. Columns represent the clusters.'----
feature_map(sb, markers = markers, rank = 5, max.per.cluster = 4, gene.name = rowData(sb)[,2],
         cexRow = 0.7)

## -----------------------------------------------------------------------------
cell_type <- c('B_cell','CD8+_T','CD4+_T','Monocytes','NK')
colnames(basis(sb)[ranks(sb) == 5][[1]]) <- cell_type
rownames(coeff(sb)[ranks(sb) == 5][[1]]) <- cell_type

## ----sc, fig.small=TRUE, fig.cap = 'Heatmap of cluster coefficient matrix elements. Rows indicate clusters and columns the cells.'----
cell_map(sb, rank = 5)

## ----tsne, fig.cap='tSNE-based visualization of clustering. Coefficient matrix elements of cells were used as input with colors indicating predicted cluster assignment. The bar plot shows the cell counts of each cluster.'----
visualize_clusters(sb, rank = 5, cex = 0.7)

## ----tree, fig.small=TRUE, fig.cap = "Hierarchical tree of clusters derived from varying ranks. The rank increases from 2 to 5 horizontally and nodes are labeled by cluster IDs which bifurcated in each rank."----
tree <- build_tree(sb, rmax = 5)
tree <- rename_tips(tree, rank = 5, tip.labels = cell_type)
plot_tree(tree, cex = 0.8, show.node.label = TRUE)

