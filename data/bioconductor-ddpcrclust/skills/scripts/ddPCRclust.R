# Code example from 'ddPCRclust' vignette. See references/ for full tutorial.

### R code from vignette source 'ddPCRclust.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: ddPCRclust.Rnw:103-124
###################################################
library(ddPCRclust)
# Read files
exampleFiles <- list.files(paste0(find.package('ddPCRclust'), '/extdata'),
                           full.names = TRUE)
files <- readFiles(exampleFiles[3])
# To read all example files uncomment the following line
# files <- readFiles(exampleFiles[1:8])

# Read template
template <- readTemplate(exampleFiles[9])

# Run ddPCRclust
result <- ddPCRclust(files, template)

# Plot the results
library(ggplot2)
p <- ggplot(data = result$B01$data,
            mapping = aes(x = Ch2.Amplitude, y = Ch1.Amplitude))
p <- p + geom_point(aes(color = factor(Cluster)), size = .5, na.rm = TRUE) +
     ggtitle('B01 example')+theme_bw() + theme(legend.position='none')
p


