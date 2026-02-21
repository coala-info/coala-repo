# Code example from 'sequenceMAP-vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 6,
  fig.height = 4
)

## -----------------------------------------------------------------------------
#BiocManager::install("idpr")

## -----------------------------------------------------------------------------
#devtools::install_github("wmm27/idpr")

## ----setup--------------------------------------------------------------------
library(idpr) #load the idpr package

## -----------------------------------------------------------------------------
P53_HUMAN <- TP53Sequences[2]
print(P53_HUMAN)

## -----------------------------------------------------------------------------
tendencyDF <- structuralTendency(sequence = P53_HUMAN)
head(tendencyDF)

chargeDF <- chargeCalculationGlobal(sequence = P53_HUMAN,
                                    includeTermini = FALSE)
head(chargeDF)


## -----------------------------------------------------------------------------
sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency)

sequenceMap(
  sequence = as.character(chargeDF$AA),
  property = chargeDF$Charge, #character vector
  customColors = c("blue", "red", "grey30"))


## -----------------------------------------------------------------------------
sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  labelType = "AA") #Only AA residue Labels

sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  labelType = "number") #Only residue numner labels

## -----------------------------------------------------------------------------
sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  labelType = "number",
  labelLocation = "on") #Residue numbers printed on the sequence graphic


sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  labelType = "number",
  labelLocation = "below") #Residue numbers printed below the sequence graphic

## -----------------------------------------------------------------------------
sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  labelType = "number",
  labelLocation = "on",
  rotationAngle = 90)

## -----------------------------------------------------------------------------
sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  labelType = "number",
  labelLocation = "on",
  everyN = 1) #Every residue

sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  labelType = "number",
  labelLocation = "on",
  everyN = 2) #Every 2nd (or every other)

sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  labelType = "number",
  labelLocation = "on",
  everyN = 10) #Every 10th residue is printed

## -----------------------------------------------------------------------------
sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  labelType = "number",
  labelLocation = "on",
  nbResidues = 15) #15 residues each row

sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  labelType = "number",
  labelLocation = "on",
  nbResidues = 45,
  rotationAngle = 90) #45 residues each row

## -----------------------------------------------------------------------------
sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  customColors = c("#999999", "#E69F00", "#56B4E9"))

## -----------------------------------------------------------------------------
sequenceMap(
  sequence = as.character(chargeDF$AA),
  property = chargeDF$Charge,
  customColors = c("purple", "pink", "grey90")
  )

## -----------------------------------------------------------------------------
library(ggplot2)

ggSequence <- sequenceMap(
  sequence = tendencyDF$AA,
  property = tendencyDF$Tendency,
  nbResidues = 40,
  customColors = c("#999999", "#E69F00", "#56B4E9"))

    # Adding Annotations of DNA Binding from UniProt
ggSequence <- ggSequence +
              annotate("segment",
                       x = 21,
                       xend  = 40.5,
                        y = 8.05,
                        yend = 8.05,
                       color = "#FF3562",
                       size = 1.5) +
              annotate("segment",
                       x = 1,
                       xend  = 12.5,
                        y = 3.05,
                        yend = 3.05,
                       color = "#FF3562",
                       size = 1.5) +
              annotate("segment",
                       x = 1,
                       xend  = 40.5,
                        y = c(7:4) + 0.05,
                        yend = c(7:4) + 0.05,
                       color = "#FF3562",
                       size = 1.5) +
               annotate("segment",
                        x = 34,
                        xend = 36,
                        y = 0.65,
                        yend = 0.65,
                        color = "#FF3562",
                       size = 1.5) +
              annotate("text",
                       x = 36.35,
                       y = 0.65,
                       label = "= DNA Binding",
                       size = 3.5,
                       hjust = 0)
# Adding a plot title
ggSequence <- ggSequence +
              labs(title = "P53 Structural Tendency") +
              theme(plot.title = element_text(hjust = 0.5,
                                              vjust = 2.5))
# Adding point and text annotations
ggSequence <- ggSequence +
              geom_point(aes(x = 2.5, #column 2
                             y = 4), #row 4
                         shape = 8,
                         show.legend = FALSE,
                         inherit.aes = FALSE) +
              annotate("text",
                       x = 4.5,
                       y = 4.3,
                       label = "Metal Binding",
                        size = 3)

plot(ggSequence)

## -----------------------------------------------------------------------------
coord_DF <- sequenceMapCoordinates(P53_HUMAN,
                                   nbResidues = 40)
head(coord_DF)

## -----------------------------------------------------------------------------
exampleDF <- chargeCalculationGlobal(P53_HUMAN,
                                     includeTermini = FALSE)

#Making a sequence plot
sequencePlot(
  position = exampleDF$Position,
  property = exampleDF$Charge)

#Adding a dynamic colors based on the property values and horizontal lines
sequencePlot(
position = exampleDF$Position,
  property = exampleDF$Charge,
hline = 0.0,
propertyLimits = c(-1.0, 1.0),
dynamicColor = exampleDF$Charge,
customColors = c("red", "blue", "grey50"),
customTitle = "Charge of Each Residue / Terminus")

## -----------------------------------------------------------------------------
citation("ggplot2")

## -----------------------------------------------------------------------------
R.version.string

## -----------------------------------------------------------------------------
as.data.frame(Sys.info())

## ----results="asis"-----------------------------------------------------------
citation()

