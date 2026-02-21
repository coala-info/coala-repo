Benchmarking ADaCGH2 and comparison with previous
versions

Ramon Diaz-Uriarte1

28-December-2013

1. Department of Biochemistry, Universidad Autonoma de Madrid Instituto de
Investigaciones Biomedicas “Alberto Sols” (UAM-CSIC), Madrid (SPAIN).
rdiaz02@gmail.com

Contents

1 Introduction

1.1 Data set and hardware . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
1.2 Segmentation methods used . . . . . . . . . . . . . . . . . . . . . . . . . . . .
1.2.1 Diﬃculties of using some methods with large data sets . . . . . . . . .
1.3 Tables: column name explanation . . . . . . . . . . . . . . . . . . . . . . . . .

2 Comparison with v. 1.10 of ADaCGH2

ADaCGH2

2.1 Main diﬀerences between the old (v. 1.10) and new versions (v. ≥ 2.3.4) of
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.2 Data and code availability . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 Reading data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
2.4 Analyzing data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

3 Other comparisons

3.1 Comparison with non-parallelized executions
. . . . . . . . . . . . . . . . . .
3.2 Reading from a directory of ﬁles vs. other options . . . . . . . . . . . . . . . .
3.3 Analyzing large data with RAM objects . . . . . . . . . . . . . . . . . . . . .

4 Comments and recommended usage patterns

4.1 Recommended usage: summary . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2 Recommended usage: details

3
3
4
5
5

7

7
8
9
22

39
39
41
42

43
43
43

List of Tables

1
2
3
4
5
6
7

Reading benchmarks for Coleonyx: Intel Xeon E5645, 12 cores, 64 GB RAM 10
Reading benchmarks for Gallotia: AMD Opteron 6276, 64 cores, 256 GB RAM 14
Reading benchmarks for Lacerta: AMD Opteron 6276, 64 cores, 384 GB RAM 18
Analysis benchmarks for Coleonyx: Intel Xeon E5645, 12 cores, 64 GB RAM 24
Analysis benchmarks for Gallotia: AMD Opteron 6276, 64 cores, 256 GB RAM 28
Analysis benchmarks for Lacerta: AMD Opteron 6276, 64 cores, 384 GB RAM 33
Analysis benchmarks using Lacerta and Gallotia with MPI over Inﬁniband
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
(total 124 cores)

37

1

8

Time and memory usage of segmentation: comparison with non-parallized
executions.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
Time and memory usage when reading data . . . . . . . . . . . . . . . . . . .
10 Time and memory usage of segmentation with default options . . . . . . . . .

40
41
42

List of Figures

1 Wall time and memory usage when reading data: version comparison . . . . .
2 Wall time and memory usage when analyzing data: version comparison . . .

13
23

2

1

Introduction

I provide here comparisons with the former version of ADaCGH2 (v. 1.10, as available in
BioConductor v. 2.12) as well as some comparisons against non-parallelized executions and,
ﬁnally, some details about recommended patterns of usage. The benchmarks shown here
total more than 2047 hours of wall time (more than 85 days) and correspond to over 400
runs for reading and 370 for analysis. The purpose of these benchmarks is to show the
diﬀerences in performance between the new and old versions, as well as to illustrate the
eﬀects of changing several parameters in the new version. Before showing the results, we
provide information about the hardware and data sets.

It should be noted that the very ﬁrst version of ADaCGH (the one documented in Diaz-
Uriarte and Rueda (2007)) will no longer run in current versions of R without tweaks, as it
depends on a package (papply) that no longer installs in current versions of R (it had problems
at least since v. 2.15.0 of R). The web-based application documented in that paper still works
because I did perform those tweaks, and because in some servers we are still running version
2.9.0 of R. However, for the ﬁnal user, comparisons against that initial version are therefore
of little interest. Thus, the benchmarks that I show provide comparisons against the version
available from release 2.12 of BioConductor; this “old” version (v. 1.10) still runs, but already
incorporates several major advantages over the initial one documented in the PLoS ONE
paper, mainly:

• Clusters are not restricted to MPI cluster, whereas the initial version only allowed
MPI clusters; so, for instance socket clusters (much easier to use in Windows than
MPI clusters) were not available.

• There are no dependencies on deprecated or orphaned packages so the package will

install in current versions of R.

• ﬀ objects start to be used. The very ﬁrst version always required the complete data
set to be in memory in the master process for the duration of the analysis, and MPI
moved around actual columns of the data frame, and not just pointers to ﬀ objects. As
a consequence, for the initial version, memory requirements for analysis were actually
higher than the memory requirements of reading data of the “old” version; thus the
largest possible data for analysis were smaller than the ones for v. 1.10, and analyses
were also slower.

• Two algorithms, ACE and PSW, were eliminated because of little usage, and a new

and very fast one, HaarSeg, included.

• Input from, and output to, other BioConductor packages was added.

Therefore, in what follows, “old” refers to v. 1.10, as available from BioConductor 2.12,

and “new” to versions ge2.3, and those are the versions that will be compared.

1.1 Data set and hardware

We will use a simulated data set that contains 6,067,433 rows and up to 4000 columns of data;
these are, thus, data for an array with 6 million probes and data for up to 4000 subjects.
Many of the examples shown below will use smaller subsets of the data, smaller in terms
of the number of subjects or samples (columns). There are 421,000 missing values per data
column.

3

To give an idea of sizes, the ASCII ﬁle with the data for the 1000 column data is about
96 GB1. The directory with the data for 2000 columns occupies about 198 GB and, when
archived and compressed with bzip2, occupies 78 GB. The RData for the 1000 columns
data is 46 GB (without compression; 41 GB with the standard R compression); in a freshly
started R session, loading the RData will use 46 GB (as reported by gc()). The RData
object with the 1000 columns, when loaded into R in the PowerEdges, takes 13 minutes to
load and uses a total of about 46 GB (45.7 from calls to gc before and after loading the
object, and adding Ncells and Vcells, or 45.6 as reported by object.size). Note that this
is not the result of the object being a data frame and having a column with identiﬁers (a
factor), instead of being a matrix; a similarly sized matrix with just the numeric data for
the probes (i.e., without the ﬁrst three columns of ID, chromosome, and location) has a size
of 45.2 GB (therefore, the diﬀerence of 300 MB due to the ﬁrst column, ID, being a factor
with the identiﬁers, is minute relative to the size of the matrix).

The examples below were run on a Dell PowerEdge C6145 chasis with two nodes. Each
node has 4 AMD Opteron 6276 processors; since each processor has 16 cores, each node
has 64 cores. One node has 256 GB RAM and the other 384 GB of RAM. Both nodes are
connected by Inﬁniband (40Gb/s). For the data presented here, when using a single node,
the data live on an xfs partition of a RAID0 array of SAS disks (15000 rpm) that are local
to the node doing the computations. When using the two nodes, the data live on one of the
xfs partitions, which is seen by the other node using a simple NFS setup (we have also used
distributed ﬁle systems, such as FhGFS, but they have tended to be a lot slower in these
experiments; your mileage might vary). Therefore, in the table entries below, executions
using both nodes will indicate “124 cores” 2

We will also show some examples run on an HP Z800 workstation, with 2 Intel Xeon
E5645 processors (each processor has six cores), and 64 GB of RAM. The data live on an
ext4 partition on a SATA disk (7200 rmp).

In both systems, the operating system is Debian GNU/Linux (a mixture of Debian testing
and Debian unstable). The Dell PowerEdge nodes were running version R-2.15.1 as available
from the Debian repository (v. 2.15.1-5) or, later, R-3.0.1, patched (diﬀerent releases, as
available through May and June of 2013), and compiled from sources. The Xeon workstation
was running R-2.15.1, patched version (2012-10-02 r60861), compiled from sources or, later
R-3.0.1, patched (diﬀerent releases, as available through May and June of 2013). Open MPI
is version 1.4.3-2 (as available from Debian).

1.2 Segmentation methods used

The methods available in ADaCGH2 are (see further details in the help of function pSegment):

• The popular Circular Binary Segmentation approach, described in its current imple-
mentation in Venkatraman and Olshen (2007) and implemented in package DNAcopy.

• A wavelet-based method, proposed in Hsu et al. (2005). This is called pSegementWavelets

in ADaCGH2.

• Another wavelet-based method, HaarSeg, published in Ben-Yaacov and Eldar (2008).

This was later made available as an R-package as Ben-Yaacov and Eldar (2009).

1All sizes are computed from the reported size in bytes or megabytes, using 1024, or powers of 1024, as

denominator.

2124 is not a typo; it is 124, even if the total number of cores is 128 = 64 ∗ 2. This is due to the
following documented issue with Open MPI and Inﬁniband: http://www.open-mpi.org/community/lists/
users/2011/07/17003.php, and since 1282 = 16384, we are hitting the limit, and we have not had a chance
to correct this problem yet. Regardless, the penalty we would pay would be a diﬀerence of 4 process out of
124.

4

• HMM, as described by Fridlyand et al. (2004) and implemented in package Fridlyand

and Dimitrov (2010).

• BioHMM, a non-homogeneous HMM, described in Marioni et al. (2006) and imple-

mented in package Smith et al. (2009).

• The CGHseg method described in Picard et al. (2005). An implementation of part of
this method is available in the R package Huber et al. (2006), but ADaCGH2 is the
ﬁrst R implementation of the full description of the CGHseg procedure (see comments
in the help of function pSegmentCGHseg).

• GLAD, a method ﬁrst described in Hupe et al. (2004) and implemented in Hupe (2011).

1.2.1 Diﬃculties of using some methods with large data sets

The tables below only show benchmarks for methods HMM, BioHMM, HaarSeg (referred
as Haar) and CBS. CGHseg and the wavelet approach described in Hsu et al. (2005) can-
not be used when any chromosome has a large number of probes because of their memory
use. With CGHseg the problem arises in the underlying tilingArray package, in the in-
ternal step of computing the “costMatrix”, a function called by the function segment in
tilingArray. When analyzing the ﬁrst chromosome (for a single subject), the request is
for 1493 GB. For the wavelet approach, the problem shows up in the clustering step, when
function pam (from package cluster) is called. For instance, the memory requirements for a
chromosome of 350000 probes would exceeded 400 GB (the request is for a vector of doubles
of size 1 + (n ∗ (n − 1))). It must be emphasized that, in both cases, it is not the complete 6
million probes, nor using multiple subjects, which causes the problems: neither of the meth-
ods is capable of analyzing the ﬁrst chromosome for a single subject. GLAD seems capable
of dealing with large data sets in terms of memory usage, but it is extremely slow. After
more than four days, the method had not been able to ﬁnish the analysis of the 50-column
data set in the machines with 64 cores; on closer inspection, the problem lies in function
OptimBkpFindCluster, a C function internal to the package, and is not attributable, there-
fore, to the initial segmentation method (we were using, anyway, the recommended fast
function, which uses HaarSeg). Finally, to run method BioHMM we often had to increase
the ulimit (stack limit), by using ulimit -u, from the shell.

1.3 Tables: column name explanation

For the tables below, the meaning of columns is as follows:

Wall time (min.) The “elapsed” entry returned by the command system.time. This is
the real elapsed time, the wall time, in minutes, since the function was called.

It is important to understand that these timings can be variable.
In many cases,
we show repeated executions with the exact same settings, that will help show the
variability in those numbers.

Memory (GB) The memory used by the master R process. This is the sum of the two
rows of the “max used” column reported by gc(), in R, at the end of the execution of
the given function. This number cannot reﬂect all the memory used by the function if
the function spawns other R processes (via MPI or forking, for example).

Σ Memory (GB) A simple attempt to measure the memory used by all the processes3.
Right before starting the execution of our function, we call the operating system com-

3Just adding the entries given by top or ps will not do, and will overestimate, sometimes by a huge amount,

the total memory used.

5

mand free and record the value reported by the “-/+ buﬀers/cache” row. Then, while
the function is executing, we record, every 0.1 seconds (or every 0.05 seconds), that
same quantity. The largest diﬀerence between the successive measures and the original
one is the largest RAM consumption. Note that this is an approximation. First, if
other process start executing, they will lead to an overestimation of RAM usage; this,
however, is unlikely to have had serious eﬀects (the systems were basically idle, except
for light weight cron jobs), though a few results in the tables suggest this happened in
a few instances (related to backup processes). Second, sampling is carried out every
0.5 seconds, so we could miss short peaks in RAM usage but, again, this is unlikely to
lead to a serious underestimation.

Finally, note that for cases where we know that there is a single R process (e.g.,
reading with the old version), there is an excellent agreement between the “Memory
(GB)” (whose value is reported from R itself) and “Σ Memory (GB)”.

Columns The number of data columns of the data set; the same as the number of arrays

or the number of samples.

Method The analysis method. “Haar” for HaarSeg, “CBS” for Circular Binary Segmen-
tation (from package DNAcopy), “HMM” for the HMM approach in package aCGH,
“BioHMM” for the non-homogeneous HMM method in package snapCGH, and “GLAD”
for the method with the same name in package GLAD. See section 1.2.1 for why other
methods are not shown in the tables.

MPI/Fork Whether forking (via mclapply) or explicitly using an MPI cluster (using the
facilities provided by package Rmpi, which are called from package snow) are used
to parallelize execution.

The “NP” entries in table 8 refer to non-parallelized execution, using the original
packages4.

The entries marked as “-LB” correspond to the load-balanced options with the new
version of ADaCGH2 (setting loadBalance = TRUE, in v. ≥ 2.3.4).

Cores Number of cores used. In most cases, when running in the AMD Opteron machines
we used all 64 cores, and when running on the Intel Xeon machine we used all 12
cores, but not always, to show the eﬀects of changing the number of cores used. When
running over both AMD Opterons we used 124 cores (see above).

Procs. per node When using MPI, the total number of R processes that can run in a node;
this is the parameter npernode passed to mpirun (from Open MPI). When running on
a single node, that is the number of R slaves + 1.

Universe size The number of slave nodes in the MPI universe (over all nodes in the uni-

verse). This is the parameter count passed to makeMPIcluster in R.

Version The version of ADaCGH2. For simplicity, “Old” means version 1.10 and “New”

versions 2.1 and larger.

The post-ﬁx “-noNA” means the new version was run using option certain noNA =
TRUE; note that the old version of ADaCGH2 assumes there are no missing values in
the data. Thus, certain noNA = TRUE is the closest to what the old version assumes.

ﬀ/RAM Where applicable in the tables, if the data for the analysis had been stored as an
ﬀ object, or as a data frame inside an RData that was loaded before the analysis.

4The packages are DNAcopy, as available from BioConductor, and the HaarSeg package, available from

R-forge: https://r-forge.r-project.org/projects/haarseg/

6

2 Comparison with v. 1.10 of ADaCGH2

2.1 Main diﬀerences between the old (v. 1.10) and new versions (v. ≥

2.3.4) of ADaCGH2

The code for the new version of ADaCGH2 represent a major rewrite of most of the code in
the former version. Listed here are some of the major advantages of the new version5; they
are shown in approximately decreasing order of importance from the user’s point of view.

Reading of large data sets The new version of ADaCGH2 can read data sets much larger
than the old one (see section 2.3). In a machine with 64 GB RAM the old version cannot
read data sets with 500 columns (each with 6 million probes —see section 1.1), whereas
data sets with 4000 columns can be read with the new version (see table 1) and the
scaling of the memory consumption with number of columns suggests that much larger
data sets could be read. Likewise, in machines with 256 and 384 GB of RAM (tables 2
and 3) data sets of 2000 columns could not be read with the old version of ADaCGH2,
but data sets of 4000 columns are read with the new version and, again, the scaling
of memory consumption with number of columns suggests (see Figure 1) that much
larger data sets could be read and, even for the sizes of data that can be read by the
old version, reading is much faster with the new version because of the parallelized
reading, which can make much better usage of available hardware (e.g., RAID arrays
for disks).

Missing value handling The old version of ADaCGH2 used row-wise deletion of missing
values when reading data: a probe would be deleted from the data if it had one missing
value in any subject/column. Analysis could be speed up, as no checks or provisions
had to be taken for dealing with NAs, and all procedures are simpliﬁed, as the data are
then known to be complete. However, row-wise deletion of missing values is probably
not an appropriate approach, especially as the number of samples increases (because
the probability that a given probe will then be left out of the analysis increases).
The new version of ADaCGH2 deals with missing values column by column, so for
each column (or subject) all available data (or probes) are used in the segmentation.
Nevertheless, the new version incorporates a setting to provide speed ups when the
user is certain that there are no missing values (certain noNA = TRUE).

Analysis of large data sets The old version of ADaCGH2 cannot analyze large data sets,
as it cannot read them (and it cannot use data read by the new version since the old
version assumes there are no missing values in the data after reading).

In addition, although time increases, obviously, with number of samples to analyze,
the scaling of memory consumption is modest and well below the memory available for
the systems.

Forking and clusters The new version of ADaCGH2 allows for the usage of forking or an
explicit cluster (e.g., MPI, sockets, etc) to parallelize reading and analysis. In POSIX
operating systems (including Unix, GNU/Linux, and Mac OS), forking can be faster,
less memory consuming, and much easier to use than using a cluster.

Speed of analysis The new version can be slightly faster than the old one for the default
options. Further speed improvements can be achieved in some cases, for instance by
not using load balancing with certain methods (e.g., HaarSeg).

5Most of the new capabilities were already available in version 2.1.3; however, the vignettes have suﬀered
major changes and there have been some changes in the code and help ﬁles. Thus, these comments all do
apply to version ≥ 2.3.4.

7

Flexibility of reading data The new version of ADaCGH2 has not removed the mech-
anisms of reading data available in the old version. Thus, when data are small or
memory is plentiful, reading data from a single RData is an available option. But the
new version adds new mechanisms, mainly reading from a text ﬁle and from a directory
of text ﬁles that, as discussed above, allow for reading much larger data sets.

Usage of data read from the other version The new version of ADaCGH2 can accept
data read by the old version. However, the old version of ADaCGH2 cannot accept
data from read by the new version unless the original data contained no missing values
at all: the old version of ADaCGH2 assumes that data that have been read contain no
missing values.

Dependencies The old version depends on package snowfall for parallelization, whereas
the new version depends only on multicore. This makes the new version less likely
to break in the future, as multicore is one of the core packages distributed with R
(whereas, for instance, there were some problems with snowfall not building with the
development versions of v. 3 of R around February 2013).

More ﬂexible options for load balancing The old version of ADaCGH2 forced load bal-
ancing. Whether or not load-balancing is the best approach depends on the size and
number of jobs relative to the number of cores. As shown in the tables (see tables 4,
6, 5), not using load balancing can sometimes lead to speed improvements. The new
version of ADaCGH2 allows not to use load balancing with the argument loadBalance
= FALSE.

Limiting memory consumption Memory usage is generally well below the available mem-
ory of the system. However, if it were necessary to limit memory usage during reading
limit the number of
and analysis this is simple with the new version of ADaCGH2:
processes that are allowed to run simultaneously. This is not possible with the old
version of ADaCGH2.

Method availability Two of the methods available, HMM and BioHMM, depend on pack-
ages aCGH and snapCGH. These two packages haven not been updated since 2010 and
2009, respectively, and aCGH will no longer be maintained (personal communication
from the authors). There is code in the ADaCGH2 repositories (including both C and
R code), taken and modiﬁed from those packages, that can be readily uncommented
to make these two methods available in ADaCGH2 if either of those packages were not
to pass checks in future versions of BioConductor.

2.2 Data and code availability

All scripts, data, and results from these benchmarks are available from http://www2.iib.
uam.es/rduriarte_lab/ADaCGH2-v2-suppl-files/public. The scripts include the R code
to obtain the tables and ﬁgures shown here. All of the code, scripts, and benchmark re-
sults are also available from my personal web site at http://ligarto.org/rdiaz/Papers/
ADaCGH2-v2-suppl-files/ (for space restriction reasons, the more than 140 GB of data in
the form of RData and txt ﬁles are only available from the previous site.)

8

2.3 Reading data

The next three tables show time and memory consumption when reading data using the
recommended approach with each version of the package (an RData object for the old version,
a directory of single-column txt ﬁles for the new version). Some of the major patterns and
results are:

Size limits for old version Table 1 cannot show reading benchmarks for the old version
with data sets of sizes 500, 1000, 2000, or 4000, as those could not be read with the old
version (R run out of memory). Likewise, tables 2 and 3 show reading benchmarks for
the old version with up to 1000 columns, because the AMD Opteron machines with ≥
256 GB RAM could not read data sets of sizes 2000 or 4000, as R could not allocate
the necessary memory.

In contrast, the new version is capable of reading data sets of 4000 columns in all
machines, without getting anywhere near the memory limits of the machines. More-
over, the scaling (see also ﬁgure 1) shows that the total number of columns could be
increased to much larger numbers and, in addition, that the total memory used can be
limited by reducing the number of cores used (with little eﬀects on speed —see next
point).

Speed of new and old version Reading is much faster with the new version. These dif-
ferences are most likely inconsequential for small sized data sets (where diﬀerences are
by a factor of about 2x), but can have large eﬀects with a large number of columns.
As data sets grow larger in size, reading speeds are much faster with the new version
than the old by factors of about 10x (this can only be veriﬁed in the machines with
larger memory, as the old version will not read data sets of 500 columns or more in
the smaller machine). There can, nevertheless, be quite a bit of variation in reading
speeds of small data sets, specially in less capable machines; these variations, however,
are most likely of little practical relevance.

Speed and number of cores in new version Reading speed does not always increase
with the number of cores. In fact, for a range of number of cores, reading speeds show
little variation with number of cores, as the most likely limiting factor is I/O, which is
related to the number of spindles and the speed of the drives. Increasing the number
of cores used, however, tends to make the system less responsive (higher loads) and
thus using a reasonably small number of cores is recommended and the default option.

If the reading operation is to be performed many times, or on very large set of data,
it would pay oﬀ to experiment with the number of cores used for reading, which can
be done with the option mc.cores to the function inputToADaCGH.

9

Table 1: Reading benchmarks for Coleonyx: Intel Xeon E5645, 12 cores, 64 GB RAM

Wall time (min.) Memory (GB) Σ Memory (GB) Columns Cores Version

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48

3.0
3.0
5.7
2.7
2.7
2.4
2.4
2.4
6.0
2.4
5.9
2.4
2.4
4.2
4.6
4.5
4.2
4.1
12.4
10.2
6.2
6.2
3.9
4.2
3.9
4.1
3.5
3.3
3.3
3.4
3.3
3.3
2.9
2.9
2.8
2.8
2.9
2.9
2.7
2.7
2.7
2.6
10.3
2.6
10.0
2.6
2.8
7.1

3.2
3.2
4.5
4.5
4.5
5.6
6.9
8.0
8.1
8.1
8.1
8.1
8.1
9.0
8.9
8.6
9.0
9.0
1.3
1.3
2.0
1.9
3.3
3.2
3.4
3.4
4.4
4.4
4.5
4.5
5.0
5.0
5.7
5.7
6.2
6.2
7.0
6.9
7.5
7.5
8.1
8.1
8.1
8.1
8.1
8.4
8.1
17.0

50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100

4 New
4 New
6 New
6 New
6 New
8 New
10 New
12 New
12 New
12 New
12 New
12 New
12 New
Old
Old
Old
Old
Old
1 New
1 New
2 New
2 New
4 New
4 New
4 New
4 New
6 New
6 New
6 New
6 New
7 New
7 New
8 New
8 New
9 New
9 New
10 New
10 New
11 New
11 New
12 New
12 New
12 New
12 New
12 New
12 New
12 New
Old

1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
9.05
9.05
9.05
9.05
9.05
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
16.93

10

Table 1: (Reading benchmarks for Coleonyx: Intel Xeon E5645, 12 cores, 64 GB RAM,
continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Columns Cores Version

49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95

5.9
5.5
5.6
6.1
6.3
17.4
5.0
4.9
4.8
5.6
4.6
4.2
4.2
4.1
4.1
3.9
3.8
3.8
3.6
3.5
3.6
18.3
3.4
12.8
3.6
3.6
9.2
9.1
9.1
9.1
42.2
41.1
42.4
42.7
44.6
44.5
42.4
82.3
81.7
85.8
87.7
96.2
171.2
173.8
162.3
173.0
181.6

16.4
16.6
17.0
3.5
3.5
4.7
4.6
4.6
4.8
5.1
5.0
5.9
5.9
6.2
6.3
7.2
7.0
7.5
7.5
8.1
8.2
8.2
8.1
8.4
8.1
8.3
30.0
31.1
31.1
31.2
3.4
4.4
6.1
7.3
8.5
8.7
8.5
3.6
4.4
6.1
7.3
8.6
3.6
4.5
4.7
6.1
7.4

100
100
100
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
500
500
500
500
500
500
500
1000
1000
1000
1000
1000
2000
2000
2000
2000
2000

Old
Old
Old
4 New
4 New
6 New
6 New
6 New
6 New
7 New
7 New
8 New
8 New
9 New
9 New
10 New
10 New
11 New
11 New
12 New
12 New
12 New
12 New
12 New
12 New
12 New
Old
Old
Old
Old
4 New
6 New
8 New
10 New
12 New
12 New
12 New
4 New
6 New
8 New
10 New
12 New
4 New
6 New
6 New
8 New
10 New

16.93
16.93
16.93
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
30.01
31.23
31.02
31.02
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33

11

Table 1: (Reading benchmarks for Coleonyx: Intel Xeon E5645, 12 cores, 64 GB RAM,
continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Columns Cores Version

96
97
98
99
100
101
102

188.2
349.3
339.7
333.8
347.5
366.6
373.4

1.33
1.32
1.32
1.32
1.32
1.32
1.32

8.7
3.0
4.4
4.4
6.1
7.4
8.6

2000
4000
4000
4000
4000
4000
4000

12 New
4 New
6 New
6 New
8 New
10 New
12 New

12

Figure 1: Comparison between old and new versions in wall time and total memory usage
(over all spawned processes) when reading data as a function of number of columns (or arrays
or samples). Both axes shown in log scale. The ﬁgure shows the benchmarks using 12 cores
in the Intel Xeon machine and 64 cores in the AMD Opterons; note that for some scenarios
better speeds (and lower memory usage) can be achieved by decreasing the number of cores
used (see tables). When more than one benchmark is available for a scenario, the median is
shown.

13

lllllllColumnsWall time (min.)2510205010020050100200500100020004000lOldNewlllllllColumnsMemory (GB)101520253050100200500100020004000Coleonyx: Intel Xeon E5645, 12 cores, 64 GB RAMlllllllColumnsWall time (min.)3510205050100200500100020004000lllllllColumnsMemory (GB)510205010050100200500100020004000Gallotia: AMD Opteron 6276, 64 cores, 256 GB RAMlllllllColumnsWall time (min.)3510205050100200500100020004000lllllllColumnsMemory (GB)610205010050100200500100020004000Lacerta: AMD Opteron 6276, 64 cores, 384 GB RAMTable 2: Reading benchmarks for Gallotia: AMD Opteron 6276, 64 cores, 256 GB RAM

Wall time (min.) Memory (GB) Σ Memory (GB) Columns Cores Version

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48

3.7
3.8
3.5
3.2
3.4
2.9
2.9
2.8
3.3
2.8
2.8
2.7
3.1
2.8
2.6
2.9
2.9
2.9
2.7
2.9
2.9
6.6
7.3
6.5
7.1
6.5
5.0
5.0
4.3
3.8
4.1
3.2
3.4
3.0
3.6
2.8
3.3
3.0
3.1
3.2
3.1
3.0
2.9
2.7
3.4
2.7
3.0
9.8

3.8
3.8
6.9
6.9
6.7
11.5
11.6
17.0
16.5
9.9
10.0
5.8
5.8
6.1
5.7
6.2
5.4
5.6
6.3
5.7
5.7
9.1
9.1
9.1
9.1
9.1
4.0
4.0
6.9
7.1
6.8
13.1
13.1
17.1
16.9
21.5
21.0
24.9
24.9
21.9
23.0
18.7
19.3
18.8
16.8
18.3
18.6
17.0

50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100

5 New
5 New
10 New
10 New
10 New
20 New
20 New
30 New
30 New
40 New
40 New
50 New
50 New
55 New
55 New
60 New
60 New
64 New
64 New
64 New
64 New
Old
Old
Old
Old
Old
5 New
5 New
10 New
10 New
10 New
20 New
20 New
30 New
30 New
40 New
40 New
50 New
50 New
55 New
55 New
60 New
60 New
64 New
64 New
64 New
64 New
Old

1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
9.05
9.05
9.05
9.05
9.05
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
16.93

14

Table 2: (Reading benchmarks for Gallotia: AMD Opteron 6276, 64 cores, 256 GB RAM,
continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Columns Cores Version

49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95

10.9
10.1
9.8
7.5
7.7
5.5
5.2
5.7
3.6
3.9
3.5
4.8
3.8
3.7
3.3
3.7
3.5
3.2
3.6
3.5
3.5
3.5
3.5
3.5
16.6
18.9
17.0
15.9
15.1
15.1
10.1
9.0
9.9
5.8
5.6
4.9
8.7
4.9
4.7
4.2
4.7
4.8
4.6
4.4
4.5
4.4
4.3

17.0
17.0
16.9
4.1
4.0
6.8
7.4
7.1
13.3
13.3
19.2
18.7
24.2
24.2
28.0
28.2
30.4
30.1
32.8
32.4
35.2
35.2
35.1
35.2
32.6
32.4
32.4
32.5
4.3
4.3
7.1
7.5
7.3
13.6
13.7
18.7
18.5
24.3
24.5
30.1
30.3
33.2
33.4
36.0
36.2
38.7
38.4

100
100
100
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500

Old
Old
Old
5 New
5 New
10 New
10 New
10 New
20 New
20 New
30 New
30 New
40 New
40 New
50 New
50 New
55 New
55 New
60 New
60 New
64 New
64 New
64 New
64 New
Old
Old
Old
Old
5 New
5 New
10 New
10 New
10 New
20 New
20 New
30 New
30 New
40 New
40 New
50 New
50 New
55 New
55 New
60 New
60 New
64 New
64 New

16.93
16.93
16.93
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
32.24
32.24
32.24
32.24
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33

15

Table 2: (Reading benchmarks for Gallotia: AMD Opteron 6276, 64 cores, 256 GB RAM,
continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Columns Cores Version

96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142

4.3
4.6
36.5
37.7
35.8
35.7
28.1
26.7
17.9
14.9
16.6
8.9
8.5
6.8
9.9
6.6
6.7
6.2
6.3
6.4
6.5
6.0
6.2
5.6
5.8
5.9
6.0
5.9
64.8
67.2
55.4
56.7
30.3
32.4
32.1
30.3
23.6
21.1
29.6
19.4
31.3
22.3
22.5
21.9
26.2
21.2
23.0

38.7
38.6
78.3
79.3
77.8
78.4
4.8
4.8
7.5
7.8
7.6
13.9
13.9
19.3
18.3
24.6
24.7
30.5
30.2
33.5
33.2
36.4
36.4
39.0
38.7
38.4
38.6
38.3
154.2
155.0
5.8
5.7
7.9
8.7
8.4
8.8
14.5
14.5
14.4
20.0
19.5
25.6
25.2
25.5
30.1
30.5
33.5

500
500
500
500
500
500
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000

64 New
64 New
Old
Old
Old
Old
5 New
5 New
10 New
10 New
10 New
20 New
20 New
30 New
30 New
40 New
40 New
50 New
50 New
55 New
55 New
60 New
60 New
64 New
64 New
64 New
64 New
64 New
Old
Old
5 New
5 New
10 New
10 New
10 New
10 New
20 New
20 New
20 New
30 New
30 New
40 New
40 New
40 New
50 New
50 New
55 New

1.33
1.33
77.67
77.62
77.67
77.67
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
153.58
153.58
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33

16

Table 2: (Reading benchmarks for Gallotia: AMD Opteron 6276, 64 cores, 256 GB RAM,
continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Columns Cores Version

143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166

23.0
21.8
21.1
21.1
21.8
19.7
110.2
60.9
62.6
58.0
59.1
60.1
59.2
63.8
62.1
63.2
65.0
65.8
64.5
65.4
65.7
66.7
65.8
67.4

1.33
1.33
1.33
1.33
1.33
1.33
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32

33.7
36.3
36.2
38.8
38.4
38.8
6.2
9.2
9.5
15.0
15.0
18.8
19.8
26.0
26.0
31.6
31.9
34.9
34.3
37.0
37.1
39.2
39.7
39.6

2000
2000
2000
2000
2000
2000
4000
4000
4000
4000
4000
4000
4000
4000
4000
4000
4000
4000
4000
4000
4000
4000
4000
4000

55 New
60 New
60 New
64 New
64 New
64 New
5 New
10 New
10 New
20 New
20 New
30 New
30 New
40 New
40 New
50 New
50 New
55 New
55 New
60 New
60 New
64 New
64 New
64 New

17

Table 3: Reading benchmarks for Lacerta: AMD Opteron 6276, 64 cores, 384 GB RAM

Wall time (min.) Memory (GB) Σ Memory (GB) Columns Cores Version

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48

3.5
3.5
3.2
3.3
2.8
3.3
2.9
3.3
2.8
2.8
2.8
2.9
2.8
3.0
2.8
2.6
2.8
2.4
2.7
2.9
6.4
6.2
6.9
4.9
5.1
4.0
3.5
3.1
3.6
3.0
3.6
3.0
3.7
2.9
3.4
3.1
3.1
2.9
3.4
2.8
2.6
2.7
2.9
10.2
9.2
10.2
7.3
7.7

3.8
3.8
6.8
6.9
11.5
11.6
17.0
16.7
9.2
9.3
5.5
5.9
5.8
5.7
5.8
5.9
6.1
5.9
6.4
5.6
9.0
9.1
9.1
4.0
4.0
6.8
7.1
13.1
12.8
17.4
16.9
21.5
21.3
24.8
24.2
22.6
23.2
20.3
17.4
17.0
18.0
18.7
18.3
16.9
16.9
17.1
4.0
4.1

50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
50
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
100
200
200

5 New
5 New
10 New
10 New
20 New
20 New
30 New
30 New
40 New
40 New
50 New
50 New
55 New
55 New
60 New
60 New
64 New
64 New
64 New
64 New
Old
Old
Old
5 New
5 New
10 New
10 New
20 New
20 New
30 New
30 New
40 New
40 New
50 New
50 New
55 New
55 New
60 New
60 New
64 New
64 New
64 New
64 New
Old
Old
Old
5 New
5 New

1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
9.05
9.05
9.05
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
16.93
16.93
16.93
1.33
1.33

18

Table 3: (Reading benchmarks for Lacerta: AMD Opteron 6276, 64 cores, 384 GB RAM,
continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Columns Cores Version

49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95

5.4
4.9
4.0
4.6
3.5
3.9
3.5
4.1
3.4
3.8
3.4
3.6
3.4
3.7
3.2
3.5
3.7
3.5
16.6
15.5
15.7
14.8
15.4
9.6
8.4
5.3
8.1
4.8
5.4
5.4
4.8
4.8
4.6
4.8
4.6
5.1
4.4
4.3
4.6
4.5
4.6
35.2
35.8
36.7
27.0
27.9
17.1

6.9
7.3
13.3
12.7
19.1
18.4
24.1
24.1
28.6
28.1
30.4
30.4
32.9
33.0
35.1
35.2
35.0
34.4
32.1
32.4
32.6
4.4
4.4
7.5
7.6
13.7
12.8
18.9
18.7
24.6
24.4
30.4
30.3
33.2
33.3
36.2
36.6
39.3
39.0
39.0
38.6
77.4
77.6
77.2
4.9
4.8
8.2

200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
200
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500
500
1000
1000
1000

10 New
10 New
20 New
20 New
30 New
30 New
40 New
40 New
50 New
50 New
55 New
55 New
60 New
60 New
64 New
64 New
64 New
64 New
Old
Old
Old
5 New
5 New
10 New
10 New
20 New
20 New
30 New
30 New
40 New
40 New
50 New
50 New
55 New
55 New
60 New
60 New
64 New
64 New
64 New
64 New
Old
Old
Old
5 New
5 New
10 New

1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
32.24
32.24
32.24
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
77.67
77.67
77.67
1.33
1.33
1.33

19

Table 3: (Reading benchmarks for Lacerta: AMD Opteron 6276, 64 cores, 384 GB RAM,
continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Columns Cores Version

96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142

14.9
9.1
9.1
7.5
7.3
7.0
6.7
6.3
6.3
6.1
6.1
5.9
5.9
6.1
5.9
6.1
6.0
5.8
64.9
59.7
59.1
52.1
54.5
29.5
26.7
31.7
15.5
15.5
25.5
13.2
11.7
17.1
10.9
11.1
12.8
10.2
10.8
9.7
10.1
9.1
9.0
12.1
9.2
121.5
65.1
57.4
62.1

7.8
13.8
13.8
18.7
19.6
24.6
24.8
30.2
30.6
33.1
33.3
36.1
36.4
39.4
38.9
38.6
38.9
38.4
154.1
155.5
155.5
6.0
6.1
8.2
8.9
9.6
14.9
14.7
14.9
20.2
20.7
25.5
25.7
25.8
31.4
31.8
34.1
34.5
37.7
37.1
39.4
39.2
39.9
7.7
10.6
16.2
16.2

1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
1000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
2000
4000
4000
4000
4000

10 New
20 New
20 New
30 New
30 New
40 New
40 New
50 New
50 New
55 New
55 New
60 New
60 New
64 New
64 New
64 New
64 New
64 New
Old
Old
Old
5 New
5 New
10 New
10 New
10 New
20 New
20 New
20 New
30 New
30 New
40 New
40 New
40 New
50 New
50 New
55 New
55 New
60 New
60 New
64 New
64 New
64 New
5 New
10 New
20 New
20 New

1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
153.58
153.58
153.58
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.33
1.32
1.32
1.32
1.32

20

Table 3: (Reading benchmarks for Lacerta: AMD Opteron 6276, 64 cores, 384 GB RAM,
continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Columns Cores Version

143
144
145
146
147
148
149
150
151
152
153
154
155

45.3
47.0
58.3
73.1
61.6
72.1
64.6
69.9
65.1
71.6
66.3
68.4
72.4

1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32
1.32

22.6
19.5
26.9
27.4
32.6
31.5
35.6
35.4
38.1
38.5
40.3
40.1
40.5

4000
4000
4000
4000
4000
4000
4000
4000
4000
4000
4000
4000
4000

30 New
30 New
40 New
40 New
50 New
50 New
55 New
55 New
60 New
60 New
64 New
64 New
64 New

21

2.4 Analyzing data

The next four tables show time and memory consumption when analyzing data. For the old
version, the largest data sets analyzed are of 200 columns for the Intel Xeon machine with 64
GB of RAM, and 1000 columns for the AMD Opteron machines (see details in section 2.3).
In these benchmarks, runs were not allowed to run for more than 36 hours (2160 minutes)
except for a few cases that were allowed to run for longer to either compare between methods
(e.g., HMM in Coleonyx) or to verify that the method is deﬁnitely not suitable for very large
data, such as in the case of GLAD, where two processes were allowed to run for four days
(see section 1.2.1). Finally, note that we do not compute the time it takes to set up the MPI
environment (with the old version or with the new version, when using MPI), but only the
time of the call for the segmentation itself; setting up the cluster takes about half a minute
to a minute.

Some of the major patterns and results shown in tables 4 to 7 (see also Figure2) are:

Version comparison There are small speed diﬀerences between the old and new versions,
generally favoring the new version, specially with HaarSeg and CBS. The new version
generally also uses less memory than the old version. The main diﬀerence, however, is
that the new version can analyze much larger data sets, as the old version is limited
by the size of the data sets that can be read (see section 2.3).

Load balancing Load balancing is generally a good choice, but not with HaarSeg on a
single multicore machine, because the individual analysis of HaarSeg are so fast that
they rarely make it worth it the increased communication and processing overheads of
load balancing.

MPI vs. forking Forking is faster than MPI when running on a single node, which is to
be expected, and in some cases (e.g., HMM) the diﬀerences can be very large.

Running over several nodes Even with fast communication between nodes (as in this
case) duplicating the number of cores might not result in signiﬁcant decreases in wall
time for the fastest methods. In particular, Wall time for HaarSeg is actually larger
when run over two nodes. For CBS there is a slight advantage of running over two
nodes. Running over more than one node to increase the number of cores/CPUs is,
however, advantageous for the slower methods (e.g., HMM).

Note that these results are highly hardware dependent: slower communication
between nodes or slower I/O from shared storage will make running over several nodes
less worth it. However, increasing the available number of cores/CPUs by larger factors
(e.g., 4x or 8x) might make it worth it to use them even for fast methods such as
HaarSeg.

22

Figure 2: Comparison between old and new version in wall time and total memory usage
(over all spawned processes) as a function of number of columns (or arrays or samples).
Both axes shown in log scale. The ﬁgure shows the default use cases: using 12 cores in the
Intel Xeon machine and 64 cores in the AMD Opterons. Since the old - version assumes no
missing data, when possible (i.e., when data read by the old version are available) the data
without missing values have been used with option certain noNA = TRUE; these correspond
to rows labeled “New-noNA” in tables 4 to 7. When more than one benchmark is available
for a scenario, the median is shown.

23

ColumnsWall time (min.)151050100500100050100200500100020004000lllllllllColumnsMemory (GB)68101214161850100200500100020004000lllllllllColeonyx: Intel Xeon E5645, 12 cores, 64 GB RAMllHaar, OldHaar, NewCBS, OldCBS, NewHMM, OldHMM, NewBioHMM, OldBioHMM, NewColumnsWall time (min.)0.51.05.010.050.0100.0500.01000.050100200500100020004000llllllllllllColumnsMemory (GB)2025303540455050100200500100020004000llllllllllllGallotia: AMD Opteron 6276, 64 cores, 256 GB RAMColumnsWall time (min.)0.51.05.010.050.0100.0500.01000.050100200500100020004000llllllllllColumnsMemory (GB)202530354045505550100200500100020004000llllllllllLacerta: AMD Opteron 6276, 64 cores, 384 GB RAMColumnsWall time (min.)1510501005001000200100020004000llllllColumnsMemory (GB)3035404550200100020004000llllllLacerta and Gallotia with MPI over Infiniband (124 cores)Table 4: Analysis benchmarks for Coleonyx: Intel Xeon E5645, 12 cores, 64 GB RAM

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

Version

2
4

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29

2.0
1.8
1.4
1.2
1.6
1.4
1.3
1.2
3.1
3.2
2.8
3.1
2.3
2.2
2.7
2.6
2.3
2.3
5.8
5.3
7.9
5.7
4.8
4.2
5.3
6.7
5.2
4.8
4.5

0.13
0.13
0.13
0.13
0.13
0.16
0.16
0.16
0.14
0.13
0.13
0.13
0.13
0.13
0.13
0.17
0.17
0.17
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.18
0.18

5.3 Haar
5.2 Haar
5.0 Haar
4.9 Haar
4.9 Haar
5.8 Haar
6.2 Haar
6.4 Haar
5.2 Haar
5.1 Haar
3.2 Haar
5.2 Haar
5.0 Haar
5.0 Haar
5.0 Haar
5.9 Haar
6.1 Haar
6.1 Haar
5.2 Haar
5.4 Haar
5.3 Haar
5.6 Haar
5.3 Haar
5.0 Haar
5.0 Haar
5.2 Haar
5.1 Haar
6.0 Haar
6.5 Haar

12
12
12
12
12

12
12

12
12
12

12
12

12
12
12

50 Fork
50 Fork-LB
50 Fork
50 Fork
50 Fork-LB
50 MPI
50 MPI
50 MPI
100 Fork
100 Fork-LB
100 MPI
100 MPI-LB
100 Fork
100 Fork
100 Fork-LB
100 MPI
100 MPI
100 MPI
200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 Fork
200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 MPI
200 MPI

New
New
New-noNA
New-noNA
New-noNA

11 Old
12 Old
12 Old
New
New
11 New
11 New

New-noNA
New-noNA
New-noNA

11 Old
12 Old
12 Old
New
New
11 New
11 New

New-noNA
New-noNA
New-noNA
11 New-noNA
11 New-noNA
11 Old
12 Old

12
13
13

12
12

12
13
13

12
12

12
12
12
13

Table 4: (Analysis benchmarks for Coleonyx: Intel Xeon E5645, 12 cores, 64 GB RAM, continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

Version

2
5

30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58

4.3
38.9
29.8
38.7
29.8
54.2
58.6
104.1
117.3
69.7
64.5
70.0
68.3
70.9
64.6
74.2
74.1
77.3
133.5
124.2
132.4
131.2
122.7
146.2
147.9
150.0
250.8
241.4
380.0

0.18
0.14
0.14
0.14
0.14
0.15
0.15
0.18
0.18
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13

6.5 Haar
5.6 Haar
5.7 Haar
5.7 Haar
10.0 Haar
6.1 Haar
6.1 Haar
6.7 Haar
6.3 Haar
7.5 CBS
7.1 CBS
6.8 CBS
6.6 CBS
6.8 CBS
6.2 CBS
7.6 CBS
7.6 CBS
8.1 CBS
9.8 CBS
7.2 CBS
8.4 CBS
7.2 CBS
6.2 CBS
8.0 CBS
7.7 CBS
15.5 CBS
8.2 CBS
7.5 CBS
9.0 CBS

200 MPI
1000 Fork
1000 Fork-LB
1000 MPI
1000 MPI-LB
2000 Fork
2000 Fork-LB
4000 Fork
4000 Fork-LB
50 Fork
50 Fork-LB
50 Fork
50 Fork
50 Fork
50 Fork-LB
50 MPI
50 MPI
50 MPI
100 Fork
100 Fork-LB
100 Fork
100 Fork
100 Fork-LB
100 MPI
100 MPI
100 MPI
200 Fork
200 Fork-LB
200 MPI

12
12

12
12
12
12
12
12
12
12
12
12

12
12
12
12
12

12
12

13

12
12

12
12
13

12
12
13

12

12 Old
New
New
11 New
11 New
New
New
New
New
New
New
New-noNA
New-noNA
New-noNA
New-noNA

11 Old
11 Old
12 Old
New
New
New-noNA
New-noNA
New-noNA

11 Old
11 Old
12 Old
New
New
11 New

Table 4: (Analysis benchmarks for Coleonyx: Intel Xeon E5645, 12 cores, 64 GB RAM, continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

Version

2
6

59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87

307.9
255.2
250.7
240.3
372.4
307.8
287.7
287.2
294.6
1246.0
1185.2
1804.2
1512.4
311.2
309.5
282.1
286.4
288.4
281.0
310.9
284.0
280.1
322.5
324.4
298.2
302.2
299.9
305.8
574.2

0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.14
0.14
0.14
0.14
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18

8.4 CBS
14.2 CBS
7.3 CBS
6.1 CBS
8.7 CBS
7.9 CBS
7.9 CBS
7.2 CBS
10.6 CBS
14.8 CBS
8.2 CBS
10.0 CBS
8.9 CBS
6.4 HMM
10.5 HMM
7.0 HMM
7.1 HMM
9.6 HMM
6.3 HMM
9.1 HMM
11.5 HMM
5.8 HMM
7.2 HMM
7.2 HMM
7.3 HMM
10.2 HMM
8.2 HMM
9.8 HMM
9.5 HMM

200 MPI-LB
200 Fork
200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 MPI
200 MPI
200 MPI
1000 Fork
1000 Fork-LB
1000 MPI
1000 MPI-LB
50 Fork
50 Fork
50 Fork
50 Fork
50 Fork
50 Fork-LB
50 Fork
50 Fork
50 Fork-LB
50 MPI
50 MPI
50 MPI
50 MPI
50 MPI
50 MPI
100 Fork

12
12
12

12
12

11
11
12
12
12
12
12
12
12

12

12

12
12
12
12
13

12
12

11
11
12
12
13
13

11 New

New-noNA
New-noNA
New-noNA
11 New-noNA
11 New-noNA
11 Old
11 Old
12 Old
New
New
11 New
11 New
New
New
New
New
New
New
New-noNA
New-noNA
New-noNA

10 Old
10 Old
11 Old
11 Old
12 Old
12 Old
New

Table 4: (Analysis benchmarks for Coleonyx: Intel Xeon E5645, 12 cores, 64 GB RAM, continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

Version

88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107

2
7

552.2
560.4
559.1
603.0
595.4
1117.5
3188.2
1213.7
1108.7
1122.8
1112.3
3240.6
1205.0
1192.3
1169.4
1122.9
1222.2
2339.5
2235.4
2401.8

0.18
0.18
0.18
0.18
0.18
0.18
0.20
0.20
0.18
0.18
0.18
0.20
0.20
0.20
0.18
0.18
0.18
0.18
0.18
0.18

6.4 HMM
11.3 HMM
6.3 HMM
10.7 HMM
8.5 HMM
6.1 HMM
8.7 HMM
8.1 HMM
7.9 HMM
13.5 HMM
6.1 HMM
9.1 HMM
8.4 HMM
7.3 HMM
10.5 BioHMM
5.5 BioHMM
17.2 BioHMM
11.0 BioHMM
5.5 BioHMM
15.5 BioHMM

100 Fork-LB
100 Fork
100 Fork-LB
100 MPI
100 MPI
200 Fork-LB
200 MPI
200 MPI-LB
200 Fork
200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 MPI
50 Fork
50 Fork-LB
50 MPI
100 Fork
100 Fork-LB
100 MPI

12
12
12

12

12
12
12

12
12

12
12

New
New-noNA
New-noNA

11 Old
12 Old
New
11 New
11 New

New-noNA
New-noNA
New-noNA
11 New-noNA
11 New-noNA
11 Old

New-noNA
New-noNA

12 Old

New-noNA
New-noNA

12 Old

12
13

12
12

12
12
12

13

13

Table 5: Analysis benchmarks for Gallotia: AMD Opteron 6276, 64 cores, 256 GB RAM

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

Version

2
8

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29

0.7
1.4
0.6
0.7
0.6
0.4
1.2
1.9
1.0
1.0
1.1
0.8
0.9
0.9
2.4
2.8
2.6
1.9
1.9
1.8
1.9
2.7
1.8
1.4
1.6
1.5
3.7
3.7
3.8

0.13
0.13
0.13
0.13
0.13
0.16
0.13
0.13
0.13
0.13
0.13
0.17
0.17
0.17
0.13
0.13
0.14
0.14
0.14
0.14
0.13
0.14
0.14
0.18
0.18
0.18
0.13
0.14
0.18

20.2 Haar
18.6 Haar
19.2 Haar
19.3 Haar
19.2 Haar
23.6 Haar
25.7 Haar
23.6 Haar
25.2 Haar
25.0 Haar
24.5 Haar
28.1 Haar
28.0 Haar
27.8 Haar
25.8 Haar
25.2 Haar
28.3 Haar
28.1 Haar
25.0 Haar
25.0 Haar
24.7 Haar
27.1 Haar
26.7 Haar
34.2 Haar
33.2 Haar
32.6 Haar
27.0 Haar
25.6 Haar
31.3 Haar

50 Fork
50 Fork-LB
50 Fork
50 Fork
50 Fork-LB
50 MPI
100 Fork
100 Fork-LB
100 Fork
100 Fork
100 Fork-LB
100 MPI
100 MPI
100 MPI
200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 Fork
200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 MPI
200 MPI
200 MPI
500 Fork
500 Fork
500 MPI

64
64
64
64
64

64
64
64
64
64

64
64

64
64
64

64
64

New
New
New-noNA
New-noNA
New-noNA

63 Old
New
New
New-noNA
New-noNA
New-noNA

63 Old
64 Old
64 Old
New
New
63 New
63 New

New-noNA
New-noNA
New-noNA
63 New-noNA
63 New-noNA
63 Old
64 Old
64 Old
New
New-noNA

63 Old

64

64
65
65

64
64

64
64
64
65
65

64

Table 5: (Analysis benchmarks for Gallotia: AMD Opteron 6276, 64 cores, 256 GB RAM, continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

Version

2
9

30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58

3.0
7.0
10.1
13.0
10.2
12.4
8.9
6.5
8.9
7.3
7.6
8.7
6.2
6.2
5.9
15.3
16.9
21.8
19.9
35.6
40.8
43.2
39.9
25.1
24.3
25.1
24.7
24.0
33.1

0.18
0.14
0.14
0.14
0.14
0.14
0.14
0.14
0.14
0.14
0.14
0.14
0.14
0.14
0.18
0.15
0.15
0.15
0.15
0.18
0.18
0.18
0.18
0.13
0.14
0.13
0.13
0.13
0.13

34.0 Haar
27.7 Haar
27.5 Haar
26.4 Haar
27.4 Haar
29.3 Haar
28.6 Haar
26.3 Haar
26.6 Haar
26.5 Haar
25.9 Haar
25.8 Haar
28.7 Haar
28.5 Haar
33.6 Haar
28.9 Haar
29.8 Haar
28.4 Haar
29.1 Haar
30.7 Haar
30.6 Haar
29.1 Haar
30.2 Haar
29.2 CBS
27.9 CBS
23.8 CBS
23.8 CBS
23.9 CBS
31.2 CBS

500 MPI
1000 Fork
1000 Fork
1000 Fork-LB
1000 Fork-LB
1000 MPI
1000 MPI-LB
1000 Fork
1000 Fork
1000 Fork
1000 Fork-LB
1000 Fork-LB
1000 MPI
1000 MPI-LB
1000 MPI
2000 Fork
2000 Fork
2000 Fork-LB
2000 Fork-LB
4000 Fork
4000 Fork
4000 Fork-LB
4000 Fork-LB
50 Fork
50 Fork-LB
50 Fork
50 Fork
50 Fork-LB
50 MPI

64
64
64
64

64
64
64
64
64

64
64
64
64
64
64
64
64
64
64
64
64
64

64

64
64

64
64
64

64

63 Old
New
New
New
New
63 New
63 New

New-noNA
New-noNA
New-noNA
New-noNA
New-noNA
63 New-noNA
63 New-noNA
63 Old
New
New
New
New
New
New
New
New
New
New
New-noNA
New-noNA
New-noNA

63 Old

Table 5: (Analysis benchmarks for Gallotia: AMD Opteron 6276, 64 cores, 256 GB RAM, continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

Version

3
0

59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87

47.7
45.1
48.2
47.0
44.6
60.3
61.2
61.6
87.5
82.9
134.6
104.1
88.9
87.0
82.5
135.0
104.7
106.6
108.7
107.5
184.6
182.6
231.6
362.5
355.1
356.6
563.2
447.6
358.9

0.13
0.14
0.13
0.14
0.13
0.13
0.13
0.13
0.13
0.14
0.14
0.14
0.13
0.13
0.13
0.14
0.14
0.13
0.13
0.13
0.13
0.14
0.14
0.14
0.14
0.14
0.14
0.14
0.14

37.1 CBS
36.3 CBS
31.1 CBS
30.4 CBS
31.6 CBS
38.8 CBS
39.4 CBS
39.7 CBS
38.7 CBS
37.4 CBS
44.2 CBS
44.3 CBS
34.1 CBS
34.4 CBS
30.8 CBS
41.6 CBS
41.9 CBS
41.7 CBS
43.0 CBS
42.2 CBS
40.7 CBS
36.8 CBS
44.2 CBS
42.1 CBS
36.3 CBS
36.8 CBS
50.9 CBS
49.1 CBS
39.3 CBS

100 Fork
100 Fork-LB
100 Fork
100 Fork
100 Fork-LB
100 MPI
100 MPI
100 MPI
200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 Fork
200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 MPI
200 MPI
200 MPI
500 Fork
500 Fork
500 MPI
1000 Fork
1000 Fork-LB
1000 Fork-LB
1000 MPI
1000 MPI-LB
1000 Fork

64
64
64
64
64

64
64

64
64
64

64
64

64
64
64

64

New
New
New-noNA
New-noNA
New-noNA

63 Old
64 Old
64 Old
New
New
63 New
63 New

New-noNA
New-noNA
New-noNA
63 New-noNA
63 New-noNA
63 Old
64 Old
64 Old
New
New-noNA

63 Old
New
New
New
63 New
63 New

New-noNA

64
65
65

64
64

64
64
64
65
65

64

64
64

Table 5: (Analysis benchmarks for Gallotia: AMD Opteron 6276, 64 cores, 256 GB RAM, continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

3
1

88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116

352.1
446.7
455.5
722.7
696.4
1499.6
1396.8
87.6
105.9
94.5
87.2
83.0
82.2
175.7
174.2
165.4
166.3
179.2
166.9
168.0
166.2
164.0
164.6
160.9
163.0
168.8
167.9
333.8
336.5

0.14
0.14
0.14
0.16
0.16
0.18
0.18
0.18
0.17
0.17
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18

32.0 CBS
45.6 CBS
45.5 CBS
43.8 CBS
37.9 CBS
44.2 CBS
39.0 CBS
25.8 HMM
30.0 HMM
30.0 HMM
23.2 HMM
37.9 HMM
37.6 HMM
33.6 HMM
33.4 HMM
34.5 HMM
34.4 HMM
32.8 HMM
31.4 HMM
31.6 HMM
30.4 HMM
38.9 HMM
39.6 HMM
40.7 HMM
39.9 HMM
41.1 HMM
41.4 HMM
34.4 HMM
34.8 HMM

1000 Fork-LB
1000 MPI-LB
1000 MPI
2000 Fork
2000 Fork-LB
4000 Fork
4000 Fork-LB
50 Fork-LB
50 Fork
50 Fork
50 Fork-LB
50 MPI
50 MPI
100 Fork
100 Fork
100 Fork
100 Fork
100 Fork-LB
100 Fork
100 Fork
100 Fork-LB
100 MPI
100 MPI
100 MPI
100 MPI
100 MPI
100 MPI
200 Fork
200 Fork

64

64
64
64
64
64
64
64
64

63
63
64
64
64
64
64
64

63
63

64
64

64
64

63
63
64
64
65
65

Version
New-noNA
63 New-noNA
63 Old
New
New
New
New
New
New-noNA
New-noNA
New-noNA

63 Old
63 Old
New
New
New
New
New
New-noNA
New-noNA
New-noNA

62 Old
62 Old
63 Old
63 Old
64 Old
64 Old
New
New

Table 5: (Analysis benchmarks for Gallotia: AMD Opteron 6276, 64 cores, 256 GB RAM, continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

Version

3
2

117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142

331.5
333.3
359.6
1110.5
329.7
328.7
328.9
325.1
1109.4
326.9
331.3
330.2
319.5
325.8
1616.9
1618.0
1612.1
469.8
499.2
363.3
964.7
979.8
645.5
1813.8
1939.3
1652.7

0.18
0.18
0.19
0.20
0.20
0.18
0.18
0.18
0.20
0.20
0.20
0.20
0.20
0.20
0.21
0.22
0.26
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.20

36.1 HMM
36.1 HMM
33.1 HMM
40.5 HMM
41.5 HMM
33.5 HMM
33.6 HMM
30.2 HMM
43.1 HMM
42.8 HMM
40.8 HMM
41.1 HMM
41.7 HMM
41.5 HMM
40.7 HMM
30.9 HMM
43.8 HMM
32.2 BioHMM
32.3 BioHMM
42.9 BioHMM
34.5 BioHMM
34.2 BioHMM
47.5 BioHMM
36.1 BioHMM
35.6 BioHMM
48.8 BioHMM

200 Fork
200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 Fork
200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 MPI
200 MPI
200 MPI
200 MPI
1000 Fork
1000 Fork-LB
1000 MPI
50 Fork
50 Fork
50 MPI
100 Fork
100 Fork
100 MPI
200 Fork
200 Fork
200 MPI

64
64
64

64
64
64

64
64

64
64

64
64

64
64

New
New
New
63 New
63 New

New-noNA
New-noNA
New-noNA
63 New-noNA
63 New-noNA
62 Old
62 Old
63 Old
63 Old

New-noNA
New-noNA

63 Old

New-noNA
New-noNA

63 Old

New-noNA
New-noNA

63 Old

New-noNA
New-noNA

63 Old

64
64

64
64
63
63
64
64

64

64

64

64

Table 6: Analysis benchmarks for Lacerta: AMD Opteron 6276, 64 cores, 384 GB RAM

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

Version

3
3

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29

0.7
0.6
0.4
0.6
0.5
0.5
1.3
1.2
0.8
1.1
0.8
1.1
2.5
1.8
2.6
2.1
1.5
2.0
2.4
1.5
1.4
1.9
10.5
8.1
11.4
10.5
11.6
10.0
8.0

0.13
0.13
0.13
0.13
0.16
0.16
0.13
0.13
0.13
0.13
0.17
0.17
0.13
0.13
0.13
0.13
0.14
0.13
0.13
0.13
0.18
0.18
0.14
0.14
0.14
0.14
0.14
0.14
0.14

20.2 Haar
20.2 Haar
19.1 Haar
19.2 Haar
24.3 Haar
24.3 Haar
25.7 Haar
25.7 Haar
25.3 Haar
24.5 Haar
27.8 Haar
28.1 Haar
26.8 Haar
26.9 Haar
28.2 Haar
28.1 Haar
25.1 Haar
24.6 Haar
27.1 Haar
27.1 Haar
31.9 Haar
29.0 Haar
27.9 Haar
27.7 Haar
26.7 Haar
28.2 Haar
29.8 Haar
29.2 Haar
26.3 Haar

50 Fork
50 Fork-LB
50 Fork
50 Fork-LB
50 MPI
50 MPI
100 Fork
100 Fork-LB
100 Fork
100 Fork-LB
100 MPI
100 MPI
200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 MPI
200 MPI
1000 Fork
1000 Fork
1000 Fork-LB
1000 Fork-LB
1000 MPI
1000 MPI-LB
1000 Fork

64
64
64
64

64
64
64
64

64
64

64
64

64
64
64
64

64

New
New
New-noNA
New-noNA

64 Old
64 Old
New
New
New-noNA
New-noNA

63 Old
64 Old
New
New
63 New
63 New

New-noNA
New-noNA
63 New-noNA
63 New-noNA
63 Old
64 Old
New
New
New
New
63 New
63 New

New-noNA

65
65

64
65

64
64

64
64
64
65

64
64

Table 6: (Analysis benchmarks for Lacerta: AMD Opteron 6276, 64 cores, 384 GB RAM, continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

3
4

30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58

8.8
7.1
9.2
7.0
6.1
6.1
6.2
6.2
14.8
16.4
21.7
20.2
36.1
42.2
45.0
44.9
25.5
24.6
25.0
34.0
34.9
44.7
46.2
44.5
61.0
60.6
83.6
131.5
103.3

0.14
0.14
0.14
0.14
0.14
0.14
0.18
0.18
0.14
0.14
0.14
0.14
0.18
0.18
0.18
0.18
0.13
0.13
0.14
0.13
0.13
0.13
0.13
0.14
0.13
0.13
0.13
0.13
0.13

26.7 Haar
26.7 Haar
26.5 Haar
26.2 Haar
28.5 Haar
28.5 Haar
32.9 Haar
34.9 Haar
29.0 Haar
29.1 Haar
27.1 Haar
28.4 Haar
32.3 Haar
31.9 Haar
31.8 Haar
31.7 Haar
26.2 CBS
24.4 CBS
23.1 CBS
35.0 CBS
32.3 CBS
34.0 CBS
31.1 CBS
32.0 CBS
40.5 CBS
41.0 CBS
35.7 CBS
46.1 CBS
43.9 CBS

1000 Fork
1000 Fork
1000 Fork-LB
1000 Fork-LB
1000 MPI
1000 MPI-LB
1000 MPI
1000 MPI
2000 Fork
2000 Fork
2000 Fork-LB
2000 Fork-LB
4000 Fork
4000 Fork
4000 Fork-LB
4000 Fork-LB
50 Fork-LB
50 Fork
50 Fork-LB
50 MPI
50 MPI

100 Fork-LB
100 Fork
100 Fork-LB
100 MPI
100 MPI
200 Fork-LB
200 MPI
200 MPI-LB

64
64
64
64

64
64
64
64
64
64
64
64
64
64
64

64
64
64

64

64
64
65
65

65
65

64
65

64
64

Version
New-noNA
New-noNA
New-noNA
New-noNA
63 New-noNA
63 New-noNA
64 Old
64 Old
New
New
New
New
New
New
New
New
New
New-noNA
New-noNA

64 Old
64 Old
New
New-noNA
New-noNA

63 Old
64 Old
New
63 New
63 New

Table 6: (Analysis benchmarks for Lacerta: AMD Opteron 6276, 64 cores, 384 GB RAM, continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

3
5

59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87

88.1
82.1
134.9
102.8
107.8
109.7
353.7
353.4
556.8
451.2
359.9
352.3
443.2
459.6
722.2
695.2
1430.5
1399.4
94.5
88.0
94.0
86.8
81.3
166.1
167.1
165.6
160.3
166.5
324.9

0.14
0.14
0.13
0.13
0.13
0.13
0.14
0.14
0.14
0.14
0.14
0.14
0.14
0.14
0.15
0.16
0.18
0.18
0.18
0.18
0.17
0.18
0.18
0.18
0.18
0.18
0.18
0.18
0.18

34.1 CBS
30.9 CBS
43.1 CBS
42.0 CBS
42.5 CBS
41.7 CBS
36.7 CBS
36.4 CBS
51.0 CBS
47.9 CBS
38.8 CBS
31.7 CBS
45.0 CBS
45.7 CBS
44.1 CBS
37.3 CBS
46.4 CBS
41.9 CBS
25.8 HMM
25.7 HMM
29.9 HMM
23.0 HMM
38.8 HMM
32.5 HMM
31.7 HMM
29.9 HMM
41.6 HMM
41.0 HMM
32.9 HMM

200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 MPI
200 MPI

1000 Fork-LB
1000 Fork-LB
1000 MPI
1000 MPI-LB
1000 Fork
1000 Fork-LB
1000 MPI-LB
1000 MPI
2000 Fork
2000 Fork-LB
4000 Fork
4000 Fork-LB
50 Fork
50 Fork-LB
50 Fork
50 Fork-LB
50 MPI

100 Fork-LB
100 Fork
100 Fork-LB
100 MPI
100 MPI
200 Fork-LB

64
64

64
64

64
64

64
64
64
64
64
64
64
64

64
64
64

64

64
64
64
65

64
64

64
65

64

64
65

Version
New-noNA
New-noNA
63 New-noNA
63 New-noNA
63 Old
64 Old
New
New
63 New
63 New

New-noNA
New-noNA
63 New-noNA
64 Old
New
New
New
New
New
New
New-noNA
New-noNA

63 Old
New
New-noNA
New-noNA

63 Old
64 Old
New

Table 6: (Analysis benchmarks for Lacerta: AMD Opteron 6276, 64 cores, 384 GB RAM, continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

Version

88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104

3
6

1113.2
326.7
323.8
323.1
1123.3
324.5
322.3
1612.9
1597.5
1613.6
458.4
373.7
328.9
731.2
697.5
1543.5
1525.2

0.20
0.20
0.18
0.19
0.20
0.20
0.20
0.21
0.22
0.27
0.18
0.17
0.18
0.18
0.18
0.18
0.20

41.6 HMM
40.3 HMM
33.0 HMM
30.0 HMM
42.7 HMM
42.7 HMM
40.8 HMM
40.0 HMM
33.9 HMM
43.9 HMM
28.3 BioHMM
32.5 BioHMM
43.2 BioHMM
34.5 BioHMM
47.0 BioHMM
36.0 BioHMM
49.5 BioHMM

200 MPI
200 MPI-LB
200 Fork
200 Fork-LB
200 MPI
200 MPI-LB
200 MPI
1000 Fork
1000 Fork-LB
1000 MPI
50 Fork
50 Fork
50 MPI
100 Fork
100 MPI
200 Fork
200 MPI

64
64

64
64

64
64

64

64

64
64

64
64
64

64

64

64

64

63 New
63 New

New-noNA
New-noNA
63 New-noNA
63 New-noNA
63 Old

New-noNA
New-noNA

63 Old
New
New-noNA

63 Old

New-noNA

63 Old

New-noNA

63 Old

Table 7: Analysis benchmarks using Lacerta and Gallotia with MPI over Inﬁniband (total 124 cores)

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

Version

3
7

1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29

1.4
1.3
1.3
1.3
1.1
1.1
1.0
1.2
1.4
1.3
7.9
4.7
8.8
27.7
15.2
59.0
35.0
70.1
69.6
60.6
60.0
61.2
324.1
239.1
242.5
612.7
452.6
1237.0
893.3

0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.13
0.18
0.18
0.14
0.14
0.18
0.15
0.15
0.18
0.18
0.13
0.13
0.13
0.13
0.13
0.14
0.14
0.14
0.15
0.15
0.18
0.18

27.3 Haar
26.9 Haar
27.1 Haar
27.3 Haar
27.2 Haar
26.7 Haar
26.7 Haar
27.1 Haar
27.4 Haar
27.2 Haar
28.5 Haar
27.5 Haar
32.9 Haar
31.6 Haar
30.8 Haar
31.8 Haar
32.4 Haar
42.1 CBS
41.4 CBS
40.1 CBS
42.0 CBS
41.1 CBS
44.7 CBS
43.9 CBS
44.8 CBS
51.5 CBS
49.6 CBS
53.8 CBS
51.7 CBS

200 MPI
200 MPI
200 MPI
200 MPI
200 MPI-LB
200 MPI-LB
200 MPI-LB
200 MPI-LB
200 MPI
200 MPI
1000 MPI
1000 MPI-LB
1000 MPI
2000 MPI
2000 MPI-LB
4000 MPI
4000 MPI-LB

200 MPI
200 MPI
200 MPI-LB
200 MPI
200 MPI
1000 MPI
1000 MPI-LB
1000 MPI
2000 MPI
2000 MPI-LB
4000 MPI
4000 MPI-LB

63
62
62
63
63
62
62
63
63
62
62
62
62
62
62
62
62
63
62
62
63
62
62
62
62
62
62
62
62

124 New-noNA
124 New-noNA
124 New-noNA
124 New-noNA
124 New-noNA
124 New-noNA
124 New-noNA
124 New-noNA
124 Old
124 Old
124 New-noNA
124 New-noNA
124 Old
124 New
124 New
124 New
124 New
124 New-noNA
124 New-noNA
124 New-noNA
124 Old
124 Old
124 New-noNA
124 New-noNA
124 Old
124 New
124 New
124 New
124 New

Table 7: (Analysis benchmarks using Lacerta and Gallotia with MPI over Inﬁniband (total 124 cores), continued)

Wall time (min.) Memory (GB) Σ Memory (GB) Method Columns MPI/Fork Cores Procs. per node Universe size

Version

30
31
32
33
34
35
36

584.2
172.1
165.7
166.4
847.6
846.4
1489.2

0.20
0.20
0.20
0.20
0.27
0.27
0.35

41.8 HMM
40.9 HMM
41.8 HMM
41.0 HMM
40.4 HMM
43.7 HMM
41.3 HMM

200 MPI
200 MPI-LB
200 MPI
200 MPI

1000 MPI-LB
1000 MPI
2000 MPI-LB

62
62
63
62
62
62
62

124 New-noNA
124 New-noNA
124 Old
124 Old
124 New-noNA
124 Old
124 New

3
8

3 Other comparisons

3.1 Comparison with non-parallelized executions

ADaCGH2 was run without merging, to compare it to the canonical, non-parallelized, im-
plementations of CBS and Haar. Note that, as there are missing values in the data, and
the original HaarSeg code does not deal with missing values, we are forced to remove NAs
array-per-array, and make repeated calls to the function.

39

Table 8: Time and memory usage of segmentation without merging and comparison with
non-parallized executions. These examples have all been run on the Dell Power Edges,
except for the last two, run on the Intel machine (on the Intel machine non-parallelized
runs with 1000 columns cannot be attempted as R runs out of memory loading the data).

Method MPI

Cores

Haar
1
Haar
2
Haar
3
Haar
4
Haar
5
Haar
6
Haar
7
Haar
8
9
Haar
10 Haar
11 Haar

12 CBS
13 CBS
14 CBS
15 CBS
16 CBS
17 CBS
18 CBS
19 CBS
20 CBS
21 CBS
22 CBS

23 Haar
24 CBS
25 Haar
26 CBS

/Fork
Fork
Fork
Fork
Fork
Fork
Fork
Fork
Fork
Fork
Fork
Fork

Fork
Fork
Fork
Fork
Fork
Fork
Fork
Fork
Fork
Fork
Fork

NP
NP
NP
NP

64
10
20
40
50
64
10
20
40
50
64

64
10
20
40
50
64
10
20
40
50
64

-
-
-
-

ﬀ/
RAM
ﬀ
ﬀ
ﬀ
ﬀ
ﬀ
ﬀ
ﬀ
ﬀ
ﬀ
ﬀ
ﬀ

ﬀ
ﬀ
ﬀ
ﬀ
ﬀ
ﬀ
ﬀ
ﬀ
ﬀ
ﬀ
ﬀ

Columns Wall

time

100
1000
1000
1000
1000
1000
2000
2000
2000
2000
2000

100
1000
1000
1000
1000
1000
2000
2000
2000
2000
2000

(min.)
1.2
23.5
12.3
7.4
6.7
6.4
49.7
26.3
15.4
13.3
11.9

55.9
1855.4
939.8
513.5
438.6
350.3
3770.9
1878.8
1007.0
857.1
717.3

Memory
(GB)
0.13
0.142
0.137
0.142
0.139
0.142
0.16
0.16
0.16
0.16
0.16

0.13
0.135
0.135
0.136
0.142
0.142
0.15
0.16
0.15
0.16
0.163

Σ Memory
(GB)
24.5
5.9
10.0
17.6
21.2
26.9
8.0
11.9
19.5
23.2
28.4

35.3
8.6
14.9
27.0
33.1
41.3
11.1
16.5
28.8
35.3
41.9

RAM 100
RAM 100
RAM 1000
RAM 1000

25.2a
1706b
198.3c Cannot allocate memory

12.5
40

12.5
40

Cannot allocate memory

NP
NP

27 Haar
28 CBS
a 25.25 = 0.95 + 22.9 + 1.4: load data, analyze, and save results. If there are no missing values in this
data set, the total time of analysis (i.e., sending the whole matrix at once and not checking for, nor
removing, NAs) is 3.3 minutes.

RAM 100
RAM 100

14.1
38.3

14.1
38.3

-
-

15.1d
1112e

b 1706 = 0.95 + 1698 + 6.7: load data, analyze, and save results. The analysis involves calling the CNA
function to create the CNA object (5.3 min), calling the smooth.CNA function to smooth the data and
detect outlier (83.2 minutes), and segmenting the data with the segment function (1609.5 minutes).
c The analysis uses 113 GB, but results cannot be saved. This was in the machine with 256 GB of RAM.
d 15.1 = 0.65 + 13.5 + 0.9: load data, analyze, and save results.
e 1112 = 0.65 + 1106 + 4.9: load data, analyze, and save results. The analysis involves calling the CNA
function to create the CNA object (0.95 min), calling the smooth.CNA function to smooth the data
and detect outlier (20.2 minutes), and segmenting the data with the segment function (1085 minutes).

40

3.2 Reading from a directory of ﬁles vs. other options

Here we show time and memory usage of options that are not the recommended approach
with large data set (using ﬀ objects and reading from a directory of single-column ﬁles). All
these benchmarks have been carried out in the AMD Opteron machines. These data show
the patterns discussed in the main vignette: with large data sets the best approach is to read
from a directory of single-column ﬁles and store as ﬀ objects. Wall time is much smaller
when reading from a directory of single column ﬁles (see also table 1 for a comparison with
former versions of ADaCGH2, where original data where stored as RData and then read to
ﬀ objects). Moreover, storing as a RAM object, even when possible, might result in a RAM
object that can then not be successfully used for analysis (see section 3.3).

Table 9: Time and memory usage when reading data

Reading operation

Columns Wall time

1 Txt ﬁle to ﬀ

2 RData to ﬀ

3 Directory

data
frame (RAM object)

to

(min)

2630

29.6

22 + 2a

1000

1000

1000

1.3

169

96

4 RData to data frame

1000

22 + 2b

139

(RAM object)

Memory
(GB)

Σ Memory (GB)

NA

168.3

NA. Output unusable
for analysis. See table
3.3.

NA. Output unusable
for analysis. See table
3.3.

5 Directory

data
frame (RAM object)

to

6 Directory

data
frame (RAM object)

to

7 Directory

data
frame (RAM object)

to

200

100

50

7.7 + 0.4c

20

8.7 + 0.3d

10.5

5.8 + 0.1e

5.8

38

30

27

a The 2 reﬂects the time needed to save the resulting data frame to an RData ﬁle.
b The 2 reﬂects the time needed to save the resulting data frame to an RData ﬁle.
c The 0.4 reﬂects the time needed to save the resulting data frame to an RData ﬁle.
d The 0.3 reﬂects the time needed to save the resulting data frame to an RData ﬁle.
e The 0.1 reﬂects the time needed to save the resulting data frame to an RData ﬁle.

41

3.3 Analyzing large data with RAM objects

Here we present some results from attempting to analyze large data sets, with the new
version of ADaCGH2, using RAM objects. Even moderately size data sets (200 columns)
cannot be analyzed when using RAM objects in a machine with 384 GB of RAM; memory
usage is already very large (140 GB) with just 50 columns. Time of analysis is also much
larger for the case shown than for similarly sized problems when using ﬀ objects (see tables
5 and 6).

Table 10: Time and memory usage of segmentation with default options

Method MPI

Cores

ﬀ/RAM Columns Wall time (min.) Memory

1 Haar

2 Haar

/Fork

Fork

Fork

64

64

RAM 50

0.7 + 2.5 + 0.9a

RAM 200

NA

(GB)

14.4

NA

3 Haar

Fork

64

RAM 1000

NA

NA

Σ Mem-
ory (GB)

140

Cannot
allocate
memory

Cannot
allocate
memory

a 0.7 + 2.5 + 0.9: load data, analyze, and save results.

42

4 Comments and recommended usage patterns

4.1 Recommended usage: summary

1. For data analysis, use the defaults when running on a single multicore computer:

(a) ﬀ objects for input and output.

(b) Forking (instead of explicit clusters).

(c) Load balancing, except when using HaarSeg.

2. If you have multiple machines available for analysis, try using them with explicit clus-
ters (e.g., MPI). However, especially for methods such as HaarSeg, the gains could
be modest unless you add many machines to the cluster. Use load balancing for all
methods (i.e., override the defult if using HaarSeg).

3. When reading data, the fastest and least memory consuming is using a directory of
single-column ﬁles. The best number of cores is likely to be strongly hardware (and
possibly ﬁle system) dependent. The default mc.cores has been set to half the number
of cores, but this is not necessarily a sensible default.

4.2 Recommended usage: details

1. Reading data and trying to save it as a RAM object, a usual in-memory data frame,
will quickly exhaust available memory. For these data, we were not able to read data
sets of 100 or more columns. Part of the problem lies on the way memory is handled
and freed in the slaves, given that we are returning lists. In contrast, when saving as
ﬀ objects, the slaves are only returning tiny objects (just pointers to a ﬁle).

2. Saving data as RData objects will also not be an option for large numbers of columns

as we will quickly exhaust available memory when trying to analyze them.

3. In a single machine, and for the same number of cores, analyzing data with MPI is
often generally slower than using forking, which is not surprising. Note also that with
MPI there is an overhead of spawning slaves and loading packages in the slaves (which,
in our case, takes about half a minute to a minute).

4. When using two nodes (i.e., almost doubling the number of cores), MPI might, or
might not, be faster than using forking on a single node. Two main issues aﬀect the
speed diﬀerences:
In our case, the
inter-process communication and access to ﬁles.
likely bottleneck lies in access to ﬁles, which live on an array of disks that is accessed
via NFS. With other hardware/software conﬁgurations, access to shared ﬁles might
be much faster. Regardless, the MPI costs might not be worth if each individual
calculation is fast; this is why MPI with HaarSeg does not pay oﬀ, but it does pay oﬀ
with HMM and is borderline with CBS.

5. When using ﬀ, the exact same operations in systems with diﬀerent RAM can lead to

diﬀerent amounts of memory usage, as ﬀ tries autotuning when starting.

You can tune parameters when you load the ﬀ package, but even if you don’t (and, by
default, we don’t), defaults are often sensible and will play in your favor.

6. Even for relatively small examples, using ﬀ can be faster than using RAM objects.
Using RAM objects incurs overheads of loading and saving the RData objects in mem-
ory, but analyses also tend to be slightly slower. The later is somewhat surprising:
with forking and RAM objects, the R object that holds the CGH data is accessed only

43

for reading, and thus can be shared between all processes. We expected this to be
faster than using ﬀ, because access to disk is several orders of magnitude slower than
access to memory —note that we made sure that memory was not virtual memory
mapped to disk, as we had disabled all swapping. We suspect the main diﬀerence lies
in bottlenecks and contention problems that result from accessing data in a single data
frame simultaneously from multiple processes, compared to loading exactly just one
column independently in each process, and/or repeated cache misses.

7. inputToADaCGH (i.e., transforming a directory of ﬁles into ﬀ objects) can be severely
aﬀected, of course, by other processes accessing the disk. More generally, since with
inputToADaCGH several processes can try to access diﬀerent ﬁles at once (we are trying
to parallelize the reading of data), issues such as type of ﬁle system, conﬁguration and
type of RAID, number of spindles, quality of the RAID card, amount of free space,
etc, etc, etc, can have an eﬀect on all heavy I/O operations. Note also that, as a
general rule, it is better if the newly created ﬀ ﬁles from inputToADaCGH are written
to an empty directory, and if the working directory for segmentation analysis is another
empty directory if you are using ff objects.

inputToADaCGH accepts an argument to reduce the number of cores used, which can
help with contention issues related to I/O. A multicore machine (say, 12 cores) with a
single SATA drive might actually complete the reading faster if you use fewer than 12
cores for the reading. But your mileage might vary. See also comments and full tables
in section 2.3.

8. Reordering data takes time (a lot if you do not use ﬀ objects) and can use a lot of
memory. So it is much better if input data are already ordered (by Chromosome and
Position within Chromosome).

44

References

Ben-Yaacov, E. and Eldar, Y. C. (2008). A fast and ﬂexible method for the segmentation of

aCGH data. Bioinformatics (Oxford, England), 24(16):i139–i145.

Ben-Yaacov, E. and Eldar, Y. C. (2009). HaarSeg: HaarSeg. R package version 0.0.3/r4.

Diaz-Uriarte, R. and Rueda, O. M. (2007). ADaCGH: A parallelized web-based application

and R package for the analysis of aCGH data. PloS one, 2(1):e737.

Fridlyand, J. and Dimitrov, P. (2010). aCGH: Classes and functions for Array Comparative

Genomic Hybridization data. R package version 1.41.2.

Fridlyand, J., Snijders, A. M., Pinkel, D., and Albertson, D. G. (2004). Hidden Markov
models approach to the analysis of array CGH data. . Journal of Multivariate Analysis,
90:132–153.

Hsu, L., Self, S. G., Grove, D., Randolph, T., Wang, K., Delrow, J. J., Loo, L., and Porter,
P. (2005). Denoising array-based comparative genomic hybridization data using wavelets.
Biostatistics, 6(2):211–226.

Huber, W., Toedling, J., and Steinmetz, L. M. (2006). Transcript mapping with high-density

oligonucleotide tiling arrays. Bioinformatics, 22:1963–1970.

Hupe, P. (2011). GLAD: Gain and Loss Analysis of DNA. R package version 2.27.0.

Hupe, P., Stransky, N., Thiery, J. P., Radvanyi, F., and Barillot, E. (2004). Analysis of
array cgh data: from signal ratio to gain and loss of dna regions. Bioinformatics, pages
3413–3422.

Marioni, J. C., Thorne, N. P., and Tavar´e, S. (2006). BioHMM: a heterogeneous hidden

Markov model for segmenting array CGH data. Bioinformatics, 22(9):1144–1146.

Picard, F., Robin, S., Lavielle, M., Vaisse, C., and Daudin, J. J. (2005). A statistical

approach for array CGH data analysis. BMC Bioinformatics, 6.

Smith, M. L., Marioni, J. C., McKinney, S., Hardcastle, T., and Thorne, N. P. (2009).
snapCGH: Segmentation, normalisation and processing of aCGH data. R package version
1.33.0.

Venkatraman, E. S. and Olshen, A. B. (2007). A faster circular binary segmentation algo-
rithm for the analysis of array CGH data. Bioinformatics (Oxford, England), 23(6):657–
663.

45

