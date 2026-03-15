# bbmap CWL Generation Report

## bbmap_bbmap.sh

### Tool Description
Fast and accurate splice-aware read aligner.

### Metadata
- **Docker Image**: quay.io/biocontainers/bbmap:39.79--h9b5c0a0_0
- **Homepage**: https://sourceforge.net/projects/bbmap
- **Package**: https://anaconda.org/channels/bioconda/packages/bbmap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bbmap/overview
- **Total Downloads**: 1.8M
- **Last updated**: 2026-03-10
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
BBMap
Written by Brian Bushnell, from Dec. 2010 - present
Last modified September 15, 2022

Description:  Fast and accurate splice-aware read aligner.
Please read bbmap/docs/guides/BBMapGuide.txt for more information.

Usage:                      bbmap.sh ref=<fasta> in=<reads> out=<sam>
Index only:                 bbmap.sh ref=<fasta>
Map to existing index:      bbmap.sh in=<reads> out=<sam>
Map without writing index:  bbmap.sh ref=<fasta> in=<reads> out=<sam> nodisk

in=stdin will accept reads from standard in, and out=stdout will write to 
standard out, but file extensions are still needed to specify the format of the 
input and output files e.g. in=stdin.fa.gz will read gzipped fasta from 
standard in; out=stdout.sam.gz will write gzipped sam; out=x.bam writes bam.

Indexing Parameters (required when building the index):
nodisk=f                Set to true to build index in memory and write nothing 
                        to disk except output.
ref=<file>              Specify the reference sequence.  Only do this ONCE, 
                        when building the index (unless using 'nodisk').
build=1                 If multiple references are indexed in the same directory,
                        each needs a unique numeric ID (unless using 'nodisk').
                        Later, this flag can be used to select an index.
k=13                    Kmer length, range 8-15.  Longer is faster but uses 
                        more memory.  Shorter is more sensitive.
                        If indexing and mapping are done in two steps, K should
                        be specified each time.
path=<.>                Specify the location to write the index, if you don't 
                        want it in the current working directory.
usemodulo=f             Throw away ~80% of kmers based on remainder modulo a 
                        number (reduces RAM by 50% and sensitivity slightly).
                        Should be enabled both when building the index AND 
                        when mapping.
rebuild=f               Force a rebuild of the index (ref= should be set).

Input Parameters:
in=<file>               Primary reads input; required parameter.
in2=<file>              For paired reads in two files.
interleaved=auto        True forces paired/interleaved input; false forces 
                        single-ended mapping. If not specified, interleaved 
                        status will be autodetected from read names.
fastareadlen=500        Break up FASTA reads longer than this.  Max is 500 for
                        BBMap and 6000 for BBMapPacBio.  Only works for FASTA
                        input (use 'maxlen' for FASTQ input).  The default for
                        bbmap.sh is 500, and for mapPacBio.sh is 6000.
unpigz=f                Spawn a pigz (parallel gzip) process for faster 
                        decompression than using Java.  
                        Requires pigz to be installed.
touppercase=t           (tuc) Convert lowercase letters in reads to upper case 
                        (otherwise they will not match the reference).

Sampling Parameters:

reads=-1                Set to a positive number N to only process the first N
                        reads (or pairs), then quit.  -1 means use all reads.
samplerate=1            Set to a number from 0 to 1 to randomly select that
                        fraction of reads for mapping. 1 uses all reads.
skipreads=0             Set to a number N to skip the first N reads (or pairs), 
                        then map the rest.

Mapping Parameters:
fast=f                  This flag is a macro which sets other paramters to run 
                        faster, at reduced sensitivity.  Bad for RNA-seq.
slow=f                  This flag is a macro which sets other paramters to run 
                        slower, at greater sensitivity.  'vslow' is even slower.
maxindel=16000          Don't look for indels longer than this. Lower is faster.
                        Set to >=100k for RNAseq with long introns like mammals.
strictmaxindel=f        When enabled, do not allow indels longer than 'maxindel'.
                        By default these are not sought, but may be found anyway.
tipsearch=100           Look this far for read-end deletions with anchors
                        shorter than K, using brute force.
minid=0.76              Approximate minimum alignment identity to look for. 
                        Higher is faster and less sensitive.
minhits=1               Minimum number of seed hits required for candidate sites.
                        Higher is faster.
local=f                 Set to true to use local, rather than global, alignments.
                        This will soft-clip ugly ends of poor alignments.
perfectmode=f           Allow only perfect mappings when set to true (very fast).
semiperfectmode=f       Allow only perfect and semiperfect (perfect except for 
                        N's in the reference) mappings.
threads=auto            (t) Set to number of threads desired.  By default, uses 
                        all cores available.
ambiguous=best          (ambig) Set behavior on ambiguously-mapped reads (with 
                        multiple top-scoring mapping locations).
                            best    (use the first best site)
                            toss    (consider unmapped)
                            random  (select one top-scoring site randomly)
                            all     (retain all top-scoring sites)
samestrandpairs=f       (ssp) Specify whether paired reads should map to the
                        same strand or opposite strands.
requirecorrectstrand=t  (rcs) Forbid pairing of reads without correct strand 
                        orientation.  Set to false for long-mate-pair libraries.
killbadpairs=f          (kbp) If a read pair is mapped with an inappropriate
                        insert size or orientation, the read with the lower  
                        mapping quality is marked unmapped.
pairedonly=f            (po) Treat unpaired reads as unmapped.  Thus they will 
                        be sent to 'outu' but not 'outm'.
rcomp=f                 Reverse complement both reads prior to mapping (for LMP
                        outward-facing libraries).
rcompmate=f             Reverse complement read2 prior to mapping.
pairlen=32000           Set max allowed distance between paired reads.  
                        (insert size)=(pairlen)+(read1 length)+(read2 length)
rescuedist=1200         Don't try to rescue paired reads if avg. insert size
                        greater than this.  Lower is faster.
rescuemismatches=32     Maximum mismatches allowed in a rescued read.  Lower
                        is faster.
averagepairdist=100     (apd) Initial average distance between paired reads.
                        Varies dynamically; does not need to be specified.
deterministic=f         Run in deterministic mode.  In this case it is good
                        to set averagepairdist.  BBMap is deterministic
                        without this flag if using single-ended reads,
                        or run singlethreaded.
bandwidthratio=0        (bwr) If above zero, restrict alignment band to this 
                        fraction of read length.  Faster but less accurate.
bandwidth=0             (bw) Set the bandwidth directly.
                        fraction of read length.  Faster but less accurate.
usejni=f                (jni) Do alignments faster, in C code.  Requires 
                        compiling the C code; details are in /jni/README.txt.
maxsites2=800           Don't analyze (or print) more than this many alignments 
                        per read.
ignorefrequentkmers=t   (ifk) Discard low-information kmers that occur often.
excludefraction=0.03    (ef) Fraction of kmers to ignore.  For example, 0.03
                        will ignore the most common 3% of kmers.
greedy=t                Use a greedy algorithm to discard the least-useful
                        kmers on a per-read basis.
kfilter=0               If positive, potential mapping sites must have at
                        least this many consecutive exact matches.


Quality and Trimming Parameters:
qin=auto                Set to 33 or 64 to specify input quality value ASCII
                        offset. 33 is Sanger, 64 is old Solexa.
qout=auto               Set to 33 or 64 to specify output quality value ASCII 
                        offset (only if output format is fastq).
qtrim=f                 Quality-trim ends before mapping.  Options are: 
                        'f' (false), 'l' (left), 'r' (right), and 'lr' (both).
untrim=f                Undo trimming after mapping.  Untrimmed bases will be 
                        soft-clipped in cigar strings.
trimq=6                 Trim regions with average quality below this 
                        (phred algorithm).
mintrimlength=60        (mintl) Don't trim reads to be shorter than this.
fakefastaquality=-1     (ffq) Set to a positive number 1-50 to generate fake
                        quality strings for fasta input reads.
ignorebadquality=f      (ibq) Keep going, rather than crashing, if a read has 
                        out-of-range quality values.
usequality=t            Use quality scores when determining which read kmers
                        to use as seeds.
minaveragequality=0     (maq) Do not map reads with average quality below this.
maqb=0                  If positive, calculate maq from this many initial bases.

Output Parameters:
out=<file>              Write all reads to this file.
outu=<file>             Write only unmapped reads to this file.  Does not 
                        include unmapped paired reads with a mapped mate.
outm=<file>             Write only mapped reads to this file.  Includes 
                        unmapped paired reads with a mapped mate.
mappedonly=f            If true, treats 'out' like 'outm'.
bamscript=<file>        (bs) Write a shell script to <file> that will turn 
                        the sam output into a sorted, indexed bam file.
ordered=f               Set to true to output reads in same order as input.  
                        Slower and uses more memory.
overwrite=f             (ow) Allow process to overwrite existing files.
secondary=f             Print secondary alignments.
sssr=0.95               (secondarysitescoreratio) Print only secondary alignments
                        with score of at least this fraction of primary.
ssao=f                  (secondarysiteasambiguousonly) Only print secondary 
                        alignments for ambiguously-mapped reads.
maxsites=5              Maximum number of total alignments to print per read.
                        Only relevant when secondary=t.
quickmatch=f            Generate cigar strings more quickly.
trimreaddescriptions=f  (trd) Truncate read and ref names at the first whitespace,
                        assuming that the remainder is a comment or description.
ziplevel=2              (zl) Compression level for zip or gzip output.
pigz=f                  Spawn a pigz (parallel gzip) process for faster 
                        compression than Java.  Requires pigz to be installed.
machineout=f            Set to true to output statistics in machine-friendly 
                        'key=value' format.
printunmappedcount=f    Print the total number of unmapped reads and bases.
                        If input is paired, the number will be of pairs
                        for which both reads are unmapped.
showprogress=0          If positive, print a '.' every X reads.
showprogress2=0         If positive, print the number of seconds since the
                        last progress update (instead of a '.').
renamebyinsert=f        Renames reads based on their mapped insert size.

Bloom-Filtering Parameters (bloomfilter.sh is the standalone version).
bloom=f                 Use a Bloom filter to ignore reads not sharing kmers
                        with the reference.  This uses more memory, but speeds
                        mapping when most reads don't match the reference.
bloomhashes=2           Number of hash functions.
bloomminhits=3          Number of consecutive hits to be considered matched.
bloomk=31               Bloom filter kmer length.
bloomserial=t           Use the serialized Bloom filter for greater loading
                        speed, if available.  If not, generate and write one.

Post-Filtering Parameters:
idfilter=0              Independant of minid; sets exact minimum identity 
                        allowed for alignments to be printed.  Range 0 to 1.
subfilter=-1            Ban alignments with more than this many substitutions.
insfilter=-1            Ban alignments with more than this many insertions.
delfilter=-1            Ban alignments with more than this many deletions.
indelfilter=-1          Ban alignments with more than this many indels.
editfilter=-1           Ban alignments with more than this many edits.
inslenfilter=-1         Ban alignments with an insertion longer than this.
dellenfilter=-1         Ban alignments with a deletion longer than this.
nfilter=-1              Ban alignments with more than this many ns.  This 
                        includes nocall, noref, and off scaffold ends.

Sam flags and settings:
noheader=f              Disable generation of header lines.
sam=1.4                 Set to 1.4 to write Sam version 1.4 cigar strings, 
                        with = and X, or 1.3 to use M.
saa=t                   (secondaryalignmentasterisks) Use asterisks instead of
                        bases for sam secondary alignments.
cigar=t                 Set to 'f' to skip generation of cigar strings (faster).
keepnames=f             Keep original names of paired reads, rather than 
                        ensuring both reads have the same name.
intronlen=999999999     Set to a lower number like 10 to change 'D' to 'N' in 
                        cigar strings for deletions of at least that length.
rgid=                   Set readgroup ID.  All other readgroup fields 
                        can be set similarly, with the flag rgXX=
                        If you set a readgroup flag to the word 'filename',
                        e.g. rgid=filename, the input file name will be used.
mdtag=f                 Write MD tags.
nhtag=f                 Write NH tags.
xmtag=f                 Write XM tags (may only work correctly with ambig=all).
amtag=f                 Write AM tags.
nmtag=f                 Write NM tags.
xstag=f                 Set to 'xs=fs', 'xs=ss', or 'xs=us' to write XS tags 
                        for RNAseq using firststrand, secondstrand, or 
                        unstranded libraries.  Needed by Cufflinks.  
                        JGI mainly uses 'firststrand'.
stoptag=f               Write a tag indicating read stop location, prefixed by YS:i:
lengthtag=f             Write a tag indicating (query,ref) alignment lengths, 
                        prefixed by YL:Z:
idtag=f                 Write a tag indicating percent identity, prefixed by YI:f:
inserttag=f             Write a tag indicating insert size, prefixed by X8:Z:
scoretag=f              Write a tag indicating BBMap's raw score, prefixed by YR:i:
timetag=f               Write a tag indicating this read's mapping time, prefixed by X0:i:
boundstag=f             Write a tag indicating whether either read in the pair
                        goes off the end of the reference, prefixed by XB:Z:
notags=f                Turn off all optional tags.

Histogram and statistics output parameters:
scafstats=<file>        Statistics on how many reads mapped to which scaffold.
refstats=<file>         Statistics on how many reads mapped to which reference
                        file; only for BBSplit.
sortscafs=t             Sort scaffolds or references by read count.
bhist=<file>            Base composition histogram by position.
qhist=<file>            Quality histogram by position.
aqhist=<file>           Histogram of average read quality.
bqhist=<file>           Quality histogram designed for box plots.
lhist=<file>            Read length histogram.
ihist=<file>            Write histogram of insert sizes (for paired reads).
ehist=<file>            Errors-per-read histogram.
qahist=<file>           Quality accuracy histogram of error rates versus 
                        quality score.
indelhist=<file>        Indel length histogram.
mhist=<file>            Histogram of match, sub, del, and ins rates by 
                        read location.
gchist=<file>           Read GC content histogram.
gcbins=100              Number gchist bins.  Set to 'auto' to use read length.
gcpairs=t               Use average GC of paired reads.
idhist=<file>           Histogram of read count versus percent identity.
idbins=100              Number idhist bins.  Set to 'auto' to use read length.
statsfile=stderr        Mapping statistics are printed here.

Coverage output parameters (these may reduce speed and use more RAM):
covstats=<file>         Per-scaffold coverage info.
rpkm=<file>             Per-scaffold RPKM/FPKM counts.
covhist=<file>          Histogram of # occurrences of each depth level.
basecov=<file>          Coverage per base location.
bincov=<file>           Print binned coverage per location (one line per X bases).
covbinsize=1000         Set the binsize for binned coverage output.
nzo=t                   Only print scaffolds with nonzero coverage.
twocolumn=f             Change to true to print only ID and Avg_fold instead of 
                        all 6 columns to the 'out=' file.
32bit=f                 Set to true if you need per-base coverage over 64k.
strandedcov=f           Track coverage for plus and minus strand independently.
startcov=f              Only track start positions of reads.
secondarycov=t          Include coverage of secondary alignments.
physcov=f               Calculate physical coverage for paired reads.
                        This includes the unsequenced bases.
delcoverage=t           (delcov) Count bases covered by deletions as covered.
                        True is faster than false.
covk=0                  If positive, calculate kmer coverage statistics.

Java Parameters:
-Xmx                    This will set Java's memory usage, 
                        overriding autodetection.
                        -Xmx20g will specify 20 gigs of RAM, and -Xmx800m 
                        will specify 800 megs.  The max is typically 85% of 
                        physical memory.  The human genome requires around 24g,
                        or 12g with the 'usemodulo' flag.  The index uses 
                        roughly 6 bytes per reference base.
-eoom                   This flag will cause the process to exit if an 
                        out-of-memory exception occurs.  Requires Java 8u92+.
-da                     Disable assertions.

Please contact Brian Bushnell at bbushnell@lbl.gov if you encounter 
any problems, or post at: http://seqanswers.com/forums/showthread.php?t=41057
For documentation and the latest version, visit: https://bbmap.org
```
## bbmap_bbduk.sh

### Tool Description
Compares reads to the kmers in a reference dataset, optionally allowing an edit distance. Splits the reads into two outputs - those that match the reference, and those that don't. Can also trim (remove) the matching parts of the reads rather than binning the reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
- **Homepage**: https://sourceforge.net/projects/bbmap
- **Package**: https://anaconda.org/channels/bioconda/packages/bbmap/overview
- **Validation**: PASS

### Original Help Text
```text
Written by Brian Bushnell
Last modified October 29, 2025

Description:  Compares reads to the kmers in a reference dataset, optionally 
allowing an edit distance. Splits the reads into two outputs - those that 
match the reference, and those that don't. Can also trim (remove) the matching 
parts of the reads rather than binning the reads.
Please read bbmap/docs/guides/BBDukGuide.txt for more information.

Usage:  bbduk.sh in=<input file> out=<output file> ref=<contaminant files>

Input may be stdin or a fasta or fastq file, compressed or uncompressed.
If you pipe via stdin/stdout, please include the file type; e.g. for gzipped 
fasta input, set in=stdin.fa.gz

Input parameters:
in=<file>           Main input. in=stdin.fq will pipe from stdin.
in2=<file>          Input for 2nd read of pairs in a different file.
ref=<file,file>     Comma-delimited list of reference files.
                    In addition to filenames, you may also use the keywords:
                    adapters, artifacts, phix, lambda, pjet, mtst, kapa
literal=<seq,seq>   Comma-delimited list of literal reference sequences.
                    Polymers are also allowed with the 'poly' prefix;
                    for example, 'literal=ATGGT,polyGC' will add both ATGGT
                    and GCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGC - 32+ of them,
                    enough replicates to ensure that all kmers are present.
touppercase=f       (tuc) Change all bases upper-case.
interleaved=auto    (int) t/f overrides interleaved autodetection.
                    Must be set mainually when streaming fastq input.
qin=auto            Input quality offset: 33 (Sanger), 64, or auto.
reads=-1            If positive, quit after processing X reads or pairs.
copyundefined=f     (cu) Process non-AGCT IUPAC reference bases by making all
                    possible unambiguous copies.  Intended for short motifs
                    or adapter barcodes, as time/memory use is exponential.
samplerate=1        Set lower to only process a fraction of input reads.
samref=<file>       Optional reference fasta for processing sam files.

Output parameters:
out=<file>          (outnonmatch) Write reads here that do not contain 
                    kmers matching the database.  'out=stdout.fq' will pipe 
                    to standard out.
out2=<file>         (outnonmatch2) Use this to write 2nd read of pairs to a 
                    different file.
outm=<file>         (outmatch) Write reads here that fail filters.  In default
                    kfilter mode, this means any read with a matching kmer.
                    In any mode, it also includes reads that fail filters such
                    as minlength, mingc, maxgc, entropy, etc.  In other words,
                    it includes all reads that do not go to 'out'.
outm2=<file>        (outmatch2) Use this to write 2nd read of pairs to a 
                    different file.
outs=<file>         (outsingle) Use this to write singleton reads whose mate 
                    was trimmed shorter than minlen.
stats=<file>        Write statistics about which contamininants were detected.
refstats=<file>     Write statistics on a per-reference-file basis.
rpkm=<file>         Write RPKM for each reference sequence (for RNA-seq).
dump=<file>         Dump kmer tables to a file, in fasta format.
duk=<file>          Write statistics in duk's format. *DEPRECATED*
nzo=t               Only write statistics about ref sequences with nonzero hits.
overwrite=t         (ow) Grant permission to overwrite files.
showspeed=t         (ss) 'f' suppresses display of processing speed.
ziplevel=2          (zl) Compression level; 1 (min) through 9 (max).
fastawrap=70        Length of lines in fasta output.
qout=auto           Output quality offset: 33 (Sanger), 64, or auto.
statscolumns=3      (cols) Number of columns for stats output, 3 or 5.
                    5 includes base counts.
rename=f            Rename reads to indicate which sequences they matched.
refnames=f          Use names of reference files rather than scaffold IDs.
trd=f               Truncate read and ref names at the first whitespace.
ordered=f           Set to true to output reads in same order as input.
maxbasesout=-1      If positive, quit after writing approximately this many
                    bases to out (outu/outnonmatch).
maxbasesoutm=-1     If positive, quit after writing approximately this many
                    bases to outm (outmatch).
json=f              Print to screen in json format.

Histogram output parameters:
bhist=<file>        Base composition histogram by position.
qhist=<file>        Quality histogram by position.
qchist=<file>       Count of bases with each quality value.
aqhist=<file>       Histogram of average read quality.
bqhist=<file>       Quality histogram designed for box plots.
lhist=<file>        Read length histogram.
phist=<file>        Polymer length histogram.
gchist=<file>       Read GC content histogram.
enthist=<file>      Read entropy histogram.
ihist=<file>        Insert size histogram, for paired reads in mapped sam.
gcbins=100          Number gchist bins.  Set to 'auto' to use read length.
maxhistlen=6000     Set an upper bound for histogram lengths; higher uses 
                    more memory.  The default is 6000 for some histograms
                    and 80000 for others.

Histogram parameters for mapped sam/bam files only:
histbefore=t        Calculate histograms from reads before processing.
ehist=<file>        Errors-per-read histogram.
qahist=<file>       Quality accuracy histogram of error rates versus quality 
                    score.
indelhist=<file>    Indel length histogram.
mhist=<file>        Histogram of match, sub, del, and ins rates by position.
idhist=<file>       Histogram of read count versus percent identity.
idbins=100          Number idhist bins.  Set to 'auto' to use read length.
varfile=<file>      Ignore substitution errors listed in this file when 
                    calculating error rates.  Can be generated with
                    CallVariants.
vcf=<file>          Ignore substitution errors listed in this VCF file 
                    when calculating error rates.
ignorevcfindels=t   Also ignore indels listed in the VCF.

Processing parameters:
k=31                Kmer length used for finding contaminants.  Contaminants 
                    shorter than k will not be found.  k must be at least 1.
rcomp=t             Look for reverse-complements of kmers in addition to 
                    forward kmers.
maskmiddle=t        (mm) Treat the middle base of a kmer as a wildcard, to 
                    increase sensitivity in the presence of errors.  This may
                    also be set to a number, e.g. mm=3, to mask that many bp.
                    The default mm=t corresponds to mm=1 for odd-length kmers
                    and mm=2 for even-length kmers (as of v39.04), while
                    mm=f is always equivalent to mm=0.
minkmerhits=1       (mkh) Reads need at least this many matching kmers 
                    to be considered as matching the reference.
minkmerfraction=0.0 (mkf) A reads needs at least this fraction of its total
                    kmers to hit a ref, in order to be considered a match.
                    If this and minkmerhits are set, the greater is used.
mincovfraction=0.0  (mcf) A reads needs at least this fraction of its total
                    bases to be covered by ref kmers to be considered a match.
                    If specified, mcf overrides mkh and mkf.
hammingdistance=0   (hdist) Maximum Hamming distance for ref kmers (subs only).
                    Memory use is proportional to (3*K)^hdist.
qhdist=0            Hamming distance for query kmers; impacts speed, not memory.
editdistance=0      (edist) Maximum edit distance from ref kmers (subs 
                    and indels).  Memory use is proportional to (8*K)^edist.
hammingdistance2=0  (hdist2) Sets hdist for short kmers, when using mink.
qhdist2=0           Sets qhdist for short kmers, when using mink.
editdistance2=0     (edist2) Sets edist for short kmers, when using mink.
forbidn=f           (fn) Forbids matching of read kmers containing N.
                    By default, these will match a reference 'A' if 
                    hdist>0 or edist>0, to increase sensitivity.
removeifeitherbad=t (rieb) Paired reads get sent to 'outmatch' if either is 
                    match (or either is trimmed shorter than minlen).  
                    Set to false to require both.
trimfailures=f      Instead of discarding failed reads, trim them to 1bp.
                    This makes the statistics a bit odd.
findbestmatch=f     (fbm) If multiple matches, associate read with sequence 
                    sharing most kmers.  Reduces speed.
skipr1=f            Don't do kmer-based operations on read 1.
skipr2=f            Don't do kmer-based operations on read 2.
ecco=f              For overlapping paired reads only.  Performs error-
                    correction with BBMerge prior to kmer operations.
recalibrate=f       (recal) Recalibrate quality scores.  Requires calibration
                    matrices generated by CalcTrueQuality.
sam=<file,file>     If recalibration is desired, and matrices have not already
                    been generated, BBDuk will create them from the sam file.
amino=f             Run in amino acid mode.  Some features have not been
                    tested, but kmer-matching works fine.  Maximum k is 12.

Speed and Memory parameters:
threads=auto        (t) Set number of threads to use; default is number of 
                    logical processors.
prealloc=f          Preallocate memory in table.  Allows faster table loading 
                    and more efficient memory usage, for a large reference.
monitor=f           Kill this process if it crashes.  monitor=600,0.01 would 
                    kill after 600 seconds under 1% usage.
minrskip=1          (mns) Force minimal skip interval when indexing reference 
                    kmers.  1 means use all, 2 means use every other kmer, etc.
maxrskip=1          (mxs) Restrict maximal skip interval when indexing 
                    reference kmers. Normally all are used for scaffolds<100kb, 
                    but with longer scaffolds, up to maxrskip-1 are skipped.
rskip=              Set both minrskip and maxrskip to the same value.
                    If not set, rskip will vary based on sequence length.
qskip=1             Skip query kmers to increase speed.  1 means use all.
speed=0             Ignore this fraction of kmer space (0-15 out of 16) in both
                    reads and reference.  Increases speed and reduces memory.
Note: Do not use more than one of 'speed', 'qskip', and 'rskip'.

Trimming/Filtering/Masking parameters:
Note - if ktrim, kmask, and ksplit are unset, the default behavior is kfilter.
All kmer processing modes are mutually exclusive.
Reads only get sent to 'outm' purely based on kmer matches in kfilter mode.

ktrim=f             Trim reads to remove bases matching reference kmers, plus
                    all bases to the left or right.
                    Values:
                       f (don't trim), 
                       r (trim to the right), 
                       l (trim to the left)
ktrimtips=0         Set this to a positive number to perform ktrim on both
                    ends, examining only the outermost X bases.
kmask=              Replace bases matching ref kmers with another symbol.
                    Allows any non-whitespace character, and processes short
                    kmers on both ends if mink is set.  'kmask=lc' will
                    convert masked bases to lowercase.
maskfullycovered=f  (mfc) Only mask bases that are fully covered by kmers.
ksplit=f            For single-ended reads only.  Reads will be split into
                    pairs around the kmer.  If the kmer is at the end of the
                    read, it will be trimmed instead.  Singletons will go to
                    out, and pairs will go to outm.  Do not use ksplit with
                    other operations such as quality-trimming or filtering.
mink=0              Look for shorter kmers at read tips down to this length, 
                    when k-trimming or masking.  0 means disabled.  Enabling
                    this will disable maskmiddle.
qtrim=f             Trim read ends to remove bases with quality below trimq.
                    Performed AFTER looking for kmers.  Values: 
                       rl (trim both ends), 
                       f (neither end), 
                       r (right end only), 
                       l (left end only),
                       w (sliding window).
trimq=6             Regions with average quality BELOW this will be trimmed,
                    if qtrim is set to something other than f.  Can be a 
                    floating-point number like 7.3.
quantize            Bin quality scores to reduce file size.  quantize=2 will
                    eliminate all odd quality scores, while quantize=0,10,37
                    will only allow qualty scores of 0, 10, or 37.
trimclip=f          Trim soft-clipped bases from sam files.
minlength=10        (ml) Reads shorter than this after trimming will be 
                    discarded.  Pairs will be discarded if both are shorter.
mlf=0               (minlengthfraction) Reads shorter than this fraction of 
                    original length after trimming will be discarded.
maxlength=          Reads longer than this after trimming will be discarded.
minavgquality=0     (maq) Reads with average quality (after trimming) below 
                    this will be discarded.
maqb=0              If positive, calculate maq from this many initial bases.
minbasequality=0    (mbq) Reads with any base below this quality (after 
                    trimming) will be discarded.
maxns=-1            If non-negative, reads with more Ns than this 
                    (after trimming) will be discarded.
mcb=0               (minconsecutivebases) Discard reads without at least 
                    this many consecutive called bases.
ottm=f              (outputtrimmedtomatch) Output reads trimmed to shorter 
                    than minlength to outm rather than discarding.
tp=0                (trimpad) Trim this much extra around matching kmers.
tbo=f               (trimbyoverlap) Trim adapters based on where paired 
                    reads overlap.
strictoverlap=t     Adjust sensitivity for trimbyoverlap mode.
minoverlap=14       Require this many bases of overlap for detection.
mininsert=40        Require insert size of at least this for overlap.
                    Should be reduced to 16 for small RNA sequencing.
tpe=f               (trimpairsevenly) When kmer right-trimming, trim both 
                    reads to the minimum length of either.
forcetrimleft=0     (ftl) If positive, trim bases to the left of this position
                    (exclusive, 0-based).
forcetrimright=0    (ftr) If positive, trim bases to the right of this position
                    (exclusive, 0-based).
forcetrimright2=0   (ftr2) If positive, trim this many bases on the right end.
forcetrimmod=0      (ftm) If positive, right-trim length to be equal to zero,
                    modulo this number.
restrictleft=0      If positive, only look for kmer matches in the 
                    leftmost X bases.
restrictright=0     If positive, only look for kmer matches in the 
                    rightmost X bases.
NOTE:  restrictleft and restrictright are mutually exclusive.  If trimming
       both ends is desired, use ktrimtips.
mingc=0             Discard reads with GC content below this.
maxgc=1             Discard reads with GC content above this.
gcpairs=t           Use average GC of paired reads.
                    Also affects gchist.
tossjunk=f          Discard reads with invalid characters as bases.
swift=f             Trim Swift sequences: Trailing C/T/N R1, leading G/A/N R2.

Header-parsing parameters - these require Illumina headers:
chastityfilter=f    (cf) Discard reads with id containing ' 1:Y:' or ' 2:Y:'.
barcodefilter=f     Remove reads with unexpected barcodes if barcodes is set,
                    or barcodes containing 'N' otherwise.  A barcode must be
                    the last part of the read header.  Values:
                       t:     Remove reads with bad barcodes.
                       f:     Ignore barcodes.
                       crash: Crash upon encountering bad barcodes.
barcodes=           Comma-delimited list of barcodes or files of barcodes.
xmin=-1             If positive, discard reads with a lesser X coordinate.
ymin=-1             If positive, discard reads with a lesser Y coordinate.
xmax=-1             If positive, discard reads with a greater X coordinate.
ymax=-1             If positive, discard reads with a greater Y coordinate.

Polymer trimming parameters:
trimpolya=0         If greater than 0, trim poly-A or poly-T tails of
                    at least this length on either end of reads.
trimpolygleft=0     If greater than 0, trim poly-G prefixes of at least this
                    length on the left end of reads.  Does not trim poly-C.
trimpolygright=0    If greater than 0, trim poly-G tails of at least this 
                    length on the right end of reads.  Does not trim poly-C.
trimpolyg=0         This sets both left and right at once.
filterpolyg=0       If greater than 0, remove reads with a poly-G prefix of
                    at least this length (on the left).
Note: there are also equivalent poly-C flags.

Polymer tracking parameters:
pratio=base,base    'pratio=G,C' will print the ratio of G to C polymers.
plen=20             Length of homopolymers to count.

Entropy/Complexity parameters:
entropy=-1          Set between 0 and 1 to filter reads with entropy below
                    that value.  Higher is more stringent.
entropywindow=50    Calculate entropy using a sliding window of this length.
entropyk=5          Calculate entropy using kmers of this length.
minbasefrequency=0  Discard reads with a minimum base frequency below this.
entropytrim=f       Values:
                       f:  (false) Do not entropy-trim.
                       r:  (right) Trim low entropy on the right end only.
                       l:  (left) Trim low entropy on the left end only.
                       rl: (both) Trim low entropy on both ends.
entropymask=f       Values:
                       f:  (filter) Discard low-entropy sequences.
                       t:  (true) Mask low-entropy parts of sequences with N.
                       lc: Change low-entropy parts of sequences to lowercase.
entropymark=f       Mark each base with its entropy value.  This is on a scale
                    of 0-41 and is reported as quality scores, so the output
                    should be fastq or fasta+qual.
NOTE: If set, entropytrim overrides entropymask.

Cardinality estimation parameters:
cardinality=f       (loglog) Count unique kmers using the LogLog algorithm.
cardinalityout=f    (loglogout) Count unique kmers in output reads.
loglogk=31          Use this kmer length for counting.
loglogbuckets=2048  Use this many buckets for counting.
khist=<file>        Kmer frequency histogram; plots number of kmers versus
                    kmer depth.  This is approximate.
khistout=<file>     Kmer frequency histogram for output reads.

Side Channel Parameters:
sideout=<file>      Output for aligned reads.
sideref=phix        Reference for side-channel alignment; must be a single
                    sequence and virtually repeat-free at selected k.
sidek1=17           Kmer length for seeding alignment to reference.
sidek2=13           Kmer length for seeding alignment of unaligned reads
                    with an aligned mate.
sideminid1=0.66     Minimum identity to accept individual alignments.
sideminid2=0.58     Minimum identity for aligning reads with aligned mates.
sidemm1=1           Middle mask length for sidek1.
sidemm2=1           Middle mask length for sidek2.
Note:  The side channel is a special additional output that allows alignment
to a secondary reference while also doing trimming.  Alignment does not affect
whether reads go to the normal outputs (out, outm).  The main purpose is to
simplify pipelines that need trimmed, aligned phiX reads for recalibration.


Java Parameters:

-Xmx                This will set Java's memory usage, overriding autodetection.
                    -Xmx20g will 
                    specify 20 gigs of RAM, and -Xmx200m will specify 200 megs.  
                    The max is typically 85% of physical memory.
-eoom               This flag will cause the process to exit if an 
                    out-of-memory exception occurs.  Requires Java 8u92+.
-da                 Disable assertions.

Please contact Brian Bushnell at bbushnell@lbl.gov if you encounter any problems.
For documentation and the latest version, visit: https://bbmap.org
```


## bbmap_bbmerge.sh

### Tool Description
Merges paired reads into single reads by overlap detection. With sufficient coverage, can merge nonoverlapping reads by kmer extension.

### Metadata
- **Docker Image**: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
- **Homepage**: https://sourceforge.net/projects/bbmap
- **Package**: https://anaconda.org/channels/bioconda/packages/bbmap/overview
- **Validation**: PASS

### Original Help Text
```text
Written by Brian Bushnell and Jonathan Rood
Last modified October 8, 2024

Description:  Merges paired reads into single reads by overlap detection.
With sufficient coverage, can merge nonoverlapping reads by kmer extension.
Kmer modes (Tadpole or Bloom Filter) require much more memory, and should
be used with the bbmerge-auto.sh script rather than bbmerge.sh.
Please read bbmap/docs/guides/BBMergeGuide.txt for more information.

Usage (interleaved):	bbmerge.sh in=<reads> out=<merged reads> outu=<unmerged reads>
Usage (twin files):     bbmerge.sh in1=<read1> in2=<read2> out=<merged reads> outu1=<unmerged1> outu2=<unmerged2>

Input may be stdin or a file, fasta or fastq, raw or gzipped.

Input parameters:
in=null              Primary input. 'in2' will specify a second file.
interleaved=auto     May be set to true or false to override autodetection of
                     whether the input file as interleaved.
reads=-1             Quit after this many read pairs (-1 means all).

Output parameters:
out=<file>           File for merged reads. 'out2' will specify a second file.
outu=<file>          File for unmerged reads. 'outu2' will specify a second file.
outinsert=<file>     (outi) File to write read names and insert sizes.
outadapter=<file>    (outa) File to write consensus adapter sequences.
outc=<file>          File to write input read kmer cardinality estimate.
ihist=<file>         (hist) Insert length histogram output file.
nzo=t                Only print histogram bins with nonzero values.
showhiststats=t      Print extra header lines with statistical information.
ziplevel=2           Set to 1 (lowest) through 9 (max) to change compression
                     level; lower compression is faster.
ordered=f            Output reads in same order as input.
mix=f                Output both the merged (or mergable) and unmerged reads
                     in the same file (out=).  Useful for ecco mode.

Trimming/Filtering parameters:
qtrim=f              Trim read ends to remove bases with quality below minq.
                     Trims BEFORE merging.
                     Values: t (trim both ends), 
                             f (neither end), 
                             r (right end only), 
                             l (left end only).
qtrim2=f             May be specified instead of qtrim to perform trimming 
                     only if merging is unsuccessful, then retry merging.
trimq=10             Trim quality threshold.  This may be a comma-delimited
                     list (ascending) to try multiple values.
minlength=1          (ml) Reads shorter than this after trimming, but before
                     merging, will be discarded. Pairs will be discarded only
                     if both are shorter.
maxlength=-1         Reads with longer insert sizes will be discarded.
tbo=f                (trimbyoverlap) Trim overlapping reads to remove 
                     rightmost (3') non-overlapping portion, instead of joining.
minavgquality=0      (maq) Reads with average quality below this, after 
                     trimming, will not be attempted to be merged.
maxexpectederrors=0  (mee) If positive, reads with more combined expected 
                     errors than this will not be attempted to be merged.
forcetrimleft=0      (ftl) If nonzero, trim left bases of the read to 
                     this position (exclusive, 0-based).
forcetrimright=0     (ftr) If nonzero, trim right bases of the read 
                     after this position (exclusive, 0-based).
forcetrimright2=0    (ftr2) If positive, trim this many bases on the right end.
forcetrimmod=5       (ftm) If positive, trim length to be equal to 
                     zero modulo this number.
ooi=f                Output only incorrectly merged reads, for testing.
trimpolya=t          Trim trailing poly-A tail from adapter output.  Only 
                     affects outadapter.  This also trims poly-A followed
                     by poly-G, which occurs on NextSeq.

Processing Parameters:
usejni=f             (jni) Do overlapping in C code, which is faster.  Requires
                     compiling the C code; details are in /jni/README.txt.
                     However, the jni path is currently disabled.
merge=t              Create merged reads.  If set to false, you can still 
                     generate an insert histogram.
ecco=f               Error-correct the overlapping part, but don't merge.
trimnonoverlapping=f (tno) Trim all non-overlapping portions, leaving only
                     consensus sequence.  By default, only sequence to the 
                     right of the overlap (adapter sequence) is trimmed.
useoverlap=t         Attempt find the insert size using read overlap.
mininsert=15         Minimum insert size to merge reads.
mininsert0=12        Insert sizes less than this will not be considered.
                     Must be less than or equal to mininsert.
minoverlap=12        Minimum number of overlapping bases to allow merging.
minoverlap0=8        Overlaps shorter than this will not be considered.
                     Must be less than or equal to minoverlap.
minq=9               Ignore bases with quality below this.
maxq=41              Cap output quality scores at this.
quantize=1           Set to a higher number to eliminate some quality scores
                     for a lower output filesize.
entropy=t            Increase the minimum overlap requirement for low-
                     complexity reads.
efilter=6            Ban overlaps with over this many times the expected 
                     number of errors.  Lower is more strict. -1 disables.
pfilter=0.00004      Ban improbable overlaps.  Higher is more strict. 0 will
                     disable the filter; 1 will allow only perfect overlaps.
kfilter=0            Ban overlaps that create kmers with count below
                     this value (0 disables).  If this is used minprob should
                     probably be set to 0.  Requires good coverage.
ouq=f                Calculate best overlap using quality values.
owq=t                Calculate best overlap without using quality values.
usequality=t         If disabled, quality values are completely ignored,
                     both for overlap detection and filtering.  May be useful
                     for data with inaccurate quality values.
iupacton=f           (itn) Change ambiguous IUPAC symbols to N.
adapter=             Specify the adapter sequences used for these reads, if
                     known; this can be a fasta file or a literal sequence.
                     Read 1 and 2 can have adapters specified independently
                     with the adapter1 and adapter2 flags.  adapter=default
                     will use a list of common adapter sequences.

Neural Network Mode Parameters:
nn=t                 Use a neural network for increased merging accuracy.
                     This is highly recommended, but will conflict with
                     strictness and ratiomode flags.  Stringency in nn mode
                     should be adjusted via the cutoff flag instead.
cutoff=0.872857      Merge reads with nn score above this value. Lower will
                     increase the merge rate at the cost of false positives.
net=<file>           Optional network to specify (for developer use); the
                     default is bbmap/resources/bbmerge.bbnet.

Ratio Mode Parameters: 
ratiomode=t          Score overlaps based on the ratio of matching to 
                     mismatching bases.
maxratio=0.09        Max error rate; higher increases merge rate.
ratiomargin=5.5      Lower increases merge rate; min is 1.
ratiooffset=0.55     Lower increases merge rate; min is 0.
maxmismatches=20     Maximum mismatches allowed in overlapping region.
ratiominoverlapreduction=3  This is the difference between minoverlap in 
                     flat mode and minoverlap in ratio mode; generally, 
                     minoverlap should be lower in ratio mode.
minsecondratio=0.1   Cutoff for second-best overlap ratio.
forcemerge=f         Disable all filters and just merge everything 
                     (not recommended).

Strictness (these are mutually exclusive macros that set other parameters):
strict=f             Decrease false positive rate and merging rate.
verystrict=f         (vstrict) Greatly decrease FP and merging rate.
ultrastrict=f        (ustrict) Decrease FP and merging rate even more.
maxstrict=f          (xstrict) Maximally decrease FP and merging rate.
loose=f              Increase false positive rate and merging rate.
veryloose=f          (vloose) Greatly increase FP and merging rate.
ultraloose=f         (uloose) Increase FP and merging rate even more.
maxloose=f           (xloose) Maximally decrease FP and merging rate.
fast=f               Fastest possible mode; less accurate.

Tadpole Parameters (for read extension and error-correction):
*Note: These require more memory and should be run with bbmerge-auto.sh.*
k=31                 Kmer length.  31 (or less) is fastest and uses the least
                     memory, but higher values may be more accurate.  
                     60 tends to work well for 150bp reads.
extend=0             Extend reads to the right this much before merging.
                     Requires sufficient (>5x) kmer coverage.
extend2=0            Extend reads this much only after a failed merge attempt,
                     or in rem/rsem mode.
iterations=1         (ei) Iteratively attempt to extend by extend2 distance
                     and merge up to this many times.
rem=f                (requireextensionmatch) Do not merge if the predicted
                     insert size differs before and after extension.
                     However, if only the extended reads overlap, then that
                     insert will be used.  Requires setting extend2.
rsem=f               (requirestrictextensionmatch) Similar to rem but stricter.
                     Reads will only merge if the predicted insert size before
                     and after extension match.  Requires setting extend2.
                     Enables the lowest possible false-positive rate.
ecctadpole=f         (ecct) If reads fail to merge, error-correct with Tadpole
                     and try again.  This happens prior to extend2.
reassemble=t         If ecct is enabled, use Tadpole's reassemble mode for 
                     error correction.  Alternatives are pincer and tail.
removedeadends       (shave) Remove kmers leading to dead ends.
removebubbles        (rinse) Remove kmers in error bubbles.
mindepthseed=3       (mds) Minimum kmer depth to begin extension.
mindepthextend=2     (mde) Minimum kmer depth continue extension.
branchmult1=20       Min ratio of 1st to 2nd-greatest path depth at high depth.
branchmult2=3        Min ratio of 1st to 2nd-greatest path depth at low depth.
branchlower=3        Max value of 2nd-greatest path depth to be considered low.
ibb=t                Ignore backward branches when extending.
extra=<file>         A file or comma-delimited list of files of reads to use
                     for kmer counting, but not for merging or output.
prealloc=f           Pre-allocate memory rather than dynamically growing; 
                     faster and more memory-efficient for large datasets.  
                     A float fraction (0-1) may be specified, default 1.
prefilter=0          If set to a positive integer, use a countmin sketch to 
                     ignore kmers with depth of that value or lower, to
                     reduce memory usage.
filtermem=0          Allows manually specifying prefilter memory in bytes, for
                     deterministic runs.  0 will set it automatically.
minprob=0.5          Ignore kmers with overall probability of correctness 
                     below this, to reduce memory usage.
minapproxoverlap=26  For rem mode, do not merge reads if the extended reads
                     indicate that the raw reads should have overlapped by
                     at least this much, but no overlap was found.


Bloom Filter Parameters (for kmer operations with less memory than Tadpole)
*Note: These require more memory and should be run with bbmerge-auto.sh.*
eccbloom=f           (eccb) If reads fail to merge, error-correct with bbcms
                     and try again.
testmerge=f          Test kmer counts around the read merge junctions.  If
                     it appears that the merge created new errors, undo it.
                     This reduces the false-positive rate, but not as much as
                     rem or rsem.

Java Parameters:
-Xmx                 This will set Java's memory usage, 
                     overriding autodetection.
                     For example, -Xmx400m will specify 400 MB RAM.
-eoom                This flag will cause the process to exit if an 
                     out-of-memory exception occurs.  Requires Java 8u92+.
-da                  Disable assertions.

Please contact Brian Bushnell at bbushnell@lbl.gov if you encounter any problems.
For documentation and the latest version, visit: https://bbmap.org
```


## bbmap_bbmerge-auto.sh

### Tool Description
BBMerge merges paired-end reads into single reads by identifying overlap. (Note: The provided help text resulted in a runtime error and did not list specific arguments).

### Metadata
- **Docker Image**: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
- **Homepage**: https://sourceforge.net/projects/bbmap
- **Package**: https://anaconda.org/channels/bioconda/packages/bbmap/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
java -ea  --add-modules jdk.incubator.vector -Xmx26469m -Xms26469m -cp /usr/local/opt/bbmap-39.52-0/current/ jgi.BBMerge --h
WARNING: Using incubator modules: jdk.incubator.vector
Executing jgi.BBMerge [h]
Version 39.52

Exception in thread "main" java.lang.RuntimeException: Unknown parameter h
	at jgi.BBMerge.<init>(BBMerge.java:716)
	at jgi.BBMerge.main(BBMerge.java:62)
```


## bbmap_bbnorm.sh

### Tool Description
Normalizes read depth based on kmer counts. Can also error-correct, bin reads by kmer depth, and generate a kmer depth histogram.

### Metadata
- **Docker Image**: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
- **Homepage**: https://sourceforge.net/projects/bbmap
- **Package**: https://anaconda.org/channels/bioconda/packages/bbmap/overview
- **Validation**: PASS

### Original Help Text
```text
Written by Brian Bushnell
Last modified October 19, 2017

Description:  Normalizes read depth based on kmer counts.
Can also error-correct, bin reads by kmer depth, and generate a kmer depth histogram.
However, Tadpole has superior error-correction to BBNorm.
Please read bbmap/docs/guides/BBNormGuide.txt for more information.

Usage:     bbnorm.sh in=<input> out=<reads to keep> outt=<reads to toss> hist=<histogram output>

Input parameters:
in=null             Primary input.  Use in2 for paired reads in a second file
in2=null            Second input file for paired reads in two files
extra=null          Additional files to use for input (generating hash table) but not for output
fastareadlen=2^31   Break up FASTA reads longer than this.  Can be useful when processing scaffolded genomes
tablereads=-1       Use at most this many reads when building the hashtable (-1 means all)
kmersample=1        Process every nth kmer, and skip the rest
readsample=1        Process every nth read, and skip the rest
interleaved=auto    May be set to true or false to force the input read file to ovverride autodetection of the input file as paired interleaved.
qin=auto            ASCII offset for input quality.  May be 33 (Sanger), 64 (Illumina), or auto.

Output parameters:
out=<file>          File for normalized or corrected reads.  Use out2 for paired reads in a second file
outt=<file>         (outtoss) File for reads that were excluded from primary output
reads=-1            Only process this number of reads, then quit (-1 means all)
sampleoutput=t      Use sampling on output as well as input (not used if sample rates are 1)
keepall=f           Set to true to keep all reads (e.g. if you just want error correction).
zerobin=f           Set to true if you want kmers with a count of 0 to go in the 0 bin instead of the 1 bin in histograms.
                    Default is false, to prevent confusion about how there can be 0-count kmers.
                    The reason is that based on the 'minq' and 'minprob' settings, some kmers may be excluded from the bloom filter.
tmpdir=      This will specify a directory for temp files (only needed for multipass runs).  If null, they will be written to the output directory.
usetempdir=t        Allows enabling/disabling of temporary directory; if disabled, temp files will be written to the output directory.
qout=auto           ASCII offset for output quality.  May be 33 (Sanger), 64 (Illumina), or auto (same as input).
rename=f            Rename reads based on their kmer depth.

Hashing parameters:
k=31                Kmer length (values under 32 are most efficient, but arbitrarily high values are supported)
bits=32             Bits per cell in bloom filter; must be 2, 4, 8, 16, or 32.  Maximum kmer depth recorded is 2^cbits.  Automatically reduced to 16 in 2-pass.
                    Large values decrease accuracy for a fixed amount of memory, so use the lowest number you can that will still capture highest-depth kmers.
hashes=3            Number of times each kmer is hashed and stored.  Higher is slower.
                    Higher is MORE accurate if there is enough memory, and LESS accurate if there is not enough memory.
prefilter=f         True is slower, but generally more accurate; filters out low-depth kmers from the main hashtable.  The prefilter is more memory-efficient because it uses 2-bit cells.
prehashes=2         Number of hashes for prefilter.
prefilterbits=2     (pbits) Bits per cell in prefilter.
prefiltersize=0.35  Fraction of memory to allocate to prefilter.
buildpasses=1       More passes can sometimes increase accuracy by iteratively removing low-depth kmers
minq=6              Ignore kmers containing bases with quality below this
minprob=0.5         Ignore kmers with overall probability of correctness below this
threads=auto        (t) Spawn exactly X hashing threads (default is number of logical processors).  Total active threads may exceed X due to I/O threads.
rdk=t               (removeduplicatekmers) When true, a kmer's count will only be incremented once per read pair, even if that kmer occurs more than once.

Normalization parameters:
fixspikes=f         (fs) Do a slower, high-precision bloom filter lookup of kmers that appear to have an abnormally high depth due to collisions.
target=100          (tgt) Target normalization depth.  NOTE:  All depth parameters control kmer depth, not read depth.
                    For kmer depth Dk, read depth Dr, read length R, and kmer size K:  Dr=Dk*(R/(R-K+1))
maxdepth=-1         (max) Reads will not be downsampled when below this depth, even if they are above the target depth.            
mindepth=5          (min) Kmers with depth below this number will not be included when calculating the depth of a read.
minkmers=15         (mgkpr) Reads must have at least this many kmers over min depth to be retained.  Aka 'mingoodkmersperread'.
percentile=54.0     (dp) Read depth is by default inferred from the 54th percentile of kmer depth, but this may be changed to any number 1-100.
uselowerdepth=t     (uld) For pairs, use the depth of the lower read as the depth proxy.
deterministic=t     (dr) Generate random numbers deterministically to ensure identical output between multiple runs.  May decrease speed with a huge number of threads.
passes=2            (p) 1 pass is the basic mode.  2 passes (default) allows greater accuracy, error detection, better contol of output depth.

Error detection parameters:
hdp=90.0            (highdepthpercentile) Position in sorted kmer depth array used as proxy of a read's high kmer depth.
ldp=25.0            (lowdepthpercentile) Position in sorted kmer depth array used as proxy of a read's low kmer depth.
tossbadreads=f      (tbr) Throw away reads detected as containing errors.
requirebothbad=f    (rbb) Only toss bad pairs if both reads are bad.
errordetectratio=125   (edr) Reads with a ratio of at least this much between their high and low depth kmers will be classified as error reads.
highthresh=12       (ht) Threshold for high kmer.  A high kmer at this or above are considered non-error.
lowthresh=3         (lt) Threshold for low kmer.  Kmers at this and below are always considered errors.

Error correction parameters:
ecc=f               Set to true to correct errors.  NOTE: Tadpole is now preferred for ecc as it does a better job.
ecclimit=3          Correct up to this many errors per read.  If more are detected, the read will remain unchanged.
errorcorrectratio=140  (ecr) Adjacent kmers with a depth ratio of at least this much between will be classified as an error.
echighthresh=22     (echt) Threshold for high kmer.  A kmer at this or above may be considered non-error.
eclowthresh=2       (eclt) Threshold for low kmer.  Kmers at this and below are considered errors.
eccmaxqual=127      Do not correct bases with quality above this value.
aec=f               (aggressiveErrorCorrection) Sets more aggressive values of ecr=100, ecclimit=7, echt=16, eclt=3.
cec=f               (conservativeErrorCorrection) Sets more conservative values of ecr=180, ecclimit=2, echt=30, eclt=1, sl=4, pl=4.
meo=f               (markErrorsOnly) Marks errors by reducing quality value of suspected errors; does not correct anything.
mue=t               (markUncorrectableErrors) Marks errors only on uncorrectable reads; requires 'ecc=t'.
overlap=f           (ecco) Error correct by read overlap.

Depth binning parameters:
lowbindepth=10      (lbd) Cutoff for low depth bin.
highbindepth=80     (hbd) Cutoff for high depth bin.
outlow=<file>       Pairs in which both reads have a median below lbd go into this file.
outhigh=<file>      Pairs in which both reads have a median above hbd go into this file.
outmid=<file>       All other pairs go into this file.

Histogram parameters:
hist=<file>         Specify a file to write the input kmer depth histogram.
histout=<file>      Specify a file to write the output kmer depth histogram.
histcol=3           (histogramcolumns) Number of histogram columns, 2 or 3.
pzc=f               (printzerocoverage) Print lines in the histogram with zero coverage.
histlen=1048576     Max kmer depth displayed in histogram.  Also affects statistics displayed, but does not affect normalization.

Peak calling parameters:
peaks=<file>        Write the peaks to this file.  Default is stdout.
minHeight=2         (h) Ignore peaks shorter than this.
minVolume=5         (v) Ignore peaks with less area than this.
minWidth=3          (w) Ignore peaks narrower than this.
minPeak=2           (minp) Ignore peaks with an X-value below this.
maxPeak=BIG         (maxp) Ignore peaks with an X-value above this.
maxPeakCount=8      (maxpc) Print up to this many peaks (prioritizing height).

Java Parameters:
-Xmx                This will set Java's memory usage, overriding autodetection.
                    -Xmx20g will specify 20 gigs of RAM, and -Xmx200m will specify 200 megs.
                    The max is typically 85% of physical memory.
-eoom               This flag will cause the process to exit if an
                    out-of-memory exception occurs.  Requires Java 8u92+.
-da                 Disable assertions.

Please contact Brian Bushnell at bbushnell@lbl.gov if you encounter any problems.
For documentation and the latest version, visit: https://bbmap.org
```


## bbmap_khist.sh

### Tool Description
Kmer normalization and histogram generation tool (jgi.KmerNormalize)

### Metadata
- **Docker Image**: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
- **Homepage**: https://sourceforge.net/projects/bbmap
- **Package**: https://anaconda.org/channels/bioconda/packages/bbmap/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
java -ea  --add-modules jdk.incubator.vector -Xmx26469m -Xms26469m -cp /usr/local/opt/bbmap-39.52-0/current/ jgi.KmerNormalize bits=32 ecc=f passes=1 keepall dr=f prefilter hist=stdout minprob=0 minqual=0 mindepth=0 minkmers=1 hashes=3 --h
WARNING: Using incubator modules: jdk.incubator.vector
Executing jgi.KmerNormalize [bits=32, ecc=f, passes=1, keepall, dr=f, prefilter, hist=stdout, minprob=0, minqual=0, mindepth=0, minkmers=1, hashes=3, h]

Exception in thread "main" java.lang.RuntimeException: Unknown parameter h
	at jgi.KmerNormalize.main(KmerNormalize.java:474)
```


## bbmap_dedupe.sh

### Tool Description
Accepts one or more files containing sets of sequences (reads or scaffolds). Removes duplicate sequences, which may be specified to be exact matches, subsequences, or sequences within some percent identity. Can also find overlapping sequences and group them into clusters.

### Metadata
- **Docker Image**: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
- **Homepage**: https://sourceforge.net/projects/bbmap
- **Package**: https://anaconda.org/channels/bioconda/packages/bbmap/overview
- **Validation**: PASS

### Original Help Text
```text
Written by Brian Bushnell and Jonathan Rood
Last modified February 19, 2020

Description:  Accepts one or more files containing sets of sequences (reads or scaffolds).
Removes duplicate sequences, which may be specified to be exact matches, subsequences, or sequences within some percent identity.
Can also find overlapping sequences and group them into clusters.
Please read bbmap/docs/guides/DedupeGuide.txt for more information.

Usage:     dedupe.sh in=<file or stdin> out=<file or stdout>

An example of running Dedupe for clustering short reads:
dedupe.sh in=x.fq am=f ac=f fo c pc rnc=f mcs=4 mo=100 s=1 pto cc qin=33 csf=stats.txt pattern=cluster_%.fq dot=graph.dot

Input may be fasta or fastq, compressed or uncompressed.
Output may be stdout or a file.  With no output parameter, data will be written to stdout.
If 'out=null', there will be no output, but statistics will still be printed.
You can also use 'dedupe <infile> <outfile>' without the 'in=' and 'out='.

I/O parameters:
in=<file,file>        A single file or a comma-delimited list of files.
out=<file>            Destination for all output contigs.
pattern=<file>        Clusters will be written to individual files, where the '%' symbol in the pattern is replaced by cluster number.
outd=<file>           Optional; removed duplicates will go here.
csf=<file>            (clusterstatsfile) Write a list of cluster names and sizes.
dot=<file>            (graph) Write a graph in dot format.  Requires 'fo' and 'pc' flags.
threads=auto          (t) Set number of threads to use; default is number of logical processors.
overwrite=t           (ow) Set to false to force the program to abort rather than overwrite an existing file.
showspeed=t           (ss) Set to 'f' to suppress display of processing speed.
minscaf=0             (ms) Ignore contigs/scaffolds shorter than this.
interleaved=auto      If true, forces fastq input to be paired and interleaved.
ziplevel=2            Set to 1 (lowest) through 9 (max) to change compression level; lower compression is faster.

Output format parameters:
storename=t           (sn) Store scaffold names (set false to save memory).
#addpairnum=f         Add .1 and .2 to numeric id of read1 and read2.
storequality=t        (sq) Store quality values for fastq assemblies (set false to save memory).
uniquenames=t         (un) Ensure all output scaffolds have unique names.  Uses more memory.
mergenames=f          When a sequence absorbs another, concatenate their headers.
mergedelimiter=>      Delimiter between merged headers.  Can be a symbol name like greaterthan.
numbergraphnodes=t    (ngn) Label dot graph nodes with read numbers rather than read names.
sort=f                Sort output (otherwise it will be random).  Options:
                         length:  Sort by length
                         quality: Sort by quality
                         name:    Sort by name
                         id:      Sort by input order
ascending=f           Sort in ascending order.
ordered=f             Output sequences in input order.  Equivalent to sort=id ascending.
renameclusters=f      (rnc) Rename contigs to indicate which cluster they are in.
printlengthinedges=f  (ple) Print the length of contigs in edges.

Processing parameters:
absorbrc=t            (arc) Absorb reverse-complements as well as normal orientation.
absorbmatch=t         (am) Absorb exact matches of contigs.
absorbcontainment=t   (ac) Absorb full containments of contigs.
#absorboverlap=f      (ao) Absorb (merge) non-contained overlaps of contigs (TODO).
findoverlap=f         (fo) Find overlaps between contigs (containments and non-containments).  Necessary for clustering.
uniqueonly=f          (uo) If true, all copies of duplicate reads will be discarded, rather than keeping 1.
rmn=f                 (requirematchingnames) If true, both names and sequence must match.
usejni=f              (jni) Do alignments in C code, which is faster, if an edit distance is allowed.
                      This will require compiling the C code; details are in /jni/README.txt.

Subset parameters:
subsetcount=1         (sstc) Number of subsets used to process the data; higher uses less memory.
subset=0              (sst) Only process reads whose ((ID%subsetcount)==subset).

Clustering parameters:
cluster=f             (c) Group overlapping contigs into clusters.
pto=f                 (preventtransitiveoverlaps) Do not look for new edges between nodes in the same cluster.
minclustersize=1      (mcs) Do not output clusters smaller than this.
pbr=f                 (pickbestrepresentative) Only output the single highest-quality read per cluster.

Cluster postprocessing parameters:
processclusters=f     (pc) Run the cluster processing phase, which performs the selected operations in this category.
                      For example, pc AND cc must be enabled to perform cc.
fixmultijoins=t       (fmj) Remove redundant overlaps between the same two contigs.
removecycles=t        (rc) Remove all cycles so clusters form trees.
cc=t                  (canonicizeclusters) Flip contigs so clusters have a single orientation.
fcc=f                 (fixcanoncontradictions) Truncate graph at nodes with canonization disputes.
foc=f                 (fixoffsetcontradictions) Truncate graph at nodes with offset disputes.
mst=f                 (maxspanningtree) Remove cyclic edges, leaving only the longest edges that form a tree.

Overlap Detection Parameters
exact=t               (ex) Only allow exact symbol matches.  When false, an 'N' will match any symbol.
touppercase=t         (tuc) Convert input bases to upper-case; otherwise, lower-case will not match.
maxsubs=0             (s) Allow up to this many mismatches (substitutions only, no indels).  May be set higher than maxedits.
maxedits=0            (e) Allow up to this many edits (subs or indels).  Higher is slower.
minidentity=100       (mid) Absorb contained sequences with percent identity of at least this (includes indels).
minlengthpercent=0    (mlp) Smaller contig must be at least this percent of larger contig's length to be absorbed.
minoverlappercent=0   (mop) Overlap must be at least this percent of smaller contig's length to cluster and merge.
minoverlap=200        (mo) Overlap must be at least this long to cluster and merge.
depthratio=0          (dr) When non-zero, overlaps will only be formed between reads with a depth ratio of at most this.
                      Should be above 1.  Depth is determined by parsing the read names; this information can be added
                      by running KmerNormalize (khist.sh, bbnorm.sh, or ecc.sh) with the flag 'rename'
k=31                  Seed length used for finding containments and overlaps.  Anything shorter than k will not be found.
numaffixmaps=1        (nam) Number of prefixes/suffixes to index per contig. Higher is more sensitive, if edits are allowed.
hashns=f              Set to true to search for matches using kmers containing Ns.  Can lead to extreme slowdown in some cases.
#ignoreaffix1=f       (ia1) Ignore first affix (for testing).
#storesuffix=f        (ss) Store suffix as well as prefix.  Automatically set to true when doing inexact matches.

Other Parameters
qtrim=f               Set to qtrim=rl to trim leading and trailing Ns.
trimq=6               Quality trim level.
forcetrimleft=-1      (ftl) If positive, trim bases to the left of this position (exclusive, 0-based).
forcetrimright=-1     (ftr) If positive, trim bases to the right of this position (exclusive, 0-based).

Note on Proteins / Amino Acids
Dedupe supports amino acid space via the 'amino' flag.  This also changes the default kmer length to 10.
In amino acid mode, all flags related to canonicity and reverse-complementation are disabled,
and nam (numaffixmaps) is currently limited to 2 per tip.

Java Parameters:
-Xmx                  This will set Java's memory usage, overriding autodetection.
                      -Xmx20g will specify 20 gigs of RAM, and -Xmx200m will specify 200 megs.
                    The max is typically 85% of physical memory.
-eoom                 This flag will cause the process to exit if an out-of-memory exception occurs.  Requires Java 8u92+.
-da                   Disable assertions.

Please contact Brian Bushnell at bbushnell@lbl.gov if you encounter any problems.
For documentation and the latest version, visit: https://bbmap.org
```


## bbmap_reformat.sh

### Tool Description
Reformats reads to change ASCII quality encoding, interleaving, file format, or compression format. Optionally performs additional functions such as quality trimming, subsetting, and subsampling.

### Metadata
- **Docker Image**: quay.io/biocontainers/bbmap:39.52--he5f24ec_0
- **Homepage**: https://sourceforge.net/projects/bbmap
- **Package**: https://anaconda.org/channels/bioconda/packages/bbmap/overview
- **Validation**: PASS

### Original Help Text
```text
Written by Brian Bushnell
Last modified November 19, 2025

Description:  Reformats reads to change ASCII quality encoding, interleaving, file format, or compression format.
Optionally performs additional functions such as quality trimming, subsetting, and subsampling.
Supports fastq, fasta, fasta+qual, scarf, oneline, sam, bam, gzip, bz2.
Please read bbmap/docs/guides/ReformatGuide.txt for more information.

Usage:  reformat.sh in=<file> in2=<file2> out=<outfile> out2=<outfile2>

in2 and out2 are for paired reads and are optional.
If input is paired and there is only one output file, it will be written interleaved.

Parameters and their defaults:

ow=f                    (overwrite) Overwrites files that already exist.
app=f                   (append) Append to files that already exist.
zl=4                    (ziplevel) Set compression level, 1 (low) to 9 (max).
int=f                   (interleaved) Determines whether INPUT file is considered interleaved.
fastawrap=70            Length of lines in fasta output.
fastareadlen=0          Set to a non-zero number to break fasta files into reads of at most this length.
fastaminlen=1           Ignore fasta reads shorter than this.
qin=auto                ASCII offset for input quality.  May be 33 (Sanger), 64 (Illumina), or auto.
qout=auto               ASCII offset for output quality.  May be 33 (Sanger), 64 (Illumina), or auto (same as input).
qfake=30                Quality value used for fasta to fastq reformatting.
qfin=<.qual file>       Read qualities from this qual file, for the reads coming from 'in=<fasta file>'
qfin2=<.qual file>      Read qualities from this qual file, for the reads coming from 'in2=<fasta file>'
qfout=<.qual file>      Write qualities from this qual file, for the reads going to 'out=<fasta file>'
qfout2=<.qual file>     Write qualities from this qual file, for the reads coming from 'out2=<fasta file>'
outsingle=<file>        (outs) If a read is longer than minlength and its mate is shorter, the longer one goes here.
deleteinput=f           Delete input upon successful completion.
ref=<file>              Optional reference fasta for sam processing.

Processing Parameters:

verifypaired=f          (vpair) When true, checks reads to see if the names look paired.  Prints an error message if not.
verifyinterleaved=f     (vint) sets 'vpair' to true and 'interleaved' to true.
allowidenticalnames=f   (ain) When verifying pair names, allows identical names, instead of requiring /1 and /2 or 1: and 2:
tossbrokenreads=f       (tbr) Discard reads that have different numbers of bases and qualities.  By default this will be detected and cause a crash.
ignorebadquality=f      (ibq) Fix out-of-range quality values instead of crashing with a warning.
addslash=f              Append ' /1' and ' /2' to read names, if not already present.  Please include the flag 'int=t' if the reads are interleaved.
spaceslash=t            Put a space before the slash in addslash mode.
addcolon=f              Append ' 1:' and ' 2:' to read names, if not already present.  Please include the flag 'int=t' if the reads are interleaved.
underscore=f            Change whitespace in read names to underscores.
rcomp=f                 (rc) Reverse-complement reads.
rcompmate=f             (rcm) Reverse-complement read 2 only.
comp=f                  (complement) Reverse-complement reads.
changequality=t         (cq) N bases always get a quality of 0 and ACGT bases get a min quality of 2.
quantize=f              Quantize qualities to a subset of values like NextSeq.  Can also be used with comma-delimited list, like quantize=0,8,13,22,27,32,37
tuc=f                   (touppercase) Change lowercase letters in reads to uppercase.
uniquenames=f           Make duplicate names unique by appending _<number>.
remap=                  A set of pairs: remap=CTGN will transform C>T and G>N.
                        Use remap1 and remap2 to specify read 1 or 2.
iupacToN=f              (itn) Convert non-ACGTN symbols to N.
monitor=f               Kill this process if it crashes.  monitor=600,0.01 would kill after 600 seconds under 1% usage.
crashjunk=t             Crash when encountering reads with invalid bases.
tossjunk=f              Discard reads with invalid characters as bases.
fixjunk=f               Convert invalid bases to N (or X for amino acids).
dotdashxton=f           Specifically convert . - and X to N (or X for amino acids).
recalibrate=f           (recal) Recalibrate quality scores.  Must first generate matrices with CalcTrueQuality.
maxcalledquality=41     Quality scores capped at this upper bound.
mincalledquality=2      Quality scores of ACGT bases will be capped at lower bound.
trimreaddescription=f   (trd) Trim the names of reads after the first whitespace.
trimrname=f             For sam/bam files, trim rname/rnext fields after the first space.
fixheaders=f            Replace characters in headers such as space, *, and | to make them valid file names.
warnifnosequence=t      For fasta, issue a warning if a sequenceless header is encountered.
warnfirsttimeonly=t     Issue a warning for only the first sequenceless header.
utot=f                  Convert U to T (for RNA -> DNA translation).
padleft=0               Pad the left end of sequences with this many symbols.
padright=0              Pad the right end of sequences with this many symbols.
pad=0                   Set padleft and padright to the same value.
padsymbol=N             Symbol to use for padding.

Histogram output parameters:

bhist=<file>            Base composition histogram by position.
qhist=<file>            Quality histogram by position.
qchist=<file>           Count of bases with each quality value.
aqhist=<file>           Histogram of average read quality.
bqhist=<file>           Quality histogram designed for box plots.
lhist=<file>            Read length histogram.
gchist=<file>           Read GC content histogram.
gcbins=100              Number gchist bins.  Set to 'auto' to use read length.
gcplot=f                Add a graphical representation to the gchist.
maxhistlen=6000         Set an upper bound for histogram lengths; higher uses more memory.
                        The default is 6000 for some histograms and 80000 for others.

Histogram parameters for sam files only (requires sam format 1.4 or higher):

ehist=<file>            Errors-per-read histogram.
qahist=<file>           Quality accuracy histogram of error rates versus quality score.
indelhist=<file>        Indel length histogram.
mhist=<file>            Histogram of match, sub, del, and ins rates by read location.
ihist=<file>            Insert size histograms.  Requires paired reads in a sam file.
idhist=<file>           Histogram of read count versus percent identity.
idbins=100              Number idhist bins.  Set to 'auto' to use read length.

Sampling parameters:

reads=-1                Set to a positive number to only process this many INPUT reads (or pairs), then quit.
skipreads=-1            Skip (discard) this many INPUT reads before processing the rest.
samplerate=1            Randomly output only this fraction of reads; 1 means sampling is disabled.
sampleseed=-1           Set to a positive number to use that prng seed for sampling (allowing deterministic sampling).
samplereadstarget=0     (srt) Exact number of OUTPUT reads (or pairs) desired.
samplebasestarget=0     (sbt) Exact number of OUTPUT bases desired.
                        Important: srt/sbt flags should not be used with stdin, samplerate, qtrim, minlength, or minavgquality.
upsample=f              Allow srt/sbt to upsample (duplicate reads) when the target is greater than input.
prioritizelength=f      If true, calculate a length threshold to reach the target, and retain all reads of at least that length (must set srt or sbt).

Trimming and filtering parameters:

qtrim=f                 Trim read ends to remove bases with quality below trimq.
                        Values: t (trim both ends), f (neither end), r (right end only), l (left end only), w (sliding window).
trimq=6                 Regions with average quality BELOW this will be trimmed.  Can be a floating-point number like 7.3.
minlength=0             (ml) Reads shorter than this after trimming will be discarded.  Pairs will be discarded only if both are shorter.
mlf=0                   (mlf) Reads shorter than this fraction of original length after trimming will be discarded.
maxlength=0             If nonzero, reads longer than this after trimming will be discarded.
breaklength=0           If nonzero, reads longer than this will be broken into multiple reads of this length.  Does not work for paired reads.
requirebothbad=t        (rbb) Only discard pairs if both reads are shorter than minlen.
invertfilters=f         (invert) Output failing reads instead of passing reads.
minavgquality=0         (maq) Reads with average quality (after trimming) below this will be discarded.
maqb=0                  If positive, calculate maq from this many initial bases.
chastityfilter=f        (cf) Reads with names  containing ' 1:Y:' or ' 2:Y:' will be discarded.
barcodefilter=f         Remove reads with unexpected barcodes if barcodes is set, or barcodes containing 'N' otherwise.  
                        A barcode must be the last part of the read header.
barcodes=               Comma-delimited list of barcodes or files of barcodes.
maxns=-1                If 0 or greater, reads with more Ns than this (after trimming) will be discarded.
minconsecutivebases=0   (mcb) Discard reads without at least this many consecutive called bases.
forcetrimleft=0         (ftl) If nonzero, trim left bases of the read to this position (exclusive, 0-based).
forcetrimright=-1       (ftr) If nonnegative, trim right bases of the read after this position (exclusive, 0-based).
forcetrimright2=0       (ftr2) If positive, trim this many bases on the right end.
forcetrimmod=5          (ftm) If positive, trim length to be equal to zero modulo this number.
mingc=0                 Discard reads with GC content below this.
maxgc=1                 Discard reads with GC content above this.
gcpairs=t               Use average GC of paired reads.
                        Also affects gchist.

Tag-filtering parameters:

tag=                    Look for this tag in the header to filter by the next value.  To filter reads
                        with a header like 'foo,depth=5.5,bar' where you only want depths
                        of at least 3, the necessary flags would be 'tag=depth= minvalue=3 delimiter=,'
delimiter=              Character after the end of the value, such as delimiter=X.  Control and
                        whitespace symbols may be spelled out, like delimiter=tab or delimiter=pipe.
                        The tag may contain the delimiter.  If the value is the last term in the header,
                        the delimiter doesn't matter but is still required.
minvalue=               If set, only accept a numeric value of at least this.
maxvalue=               If set, only accept a numeric value of at most this.
value=                  If set, only accept a string value of exactly this.

Illumina-specific parameters:
top=true                Include reads from the top of the flowcell.
bottom=true             Include reads from the bottom of the flowcell.

Sam and bam processing parameters:

mappedonly=f            Toss unmapped reads.
unmappedonly=f          Toss mapped reads.
pairedonly=f            Toss reads that are not mapped as proper pairs.
unpairedonly=f          Toss reads that are mapped as proper pairs.
primaryonly=f           Toss secondary alignments.  Set this to true for sam to fastq conversion.
minmapq=-1              If non-negative, toss reads with mapq under this.
maxmapq=-1              If non-negative, toss reads with mapq over this.
requiredbits=0          (rbits) Toss sam lines with any of these flag bits unset.  Similar to samtools -f.
filterbits=0            (fbits) Toss sam lines with any of these flag bits set.  Similar to samtools -F.
stoptag=f               Set to true to write a tag indicating read stop location, prefixed by YS:i:
sam=                    Set to 'sam=1.3' to convert '=' and 'X' cigar symbols (from sam 1.4+ format) to 'M'.
                        Set to 'sam=1.4' to convert 'M' to '=' and 'X' (sam=1.4 requires MD tags to be present, or ref to be specified).

Sam and bam alignment filtering parameters:
These require = and X symbols in cigar strings, or MD tags, or a reference fasta.
-1 means disabled; to filter reads with any of a symbol type, set to 0.

subfilter=-1            Discard reads with more than this many substitutions.
minsubs=-1              Discard reads with fewer than this many substitutions.
insfilter=-1            Discard reads with more than this many insertions.
delfilter=-1            Discard reads with more than this many deletions.
indelfilter=-1          Discard reads with more than this many indels.
editfilter=-1           Discard reads with more than this many edits.
inslenfilter=-1         Discard reads with an insertion longer than this.
dellenfilter=-1         Discard reads with a deletion longer than this.
minidfilter=-1.0        Discard reads with identity below this (0-1).
maxidfilter=1.0         Discard reads with identity above this (0-1).
clipfilter=-1           Discard reads with more than this many soft-clipped bases.

Kmer counting and cardinality estimation parameters:
k=0                     If positive, count the total number of kmers.
cardinality=f           (loglog) Count unique kmers using the LogLog algorithm.
loglogbuckets=1999      Use this many buckets for cardinality estimation.

Shortcuts: 
The # symbol will be substituted for 1 and 2.  The % symbol in out will be substituted for input name minus extensions.
For example:
reformat.sh in=read#.fq out=%.fa
...is equivalent to:
reformat.sh in1=read1.fq in2=read2.fq out1=read1.fa out2=read2.fa

Java Parameters:
-Xmx                    This will set Java's memory usage, overriding autodetection.
                        -Xmx20g will specify 20 gigs of RAM, and -Xmx200m will specify 200 megs.
                        The max is typically 85% of physical memory.
-eoom                   This flag will cause the process to exit if an out-of-memory exception occurs.  Requires Java 8u92+.
-da                     Disable assertions.

Please contact Brian Bushnell at bbushnell@lbl.gov if you encounter any problems.
For documentation and the latest version, visit: https://bbmap.org
```


## Metadata
- **Skill**: generated
