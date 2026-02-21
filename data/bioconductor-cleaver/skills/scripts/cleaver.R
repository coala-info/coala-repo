# Code example from 'cleaver' vignette. See references/ for full tutorial.

## ----environment, echo=FALSE, message=FALSE, warning=FALSE--------------------
library("cleaver")
library("UniProt.ws")
library("BRAIN")

## -----------------------------------------------------------------------------
library("cleaver")

## ----eval=FALSE---------------------------------------------------------------
# help("cleave")

## -----------------------------------------------------------------------------
## cleave it
cleave("LAAGKVEDSD", enzym="trypsin")
## get the cleavage ranges
cleavageRanges("LAAGKVEDSD", enzym="trypsin")
## get only cleavage sites
cleavageSites("LAAGKVEDSD", enzym="trypsin")

## -----------------------------------------------------------------------------
## miss one cleavage position
cleave("LAAGKVEDSD", enzym="trypsin", missedCleavages=1)
cleavageRanges("LAAGKVEDSD", enzym="trypsin", missedCleavages=1)
## miss zero or one cleavage positions
cleave("LAAGKVEDSD", enzym="trypsin", missedCleavages=0:1)
cleavageRanges("LAAGKVEDSD", enzym="trypsin", missedCleavages=0:1)

## -----------------------------------------------------------------------------
## create AAStringSet object
p <- AAStringSet(c(gaju="LAAGKVEDSD", pnm="AGEPKLDAGV"))

## cleave it
cleave(p, enzym="trypsin")
cleavageRanges(p, enzym="trypsin")
cleavageSites(p, enzym="trypsin")

## -----------------------------------------------------------------------------
## load UniProt.ws library
library("UniProt.ws")

## select species Homo sapiens
up <- UniProt.ws(taxId=9606)

## download sequences of Insulin/Somatostatin
s <- select(up,
    keys=c("P01308", "P61278"),
    columns=c("sequence"),
    keytype="UniProtKB"
)

## fetch only sequences
sequences <- setNames(s$Sequence, s$Entry)

## remove whitespaces
sequences <- gsub(pattern="[[:space:]]", replacement="", x=sequences)

## -----------------------------------------------------------------------------
cleave(sequences, enzym="pepsin")

## -----------------------------------------------------------------------------
## load BRAIN library
library("BRAIN")

## cleave insulin
cleavedInsulin <- cleave(sequences[1], enzym="trypsin")[[1]]

## create empty plot area
plot(NA, xlim=c(150, 4300), ylim=c(0, 1),
     xlab="mass", ylab="relative intensity",
     main="tryptic digested insulin - isotopic distribution")

## loop through peptides
for (i in seq(along=cleavedInsulin)) {
  ## count C, H, N, O, S atoms in current peptide
  atoms <- BRAIN::getAtomsFromSeq(cleavedInsulin[[i]])
  ## calculate isotopic distribution
  d <- useBRAIN(atoms)
  ## draw peaks
  lines(d$masses, d$isoDistr, type="h", col=2)
}

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

