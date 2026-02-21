# Code example from 'crisprBase' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide"-----------------------------------------------
options("knitr.graphics.auto_pdf"=TRUE, eval=TRUE)

## ----warnings=FALSE, message=FALSE--------------------------------------------
library(crisprBase)

## ----warning=FALSE, message=FALSE---------------------------------------------
library(crisprBase)

EcoRI <- Nuclease("EcoRI",
                  targetType="DNA",
                  motifs=c("G^AATTC"),
                  metadata=list(description="EcoRI restriction enzyme"))

## -----------------------------------------------------------------------------
HgaI <- Nuclease("HgaI",
                 targetType="DNA",
                 motifs=c("GACGC(5/10)"),
                 metadata=list(description="HgaI restriction enzyme"))

## -----------------------------------------------------------------------------
PfaAI <- Nuclease("PfaAI",
                  targetType="DNA",
                  motifs=c("G^GYRCC"),
                  metadata=list(description="PfaAI restriction enzyme"))

## -----------------------------------------------------------------------------
motifs(PfaAI)

## -----------------------------------------------------------------------------
motifs(PfaAI, expand=TRUE)

## ----echo=FALSE, fig.cap="Examples of restriction enzymes"--------------------
knitr::include_graphics("./figures/enzymes.svg")

## -----------------------------------------------------------------------------
SpCas9 <- CrisprNuclease("SpCas9",
                         targetType="DNA",
                         pams=c("(3/3)NGG", "(3/3)NAG", "(3/3)NGA"),
                         weights=c(1, 0.2593, 0.0694),
                         metadata=list(description="Wildtype Streptococcus pyogenes Cas9 (SpCas9) nuclease"),
                         pam_side="3prime",
                         spacer_length=20)
SpCas9

## -----------------------------------------------------------------------------
SaCas9 <- CrisprNuclease("SaCas9",
                         targetType="DNA",
                         pams=c("(3/3)NNGRRT"),
                         metadata=list(description="Wildtype Staphylococcus 
                         aureus Cas9 (SaCas9) nuclease"),
                         pam_side="3prime",
                         spacer_length=21)
SaCas9

## -----------------------------------------------------------------------------
AsCas12a <- CrisprNuclease("AsCas12a",
                           targetType="DNA",
                           pams="TTTV(18/23)",
                           metadata=list(description="Wildtype Acidaminococcus
                           Cas12a (AsCas12a) nuclease."),
                           pam_side="5prime",
                           spacer_length=23)
AsCas12a

## ----echo=FALSE, fig.cap="Examples of CRISPR nucleases"-----------------------
knitr::include_graphics("./figures/nucleases.svg")

## -----------------------------------------------------------------------------
data(SpCas9, package="crisprBase")
data(AsCas12a, package="crisprBase")
cutSites(SpCas9)
cutSites(SpCas9, strand="-")
cutSites(AsCas12a)
cutSites(AsCas12a, strand="-")

## ----echo=FALSE, fig.cap="Examples of cut site coordinates"-------------------
knitr::include_graphics("./figures/cut_sites.svg")

## -----------------------------------------------------------------------------
targets <- c("AGGTGCTGATTGTAGTGCTGCGG",
             "AGGTGCTGATTGTAGTGCTGAGG")
extractPamFromTarget(targets, SpCas9)
extractProtospacerFromTarget(targets, SpCas9)

## -----------------------------------------------------------------------------
chr      <- rep("chr7",2)
pam_site <- rep(200,2)
strand   <- c("+", "-")
gr_pam <- getPamRanges(seqnames=chr,
                       pam_site=pam_site,
                       strand=strand,
                       nuclease=SpCas9)
gr_protospacer <- getProtospacerRanges(seqnames=chr,
                                       pam_site=pam_site,
                                       strand=strand,
                                       nuclease=SpCas9)
gr_target <- getTargetRanges(seqnames=chr,
                             pam_site=pam_site,
                             strand=strand,
                             nuclease=SpCas9)
gr_pam
gr_protospacer
gr_target

## -----------------------------------------------------------------------------
gr_pam <- getPamRanges(seqnames=chr,
                       pam_site=pam_site,
                       strand=strand,
                       nuclease=AsCas12a)
gr_protospacer <- getProtospacerRanges(seqnames=chr,
                                       pam_site=pam_site,
                                       strand=strand,
                                       nuclease=AsCas12a)
gr_target <- getTargetRanges(seqnames=chr,
                             pam_site=pam_site,
                             strand=strand,
                             nuclease=AsCas12a)
gr_pam
gr_protospacer
gr_target

## ----echo=FALSE, fig.cap="Examples of base editors."--------------------------
knitr::include_graphics("./figures/nucleasesBaseEditor.svg")

## -----------------------------------------------------------------------------
# Creating weight matrix
weightsFile <- system.file("be/b4max.csv",
                           package="crisprBase",
                           mustWork=TRUE)
ws <- t(read.csv(weightsFile))
ws <- as.data.frame(ws)

## -----------------------------------------------------------------------------
rownames(ws)

## -----------------------------------------------------------------------------
colnames(ws) <- ws["Position",]
ws <- ws[-c(match("Position", rownames(ws))),,drop=FALSE]
ws <- as.matrix(ws)
head(ws)

## -----------------------------------------------------------------------------
data(SpCas9, package="crisprBase")
BE4max <- BaseEditor(SpCas9,
                     baseEditorName="BE4max",
                     editingStrand="original",
                     editingWeights=ws,
                     scale=TRUE)
metadata(BE4max)$description_base_editor <- "BE4max cytosine base editor."
BE4max

## -----------------------------------------------------------------------------
plotEditingWeights(BE4max)

## ----echo=FALSE, fig.cap="Examples of CRISPR nickases."-----------------------
knitr::include_graphics("./figures/nickases.svg")

## -----------------------------------------------------------------------------
Cas9D10A <- CrisprNickase("Cas9D10A",
                           nickingStrand="opposite",
                           pams=c("(3)NGG", "(3)NAG", "(3)NGA"),
                           weights=c(1, 0.2593, 0.0694),
                           metadata=list(description="D10A-mutated Streptococcus
                                         pyogenes Cas9 (SpCas9) nickase"),
                           pam_side="3prime",
                           spacer_length=20)
 
Cas9H840A <- CrisprNickase("Cas9H840A",
                            nickingStrand="original",
                            pams=c("(3)NGG", "(3)NAG", "(3)NGA"),
                            weights=c(1, 0.2593, 0.0694),
                            metadata=list(description="H840A-mutated Streptococcus
                                          pyogenes Cas9 (SpCas9) nickase"),
                            pam_side="3prime",
                            spacer_length=20)

## -----------------------------------------------------------------------------
CasRx <- CrisprNuclease("CasRx",
                        targetType="RNA",
                        pams="N",
                        metadata=list(description="CasRx nuclease"),
                        pam_side="3prime",
                        spacer_length=23)
CasRx

## -----------------------------------------------------------------------------
sessionInfo()

