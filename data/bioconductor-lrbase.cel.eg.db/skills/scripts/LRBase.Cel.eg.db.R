# Code example from 'LRBase.Cel.eg.db' vignette. See references/ for full tutorial.

### R code from vignette source 'LRBase.Cel.eg.db.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: style-Sweave
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: LRBase.Cel.eg.db.Rnw:45-49
###################################################
library('LRBase.Cel.eg.db')
if(interactive()){
  example('makeLRBasePackage')
}


###################################################
### code chunk number 3: LRBase.Cel.eg.db.Rnw:55-60
###################################################
if(interactive()){
  filepath <- list.files(destination, full.names=TRUE)
  install.packages(filepath, repos=NULL, type='source')
  library('FANTOM5.Hsa.eg.db')
}


###################################################
### code chunk number 4: LRBase.Cel.eg.db.Rnw:67-74
###################################################
if(interactive()){
  columns(FANTOM5.Hsa.eg.db)
  keytypes(FANTOM5.Hsa.eg.db)
  key_FN5 <- keys(FANTOM5.Hsa.eg.db, keytype='GENEID_R')
  head(select(FANTOM5.Hsa.eg.db, keys=key_FN5[1:2],
       columns=c('GENEID_L', 'GENEID_R'), keytype='GENEID_R'))
}


###################################################
### code chunk number 5: LRBase.Cel.eg.db.Rnw:80-89
###################################################
if(interactive()){
  species(FANTOM5.Hsa.eg.db)
  nomenclature(FANTOM5.Hsa.eg.db)
  listDatabases(FANTOM5.Hsa.eg.db)
  dbInfo(FANTOM5.Hsa.eg.db)
  dbfile(FANTOM5.Hsa.eg.db)
  dbschema(FANTOM5.Hsa.eg.db)
  dbconn(FANTOM5.Hsa.eg.db)
}


###################################################
### code chunk number 6: LRBase.Cel.eg.db.Rnw:106-114
###################################################
if(interactive()){
  if (!requireNamespace('BiocManager', quietly = TRUE)){
    install.packages('BiocManager')
  }
  BiocManager::install('scTensor')
  library('scTensor')
  vignette('scTensor')
}


