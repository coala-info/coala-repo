# Code example from 'chargeHydropathy-vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 6,
  fig.height = 4
)

## ----setup--------------------------------------------------------------------
library(idpr)

## -----------------------------------------------------------------------------
#BiocManager::install("idpr")

## -----------------------------------------------------------------------------
#devtools::install_github("wmm27/idpr")

## -----------------------------------------------------------------------------
HUMAN_P53 <- TP53Sequences[2]
print(HUMAN_P53)

## -----------------------------------------------------------------------------
P53_msh <- meanScaledHydropathy(HUMAN_P53)
print(P53_msh)

## -----------------------------------------------------------------------------
P53_nc <- netCharge(HUMAN_P53,
                     averaged = TRUE)
print(P53_nc)

## ----include = FALSE----------------------------------------------------------
P53_msh <- round(P53_msh, 3)
P53_nc <- round(P53_nc, 3)

## -----------------------------------------------------------------------------
chargeHydropathyPlot(HUMAN_P53) +
  ggplot2::annotate("text",
                    x = P53_msh,
                    y = P53_nc + 0.1, #offset from point
                    label = paste("(", P53_msh, ", ", P53_nc, ")",
                                  collapse = "",
                                  sep = ""))

## -----------------------------------------------------------------------------
TP53_Sequences <- TP53Sequences
print(TP53_Sequences)

## -----------------------------------------------------------------------------
gg <- chargeHydropathyPlot(
  sequence = TP53_Sequences,
  pKaSet = "IPC_protein")
plot(gg)

## -----------------------------------------------------------------------------
chargeHydropathyPlot(
  sequence = TP53_Sequences,
  pKaSet = "EMBOSS")  #Using EMBOSS pKa set

## -----------------------------------------------------------------------------
foldIndexR(sequence = HUMAN_P53,
           plotResults = TRUE)

## -----------------------------------------------------------------------------
 meanScaledHydropathy(HUMAN_P53)

## -----------------------------------------------------------------------------
P53_shg <- scaledHydropathyGlobal(HUMAN_P53)
head(P53_shg)

## -----------------------------------------------------------------------------
scaledHydropathyGlobal(HUMAN_P53,
                       plotResults = TRUE)

## -----------------------------------------------------------------------------
P53_shg <- scaledHydropathyGlobal(HUMAN_P53)
sequenceMap(sequence = P53_shg$AA,
            property = P53_shg$Hydropathy,
            customColors = c("chocolate1", "grey65", "skyblue3"))

## -----------------------------------------------------------------------------
P53_shl <- scaledHydropathyLocal(HUMAN_P53,
                                 plotResults = FALSE)
head(P53_shl)

## -----------------------------------------------------------------------------
scaledHydropathyLocal(HUMAN_P53,
                       plotResults = TRUE)

## -----------------------------------------------------------------------------
scaledHydropathyLocal(HUMAN_P53,
                       window = 3,
                       plotResults = TRUE)

## -----------------------------------------------------------------------------
netCharge(HUMAN_P53)

## -----------------------------------------------------------------------------
netCharge(HUMAN_P53,
          averaged = TRUE)

## -----------------------------------------------------------------------------
netCharge(HUMAN_P53,
          pH = 5.5)
netCharge(HUMAN_P53,
          pH = 7)
netCharge(HUMAN_P53,
          pH = 8)

## -----------------------------------------------------------------------------
netCharge(HUMAN_P53,
          pKaSet = "IPC_protein")
netCharge(HUMAN_P53,
          pKaSet = "IPC_peptide")
netCharge(HUMAN_P53,
          pKaSet = "EMBOSS")


## ----include=FALSE------------------------------------------------------------
charged_aa <- c("C", "D", "E", "H", "K", "R", "Y", "NH3", "COO")
aa_pKa <- c(8.55, 3.67, 4.25, 6.54, 10.40, 12.3, 9.84, 9.28, 1.99)
custom_pKa <- data.frame(AA = charged_aa,
                         pKa = aa_pKa)

## -----------------------------------------------------------------------------
print(custom_pKa)

netCharge(HUMAN_P53,
          pKaSet = custom_pKa,
          includeTermini = FALSE)

## -----------------------------------------------------------------------------
P53_ccg <- chargeCalculationGlobal(HUMAN_P53)
head(P53_ccg)

## -----------------------------------------------------------------------------
chargeCalculationGlobal(HUMAN_P53,
                        plotResults = TRUE)

## -----------------------------------------------------------------------------
P53_ccg <- chargeCalculationGlobal(HUMAN_P53) #repeating from above
sequenceMap(sequence = P53_ccg$AA,
            property = P53_ccg$Charge,
            customColors = c("red", "blue", "grey65"))

## -----------------------------------------------------------------------------
P53_ccg <- chargeCalculationGlobal(HUMAN_P53,
                        sumTermini = FALSE)
head(P53_ccg)

## -----------------------------------------------------------------------------
P53_ccg <- chargeCalculationGlobal(HUMAN_P53,
                        includeTermini = FALSE)
head(P53_ccg)

## -----------------------------------------------------------------------------
P53_cgl <- chargeCalculationLocal(HUMAN_P53)
head(P53_cgl)

## -----------------------------------------------------------------------------
chargeCalculationLocal(HUMAN_P53,
                       plotResults = TRUE)

## -----------------------------------------------------------------------------
chargeCalculationLocal(HUMAN_P53,
                       window = 11,
                       plotResults = TRUE)

## -----------------------------------------------------------------------------
citation("ggplot2")

## -----------------------------------------------------------------------------
R.version.string

## -----------------------------------------------------------------------------
as.data.frame(Sys.info())

## -----------------------------------------------------------------------------
sessionInfo()

## ----results="asis"-----------------------------------------------------------
citation()

