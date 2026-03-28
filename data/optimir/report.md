# optimir CWL Generation Report

## optimir_process

### Tool Description
Processes sequencing data to identify and analyze microRNAs.

### Metadata
- **Docker Image**: quay.io/biocontainers/optimir:1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/FlorianThibord/OptimiR
- **Package**: https://anaconda.org/channels/bioconda/packages/optimir/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/optimir/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/FlorianThibord/OptimiR
- **Stars**: N/A
### Original Help Text
```text
usage: optimir process [-h] -i FASTQ [-o OUTDIR] [-g VCF] [--seedLen SEEDLEN]
                       [--w5 WEIGHT5] [--scoreThresh SCORE_THRESH]
                       [--consistentRate INCONSISTENT_THRESHOLD]
                       [--rmTempFiles] [--annot ANNOT_FILES] [--gff_out]
                       [--vcf_out] [--adapt3 ADAPT3] [--adapt5 ADAPT5]
                       [--readMin READMIN] [--readMax READMAX]
                       [--bqThresh BQTHRESH] [--trimAgain]
                       [--maturesFasta MATURES] [--hairpinsFasta HAIRPINS]
                       [--gff3 GFF3] [--quiet] [--cutadapt CUTADAPT]
                       [--bowtie2 BOWTIE2] [--bowtie2_build BOWTIE2_BUILD]
                       [--samtools SAMTOOLS]

optional arguments:
  -h, --help            show this help message and exit
  -i FASTQ, --fq FASTQ  Full path of the sample fastq file (accepted formats
                        and extensions: fastq, fq and fq.gz)
  -o OUTDIR, --dirOutput OUTDIR
                        Full path of the directory where output files are
                        generated [default: ./OptimiR_Results_Dir/]
  -g VCF, --vcf VCF     Full path of the vcf file with genotypes
  --seedLen SEEDLEN     Choose the alignment seed length used in option '-L'
                        by Bowtie2 [default: 17]
  --w5 WEIGHT5          Choose the weight applied on events detected on the 5'
                        end of aligned reads [default: 4]
  --scoreThresh SCORE_THRESH
                        Choose the threshold for alignment score above which
                        alignments are discarded [default: 9]
  --consistentRate INCONSISTENT_THRESHOLD
                        Choose the rate threshold for inconsistent reads
                        mapped to a polymiR above which the alignment is
                        flagged as highly suspicious [default: 0.01]
  --rmTempFiles         Add this option to remove temporary files (trimmed
                        fastq, collapsed fastq, mapped reads, annotated bams
  --annot ANNOT_FILES   Control which annotation file is produced by adding
                        corresponding letter : 'h' for expressed_hairpins, 'p'
                        for polymiRs_table, 'i' for consistency_table, 'c' for
                        remaining_ambiguous, 's' for isomiRs_dist. Ex: '--
                        annot hpics' [default] will produce all of them
  --gff_out             Add this option to generate results in mirGFF3 format
                        [default : disabled]
  --vcf_out             Add this option to generate results in VCF format
                        [default : disabled]
  --adapt3 ADAPT3       Define the 3' adaptor sequence (default is NEB &
                        ILLUMINA: AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -a
                        TGGAATTCTCGGGTGCCAAGG -> hack: use -a to add adapter
                        sequences)
  --adapt5 ADAPT5       Define the 5' adaptor sequence [default: None]
  --readMin READMIN     Define the minimum read length defined with option -m
                        in cutadapt [default: 15]
  --readMax READMAX     Define the maximum read length defined with option -M
                        in cutadapt [default: 27]
  --bqThresh BQTHRESH   Define the Base Quality threshold defined with option
                        -q in cutadapt [default: 28]
  --trimAgain           Add this option to trim files that have been trimmed
                        in a previous application. By default, when temporary
                        files are kept, trimmed files are reused. If you wish
                        to change a paramater used in the trimming step of the
                        workflow, this parameter is a must [default: disabled]
  --maturesFasta MATURES
                        Path to the reference library containing mature miRNAs
                        sequences [default: miRBase 21]
  --hairpinsFasta HAIRPINS
                        Path to the reference library containing pri-miRNAs
                        sequences [default: miRBase 21]
  --gff3 GFF3           Path to the reference library containing miRNAs and
                        pri-miRNAs coordinates [default: miRBase v21, GRCh38
                        coordinates]
  --quiet               Add this option to remove OptimiR progression on
                        screen [default: disabled]
  --cutadapt CUTADAPT   Provide path to the cutadapt binary [default: from
                        $PATH]
  --bowtie2 BOWTIE2     Provide path to the bowtie2 binary [default: from
                        $PATH]
  --bowtie2_build BOWTIE2_BUILD
                        Provide path to the bowtie2 index builder binary
                        [default: from $PATH]
  --samtools SAMTOOLS   Provide path to the samtools binary [default: from
                        $PATH]
```


## optimir_summarize

### Tool Description
Summarize optimir results

### Metadata
- **Docker Image**: quay.io/biocontainers/optimir:1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/FlorianThibord/OptimiR
- **Package**: https://anaconda.org/channels/bioconda/packages/optimir/overview
- **Validation**: PASS

### Original Help Text
```text
usage: optimir summarize [-h] --dir DIR

optional arguments:
  -h, --help  show this help message and exit
  --dir DIR   Full path of the directory containing results
```


## optimir_libprep

### Tool Description
Prepare reference libraries for OptimiR.

### Metadata
- **Docker Image**: quay.io/biocontainers/optimir:1.2--pyh5e36f6f_0
- **Homepage**: https://github.com/FlorianThibord/OptimiR
- **Package**: https://anaconda.org/channels/bioconda/packages/optimir/overview
- **Validation**: PASS

### Original Help Text
```text
usage: optimir libprep [-h] [-v VCF] [--maturesFasta MATURES]
                       [--hairpinsFasta HAIRPINS] [--gff3 GFF3] [-o OUTDIR]
                       [--bowtie2_build BOWTIE2_BUILD]

optional arguments:
  -h, --help            show this help message and exit
  -v VCF, --vcf VCF     Full path of the input VCF file.
  --maturesFasta MATURES
                        Path to the reference library containing mature miRNAs
                        sequences [default: miRBase 21]
  --hairpinsFasta HAIRPINS
                        Path to the reference library containing pri-miRNAs
                        sequences [default: miRBase 21]
  --gff3 GFF3           Path to the reference library containing miRNAs and
                        pri-miRNAs coordinates [default: miRBase v21, GRCh38
                        coordinates]
  -o OUTDIR, --dirOutput OUTDIR
                        Full path of the directory where output files are
                        generated [default: ./OptimiR_Results_Dir/]
  --bowtie2_build BOWTIE2_BUILD
                        Provide path to the bowtie2 index builder binary
                        [default: from $PATH]
```


## Metadata
- **Skill**: generated
