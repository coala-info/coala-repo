# Code example from 'PSM' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----setup, message = FALSE, echo = FALSE-------------------------------------
library("PSMatch")

## -----------------------------------------------------------------------------
f <- msdata::ident(full.names = TRUE, pattern = "TMT")
basename(f)

## -----------------------------------------------------------------------------
library("PSMatch")
id <- PSM(f)
id

## ----echo = FALSE-------------------------------------------------------------
n_matches <- nrow(id)
n_scans <- length(unique(id$spectrumID))
n_seqs <- length(unique(id$sequence))
n_cols <- ncol(id)

## -----------------------------------------------------------------------------
nrow(id) ## number of matches
length(unique(id$spectrumID)) ## number of scans
length(unique(id$sequence))   ## number of peptide sequences
names(id)

## -----------------------------------------------------------------------------
table(id$isDecoy)

## -----------------------------------------------------------------------------
table(table(id$spectrumID))

## -----------------------------------------------------------------------------
i <- grep("scan=1774", id$spectrumID)
id[i, ]
id[i, "DatabaseAccess"]

## ----warning = FALSE----------------------------------------------------------
id2 <- reducePSMs(id, id$spectrumID)
rownames(id2) <- NULL ## rownames not needed here
dim(id2)

## -----------------------------------------------------------------------------
j <- grep("scan=1774", id2$spectrumID)
id2[j, ]

## -----------------------------------------------------------------------------
id2[j, "DatabaseAccess"]

## -----------------------------------------------------------------------------
id <- filterPsmDecoy(id)
id

## -----------------------------------------------------------------------------
id <- filterPsmRank(id)
id

## -----------------------------------------------------------------------------
id[id$sequence == "QKTRCATRAFKANKGRAR", "DatabaseAccess"]

## -----------------------------------------------------------------------------
id <- filterPsmShared(id)
id

## -----------------------------------------------------------------------------
id <- PSM(f)
filterPSMs(id)

## ----warning = FALSE----------------------------------------------------------
system.time(id1 <- PSM(f, parser = "mzR"))
system.time(id2 <- PSM(f, parser = "mzID"))

## -----------------------------------------------------------------------------
names(id1)
names(id2)

## -----------------------------------------------------------------------------
nrow(id1)
nrow(id2)

## -----------------------------------------------------------------------------
table(id1$isDecoy)
table(id2$isdecoy)

## -----------------------------------------------------------------------------
id1_filtered <- filterPSMs(id1)

id2_filtered <- filterPSMs(id2)

## -----------------------------------------------------------------------------
identical(sort(unique(id1_filtered$spectrumID)),
          sort(unique(id2_filtered$spectrumid)))

## -----------------------------------------------------------------------------
anyDuplicated(id2_filtered$spectrumid)

## -----------------------------------------------------------------------------
table(table(id1_filtered$spectrumID))

## -----------------------------------------------------------------------------
k <- names(which(table(id1_filtered$spectrumID) == 4))
id1_filtered[id1_filtered$spectrumID == k, "sequence"]
id1_filtered[id1_filtered$spectrumID == k, "modLocation"]
id1_filtered[id1_filtered$spectrumID == k, "modName"]

## -----------------------------------------------------------------------------
id1_filtered$modLocation <- NULL
nrow(unique(id1_filtered))
nrow(unique(id2_filtered))

## ----si-----------------------------------------------------------------------
sessionInfo()

