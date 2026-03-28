# kb-python CWL Generation Report

## kb-python_kb

### Tool Description
kb_python 0.30.0

### Metadata
- **Docker Image**: quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0
- **Homepage**: https://github.com/pachterlab/kb_python
- **Package**: https://anaconda.org/channels/bioconda/packages/kb-python/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kb-python/overview
- **Total Downloads**: 40.0K
- **Last updated**: 2025-10-30
- **GitHub**: https://github.com/pachterlab/kb_python
- **Stars**: N/A
### Original Help Text
```text
usage: kb [-h] [--list] <CMD> ...

kb_python 0.30.0

positional arguments:
  <CMD>
    info      Display package and citation information
    compile   Compile `kallisto` and `bustools` binaries from source
    ref       Build a kallisto index and transcript-to-gene mapping
    count     Generate count matrices from a set of single-cell FASTQ files
    extract   Extract sequencing reads that were pseudoaligned to specific
              genes/transcripts (or extract all reads that were / were not
              pseudoaligned)

options:
  -h, --help  Show this help message and exit
  --list      Display list of supported single-cell technologies
```


## kb-python_kb ref

### Tool Description
Build a kallisto index and transcript-to-gene mapping

### Metadata
- **Docker Image**: quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0
- **Homepage**: https://github.com/pachterlab/kb_python
- **Package**: https://anaconda.org/channels/bioconda/packages/kb-python/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kb ref [-h] [--tmp TMP] [--keep-tmp] [--verbose] -i INDEX -g T2G -f1
              FASTA
              [--include-attribute KEY:VALUE | --exclude-attribute KEY:VALUE]
              [-f2 FASTA] [-c1 T2C] [-c2 T2C] [-d NAME] [-k K] [-t THREADS]
              [--d-list FASTA] [--aa] [--workflow {standard,nac,kite,custom}]
              [--make-unique] [--overwrite] [--kallisto KALLISTO]
              [--bustools BUSTOOLS] [--opt-off]
              fasta gtf [feature]

Build a kallisto index and transcript-to-gene mapping

positional arguments:
  fasta                 Genomic FASTA file(s), comma-delimited
  gtf                   Reference GTF file(s), comma-delimited [not required
                        with --aa]
  feature               [`kite` workflow only] Path to TSV containing barcodes
                        and feature names.

options:
  -h, --help            Show this help message and exit
  --tmp TMP             Override default temporary directory
  --keep-tmp            Do not delete the tmp directory
  --verbose             Print debugging information
  --include-attribute KEY:VALUE
                        Only process GTF entries that have the provided
                        KEY:VALUE attribute. May be specified multiple times.
  --exclude-attribute KEY:VALUE
                        Only process GTF entires that do not have the provided
                        KEY:VALUE attribute. May be specified multiple times.
  -d NAME               Download a pre-built kallisto index (along with all
                        necessary files) instead of building it locally
  -k K                  Use this option to override the k-mer length of the
                        index. Usually, the k-mer length automatically
                        calculated by `kb` provides the best results.
  -t THREADS            Number of threads to use (default: 8)
  --d-list FASTA        D-list file(s) (default: the Genomic FASTA file(s) for
                        standard/nac workflow)
  --aa                  Generate index from a FASTA-file containing amino acid
                        sequences
  --workflow {standard,nac,kite,custom}
                        The type of index to create. Use `nac` for an index
                        type that can quantify nascent and mature RNA. Use
                        `custom` for indexing targets directly. Use `kite` for
                        feature barcoding. (default: standard)
  --make-unique         Replace repeated target names with unique names
  --overwrite           Overwrite existing kallisto index
  --kallisto KALLISTO   Path to kallisto binary to use (default:
                        /usr/local/lib/python3.12/site-
                        packages/kb_python/bins/linux/kallisto/kallisto)
  --bustools BUSTOOLS   Path to bustools binary to use (default:
                        /usr/local/lib/python3.12/site-
                        packages/kb_python/bins/linux/bustools/bustools)
  --opt-off             Disable performance optimizations

required arguments:
  -i INDEX              Path to the kallisto index to be constructed.
  -g T2G                Path to transcript-to-gene mapping to be generated
  -f1 FASTA             [Optional with -d] Path to the cDNA FASTA (standard,
                        nac) or mismatch FASTA (kite) to be generated
                        [Optional with --aa when no GTF file(s) provided] [Not
                        used with --workflow=custom]

required arguments for `nac` workflow:
  -f2 FASTA             Path to the unprocessed transcripts FASTA to be
                        generated
  -c1 T2C               Path to generate cDNA transcripts-to-capture
  -c2 T2C               Path to generate unprocessed transcripts-to-capture
```


## kb-python_kb count

### Tool Description
Generate count matrices from a set of single-cell FASTQ files. Run `kb --list`
to view single-cell technology information.

### Metadata
- **Docker Image**: quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0
- **Homepage**: https://github.com/pachterlab/kb_python
- **Package**: https://anaconda.org/channels/bioconda/packages/kb-python/overview
- **Validation**: PASS

### Original Help Text
```text
usage: kb count [-h] [--tmp TMP] [--keep-tmp] [--verbose] -i INDEX -g T2G -x
                TECHNOLOGY [-o OUT] [--num] [-w ONLIST] [--exact-barcodes]
                [-r REPLACEMENT] [-t THREADS] [-m MEMORY]
                [--strand {unstranded,forward,reverse}] [--inleaved]
                [--genomebam] [--cram] [--aa]
                [--workflow {standard,nac,kite,kite:10xFB}] [--mm | --tcc]
                [--filter [{bustools}]] [--filter-threshold THRESH] [-c1 T2C]
                [-c2 T2C] [--overwrite] [--dry-run] [--batch-barcodes]
                [--loom | --h5ad]
                [--loom-names col_attrs/{name},row_attrs/{name}] [--sum TYPE]
                [--cellranger] [--gzip] [--no-gzip] [--delete-bus]
                [--gene-names] [-N NUMREADS] [--report] [--long]
                [--threshold THRESH] [--platform [PacBio or ONT]]
                [--kallisto KALLISTO] [--bustools BUSTOOLS] [--opt-off]
                [--parity {single,paired}] [--fragment-l L] [--fragment-s S]
                [--bootstraps B] [--matrix-to-files] [--matrix-to-directories]
                fastqs [fastqs ...]

Generate count matrices from a set of single-cell FASTQ files. Run `kb --list`
to view single-cell technology information.

positional arguments:
  fastqs                FASTQ files. For technology `SMARTSEQ`, all input
                        FASTQs are alphabetically sorted by path and paired in
                        order, and cell IDs are assigned as incrementing
                        integers starting from zero. A single batch TSV with
                        cell ID, read 1, and read 2 as columns can be provided
                        to override this behavior.

options:
  -h, --help            Show this help message and exit
  --tmp TMP             Override default temporary directory
  --keep-tmp            Do not delete the tmp directory
  --verbose             Print debugging information
  -o OUT                Path to output directory (default: current directory)
  --num                 Store read numbers in BUS file
  -w ONLIST             Path to file of on-listed barcodes to correct to. If
                        not provided and bustools supports the technology, a
                        pre-packaged on-list is used. Otherwise, the bustools
                        allowlist command is used. Specify NONE to bypass
                        barcode error correction. (`kb --list` to view on-
                        lists)
  --exact-barcodes      Only exact matches are used for matching barcodes to
                        on-list.
  -r REPLACEMENT        Path to file of a replacement list to correct to. In
                        the file, the first column is the original barcode and
                        second is the replacement sequence
  -t THREADS            Number of threads to use (default: 8)
  -m MEMORY             Maximum memory used (default: 2G for standard, 4G for
                        others)
  --strand {unstranded,forward,reverse}
                        Strandedness (default: see `kb --list`)
  --inleaved            Specifies that input is an interleaved FASTQ file
  --genomebam           Generate genome-aligned BAM file from
                        pseudoalignments. Requires --gtf to be specified.
                        --chromosomes is recommended.
  --cram                Convert BAM output to CRAM format (requires
                        --genomebam). CRAM provides better compression than
                        BAM.
  --aa                  Map to index generated from FASTA-file containing
                        amino acid sequences
  --workflow {standard,nac,kite,kite:10xFB}
                        Type of workflow. Use `nac` to specify a nac index for
                        producing mature/nascent/ambiguous matrices. Use
                        `kite` for feature barcoding. Use `kite:10xFB` for 10x
                        Genomics Feature Barcoding technology. (default:
                        standard)
  --mm                  Include reads that pseudoalign to multiple genes.
                        Automatically enabled when generating a TCC matrix.
  --tcc                 Generate a TCC matrix instead of a gene count matrix.
  --filter [{bustools}]
                        Produce a filtered gene count matrix (default:
                        bustools)
  --filter-threshold THRESH
                        Barcode filter threshold (default: auto)
  --overwrite           Overwrite existing output.bus file
  --dry-run             Dry run
  --batch-barcodes      When a batch file is supplied, store sample
                        identifiers in barcodes
  --loom                Generate loom file from count matrix
  --h5ad                Generate h5ad file from count matrix
  --loom-names col_attrs/{name},row_attrs/{name}
                        Names for col_attrs and row_attrs in loom file
                        (default: barcode,target_name). Use --loom-
                        names=velocyto for velocyto-compatible loom files
  --sum TYPE            Produced summed count matrices (Options: none, cell,
                        nucleus, total). Use `cell` to add ambiguous and
                        processed transcript matrices. Use `nucleus` to add
                        ambiguous and unprocessed transcript matrices. Use
                        `total` to add all three matrices together. (Default:
                        none)
  --cellranger          Convert count matrices to cellranger-compatible
                        format. For nac/lamanno workflows, automatically
                        creates spliced/ and unspliced/ subdirectories. Gzip
                        compression is enabled by default (use --no-gzip to
                        disable)
  --gzip                Gzip compress output matrices (matrix.mtx.gz,
                        barcodes.tsv.gz, genes.tsv.gz). Automatically enabled
                        with --cellranger
  --no-gzip             Disable gzip compression for cellranger matrices
  --delete-bus          Delete intermediate BUS files after successful count
                        to save disk space
  --gene-names          Group counts by gene names instead of gene IDs when
                        generating the loom or h5ad file
  -N NUMREADS           Maximum number of reads to process from supplied input
  --report              Generate a HTML report containing run statistics and
                        basic plots. Using this option may cause kb to use
                        more memory than specified with the `-m` option. It
                        may also cause it to crash due to memory.
  --long                Use lr-kallisto for long-read mapping
  --threshold THRESH    Set threshold for lr-kallisto read mapping (default:
                        0.8)
  --platform [PacBio or ONT]
                        Set platform for lr-kallisto (default: ONT)
  --kallisto KALLISTO   Path to kallisto binary to use (default:
                        /usr/local/lib/python3.12/site-
                        packages/kb_python/bins/linux/kallisto/kallisto)
  --bustools BUSTOOLS   Path to bustools binary to use (default:
                        /usr/local/lib/python3.12/site-
                        packages/kb_python/bins/linux/bustools/bustools)
  --opt-off             Disable performance optimizations

required arguments:
  -i INDEX              Path to kallisto index
  -g T2G                Path to transcript-to-gene mapping
  -x TECHNOLOGY         Single-cell technology used (`kb --list` to view)

required arguments for `nac` workflow:
  -c1 T2C               Path to mature transcripts-to-capture
  -c2 T2C               Path to nascent transcripts-to-captured

optional arguments for `BULK` and `SMARTSEQ2` technologies:
  --parity {single,paired}
                        Parity of the input files. Choices are `single` for
                        single-end and `paired` for paired-end reads.
  --fragment-l L        Mean length of fragments. Only for single-end.
  --fragment-s S        Standard deviation of fragment lengths. Only for
                        single-end.
  --bootstraps B        Number of bootstraps to perform
  --matrix-to-files     Reorganize matrix output into abundance tsv files
  --matrix-to-directories
                        Reorganize matrix output into abundance tsv files
                        across multiple directories
```


## kb-python_kb --list

### Tool Description
List of supported single-cell technologies

### Metadata
- **Docker Image**: quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0
- **Homepage**: https://github.com/pachterlab/kb_python
- **Package**: https://anaconda.org/channels/bioconda/packages/kb-python/overview
- **Validation**: PASS

### Original Help Text
```text
List of supported single-cell technologies

Positions syntax: `input file index, start position, end position`
When start & end positions are None, refers to the entire file
Custom technologies may be defined by providing a kallisto-supported technology string
(see https://pachterlab.github.io/kallisto/manual)

name            description                            on-list    barcode                    umi        cDNA                       
------------    -----------------------------------    -------    -----------------------    -------    -----------------------    
10XV1           10x version 1                          yes        0,0,14                     1,0,10     2,None,None                
10XV2           10x version 2                          yes        0,0,16                     0,16,26    1,None,None                
10XV3           10x version 3                          yes        0,0,16                     0,16,28    1,None,None                
10XV3_ULTIMA    10x version 3 sequenced with Ultima    yes        0,22,38                    0,38,50    0,62,None                  
10XV4           10x version 4                          yes        0,0,16                     0,16,28    1,None,None                
BDWTA           BD Rhapsody                            yes        0,0,9 0,21,30 0,43,52      0,52,60    1,None,None                
BULK            Bulk (single or paired)                                                                 0,None,None 1,None,None    
CELSEQ          CEL-Seq                                           0,0,8                      0,8,12     1,None,None                
CELSEQ2         CEL-SEQ version 2                                 0,6,12                     0,0,6      1,None,None                
DROPSEQ         DropSeq                                           0,0,12                     0,12,20    1,None,None                
INDROPSV1       inDrops version 1                                 0,0,11 0,30,38             0,42,48    1,None,None                
INDROPSV2       inDrops version 2                                 1,0,11 1,30,38             1,42,48    0,None,None                
INDROPSV3       inDrops version 3                      yes        0,0,8 1,0,8                1,8,14     2,None,None                
SCRUBSEQ        SCRB-Seq                                          0,0,6                      0,6,16     1,None,None                
SMARTSEQ2       Smart-seq2  (single or paired)                                                          0,None,None 1,None,None    
SMARTSEQ3       Smart-seq3                                                                   0,11,19    0,11,None 1,None,None      
SPLIT-SEQ       SPLiT-seq (version 2)                  yes        1,10,18 1,48,56 1,78,86    1,0,10     0,None,None                
STORMSEQ        STORM-seq                                                                    1,0,8      0,None,None 1,14,None      
SURECELL        SureCell for ddSEQ                                0,0,6 0,21,27 0,42,48      0,51,59    1,None,None                
Visium          10x Visium                             yes        0,0,16                     0,16,28    1,None,None
```


## kb-python_kb info

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0
- **Homepage**: https://github.com/pachterlab/kb_python
- **Package**: https://anaconda.org/channels/bioconda/packages/kb-python/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/kb", line 10, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.12/site-packages/ngs_tools/logging.py", line 62, in inner
    return func(*args, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/kb_python/main.py", line 1859, in main
    display_info()
  File "/usr/local/lib/python3.12/site-packages/kb_python/main.py", line 83, in display_info
    info = f'kb_python {__version__}\n{get_binary_info()}'
                                       ^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/kb_python/main.py", line 71, in get_binary_info
    kallisto_version = '.'.join(str(i) for i in get_kallisto_version())
                                                ^^^^^^^^^^^^^^^^^^^^^^
TypeError: 'NoneType' object is not iterable
```


## Metadata
- **Skill**: generated
