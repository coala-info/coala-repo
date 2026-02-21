Using the SRAdb Package to Query the Sequence Read
Archive

Jack Zhu∗and Sean Davis†

Genetics Branch, Center for Cancer Research,
National Cancer Institute,
National Institutes of Health

October 30, 2025

1

Introduction

High throughput sequencing technologies have very rapidly become standard tools in biology.
The data that these machines generate are large, extremely rich. As such, the Sequence
Read Archives (SRA) have been set up at NCBI in the United States, EMBL in Europe,
and DDBJ in Japan to capture these data in public repositories in much the same spirit as
MIAME-compliant microarray databases like NCBI GEO and EBI ArrayExpress.

Accessing data in SRA requires finding it first. This R package provides a convenient and
powerful framework to do just that. In addition, SRAdb features functionality to determine
availability of sequence files and to download files of interest.

SRA currently store aligned reads or other processed data that relies on alignment to a ref-

erence genome. Please refer to the SRA handbook (http://www.ncbi.nlm.nih.gov/books/NBK47537/)
for details. NCBI GEO also often contain aligned reads for sequencing experiments and the
SRAdb package can help to provide links to these data as well.
In combination with the
GEOmetadb and GEOquery packages, these data are also, then, accessible.

2 Getting Started

Since SRA is a continuously growing repository, the SRAdb SQLite file is updated regularly.
The first step, then, is to get the SRAdb SQLite file from the online location. The download
and uncompress steps are done automatically with a single command, getSRAdbFile.

∗zhujack@mail.nih.gov
†sdavis2@mail.nih.gov

1

Figure 1: A graphical representation (sometimes called an Entity-Relationship Diagram) of
the relationships between the main tables in the SRAdb package.

2

> library(SRAdb)
> sqlfile <- file.path(system.file('extdata', package='SRAdb'), 'SRAmetadb_demo.sqlite')

Note: the above "SRAmetadb_demo.sqlite" is a down-sized demo SRAmetadb sqlite
database. The actual SRAmetadb sqlite database can be downloaded using function: get-
SRAdbFile. Warning: the actual SRAmetadb sqlite database is pretty large (> 35GB as of
May, 2018) after uncompression. So, downloading and uncompressing of the actual SRAm-
etadb sqlite could take quite a few minutes depending on your network bandwidth. Direct
links for downloading the SRAmetadb sqlite database: https://s3.amazonaws.com/starbuck1/sradb/SRAmetadb.sqlite.gz
https://gbnci-abcc.ncifcrf.gov/backup/SRAmetadb.sqlite.gz . If interested, it can be timed
using the following commands:

> timeStart <- proc.time()
> sqlfile <- getSRAdbFile()
> proc.time() - timeStart

Since this SQLite file is of key importance in SRAdb, it is perhaps of some interest to

know some details about the file itself.

> file.info(sqlfile)

size
/tmp/RtmpE0R76p/Rinst34c2713c380332/SRAdb/extdata/SRAmetadb_demo.sqlite 4534272

isdir
/tmp/RtmpE0R76p/Rinst34c2713c380332/SRAdb/extdata/SRAmetadb_demo.sqlite FALSE

mode
/tmp/RtmpE0R76p/Rinst34c2713c380332/SRAdb/extdata/SRAmetadb_demo.sqlite 755

mtime
/tmp/RtmpE0R76p/Rinst34c2713c380332/SRAdb/extdata/SRAmetadb_demo.sqlite 2025-10-30 02:46:02
ctime
/tmp/RtmpE0R76p/Rinst34c2713c380332/SRAdb/extdata/SRAmetadb_demo.sqlite 2025-10-30 02:46:06
atime
/tmp/RtmpE0R76p/Rinst34c2713c380332/SRAdb/extdata/SRAmetadb_demo.sqlite 2025-10-30 02:46:02

uid
/tmp/RtmpE0R76p/Rinst34c2713c380332/SRAdb/extdata/SRAmetadb_demo.sqlite 1002
gid
/tmp/RtmpE0R76p/Rinst34c2713c380332/SRAdb/extdata/SRAmetadb_demo.sqlite 1002

uname
/tmp/RtmpE0R76p/Rinst34c2713c380332/SRAdb/extdata/SRAmetadb_demo.sqlite biocbuild
grname
/tmp/RtmpE0R76p/Rinst34c2713c380332/SRAdb/extdata/SRAmetadb_demo.sqlite biocbuild

Then, create a connection for later queries. The standard DBI functionality as im-
plemented in RSQLite function dbConnect makes the connection to the database. The
dbDisconnect function disconnects the connection.

3

> sra_con <- dbConnect(SQLite(),sqlfile)

For further details, at this time see help(’SRAdb-package’).

3 Using the SRAdb package

3.1

Interacting with the database

The functionality covered in this section is covered in much more detail in the DBI and
RSQLite package documentation. We cover enough here only to be useful. The dbListTables
function lists all the tables in the SQLite database handled by the connection object sra_con
created in the previous section. A simplified illustration of the relationship between the SRA
main data types is shown in the Figure 1.

> sra_tables <- dbListTables(sra_con)
> sra_tables

[1] "col_desc"
[3] "fastq"
[5] "run"
[7] "sra"
[9] "sra_ft_content"

"experiment"
"metaInfo"
"sample"
"sra_ft"
"sra_ft_segdir"

[11] "sra_ft_segments" "study"
[13] "submission"

There is also the dbListFields function that can list database fields associated with a

table.

> dbListFields(sra_con,"study")

[1] "study_ID"
[3] "study_accession"
[5] "study_type"
[7] "broker_name"
[9] "center_project_name"

[11] "related_studies"
[13] "sra_link"
[15] "xref_link"
[17] "ddbj_link"
[19] "study_attribute"
[21] "sradb_updated"

"study_alias"
"study_title"
"study_abstract"
"center_name"
"study_description"
"primary_study"
"study_url_link"
"study_entrez_link"
"ena_link"
"submission_accession"

Sometimes it is useful to get the actual SQL schema associated with a table. Here, we

get the table schema for the study table:

4

> dbGetQuery(sra_con,'PRAGMA TABLE_INFO(study)')

cid
0
study_ID REAL
1
study_alias TEXT
2
study_accession TEXT
3
study_title TEXT
4
study_type TEXT
5
study_abstract TEXT
6
broker_name TEXT
7
center_name TEXT
8
center_project_name TEXT
9
study_description TEXT
10
related_studies TEXT
11
primary_study TEXT
12
sra_link TEXT
13
study_url_link TEXT
14
xref_link TEXT
15
study_entrez_link TEXT
16
ddbj_link TEXT
17
ena_link TEXT
study_attribute TEXT
18
19 submission_accession TEXT
sradb_updated TEXT
20

name type notnull
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0

dflt_value pk
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0

NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

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

5

19
20
21

NA
NA
NA

0
0
0

The table "col_desc" contains information of filed name, type, descritption and default

values:

> colDesc <- colDescriptions(sra_con=sra_con)[1:5,]
> colDesc[, 1:4]

field_name
col_desc_ID table_name
ID
1 submission
accession
2 submission
3 submission
alias
4 submission submission_comment
files
5 submission

1
2
3
4
5

type
1
int
2 varchar
3 varchar
text
4
text
5

3.2 Writing SQL queries and getting results

Select 3 records from the study table and show the first 5 columns:

> rs <- dbGetQuery(sra_con,"select * from study limit 3")
> rs[, 1:3]

study_ID study_alias study_accession
DRP002494
DRP002820
DRP002612

DRP002494
DRP002820
DRP002612

865
2297
2403

1
2
3

Get the SRA study accessions and titles from SRA study that study_type contains
“Transcriptome”. The “%” sign is used in combination with the “like” operator to do a
“wildcard” search for the term “Transcriptome” with any number of characters after it.

> rs <- dbGetQuery(sra_con, paste( "select study_accession,
+
+
> rs[1:3,]

"study_description like 'Transcriptome%'",sep=" "))

study_title from study where",

6

study_accession
DRP002494
DRP002820
DRP002612

1
2
3

study_title
1
Allium fistulosum transcriptome sequencing
2 Transcriptome sequence of planarian Dugesia japonica
Bursaphelenchus xylophilus transcriptome
3

Of course, we can combine programming and data access. A simple sapply example

shows how to query each of the tables for number of records.

sql <- sprintf("select count(*) from %s",tableName)
return(dbGetQuery(conn,sql)[1,1])

> getTableCounts <- function(tableName,conn) {
+
+
+ }
> do.call(rbind,sapply(sra_tables[c(2,4,5,11,12)],
+

getTableCounts, sra_con, simplify=FALSE))

experiment
metaInfo
run
sra_ft_segments
study

[,1]
712
2
756
186
31

Get some high-level statistics could be to helpful to get overall idea about what data are
availble in the SRA database. List all study types and number of studies contained for each
of the type:

> rs <- dbGetQuery(sra_con, paste( "SELECT study_type AS StudyType,
+
+
> rs

count( * ) AS Number FROM `study` GROUP BY study_type order
by Number DESC ", sep=""))

Other
1
2
Transcriptome Analysis
3 Whole Genome Sequencing
<NA>
4
Metagenomics
5

StudyType Number
15
11
2
2
1

List all Instrument Models and number of experiments for each of the Instrument Models:

7

> rs <- dbGetQuery(sra_con, paste( "SELECT instrument_model AS
+
+
> rs

'Instrument Model', count( * ) AS Experiments FROM `experiment`
GROUP BY instrument_model order by Experiments DESC", sep=""))

Instrument Model Experiments
430
<NA>
197
Illumina HiSeq 2000
29
Illumina Genome Analyzer II
11
NextSeq 500
10
Illumina HiSeq 2500
10
Illumina HiSeq 1500
8
Illumina Genome Analyzer
6
454 GS FLX Titanium
4
454 GS FLX
3
Illumina MiSeq
3
454 GS FLX+
1
unspecified

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

List all types of library strategies and number of runs for each of them:

> rs <- dbGetQuery(sra_con, paste( "SELECT library_strategy AS
+
+
> rs

'Library Strategy', count( * ) AS Runs FROM `experiment`
GROUP BY library_strategy order by Runs DESC", sep=""))

Library Strategy Runs
430
215
32
17
11
4
2
1

<NA>
RNA-Seq
OTHER
WGS
WXS
RIP-Seq
FL-cDNA
EST

1
2
3
4
5
6
7
8

3.3 Conversion of SRA entity types

Large-scale consumers of SRA data might want to convert SRA entity type from one to
others, e.g. finding all experiment accessions (SRX, ERX or DRX) and run accessions (SRR,
ERR or DRR) associated with "SRP001007" and "SRP000931". Function sraConvert does
the conversion with a very fast mapping between entity types.

Covert "SRP001007" and "SRP000931" to other possible types in the SRAmetadb_demo.sqlite:

8

> conversion <- sraConvert( c('SRP001007','SRP000931'), sra_con = sra_con )
> conversion[1:3,]

study submission

SRA009053 SRS003458
SRA009053 SRS003455
SRA009053 SRS003462

sample experiment
SRX006127
SRX006124
SRX006133

1 SRP000931
2 SRP000931
3 SRP000931
run
1 SRR018261
2 SRR018258
3 SRR018267

Check what SRA types and how many entities for each type:

> apply(conversion, 2, unique)

$study
[1] "SRP000931" "SRP001007"

$submission
[1] "SRA009053" "SRA009276"

$sample

[1] "SRS003458" "SRS003455" "SRS003462"
[4] "SRS003460" "SRS003457" "SRS003459"
[7] "SRS003463" "SRS003453" "SRS003456"
[10] "SRS003461" "SRS003464" "SRS003454"
[13] "SRS004650"

$experiment

[1] "SRX006127" "SRX006124" "SRX006133"
[4] "SRX006131" "SRX006126" "SRX006128"
[7] "SRX006134" "SRX006129" "SRX006125"
[10] "SRX006132" "SRX006122" "SRX006135"
[13] "SRX006123" "SRX006130" "SRX007396"

$run

[1] "SRR018261" "SRR018258" "SRR018267"
[4] "SRR018265" "SRR018260" "SRR018262"
[7] "SRR018268" "SRR018263" "SRR018259"
[10] "SRR018266" "SRR018256" "SRR018269"
[13] "SRR018257" "SRR018264" "SRR020740"
[16] "SRR020739"

9

3.4 Full text search

Searching by regular table and field specific SQL commands can be very powerful and if
you are familiar with SQL language and the table structure.
If not, SQLite has a very
handy module called Full text search (fts3), which allow users to do Google like search with
terms and operators. The function getSRA does Full text search against all fields in a fts3
table with terms constructed with the Standard Query Syntax and Enhanced Query Syntax.
Please see http://www.sqlite.org/fts3.html for detail.

Find all run and study combined records in which any given fields has "breast" and

"cancer" words, including "breast" and "cancer" are not next to each other:

> rs <- getSRA( search_terms = "breast cancer",
+
> dim(rs)

out_types = c('run','study'), sra_con )

[1] 487

23

out_types = c("submission", "study", "sample",
"experiment", "run"), sra_con )

> rs <- getSRA( search_terms = "breast cancer",
+
+
> # get counts for some information interested
> apply( rs[, c('run','sample','study_type','platform',
'instrument_model')], 2, function(x)
+
{length(unique(x))} )
+

sample
104
platform
2

run
487
study_type
5
instrument_model
4

>

If you only want SRA records containing exact phrase of "breast cancer", in which

"breast" and "cancer" do not have other characters between other than a space:

> rs <- getSRA (search_terms ='"breast cancer"',
+
> dim(rs)

out_types=c('run','study'), sra_con)

[1] 487

23

Find all sample records containing words of either "MCF7" or "MCF-7":

10

> rs <- getSRA( search_terms ='MCF7 OR "MCF-7"',
+
> dim(rs)

out_types = c('sample'), sra_con )

[1] 12 10

Find all submissions by GEO:

> rs <- getSRA( search_terms ='submission_center: GEO',
+
> dim(rs)

out_types = c('submission'), sra_con )

[1] 8 6

Find study records containing a word beginning with ’Carcino’:

> rs <- getSRA( search_terms ='Carcino*',
+
> dim(rs)

out_types = c('study'), sra_con=sra_con )

[1]

4 12

3.5 Download SRA data files

List ftp addresses of the fastq files associated with "SRX000122":

> rs = listSRAfile( c("SRX000122"), sra_con, fileType = 'sra' )

The above function does not check file availability, size and date of the sra data files on
the server, but the function getSRAinfo does this, which is good to know if you are preparing
to download them:

> # rs = getSRAinfo ( c("SRX000122"), sra_con, sraType = "sra" )
> # rs[1:3,]

Next you might want to download sra data files from the ftp site. The getSRAfile function
will download all available sra data files associated with "SRR000648" and "SRR000657"
from the NCBI SRA ftp site to the current directory:

> getSRAfile( c("SRR000648","SRR000657"), sra_con, fileType = 'sra' )

Then downloaded sra data files can be easily converted into fastq files using fastq-dump

in SRA Toolkit ( http://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software ):

> system ("fastq-dump SRR000648.sra")

Or directly download fastq files from EBI using ftp protocol:

> getFASTQinfo( c("SRR000648","SRR000657"), sra_con, srcType = 'ftp' )
> getSRAfile( c("SRR000648","SRR000657"), sra_con, fileType = 'fastq' )

11

3.6 Download SRA data files using fasp protocol

Curretly both NCBI and EBI supports fasp protocol for downloading SRA data files, which
has several advantages over ftp protocol, including high-speed transfering large files over long
distance. Please check EBI or NCBI web site or Aspera (http://www.asperasoft.com/) for
details. SRAdb has indcluded two wraper functions for using ascp command line program
(fasp protocol) to download SRA data files frm either the NCBI or EBI, which is included
in in Aspera Connect software. But, due to complexity of installaton of the software and
options within it, the funcitons develpped here ask users to supply main ascp comands.

Download fastq files from EBI ftp siteusing fasp protocol:

> ## List fasp addresses for associated fastq files:
> listSRAfile ( c("SRX000122"), sra_con, fileType = 'fastq', srcType='fasp')
> ## get fasp addresses for associated fastq files:
> getFASTQinfo( c("SRX000122"), sra_con, srcType = 'fasp' )
> ## download fastq files using fasp protocol:
> # the following ascpCMD needs to be constructed according custom
> # system configuration
> # common ascp installation in a Linux system:
> ascpCMD <- 'ascp -QT -l 300m -i
+
> ## common ascpCMD for a Mac OS X system:
> # ascpCMD <- "'/Applications/Aspera Connect.app/Contents/
> # Resources/ascp' -QT -l 300m -i '/Applications/
> # Aspera Connect.app/Contents/Resources/asperaweb_id_dsa.putty'"
>
> getSRAfile( c("SRX000122"), sra_con, fileType = 'fastq',
+

/usr/local/aspera/connect/etc/asperaweb_id_dsa.putty'

ascpCMD = ascpCMD )

srcType = 'fasp',

Download sra files from NCBI using fasp protocol:

> ## List fasp addresses of sra files associated with "SRX000122"
> listSRAfile( c("SRX000122"), sra_con, fileType = 'sra', srcType='fasp')
> ## download sra files using fasp protocol
> getSRAfile( c("SRX000122"), sra_con, fileType = 'sra',
+

ascpCMD = ascpCMD )

srcType = 'fasp',

The downloading messege will show signigicant faster downloading speed than the ftp

protocol:

’ SRR000658.sra 100Completed: 159492K bytes transferred in 5 seconds (249247K bits/sec),

in 1 file. ... ’

12

4

Interactive views of sequence data

Working with sequence data is often best done interactively in a genome browser, a task
not easily done from R itself. We have found the Integrative Genomics Viewer (IGV) a
high-performance visualization tool for interactive exploration of large, integrated datasets,
increasing usefully for visualizing sequence alignments.
In SRAdb, functions startIGV,
load2IGV and load2newIGV provide convenient functionality for R to interact with IGV.
Note that for some OS, these functions might not work or work well.

Launch IGV with 2 GB maximum usable memory support:

> startIGV("mm")

IGV offers a remort control port that allows R to communicate with IGV. The current
command set is fairly limited, but it does allow for some IGV operations to be performed in
the R console. To utilize this functionality, be sure that IGV is set to allow communication via
the “enable port” option in IGV preferences. To load BAM files to IGV and then manipulate
the window:

dir(system.file('extdata',package='SRAdb'),pattern='bam$'))

> exampleBams = file.path(system.file('extdata',package='SRAdb'),
+
> sock <- IGVsocket()
> IGVgenome(sock, 'hg18')
> IGVload(sock, exampleBams)
> IGVgoto(sock, 'chr1:1-1000')
> IGVsnapshot(sock)

5 Graphic view of SRA entities

Due to the nature of SRA data and its design, sometimes it is hard to get a whole picture of
the relationship between a set of SRA entities. Functions of entityGraph and sraGraph in
this package generate graphNEL objects with edgemode=’directed’ from input data.frame
or directly from search terms, and then the plot function can easily draw a diagram.

Create a graphNEL object directly from full text search results of terms ’primary thyroid

cell line’

> library(SRAdb)
> library(Rgraphviz)
> g <- sraGraph('primary thyroid cell line', sra_con)
> attrs <- getDefaultAttrs(list(node=list(
+
> plot(g, attrs=attrs)
> ## similiar search as the above, returned much larger data.frame and graph is too clouded
> g <- sraGraph('Ewing Sarcoma', sra_con)
> plot(g)
>

fillcolor='lightblue', shape='ellipse')))

13

Figure 2: A graphical representation of the relationships between the SRA entities.

14

Please see the Figure 2 for an example diagram.
It’s considered good practise to explicitely disconnect from the database once we are done

with it:

> dbDisconnect(sra_con)

6 Example use case

This sesection will use the functionalities in the SRAdb package to explore data from the
1000 genomes project. Mainly,

1. Get some statistics of meta data and data files from the 1000 genomes project using
the SRAdb 2. Download data files 3. Load bam files into the IGV from R 4. Create some
snapshoots programmtically from R

sqlfile <- getSRAdbFile()

sqlfile <- 'SRAmetadb.sqlite'

> library(SRAdb)
> setwd('1000g')
> if( ! file.exists('SRAmetadb.sqlite') ) {
+
+ } else {
+
+ }
> sra_con <- dbConnect(SQLite(),sqlfile)
> ## get all related accessions
> rs <- getSRA( search_terms = '"1000 Genomes Project"',
+
> dim(rs)
> head(rs)
> ## get counts for each data types
> apply( rs, 2, function(x) {length(unique(x))} )

sra_con=sra_con, acc_only=TRUE)

After you decided what data from the 1000 Genomes, you would like to download data

files from the SRA. But, it might be helpful to know file size before downloading them:

> runs <- tail(rs$run)
> fs <- getSRAinfo( runs, sra_con, sraType = "sra" )

Now you can download the files through ftp protocol:

> getSRAfile( runs, sra_con, fileType ='sra', srcType = "ftp" )

Or, you can download them through fasp protocol:

> ascpCMD <- "'/Applications/Aspera Connect.app/Contents/Resources/ascp' -QT -l 300m -i '/Applications/Aspera Connect.app/Contents/Resources/asperaweb_id_dsa.putty'"
> sra_files = getSRAfile( runs, sra_con, fileType ='sra', srcType = "fasp", ascpCMD = ascpCMD )

15

Next you might want to convert the downloaded sra files into fastq files:

> for( fq in basename(sra_files$fasp) ) {
+
+ }

system ("fastq-dump SRR000648.lite.sra")

... to be compeleted.

7

sessionInfo

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,
LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: BiocGenerics 0.56.0, RCurl 1.98-1.17, RSQLite 2.4.3, SRAdb 1.72.0,

generics 0.1.4, graph 1.88.0

• Loaded via a namespace (and not attached): DBI 1.2.3, R.methodsS3 1.8.2,
R.oo 1.27.1, R.utils 2.13.0, bit 4.6.0, bit64 4.6.0-1, bitops 1.0-9, blob 1.2.4,
cachem 1.1.0, cli 3.6.5, compiler 4.5.1, fastmap 1.2.0, memoise 2.0.1, pkgconfig 2.0.3,
rlang 1.1.6, stats4 4.5.1, tools 4.5.1, vctrs 0.6.5

16

