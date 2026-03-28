# callingcardstools CWL Generation Report

## callingcardstools_barcode_table_to_json

### Tool Description
Converts a barcode table to JSON format.

### Metadata
- **Docker Image**: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/cmatKhan/callingCardsTools
- **Package**: https://anaconda.org/channels/bioconda/packages/callingcardstools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/callingcardstools/overview
- **Total Downloads**: 11.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cmatKhan/callingCardsTools
- **Stars**: N/A
### Original Help Text
```text
usage: barcode_table_to_json [-h] [-l {critical,error,warning,info,debug}] -t
                             BARCODE_TABLE -r BATCH

optional arguments:
  -h, --help            show this help message and exit
  -t BARCODE_TABLE, --barcode_table BARCODE_TABLE
                        old pipeline barcode table
  -r BATCH, --batch BATCH
                        batch name, eg the run number like run_1234

General:
  -l {critical,error,warning,info,debug}, --log_level {critical,error,warning,info,debug}
```


## callingcardstools_legacy_split_fastq

### Tool Description
Splits paired-end FASTQ files based on barcodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/cmatKhan/callingCardsTools
- **Package**: https://anaconda.org/channels/bioconda/packages/callingcardstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: legacy_split_fastq [-h] [-l {critical,error,warning,info,debug}] -r1
                          READ1 -r2 READ2 [-b BARCODEFILE] [-o OUTPUT]
                          [--hammp HAMMP] [--hammt HAMMT]

optional arguments:
  -h, --help            show this help message and exit
  -r1 READ1, --read1 READ1
                        Read 1 filename (full path)
  -r2 READ2, --read2 READ2
                        Read2 filename (full path)
  -b BARCODEFILE, --barcodefile BARCODEFILE
                        barcode filename (full path)
  -o OUTPUT, --output OUTPUT
                        path to output directory
  --hammp HAMMP         Primer barcode hamming distance
  --hammt HAMMT         Transposon barcode hamming distance

General:
  -l {critical,error,warning,info,debug}, --log_level {critical,error,warning,info,debug}
```


## callingcardstools_legacy_makeccf

### Tool Description
Converts alignment files to calling card format.

### Metadata
- **Docker Image**: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/cmatKhan/callingCardsTools
- **Package**: https://anaconda.org/channels/bioconda/packages/callingcardstools/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/callingcardstools", line 10, in <module>
    sys.exit(__main__.main())
  File "/usr/local/lib/python3.9/site-packages/callingcardstools/__main__.py", line 179, in main
    args.func(args)
  File "/usr/local/lib/python3.9/site-packages/callingcardstools/Alignment/yeast/legacy_makeccf.py", line 164, in main
    if not args.outputpath[-1] == "/":
TypeError: 'NoneType' object is not subscriptable
```


## callingcardstools_split_fastq

### Tool Description
Splits fastq files based on barcode details.

### Metadata
- **Docker Image**: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/cmatKhan/callingCardsTools
- **Package**: https://anaconda.org/channels/bioconda/packages/callingcardstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: split_fastq [-h] [-l {critical,error,warning,info,debug}] -r1 READ1 -r2
                   READ2 -b BARCODE_DETAILS [-s SPLIT_KEY] [-n SPLIT_SUFFIX]
                   [-o OUTPUT_DIRPATH] [-v] [-p]

optional arguments:
  -h, --help            show this help message and exit
  -r1 READ1, --read1 READ1
                        Read 1 filename (full path)
  -r2 READ2, --read2 READ2
                        Read2 filename (full path)
  -b BARCODE_DETAILS, --barcode_details BARCODE_DETAILS
                        barcode filename (full path)
  -s SPLIT_KEY, --split_key SPLIT_KEY
                        Either a name of a key in
                        barcode_details['components'], or just a string. This
                        will be used to create the passing output fastq
                        filenames. Defaults to 'tf' which is appropriate for
                        yeast data
  -n SPLIT_SUFFIX, --split_suffix SPLIT_SUFFIX
                        append this after the tf name and before _R1.fq in the
                        output fastq files. Defaults to "split"
  -o OUTPUT_DIRPATH, --output_dirpath OUTPUT_DIRPATH
                        a path to a directory where the output files will be
                        output. Defaults to the current directory
  -v, --verbose_qc      set this flag to output a file which contains the
                        barcode components for each read ID in the fastq files
                        associated with its barcode components
  -p, --pickle_qc       set this flag to output a pickle file which containing
                        the BarcodeQcCounter object. This is useful when
                        splitting the fastq files prior to demultiplexing

General:
  -l {critical,error,warning,info,debug}, --log_level {critical,error,warning,info,debug}
```


## callingcardstools_yeast_combine_qc

### Tool Description
Splits BarcodeQcCounter objects into separate files based on barcode details.

### Metadata
- **Docker Image**: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/cmatKhan/callingCardsTools
- **Package**: https://anaconda.org/channels/bioconda/packages/callingcardstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: split_fastq [-h] [-l {critical,error,warning,info,debug}] -i INPUT
                   [INPUT ...] -b BARCODE_DETAILS [-o OUTPUT_DIRPATH]
                   [-p PREFIX]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                        a list of paths to BarcodeQcCounter object pickle
                        files
  -b BARCODE_DETAILS, --barcode_details BARCODE_DETAILS
                        barcode filename (full path)
  -o OUTPUT_DIRPATH, --output_dirpath OUTPUT_DIRPATH
                        a path to a directory where the output files will be
                        output. Defaults to the current directory
  -p PREFIX, --prefix PREFIX
                        filename prefix for output files. Defaults to
                        barcode_qc

General:
  -l {critical,error,warning,info,debug}, --log_level {critical,error,warning,info,debug}
```


## callingcardstools_process_yeast_bam

### Tool Description
Processes yeast BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/cmatKhan/callingCardsTools
- **Package**: https://anaconda.org/channels/bioconda/packages/callingcardstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: process_yeast_bam [-h] [-l {critical,error,warning,info,debug}] -i
                         BAMPATH -g GENOME -j BARCODE_DETAILS
                         [-q MAPQ_THRESHOLD] [-o OUTPUT_DIR] [-v]

optional arguments:
  -h, --help            show this help message and exit
  -i BAMPATH, --bampath BAMPATH
                        path to the input bam file
  -g GENOME, --genome GENOME
                        Path to a genome .fasta file. Note that an index .fai
                        file must exist in the same path
  -j BARCODE_DETAILS, --barcode_details BARCODE_DETAILS
                        Path to the barcode details json file
  -q MAPQ_THRESHOLD, --mapq_threshold MAPQ_THRESHOLD
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        path to the output directory (default: current
                        directory)
  -v, --verbose_qc      save complete alignment summary

General:
  -l {critical,error,warning,info,debug}, --log_level {critical,error,warning,info,debug}
```


## callingcardstools_process_mammals_bam

### Tool Description
Processes BAM files for calling cards analysis in mammals.

### Metadata
- **Docker Image**: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/cmatKhan/callingCardsTools
- **Package**: https://anaconda.org/channels/bioconda/packages/callingcardstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: process_mammals_bam [-h] [-l {critical,error,warning,info,debug}] -i
                           INPUT -b BARCODE_DETAILS -g GENOME
                           [-q MAPQ_THRESHOLD] [-f FILENAME] [-s SUFFIX] [-p]

optional arguments:
  -h, --help            show this help message and exit

General:
  -l {critical,error,warning,info,debug}, --log_level {critical,error,warning,info,debug}

input:
  -i INPUT, --input INPUT
                        path to bam file. Note that this must be sorted, and
                        that an index .bai file must exist in the same
                        directory
  -b BARCODE_DETAILS, --barcode_details BARCODE_DETAILS
                        path to the barcode details json
  -g GENOME, --genome GENOME
                        path to genome fasta file. Note that a index .fai must
                        exist in the same directory
  -q MAPQ_THRESHOLD, --mapq_threshold MAPQ_THRESHOLD
                        Reads less than or equal to mapq_threshold will be
                        marked as failed

output:
  -f FILENAME, --filename FILENAME
                        Filename minus optional suffix and extension. Default
                        is the input file basename minus the extension
  -s SUFFIX, --suffix SUFFIX
                        suffix to add to output files.
  -p, --pickle          Set this flag to save the qbed and qc data as pickle
                        files. this is useful when processing split files in
                        parallel and then combining later. Defaults to False,
                        which saves as qbed/tsv
```


## callingcardstools_mammals_combine_qc

### Tool Description
Combines QC data from multiple Qbed and BarcodeQcCounter objects.

### Metadata
- **Docker Image**: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/cmatKhan/callingCardsTools
- **Package**: https://anaconda.org/channels/bioconda/packages/callingcardstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mammals_combine_qc [-h] [-l {critical,error,warning,info,debug}] -q
                          QBED_LIST [QBED_LIST ...] -b BARCODEQCCOUNTER_LIST
                          [BARCODEQCCOUNTER_LIST ...] [-f FILENAME]
                          [-s SUFFIX] [-p]

optional arguments:
  -h, --help            show this help message and exit

General:
  -l {critical,error,warning,info,debug}, --log_level {critical,error,warning,info,debug}

input:
  -q QBED_LIST [QBED_LIST ...], --qbed_list QBED_LIST [QBED_LIST ...]
                        A list of pickled Qbed objects
  -b BARCODEQCCOUNTER_LIST [BARCODEQCCOUNTER_LIST ...], --barcodeQcCounter_list BARCODEQCCOUNTER_LIST [BARCODEQCCOUNTER_LIST ...]
                        A list of pickled BarcodeQcCounter objects

output:
  -f FILENAME, --filename FILENAME
                        base filename (no extension) for output files.
  -s SUFFIX, --suffix SUFFIX
                        suffix to add to to the base filename.
  -p, --pickle          Set this flag to save the qbed and qc data as pickle
                        files. this is useful when processing split files in
                        parallel and then combining later. Defaults to False,
                        which saves as qbed/tsv
```


## callingcardstools_yeast_call_peaks

### Tool Description
Call peaks for yeast calling cards data.

### Metadata
- **Docker Image**: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/cmatKhan/callingCardsTools
- **Package**: https://anaconda.org/channels/bioconda/packages/callingcardstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: yeast_call_peaks [-h] [-l {critical,error,warning,info,debug}]
                        --experiment_data_paths EXPERIMENT_DATA_PATHS
                        [EXPERIMENT_DATA_PATHS ...]
                        --experiment_orig_chr_convention
                        EXPERIMENT_ORIG_CHR_CONVENTION --promoter_data_path
                        PROMOTER_DATA_PATH --promoter_orig_chr_convention
                        PROMOTER_ORIG_CHR_CONVENTION --background_data_path
                        BACKGROUND_DATA_PATH --background_orig_chr_convention
                        BACKGROUND_ORIG_CHR_CONVENTION --chrmap_data_path
                        CHRMAP_DATA_PATH
                        [--unified_chr_convention UNIFIED_CHR_CONVENTION]
                        [--deduplicate_experiment] [--genomic_only]
                        [--output_path OUTPUT_PATH]
                        [--pseudocount PSEUDOCOUNT] [--compress_output]

optional arguments:
  -h, --help            show this help message and exit
  --experiment_data_paths EXPERIMENT_DATA_PATHS [EXPERIMENT_DATA_PATHS ...]
                        paths to the experiment data files.
  --experiment_orig_chr_convention EXPERIMENT_ORIG_CHR_CONVENTION
                        the chromosome naming convention used in the
                        experiment data file.
  --promoter_data_path PROMOTER_DATA_PATH
                        path to the promoter data file.
  --promoter_orig_chr_convention PROMOTER_ORIG_CHR_CONVENTION
                        the chromosome naming convention used in the promoter
                        data file.
  --background_data_path BACKGROUND_DATA_PATH
                        path to the background data file.
  --background_orig_chr_convention BACKGROUND_ORIG_CHR_CONVENTION
                        the chromosome naming convention used in the
                        background data file.
  --chrmap_data_path CHRMAP_DATA_PATH
                        path to the chromosome map file. this must include the
                        data files' current naming conventions, the desired
                        naming, and a column `type` that indicates whether the
                        chromosome is 'genomic' or something else, eg
                        'mitochondrial' or 'plasmid'.
  --unified_chr_convention UNIFIED_CHR_CONVENTION
                        the chromosome naming convention to use in the output
                        DataFrame.
  --deduplicate_experiment
                        set this flag to deduplicate the experiment data based
                        on `chr`, `start` and `end` such that if an insertion
                        is found at the same coordinate on different strands,
                        only one of those records will be retained.
  --genomic_only        set this flag to include only genomic chromosomes in
                        the experiment and background.
  --output_path OUTPUT_PATH
                        path to the output file.
  --pseudocount PSEUDOCOUNT
                        pseudocount to use when calculating poisson pvalue.
                        Note that this is used only when the background hops
                        are 0 for a given promoter.
  --compress_output     set this flag to gzip the output csv file.

General:
  -l {critical,error,warning,info,debug}, --log_level {critical,error,warning,info,debug}
```


## callingcardstools_chipexo_promoter_sig

### Tool Description
Compare CHIPEXO and promoter data to find significant regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/cmatKhan/callingCardsTools
- **Package**: https://anaconda.org/channels/bioconda/packages/callingcardstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: chipexo_promoter_sig [-h] [-l {critical,error,warning,info,debug}]
                            --chipexo_data_path CHIPEXO_DATA_PATH
                            --chipexo_orig_chr_convention
                            CHIPEXO_ORIG_CHR_CONVENTION --promoter_data_path
                            PROMOTER_DATA_PATH --promoter_orig_chr_convention
                            PROMOTER_ORIG_CHR_CONVENTION --chrmap_data_path
                            CHRMAP_DATA_PATH --unified_chr_convention
                            UNIFIED_CHR_CONVENTION [--output_file OUTPUT_FILE]
                            [--compress]

optional arguments:
  -h, --help            show this help message and exit
  --chipexo_data_path CHIPEXO_DATA_PATH
                        Path to the chipexo data file.
  --chipexo_orig_chr_convention CHIPEXO_ORIG_CHR_CONVENTION
                        Chromosome convention of the chipexo data file.
  --promoter_data_path PROMOTER_DATA_PATH
                        Path to the promoter data file.
  --promoter_orig_chr_convention PROMOTER_ORIG_CHR_CONVENTION
                        Chromosome convention of the promoter data file.
  --chrmap_data_path CHRMAP_DATA_PATH
                        Path to the chromosome map file.
  --unified_chr_convention UNIFIED_CHR_CONVENTION
                        Chromosome convention to convert to.
  --output_file OUTPUT_FILE
                        Path to the output file.
  --compress            Set this flag to gzip the output file.

General:
  -l {critical,error,warning,info,debug}, --log_level {critical,error,warning,info,debug}
```


## callingcardstools_yeast_rank_response

### Tool Description
Rank response of yeast genes based on calling cards data.

### Metadata
- **Docker Image**: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/cmatKhan/callingCardsTools
- **Package**: https://anaconda.org/channels/bioconda/packages/callingcardstools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: yeast_rank_response [-h] [-l {critical,error,warning,info,debug}]
                           --config CONFIG [--output_file OUTPUT_FILE]
                           [--compress]

optional arguments:
  -h, --help            show this help message and exit
  --config CONFIG       Path to the configuration json file. For details, see 
                        https://cmatkhan.github.io/callingCardsTools/file_form
                        at_specs/yeast_rank_response/
  --output_file OUTPUT_FILE
                        Path to the output file. Default is rank_response.csv
  --compress            Compress the output file using gzip

General:
  -l {critical,error,warning,info,debug}, --log_level {critical,error,warning,info,debug}
```


## Metadata
- **Skill**: not generated
