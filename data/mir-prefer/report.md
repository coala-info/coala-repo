# mir-prefer CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mir-prefer_bowtie-align-reads.py | PASS | new CWL; 3000 real miR-PREFeR example reads all aligned back to their original positions on Arabidopsis chr1; note: -p 2 hangs in this image, single thread works |
| mir-prefer_convert-mirdeep2-fasta.py | PASS | new CWL; collapsed fasta derived from the same real reads; read ids renamed to sample_rA_xN with counts kept (10000 total) |
| mir-prefer_convert-readcount-file.py | PASS | new CWL; read count file derived from the same real reads; converted with counts kept (10000 total) |
| mir-prefer_miR_PREFeR.py | Failed | image problem: samtools in the image cannot load libncurses.so.5, so the pipeline stops at its first samtools call; real Arabidopsis example data staged correctly |
| mir-prefer_process-reads-fasta.py | PASS | new CWL; real small RNA reads (nf-core smrnaseq) collapsed to 7782 unique reads with counts summing to 10000 |

## mir-prefer_miR_PREFeR.py

### Tool Description
miR-PREFeR is a tool for predicting miRNAs.

### Metadata
- **Docker Image**: quay.io/biocontainers/mir-prefer:0.24--py27_0
- **Homepage**: https://github.com/hangelwen/miR-PREFeR
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mir-prefer/overview
- **Total Downloads**: 10.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hangelwen/miR-PREFeR
- **Stars**: N/A
### Original Help Text
```text
Usage: python mir_PREFeR.py [options] command configfile

    command could be one of the following:
    check = Check the dependency and the config file only (default).
    prepare = Prepare data.
    candidate = Generate candidate regions.
    fold = Fold the candidate regions.
    predict = Predict miRNAs.
    pipeline = Run the whole pipeline. This is the same as running 'check', 'prepare', 'candidate', 'fold', and 'predict' sequentially.
    recover = Recover a unfinished job. By default, miR-PREFeR makes checkpoint of the results of each stage. Thus, an unfinished job can be started from where it was checkpointed to save time.

configfile: configuration file

Options:
  -h, --help            show this help message and exit
  -L, --log             Generate a log file.
  -k, --keep-tmp        After finish the whole pipeline, do not remove the
                        temporary folder that contains the intermidate files.
  -d, --output-detail-for-debug
```

## mir-prefer_process-reads-fasta.py

### Tool Description
Pre-process uncollapsed read FASTA files: collapse identical reads and rename them SampleName_rA_xB

### Metadata
- **Docker Image**: quay.io/biocontainers/mir-prefer:0.24--py27_0
- **Homepage**: https://github.com/hangelwen/miR-PREFeR
- **Package**: https://anaconda.org/channels/bioconda/packages/mir-prefer/overview
- **Validation**: PASS

### Original Help Text
```text
========================================================================================= 
Pre-processing RNAseq fasta files
Please make sure the input fasta files are uncollpased fasta files.
Please make sure the sequence of each read only has one line in the input file.
The output files are in the same folders as the input files, with suffix '.processed'. 
========================================================================================= 
Usage: python preocess-reads-fasta.py <samplenamelist> <fasta1> <fasta2> .. <fastaN>
```

## mir-prefer_convert-mirdeep2-fasta.py

### Tool Description
Convert collapsed miRDeep2-format read FASTA files to the miR-PREFeR read format

### Metadata
- **Docker Image**: quay.io/biocontainers/mir-prefer:0.24--py27_0
- **Homepage**: https://github.com/hangelwen/miR-PREFeR
- **Package**: https://anaconda.org/channels/bioconda/packages/mir-prefer/overview
- **Validation**: PASS

### Original Help Text
```text
========================================================================================= 
Pre-processing RNAseq fasta files (mirdeep2 format).
Please make sure the sequence of each read only has one line in the input file.
The output files are in the same folders as the input files, with suffix '.processed'. 
========================================================================================= 
Usage: python process-reads-fasta.py <samplenamelist> <fasta1> <fasta2> .. <fastaN>
```

## mir-prefer_convert-readcount-file.py

### Tool Description
Convert read count files (sequence and depth per line) to the miR-PREFeR read format

### Metadata
- **Docker Image**: quay.io/biocontainers/mir-prefer:0.24--py27_0
- **Homepage**: https://github.com/hangelwen/miR-PREFeR
- **Package**: https://anaconda.org/channels/bioconda/packages/mir-prefer/overview
- **Validation**: PASS

### Original Help Text
```text
========================================================================================= 
Pre-processing read-count format files.
The output files are in the same folders as the input files, with suffix '.processed'. 
========================================================================================= 
Usage: python process-reads-fasta.py <samplenamelist> <rc1> <rc2> .. <rcN>
```

## mir-prefer_bowtie-align-reads.py

### Tool Description
Align collapsed small RNA reads to a genome with bowtie and write SAM files for miR-PREFeR

### Metadata
- **Docker Image**: quay.io/biocontainers/mir-prefer:0.24--py27_0
- **Homepage**: https://github.com/hangelwen/miR-PREFeR
- **Package**: https://anaconda.org/channels/bioconda/packages/mir-prefer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: python bowtie-align-reads.py [options] <fasta1> ... <fastaN>

    Align fasta format reads to genome using bowtie.

    The input fasta format should follow the output of
    'process-reads-fasta.py'. That is, the read should be collapsed; the read ID
    must be in format of 'samplename_rA_xN'. Here samplename is the name of the
    sample from with small RNASeq library came from, 'A' is an unique number to
    identify the read, 'N' is the depth of the read.

    The output of the script are SAM format alignment files, which can be then used
    in mir_PREFeR.py to do miRNA prediction. The output are in the same folder as
    the input files, with suffix ".sam".

    NOTE: Pair-end reads are not supported currently. Not all bowtie options are
    exposed in the script. To use more bowtie options, please use bowtie
    directly to align the reads.

    To use the script:
    python bowtie-align-reads.py [options] <read fasta1> ... <read fastaN>

    Example:
    python bowtie-align-reads.py -p 2 -k 20 -f -r TAIR10.fa SAMPLE1.fa.processed

    This command maps reads in SAMPLE1.fa.processed to TAIR10.fa using two
    threads (-p). Reads that mapped to more than 20 positions are not
    reported (-k). Unmapped alignments are filtered using SAMtools (-f), this
    will reduce the size of the SAM file and can speed up the running time
    of miR-PREFeR, so it's recommended.

    To see the available options, using:
    python bowtie-align-reads.py -h

    

Options:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference=REFERENCE
                        Reference genome in fasta format. If you have multiple
                        reference files, please use multipe -r options. If you
                        have aready index the reference sequences, you should
                        use the -i option.
  -i INDEX, --index=INDEX
                        Use the supplied bowtie index file, instead of
                        indexing the genome in the script.
                        If your genome index files are in folder
                        /user/home/index, with names TAIR10.1.ebwt,
                        TAIR10.2.ebwt, etc, you must use -i
                        /user/home/index/TAIR10 for the -i option.
  -t TEMP, --temp=TEMP  Temporary folder to hold the bowtie index files. If
                        not supplied, the current directory is used. Only used
                        with -r.
  -v ALLOWEDMISMATCH, --allowedmismatch=ALLOWEDMISMATCH
                        -v option in bowtie. Number of mismatches allowed.
                        Default is 0.
  -k MULTIALIGNMENT, --multialignment=MULTIALIGNMENT
                        -k option in bowtie.  Report up to <int> vaild
                        alignment. Default is 20.
  -p PROCESSOR, --processor=PROCESSOR
                        Use multiple threads to do alignment.
  -f, --filterunmapped  Filter out unmapped alignments in the output.
```
