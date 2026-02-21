# Code example from 'poster' vignette. See references/ for full tutorial.

### R code from vignette source 'poster.Rnw'

###################################################
### code chunk number 1: msqc1
###################################################
library(msqc1)
plot(10 * msqc1::peptides$SIL.peptide.per.vial, msqc1::peptides$actual.LH.ratio, 
     log='xy', 
     ylab='reference L:H ratio',
     xlab='on column amount [fmol]',
     axes=FALSE,
     ylim=c(min(1 * msqc1::peptides$SIL.peptide.per.vial), 100),
     xlim=c(0.8, 4000)); 

axis(1, 10 * peptides$SIL.peptide.per.vial, 10 * peptides$SIL.peptide.per.vial )
axis(2, peptides$actual.LH.ratio, peptides$actual.LH.ratio)
text(10 * peptides$SIL.peptide.per.vial, peptides$actual.LH.ratio, peptides$Peptide.Sequence, cex=0.5 ,pos=4, srt=11)
box()


###################################################
### code chunk number 2: chromatographySP
###################################################

library(msqc1)
msqc1:::.figure_setup()
op <- par(mfrow=c(2,1), mar=c(5,5,5,1))
S.training.8rep <- msqc1:::.reshape_rt(msqc1_8rep, peptides=peptides, cex=2, plot=FALSE)
msqc1_8rep.norm <- msqc1:::.normalize_rt(msqc1_8rep, S.training.8rep,
                                reference_instrument = 'Retention.Time.QTRAP')




S.training.dil <- msqc1:::.reshape_rt(msqc1_dil, peptides=peptides, cex=2,plot=FALSE)
msqc1_dil.norm <- msqc1:::.normalize_rt(msqc1_dil, 
                                        S.training.dil, 
                                        reference_instrument = 'Retention.Time.QTRAP')


S.8rep <- data.frame(normRT=msqc1_8rep.norm$Retention.Time, 
              empRT=msqc1_8rep$Retention.Time, 
              instrument=msqc1_8rep.norm$instrument, 
              type='8 replicates')

S.dil <- data.frame(normRT=msqc1_dil.norm$Retention.Time, 
              empRT=msqc1_dil$Retention.Time, 
              instrument=msqc1_dil.norm$instrument, 
              type='dilution series')

S<-do.call('rbind',list(S.8rep, S.dil))

xyplot(normRT ~ empRT | type, 
       group=instrument, 
       xlab='empirical RT',
       ylab='normalized RT',
       auto.key=list(space = "top", points = TRUE, lines = FALSE, cex=1),
       data=S, layout=c(1,2))


###################################################
### code chunk number 3: figure3
###################################################
#msqc1:::.figure3(data=msqc1_8rep, peptides=peptides)
#R
x <- msqc1_8rep

x <- x[grepl("[by]", x$Fragment.Ion) & x$Peptide.Sequence %in% peptides$Peptide.Sequence, ]

x.sum <- aggregate(Area ~ instrument + Isotope.Label.Type + relative.amount + Peptide.Sequence + File.Name.Id, data=x, FUN=sum)

x.sum.sd <- aggregate(Area ~ instrument + Isotope.Label.Type + Peptide.Sequence,
                      data=x.sum, FUN=sd)
x.sum.mean <-  aggregate(Area ~ instrument + Isotope.Label.Type + Peptide.Sequence,
                         data=x.sum, FUN=mean)


S.peptide <- data.frame(sum_sd_area = x.sum.sd$Area,
        sum_mean_area = x.sum.mean$Area,
        instrument = x.sum.mean$instrument,
        type = "peptide level")


x <- msqc1_8rep

x <- x[grepl("[by]", x$Fragment.Ion) & x$Peptide.Sequence %in% peptides$Peptide.Sequence, ]

x.sum <- aggregate(Area ~ instrument + Isotope.Label.Type + relative.amount + Peptide.Sequence + File.Name.Id, data=x, FUN=sum)


x.light <- x.sum[x.sum$Isotope.Label.Type == "light", ]
x.heavy <- x.sum[x.sum$Isotope.Label.Type == "heavy", ]

x.merged <- merge(x.heavy, x.light, by=c('instrument', 'Peptide.Sequence', 'File.Name.Id'))

x.merged$log2ratio <- log(x.merged$Area.x, 2) - log(x.merged$Area.y, 2)

x.sum.sd <- aggregate(log2ratio ~ instrument  + Peptide.Sequence,
                      data=x.merged, FUN=sd)
x.sum.mean <-  aggregate(log2ratio ~ instrument  + Peptide.Sequence,
                         data=x.merged, FUN=mean)

S.log2 <- data.frame(sum_sd_area = x.sum.sd$log2ratio,
        sum_mean_area = x.sum.mean$log2ratio,
        instrument = x.sum.mean$instrument,
        type = "log2 L:H ratio level")


S <-  do.call('rbind', list(S.peptide, S.log2))



bwplot(100*(sum_sd_area /  sum_mean_area)  ~ instrument | type, data=S,
        panel=function(...){
                      panel.violin(..., fill = NULL, col = NULL, adjust = 1.0, varwidth = FALSE)
                      panel.bwplot(..., fill = "#AAAAAA88")
                      panel.abline(h = log(c(5, 10, 20), base = 10), col.line ='grey')
                      },
         scales = list(x = list(rot = 45),
                y = list(log=TRUE, at=100 * c(2.000, 1, 0.5, 0.25, 0.100, 0.050, 0.025, 0.01, 0.001))),
                ylab = 'coefficient of variation [%]')



###################################################
### code chunk number 4: poster.Rnw:371-372
###################################################
library(msqc1)


###################################################
### code chunk number 5: figure2 (eval = FALSE)
###################################################
## msqc1:::.figure2(data=msqc1_8rep)


###################################################
### code chunk number 6: poster.Rnw:379-523
###################################################

.panel.msqc1_dil <- function(...){
  idx <- order(msqc1::peptides$SIL.peptide.per.vial[order(msqc1::peptides$Peptide.Sequence)])
  peptide.idx <- sort(msqc1::peptides$Peptide.Sequence)[idx]
  
  pep <- peptide.idx[panel.number()]
  pep.idx <- (which(as.character(pep) == as.character(msqc1::peptides$Peptide.Sequence)))
  Protein.Name <- (msqc1::peptides$Protein.Name[pep.idx])
  actual.LH.ratio <- (msqc1::peptides$actual.LH.ratio[pep.idx])
  
  SIL.peptide.per.vial <- (msqc1::peptides$SIL.peptide.per.vial[(which(as.character(pep) == as.character(msqc1::peptides$Peptide.Sequence)))])
  
  # log2 changes
  panel.rect(-100,log2(actual.LH.ratio)-1, 5, log2(actual.LH.ratio)+1 ,border = '#EEEEEEEE', col='#EEEEEEEE')
  panel.rect(-100,log2(actual.LH.ratio)-0.5, 5, log2(actual.LH.ratio)+0.5 ,border = '#CCCCCCCC', col='#CCCCCCCC')
  
  # zero line
  panel.abline(h=c(0, log2(actual.LH.ratio)), col=c("grey", "black"), lwd=c(1,1))
  
  # plot the data
  panel.xyplot(...)
  panel.xyplot(..., type='smooth')
  
  # legend
  SIL.onColumnAmount <- paste("SIL on column=", round(SIL.peptide.per.vial * 10, 1), "fmol",sep='')
  message(Protein.Name)
  x.x<-0.85
  x.cex<-0.7
  
  offset <- 0
  if (actual.LH.ratio < 5){
  }else{offset <- -10}
  ltext(x=x.x, y=8.6 + offset, as.character(Protein.Name), cex=x.cex, pos=2)
  ltext(x=x.x, y=7.2 + offset, SIL.onColumnAmount, cex=x.cex, pos=2)
  #ltext(x=x.x, y=8, paste("SIL=",round(SIL.peptide.per.vial, 2),sep=''), cex=x.cex, pos=2)
  ltext(x=x.x, y=5.8 + offset, paste("actual.LH.ratio=",round(actual.LH.ratio, 2),sep=''), cex=x.cex, pos=2)
}

.figure4 <- function(data, peptides){
  msqc1:::.figure_setup()
  # load the package data
  # s <- msqc1::load_msqc1('dilSeries.csv')
  
  s <- data
  s <- s[grep("[by]", s$Fragment.Ion), ]
  # aggregate the haevy and light transition areas
  s.peptide_areas <- aggregate(Area ~ instrument + Isotope.Label.Type + relative.amount + Peptide.Sequence + File.Name, 
                               data=s, FUN=function(x){sum(x, na.rm=TRUE)})
  
  s.light <- s.peptide_areas[s.peptide_areas$Isotope.Label.Type=='light',] 
  s.heavy <- s.peptide_areas[s.peptide_areas$Isotope.Label.Type=='heavy',]
  
  s.peptie_areas_hl <- merge(s.heavy, s.light, by=c('instrument', 'Peptide.Sequence', 'relative.amount', 'File.Name'))
  
  names(s.peptie_areas_hl) <- c("instrument", "Peptide.Sequence", 
                                "relative.amount", "File.Name", 
                                "Isotope.Label.Type.x", "Area.heavy", 
                                "Isotope.Label.Type.y", "Area.light")
  
  idx <- order(peptides$SIL.peptide.per.vial[order(peptides$Peptide.Sequence)])
  peptide.idx <- sort(peptides$Peptide.Sequence)[idx]
  
  xyplot(log2(Area.light) - log2(Area.heavy) ~ relative.amount | Peptide.Sequence, 
         groups=s.peptie_areas_hl$instrument,
         data=s.peptie_areas_hl, 
         panel=.panel.msqc1_dil,
         layout=c(2,7),
         auto.key=list(space = "top", points = TRUE, lines = FALSE, cex=1),
         index.cond=list(idx),
         scales=list(x = list(rot = 45, log=TRUE, at=sort(unique(s.peptie_areas_hl$relative.amount)) )),
         sub="log2 light heavy ratios of 6 dilutions on 5 MS plattforms",
         main='sigma mix peptide level signal')
}

.figure5 <- function(data, data_reference){
  msqc1:::.figure_setup()
  
  s <- data
  s <- s[grep("[by]", s$Fragment.Ion), ]
  s <- s[!s$Peptide.Sequence %in%  c('TAENFR','GYSIFSYATK'), ]
  
  s.peptide_areas <- aggregate(Area ~ instrument + Isotope.Label.Type + relative.amount + Peptide.Sequence + File.Name,  data=s, FUN=function(x){sum(x, na.rm=TRUE)})
  
  s.light <- s.peptide_areas[s.peptide_areas$Isotope.Label.Type=='light',] 
  s.heavy <- s.peptide_areas[s.peptide_areas$Isotope.Label.Type=='heavy',]
  
  s.peptie_areas_hl <- merge(s.heavy, s.light, by=c('instrument', 'Peptide.Sequence', 'relative.amount', 'File.Name'))
  
  names(s.peptie_areas_hl) <- c("instrument", "Peptide.Sequence", 
                                "relative.amount", "File.Name", 
                                "Isotope.Label.Type.x", "Area.heavy", 
                                "Isotope.Label.Type.y", "Area.light")
  
 
  s.8rep <- data_reference
  xx.table <- table(s.8rep$Peptide.Sequence)
  
  
  xxx <- do.call('rbind', 
                 lapply(c(0), function(cutoff){
                   xx.240 <- names(xx.table[xx.table > cutoff * 240 | xx.table == 160])
                   
                   sensitivity.dil <- msqc1:::.get_sensitivity_relative.amount(s.peptie_areas_hl[s.peptie_areas_hl$Peptide.Sequence %in% xx.240,], 
                                                                               max=42/14*12)
                   
                   sensitivity.dil$cutoff <- cutoff
                   sensitivity.dil
                 }))
                 
  
  AUC <- aggregate(sensitivity ~ instrument + relative.amount, 
                   data=xxx[xxx$log2ratio.cutoff<=1,], 
                   FUN=function(x){round(sum(x)/length(x),2)})
  
  AUC.relative.amount <- unique(AUC$relative.amount)
  
  xyplot(sensitivity ~ log2ratio.cutoff | relative.amount , 
         group=xxx$instrument, 
         #xlab="log2-scaled L:H cutoff value ",
         xlab=expression(epsilon),
         ylab='relative amount correctly quantified replicates',
         panel=function(...){
           pn = panel.number()
           panel.rect(0,0,0.5,1,col='#CCCCCCCC', border='#CCCCCCCC')
           panel.rect(0.5,0,1,1,col='#EEEEEEEE', border='#EEEEEEEE')
           panel.abline(h=c(0.5,0.9,1), col='darkgrey')
           panel.xyplot(...)
           message(paste(pn, AUC.relative.amount[pn]))
           AUC.panel <- AUC[AUC$relative.amount == AUC.relative.amount[pn], ]
           panel.text(1.50,0.31,"AUC [0,1]:", pos=4)
           panel.text(1.51, seq(0.05,0.25,length=5), 
                      paste(AUC.panel$instrument, AUC.panel$sensitivity, sep=" = "), 
                      pos=4, cex=0.75)
         },
         sub = list('sensitivity (relative number of data items having a distance to the theoretical log2ratio cutoff)', cex=1),
         data=xxx,
         xlim=c(0,5),
         type='l', 
         strip = strip.custom(strip.names = TRUE, strip.levels = TRUE),
         auto.key=list(space = "top", points = TRUE, lines = FALSE, cex=1),
         lwd=3,
         layout=c(3,2)
  )
}


###################################################
### code chunk number 7: figure4
###################################################
.figure4(data = msqc1_dil, peptides=peptides)


###################################################
### code chunk number 8: figure5
###################################################
.figure5(data = msqc1_dil, data_reference = msqc1_8rep)


###################################################
### code chunk number 9: supplement_figure6
###################################################
msqc1:::.supplement_figure6(data=msqc1_dil, peptides=peptides)


###################################################
### code chunk number 10: supplement_figure7 (eval = FALSE)
###################################################
## msqc1:::.supplement_figure7(data=msqc1_dil)


###################################################
### code chunk number 11: poster.Rnw:553-602
###################################################
.figure6 <- function(data, peptides){
  msqc1:::.figure_setup()
  x_user <- data
  x_user <- droplevels(x_user[x_user$Peptide.Sequence %in% peptides$Peptide.Sequence, ])
  
  x_user.light <- x_user[x_user$Isotope.Label.Type == "light",]
  x_user.heavy <- x_user[x_user$Isotope.Label.Type == "heavy",]
  
  m_user <- merge(x_user.heavy, x_user.light, 
                  by=c('instrument', 'File.Name', 'Peptide.Sequence', 'Replicate.Name',
                       'Fragment.Ion', 'relative.amount', 'user', 'attempt', 'Protein.Name', 'Precursor.Charge'))
  
  pp <- data.frame(ratio=m_user$Area.y / m_user$Area.x, 
                   user=m_user$user, 
                   attempt=m_user$attempt,
                   instrument=m_user$instrument, 
                   Peptide.Sequence=m_user$Peptide.Sequence)
  
  m_user <- merge(peptides, pp, by='Peptide.Sequence')
  
  idx <- which(is.infinite(m_user$ratio))
  m_user$ratio[idx] <- NA
  
  user_n <- aggregate((actual.LH.ratio - ratio) ~ user + instrument + attempt, 
                      data=m_user, 
                      FUN=function(x){length(x)})
  names(user_n)[4] <- 'n'
  user_sd <- aggregate((actual.LH.ratio - ratio) ~ user + instrument + attempt, 
                       data=m_user, 
                       FUN=function(x){sd(x,na.rm=TRUE)})
  names(user_sd)[4] <- 'sd'
  
  user_sd_n <- cbind(user_sd, user_n)
  xyplot(sd ~ n | instrument, 
         group=user_sd_n$attempt, 
         data=user_sd_n,
         xlab='number of valid ratios',
         ylab="Standard deviation of Error",
         panel = function(...){
           
           auto.sd <- user_sd$sd[user_sd$attempt=='legacy']
           auto.n <- user_n$n[user_n$attempt=='legacy']
           panel.abline(h=auto.sd[panel.number()],col='grey')
           panel.abline(v=auto.n[panel.number()],col='grey')
           panel.xyplot(..., cex=1.4, lwd=1.4, type='p')
         },
         auto.key=list(space = "top", points = TRUE, lines = FALSE, cex=1.5)
  )
}


###################################################
### code chunk number 12: figure6
###################################################
.figure6(data=msqc1_userstudy, peptides=peptides)


