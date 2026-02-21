# Code example from 'LRBaseDbi' vignette. See references/ for full tutorial.

### R code from vignette source 'LRBaseDbi.Rnw'

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: LRBaseDbi.Rnw:53-60
###################################################
library("LRBaseDbi")
library("AnnotationHub")
ah <- AnnotationHub()
dbfile <- query(ah, c("LRBaseDb", "Sus scrofa"))[[1]]

# Constructor
LRBase.Ssc.eg.db <- LRBaseDbi::LRBaseDb(dbfile)


###################################################
### code chunk number 3: LRBaseDbi.Rnw:73-80
###################################################
if(interactive()){
  (cols <- columns(LRBase.Ssc.eg.db))
  keytypes(LRBase.Ssc.eg.db)
  (ks <- keys(LRBase.Ssc.eg.db, keytype='GENEID_R'))
  head(select(LRBase.Ssc.eg.db, keys=ks[1:2],
       columns=c('GENEID_L', 'GENEID_R'), keytype='GENEID_R'))
}


###################################################
### code chunk number 4: LRBaseDbi.Rnw:97-117
###################################################
if(interactive()){
  # show
  LRBase.Ssc.eg.db
  # dbconn
  dbconn(LRBase.Ssc.eg.db)
  # dbfile
  dbfile(LRBase.Ssc.eg.db)
  # dbschema
  dbschema(LRBase.Ssc.eg.db)
  # dbInfo
  dbInfo(LRBase.Ssc.eg.db)
  # species
  species(LRBase.Ssc.eg.db)
  # lrNomenclature
  lrNomenclature(LRBase.Ssc.eg.db)
  # lrListDatabases
  lrListDatabases(LRBase.Ssc.eg.db)
  # lrVersion
  lrVersion(LRBase.Ssc.eg.db)
}


###################################################
### code chunk number 5: LRBaseDbi.Rnw:138-146
###################################################
if(interactive()){
  if (!requireNamespace('BiocManager', quietly = TRUE)){
    install.packages('BiocManager')
  }
  BiocManager::install('scTensor')
  library('scTensor')
  vignette('scTensor')
}


