# snaptools CWL Generation Report

## snaptools_dex-fastq

### Tool Description
Decomplexes a fastq file containing reads from multiple cells into individual fastq files for each cell.

### Metadata
- **Docker Image**: quay.io/biocontainers/snaptools:1.4.8--py_0
- **Homepage**: https://github.com/r3fang/SnapTools.git
- **Package**: https://anaconda.org/channels/bioconda/packages/snaptools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snaptools/overview
- **Total Downloads**: 3.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/r3fang/SnapTools
- **Stars**: N/A
### Original Help Text
```text
usage: snaptools dex-fastq [-h] --input-fastq INPUT_FASTQ --output-fastq
                           OUTPUT_FASTQ --index-fastq-list INDEX_FASTQ_LIST
                           [INDEX_FASTQ_LIST ...]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --input-fastq INPUT_FASTQ
                        fastq file contains the sequencing reads (default:
                        None)
  --output-fastq OUTPUT_FASTQ
                        output decomplexed fastq file (default: None)
  --index-fastq-list INDEX_FASTQ_LIST [INDEX_FASTQ_LIST ...]
                        a list of fastq files that contain the cell indices.
                        (default: None)
```


## snaptools_index-genome

### Tool Description
Builds genome index for snaptools.

### Metadata
- **Docker Image**: quay.io/biocontainers/snaptools:1.4.8--py_0
- **Homepage**: https://github.com/r3fang/SnapTools.git
- **Package**: https://anaconda.org/channels/bioconda/packages/snaptools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snaptools index-genome [-h] --input-fasta INPUT_FASTA
                              [--output-prefix OUTPUT_PREFIX]
                              [--aligner ALIGNER]
                              [--path-to-aligner PATH_TO_ALIGNER]
                              [--num-threads NUM_THREADS]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --input-fasta INPUT_FASTA
                        genome fasta file to build the index from (default:
                        None)

optional inputs:
  --output-prefix OUTPUT_PREFIX
                        prefix of indexed file (default: None)
  --aligner ALIGNER     aligner to use. Currently, snaptools supports bwa,
                        bowtie, bowtie2 and minimap2. (default: bwa)
  --path-to-aligner PATH_TO_ALIGNER
                        path to fold that contains bwa (default: None)
  --num-threads NUM_THREADS
                        =number of indexing threads (default: 3)
```


## snaptools_align-paired-end

### Tool Description
Align paired-end FASTQ files to a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/snaptools:1.4.8--py_0
- **Homepage**: https://github.com/r3fang/SnapTools.git
- **Package**: https://anaconda.org/channels/bioconda/packages/snaptools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snaptools align-paired-end [-h] --input-reference INPUT_REFERENCE
                                  --input-fastq1 INPUT_FASTQ1 --input-fastq2
                                  INPUT_FASTQ2 --output-bam OUTPUT_BAM
                                  [--aligner ALIGNER]
                                  [--path-to-aligner PATH_TO_ALIGNER]
                                  [--aligner-options ALIGNER_OPTIONS [ALIGNER_OPTIONS ...]]
                                  [--read-fastq-command READ_FASTQ_COMMAND]
                                  [--min-cov MIN_COV]
                                  [--num-threads NUM_THREADS]
                                  [--if-sort IF_SORT]
                                  [--tmp-folder TMP_FOLDER]
                                  [--overwrite OVERWRITE] [--verbose VERBOSE]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --input-reference INPUT_REFERENCE
                        reference genome file contains the reference genome
                        that reads are mapped against, the genome index must
                        be under the same folder (default: None)
  --input-fastq1 INPUT_FASTQ1
                        fastq file contains R1 reads, currently supports
                        fastq, gz, bz2 file (default: None)
  --input-fastq2 INPUT_FASTQ2
                        fastq file contains R2 reads, currently supports
                        fastq, gz, bz2 file (default: None)
  --output-bam OUTPUT_BAM
                        output bam file contains unfiltered alignments
                        (default: None)

optional inputs:
  --aligner ALIGNER     aligner to use. Currently, snaptools supports bwa,
                        bowtie, bowtie2 and minimap2. (default: bwa)
  --path-to-aligner PATH_TO_ALIGNER
                        path to fold that contains bwa (default: None)
  --aligner-options ALIGNER_OPTIONS [ALIGNER_OPTIONS ...]
                        list of strings indicating options you would like
                        passed to alignerstrongly do not recommand to change
                        unless you know what you are doing. the default is to
                        align reads without filteration. (default: None)
  --read-fastq-command READ_FASTQ_COMMAND
                        command line to execute for each of the input file.
                        This command should generate FASTQ text and send it to
                        stdout. For example, --read-fastq-command should be
                        zcat, bzcat and cat for .gz, .bz2 and plain fastq file
                        respectively (default: None)
  --min-cov MIN_COV     min number of fragments per barcode. barcodes of total
                        fragments less than --min-cov will be filreted before
                        alingment. Note: though this feature is included, we
                        found it barely benefit anything, recommand to set it
                        0. (default: 0)
  --num-threads NUM_THREADS
                        number of alignment threads, also number of threads
                        for sorting a bam file. (default: 1)
  --if-sort IF_SORT     weather to sort the bam file based on the read name
                        (default: True)
  --tmp-folder TMP_FOLDER
                        directory to store temporary files. If not given,
                        snaptools will automaticallygenerate a temporary
                        location to store temporary files (default: None)
  --overwrite OVERWRITE
                        whether to overwrite the output file if it already
                        exists (default: False)
  --verbose VERBOSE     a boolen tag indicates output the progress. (default:
                        True)
```


## snaptools_align-single-end

### Tool Description
Align single-end reads to a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/snaptools:1.4.8--py_0
- **Homepage**: https://github.com/r3fang/SnapTools.git
- **Package**: https://anaconda.org/channels/bioconda/packages/snaptools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snaptools align-single-end [-h] --input-reference INPUT_REFERENCE
                                  --input-fastq1 INPUT_FASTQ1 --output-bam
                                  OUTPUT_BAM [--aligner ALIGNER]
                                  [--path-to-aligner PATH_TO_ALIGNER]
                                  [--aligner-options ALIGNER_OPTIONS [ALIGNER_OPTIONS ...]]
                                  [--read-fastq-command READ_FASTQ_COMMAND]
                                  [--num-threads NUM_THREADS]
                                  [--min-cov MIN_COV] [--if-sort IF_SORT]
                                  [--tmp-folder TMP_FOLDER]
                                  [--overwrite OVERWRITE]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --input-reference INPUT_REFERENCE
                        reference genome file contains the reference genome
                        that reads are mapped against, the genome index must
                        be under the same folder (default: None)
  --input-fastq1 INPUT_FASTQ1
                        fastq file contains R1 reads, currently supports
                        fastq, gz, bz2 file (default: None)
  --output-bam OUTPUT_BAM
                        output bam file contains unfiltered alignments
                        (default: None)

optional inputs:
  --aligner ALIGNER     aligner to use. Currently, snaptools supports bwa,
                        bowtie, bowtie2 and minimap2. (default: bwa)
  --path-to-aligner PATH_TO_ALIGNER
                        path to fold that contains bwa (default: None)
  --aligner-options ALIGNER_OPTIONS [ALIGNER_OPTIONS ...]
                        list of strings indicating options you would like
                        passed to alignerstrongly do not recommand to change
                        unless you know what you are doing. (default: None)
  --read-fastq-command READ_FASTQ_COMMAND
                        command line to execute for each of the input file.
                        This commandshould generate FASTA or FASTQ text and
                        send it to stdout (default: None)
  --num-threads NUM_THREADS
                        number of alignment threads (default: 1)
  --min-cov MIN_COV     min number of fragments per barcode. barcodes of total
                        fragments less than --min-cov will be filreted before
                        alingment. Note: though this feature is included, we
                        found it barely speed up the process, so recommand to
                        set it to be 0. (default: 0)
  --if-sort IF_SORT     weather to sort the bam file based on the read name
                        (default: True)
  --tmp-folder TMP_FOLDER
                        directory to store temporary files. If not given,
                        snaptools will automaticallygenerate a temporary
                        location to store temporary files (default: None)
  --overwrite OVERWRITE
                        whether to overwrite the output file if it already
                        exists (default: False)
```


## snaptools_snap-pre

### Tool Description
Preprocess single-cell ATAC-seq data into snap format.

### Metadata
- **Docker Image**: quay.io/biocontainers/snaptools:1.4.8--py_0
- **Homepage**: https://github.com/r3fang/SnapTools.git
- **Package**: https://anaconda.org/channels/bioconda/packages/snaptools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snaptools snap-pre [-h] --input-file INPUT_FILE --output-snap
                          OUTPUT_SNAP --genome-name GENOME_NAME --genome-size
                          GENOME_SIZE [--barcode-file BARCODE_FILE]
                          [--min-mapq MIN_MAPQ] [--min-flen MIN_FLEN]
                          [--max-flen MAX_FLEN] [--min-cov MIN_COV]
                          [--max-num MAX_NUM] [--keep-chrm KEEP_CHRM]
                          [--keep-single KEEP_SINGLE]
                          [--keep-secondary KEEP_SECONDARY]
                          [--keep-discordant KEEP_DISCORDANT]
                          [--tmp-folder TMP_FOLDER] [--overwrite OVERWRITE]
                          [--qc-file QC_FILE] [--verbose VERBOSE]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --input-file INPUT_FILE
                        input bam, bed or bed.gz file. (default: None)
  --output-snap OUTPUT_SNAP
                        output snap file. (default: None)
  --genome-name GENOME_NAME
                        genome identifier (i.e. hg19, mm10). This tag does not
                        change anything unless merge or compare multiple snap
                        files. (default: None)
  --genome-size GENOME_SIZE
                        a txt file contains corresponding genome sizes. It
                        must be in the following format with the first column
                        the chromsome name and the second column as chromsome
                        length. This tag does not change anything unless merge
                        or compare multiple snap files. (default: None)

optional inputs:
  --barcode-file BARCODE_FILE
                        a txt file contains pre-selected cell barcodes. If
                        --barcode-file is given, snaptools will ignore any
                        barcodes not present in the --barcode-file. If it is
                        None, snaptools will automatically identify barcodes
                        from bam file. The first column of --barcode-file must
                        be the selected barcodes and the other columns could
                        be any attributes of the barcode as desired
                        (`ATGCTCTACTAC attr1 att2`). The attributes, however,
                        will not be kept in the snap file. This tag will be
                        ignored if the output snap file already exists.
                        (default: None)
  --min-mapq MIN_MAPQ   min mappability score. Fargments with mappability
                        score less than --min-mapq will be filtered. (default:
                        10)
  --min-flen MIN_FLEN   min fragment length. Fragments of length shorted than
                        --min-flen will be filtered. (default: 0)
  --max-flen MAX_FLEN   max fragment length. Fragments of length longer than
                        --max-flen will be filtered. (default: 1000)
  --min-cov MIN_COV     min number of fragments per barcode. barcodes of total
                        fragments fewer than --min-cov will be considered when
                        creating the cell x bin count matrix. Note: because
                        the vast majority of barcodes contains very few reads,
                        we found by setting --min-cov, one can remove barcodes
                        of low coverage without wasting time and storage.
                        Please note that this is not selection of good
                        barcodes for downstream clustering analysis, it is
                        only filterationof very low-quality barcodes.
                        (default: 0)
  --max-num MAX_NUM     max number of barcodes to store. Barcodes are sorted
                        based on the coverage and only the top --max-num
                        barcodes will be stored. (default: 1000000)
  --keep-chrm KEEP_CHRM
                        a boolen tag indicates whether to keep fragments
                        mapped to chrM. If set Fasle, fragments aligned to the
                        mitochondrial sequence will be filtered. (default:
                        True)
  --keep-single KEEP_SINGLE
                        a boolen tag indicates whether to keep those reads
                        whose mates are not mapped or missing. If False,
                        unpaired reads will be filtered. If True, unpaired
                        reads will be simply treated as a fragment. Note: for
                        single-end such as scTHS-seq, --keep-single must be
                        True. (default: True)
  --keep-secondary KEEP_SECONDARY
                        a boolen tag indicates whether to keep secondary
                        alignments. If False, secondary alignments will be
                        filtered. If True, a secondary alignments will be
                        treated as fragments just single-end. (default: False)
  --keep-discordant KEEP_DISCORDANT
                        a boolen tag indicates whether to keep discordant read
                        pairs. (default: False)
  --tmp-folder TMP_FOLDER
                        a directory to store temporary files. If not given,
                        snaptools will automatically generate a temporary
                        location to store temporary files. (default: None)
  --overwrite OVERWRITE
                        a boolen tag indicates whether to overwrite the matrix
                        session if it already exists. (default: False)
  --qc-file QC_FILE     a boolen tag indicates whether to create a master qc
                        file. This .qc file contains basic quality control
                        metrics at the bulk level. Quality control is only
                        estimated by selected barcodes only. (default: True)
  --verbose VERBOSE     a boolen tag indicates output the progress. (default:
                        True)
```


## snaptools_snap-add-bmat

### Tool Description
Add cell-by-bin count matrix to snap file.

### Metadata
- **Docker Image**: quay.io/biocontainers/snaptools:1.4.8--py_0
- **Homepage**: https://github.com/r3fang/SnapTools.git
- **Package**: https://anaconda.org/channels/bioconda/packages/snaptools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snaptools snap-add-bmat [-h] --snap-file SNAP_FILE
                               [--bin-size-list BIN_SIZE_LIST [BIN_SIZE_LIST ...]]
                               [--tmp-folder TMP_FOLDER] [--verbose VERBOSE]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --snap-file SNAP_FILE
                        snap file. (default: None)

optional inputs:
  --bin-size-list BIN_SIZE_LIST [BIN_SIZE_LIST ...]
                        a list of bin size(s) to create the cell-by-bin count
                        matrix. The genome will be divided into bins of the
                        equal size of --bin-size-list to create the cell x bin
                        count matrix. If more than one bin size are given,
                        snaptools will generate a list of cell x bin matrices
                        of different resolutions and stored in the same snap
                        file. (default: [5000])
  --tmp-folder TMP_FOLDER
                        a directory to store temporary files. If not given,
                        snaptools will automatically generate a temporary
                        location to store temporary files. (default: None)
  --verbose VERBOSE     a boolen tag indicates output the progress. (default:
                        True)
```


## snaptools_snap-add-pmat

### Tool Description
Add peak information to snap file.

### Metadata
- **Docker Image**: quay.io/biocontainers/snaptools:1.4.8--py_0
- **Homepage**: https://github.com/r3fang/SnapTools.git
- **Package**: https://anaconda.org/channels/bioconda/packages/snaptools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snaptools snap-add-pmat [-h] --snap-file SNAP_FILE --peak-file
                               PEAK_FILE [--buffer-size BUFFER_SIZE]
                               [--tmp-folder TMP_FOLDER] [--verbose VERBOSE]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --snap-file SNAP_FILE
                        snap file. (default: None)
  --peak-file PEAK_FILE
                        bed file contains peaks. (default: None)

optional inputs:
  --buffer-size BUFFER_SIZE
                        max number of barcodes be stored in the memory.
                        (default: 1000)
  --tmp-folder TMP_FOLDER
                        a directory to store temporary files. If not given,
                        snaptools will automatically generate a temporary
                        location to store temporary files. (default: None)
  --verbose VERBOSE     a boolen tag indicates output the progress. (default:
                        True)
```


## snaptools_snap-add-gmat

### Tool Description
Add gene matrix to snap file.

### Metadata
- **Docker Image**: quay.io/biocontainers/snaptools:1.4.8--py_0
- **Homepage**: https://github.com/r3fang/SnapTools.git
- **Package**: https://anaconda.org/channels/bioconda/packages/snaptools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snaptools snap-add-gmat [-h] --snap-file SNAP_FILE --gene-file
                               GENE_FILE [--buffer-size BUFFER_SIZE]
                               [--tmp-folder TMP_FOLDER] [--verbose VERBOSE]

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --snap-file SNAP_FILE
                        snap file. (default: None)
  --gene-file GENE_FILE
                        bed file contains genes. (default: None)

optional inputs:
  --buffer-size BUFFER_SIZE
                        max number of barcodes be stored in the memory.
                        (default: 1000)
  --tmp-folder TMP_FOLDER
                        a directory to store temporary files. If not given,
                        snaptools will automatically generate a temporary
                        location to store temporary files. (default: None)
  --verbose VERBOSE     a boolen tag indicates output the progress. (default:
                        True)
```


## snaptools_snap-del

### Tool Description
Delete a session from a snap file.

### Metadata
- **Docker Image**: quay.io/biocontainers/snaptools:1.4.8--py_0
- **Homepage**: https://github.com/r3fang/SnapTools.git
- **Package**: https://anaconda.org/channels/bioconda/packages/snaptools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snaptools snap-del [-h] --snap-file SNAP_FILE --session-name
                          SESSION_NAME

optional arguments:
  -h, --help            show this help message and exit

required inputs:
  --snap-file SNAP_FILE
                        snap file. (default: None)
  --session-name SESSION_NAME
                        session to be deleted in snap file. 'AM': cell-by-bin
                        matrix. All cell-by-bin matrices will be removed.
                        'PM': cell-by-peak matrix. 'GM': cell-by-gene matrix.
                        (default: None)
```


## Metadata
- **Skill**: generated
