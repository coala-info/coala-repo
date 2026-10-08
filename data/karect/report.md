# karect CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| karect_align | PASS | Rewritten from the help; aligned 200 nf-core SARS-CoV-2 reads to the genome. |
| karect_correct | PASS | Rewritten from the help (old file ran bare karect); corrected nf-core SARS-CoV-2 Illumina pairs, eval shows 34 bases fixed and 0 wrongly changed. |
| karect_eval | PASS | Rewritten from the help; evaluation of karect_correct output reports 100% precision with plausible recall. |
| karect_merge | PASS | Rewritten from the help; -paired interlaced the two nf-core FASTQ files into 200 reads in /1 /2 order. |

## karect_correct

### Tool Description
Correct substitution, insertion and deletion errors in assembly reads from fasta/fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/karect:1.0--h9948957_9
- **Homepage**: https://github.com/aminallam/karect
- **Package**: https://anaconda.org/channels/bioconda/packages/karect/overview
- **Validation**: PASS

### Original Help Text
```text
-Run "karect -correct [options_list]" for the error correction tool.
-Available options: (i=integer, d=decimal, f=file, s=directory)
-Essential options:
  "-inputfile=f":      Specify an input fasta/fastq file. This option can be repeated for multiple files
  "-celltype=[haploid|diploid]": Specify the cell type. Use "haploid" for bacteria and viruses.
  "-matchtype=[edit|hamming|insdel]": Specify the matching type. "hamming" allows substitution errors only.
                         "edit" allows insertions, deletion, and substitutions with equal costs.
                         "insdel" is the same as "edit", but the cost of substitutions is doubled.
                         Use "hamming" for Illumina datasets, and "edit" for 454 datasets.
-Basic options:
  "-inputdir=s":       Specify the input directory. Ignored if input file paths are complete [Default=.].
  "-resultdir=s":      Specify a directory to save result file(s) [Default=.].
  "-resultprefix=s":   Specify a prefix string to the result file(s) [Default=karect_].
  "-tempdir=s":        Specify a directory to save temporary output files [Default=.].
  "-threads=i":        Specify the number of threads [Default=16].
  "-memory=d":         Specify an upper bound on the memory that can be used in gigabytes [Default=10240.0].
-Advanced options:
  "-aggressive=d":     Specify the aggressiveness towards error correction [Default=0.42].
  "-numstages=i":      Specify the number of stages (1 or 2) [Default=1].
  "-minoverlap=i":     Specify the minimum overlap size [Default=35].
  "-minoverlapper=d":  Specify the minimum overlap percentage [Default=0.20].
  "-minreadweigth=d":  Specify the minimum read weight [Default=0].
  "-errorrate=d":      Specify the first stage maximum allowed error rate [Default=0.25].
  "-errorratesec=d":   Specify the second stage maximum allowed error rate [Default=0.25].
  "-reserveval=d":     Specify the minimum reservation value [Default=100.0].
  "-estcov=[yes|no]":  Estimate coverage and use it to adjust the minimum reservation value [Default=yes].
  "-usequal=[yes|no]": Use quality values of candidate reads [Default=yes].
  "-higherror":        Work in high error rate mode (error rate = 0.50).
  "-trimfact=d":       Specify the trimming factor [Default=2.5].
  "-reserveper=d":     Specify the minimum reservation percentage [Default=1.0].
  "-kmer=i":           Specify the minimum kmer size (will increase according to '-kmerfactor') [Default=9].
  "-trim=[yes|no]":    Allow/Disallow trimming. Do not allow trimming if evaluating results afterwards, or
                         if you will pass results to an assembler which expects fixed read sizes [Default=no].
-More advanced options:
  "-maxlenmatches=i":  Specify the maximum number of expected alignment computations (millions) [Default=2000].
  "-maxkmerslots=i":   Specify the maximum number kmer slots to be used [Default=100,000].
  "-kmerfactor=i":     Specify the factor f such that 4^kmersize > total_num_kmers/f [Default=1000].
  "-maxkmerres=i":     Specify the maximum number kmer results to be used [Default=30].
  "-kmererrors=i":     Specify the maximum allowed kmer errors (0,1,2) [Default=2].
  "-readsperstep=i":   Specify the maximum number of processed reads per step [Default=1000].
  "-fbs=i":            Specify file block size in megabytes [Default=10].
  "-cbs=i":            Specify cache block size in megabytes [Default=128].
-Example:
        ./karect -correct -inputdir=/sra_data -inputfile=SRR001666_1.fasta -inputfile=SRR001666_2.fasta
              -resultprefix=karect_r1_ -celltype=haploid -matchtype=hamming -errorrate=0.25 -threads=12
```


## karect_align

### Tool Description
Align original assembly reads to a reference genome as pre-processing for evaluation.

### Metadata
- **Docker Image**: quay.io/biocontainers/karect:1.0--h9948957_9
- **Homepage**: https://github.com/aminallam/karect
- **Package**: https://anaconda.org/channels/bioconda/packages/karect/overview
- **Validation**: PASS

### Original Help Text
```text
-Run "karect -align [options_list]" for the alignment tool.
-Available options: (i=integer, f=file, s=directory)
-Essential options:
  "-matchtype=[edit|hamming|insdel]": Specify the matching type. "hamming" allows substitution errors only.
                        "edit" allows insertions, deletion, and substitutions with equal costs.
                        "insdel" is the same as "edit", but the cost of substitutions is doubled.
  "-inputfile=f":     Specify an input fasta/fastq file. This option can be repeated for multiple files.
  "-refgenomefile=f": Specify the file containing the reference genome (to be aligned with).
  "-alignfile=f":     Specify the output alignment file.
-Basic options:
  "-inputdir=s":      Specify the input directory. Ignored if input file paths are complete [Default=.].
  "-threads=i":       Specify the number of threads [Default=16].
-Advanced options:
  "-circular=i":      Specify the sequence size to be appended circularly (for circular genomes) [Default=0].
  "-accuracy=i":      Specify the alignment accuracy [Default=5].
  "-readsperstep=i":  Specify the maximum number of processed reads per step [Default=1000].
-Example:
        ./karect -align -inputdir=/sra_data -inputfile=SRR001666_1.fasta -inputfile=SRR001666_2.fasta
              -refgenomefile=NC_000913.fna -alignfile=./SRR001666_align.txt -matchtype=hamming -threads=12
```


## karect_eval

### Tool Description
Evaluate assembly read correction against a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/karect:1.0--h9948957_9
- **Homepage**: https://github.com/aminallam/karect
- **Package**: https://anaconda.org/channels/bioconda/packages/karect/overview
- **Validation**: PASS

### Original Help Text
```text
-Run "karect -eval [options_list]" for the evaluation tool.
-Available options: (i=integer, f=file, s=directory)
-Essential options:
  "-matchtype=[edit|hamming|insdel]": Specify the matching type. "hamming" allows substitution errors only.
                        "edit" allows insertions, deletion, and substitutions with equal costs.
                        "insdel" is the same as "edit", but the cost of substitutions is doubled.
  "-inputfile=f":     Specify an input fasta/fastq file. This option can be repeated for multiple files.
  "-resultfile=f":    Specify a result fasta/fastq file (resulting from running "karect -correct",
                        or any other correction tool). This option can be repeated for multiple files.
  "-refgenomefile=f": Specify the file containing the reference genome (to be aligned with).
  "-alignfile=f":     Specify the alignment file resulted from running "karect -align".
  "-evalfile=f":      Specify the output evaluation file.
-Basic options:
  "-inputdir=s":      Specify the input files directory. Ignored if file paths are complete [Default=.].
  "-resultdir=s":     Specify the result files directory. Ignored if file paths are complete [Default=.].
  "-threads=i":       Specify the number of threads [Default=16].
-Advanced options:
  "-circular=i":      Specify the sequence size to be appended circularly (for circular genomes) [Default=0].
  "-readsperstep=i":  Specify the maximum number of processed reads per step [Default=1000].
-Experimental options:
  "-trim=[yes|no]":   Allow/Disallow trimming. Allow trimming if you used "-trim=yes" while correction,
                        however, in this case the evaluation results are experimental [Default=no].
-Example:
        ./karect -eval -inputdir=/sra_data -inputfile=SRR001666_1.fasta -inputfile=SRR001666_2.fasta
              -resultdir=/results -resultfile=karect_SRR001666_1.fasta -resultfile=karect_SRR001666_2.fasta
              -refgenomefile=NC_000913.fna -alignfile=./SRR001666_align.txt -evalfile=./SRR001666_eval.txt
              -matchtype=hamming -threads=12
```


## karect_merge

### Tool Description
Concatenate, interlace, split or convert fasta/fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/karect:1.0--h9948957_9
- **Homepage**: https://github.com/aminallam/karect
- **Package**: https://anaconda.org/channels/bioconda/packages/karect/overview
- **Validation**: PASS

### Original Help Text
```text
-Run "karect -merge [options_list]" for the merge tool.
-Available options: (i=integer, c=char, f=file, s=directory)
-Essential options:
  "-inputfile=f":   Specify an input fasta/fastq file. This option can be repeated for multiple files.
  "-mergedfile=f":  Specify the output file.
-Basic options:
  "-inputdir=s":    Specify the files directory. Ignored if file paths are complete [Default=.].
  "-paired":        Interlace two paired-end or mate-pairs files.
  "-sample=i":      Reserve only sample/1000 of reads [Default=1000].
  "-oneseq":        Concatenate all sequences into one sequence (works with fasta only).
  "-noqualinfo":    Do not write fastq quality information line (write only +).
-Advanced options:
  "-unknownchar=c": Specify the character to be put instead of unknown characters
                      (known characters are "ACGTacgt") [Default: do not change unknown characters].
  "-outfasta":      Output fasta file [Default: output file type is the same as input file type].
  "-outfastq":      Output fastq file [Default: output file type is the same as input file type].
  "-outqual":       Output separate quality file.
  "-adjustqual":    Do not allow "@" to exist as the first quality score for any read.
  "-hshrec":        Concatenate HSHREC output files.
  "-quake":         Concatenate Quake output files.
  "-fastaqual":     Merge fasta and qual files into fastq.
  "-replaceinfo":   Replace info lines of the second file using the ones of the first file.
  "-splitpaired":   Split into two files: fragment, paired.
  "-splitpairs":    Split interlaced pairs into two files: pair1, pair2.
  "-outpairids":    Output pair IDs file to be used by celera.
-Example:
        ./karect -merge -inputdir=/sra_data -inputfile=SRR001666_1.fasta -inputfile=SRR001666_2.fasta
              -mergedfile=./SRR001666_all.fasta
```


## Metadata
- **Skill**: generated
