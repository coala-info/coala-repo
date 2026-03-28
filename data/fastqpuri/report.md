# fastqpuri CWL Generation Report

## fastqpuri_Qreport

### Tool Description
Reads in a fq file (gz, bz2, z formats also accepted) and creates a quality report (html file) along with the necessary data to create it stored in binary format.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqpuri:1.0.7--r44hb1d24b7_9
- **Homepage**: https://github.com/jengelmann/FastqPuri
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqpuri/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fastqpuri/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jengelmann/FastqPuri
- **Stars**: N/A
### Original Help Text
```text
Qreport from FastqPuri
Not adequate number of argumentsUsage: ./Qreport -i <INPUT_FILE.fq> -l <READ_LENGTH> 
       -o <OUTPUT_FILE> [-t <NUMBER_OF_TILES>] [-q <MINQ>]
       [-n <#_QUALITY_VALUES>] [-f <FILTER_STATUS>]
       [-0 <ZEROQ>] [-Q <low-Qs>]
Reads in a fq file (gz, bz2, z formats also accepted) and creates a 
quality report (html file) along with the necessary data to create it
stored in binary format.
Options:
 -v Prints package version.
 -h Prints help dialog.
 -i Input file [*fq|*fq.gz|*fq.bz2]. Mandatory option.
 -l Read length. Length of the reads. Mandatory option.
 -o Output file prefix (with NO extension). Mandatory option.
 -t Number of tiles. Optional (default 96). 
 -q Minimum quality allowed. Optional (default 27).
 -n Number of different quality values allowed. Optional (default 46).
 -f Filter status: 0 original file, 1 file filtered with trimFilter, 
    2 file filtered with another tool. Optional (default 0).

 -0 ASCII value for quality score 0. Optional (default 33).
 -Q quality values for low quality proportion plot. Optional (default 27,33,37),
    Format is either <int>[,<int>]* or <min-int>:<max-int>.
File: /opt/conda/conda-bld/fastqpuri_1734159289387/work/src/init_Qreport.c, line: 79
```


## fastqpuri_Sreport

### Tool Description
Uses all *bin files found in a folder (output of Qreport|trimFilter|trimFilterPE) and generates a summary report in html format (of Qreport|trimFilter|trimFilterPE).

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqpuri:1.0.7--r44hb1d24b7_9
- **Homepage**: https://github.com/jengelmann/FastqPuri
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqpuri/overview
- **Validation**: PASS

### Original Help Text
```text
Sreport from FastqPuri
Not adequate number of arguments
Usage: ./Sreport -i <INPUT_FOLDER> -t <Q|F|P> -o <OUTPUT_FILE> 
Uses all *bin files found in a folder (output of Qreport|trimFilter|trimFilterPE)
and generates a summary report in html format (of Qreport|trimFilter|trimFilterPE).
Options:
 -v Prints package version.
 -h Prints help dialog.
 -i Input folder containing *bin data (output from Qreport). Mandatory option.
 -t {Q,F,P} Type of report to be generated: 'Q' for quality summary
     report, 'F' for filter summary report (single-end reads), and 
     'P' for filter summary report (paired-end reads)
    data filter summary report. Mandatory option,
 -o Output file (with NO extension). Mandatory option.

File: /opt/conda/conda-bld/fastqpuri_1734159289387/work/src/init_Sreport.c, line: 71
```


## fastqpuri_makeBloom

### Tool Description
makeBloom from FastqPuri

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqpuri:1.0.7--r44hb1d24b7_9
- **Homepage**: https://github.com/jengelmann/FastqPuri
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqpuri/overview
- **Validation**: PASS

### Original Help Text
```text
makeBloom from FastqPuri
makeBloom: option '--h' is ambiguous; possibilities: '--help' '--hashNum'
makeBloom: option `-?' is invalid: ignored
Usage: ./makeBloom --fasta <FASTA_INPUT> --output <FILTERFILE> --kmersize [KMERSIZE] 
                   (--fal_pos_rate [p] | --hashNum [HASHNUM] | --bfsizeBits [SIZEBITS])
Options: 
 -v, --version      Prints package version.
 -h, --help         Prints help dialog.
 -f, --fasta        Fasta input file. Mandatory option.
 -o, --output       Output file, with NO extension. Mandatory option.
 -k, --kmersize     kmer size, number or elements. Optional(default = 25)
 -p, --fal_pos_rate false positive rate. Optional (default = 0.05)
 -g, --hashNum      number of hash functions used. Optional (default
                    value computed from the false positive rate).
 -m, --bfsizeBits   size of the filter in bits. It will be forced to be
                    a multiple of 8. Optional (default value computed
                    from the false positive rate).
NOTE: the options -p, -g, -m are mutually exclusive. The program 
      will give an error if more than one of them are passed as input.
      It is recommended to pass the false positive rate and let the 
      program compute the other variables (excepting singular situations)
      If none of them are passed, the false positive rate will default
      to 0.05 and the other variables will be computed respecting this
      requirement. See documentation and supplementary material for 
      more details.
File: /opt/conda/conda-bld/fastqpuri_1734159289387/work/src/init_makeBloom.c, line: 141
```


## fastqpuri_makeTree

### Tool Description
Reads a *fa file, constructs a tree of depth DEPTH and saves it compressed in OUTPUT_FILE.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqpuri:1.0.7--r44hb1d24b7_9
- **Homepage**: https://github.com/jengelmann/FastqPuri
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqpuri/overview
- **Validation**: PASS

### Original Help Text
```text
makeTree from FastqPuri
Not adequate number of arguments
Usage: ./makeTree -f|--fasta <FASTA_INPUT> -l|--depth <DEPTH> -o, --output <OUTPUT_FILE>
Reads a *fa file, constructs a tree of depth DEPTH and saves it
compressed in OUTPUT_FILE.
Options: 
 -v, --version Prints package version.
 -h, --help    Prints help dialog.
 -f, --fasta   Fasta input file. Mandatory option.
 -l, --depth depth of the tree structure. Mandatory option. 
 -o, --output Output file. If the extension is not *gz, it is added. Mandatory option.

File: /opt/conda/conda-bld/fastqpuri_1734159289387/work/src/init_makeTree.c, line: 68
```


## fastqpuri_trimFilter

### Tool Description
Reads in a fq file (gz, bz2, z formats also accepted) and removes: low quality reads, reads containing N base callings, reads representing contaminations, belonging to sequences in INPUT.fa

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqpuri:1.0.7--r44hb1d24b7_9
- **Homepage**: https://github.com/jengelmann/FastqPuri
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqpuri/overview
- **Validation**: PASS

### Original Help Text
```text
trimFilter from FastqPuri
Not adequate number of arguments
Usage: trimFilter --ifq <INPUT_FILE.fq> --length <READ_LENGTH> 
                  --output [O_PREFIX] --gzip [y|n]
                  --adapter [<ADAPTERS.fa>:<mismatches>:<score>]
                  --method [TREE|BLOOM] 
                  (--idx [<INDEX_FILE>:<score>:<lmer_len>] |
                   --ifa [<INPUT.fa>:<score>:[lmer_len]])
                  --trimQ [NO|ALL|ENDS|FRAC|ENDSFRAC|GLOBAL]
                  --minL [MINL]  --minQ [MINQ] --zeroQ [ZEROQ]
                  (--percent [percent] | --global [n1:n2])
                  --trimN [NO|ALL|ENDS|STRIP]  
Reads in a fq file (gz, bz2, z formats also accepted) and removes: 
  * low quality reads,
  * reads containing N base callings,
  * reads representing contaminations, belonging to sequences in INPUT.fa
Outputs 4 [O_PREFIX]_fq.gz files containing: "good" reads, discarded 
low Q reads, discarded reads containing N's, discarded contaminations.
Options:
 -v, --version prints package version.
 -h, --help    prints help dialog.
 -f, --ifq     fastq input file [*fq|*fq.gz|*fq.bz2], mandatory option.
 -l, --length  read length: length of the reads, mandatory option.
 -o, --output  output prefix (with path), optional (default ./out).
 -z, --gzip    gzip output files: yes or no (default yes)
 -A, --adapter adapter input. Three fields separated by colons:
               <ADAPTERS.fa>: fasta file containing adapters,
               <mismatches>: maximum mismatch count allowed,
               <score>: score threshold  for the aligner.
 -x, --idx     index input file. To be included with methods to remove.
               contaminations (TREE, BLOOM). 3 fields separated by colons: 
               <INDEX_FILE>: output of makeTree, makeBloom,
               <score>: score threshold to accept a match [0,1],
               [lmer_len]: the length of the lmers to be 
                        looked for in the reads [1,READ_LENGTH].
 -a, --ifa     fasta input file of potential contaminations.
               To be included only with method TREE
               (it excludes the option --idx). Otherwise, an
               index file has to be precomputed and given as parameter
               (see option --idx). 3 fields separated by colons: 
               <INPUT.fa>: fasta input file [*fa|*fa.gz|*fa.bz2],
               <score>: score threshold to accept a match [0,1],
               <lmer_len>: depth of the tree: [1,READ_LENGTH]. 
                        Corresponds to the length of the lmers to be 
                        looked for in the reads.
 -C, --method  method used to look for contaminations: 
               TREE:  uses a 4-ary tree. Index file optional,
               BLOOM: uses a bloom filter. Index file mandatory.
 -Q, --trimQ   NO:       does nothing to low quality reads (default),
               ALL:      removes all reads containing at least one low
                         quality nucleotide.
               ENDS:     trims the ends of the read if their quality is
                         below the threshold -q,
               FRAC:     discards a read if the fraction of bases with
                         low quality scores (below -q) is over 5 percent
                         or a user defined percentage (-p).
               ENDSFRAC: trims the ends and then discards the read if 
                         there are more low quality nucleotides than 
                         allowed by the option -p.
               GLOBAL:   removes n1 bases on the left and n2 on the 
                         right, specified in -g.
               All reads are discarded if they are shorter than MINL
               (specified with -m or --minL).
 -m, --minL    minimum length allowed for a read before it is discarded
               (default 25).
 -q, --minQ    minimum quality allowed (int), optional (default 27).
 -0, --zeroQ   value of ASCII character representing zero quality (int), optional (default 33).
 -p, --percent percentage of low quality bases tolerated before 
               discarding a read (default 5), 
 -g, --global  required option if --trimQ GLOBAL is passed. Two int,
               n1:n2, have to be passed specifying the number of bases 
               to be globally cut from the left and right, respectively.
 -N, --trimN   NO:     does nothing to reads containing N's,
               ALL:    removes all reads containing N's,
               ENDS:   trims ends of reads with N's,
               STRIPS: looks for the largest substring with no N's.
               All reads are discarded if they are shorter than the
               sequence length specified by -m/--minL.
File: /opt/conda/conda-bld/fastqpuri_1734159289387/work/src/init_trimFilter.c, line: 133
```


## fastqpuri_trimFilterPE

### Tool Description
Reads in paired end fq files (gz, bz2, z formats also accepted) and removes: low quality reads, reads containing N base callings, reads representing contaminations, belonging to sequences in INPUT.fa. Outputs 8 [O_PREFIX][1|2]_fq.gz files containing: "good" reads, discarded low Q reads, discarded reads containing N's, discarded contaminations.

### Metadata
- **Docker Image**: quay.io/biocontainers/fastqpuri:1.0.7--r44hb1d24b7_9
- **Homepage**: https://github.com/jengelmann/FastqPuri
- **Package**: https://anaconda.org/channels/bioconda/packages/fastqpuri/overview
- **Validation**: PASS

### Original Help Text
```text
trimFilterPE from FastqPuri
Not an adequate number of arguments
Usage: trimFilterPE --ifq <INPUT1.fq>:<INPUT2.fq> --length <READ_LENGTH> 
                  --output [O_PREFIX] --gzip [y|n]
                  --adapter [<AD1.fa>:<AD2.fa>:<mismatches>:<score>]
                  --method [TREE|BLOOM] 
                  (--idx [<INDEX_FILE>:<score>:<lmer_len>] |
                   --ifa [<INPUT.fa>:<score>:[lmer_len]])
                  --trimQ [NO|ALL|ENDS|FRAC|ENDSFRAC|GLOBAL]
                  --minL [MINL]  --minQ [MINQ]  --zeroQ [ZEROQ]
                  (--percent [percent] | --global [n1:n2])
                  --trimN [NO|ALL|ENDS|STRIP]  
Reads in paired end fq files (gz, bz2, z formats also accepted) and removes:
  * low quality reads,
  * reads containing N base callings,
  * reads representing contaminations, belonging to sequences in INPUT.fa.
Outputs 8 [O_PREFIX][1|2]_fq.gz files containing: "good" reads, discarded 
low Q reads, discarded reads containing N's, discarded contaminations.
Options:
 -v, --version prints package version.
 -h, --help    prints help dialog.
 -f, --ifq     2 fastq input files [*fq|*fq.gz|*fq.bz2] separated by
               colons, mandatory option.
 -l, --length  read length: length of the reads, mandatory option.
 -o, --output  output prefix (with path), optional (default ./out).
 -z, --gzip    gzip output files: yes or no (default yes)
 -A, --adapter adapter input. Four fields separated by colons:
               <AD1.fa>: fasta file containing adapters,
               <AD2.fa>: fasta file containing adapters,
               <mismatches>: maximum mismatch count allowed,
               <score>: score threshold  for the aligner.
 -x, --idx     index input file. To be included with any methods to remove.
               contaminations (TREE, BLOOM). 3 fields separated by colons: 
               <INDEX_FILE>: output of makeTree, makeBloom,
               <score>: score threshold to accept a match [0,1],
               [lmer_len]: the length of the lmers to be 
                        looked for in the reads [1,READ_LENGTH].
 -a, --ifa     fasta input file of potential contaminations.
               To be included only with method TREE
               (it excludes the option --idx). Otherwise, an
               index file has to be precomputed and given as parameter
               (see option --idx). 3 fields separated by colons: 
               <INPUT.fa>: fasta input file [*fa|*fa.gz|*fa.bz2],
               <score>: score threshold to accept a match [0,1],
               <lmer_len>: depth of the tree: [1,READ_LENGTH]. 
                        Corresponds to the length of the lmers to be 
                        looked for in the reads.
 -C, --method  method used to look for contaminations: 
               TREE:  uses a 4-ary tree. Index file optional,
               BLOOM: uses a bloom filter. Index file mandatory.
 -Q, --trimQ   NO:       does nothing to low quality reads (default),
               ALL:      removes all reads containing at least one low
                         quality nucleotide.
               ENDS:     trims the ends of the read if their quality is
                         below the threshold -q,
               FRAC:     discards a read if the fraction of bases with
                         low quality scores (below -q) is over 5 percent 
                         or a user defined percentage (-p). 
               ENDSFRAC: trims the ends and then discards the read if 
                         there are more low quality nucleotides than 
                         allowed by the option -p.
               GLOBAL:   removes n1 cycles on the left and n2 on the 
                         right, specified in -g.
               All reads are discarded if they are shorter than MINL
               (specified with -m or --minL).
  -m, --minL    minimum length allowed for a read before it is discarded
               (default 25).
 -q, --minQ    minimum quality allowed (int), optional (default 27).
 -0, --zeroQ   value of ASCII character representing zero quality (int), optional (default 33)
 -p, --percent percentage of low quality bases tolerated before 
               discarding a read (default 5), 
 -g, --global  required option if --trimQ GLOBAL is passed. Two int,
               n1:n2, have to be passed specifying the number of bases 
               to be globally cut from the left and right, respectively.
 -N, --trimN   NO:     does nothing to reads containing N's,
               ALL:    removes all reads containing N's,
               ENDS:   trims ends of reads with N's,
               STRIPS: looks for the largest substring with no N's.
               All reads are discarded if they are shorter than the
               sequence length specified by -m/--minL.
File: /opt/conda/conda-bld/fastqpuri_1734159289387/work/src/init_trimFilterDS.c, line: 136
```


## Metadata
- **Skill**: generated
