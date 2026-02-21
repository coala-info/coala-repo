# Code example from 'FunChIP' vignette. See references/ for full tutorial.

### R code from vignette source 'FunChIP.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: options
###################################################
options(width=90)


###################################################
### code chunk number 3: preliminaries
###################################################
library(FunChIP)


###################################################
### code chunk number 4: fragment_length
###################################################

# load the GRanges object associated
# to the ChIP-Seq experiment on the
# transcription factor c-Myc in murine cells

data(GR100)

# name of the .bam file (the
# .bam.bai index file must also be present)

bamf <- system.file("extdata", "test.bam",
                    package="FunChIP", mustWork=TRUE)

# compute d

d <- compute_fragments_length(GR, bamf, min.d = 0, max.d = 300)
d



###################################################
### code chunk number 5: pileup_peak
###################################################

# associate to each peak
# of the GRanges object the correspondent
# coverage function

peaks <- pileup_peak(GR, bamf, d = d)
peaks



###################################################
### code chunk number 6: figureGCV
###################################################

# the method smooth_peak
# removes the background and defines the spline
# approximation from the previously computed peaks
# with lambda estimated from the
# GCV on derivatives. The method spans a non-uniform
# grid for lambda from 10^-4 to 10^12.
# ( the grid is uniform for log10(lambda) )

peaks.smooth <- smooth_peak(peaks, lambda = 10^(-4:12),
                            subsample.data = 50, GCV.derivatives = TRUE,
                            plot.GCV = TRUE, rescale = FALSE )



###################################################
### code chunk number 7: smooth
###################################################

# the automatic choice is lambda = 10^6

peaks.smooth <- smooth_peak(peaks, lambda = 10^6,
                             plot.GCV = FALSE)
head(peaks.smooth)

# mantaining this choice of lambda smooth_peak
# can also define the scaled approximation
# of the spline

peaks.smooth.scaled <- smooth_peak(peaks, lambda = 10^6,
                             plot.GCV = FALSE, rescale = TRUE)
head(peaks.smooth.scaled)



###################################################
### code chunk number 8: summit
###################################################

# peaks.summit identifies the maximum point
# of the smoothed peaks

peaks.summit <- summit_peak(peaks.smooth)
head(peaks.summit)

# peaks.summit can identify also the maximum
# point of the scaled approximation

peaks.summit.scaled <- summit_peak(peaks.smooth.scaled, 
                            rescale = TRUE)
head(peaks.summit.scaled)


###################################################
### code chunk number 9: alignment
###################################################

# representation of two peaks

par (mfrow = c(1,2))
plot_peak(peaks.summit, index = c(6,7), col=c('red',2), cex.main = 2, cex.lab = 2, cex.axis = 1.5, lwd = 2)
aligned.peaks <- cluster_peak(peaks.summit[c(6,7)], parallel = FALSE ,
                                    n.clust = 1, seeds = 1, shift.peak = TRUE,
                                    weight = 1, alpha = 1, p = 2, t.max = 2,
                                    plot.graph.k = FALSE, verbose = FALSE)
aligned.peaks

# shift coefficients
aligned.peaks$coef_shift
plot_peak(aligned.peaks, col = 'forestgreen',
          shift = TRUE, k = 1, cluster.peak = TRUE,
          line.plot = 'spline', 
          cex.main = 2,  cex.lab = 2, cex.axis = 1.5, lwd = 2)


###################################################
### code chunk number 10: weight
###################################################

# compute the weight from the first 10 peaks

dist_matrix <- distance_peak(peaks.summit)
# dist matrix contains the two matrices d_0(i,j)
# and d_1(i,j), used to compute w
names(dist_matrix)

ratio_norm <- dist_matrix$dist_matrix_d0 / dist_matrix$dist_matrix_d1
ratio_norm_upper_tri <- ratio_norm[upper.tri(ratio_norm)]
summary(ratio_norm_upper_tri)
# suggestion: use the median as weight
w <- median(ratio_norm_upper_tri)
w



###################################################
### code chunk number 11: figurek
###################################################

# classification of the smooth peaks in different
# numbers of clusters, from 1 ( no distinction, only shift )
# to 4. 

# here the analysis is run on the spline approximation
# without scaling
peaks.cluster <- cluster_peak(peaks.summit, parallel = FALSE ,  seeds=1:4,
                                   n.clust = 1:4, shift = NULL,
                                   weight = 1, alpha = 1, p = 2, t.max = 2,
                                   plot.graph.k = TRUE, verbose = FALSE)
head(peaks.cluster)



###################################################
### code chunk number 12: figurekScaled
###################################################

# here the analysis is run on the spline approximation
# with scaling
peaks.cluster.scaled <- cluster_peak(peaks.summit.scaled, parallel = FALSE ,  seeds=1:4,
                                     n.clust = 1:4, shift = NULL,
                                     weight = 1, alpha = 1, p = 2, t.max = 2,
                                     plot.graph.k = TRUE, verbose = FALSE, 
                                     rescale = TRUE)
head(peaks.cluster.scaled)



###################################################
### code chunk number 13: choose_k
###################################################

# select the results for k = 3 with alignment
peaks.classified.short <- choose_k(peaks.cluster, k = 3,
                                  shift = TRUE, cleaning = TRUE)
head(peaks.classified.short)

peaks.classified.extended <- choose_k(peaks.cluster, k = 3,
                                  shift = TRUE, cleaning = FALSE)

# and for the scaled version for k =2 and alignment

peaks.classified.scaled.short <- choose_k(peaks.cluster.scaled, k = 2,
                                  shift = TRUE, cleaning = TRUE)
head(peaks.classified.scaled.short)

peaks.classified.scaled.extended <- choose_k(peaks.cluster.scaled, k = 2,
                                  shift = TRUE, cleaning = FALSE)


###################################################
### code chunk number 14: ratio
###################################################
# here we compute the bending index for the classification
# provided for the non scaled dataset

index <- bending_index(peaks.cluster, plot.graph.k = FALSE)
index

# and then for the scaled dataset
index_scaled <- bending_index(peaks.cluster.scaled, plot.graph.k = FALSE)
index_scaled



###################################################
### code chunk number 15: sil
###################################################
sil <- silhouette_plot(peaks.cluster, p=2, weight = 1, alpha = 1,
                         rescale = FALSE, t.max = 2)


###################################################
### code chunk number 16: sil_scaled
###################################################
sil <- silhouette_plot(peaks.cluster.scaled, p=2, weight = 1, alpha = 1,
                         rescale = FALSE, t.max = 2)


###################################################
### code chunk number 17: plot1
###################################################

# plot of the first 10 peaks (raw data)
par(mar=c(4.5,5,4,4))
plot_peak(peaks, index = 1:10, line.plot = 'count',
          cex.main = 2, cex.lab = 2, cex.axis =2)


###################################################
### code chunk number 18: plot2
###################################################

# plot of the smoothed approximation of the first 10 peaks
par(mar=c(4.5,5,4,4))
plot_peak(peaks.smooth, index = 1:10, line.plot = 'spline',  cex.main = 2,cex.lab = 2, cex.axis =2)



###################################################
### code chunk number 19: plot3
###################################################

# plot of the smoothed approximation of the first 10 peaks,
# centering peaks around their summits
par(mar=c(4.5,5,4,4))
plot_peak(peaks.summit, index = 1:10, line.plot = 'spline', cex.main = 2,cex.lab = 2, cex.axis =2)


###################################################
### code chunk number 20: plot2bis
###################################################

# plot of the smoothed approximation of the first 10 peaks;
# the scaled functions are plotted.
# 
par(mar=c(4.5,5,4,4))
plot_peak(peaks.smooth.scaled, index = 1:10, 
          line.plot = 'spline', rescale = TRUE, 
           cex.main = 2,cex.lab = 2, cex.axis =2)



###################################################
### code chunk number 21: plot3bis
###################################################

# plot of the scaled approximation of the first 10 peaks,
# centering peaks around their summits
par(mar=c(4.5,5,4,4))
plot_peak(peaks.summit.scaled, index = 1:10, 
          line.plot = 'spline', rescale = TRUE, 
           cex.main = 2,cex.lab = 2, lwd = 2,cex.axis =2)


###################################################
### code chunk number 22: plotBOTH
###################################################

# plot of a peak comparing its raw structure and
# its spline-smoothed version.
par(mar=c(4.5,5,4,4))
plot_peak(peaks.summit, index = 3, lwd =2, line.plot = 'both', col = 'darkblue', cex.main = 2,cex.lab = 2, cex.axis =2)


###################################################
### code chunk number 23: plot4
###################################################

# plot of the results of the kmean alignment.
# Peaks are plotted in three different panels
# according to the clustering results.

plot_peak(peaks.cluster, index = 1:100, line.plot = 'spline',
          shift = TRUE, k = 3, cluster.peak = TRUE, 
          col = topo.colors(3),  cex.main = 2,cex.lab = 2, cex.axis =2)


###################################################
### code chunk number 24: plot4bis
###################################################

# plot of the results of the kmean alignment.
# Scaled peaks are plotted in three different panels
# according to the clustering results.

plot_peak(peaks.cluster.scaled, index = 1:100, line.plot = 'spline',
          shift = TRUE, k = 2, cluster.peak = TRUE, rescale = TRUE, 
          col = heat.colors(2), cex.main = 2,cex.lab = 2, cex.axis =2)



