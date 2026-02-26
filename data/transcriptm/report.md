# transcriptm CWL Generation Report

## transcriptm

### Tool Description
Process metatranscriptomic data and complete metagenomics analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/transcriptm:0.2--pyhdfd78af_0
- **Homepage**: https://github.com/elfrouin/transcriptM
- **Package**: https://anaconda.org/channels/bioconda/packages/transcriptm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/transcriptm/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/elfrouin/transcriptM
- **Stars**: N/A
### Original Help Text
```text
usage: transcriptm [-h] [--verbose [VERBOSE]] [--version] [-L FILE]
                   --paired_end PAIRED_END [PAIRED_END ...] --metaG_contigs
                   METAG_CONTIGS --dir_bins DIR_BINS [--threads THREADS]
                   [--db_path DB_PATH] [--output_dir OUTPUT_DIR]
                   [--working_dir WORKING_DIR] [--adapters {nextera,truseq}]
                   [--min_len MIN_LEN] [--min_avg_qc MIN_AVG_QC]
                   [--phred {phred33,phred64}] [--min_qc MIN_QC] [--crop CROP]
                   [--headcrop HEADCROP] [--path_db_smr PATH_DB_SMR]
                   [--percentage_id PERCENTAGE_ID]
                   [--percentage_aln PERCENTAGE_ALN] [--no_mapping_filter]

                    ===============================                       
                    |       transcriptM v0.2      |
                    ===============================    

   -------------------------------------------------------------------------   
       Process metatranscriptomic data and complete metagenomics analysis
   ------------------------------------------------------------------------- 
   e.g. usage:
transcriptm --paired_end sample1-1.fq.gz sample1-2.fq.gz sample2-1.fq.gz sample2-2.fq.gz --metaG_contigs assembly.fa --dir_bins dir_gff
    

Arguments:
  -h, --help            show this help message and exit
  --paired_end PAIRED_END [PAIRED_END ...]
                        Input files: paired sequences files of raw metatranscriptomics reads (.fq.gz format) [0;32m|REQUIRED[00m
                          e.g. --paired_end sample1_1.fq.gz sample1_2.fq.gz sample2_1.fq.gz sample2_2.fq.gz
  --metaG_contigs METAG_CONTIGS
                        All contigs from the reference metagenome in a fasta file [0;32m|REQUIRED[00m
  --dir_bins DIR_BINS   Directory which contains several annotated population genomes (bins) [0;32m|REQUIRED[00m
                         -> gff format, the others files would be ignored
  --threads THREADS     Number of threads to use [default: 20]
  --db_path DB_PATH     Directory which contains the TranscriptM databases [default: /usr/local/share/transcriptm-0.2-0/data/]
  --output_dir OUTPUT_DIR
                        Output directory  [default: TranscriptM_output]
  --working_dir WORKING_DIR
                        Working directory [default: /tmp/tmpbrWiZh]

Common options:
  --verbose [VERBOSE], -v [VERBOSE]
                        Print more verbose messages for each additional verbose level.
  --version             show program's version number and exit
  -L FILE, --log_file FILE
                        Name and path of log file

Trimmomatic options:
  --adapters {nextera,truseq}
                        Type of adapters to clip  [default: truseq]
  --min_len MIN_LEN     Minimum required length of read  [default: 30]
  --min_avg_qc MIN_AVG_QC
                        Minimum average quality score for 4 bp windows  [default: 25]
  --phred {phred33,phred64}
                        Quality encoding  [default: phred33]
  --min_qc MIN_QC       Minimum quality score for leading and trailing bases  [default: 20]
  --crop CROP           Cut read to a specific length  [default: 10000]
  --headcrop HEADCROP   Cut specified number of bases from start of read  [default: 0]

SortMeRNA options:
  --path_db_smr PATH_DB_SMR
                        Path to databases and index
                         e.g. path_db1,path_index1:path_db2,path_index2 [default: rRNA and tRNA db]
                         NB: index must be created with the script sortmerna/2.0/bin/indexdb_rna

Mapping options (BamM filter):
  --percentage_id PERCENTAGE_ID
                         Minimum allowable percentage base identity of a mapped read [default: 0.97]
  --percentage_aln PERCENTAGE_ALN
                        Minimum allowable percentage read bases mapped [default: 0.95]
  --no_mapping_filter   Do not adjust the mapping stringency by filtering alignments [default: False]
```

