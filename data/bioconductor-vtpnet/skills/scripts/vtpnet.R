# Code example from 'vtpnet' vignette. See references/ for full tutorial.

### R code from vignette source 'vtpnet.Rnw'

###################################################
### code chunk number 1: lkco
###################################################
#
# tags formatted for display
#
diseaseTags = c("Ankylosing\\\nspondylitis", "Asthma",
      "Celiac\\\ndisease", "Crohn's\\\ndisease",
      "Multiple\\\nsclerosis", "Primary\\\nbiliary\\\ncirrhosis",
      "Psoriasis", "Rheumatoid\\\narthritis", 
      "Systemic\\\nlupus\\\nerythematosus",
      "Systemic\\\nsclerosis", "Type 1\\\ndiabetes", 
      "Ulcerative\\\ncolitis"
)
TFtags = c("ELF3", "MEF2A", "TCF3", "PAX4", "STAT3",
   "ESR1", "POU2F1", "STAT1", "YY1", "SP1", "CDC5L",
   "NR3C1", "EGR1", "PPARG", "HNF4A", "REST", "PPARA",
   "AR", "NFKB1", "HNF1A", "TFAP2A")
# define adjacency matrix
adjm = matrix(1, nr=length(diseaseTags), nc=length(TFtags))
dimnames(adjm) = list(diseaseTags, TFtags)
library(graph)
cvtp = ugraph(aM2bpG(adjm)) # complete (V)TP network; variants not involved yet


###################################################
### code chunk number 2: dog1
###################################################
library(Rgraphviz)
#flat = function(x, g) c(x, edges(g)[[x]])
#sub = subGraph(unique(c(flat("Crohn's\\\ndisease", cvtp), 
#    flat("Ulcerative\\\ncolitis", cvtp))), cvtp)
sub = subGraph(unique(c(diseaseTags[1:4], TFtags[1:6])), cvtp)
plot(sub, attrs=list(node=list(shape="box", fixedsize=FALSE)))
#plot(cvtp, attrs=list(graph=list(margin=c(.5,.5), size=c(4.1,4.1)), 
#   node=list(shape="box", fixedsize=FALSE, height=1)))


###################################################
### code chunk number 3: lkvd
###################################################
library(vtpnet)
data(maurGWAS)
length(maurGWAS)
names(values(maurGWAS))


###################################################
### code chunk number 4: lkpax
###################################################
data(pax4)
length(pax4)
pax4[1:4]


###################################################
### code chunk number 5: lksearch (eval = FALSE)
###################################################
## library(foreach)
## library(doParallel)
## registerDoParallel(cores=12)
## library(BSgenome.Hsapiens.UCSC.hg19)
## library(MotifDb)
## sn = seqnames(Hsapiens)[1:24]
## pax4 = query(MotifDb, "pax4")[[1]]
## ans = foreach(i=1:24) %dopar% {
##  cat(i)
##  subj = Hsapiens[[ sn[i] ]]
##  matchPWM( pax4, subj, "75%" )
## }
## pax4_75 = 
##  do.call(c, lapply(1:length(ans), function(x) 
##   {GRanges(sn[x], as(ans[[x]], "IRanges"))}))
## save(pax4_75, file="pax4_75.rda")


###################################################
### code chunk number 6: lkmat
###################################################
data(pax4_85)
vp_pax4_85 = maurGWAS[ overlapsAny(maurGWAS, pax4_85) ]
length(vp_pax4_85)
data(pax4_75)
vp_pax4_75 = maurGWAS[ overlapsAny(maurGWAS, pax4_75) ]
length(vp_pax4_75)


###################################################
### code chunk number 7: lkfim
###################################################
vp_pax4_fimo = maurGWAS[ overlapsAny(maurGWAS, pax4) ]
length(vp_pax4_fimo)


###################################################
### code chunk number 8: lkta
###################################################
u75 = unique(vp_pax4_75$disease_trait)
ufimo = unique(vp_pax4_fimo$disease_trait)
length(setdiff(u75, ufimo))
length(setdiff(ufimo, u75))


###################################################
### code chunk number 9: domap
###################################################
data(cancerMap)
requireNamespace("gwascat")
load(system.file("legacy/gwrngs19.rda", package="gwascat"))
cangw = filterGWASbyMap( gwrngs19, cancerMap )
getOneHits( pax4, cangw, "fimo" )


###################################################
### code chunk number 10: algiz
###################################################
altize = function(chtag = "21",
#
# from sketch by Herve Pages, May 2013
#
  slpack="SNPlocs.Hsapiens.dbSNP.20120608",
  hgpack ="BSgenome.Hsapiens.UCSC.hg19",
  faElFun = function(x) sub("%%TAG%%", x, "alt%%TAG%%chr"),
  faTargFun = function(x) 
     sub("%%TAG%%", x, "alt%%TAG%%_hg19.fa")) {
    require(slpack, character.only=TRUE)
    require(hgpack, character.only=TRUE)
    require("ShortRead", character.only=TRUE)
    chk = grep("ch|chr", chtag)
    if (length(chk)>0) {
      warning("clearing prefix ch or chr from chtag")
      chtag = gsub("ch|chr", "", chtag)
      }
    snpgettag = paste0("ch", chtag)
    ggettag = paste0("chr", chtag)
    cursnps = getSNPlocs(snpgettag, as.GRanges=TRUE)
    curgenome = unmasked(Hsapiens[[ggettag]])
    ref_allele = 
     strsplit(as.character(curgenome[start(cursnps)]),
        NULL, fixed=TRUE)[[1L]]
    all_alleles = IUPAC_CODE_MAP[cursnps$alleles_as_ambig]
    alt_alleles = mapply( function(ref,all)
      sub(ref, "", all, fixed=TRUE),
        ref_allele, all_alleles, USE.NAMES=FALSE)
    cursnps$ref_allele = ref_allele
    cursnps$alt_alleles = alt_alleles
    cursnps$one_alt = substr(cursnps$alt_alleles, 1, 1)
    altg = list(replaceLetterAt(curgenome, start(cursnps),
      cursnps$one_alt))
    names(altg) = faElFun(chtag)
    writeFasta(DNAStringSet(altg), file=faTargFun(chtag))
}


###################################################
### code chunk number 11: lksess
###################################################
sessionInfo()


