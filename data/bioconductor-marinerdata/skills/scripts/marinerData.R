# Code example from 'marinerData' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(marinerData)
hicFiles <- c(
    LEUK_HEK_PJA27_inter_30.hic(),
    LEUK_HEK_PJA30_inter_30.hic()
)
names(hicFiles) <- c("FS", "WT")
hicFiles

## -----------------------------------------------------------------------------
library(marinerData)
nha9Loops <- c(
  FS_5kbLoops.txt(),
  WT_5kbLoops.txt()
)

## -----------------------------------------------------------------------------
library(marinerData)
limaLoops <- c(
  LIMA_0000.bedpe(),
  LIMA_0030.bedpe(),
  LIMA_0060.bedpe(),
  LIMA_0090.bedpe(),
  LIMA_0120.bedpe(),
  LIMA_0240.bedpe(),
  LIMA_0360.bedpe(),
  LIMA_1440.bedpe()
)
names(limaLoops) <- c(
  "LIMA_0000",
  "LIMA_0030",
  "LIMA_0060",
  "LIMA_0090",
  "LIMA_0120",
  "LIMA_0240",
  "LIMA_0360",
  "LIMA_1440"
)
limaLoops

## -----------------------------------------------------------------------------
sessionInfo()

