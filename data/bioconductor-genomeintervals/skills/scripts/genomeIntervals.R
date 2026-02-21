# Code example from 'genomeIntervals' vignette. See references/ for full tutorial.

### R code from vignette source 'genomeIntervals.Rnw'

###################################################
### code chunk number 1: set_width
###################################################
options( width = 80 )


###################################################
### code chunk number 2: classes
###################################################
library( genomeIntervals )
data("gen_ints")
i


###################################################
### code chunk number 3: ends
###################################################
i[,1]
i[,2]
closed(i)
closed(i)[2,2] <- FALSE


###################################################
### code chunk number 4: quick.closure
###################################################
i2 <- i
closed(i2) <- c( TRUE, FALSE )
i2


###################################################
### code chunk number 5: seqname.strand
###################################################
seqnames(i)
strand(i)
strand(i)[2] <- "-"


###################################################
### code chunk number 6: combine
###################################################
j
c( i[1:3,], j[1:2,] )


###################################################
### code chunk number 7: annotation
###################################################
annotation(i)
annotation(i)$myannot = rep( c("my", "annot"), length=nrow(i) )
annotation(i[2:3,])


###################################################
### code chunk number 8: annotationColumns
###################################################
i$myannot
i[["myannot"]]


###################################################
### code chunk number 9: close-intervals
###################################################
close_intervals(i)


###################################################
### code chunk number 10: size
###################################################
size(i)


###################################################
### code chunk number 11: new
###################################################
new(
    "Genome_intervals_stranded",
    matrix(c(1, 2, 2, 5), ncol = 2),
    closed = TRUE,
    annotation = data.frame(
            seq_name = factor(c("chr01","chr02")),
            inter_base = FALSE,
            strand = factor( c("+", "+"), levels=c("+", "-") )
    )
)


###################################################
### code chunk number 12: intervalOverlap
###################################################
interval_overlap( from=i, to=j )


###################################################
### code chunk number 13: interval-union
###################################################
interval_union(i)


###################################################
### code chunk number 14: setoperations
###################################################
interval_intersection(i,j)
interval_complement(j[1:2,])


###################################################
### code chunk number 15: distance
###################################################
distance_to_nearest(i,j)


###################################################
### code chunk number 16: inter-base
###################################################
k
inter_base(k)
k[inter_base(k),]


###################################################
### code chunk number 17: size.inter-base
###################################################
size(k)


###################################################
### code chunk number 18: intervalOverlap.inter-base
###################################################
interval_overlap(j,k)


###################################################
### code chunk number 19: distance.inter-base
###################################################
distance_to_nearest(j,k)


###################################################
### code chunk number 20: setoperations.inter-base
###################################################
interval_union(k)
interval_intersection(k,j)
interval_complement(k[1:2,])


###################################################
### code chunk number 21: loadgff
###################################################
libPath <- installed.packages()["genomeIntervals", "LibPath"]
filePath <- file.path(
        libPath,
        "genomeIntervals",
        "example_files"
)

gff <- readGff3(
        file.path( filePath, "sgd_simple.gff" ),
        isRightOpen=FALSE,quiet=TRUE
)
idpa = getGffAttribute( gff, c( "ID", "Parent" ) )
head(idpa)


###################################################
### code chunk number 22: sessionInfo
###################################################
si <- as.character( toLatex( sessionInfo() ) )
cat( si[ -grep( "Locale", si ) ], sep = "\n" )


