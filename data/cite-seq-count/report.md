# cite-seq-count CWL Generation Report

## cite-seq-count_CITE-seq-Count

### Tool Description
This script counts matching antibody tags from paired fastq files. Version 1.4.5

### Metadata
- **Docker Image**: quay.io/biocontainers/cite-seq-count:1.4.5--pyhdfd78af_0
- **Homepage**: https://hoohm.github.io/CITE-seq-Count/
- **Package**: https://anaconda.org/channels/bioconda/packages/cite-seq-count/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cite-seq-count/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Hoohm/CITE-seq-Count
- **Stars**: N/A
### Original Help Text
```text
usage: CITE-seq-Count [-h] -R1 READ1_PATH -R2 READ2_PATH -t TAGS -cbf CB_FIRST
                      -cbl CB_LAST -umif UMI_FIRST -umil UMI_LAST
                      [--umi_collapsing_dist UMI_THRESHOLD]
                      [--no_umi_correction]
                      [--bc_collapsing_dist BC_THRESHOLD] -cells
                      EXPECTED_CELLS [-wl WHITELIST] [--max-errors MAX_ERROR]
                      [-trim START_TRIM] [--sliding-window] [-T N_THREADS]
                      [-n FIRST_N] [-o OUTFOLDER] [--dense] [-u UNMAPPED_FILE]
                      [-ut UNKNOWNS_TOP] [--debug] [--version]

This script counts matching antibody tags from paired fastq files. Version 1.4.5

options:
  -h, --help            show this help message and exit
  -T N_THREADS, --threads N_THREADS
                        How many threads are to be used for running the program
  -n FIRST_N, --first_n FIRST_N
                        Select N reads to run on instead of all.
  -o OUTFOLDER, --output OUTFOLDER
                        Results will be written to this folder
  --dense               Add a dense output to the results folder
  -u UNMAPPED_FILE, --unmapped-tags UNMAPPED_FILE
                        Write table of unknown TAGs to file.
  -ut UNKNOWNS_TOP, --unknown-top-tags UNKNOWNS_TOP
                        Top n unmapped TAGs.
  --debug               Print extra information for debugging.
  --version             Print version number.

Inputs:
  Required input files.

  -R1 READ1_PATH, --read1 READ1_PATH
                        The path of Read1 in gz format, or a comma-separated list of paths to all Read1 files in gz format (E.g. A1.fq.gz,B1.fq,gz,...
  -R2 READ2_PATH, --read2 READ2_PATH
                        The path of Read2 in gz format, or a comma-separated list of paths to all Read2 files in gz format (E.g. A2.fq.gz,B2.fq,gz,...
  -t TAGS, --tags TAGS  The path to the csv file containing the antibody
                        barcodes as well as their respective names.
                        
                        Example of an antibody barcode file structure:
                        
                        	ATGCGA,First_tag_name
                        	GTCATG,Second_tag_name

Barcodes:
  Positions of the cellular barcodes and UMI. If your cellular barcodes and UMI
   are positioned as follows:
  	Barcodes from 1 to 16 and UMI from 17 to 26
  then this is the input you need:
  	-cbf 1 -cbl 16 -umif 17 -umil 26

  -cbf CB_FIRST, --cell_barcode_first_base CB_FIRST
                        Postion of the first base of your cell barcodes.
  -cbl CB_LAST, --cell_barcode_last_base CB_LAST
                        Postion of the last base of your cell barcodes.
  -umif UMI_FIRST, --umi_first_base UMI_FIRST
                        Postion of the first base of your UMI.
  -umil UMI_LAST, --umi_last_base UMI_LAST
                        Postion of the last base of your UMI.
  --umi_collapsing_dist UMI_THRESHOLD
                        threshold for umi collapsing.
  --no_umi_correction   Deactivate UMI collapsing
  --bc_collapsing_dist BC_THRESHOLD
                        threshold for cellular barcode collapsing.

Cells:
  Expected number of cells and potential whitelist

  -cells EXPECTED_CELLS, --expected_cells EXPECTED_CELLS
                        Number of expected cells from your run.
  -wl WHITELIST, --whitelist WHITELIST
                        A csv file containning a whitelist of barcodes produced by the mRNA data.
                        
                        	Example:
                        	ATGCTAGTGCTA
                        	GCTAGTCAGGAT
                        	CGACTGCTAACG
                        
                        Or 10X-style:
                        	ATGCTAGTGCTA-1
                        	GCTAGTCAGGAT-1
                        	CGACTGCTAACG-1

TAG filters:
  Filtering and trimming for read2.

  --max-errors MAX_ERROR
                        Maximum Levenshtein distance allowed for antibody barcodes.
  -trim START_TRIM, --start-trim START_TRIM
                        Number of bases to discard from read2.
  --sliding-window      Allow for a sliding window when aligning.
```

