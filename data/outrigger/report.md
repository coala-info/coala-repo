# outrigger CWL Generation Report

## outrigger_index

### Tool Description
Build an index of alternative splicing events from splice junction data.

### Metadata
- **Docker Image**: quay.io/biocontainers/outrigger:1.1.1--py35_0
- **Homepage**: https://yeolab.github.io/outrigger
- **Package**: https://anaconda.org/channels/bioconda/packages/outrigger/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/outrigger/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: outrigger index [-h] [-o OUTPUT]
                       (-j [SJ_OUT_TAB [SJ_OUT_TAB ...]] | -c JUNCTION_READS_CSV | -b [BAM [BAM ...]])
                       [-m MIN_READS] [--ignore-multimapping]
                       [-l MAX_DE_NOVO_EXON_LENGTH]
                       (-g GTF_FILENAME | -d GFFUTILS_DB) [--debug]
                       [--n-jobs N_JOBS] [--low-memory]
                       [--splice-types SPLICE_TYPES] [--force | --resume]

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Name of the folder where you saved the output from
                        "outrigger index" (default is ./outrigger_output,
                        which is relative to the directory where you called
                        the program)". You will need this file for the next
                        step, "outrigger psi"
  -j [SJ_OUT_TAB [SJ_OUT_TAB ...]], --sj-out-tab [SJ_OUT_TAB [SJ_OUT_TAB ...]]
                        SJ.out.tab files from STAR aligner output. Not
                        required if you specify "--compiled-junction-reads"
  -c JUNCTION_READS_CSV, --junction-reads-csv JUNCTION_READS_CSV
                        Name of the splice junction files to detect novel
                        exons and build an index of alternative splicing
                        events from. Not required if you specify SJ.out.tab
                        file with '--sj-out-tab'
  -b [BAM [BAM ...]], --bam [BAM [BAM ...]]
                        Location of bam files to use for finding events.
  -m MIN_READS, --min-reads MIN_READS
                        Minimum number of reads per junction for that junction
                        to count in creating the index of splicing events
                        (default=10)
  --ignore-multimapping
                        Applies to STAR SJ.out.tab files only. If this flag is
                        used, then do not include reads that mapped to
                        multiple locations in the genome, not uniquely to a
                        locus, in the read count for a junction. If inputting
                        "bam" files, then this means that reads with a mapping
                        quality (MAPQ) of less than 255 are considered
                        "multimapped." This is the same thing as what the STAR
                        aligner does. By default, this is off, and all reads
                        are used.
  -l MAX_DE_NOVO_EXON_LENGTH, --max-de-novo-exon-length MAX_DE_NOVO_EXON_LENGTH
                        Maximum length of an exon detected *de novo* from the
                        dataset. This is to prevent multiple kilobase long
                        exons from being accidentally created. (default=100)
  -g GTF_FILENAME, --gtf-filename GTF_FILENAME
                        Name of the gtf file you want to use. If a gffutils
                        feature database doesn't already exist at this
                        location plus '.db' (e.g. if your gtf is
                        gencode.v19.annotation.gtf, then the database is
                        inferred to be gencode.v19.annotation.gtf.db), then a
                        database will be auto-created. Not required if you
                        provide a pre-built database with '--gffutils-db'
  -d GFFUTILS_DB, --gffutils-db GFFUTILS_DB
                        Name of the gffutils database file you want to use.
                        The exon IDs defined here will be used in the function
                        when creating splicing event names. Not required if
                        you provide a gtf file with '--gtf-filename'
  --debug               If given, print debugging logging information to
                        standard out (Warning: LOTS of output. Not recommended
                        unless you think something is going wrong)
  --n-jobs N_JOBS       Number of threads to use when parallelizing exon
                        finding and file reading. Default is -1, which means
                        to use as many threads as are available.
  --low-memory          If set, then use a smaller memory footprint. By
                        default, this is off.
  --splice-types SPLICE_TYPES
                        Which splice types to find. By default, "all" are used
                        which at this point is skipped exon (SE) and mutually
                        exclusive exon (MXE) events. Can also specify only
                        one, e.g. "se" or both "se,mxe"
  --force               If the 'outrigger index' command was interrupted,
                        there will be intermediate files remaining. If you
                        wish to restart outrigger and overwrite them all, use
                        this flag. If you want to continue from where you left
                        off, use the '--resume' flag. If neither is specified,
                        the program exits and complains to the user.
  --resume              If the 'outrigger index' command was interrupted,
                        there will be intermediate files remaining. If you
                        want to continue from where you left off, use this
                        flag. The default action is to do nothing and ask the
                        user for input.
```


## outrigger_database

### Tool Description
outrigger: error: invalid choice: 'database' (choose from 'index', 'validate', 'psi')

### Metadata
- **Docker Image**: quay.io/biocontainers/outrigger:1.1.1--py35_0
- **Homepage**: https://yeolab.github.io/outrigger
- **Package**: https://anaconda.org/channels/bioconda/packages/outrigger/overview
- **Validation**: PASS

### Original Help Text
```text
usage: outrigger [-h] [--version] {index,validate,psi} ...
outrigger: error: invalid choice: 'database' (choose from 'index', 'validate', 'psi')
```


## outrigger_validate

### Tool Description
Validate splice site sequences against a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/outrigger:1.1.1--py35_0
- **Homepage**: https://yeolab.github.io/outrigger
- **Package**: https://anaconda.org/channels/bioconda/packages/outrigger/overview
- **Validation**: PASS

### Original Help Text
```text
usage: outrigger validate [-h] -f FASTA -g GENOME [-i INDEX] [-o OUTPUT]
                          [-s VALID_SPLICE_SITES] [--debug] [--low-memory]

optional arguments:
  -h, --help            show this help message and exit
  -f FASTA, --fasta FASTA
                        Location of the genome fasta file for which to get the
                        splice site sequences from
  -g GENOME, --genome GENOME
                        Either the genome name (e.g. "mm10" or "hg19") or
                        location of the genome chromosome sizes file for
                        "bedtools flank" to make sure we do not accidentally
                        ask for genome positions that are outside of the
                        defined range
  -i INDEX, --index INDEX
                        Name of the folder where you saved the output from
                        "outrigger index" (default is
                        ./outrigger_output/index, which is relative to the
                        directory where you called this program, assuming you
                        have called "outrigger psi" in the same folder as you
                        called "outrigger index").
  -o OUTPUT, --output OUTPUT
                        Name of the folder where you saved the output from
                        "outrigger index" (default is ./outrigger_output,
                        which is relative to the directory where you called
                        the program).
  -s VALID_SPLICE_SITES, --valid-splice-sites VALID_SPLICE_SITES
                        The intron-definition based splice sites that are
                        allowed in the data, which is in the format 5'/3' of
                        the intron, and separated by commas for different
                        types. Default is GT/AG,GC/AG,AT/AC, which are the
                        major and minor spliceosome splice sites in mammalian
                        systems.
  --debug               If given, print debugging logging information to
                        standard out
  --low-memory          If set, then use a smaller memory footprint. By
                        default, this is off.
```


## outrigger_correct

### Tool Description
outrigger: error: invalid choice: 'correct' (choose from 'index', 'validate', 'psi')

### Metadata
- **Docker Image**: quay.io/biocontainers/outrigger:1.1.1--py35_0
- **Homepage**: https://yeolab.github.io/outrigger
- **Package**: https://anaconda.org/channels/bioconda/packages/outrigger/overview
- **Validation**: PASS

### Original Help Text
```text
usage: outrigger [-h] [--version] {index,validate,psi} ...
outrigger: error: invalid choice: 'correct' (choose from 'index', 'validate', 'psi')
```


## outrigger_psi

### Tool Description
Calculate PSI scores

### Metadata
- **Docker Image**: quay.io/biocontainers/outrigger:1.1.1--py35_0
- **Homepage**: https://yeolab.github.io/outrigger
- **Package**: https://anaconda.org/channels/bioconda/packages/outrigger/overview
- **Validation**: PASS

### Original Help Text
```text
usage: outrigger psi [-h] [-i INDEX] [-o OUTPUT]
                     [-c JUNCTION_READS_CSV | -j [SJ_OUT_TAB [SJ_OUT_TAB ...]]
                     | -b [BAM [BAM ...]]] [-m MIN_READS] [-e METHOD]
                     [-u UNEVEN_COVERAGE_MULTIPLIER] [--ignore-multimapping]
                     [--reads-col READS_COL] [--sample-id-col SAMPLE_ID_COL]
                     [--junction-id-col JUNCTION_ID_COL] [--debug]
                     [--n-jobs N_JOBS] [--low-memory]

optional arguments:
  -h, --help            show this help message and exit
  -i INDEX, --index INDEX
                        Name of the folder where you saved the output from
                        "outrigger index" (default is
                        ./outrigger_output/index, which is relative to the
                        directory where you called this program, assuming you
                        have called "outrigger psi" in the same folder as you
                        called "outrigger index")
  -o OUTPUT, --output OUTPUT
                        Name of the folder where you saved the output from
                        "outrigger index" (default is ./outrigger_output,
                        which is relative to the directory where you called
                        the program). Cannot specify both an --index and
                        --output with "psi"
  -c JUNCTION_READS_CSV, --junction-reads-csv JUNCTION_READS_CSV
                        Name of the compiled splice junction file to calculate
                        psi scores on. Default is the '--output' folder's
                        junctions/reads.csv file. Not required if you specify
                        SJ.out.tab files with '--sj-out-tab'
  -j [SJ_OUT_TAB [SJ_OUT_TAB ...]], --sj-out-tab [SJ_OUT_TAB [SJ_OUT_TAB ...]]
                        SJ.out.tab files from STAR aligner output. Not
                        required if you specify a file with "--compiled-
                        junction-reads"
  -b [BAM [BAM ...]], --bam [BAM [BAM ...]]
                        Bam files to use to calculate psi on
  -m MIN_READS, --min-reads MIN_READS
                        Minimum number of reads per junction for calculating
                        Psi (default=10)
  -e METHOD, --method METHOD
                        How to deal with multiple junctions on an event - take
                        the mean (default) or the min? (the other option)
  -u UNEVEN_COVERAGE_MULTIPLIER, --uneven-coverage-multiplier UNEVEN_COVERAGE_MULTIPLIER
                        If a junction one one side of an exon is bigger than
                        the other side of the exon by this amount, (default is
                        10, so 10x bigger), then do not use this event
  --ignore-multimapping
                        Applies to STAR SJ.out.tab files only. If this flag is
                        used, then do not include reads that mapped to
                        multiple locations in the genome, not uniquely to a
                        locus, in the read count for a junction. If inputting
                        "bam" files, then this means that reads with a mapping
                        quality (MAPQ) of less than 255 are considered
                        "multimapped." This is the same thing as what the STAR
                        aligner does. By default, this is off, and all reads
                        are used.
  --reads-col READS_COL
                        Name of column in --splice-junction-csv containing
                        reads to use. (default='reads')
  --sample-id-col SAMPLE_ID_COL
                        Name of column in --splice-junction-csv containing
                        sample ids to use. (default='sample_id')
  --junction-id-col JUNCTION_ID_COL
                        Name of column in --splice-junction-csv containing the
                        ID of the junction to use. Must match exactly with the
                        junctions in the index.(default='junction_id')
  --debug               If given, print debugging logging information to
                        standard out
  --n-jobs N_JOBS       Number of threads to use when parallelizing psi
                        calculation and file reading. Default is -1, which
                        means to use as many threads as are available.
  --low-memory          If set, then use a smaller memory footprint. By
                        default, this is off.
```


## outrigger_splicing

### Tool Description
outrigger: error: invalid choice: 'splicing' (choose from 'index', 'validate', 'psi')

### Metadata
- **Docker Image**: quay.io/biocontainers/outrigger:1.1.1--py35_0
- **Homepage**: https://yeolab.github.io/outrigger
- **Package**: https://anaconda.org/channels/bioconda/packages/outrigger/overview
- **Validation**: PASS

### Original Help Text
```text
usage: outrigger [-h] [--version] {index,validate,psi} ...
outrigger: error: invalid choice: 'splicing' (choose from 'index', 'validate', 'psi')
```

