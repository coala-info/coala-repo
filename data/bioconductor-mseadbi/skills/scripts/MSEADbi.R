# Code example from 'MSEADbi' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library('MSEADbi')
tmp <- tempdir()

ath <- system.file("extdata","MSEA.Ath.pb.db_DATA.csv",package="MSEADbi")
meta <- system.file("extdata","MSEA.Ath.pb.db_METADATA.csv",package="MSEADbi")
athDf <- read.csv(ath, fileEncoding="utf8")
metaDf <- read.csv(meta)
# We need to avoid DOT from the column names (to query with the names)
names(athDf) <- gsub("\\.", "", names(athDf))
names(metaDf) <- gsub("\\.", "", names(metaDf))

makeMSEAPackage(pkgname = "MSEA.Ath.pb.db", data=athDf, metadata=metaDf,
organism = "Arabidopsis thaliana", version = "0.99.0",
maintainer = "Kozo Nishida <kozo.nishida@gmail.com>", author = "Kozo Nishida",
destDir = tmp, license = "Artistic-2.0")

mseaPackageDir = paste(tmp, "MSEA.Ath.pb.db", sep="/")
install.packages(mseaPackageDir, repos=NULL, type="source")


## -----------------------------------------------------------------------------
library(AnnotationDbi)
library(MSEA.Ath.pb.db)

columns(MSEA.Ath.pb.db)
keytypes(MSEA.Ath.pb.db)
ids <- c('SMP0012018', 'SMP0012019')
select(MSEA.Ath.pb.db, ids, c("MetaboliteID", "CAS", "HMDBID", "ChEBIID", 
    "KEGGID"), "PathBankID")

cls <- columns(MSEA.Ath.pb.db)
kts <- keytypes(MSEA.Ath.pb.db)
kt <- kts[2]
ks <- head(keys(MSEA.Ath.pb.db, keytype = kts[2]))
res <- select(MSEA.Ath.pb.db, keys = ks, columns = cls, keytype = kt)
head(res)

## -----------------------------------------------------------------------------
species(MSEA.Ath.pb.db)
dbInfo(MSEA.Ath.pb.db)
dbfile(MSEA.Ath.pb.db)
dbschema(MSEA.Ath.pb.db)
dbconn(MSEA.Ath.pb.db)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

