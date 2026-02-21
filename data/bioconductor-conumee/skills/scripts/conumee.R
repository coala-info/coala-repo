# Code example from 'conumee' vignette. See references/ for full tutorial.

## ----echo = TRUE, collapse = TRUE, results = 'markup', warning = FALSE, message = FALSE----
library("minfi")
library("conumee")
#RGsetTCGA <- read.450k.exp(base = "~/conumee_analysis/jhu-usc.edu_BRCA.HumanMethylation450.Level_1.8.8.0")  # adjust path
RGsetTCGA <- read.450k.url()  # use default parameters for vignette examples
MsetTCGA <- preprocessIllumina(RGsetTCGA)
MsetTCGA

## ----echo = TRUE, collapse = TRUE, results = 'markup', warning = FALSE, message = FALSE----
library("minfiData")
data(MsetEx)
MsetEx

## ----echo = TRUE, collapse = TRUE, results = 'markup', warning = FALSE, message = FALSE----
# library("CopyNumber450kData")
# data(RGcontrolSetEx)
# MsetControls <- preprocessIllumina(RGcontrolSetEx)

## ----echo = TRUE, collapse = TRUE, results = 'markup', warning = TRUE, message = TRUE----
data(exclude_regions)
data(detail_regions)
head(detail_regions, n = 2)

anno <- CNV.create_anno(array_type = "450k", exclude_regions = exclude_regions, detail_regions = detail_regions)

anno

## ----echo = TRUE, collapse = TRUE, results = 'markup', warning = FALSE, message = FALSE----
data(tcgaBRCA.sentrix2name)  # TCGA sample IDs are supplied with the conumee package
sampleNames(MsetTCGA) <- tcgaBRCA.sentrix2name[sampleNames(MsetTCGA)]
tcga.data <- CNV.load(MsetTCGA)
tcga.controls <- grep("-11A-", names(tcga.data))
names(tcga.data)
tcga.data

minfi.data <- CNV.load(MsetEx)
minfi.controls <- pData(MsetEx)$status == "normal"

# controls.data <- CNV.load(MsetControls)

## ----echo = TRUE, collapse = TRUE, results = 'markup', warning = FALSE, message = FALSE----
x <- CNV.fit(minfi.data["GroupB_1"], minfi.data[minfi.controls], anno)
# y <- CNV.fit(tcga.data["TCGA-AR-A1AU-01A-11D-A12R-05"], controls.data, anno)  # CopyNumber450kData package is deprecated
# z <- CNV.fit(tcga.data["TCGA-AR-A1AY-01A-21D-A12R-05"], controls.data, anno)
y <- CNV.fit(tcga.data["TCGA-AR-A1AU-01A-11D-A12R-05"], minfi.data[minfi.controls], anno)  # minfiData control samples
z <- CNV.fit(tcga.data["TCGA-AR-A1AY-01A-21D-A12R-05"], minfi.data[minfi.controls], anno)

x <- CNV.bin(x)
x <- CNV.detail(x)
x <- CNV.segment(x)

y <- CNV.segment(CNV.detail(CNV.bin(y)))
z <- CNV.segment(CNV.detail(CNV.bin(z)))

x

## ----echo = TRUE, fig.show = 'hold', collapse = TRUE, results = 'markup', warning = FALSE, message = FALSE, fig.width = 14, fig.height = 7, out.width = "800px", fig.retina = 1----
#pdf("~/conumee_analysis/CNVplots.pdf", height = 9, width = 18)
CNV.genomeplot(x)

CNV.genomeplot(y)
CNV.genomeplot(y, chr = "chr6")

CNV.genomeplot(z)
CNV.genomeplot(z, chr = "chr10")
CNV.detailplot(z, name = "PTEN")
CNV.detailplot_wrap(z)
#dev.off()

head(CNV.write(y, what = "segments"), n = 5)

#CNV.write(y, what = "segments", file = "~/conumee_analysis/TCGA-AR-A1AU.CNVsegments.seg")  # adjust path
#CNV.write(y, what = "bins", file = "~/conumee_analysis/TCGA-AR-A1AU.CNVbins.igv")
#CNV.write(y, what = "detail", file = "~/conumee_analysis/TCGA-AR-A1AU.CNVdetail.txt")
#CNV.write(y, what = "probes", file = "~/conumee_analysis/TCGA-AR-A1AU.CNVprobes.igv")

## ----echo = TRUE, collapse = TRUE, results = 'markup', warning = FALSE, message = FALSE----
citation("conumee")

## ----echo = TRUE, collapse = TRUE, results = 'markup', warning = FALSE, message = FALSE----
sessionInfo()

