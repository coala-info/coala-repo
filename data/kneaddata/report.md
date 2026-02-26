# kneaddata CWL Generation Report

## kneaddata

### Tool Description
KneadData

### Metadata
- **Docker Image**: quay.io/biocontainers/kneaddata:0.12.4--pyhdfd78af_0
- **Homepage**: https://huttenhower.sph.harvard.edu/kneaddata
- **Package**: https://anaconda.org/channels/bioconda/packages/kneaddata/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kneaddata/overview
- **Total Downloads**: 49.1K
- **Last updated**: 2025-11-26
- **GitHub**: https://github.com/biobakery/kneaddata
- **Stars**: N/A
### Original Help Text
```text
usage: kneaddata [-h] [--version] [-v] [-i1 INPUT1] [-i2 INPUT2]
                 [-un UNPAIRED] -o OUTPUT_DIR [-s SCRATCH_DIR]
                 [-db REFERENCE_DB] [--bypass-trim]
                 [--output-prefix OUTPUT_PREFIX] [-t <1>] [-p <1>]
                 [-q {phred33,phred64}] [--run-bmtagger] [--bypass-trf]
                 [--run-trf] [--run-fastqc-start] [--run-fastqc-end]
                 [--store-temp-output] [--remove-intermediate-output]
                 [--cat-final-output]
                 [--log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}] [--log LOG]
                 [--trimmomatic TRIMMOMATIC_PATH] [--run-trim-repetitive]
                 [--max-memory MAX_MEMORY]
                 [--trimmomatic-options TRIMMOMATIC_OPTIONS]
                 [--sequencer-source {NexteraPE,TruSeq2,TruSeq3,none}]
                 [--bowtie2 BOWTIE2_PATH] [--bowtie2-options BOWTIE2_OPTIONS]
                 [--decontaminate-pairs {strict,lenient,unpaired}] [--reorder]
                 [--serial] [--bmtagger BMTAGGER_PATH] [--trf TRF_PATH]
                 [--match MATCH] [--mismatch MISMATCH] [--delta DELTA]
                 [--pm PM] [--pi PI] [--minscore MINSCORE]
                 [--maxperiod MAXPERIOD] [--fastqc FASTQC_PATH]

KneadData

options:
  -h, --help            show this help message and exit
  -v, --verbose         additional output is printed

global options:
  --version             show program's version number and exit
  -i1, --input1 INPUT1  Pair 1 input FASTQ file
  -i2, --input2 INPUT2  Pair 2 input FASTQ file
  -un, --unpaired UNPAIRED
                        unparied input FASTQ file
  -o, --output OUTPUT_DIR
                        directory to write output files
  -s, --scratch SCRATCH_DIR
                        directory to write temp files
  -db, --reference-db REFERENCE_DB
                        location of reference database (additional arguments add databases)
  --bypass-trim         bypass the trim step
  --output-prefix OUTPUT_PREFIX
                        prefix for all output files
                        [ DEFAULT : $SAMPLE_kneaddata ]
  -t, --threads <1>     number of threads
                        [ Default : 1 ]
  -p, --processes <1>   number of processes
                        [ Default : 1 ]
  -q, --quality-scores {phred33,phred64}
                        quality scores
                        [ DEFAULT : phred33 ]
  --run-bmtagger        run BMTagger instead of Bowtie2 to identify contaminant reads
  --bypass-trf          option to bypass the removal of tandem repeats
  --run-trf             legacy option to run the removal of tandem repeats (now run by default)
  --run-fastqc-start    run fastqc at the beginning of the workflow
  --run-fastqc-end      run fastqc at the end of the workflow
  --store-temp-output   store temp output files
                        [ DEFAULT : temp output files are removed ]
  --remove-intermediate-output
                        remove intermediate output files
                        [ DEFAULT : intermediate output files are stored ]
  --cat-final-output    concatenate all final output files
                        [ DEFAULT : final output is not concatenated ]
  --log-level {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        level of log messages
                        [ DEFAULT : DEBUG ]
  --log LOG             log file
                        [ DEFAULT : $OUTPUT_DIR/$SAMPLE_kneaddata.log ]

trimmomatic arguments:
  --trimmomatic TRIMMOMATIC_PATH
                        path to trimmomatic
                        [ DEFAULT : $PATH ]
  --run-trim-repetitive
                        Trim fastqc generated overrepresented sequences
  --max-memory MAX_MEMORY
                        max amount of memory
                        [ DEFAULT : 500m ]
  --trimmomatic-options TRIMMOMATIC_OPTIONS
                        options for trimmomatic
                        [ DEFAULT : MINLEN:60 ILLUMINACLIP:/-SE.fa:2:30:10 SLIDINGWINDOW:4:20 MINLEN:50 ]
                        MINLEN is set to 50 percent of total input read length. The user can alternatively specify a length (in bases) for MINLEN.
  --sequencer-source {NexteraPE,TruSeq2,TruSeq3,none}
                        options for sequencer-source
                        [ DEFAULT : NexteraPE]

bowtie2 arguments:
  --bowtie2 BOWTIE2_PATH
                        path to bowtie2
                        [ DEFAULT : $PATH ]
  --bowtie2-options BOWTIE2_OPTIONS
                        options for bowtie2
                        [ DEFAULT : --very-sensitive-local ]
  --decontaminate-pairs {strict,lenient,unpaired}
                        options for filtering of paired end reads (strict='remove both R1+R2 if either align', lenient='remove only if both R1+R2 align', unpaired='ignore pairing and remove as single end')
                        [ DEFAULT : strict ]
  --reorder             order the sequences in the same order as the input
                        [ DEFAULT : Sequences are not ordered ]
  --serial              filter the input in serial for multiple databases so a subset of reads are processed in each database search (the default when running with a single process)

bmtagger arguments:
  --bmtagger BMTAGGER_PATH
                        path to BMTagger
                        [ DEFAULT : $PATH ]

trf arguments:
  --trf TRF_PATH        path to TRF
                        [ DEFAULT : $PATH ]
  --match MATCH         matching weight
                        [ DEFAULT : 2 ]
  --mismatch MISMATCH   mismatching penalty
                        [ DEFAULT : 7 ]
  --delta DELTA         indel penalty
                        [ DEFAULT : 7 ]
  --pm PM               match probability
                        [ DEFAULT : 80 ]
  --pi PI               indel probability
                        [ DEFAULT : 10 ]
  --minscore MINSCORE   minimum alignment score to report
                        [ DEFAULT : 50 ]
  --maxperiod MAXPERIOD
                        maximum period size to report
                        [ DEFAULT : 500 ]

fastqc arguments:
  --fastqc FASTQC_PATH  path to fastqc
                        [ DEFAULT : $PATH ]
```

