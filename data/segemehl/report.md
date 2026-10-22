# segemehl CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| segemehl | PASS | mapped 100 nf-core sarscov2 read pairs: 200 of 200 alignments (MAPQ 48), index generation, bam output with splits and bisulfite mode (two indexes) also ran; baseCommand fixed to segemehl (the image has no segemehl.x) and all options wrapped |
| segemehl_haarz_callmethyl | PASS | called methylation on a bisulfite bam made by segemehl from nf-core sarscov2 methylated reads: 11332 VCF records with methylation ratios; added .fai and .bai secondary files |
| segemehl_haarz_methylstring | PASS | annotated the same bisulfite bam: SAM records carry the ZM:Z methylation string |
| segemehl_haarz_split | Not completed | no usable test data: sarscov2 reads have no splice junctions, so the summary only has the header line |

## segemehl

### Tool Description
segemehl is a software to map short sequencer reads to reference genomes. Unlike other methods, segemehl is able to find de novo junctions (splits) in short reads.

### Metadata
- **Docker Image**: biocontainers/segemehl:v0.3.4-1-deb_cv1
- **Homepage**: http://www.bioinf.uni-leipzig.de/Software/segemehl/
- **Package**: https://anaconda.org/channels/bioconda/packages/segemehl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/segemehl/overview
- **Total Downloads**: 184.3K
- **Last updated**: 2025-09-30
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
segemehl: required option 'database' (d) missing
usage: segemehl [-besVOcf] -d <file> [<file>] [-q <file>] [-p <file>] [-i <file>] [-j <file>] 
                [-x <file>] [-y <file>] [-G <file>] [-g <string>] [-t <n>] [-o <string>] 
                [-u <file>] [-B <string>] [-F <n>] [-S [<basename>]] [-A <n>] [-D <n>] 
                [-E <double>] [-H] [-m <n>] [-Z <n>] [-W <n>] [-U <n>] [-l <f>] [-w <double>] 
                [-X <n>] [-J <n>] [-I <n>] [-M <n>] [-n <n>] [-r <n>] [--skipidcheck] 
                [--showalign] [--nohead] 
  Heuristic mapping of short sequences

 [INPUT]                         
 -d, --database <file> [<file>]  list of path/filename(s) of fasta database sequence(s)
 -q, --query <file>              path/filename of query sequences (default:none)
 -p, --mate <file>               path/filename of mate pair sequences (default:none)
 -i, --index <file>              path/filename of db index (default:none)
 -j, --index2 <file>             path/filename of second db index (default:none)
 -x, --generate <file>           generate db index and store to disk (default:none)
 -y, --generate2 <file>          generate second db index and store to disk (default:none)
 -G, --readgroupfile <file>      filename to read @RG header (default:none)
 -g, --readgroupid <string>      read group id (default:none)
 -t, --threads <n>               start <n> threads (default:1)
 [OUTPUT]                        
 -o, --outfile <string>          outputfile (default:none)
 -b, --bamabafixoida             generate a bam output (-o <filename> required)
 -u, --nomatchfilename <file>    filename for unmatched reads (default:none)
 -e, --briefcigar                brief cigar string (M vs X and =)
 -s, --progressbar               show a progress bar
 -B, --filebins <string>         file bins with basename <string> for easier data handling 
                                 (default:none)
 -V, --MEOP                      output MEOP field for easier variance calling in SAM (XE:Z:)
 [ALIGNMENT]                     
 -F, --bisulfite <n>             bisulfite aln with methylC-seq/Lister et al. (=1) or 
                                 bs-seq/Cokus et al. protocol (=2) (default:0)
 -S, --splits [<basename>]       detect split/spliced reads. (default:none)
 -A, --accuracy <n>              min percentage of matches per read in semi-global alignment 
                                 (default:90)
 -D, --differences <n>           search seeds initially with <n> differences (default:1)
 -E, --evalue <double>           max evalue (default:5.000000)
 -H, --hitstrategy               report only best scoring hits (=1) or all (=0) (default:1)
 -m, --minsize <n>               minimum length of queries (default:12)
 -Z, --minfraglen <n>            min length of a spliced fragment (default:20)
 -W, --minsplicecover <n>        min coverage for spliced transcripts (default:80)
 -U, --minfragscore <n>          min score of a spliced fragment (default:18)
 -l, --splicescorescale <f>      report spliced alignment with score s only if <f>*s is larger 
                                 than next best spliced alignment (default:0.900000)
 -w, --maxsplitevalue <double>   max evalue for splits (default:50.000000)
 [SPECIAL]                       
 -X, --dropoff <n>               dropoff parameter for extension (default:8)
 -J, --jump <n>                  search seeds with jump size <n> (0=automatic) (default:0)
 -O, --order                     sorts the output by chromsome and position (might take a while!)
 -I, --maxpairinsertsize <n>     maximum size of the inserts (paired end) in case of multiple 
                                 hits (default:200000)
 -M, --maxinterval <n>           maximum width of a suffix array interval, i.e. a query seed 
                                 will be omitted if it matches more than <n> times 
                                 (default:100)
 -c, --checkidx                  check index
 -n, --extensionpenalty <n>      penalty for a mismatch during extension (default:4)
 -r, --maxout <n>                maximum number of alignments that will be reported. If set to 
                                 zero, all alignments will be reported (default:0)
 --skipidcheck                   do not check whether the fastq ids of mates / paired ends 
                                 match. Instead, the first mate (-q) will be used for output 
                                 only.
 --showalign                     show alignments
 --nohead                        do not output header
 -f, --fullname                  write full query name (no trunctation at whitespace)
 [VERSION]
  0.3.4 ge5dee47 2018-12-25 20:39:07 +0100
 [BUGS]
  Please report bugs to steve@bioinf.uni-leipzig.de
 [REFERENCES]
  SEGEMEHL is free software under GPL 
  2008 Bioinformatik Leipzig 
  2018 Leibniz Institute on Aging (FLI)
```

## segemehl_haarz_callmethyl

### Tool Description
Generate methylation vcf from bam

### Metadata
- **Docker Image**: biocontainers/segemehl:v0.3.4-1-deb_cv1
- **Homepage**: http://www.bioinf.uni-leipzig.de/Software/segemehl/
- **Package**: https://anaconda.org/channels/bioconda/packages/segemehl/overview
- **Validation**: PASS

### Original Help Text
```text
haarz: required option 'database' (d) missing
usage: haarz [-u] -d <file> [<file>] -b <file> [-t <n>] [-o <file>] 
  Heuristic mapping of short sequences

 [methylation caller]            
 [INPUT]                         
 -d, --database <file> [<file>]  list of path/filename(s) of fasta 
                                 database sequence(s) 
                                 (default:none)
 -b, --bam <file>                path/filename of sorted and indexed 
                                 (!) bamfile (default:none)
 -t, --threads <n>               start <n> threads (default:10)
 -o, --output <file>             path/filename of output file (will 
                                 be sorted) (default:none)
 -u, --uniqueonly                only use uniquely mapped reads
 [VERSION]
  0.3.4 ge5dee47 2018-12-25 20:39:07 +0100
 [BUGS]
  Please report bugs to steve@bioinf.uni-leipzig.de
 [REFERENCES]
  SEGEMEHL is free software under GPL 
  2008 Bioinformatik Leipzig 
  2018 Computational Biology, Leibniz Institute on Aging (FLI)
```

## segemehl_haarz_methylstring

### Tool Description
Get SAM file with methylation string annotation

### Metadata
- **Docker Image**: biocontainers/segemehl:v0.3.4-1-deb_cv1
- **Homepage**: http://www.bioinf.uni-leipzig.de/Software/segemehl/
- **Package**: https://anaconda.org/channels/bioconda/packages/segemehl/overview
- **Validation**: PASS

### Original Help Text
```text
haarz: required option 'database' (d) missing
usage: haarz [-u] -d <file> [<file>] -b <file> [-a <file> [<file>]] 
             [-A <string>] [-O <string>] [-o <file>] [-t <n>] 
             
  Heuristic mapping of short sequences

 [methylation string]                   
 [INPUT]                                
 -d, --database <file> [<file>]         list of path/filename(s) of 
                                        fasta database sequence(s) 
                                        (default:none)
 -b, --bam <file>                       path/filename of sorted and 
                                        indexed (!) bamfile 
                                        (default:none)
 -a, --annotationfiles <file> [<file>]  list of path/filename(s) of 
                                        BED or GFF file (s))
 -A, --attributes <string>              attributes that shall be 
                                        selected for overlap 
                                        annotation
 -O, --offsets <string>                 offsets for the annotation
 -o, --output <file>                    path/filename of output file 
                                        (will be sorted) 
                                        (default:none)
 -u, --uniqueonly                       generate a bam output (-o 
                                        <filename> required)
 -t, --threads <n>                      start <n> threads (default:10)
 [VERSION]
  0.3.4 ge5dee47 2018-12-25 20:39:07 +0100
 [BUGS]
  Please report bugs to steve@bioinf.uni-leipzig.de
 [REFERENCES]
  SEGEMEHL is free software under GPL 
  2008 Bioinformatik Leipzig 
  2018 Computational Biology, Leibniz Institute on Aging (FLI)
```

## segemehl_haarz_split

### Tool Description
Summarize and annotate segemehl split info

### Metadata
- **Docker Image**: biocontainers/segemehl:v0.3.4-1-deb_cv1
- **Homepage**: http://www.bioinf.uni-leipzig.de/Software/segemehl/
- **Package**: https://anaconda.org/channels/bioconda/packages/segemehl/overview
- **Validation**: PASS

### Original Help Text
```text
haarz: required option 'files' (f) missing
usage: haarz -f <file> [<file>] [-m <n>] [-q <f>] 
             [-a <file> [<file>]] [-M <string>] [-A <string>] 
             [-O <string>] 
  Heuristic mapping of short sequences

 [split]                                
 [INPUT]                                
 -f, --files <file> [<file>]            list of path/filename(s) of 
                                        bed files with split info 
                                        (s)
 -m, --minsplit <n>                     minimum total split number 
                                        (all samples) of junction 
                                        (default:5)
 -q, --minqual <f>                      minimum median quality of 
                                        junction 
                                        (default:25.000000)
 -a, --annotationfiles <file> [<file>]  list of path/filename(s) of 
                                        GFF file (s))
 -M, --ovlmode <string>                 annotation mode LARGEST, 
                                        SMALLEST or ALL
 -A, --attributes <string>              attributes that shall be 
                                        selected for overlap 
                                        annotation
 -O, --offsets <string>                 offsets for the annotation
 [VERSION]
  0.3.4 ge5dee47 2018-12-25 20:39:07 +0100
 [BUGS]
  Please report bugs to steve@bioinf.uni-leipzig.de
 [REFERENCES]
  SEGEMEHL is free software under GPL 
  2008 Bioinformatik Leipzig 
  2018 Computational Biology, Leibniz Institute on Aging (FLI)
```

## Metadata
- **Skill**: generated

