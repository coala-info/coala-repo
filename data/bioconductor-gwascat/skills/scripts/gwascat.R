# Code example from 'gwascat' vignette. See references/ for full tutorial.

## ----setup,echo=FALSE,results="hide"------------------------------------------
suppressMessages({
suppressPackageStartupMessages({
 library(gwascat)
 library(dplyr)
 library(GenomeInfoDb)
 library(rtracklayer)
 library(ggbio)
})
})

## ----getlib,echo=FALSE,results='hide'-----------------------------------------
library(gwascat)

## ----dotidy-------------------------------------------------------------------
gwcat = get_cached_gwascat()
library(dplyr)
gwcat |> arrange(DATE)

## ----getgr--------------------------------------------------------------------
gg = gwcat |> as_GRanges()
gg

## ----dosei--------------------------------------------------------------------
library(GenomeInfoDb)
data(si.hs.38)
gg = keepStandardChromosomes(gg, pruning="coarse")
seqlevels(gg) = seqlevels(si.hs.38)
seqinfo(gg) = si.hs.38
gg

## ----lkadasd------------------------------------------------------------------
args(get_cached_gwascat)

## ----lkasdasdasd--------------------------------------------------------------
args(process_gwas_dataframe)

## ----lk1,echo=FALSE,results='hide'--------------------------------------------
if (length(grep("gwascat", search()))>0) detach("package:gwascat")

## ----lk2----------------------------------------------------------------------
library(gwascat)
objects("package:gwascat")

## ----lkgr---------------------------------------------------------------------
data(ebicat_2020_04_30)
gwtrunc = ebicat_2020_04_30

## ----lktr---------------------------------------------------------------------
topTraits(gwtrunc)

## ----lklocs-------------------------------------------------------------------
subsetByTraits(gwtrunc, tr="LDL cholesterol")[1:3]

## ----lkm,results='hide'-------------------------------------------------------
requireNamespace("S4Vectors")
mcols = S4Vectors::mcols
mlpv = mcols(gwtrunc)$PVALUE_MLOG
mlpv = ifelse(mlpv > 25, 25, mlpv)
S4Vectors::mcols(gwtrunc)$PVALUE_MLOG = mlpv
library(GenomeInfoDb)
# seqlevelsStyle(gwtrunc) = "UCSC" # no more!
seqlevels(gwtrunc) = paste0("chr", seqlevels(gwtrunc))
gwlit = gwtrunc[ which(as.character(seqnames(gwtrunc)) %in% c("chr4", "chr5", "chr6")) ]
library(ggbio)
mlpv = mcols(gwlit)$PVALUE_MLOG
mlpv = ifelse(mlpv > 25, 25, mlpv)
S4Vectors::mcols(gwlit)$PVALUE_MLOG = mlpv

## ----dorunap------------------------------------------------------------------
autoplot(gwlit, geom="point", aes(y=PVALUE_MLOG), xlab="chr4-chr6")

## ----runit,eval=TRUE----------------------------------------------------------
traitsManh(gwtrunc)

## ----getgd--------------------------------------------------------------------
gffpath = system.file("gff3/chr17_43000000_45000000.gff3", package="gwascat")
library(rtracklayer)
c17tg = import(gffpath)

## ----lkgvt--------------------------------------------------------------------
c17td = c17tg[ which(S4Vectors::mcols(c17tg)$type == "Degner_dsQTL") ]
library(Gviz)
dsqs = DataTrack( c17td, chrom="chr17", genome="hg19", data="score",
  name="dsQTL")

## ----dost---------------------------------------------------------------------
g2 = GRanges(seqnames="chr17", IRanges(start=4.3e7, width=2e6))

basic = gwcex2gviz(basegr = gwtrunc, contextGR=g2, plot.it=FALSE) 

## ----getstr-------------------------------------------------------------------
c17ts = c17tg[ which(S4Vectors::mcols(c17tg)$type == "Stranger_eqtl") ]
eqloc = AnnotationTrack(c17ts,  chrom="chr17", genome="hg19", name="Str eQTL")
displayPars(eqloc)$col = "black"
displayPars(dsqs)$col = "red"
integ = list(basic[[1]], eqloc, dsqs, basic[[2]], basic[[3]])

## ----doplot-------------------------------------------------------------------
plotTracks(integ)

## ----dobig,eval=FALSE---------------------------------------------------------
# library(pd.genomewidesnp.6)
# con = pd.genomewidesnp.6@getdb()
# locon6 = dbGetQuery(con,
#    "select dbsnp_rs_id, chrom, physical_pos from featureSet limit 10000")

## ----doloc--------------------------------------------------------------------
data(locon6)
rson6 = as.character(locon6[[1]])
rson6[1:5]

## ----lkdtab-------------------------------------------------------------------
intr = gwtrunc[ intersect(getRsids(gwtrunc), rson6) ]
sort(table(getTraits(intr)), decreasing=TRUE)[1:10]

## ----lkexp,keep.source=TRUE---------------------------------------------------
#gr6.0 = GRanges(seqnames=ifelse(is.na(locon6$chrom),0,locon6$chrom), 
#       IRanges(ifelse(is.na(locon6$phys),1,locon6$phys), width=1))
#S4Vectors::mcols(gr6.0)$rsid = as.character(locon6$dbsnp_rs_id)
#seqlevels(gr6.0) = paste("chr", seqlevels(gr6.0), sep="")
data(gr6.0_hg38)

## ----dosub--------------------------------------------------------------------
ag = function(x) as(x, "GRanges")
ovraw = suppressWarnings(subsetByOverlaps(ag(gwtrunc), gr6.0_hg38))
length(ovraw)
ovaug = suppressWarnings(subsetByOverlaps(ag(gwtrunc+500), gr6.0_hg38))
length(ovaug)

## ----dosub2-------------------------------------------------------------------
rawrs = mcols(ovraw)$SNPS
augrs = mcols(ovaug)$SNPS
gwtrunc[augrs]

## ----lkrelax------------------------------------------------------------------
nn = setdiff( getTraits(gwtrunc[augrs]), getTraits(gwtrunc[rawrs]) )
length(nn)
head(nn)
tail(nn)

## ----lkcout-------------------------------------------------------------------
data(gg17N) # translated from GGdata chr 17 calls using ABmat2nuc
gg17N[1:5,1:5]

## ----dorun--------------------------------------------------------------------
h17 = riskyAlleleCount(gg17N, matIsAB=FALSE, chr="ch17",
 gwwl = gwtrunc)
h17[1:5,1:5]
table(as.numeric(h17))

## ----domo---------------------------------------------------------------------
gwr = gwtrunc
gwr = gwr[colnames(h17),]
S4Vectors::mcols(gwr) = cbind(mcols(gwr), DataFrame(t(h17)))
sn = rownames(h17)
gwr[,c("DISEASE/TRAIT", sn[1:4])]

## ----getdo--------------------------------------------------------------------
library(DO.db)
DO()

## ----getallt------------------------------------------------------------------
alltob = unlist(mget(mappedkeys(DOTERM), DOTERM))
allt = sapply(alltob, Term)
allt[1:5]

## ----dohit--------------------------------------------------------------------
cattra = mcols(gwtrunc)$`DISEASE/TRAIT`
mat = match(tolower(cattra), tolower(allt))
catDO = names(allt)[mat]
na.omit(catDO)[1:50]
mean(is.na(catDO))

## ----dogr---------------------------------------------------------------------
unique(cattra[is.na(catDO)])[1:20]
nomatch = cattra[is.na(catDO)]
unique(nomatch)[1:5]

## ----dopar,cache=FALSE--------------------------------------------------------
hpobo = gzfile(dir(system.file("obo", package="gwascat"), pattern="hpo", full=TRUE))
HPOgraph = obo2graphNEL(hpobo)
close(hpobo)

## ----dohpot-------------------------------------------------------------------
requireNamespace("graph")
hpoterms = unlist(graph::nodeData(HPOgraph, graph::nodes(HPOgraph), "name"))
hpoterms[1:10]

## ----lkint--------------------------------------------------------------------
intersect(tolower(nomatch), tolower(hpoterms))

## ----chkcadd,eval=FALSE-------------------------------------------------------
# g3 = as(gwtrunc, "GRanges")
# bg3 = bindcadd_snv( g3[which(seqnames(g3)=="chr3")][1:20] )
# inds = ncol(mcols(bg3))
# bg3[, (inds-3):inds]

## ----getrs,keep.source=TRUE,cache=FALSE,eval=FALSE----------------------------
# if ("SNPlocs.Hsapiens.dbSNP144.GRCh37" %in% installed.packages()[,1]) {
#  library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
#  chklocs("20", gwtrunc)
# }

