# Code example from 'analyze-flycode-detectibilty' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----message=FALSE------------------------------------------------------------
library(NestLink)

## ----fig.retina=1-------------------------------------------------------------
library(ggplot2)
ESP <- rbind(getFC(), getNB())
p <- ggplot(ESP, aes(x = ESP_Prediction, fill = cond)) +
  geom_histogram(bins = 50, alpha = 0.4, position="identity") +
  labs(x = "detectability in LC-MS (ESP prediction)") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
      panel.background = element_blank(), axis.line = element_line(colour = "black"))
print(p)

ESP <- rbind(getFC(), NB.unambiguous(getNB()))
p <- ggplot(ESP, aes(x = ESP_Prediction, fill = cond)) +
  geom_histogram(bins = 50, alpha = 0.4, position="identity") +
  labs(x = "detectability in LC-MS (ESP prediction)") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
print(p)

ESP <- rbind(getFC(), NB.unique(getNB()))
p <- ggplot(ESP, aes(x = ESP_Prediction, fill = cond)) +
  geom_histogram(bins = 50, alpha = 0.4, position="identity") +
  labs(x = "detectability in LC-MS (ESP prediction)") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
print(p)

  
ESP <- rbind(getNB(), NB.unambiguous(getNB()), NB.unique(getNB()))

p <- ggplot(ESP, aes(x = ESP_Prediction, fill = cond)) +
  geom_histogram(bins = 50, alpha = 0.4, position="identity") +
  labs(x = "detectability in LC-MS (ESP prediction)") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
print(p)

table(ESP$cond)

## -----------------------------------------------------------------------------
# library(ExperimentHub)                               
# eh <- ExperimentHub();                                
# load(query(eh, c("NestLink", "WU160118.RData"))[[1]])

load(getExperimentHubFilename("WU160118.RData"))
WU <- WU160118

## -----------------------------------------------------------------------------
PATTERN <- "^GS[ASTNQDEFVLYWGP]{7}(WR|WLTVR|WQEGGR|WLR|WQSR)$"

idx <- grepl(PATTERN, WU$pep_seq)
WU <- WU[idx & WU$pep_score > 25,]

## -----------------------------------------------------------------------------
WU$chargeInt <- as.integer(substr(WU$query_charge, 0, 1))
table(WU$chargeInt)

## -----------------------------------------------------------------------------
round(100 * (table(WU$chargeInt) / nrow(WU)), 1)

## ----fig.retina=1, fig.height=8-----------------------------------------------
library(scales)
ggplot(WU, aes(x = moverz * chargeInt, fill = (query_charge),
               colour = (query_charge))) +
    facet_wrap(~ datfilename, ncol = 2) +
    geom_histogram(binwidth= 10, alpha=.3, position="identity") +
    labs(title = "Precursor mass to charge frequency plot",
      subtitle = "Plotting frequency of precursor masses for each charge state",
      x = "Precursor mass [neutral mass]", 
      y = "Frequency [counts]",
      fill = "Charge State",
      colour = "Charge State") +
    scale_x_continuous(breaks = pretty_breaks(8)) +
    theme_light()

## -----------------------------------------------------------------------------
WU$suffix <- substr(WU$pep_seq, 10, 100)

ggplot(WU, aes(x = moverz * chargeInt, fill = suffix, colour = suffix)) +
    geom_histogram(binwidth= 10, alpha=.2, position="identity") +
    #facet_wrap(~ substr(pep_seq, 10, 100)) +
   theme_light()

## -----------------------------------------------------------------------------
ggplot(WU, aes(x = moverz * chargeInt, fill = suffix)) +
    geom_histogram(binwidth= 10, alpha=.9, position="identity") +
    facet_wrap(~ substr(pep_seq, 10, 100)) +
   theme_light()

## -----------------------------------------------------------------------------
ggplot(WU, aes(x = pep_score, fill = query_charge, colour = query_charge)) +
    geom_histogram(binwidth= 2, alpha=.5, position="identity") +
    facet_wrap(~ substr(pep_seq, 10, 100)) +
   theme_light()

## -----------------------------------------------------------------------------
# FC <- read.table(system.file("extdata/FC.tryptic", package = "NestLink"),
#                header = TRUE)
FC <- getFC()
FC$peptide <- (as.character(FC$peptide))
idx <- grep (PATTERN, FC$peptide)

FC$cond <- "FC"
FC$pim <- parentIonMass(FC$peptide)
FC <- FC[nchar(FC$peptide) >2, ]
FC$ssrc <- sapply(FC$peptide, ssrc)
FC$peptideLength <- nchar(as.character(FC$peptide))
FC <- FC[idx,]
head(FC)    

## -----------------------------------------------------------------------------
aa_pool_x7 <- c(rep('A', 18), rep('S', 6), rep('T', 12), rep('N', 1),
  rep('Q', 1), rep('D', 11),  rep('E', 11), rep('V', 12), rep('L', 2),
  rep('F', 1), rep('Y', 4), rep('W', 1), rep('G', 8), rep('P', 12))

aa_pool_x7.post <- c(rep('WR', 20),  rep('WLTVR', 20), rep('WQEGGR', 20), 
  rep('WLR', 20), rep('WQSR', 20))


## -----------------------------------------------------------------------------
FC.pep_seq.freq <- table(unlist(strsplit(substr(FC$peptide, 3, 9), "")))
FC.freq <- round(FC.pep_seq.freq / sum(FC.pep_seq.freq) * 100, 3)


FC.pep_seq.freq.post <- table(unlist((substr(FC$peptide, 10, 100))))
FC.freq.post <- round(FC.pep_seq.freq.post / sum(FC.pep_seq.freq.post) * 100, 3)


WU.pep_seq.freq <- table(unlist(strsplit(substr(WU$pep_seq, 3, 9), "")))
WU.freq <- round(WU.pep_seq.freq / sum(WU.pep_seq.freq) * 100,3)


WU.pep_seq.freq.post <- table(unlist(substr(WU$pep_seq, 10, 100)))
WU.freq.post <- round(WU.pep_seq.freq.post / sum(WU.pep_seq.freq.post) *100,3)

## -----------------------------------------------------------------------------
table(aa_pool_x7)
FC.freq
WU.freq

## -----------------------------------------------------------------------------
AAfreq1 <- data.frame(aa = table(aa_pool_x7))
names(AAfreq1) <- c('AA', 'freq')

AAfreq1 <-rbind(AAfreq1, df<-data.frame(AA=c('C','H','I','M','K','R'), freq=rep(0,6)))

AAfreq1$cond <- 'theoretical frequency'

AAfreq2 <- data.frame(aa=FC.freq)
names(AAfreq2) <- c('AA', 'freq')
AAfreq2$cond <- "db10.fasta"

AAfreq3 <- data.frame(aa=WU.freq)
names(AAfreq3) <- c('AA', 'freq')
AAfreq3$cond <- "WU"

#FC.all <- read.table(system.file("extdata/FC.tryptic", package = "NestLink"),
#                 header = TRUE)
FC.all <- getFC()
PATTERN.all <- "^GS[A-Z]{7}(WR|WLTVR|WQEGGR|WLR|WQSR)$"
FC.all <- as.character(FC.all$peptide)[grep(PATTERN.all, as.character(FC.all$peptide))]

FC.all.pep_seq.freq <- table(unlist(strsplit(substr(FC.all, 3, 9), "")))
FC.all.freq <- round(FC.all.pep_seq.freq / sum(FC.all.pep_seq.freq) * 100, 3)
FC.all.freq[20] <- 0
names(FC.all.freq) <- c(names(FC.all.freq)[1:19], "K")
AAfreq4 <- data.frame(AA=names(FC.all.freq), freq=as.numeric(FC.all.freq))

AAfreq4$cond <- "sequenced frequency"

AAfreq <- do.call('rbind', list(AAfreq1, AAfreq2, AAfreq3, AAfreq4))
AAfreq$freq <- as.numeric(AAfreq$freq)

## ----fig.retina=1-------------------------------------------------------------
ggplot(data=AAfreq, aes(x=AA, y=freq, fill=cond)) + 
  geom_bar(stat="identity", position="dodge") + 
  labs(title = "amino acid frequency plot") +
  theme_light()

## -----------------------------------------------------------------------------
AAfreq1.post <- data.frame(aa=table(aa_pool_x7.post))
names(AAfreq1.post) <- c('AA', 'freq')
AAfreq1.post$cond <- "aa_pool_x7"

AAfreq2.post <- data.frame(aa=FC.freq.post)
names(AAfreq2.post) <- c('AA', 'freq')
AAfreq2.post$cond <- "db10.fasta"

AAfreq3.post <- data.frame(aa=WU.freq.post)
names(AAfreq3.post) <- c('AA', 'freq')
AAfreq3.post$cond <- "WU"

AAfreq.post <- do.call('rbind', list(AAfreq1.post, AAfreq2.post, AAfreq3.post))

## ----NestLink_AAFreqPercent, fig.retina=1, fig.path='Figs/'-------------------
df<-AAfreq[(AAfreq$cond != 'WU' & AAfreq$cond != 'db10.fasta'), ]
df$freq<- as.numeric(df$freq)
ggplot(data=df, aes(x=AA, y=freq, fill=cond)) + 
  geom_bar(stat="identity", position="dodge") + 
  labs(title = "Amino acid frequency plot") +
  ylab("Frequency [%]") +
  theme_light()

## ----NestLink_FCAAfreqAbsolut, fig.retina=1, fig.path='Figs/'-----------------
FCfreq <- data.frame(table(unlist(strsplit(substr(FC$peptide, 3, 9), ""))))
colnames(FCfreq) <- c('AA', 'freq')

ggplot(data=FCfreq, aes(x=AA, y=freq)) + 
  geom_bar(stat="identity", position="dodge") + 
  labs(title = "Amino acid frequency plot") +
  theme_light()

## ----fig.retina=1-------------------------------------------------------------
ggplot(data=AAfreq.post, aes(x=AA, y=freq, fill=cond)) + 
  geom_bar(stat="identity", position="dodge") + 
  labs(title = "suffix frequency plot") +
  theme_light()

## ----fig.retina=1, fig.height=12----------------------------------------------
WU$ssrc <- sapply(as.character(WU$pep_seq), ssrc)
WU$suffix <- substr(WU$pep_seq, 10,100)
ggplot(WU, aes(x = RTINSECONDS, y = ssrc)) +
  geom_point(aes(alpha=pep_score, colour = datfilename)) +
  facet_wrap(~ datfilename * suffix, ncol = 5, nrow = 8) +
  geom_smooth(method = 'lm') 

## -----------------------------------------------------------------------------
cor(WU$RTINSECONDS, WU$ssrc, method = 'spearman')

## -----------------------------------------------------------------------------
WU <- WU160118
PATTERN <- "^GS[ASTNQDEFVLYWGP]{7}(WR|WLTVR|WQEGGR|WLR|WQSR)$"
idx <- grepl(PATTERN, WU$pep_seq)

# Mascot score cut-off valye 25
WU <- WU[idx & WU$pep_score > 25,]

## ----fig.retina=1-------------------------------------------------------------
WU$suffix <- substr(WU$pep_seq, 10, 100)
WU$ssrc <- sapply(as.character(WU$pep_seq), ssrc)

ggplot(WU, aes(x = RTINSECONDS, fill = datfilename)) + 
  geom_histogram(bins = 50)

ggplot(WU, aes(x = ssrc, fill = datfilename)) + 
  geom_histogram(bins = 50)

ggplot(WU, aes(x = RTINSECONDS, fill = suffix)) + 
  geom_histogram(bins = 50)

ggplot(WU, aes(x = ssrc, fill = suffix)) + 
  geom_histogram(bins = 50)

## -----------------------------------------------------------------------------
WU <- WU[WU$datfilename == "F255737",]

WU <- aggregate(WU$RTINSECONDS ~ WU$pep_seq, FUN = min)
names(WU) <-c("pep_seq", "RTINSECONDS")
WU$suffix <- substr(WU$pep_seq, 10, 100)
WU$peptide_mass <- parentIonMass(as.character(WU$pep_seq))
WU$ssrc <- sapply(as.character(WU$pep_seq), ssrc)
WU$datfilename <- "F255737"

## ----fig.retina=1, fig.width=12, fig.height=4---------------------------------
ggplot(WU, aes(x = RTINSECONDS, y = peptide_mass)) +
  geom_point(aes(colour = suffix)) +
  facet_wrap(~ datfilename * suffix, ncol=5) 

ggplot(WU, aes(x = RTINSECONDS, fill = suffix)) + 
  geom_histogram(bins = 20) + 
  facet_wrap(~ datfilename * suffix, ncol=5)

## ----fig.retina=1, fig.width=12, fig.height=4---------------------------------
ggplot(WU, aes(x = ssrc, y = peptide_mass)) +
  geom_point(aes(colour = suffix)) +
  facet_wrap(~ datfilename * suffix,  ncol = 5)

ggplot(WU, aes(x = ssrc,fill = suffix)) + 
  geom_histogram(bins = 20) + 
  facet_wrap(~ datfilename * suffix, ncol=5)

## ----fig.retina=1, fig.width=8, fig.height=4----------------------------------
ggplot(WU, aes(x = RTINSECONDS, y = peptide_mass)) +
  geom_point(aes(colour = suffix), size = 3.0, alpha = 0.1) 

## ----fig.retina=1, fig.width=8, fig.height=4----------------------------------
ggplot(WU, aes(x = ssrc, y = peptide_mass)) +
  geom_point(aes(colour = suffix),  size = 3.0, alpha = 0.1) 

## ----fig.retina=1, fig.height=12----------------------------------------------

WU <-  do.call('rbind', lapply(c(25,35,45), function(cutoff){
  WU <- WU160118 
  PATTERN <- "^GS[ASTNQDEFVLYWGP]{7}(WR|WLTVR|WQEGGR|WLR|WQSR)$"
  idx <- grepl(PATTERN, WU$pep_seq)
  
  WU <- WU[idx & WU$pep_score > cutoff, ]
  
  WU <- WU[WU$datfilename == "F255737",]
  
  WU <- aggregate(WU$RTINSECONDS ~ WU$pep_seq, FUN=min)
  names(WU) <-c("pep_seq","RTINSECONDS")
  WU$suffix <- substr(WU$pep_seq, 10, 100)
  WU$peptide_mass <- parentIonMass(as.character(WU$pep_seq))
  WU$ssrc <- sapply(as.character(WU$pep_seq), ssrc)
  WU$datfilename <- "F255737"
  WU$mascotScoreCutOff <- cutoff
  WU}))


ggplot(WU, aes(x = RTINSECONDS, y = peptide_mass)) +
  geom_point(aes(colour = suffix),  size = 3.0, alpha = 0.1) +
  facet_wrap(~ mascotScoreCutOff, ncol = 1)

ggplot(WU, aes(x = ssrc, y = peptide_mass)) +
  geom_point(aes(colour = suffix),  size = 3.0, alpha = 0.1) +
  facet_wrap(~ mascotScoreCutOff, ncol = 1 )


## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

