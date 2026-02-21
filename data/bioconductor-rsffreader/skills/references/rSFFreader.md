An introduction to rSFFreader

Matt Settles*

October 30, 2018

1

1

Contents

1 Introduction

2 A simple workﬂow

> library("rSFFreader")
> library("xtable")

1 Introduction

The SFF ﬁle format has been adopted by both Roche 454 and Ion Torrent next generation sequencing
platforms. rSFFreader provides functionality for loading sequence, quality scores, and ﬂowgram information
from these ﬁles. This package has been modeled after the excellent ( ShortRead) package released by Martin
Morgan. It aims to maintain compatibility with that package while enabling direct processing of SFF ﬁles.

2 A simple workﬂow

Read in an SFF ﬁle:

> sff <- readSff(system.file("extdata","Small454Test.sff",package="rSFFreader"))

Total number of reads to be read: 1000
reading header for sff file:/tmp/Rtmp6Srrkc/Rinst57b954b91f92/rSFFreader/extdata/Small454Test.sff
reading file:/tmp/Rtmp6Srrkc/Rinst57b954b91f92/rSFFreader/extdata/Small454Test.sff

Accessing the read, quality, and header information:

> sread(sff)

*msettles@uidaho.edu

1

A DNAStringSet instance of length 1000

width seq

names

[1]
[2]
[3]
[4]
[5]
...
[996]
[997]
[998]
[999]
[1000]

422 ACACGACGACTT...GGCGCTCGCTC HRWLTHE02G15D7
157 ACACTACTCGTG...CTGGTGCCGGC HRWLTHE02H2PCX
376 ACACGACGACTG...CGTTACAAATC HRWLTHE02HB23L
243 ACACGACGACTC...GAGAAGATCAT HRWLTHE02IYLA2
727 ACACTACTCGTG...GGTCTCCGTTA HRWLTHE02F3E10
... ...
652 ACACGACGACTC...CGCCTTCCTGC HRWLTHE02JSWSM
756 ACACGACGACTG...CCCGGTCACCG HRWLTHE02FJUSH
574 ACACGACGACTT...ACGAGGGGGGT HRWLTHE02GCJZT
693 ACACTACTCGTC...TACCGGCAGCA HRWLTHE02IFUFC
573 ACACTACTCGTC...TTGTGAATACG HRWLTHE02GF2BA

> quality(sff)

class: FastqQuality
quality:

A BStringSet instance of length 1000

width seq

[1]
[2]
[3]
[4]
[5]
...
[996]
[997]
[998]
[999]
[1000]

422 IIIIIIIIIHIHHFFFFFFFF>...55577;;997977777878787
157 IIHHIHAAADFHDAACAA>A>@...>>???FFD@?B@??=;4/...7
376 >>FHHHHFFFFFDCA@@=?=77...777778<;;0002999:74444
243 IIIIIIIIIEEEFHHFHHHFII...887==<;;;87555641.144/
727 IIIIIIIIIIHHIIIIFHHHHH...22--/,/+++------+++--/
... ...
652 IIIIIIIIIHHHGGDD>>>FII...0225231111.10////,,,/,
756 IIIIIIIIIIIIIIIHHHHIII...100---)))++001001*10-+
574 IIIIIIIIHHFFFFA<444>EC...++++),.111111.,+++++++
693 IIIIIIIIIIIIIIIIIIIIII...011111101010-----,//-+
573 IIIIIIIIIIIIIIIIIIIIII...33355322500--)+.10-+++

> header(sff)

[[1]]
[[1]]$filename
[1] "/tmp/Rtmp6Srrkc/Rinst57b954b91f92/rSFFreader/extdata/Small454Test.sff"

[[1]]$magic_number
[1] 779314790

[[1]]$version
[1] ""

[[1]]$index_offset
[1] 6201592

2

[[1]]$index_length
[1] 20728

[[1]]$number_of_reads
[1] 1000

[[1]]$header_length
[1] 1640

[[1]]$key_length
[1] 4

[[1]]$number_of_flows_per_read
[1] 1600

[[1]]$flowgram_format_code
[1] 1

[[1]]$flow_chars
[1] "TACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACGTACG"

[[1]]$key_sequence
[1] "GACT"

Plot histogram of read lengths:

> hist(width(sff), xlab="Read Lengths",
+
+

main=paste("Histogram of read lengths using", clipMode(sff), "clip mode."),
breaks=100)

3

Setting the clipMode will change the read lengths that are reported by width and plotted by hist. Currently
the following modes are supported:

(cid:136) adapter : deﬁned in the SFF ﬁle, and meant to remove adapter sequence

(cid:136) quality : deﬁned in the SFF ﬁle, and meant to remove low-quality regions of the sequence

(cid:136) full : uses the ”interior” of quality and adapter and is the most conservative

(cid:136) raw : no clipping is applied and full length reads are returned

(cid:136) custom : clip points set by the user as an IRanges object.

> availableClipModes(sff)

[1] "full"

"quality" "adapter" "raw"

4

Histogram of read lengths using full clip mode.Read LengthsFrequency20040060080005101520253035> clipMode(sff)

[1] "full"

> clipMode(sff) <- "raw"
> hist(width(sff), xlab="Read Lengths",
+
+

main=paste("Histogram of read lengths using", clipMode(sff), "clip mode."),
breaks=100)

Custom clip points can be set using IRanges. For example, it is sometimes useful to look for barcodes

(MID tags) in the ﬁrst 15 bases of a set of reads.

> customClip(sff) <- IRanges(start = 1, end = 15)
> clipMode(sff) <- "custom"
> t = table(counts=as.character(sread(sff)))

5

Histogram of read lengths using raw clip mode.Read LengthsFrequency2004006008001000120014001600010203040GACTACACGACGACT
GACTACACGTAGTAT
GACTACACTACTCGT

counts
284
377
316

Finally, we can generate some useful QA plots and

> ## Generate some QA plots:
> ## Read length histograms:
> par(mfrow=c(2,2))
> clipMode(sff) <- "raw"
> hist(width(sff),breaks=500,col="grey",xlab="Read Length",main="Raw Read Length")
> clipMode(sff) <- "full"
> hist(width(sff),breaks=500,col="grey",xlab="Read Length",main="Clipped Read Length")
> ## Base by position plots:
> clipMode(sff) <- "raw"
> ac <- alphabetByCycle(sread(sff),alphabet=c("A","C","T","G","N"))
> ac.reads <- apply(ac,2,sum)
> acf <- sweep(ac,MARGIN=2,FUN="/",STATS=apply(ac,2,sum))
> matplot(cbind(t(acf),ac.reads/ac.reads[1]),col=c("green","blue","black","red","darkgrey","purple"),
+
+
> cols <- c("green","blue","black","red","darkgrey","purple")
> leg <- c("A","C","T","G","N","% reads")
> legend("topright", col=cols, legend=leg, pch=18, cex=.8)
> clipMode(sff) <- "full"
> ac <- alphabetByCycle(sread(sff),alphabet=c("A","C","T","G","N"))
> ac.reads <- apply(ac,2,sum)
> acf <- sweep(ac,MARGIN=2,FUN="/",STATS=apply(ac,2,sum))
> matplot(cbind(t(acf),ac.reads/ac.reads[1]),col=c("green","blue","black","red","darkgrey","purple"),
+
+
> legend("topright", col=cols, legend=leg, pch=18, cex=.8)
>

type="l",lty=1,xlab="Base Position",ylab="Base Frequency",
main="Base by position")

type="l",lty=1,xlab="Base Position",ylab="Base Frequency",
main="Base by position")

6

7

Raw Read LengthRead LengthFrequency20060010001400051015Clipped Read LengthRead LengthFrequency20040060080002468120500100015000.00.40.8Base by positionBase PositionBase FrequencyACTGN% reads02004006008000.00.40.8Base by positionBase PositionBase FrequencyACTGN% reads