# biobambam CWL Generation Report

## biobambam_bammarkduplicatesopt

### Tool Description
Mark duplicates in BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
- **Homepage**: https://gitlab.com/german.tischler/biobambam2
- **Package**: https://anaconda.org/channels/bioconda/packages/biobambam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biobambam/overview
- **Total Downloads**: 118.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
This is biobambam2 version 2.0.185.
biobambam2 is distributed under version 3 of the GNU General Public License.

Key=Value pairs:

I=<filename>                  : input file, stdin if unset
O=<filename>                  : output file, stdout if unset
M=<filename>                  : metrics file, stderr if unset
D=<filename>                  : duplicates output file if rmdup=1
tmpfile=<filename>            : prefix for temporary files, default: create files in current directory
level=<[6]>                   : compression settings for output bam file (1=fast,2=2,3=3,4=4,5=5,6=6,7=7,8=8,9=best,10=10,11=11,12=12)
verbose=<[1]>                 : print progress report (default: 1)
mod=<[1048576]>               : print progress for each mod'th record/alignment
rewritebam=<[0]>              : compression of temporary alignment file when input is via stdin (0=snappy,1=gzip/bam,2=copy)
rewritebamlevel=<[6]>         : compression setting for rewritten input file if rewritebam=1 (1=fast,2=2,3=3,4=4,5=5,6=6,7=7,8=8,9=best,10=10,11=11,12=12)
rmdup=<[0]>                   : remove duplicates (default: 0)
md5=<[0]>                     : create md5 check sum (default: 0)
md5filename=<filename>        : file name for md5 check sum (default: extend output file name)
index=<[0]>                   : create BAM index (default: 0)
indexfilename=<filename>      : file name for BAM index file (default: extend output file name)
tag=<[a-zA-Z][a-zA-Z0-9]>     : aux field id for tag string extraction
nucltag=<[a-zA-Z][a-zA-Z0-9]> : aux field id for nucleotide tag extraction
colhashbits=<[20]>            : log_2 of size of hash table used for collation
collistsize=<[33554432]>      : output list size for collation
fragbufsize=<[50331648]>      : size of each fragment/pair file buffer in bytes
D=<filename>                  : duplicates output file if rmdup=1
dupmd5=<[0]>                  : create md5 check sum for duplicates output file (default: 0)
dupmd5filename=<filename>     : file name for md5 check sum of dup file (default: extend duplicates output file name)
dupindex=<[0]>                : create BAM index for duplicates file (default: 0)
dupindexfilename=<filename>   : file name for BAM index file for duplicates file (default: extend duplicates output file name)
optminpixeldif=<[100]>        : pixel difference threshold for optical duplicates (default: 100)
odtag=<[od]>                  : tag added for optical duplicates (default: od)
inputthreads=<[1]>            : input helper threads (for inputformat=bam only, default: 1)
reference=<>                  : reference FastA (.fai file required, for cram i/o only)
outputthreads=<[1]>           : output helper threads (for outputformat=bam only, default: 1)
inputformat=<[bam]>           : input format (bam,cram,maussam,sam,sbam)
outputformat=<[bam]>          : output format (bam,cram,sam)
addmatecigar=<[0]>            : add mate cigar string field MC (default: 0)
```


## biobambam_bamsormadup

### Tool Description
Sorts and marks duplicate reads in BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
- **Homepage**: https://gitlab.com/german.tischler/biobambam2
- **Package**: https://anaconda.org/channels/bioconda/packages/biobambam/overview
- **Validation**: PASS

### Original Help Text
```text
This is biobambam2 version 2.0.185.
biobambam2 is distributed under version 3 of the GNU General Public License.

Key=Value pairs:

level=<[6]>                                       : compression settings for output bam file (1=fast,2=2,3=3,4=4,5=5,6=6,7=7,8=8,9=best,10=10,11=11,12=12)
templevel=<[1]>                                   : compression setting for temporary files (see level for options)
threads=<[20]>                                    : number of threads
tmpfile=<[bamsormadup_414e684474f1_1_1772005288]> : prefix for temporary files, default: create files in current directory
inputformat=<[bam]>                               : input format (sam,bam)
M=<filename>                                      : metrics file, stderr if unset
seqchksumhash=<[crc32prod]>                       : seqchksum digest function: crc32prod,crc32,md5,sha1,sha224,sha256,sha384,sha512,crc32prime32,crc32prime64,md5prime64,sha1prime64,sha224prime64,sha256prime64,sha384prime64,sha512prime64,crc32prime96,md5prime96,sha1prime96,sha224prime96,sha256prime96,sha384prime96,sha512prime96,crc32prime128,md5prime128,sha1prime128,sha224prime128,sha256prime128,sha384prime128,sha512prime128,crc32prime160,md5prime160,sha1prime160,sha224prime160,sha256prime160,sha384prime160,sha512prime160,crc32prime192,md5prime192,sha1prime192,sha224prime192,sha256prime192,sha384prime192,sha512prime192,crc32prime224,md5prime224,sha1prime224,sha224prime224,sha256prime224,sha384prime224,sha512prime224,crc32prime256,md5prime256,sha1prime256,sha224prime256,sha256prime256,sha384prime256,sha512prime256,null,sha512primesums,sha512primesums512,sha3_256,murmur3,murmur3primesums128
digest=<[md5]>                                    : hash digest computed for output stream (md5, sha512)
digestfilename=<[]>                               : name of file for storing hash digest computed for output stream (not stored by default)
indexfilename=<[]>                                : name of file for storing BAM index (not stored by default)
SO=<coordinate|queryname>                         : output sort order (coordinate by default)
outputformat=<[bam]>                              : output format (sam,bam,cram)
reference=<[]>                                    : reference FastA for writing cram
optminpixeldif=<[100]>                            : pixel difference threshold for optical duplicates (default: 100)
rcsupport=<[0]>                                   : add rc tag (unclipped coordinate, default: 0)
numerical=<[]>                                    : file name for storing numerical index (not stored by default)
numericalindexmod=<[1024]>                        : block size when producing numerical index (default: 1024)
fragmergepar=<[1]>                                : threads used while merging fragment lists for duplicate marking (default: 1)
crammode=<[]>                                     : CRAM encoding profile (default: )
```


## biobambam_bamtofastq

### Tool Description
Convert BAM/SAM/CRAM to FASTQ format.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
- **Homepage**: https://gitlab.com/german.tischler/biobambam2
- **Package**: https://anaconda.org/channels/bioconda/packages/biobambam/overview
- **Validation**: PASS

### Original Help Text
```text
This is biobambam2 version 2.0.185.
biobambam2 is distributed under version 3 of the GNU General Public License.

Key=Value pairs:

F=<[stdout]>                               : matched pairs first mates
F2=<[stdout]>                              : matched pairs second mates
S=<[stdout]>                               : single end
O=<[stdout]>                               : unmatched pairs first mates
O2=<[stdout]>                              : unmatched pairs second mates
collate=<[1]>                              : collate pairs
combs=<[0]>                                : print some counts after collation based processing
filename=<[stdin]>                         : input filename (default: read file from standard input)
inputformat=<[bam]>                        : input format: cram, bam or sam
reference=<[]>                             : name of reference FastA in case of inputformat=cram
ranges=<[]>                                : input ranges (bam and cram input only, default: read complete file)
exclude=<[SECONDARY,SUPPLEMENTARY]>        : exclude alignments matching any of the given flags
disablevalidation=<[0]>                    : disable validation of input data
colhlog=<[18]>                             : base 2 logarithm of hash table size used for collation
colsbs=<[33554432]>                        : size of hash table overflow list in bytes
T=<[bamtofastq_20b15d712873_1_1772005324]> : temporary file name
gz=<[0]>                                   : compress output streams in gzip format (default: 0)
level=<[-1]>                               : compression setting if gz=1 (1=fast,2=2,3=3,4=4,5=5,6=6,7=7,8=8,9=best,10=10,11=11,12=12)
fasta=<[0]>                                : output FastA instead of FastQ
inputbuffersize=<[-1]>                     : size of input buffer
outputperreadgroup=<[0]>                   : split output per read group (for collate=1 only)
outputdir=<>                               : directory for output if outputperreadgroup=1 (default: current directory)
outputperreadgroupsuffixF=<[_1.fq]>        : suffix for F category when outputperreadgroup=1
outputperreadgroupsuffixF2=<[_2.fq]>       : suffix for F2 category when outputperreadgroup=1
outputperreadgroupsuffixO=<[_o1.fq]>       : suffix for O category when outputperreadgroup=1
outputperreadgroupsuffixO2=<[_o2.fq]>      : suffix for O2 category when outputperreadgroup=1
outputperreadgroupsuffixS=<[_s.fq]>        : suffix for S category when outputperreadgroup=1
tryoq=<[0]>                                : use OQ field instead of quality field if present (collate={0,1} only)
split=<[0]>                                : split named output files into chunks of this amount of reads (0: do not split)
splitprefix=<[bamtofastq_split]>           : file name prefix if collate=0 and split>0
tags=<[]>                                  : list of aux tags to be copied (default: do not copy any aux fields)
outputperreadgrouprgsm=<[0]>               : add read group field SM ahead of read group id when outputperreadgroup=1 (for collate=1 only)
outputperreadgroupprefix=<[]>              : prefix added in front of file names if outputperreadgroup=1 (for collate=1 only)
casava18=<[0]>                             : restore input taken by c18pe option
maxoutput=<[]>                             : output no more than this number of entries (default: no limit, collate=0 only)
cols=<[]>                                  : wrap sequence and quality lines at this number of columns (default: do not wrap, even numbers only)

Alignment flags: PAIRED,PROPER_PAIR,UNMAP,MUNMAP,REVERSE,MREVERSE,READ1,READ2,SECONDARY,QCFAIL,DUP,SUPPLEMENTARY
```


## biobambam_bamsort

### Tool Description
Sorts BAM/SAM/CRAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
- **Homepage**: https://gitlab.com/german.tischler/biobambam2
- **Package**: https://anaconda.org/channels/bioconda/packages/biobambam/overview
- **Validation**: PASS

### Original Help Text
```text
This is biobambam2 version 2.0.185.
biobambam2 is distributed under version 3 of the GNU General Public License.

Key=Value pairs:

level=<[6]>                   : compression settings for output bam file (1=fast,2=2,3=3,4=4,5=5,6=6,7=7,8=8,9=best,10=10,11=11,12=12)
SO=<[coordinate]>             : sorting order (coordinate, queryname, hash, tag, tagonly, queryname_HI or queryname_lexicographic)
verbose=<[1]>                 : print progress report
blockmb=<[1024]>              : size of internal memory buffer used for sorting in MiB
disablevalidation=<[0]>       : disable input validation (default is 0)
tmpfile=<filename>            : prefix for temporary files, default: create files in current directory
md5=<[0]>                     : create md5 check sum (default: 0)
md5filename=<filename>        : file name for md5 check sum
index=<[0]>                   : create BAM index (default: 0)
indexfilename=<filename>      : file name for BAM index file
inputformat=<[bam]>           : input format (bam,cram,maussam,sam,sbam)
outputformat=<[bam]>          : output format (bam,cram,sam)
I=<[stdin]>                   : input filename (standard input if unset)
inputthreads=<[1]>            : input helper threads (for inputformat=bam only, default: 1)
reference=<>                  : reference FastA (.fai file required, for cram i/o only)
range=<>                      : coordinate range to be processed (for coordinate sorted indexed BAM input only)
outputthreads=<[1]>           : output helper threads (for outputformat=bam only, default: 1)
O=<[stdout]>                  : output filename (standard output if unset)
fixmates=<[0]>                : fix mate information (for name collated input only, disabled by default)
calmdnm=<[0]>                 : calculate MD and NM aux fields (for coordinate sorted output only)
calmdnmreference=<[]>         : reference for calculating MD and NM aux fields (calmdnm=1 only)
calmdnmrecompindetonly=<[0]>  : only recalculate MD and NM in the presence of indeterminate bases (calmdnm=1 only)
calmdnmwarnchange=<[0]>       : warn when changing existing MD/NM fields (calmdnm=1 only)
adddupmarksupport=<[0]>       : add info for streaming duplicate marking (for name collated input only, ignored for fixmate=0, disabled by default)
tag=<[a-zA-Z][a-zA-Z0-9]>     : aux field id for tag string extraction (adddupmarksupport=1 only)
nucltag=<[a-zA-Z][a-zA-Z0-9]> : aux field id for nucleotide tag extraction (adddupmarksupport=1 only)
markduplicates=<[0]>          : mark duplicates (only when input name collated and output coordinate sorted, disabled by default)
rmdup=<[0]>                   : remove duplicates (only when input name collated and output coordinate sorted, disabled by default)
streaming=<[1]>               : do not open input files multiple times when set
sorttag=<[]>                  : tag used by SO=tag (no default)
sortthreads=<[1]>             : threads used for sorting (default: 1)
hash=<[crc32prod]>            : hash used for producing bamseqchksum type checksums (default: crc32prod)
```


## biobambam_bamvalidate

### Tool Description
Validate BAM/CRAM files and perform conversions.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
- **Homepage**: https://gitlab.com/german.tischler/biobambam2
- **Package**: https://anaconda.org/channels/bioconda/packages/biobambam/overview
- **Validation**: PASS

### Original Help Text
```text
This is biobambam2 version 2.0.185.
biobambam2 is distributed under version 3 of the GNU General Public License.

Key=Value pairs:

verbose=<[0]>            : print stats at the end of a successful run
basequalhist=<[0]>       : print base quality histogram at end of a successful run
passthrough=<[0]>        : write alignments to standard output (default: do not pass through)
tmpfile=<filename>       : prefix for temporary files, default: create files in current directory (passthrough=1, index=1 only)
md5=<[0]>                : create md5 check sum (default: 0, passthrough=1 only)
md5filename=<filename>   : file name for md5 check sum
index=<[0]>              : create BAM index (default: 0, passthrough=1 only)
indexfilename=<filename> : file name for BAM index file
inputformat=<[bam]>      : input format (bam,cram,maussam,sam,sbam)
outputformat=<[bam]>     : output format (bam,cram,sam, passthrough=1 only)
I=<[stdin]>              : input filename (standard input if unset)
inputthreads=<[1]>       : input helper threads (for inputformat=bam only, default: 1)
reference=<>             : reference FastA (.fai file required, for cram i/o only)
range=<>                 : coordinate range to be processed (for coordinate sorted indexed BAM input only)
outputthreads=<[1]>      : output helper threads (for outputformat=bam only, default: 1, passthrough=1 only)
O=<[stdout]>             : output filename (standard output if unset, passthrough=1 only)
```


## biobambam_bamauxmerge

### Tool Description
Merges BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/biobambam:2.0.185--h85de650_1
- **Homepage**: https://gitlab.com/german.tischler/biobambam2
- **Package**: https://anaconda.org/channels/bioconda/packages/biobambam/overview
- **Validation**: PASS

### Original Help Text
```text
PosixFdInput(-help,0): No such file or directory

/usr/local/bin/../lib/./libmaus2_stacktrace.so.2(libmaus2::stacktrace::StackTrace::StackTrace()+0x5e)[0x7b4fdb87b45e]
/usr/local/bin/../lib/libmaus2_exception.so.2(libmaus2::exception::LibMausException::LibMausException()+0x52)[0x7b4fdc036db2]
/usr/local/bin/../lib/libmaus2.so.2(libmaus2::aio::PosixFdInput::PosixFdInput(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&, int)+0x15e)[0x7b4fdc23d8ee]
/usr/local/bin/../lib/libmaus2.so.2(+0xd1a83)[0x7b4fdc11ca83]
/usr/local/bin/../lib/libmaus2.so.2(+0x15519b)[0x7b4fdc1a019b]
/usr/local/bin/../lib/libmaus2.so.2(libmaus2::aio::InputStreamInstance::InputStreamInstance(std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> > const&)+0x6d)[0x7b4fdc1a049d]
bamauxmerge(+0xa148e)[0x5e4029c0148e]
bamauxmerge(+0xa3040)[0x5e4029c03040]
bamauxmerge(+0xa3842)[0x5e4029c03842]
bamauxmerge(+0xa3b06)[0x5e4029c03b06]
bamauxmerge(+0x172e4)[0x5e4029b772e4]
/lib/x86_64-linux-gnu/libc.so.6(+0x2724a)[0x7b4fdbc3724a]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x85)[0x7b4fdbc37305]
bamauxmerge(+0x17468)[0x5e4029b77468]
```


## Metadata
- **Skill**: generated
