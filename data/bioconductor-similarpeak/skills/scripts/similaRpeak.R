# Code example from 'similaRpeak' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message = FALSE, warning=FALSE----
BiocStyle::markdown()
library(knitr)

## ----loadingPackage, warning=FALSE, message=FALSE-----------------------------
library(similaRpeak)

## ----bam_extract_coverage, collapse=TRUE--------------------------------------
suppressMessages(library(GenomicAlignments))
suppressMessages(library(rtracklayer))
suppressMessages(library(Rsamtools))

bamFile01 <- system.file("extdata/align1.bam", package = "similaRpeak")

region <- GRanges(Rle(c("chr1")), IRanges(start = 172081530, end = 172083529), 
                strand= Rle(strand(c("*"))))

param <- ScanBamParam(which = region)

alignments01 <- readGAlignments(bamFile01, param = param)

coveragesRegion01 <- coverage(alignments01)[region]
coveragesRegion01

## ----iranges_to_vector, collapse=TRUE-----------------------------------------
coveragesRegion01 <- as.numeric(coveragesRegion01$chr1)
length(coveragesRegion01)
summary(coveragesRegion01)

## ----bam_count, collapse=TRUE-------------------------------------------------
param <- ScanBamParam(flag = scanBamFlag(isUnmappedQuery=FALSE))
count01 <- countBam(bamFile01, param = param)$records
coveragesRPMRegion01 <- coverage(alignments01, weight=1000000/count01)[region]
coveragesRPMRegion01 <- as.numeric(coveragesRPMRegion01$chr1)
length(coveragesRPMRegion01)
summary(coveragesRPMRegion01)

## ----demo_profiles_loading, collapse=T----------------------------------------
data(demoProfiles)
str(demoProfiles)

## ----ratio_area_graph, echo=FALSE, fig.width=11, fig.height=8-----------------
par(mar=c(6,4,2,2))
par(mfrow=c(2,2)) 

plot(demoProfiles$chr2.70360770.70361098$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 25),
        main="chr2:70360770-70361098")
par(new=TRUE)
plot(demoProfiles$chr2.70360770.70361098$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 25))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(250, 17, "RATIO_AREA=1.03", cex=1.5, col="red")

plot(demoProfiles$chr8.43092918.43093442$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 1500),
        main="chr8:43092918-43093442")
par(new=TRUE)
plot(demoProfiles$chr8.43092918.43093442$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 1500))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(375, 1000, "RATIO_AREA=0.06", cex=1.5, col="red")

plot(demoProfiles$chr3.73159773.73160145$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 125),
        main="chr3:73159773-73160145")
par(new=TRUE)
plot(demoProfiles$chr3.73159773.73160145$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 125))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(285, 80, "RATIO_AREA=2.23", cex=1.5, col="red")

plot(demoProfiles$chr19.27739373.27739767$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 350),
        main="chr19:27739373-27739767")
par(new=TRUE)
plot(demoProfiles$chr19.27739373.27739767$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 350))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(275, 225, "RATIO_AREA=0.12", cex=1.5, col="red")

## ----ratio_area_calculation, collapse=T---------------------------------------
metrics <- similarity(demoProfiles$chr2.70360770.70361098$H3K27ac, 
                        demoProfiles$chr2.70360770.70361098$H3K4me1)
metrics$metric$RATIO_AREA

metrics <- similarity(demoProfiles$chr8.43092918.43093442$H3K27ac, 
                        demoProfiles$chr8.43092918.43093442$H3K4me1)
metrics$metric$RATIO_AREA

metrics <- similarity(demoProfiles$chr3.73159773.73160145$H3K27ac, 
                        demoProfiles$chr3.73159773.73160145$H3K4me1)
metrics$metric$RATIO_AREA

metrics <- similarity(demoProfiles$chr19.27739373.27739767$H3K27ac, 
                        demoProfiles$chr19.27739373.27739767$H3K4me1)
metrics$metric$RATIO_AREA

## ----diff_pos_max, echo=FALSE, fig.width=11, fig.height=8---------------------

par(mar=c(6,4,2,2))
par(mfrow=c(2,2)) 

plot(demoProfiles$chr2.70360770.70361098$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 25),
        main="chr2:70360770-70361098")
par(new=TRUE)
plot(demoProfiles$chr2.70360770.70361098$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 25))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(250, 17, "DIFF_POS_MAX=-20", cex=1.5, col="red")

plot(demoProfiles$chr8.43092918.43093442$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 1500),
        main="chr8:43092918-43093442")
par(new=TRUE)
plot(demoProfiles$chr8.43092918.43093442$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 1500))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(375, 1000, "DIFF_POS_MAX=-0.5", cex=1.5, col="red")

plot(demoProfiles$chr3.73159773.73160145$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 125),
        main="chr3:73159773-73160145")
par(new=TRUE)
plot(demoProfiles$chr3.73159773.73160145$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 125))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(285, 80, "DIFF_POS_MAX=2.5", cex=1.5, col="red")

plot(demoProfiles$chr19.27739373.27739767$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 350),
        main="chr19:27739373-27739767")
par(new=TRUE)
plot(demoProfiles$chr19.27739373.27739767$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 350))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(275, 225, "DIFF_POS_MAX=2.5", cex=1.5, col="red")

## ----diff_pos_max_calculation, collapse=T-------------------------------------
metrics <- similarity(demoProfiles$chr2.70360770.70361098$H3K27ac, 
                        demoProfiles$chr2.70360770.70361098$H3K4me1)
metrics$metric$DIFF_POS_MAX

metrics <- similarity(demoProfiles$chr8.43092918.43093442$H3K27ac, 
                        demoProfiles$chr8.43092918.43093442$H3K4me1)
metrics$metric$DIFF_POS_MAX

metrics <- similarity(demoProfiles$chr3.73159773.73160145$H3K27ac, 
                        demoProfiles$chr3.73159773.73160145$H3K4me1)
metrics$metric$DIFF_POS_MAX

metrics <- similarity(demoProfiles$chr19.27739373.27739767$H3K27ac, 
                        demoProfiles$chr19.27739373.27739767$H3K4me1)
metrics$metric$DIFF_POS_MAX

## ----ratio_max_max, echo=FALSE, fig.width=11, fig.height=8--------------------

par(mar=c(6,4,2,2))
par(mfrow=c(2,2)) 

plot(demoProfiles$chr2.70360770.70361098$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 25),
        main="chr2:70360770-70361098")
par(new=TRUE)
plot(demoProfiles$chr2.70360770.70361098$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 25))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(250, 17, "RATIO_MAX_MAX=0.95", cex=1.5, col="red")

plot(demoProfiles$chr8.43092918.43093442$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 1500),
        main="chr8:43092918-43093442")
par(new=TRUE)
plot(demoProfiles$chr8.43092918.43093442$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 1500))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(380, 1000, "RATIO_MAX_MAX=0.06", cex=1.5, col="red")

plot(demoProfiles$chr3.73159773.73160145$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 125),
        main="chr3:73159773-73160145")
par(new=TRUE)
plot(demoProfiles$chr3.73159773.73160145$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 125))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(290, 80, "RATIO_MAX_MAX=2.5", cex=1.5, col="red")

plot(demoProfiles$chr19.27739373.27739767$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 350),
        main="chr19:27739373-27739767")
par(new=TRUE)
plot(demoProfiles$chr19.27739373.27739767$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 350))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(280, 225, "RATIO_MAX_MAX=0.12", cex=1.5, col="red")

## ----ratio_max_max_calculation, collapse=T------------------------------------
metrics <- similarity(demoProfiles$chr2.70360770.70361098$H3K27ac, 
                        demoProfiles$chr2.70360770.70361098$H3K4me1)
metrics$metric$RATIO_MAX_MAX

metrics <- similarity(demoProfiles$chr8.43092918.43093442$H3K27ac, 
                        demoProfiles$chr8.43092918.43093442$H3K4me1)
metrics$metric$RATIO_MAX_MAX

metrics <- similarity(demoProfiles$chr3.73159773.73160145$H3K27ac, 
                        demoProfiles$chr3.73159773.73160145$H3K4me1)
metrics$metric$RATIO_MAX_MAX

metrics <- similarity(demoProfiles$chr19.27739373.27739767$H3K27ac, 
                        demoProfiles$chr19.27739373.27739767$H3K4me1)
metrics$metric$RATIO_MAX_MAX

## ----ratio_intersect, echo=FALSE, fig.width=11, fig.height=8------------------

par(mar=c(6,4,2,2))
par(mfrow=c(2,2)) 

plot(demoProfiles$chr2.70360770.70361098$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 25),
        main="chr2:70360770-70361098")
par(new=TRUE)
plot(demoProfiles$chr2.70360770.70361098$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 25))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(242, 17, "RATIO_INTERSECT=0.63", cex=1.5, col="red")

plot(demoProfiles$chr8.43092918.43093442$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 1500),
        main="chr8:43092918-43093442")
par(new=TRUE)
plot(demoProfiles$chr8.43092918.43093442$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 1500))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(375, 1000, "RATIO_INTERSECT=0.06", cex=1.5, col="red")

plot(demoProfiles$chr3.73159773.73160145$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 125),
        main="chr3:73159773-73160145")
par(new=TRUE)
plot(demoProfiles$chr3.73159773.73160145$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 125))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(288, 87, "RATIO_INTERSECT=", cex=1.5, col="red")
text(288, 75, "0.43", cex=1.5, col="red")

plot(demoProfiles$chr19.27739373.27739767$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 350),
        main="chr19:27739373-27739767")
par(new=TRUE)
plot(demoProfiles$chr19.27739373.27739767$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage in reads per million (RPM)",  ylim=c(0, 350))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(275, 225, "RATIO_INTERSECT=0.12", cex=1.5, col="red")

## ----ratio_intersect_calculation, collapse=T----------------------------------
metrics <- similarity(demoProfiles$chr2.70360770.70361098$H3K27ac, 
                      demoProfiles$chr2.70360770.70361098$H3K4me1)
metrics$metric$RATIO_INTERSECT

metrics <- similarity(demoProfiles$chr8.43092918.43093442$H3K27ac, 
                      demoProfiles$chr8.43092918.43093442$H3K4me1)
metrics$metric$RATIO_INTERSECT

metrics <- similarity(demoProfiles$chr3.73159773.73160145$H3K27ac, 
                      demoProfiles$chr3.73159773.73160145$H3K4me1)
metrics$metric$RATIO_INTERSECT

metrics <- similarity(demoProfiles$chr19.27739373.27739767$H3K27ac, 
                      demoProfiles$chr19.27739373.27739767$H3K4me1)
metrics$metric$RATIO_INTERSECT

## ----ratio_normalized_intersect, echo=FALSE, fig.width=11, fig.height=8-------

par(mar = c(6,4,2,2))
par(mfrow = c(2,2)) 

plot(demoProfiles$chr2.70360770.70361098$H3K27ac*
        length(demoProfiles$chr2.70360770.70361098$H3K27ac)/
        sum(demoProfiles$chr2.70360770.70361098$H3K27ac, na.rm=TRUE),
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 3),
        main="chr2:70360770-70361098")
par(new=TRUE)
plot(demoProfiles$chr2.70360770.70361098$H3K4me1*
        length(demoProfiles$chr2.70360770.70361098$H3K4me1)/
        sum(demoProfiles$chr2.70360770.70361098$H3K4me1, na.rm=TRUE),
        type="l", col="darkgreen", xlab="Position", 
        ylab="Normalized Coverage (Coverage/Mean Coverage)",  ylim=c(0, 3))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(245, 2, "RATIO_NORMALIZED_", cex=1.5, col="red")
text(245, 1.75, "INTERSECT=0.63", cex=1.5, col="red")

plot(demoProfiles$chr8.43092918.43093442$H3K27ac*
        length(demoProfiles$chr8.43092918.43093442$H3K27ac)/
        sum(demoProfiles$chr8.43092918.43093442$H3K27ac, na.rm=TRUE),
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 12),
        main="chr8:43092918-43093442")
par(new=TRUE)
plot(demoProfiles$chr8.43092918.43093442$H3K4me1*
        length(demoProfiles$chr8.43092918.43093442$H3K4me1)/
        sum(demoProfiles$chr8.43092918.43093442$H3K4me1, na.rm=TRUE),
        type="l", col="darkgreen", xlab="Position", 
        ylab="Normalized Coverage (Coverage/Mean Coverage)",  ylim=c(0, 12))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(370, 8, "RATIO_NORMALIZED_", cex=1.5, col="red")
text(370, 7, "INTERSECT=0.89", cex=1.5, col="red")

plot(demoProfiles$chr3.73159773.73160145$H3K27ac*
        length(demoProfiles$chr3.73159773.73160145$H3K27ac)/
        sum(demoProfiles$chr3.73159773.73160145$H3K27ac, na.rm=TRUE),
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 8),
        main="chr3:73159773-73160145")
par(new=TRUE)
plot(demoProfiles$chr3.73159773.73160145$H3K4me1*
        length(demoProfiles$chr3.73159773.73160145$H3K4me)/
        sum(demoProfiles$chr3.73159773.73160145$H3K4me, na.rm=TRUE),
        type="l", col="darkgreen", xlab="Position", 
        ylab="Normalized Coverage (Coverage/Mean Coverage)",  ylim=c(0, 8))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(288, 5.5, "RATIO_NORMALIZED_", cex=1.5, col="red")
text(288, 4, "INTERSECT=0.78", cex=1.5, col="red")

plot(demoProfiles$chr19.27739373.27739767$H3K27ac*
         length(demoProfiles$chr19.27739373.27739767$H3K27ac)/
         sum(demoProfiles$chr19.27739373.27739767$H3K27ac, na.rm=TRUE),
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 12),
        main="chr19:27739373-27739767")
par(new=TRUE)
plot(demoProfiles$chr19.27739373.27739767$H3K4me1*
        length(demoProfiles$chr19.27739373.27739767$H3K4me1)/
        sum(demoProfiles$chr19.27739373.27739767$H3K4me1, na.rm=TRUE),
        type="l", col="darkgreen", xlab="Position", 
        ylab="Normalized Coverage (Coverage/Mean Coverage)",  ylim=c(0, 12))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(275, 7, "RATIO_NORMALIZED_", cex=1.5, col="red")
text(275, 6, "INTERSECT=0.84", cex=1.5, col="red")

## ----ratio_normalized_intersect_calculation, collapse=TRUE--------------------
metrics <- similarity(demoProfiles$chr2.70360770.70361098$H3K27ac, 
                      demoProfiles$chr2.70360770.70361098$H3K4me1)
metrics$metric$RATIO_NORMALIZED_INTERSECT

metrics <- similarity(demoProfiles$chr8.43092918.43093442$H3K27ac, 
                      demoProfiles$chr8.43092918.43093442$H3K4me1)
metrics$metric$RATIO_NORMALIZED_INTERSECT

metrics <- similarity(demoProfiles$chr3.73159773.73160145$H3K27ac, 
                      demoProfiles$chr3.73159773.73160145$H3K4me1)
metrics$metric$RATIO_NORMALIZED_INTERSECT

metrics <- similarity(demoProfiles$chr19.27739373.27739767$H3K27ac, 
                      demoProfiles$chr19.27739373.27739767$H3K4me1)
metrics$metric$RATIO_NORMALIZED_INTERSECT

## ----spearman_corr_graphs, echo=FALSE, fig.width=11, fig.height=8-------------

par(mar=c(6,4,2,2))
par(mfrow=c(2,2)) 

plot(demoProfiles$chr2.70360770.70361098$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 25),
        main="chr2:70360770-70361098")
par(new=TRUE)
plot(demoProfiles$chr2.70360770.70361098$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage",  ylim=c(0, 25))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(225, 17, "SPEARMAN_CORRELATION", cex=1.5, col="red")
text(225, 14, "=0.06", cex=1.5, col="red")

plot(demoProfiles$chr8.43092918.43093442$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 1500),
        main="chr8:43092918-43093442")
par(new=TRUE)
plot(demoProfiles$chr8.43092918.43093442$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage",  ylim=c(0, 1500))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(325, 1000, "SPEARMAN_CORRELATION", cex=1.5, col="red")
text(325, 850, "=0.82", cex=1.5, col="red")

plot(demoProfiles$chr3.73159773.73160145$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 125),
        main="chr3:73159773-73160145")
par(new=TRUE)
plot(demoProfiles$chr3.73159773.73160145$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage",  ylim=c(0, 125))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(288, 92, "SPEARMAN_", cex=1.5, col="red")
text(288, 78, "CORRELATION=0.95", cex=1.5, col="red")

plot(demoProfiles$chr19.27739373.27739767$H3K27ac,
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 350),
        main="chr19:27739373-27739767")
par(new=TRUE)
plot(demoProfiles$chr19.27739373.27739767$H3K4me1,
        type="l", col="darkgreen", xlab="Position", 
        ylab="Coverage",  ylim=c(0, 350))
legend("topright", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)
text(270, 225, "SPEARMAN_CORRELATION", cex=1.5, col="red")
text(270, 192, "=0.62", cex=1.5, col="red")


## ----spearman_correlation_calculation, collapse=TRUE--------------------------
metrics <- similarity(demoProfiles$chr2.70360770.70361098$H3K27ac, 
                      demoProfiles$chr2.70360770.70361098$H3K4me1)
metrics$metric$SPEARMAN_CORRELATION

metrics <- similarity(demoProfiles$chr8.43092918.43093442$H3K27ac, 
                      demoProfiles$chr8.43092918.43093442$H3K4me1)
metrics$metric$SPEARMAN_CORRELATION

metrics <- similarity(demoProfiles$chr3.73159773.73160145$H3K27ac, 
                      demoProfiles$chr3.73159773.73160145$H3K4me1)
metrics$metric$SPEARMAN_CORRELATION

metrics <- similarity(demoProfiles$chr19.27739373.27739767$H3K27ac, 
                      demoProfiles$chr19.27739373.27739767$H3K4me1)
metrics$metric$SPEARMAN_CORRELATION

## ----libraryLoad--------------------------------------------------------------
suppressMessages(library(similaRpeak))

## ----profiles, collapse=TRUE--------------------------------------------------
data(chr7Profiles)
str(chr7Profiles)

## ----graphProfiles, echo=FALSE, fig.align='center', fig.height=6--------------
plot(chr7Profiles$chr7.61968807.61969730$H3K27ac, type="l", col="blue", 
        xlab="", ylab="", ylim=c(0, 700), main="chr7:61968807-61969730")
par(new=TRUE)
plot(chr7Profiles$chr7.61968807.61969730$H3K4me1, type="l", col="darkgreen", 
        xlab="Position", ylab="Coverage in reads per million (RPM)", 
        ylim=c(0, 700))
legend("topleft", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)

## ----metricCalculation--------------------------------------------------------
metrics <- similarity(chr7Profiles$chr7.61968807.61969730$H3K27ac, 
                            chr7Profiles$chr7.61968807.61969730$H3K4me1, 
                            ratioAreaThreshold=5, 
                            ratioMaxMaxThreshold=2, 
                            ratioIntersectThreshold=5, 
                            ratioNormalizedIntersectThreshold=2,
                            diffPosMaxThresholdMinValue=10, 
                            diffPosMaxThresholdMaxDiff=100, 
                            diffPosMaxTolerance=0.01)

## ----metricReturn, collapse=TRUE----------------------------------------------
metrics

## ----getInfo, collapse=TRUE---------------------------------------------------
metrics$areaProfile1
metrics$areaProfile2
metrics$metrics$RATIO_INTERSECT

## ----graphProfilesNorm, echo=FALSE, fig.align='center', fig.height=6----------
plot(chr7Profiles$chr7.61968807.61969730$H3K27ac*
        length(chr7Profiles$chr7.61968807.61969730$H3K27ac)/
        sum(chr7Profiles$chr7.61968807.61969730$H3K27ac, na.rm=TRUE), 
        type="l", col="blue", xlab="", ylab="", ylim=c(0, 3.5))
par(new=TRUE)
plot(chr7Profiles$chr7.61968807.61969730$H3K4me1*
        length(chr7Profiles$chr7.61968807.61969730$H3K4me1)/
        sum(chr7Profiles$chr7.61968807.61969730$H3K4me1, na.rm=TRUE), 
        type="l", col="darkgreen", xlab="Position", 
        ylab="Normalized Coverage (Coverage/Mean Coverage)", 
        ylim=c(0, 3.5))
legend("topleft", c("H3K27ac","H3K4me1"), cex=1.2, 
        col=c("blue","darkgreen"), lty=1)

## ----factory------------------------------------------------------------------
factory = MetricFactory$new(diffPosMaxTolerance=0.04)

## ----factoryDemo, collapse=TRUE-----------------------------------------------
ratio_max_max <- factory$createMetric(metricType="RATIO_MAX_MAX", 
                        profile1=demoProfiles$chr2.70360770.70361098$H3K27ac, 
                        profile2=demoProfiles$chr2.70360770.70361098$H3K4me1)

ratio_max_max

ratio_normalized_intersect <- factory$createMetric(
                        metricType="RATIO_NORMALIZED_INTERSECT",
                        profile1=demoProfiles$chr2.70360770.70361098$H3K27ac, 
                        profile2=demoProfiles$chr2.70360770.70361098$H3K4me1)

ratio_normalized_intersect

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

