# circtools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| circtools_circtest | Failed | image problem: the R package CircTest that the circtest wrapper loads is not in the image. |
| circtools_conservation | Not completed | Needs network access to the Ensembl REST service and a human, mouse, rat, pig or dog genome with annotation; no small test set fits. |
| circtools_detect | PASS |  |
| circtools_enrich | Not completed | No real RBP CLIP peak BED for the test genome; a trial with exon intervals crashed with KeyError feature_length in the default gene mode. |
| circtools_exon | Not completed | Needs ballgown data, CircTest results and multi-sample detect output; no such real test set was found. |
| circtools_nanopore | Failed | image problem: NanoFilt and samtools are not in the image (circtools nanopore --check reports them missing). |
| circtools_padlock | Failed | image problem: the Python module primer3 is not in the image. |
| circtools_primex | Failed | image problem: the R package primex is not in the image, so the HTML report is empty. |
| circtools_quickcheck | Not completed | Needs per-sample STAR mapping folders plus circtools detect output for several samples; no such real test set was found. |
| circtools_reconstruct | Not completed | Needs a STAR BAM with chimeric reads and a matching exon BED; no such small real test set was found. |
| circtools_sirna | Failed | image problem: the image's Biopython no longer accepts SeqFeature(strand=...), so sirna crashes while drawing. |


## circtools_circtest

### Tool Description
circular RNA statistical testing - Interface to https://github.com/dieterich-lab/CircTest

### Metadata
- **Docker Image**: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/dieterich-lab/circtools
- **Package**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/dieterich-lab/circtools
- **Stars**: N/A
### Original Help Text
```text
usage: circtools [-h] -d DETECT_DIR -l CONDITION_LIST -c CONDITION_COLUMNS -g
                 GROUPING [-r NUM_REPLICATES] [-f MAX_FDR] [-p PERCENTAGE]
                 [-s FILTER_SAMPLE] [-C FILTER_COUNT] [-o OUTPUT_DIRECTORY]
                 [-n OUTPUT_NAME] [-m MAX_PLOTS] [-a LABEL] [-L RANGE]
                 [-O ONLY_NEGATIVE] [-H ADD_HEADER] [-M {colour,bw}]

circular RNA statistical testing - Interface to https://github.com/dieterich-
lab/CircTest

options:
  -h, --help            show this help message and exit

Required:
  -d DETECT_DIR, --detect DETECT_DIR
                        Path to the circtools detect data directory
  -l CONDITION_LIST, --condition-list CONDITION_LIST
                        Comma-separated list of conditions which should be
                        comparedE.g. "RNaseR +","RNaseR -"
  -c CONDITION_COLUMNS, --condition-columns CONDITION_COLUMNS
                        Comma-separated list of 1-based column numbers in the
                        circtools detect output which should be compared; e.g.
                        10,11,12,13,14,15
  -g GROUPING, --grouping GROUPING
                        Comma-separated list describing the relation of the
                        columns specified via -c to the sample names specified
                        via -l; e.g. -g 1,2 and -r 3 would assign sample1 to
                        each even column and sample 2 to each odd column

Processing options:
  -r NUM_REPLICATES, --replicates NUM_REPLICATES
                        Number of replicates used for the circRNA experiment
                        [Default: 3]
  -f MAX_FDR, --max-fdr MAX_FDR
                        Cut-off value for the FDR [Default: 0.05]
  -p PERCENTAGE, --percentage PERCENTAGE
                        The minimum percentage of circRNAs account for the
                        total transcripts in at least one group. [Default:
                        0.01]
  -s FILTER_SAMPLE, --filter-sample FILTER_SAMPLE
                        Number of samples that need to contain the amount of
                        reads specified via -C [Default: 3]
  -C FILTER_COUNT, --filter-count FILTER_COUNT
                        Number of CircRNA reads that each sample specified via
                        -s has to contain [Default: 5]

Output options:
  -o OUTPUT_DIRECTORY, --output-directory OUTPUT_DIRECTORY
                        The output directory for files created by circtools
                        [Default: .]
  -n OUTPUT_NAME, --output-name OUTPUT_NAME
                        The output name for files created by circtools
                        [Default: circtest]
  -m MAX_PLOTS, --max-plots MAX_PLOTS
                        How many of candidates should be plotted as bar chart?
                        [Default: 50]
  -a LABEL, --label LABEL
                        How should the samples be labeled? [Default: Sample]
  -L RANGE, --limit RANGE
                        How should the samples be labeled? [Default: Sample]
  -O ONLY_NEGATIVE, --only-negative-direction ONLY_NEGATIVE
                        Only print entries with negative direction indicator
                        [Default: False]
  -H ADD_HEADER, --add-header ADD_HEADER
                        Add header to CSV output [Default: False]
  -M {colour,bw}, --colour {colour,bw}
                        Can be set to bw to create grayscale graphs for
                        manuscripts
```

## circtools_conservation

### Tool Description
circular RNA conservation analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/dieterich-lab/circtools
- **Package**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/dieterich-lab/circtools
- **Stars**: N/A
### Original Help Text
```text
usage: circtools [-h] [-d DETECT_DIR] -g GTF_FILE -f FASTA_FILE [-C CONFIG]
                 [-O {mm,rn,hs,ss,cl}] [-TS TARGET_SPECIES] [-s SEQUENCE_FILE]
                 [-o OUTPUT_DIR] [-T EXPERIMENT_TITLE] [-t GLOBAL_TEMP_DIR]
                 [-G GENE_LIST [GENE_LIST ...]]
                 [-GL GENE_LIST_FILE [GENE_LIST_FILE ...]]
                 [-i ID_LIST [ID_LIST ...]] [-hg19] [-mm10] [-pairwise_flag]

circular RNA conservation analysis

options:
  -h, --help            show this help message and exit

Input:
  -d DETECT_DIR, --detect-dir DETECT_DIR
                        CircCoordinates file from circtools detect module
  -g GTF_FILE, --gtf-file GTF_FILE
                        GTF file of genome annotation e.g. ENSEMBL
  -f FASTA_FILE, --fasta FASTA_FILE
                        FASTA file with genome sequence (must match
                        annotation)
  -C CONFIG, --config CONFIG
                        config file containing species with their IDs required
                        for different settings
  -O {mm,rn,hs,ss,cl}, --organism {mm,rn,hs,ss,cl}
                        Organism of the study (used for primer BLASTing), rn =
                        Rattus norvegicus, mm = Mus musculus, hs = Homo
                        sapiens, ss = Sus scrofa, cl = Canis lupus familiaris
  -TS TARGET_SPECIES, --target_organism TARGET_SPECIES
                        Target species to be used to calculate conservation
                        score
  -s SEQUENCE_FILE, --sequence SEQUENCE_FILE
                        FASTA file containing the circRNA sequence (exons and
                        introns)

Output options:
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        Output directory (must exist)
  -T EXPERIMENT_TITLE, --title EXPERIMENT_TITLE
                        Title of the experiment for HTML output and file name

Additional options:
  -t GLOBAL_TEMP_DIR, --temp GLOBAL_TEMP_DIR
                        Temporary directory (must exist)
  -G GENE_LIST [GENE_LIST ...], --genes GENE_LIST [GENE_LIST ...]
                        Space-separated list of host gene names. Primers for
                        CircRNAs of those genes will be designed.E.g. -G
                        "CAMSAP1" "RYR2"
  -GL GENE_LIST_FILE [GENE_LIST_FILE ...], --genes-file GENE_LIST_FILE [GENE_LIST_FILE ...]
                        File containing gene names for which primers need to
                        be designed. Need to provide this if -G option not
                        provided
  -i ID_LIST [ID_LIST ...], --id-list ID_LIST [ID_LIST ...]
                        Space-separated list of circRNA IDs. E.g. -i
                        "CAMSAP1_9_135850137_135850461_-"
                        "CAMSAP1_9_135881633_135883078_-"
  -hg19, --hg19         Are given circular co-ordinates for human from hg19
                        assembly?If the flag is on, these will be converted
                        into hg38.
  -mm10, --mm10         Are given circular co-ordinates for mouse from mm10
                        assembly?If the flag is on, these will be converted
                        into mm39.
  -pairwise_flag, --pairwise_flag
                        Should pairwise alignments be performed as well?
                        Additional barplot will be plotted in this case.
```

## circtools_detect

### Tool Description
circular RNA detection

### Metadata
- **Docker Image**: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/dieterich-lab/circtools
- **Package**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/dieterich-lab/circtools
- **Stars**: N/A
### Original Help Text
```text
usage: circtools detect [-h] [--version] [-k] [-T CPU_THREADS] [-O OUT_DIR]
                 [-t TMP_DIR] [-D] [-ss] [-N] [-E {0,1,2,3,4,5,6,7,8,9}]
                 [-m MAX] [-n MIN] [-an ANNOTATE] [-Pi]
                 [-mt1 MATE1 [MATE1 ...]] [-mt2 MATE2 [MATE2 ...]] [-F]
                 [-f FILTERONLY FILTERONLY] [-M] [-R REP_FILE] [-L LENGTH]
                 [-Nr countthreshold replicatethreshold] [-fg] [-G] [-C CIRC]
                 [-B BAM [BAM ...]] [-A REFSEQ] [-cq]
                 [-cql LIST_CIRIQUANT [LIST_CIRIQUANT ...]] [-S CLEANUP]
                 Input [Input ...]

circular RNA detection

positional arguments:
  Input                 Input of the Chimeric.out.junction file from STAR.
                        Alternatively, a sample sheet specifying where your
                        chimeric.out.junction files are, each sample per line,
                        provide with @ prefix (e.g. @samplesheet)

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -k, --keep-temp       Temporary files will not be deleted [default: False]
  -T CPU_THREADS, --threads CPU_THREADS
                        Number of CPU threads used for computation [default:
                        2]
  -O OUT_DIR, --output OUT_DIR
                        Output directory [default: .]
  -t TMP_DIR, --temp TMP_DIR
                        Temporary directory [default: _tmp_circtools/]

Find circRNA Options:
  Options to find circRNAs from STAR output

  -D, --detect          Enable circRNA detection from Chimeric.out.junction
                        files [default: False]
  -ss                   Must be enabled for stranded libraries, aka 'fr-
                        secondstrand' [default: False]
  -N, --nonstrand       The library is non-stranded [default stranded]
  -E {0,1,2,3,4,5,6,7,8,9}, --endTol {0,1,2,3,4,5,6,7,8,9}
                        Maximum base pair tolerance of reads extending over
                        junction sites [default: 5]
  -m MAX, --maximum MAX
                        The maximum length of candidate circRNAs (including
                        introns) [default: 1000000]
  -n MIN, --minimum MIN
                        The minimum length of candidate circRNAs (including
                        introns) [default 30]
  -an ANNOTATE, --annotation ANNOTATE
                        Gene annotation file in GTF/GFF3 format, to annotate
                        circRNAs by their host gene name/identifier
  -Pi, --PE-independent
                        Has to be specified if the paired end mates have also
                        been mapped separately.If specified, -mt1 and -mt2
                        must also be provided [default: False]
  -mt1 MATE1 [MATE1 ...], --mate1 MATE1 [MATE1 ...]
                        For paired end data, Chimeric.out.junction files from
                        mate1 independent mapping result
  -mt2 MATE2 [MATE2 ...], --mate2 MATE2 [MATE2 ...]
                        For paired end data, Chimeric.out.junction files from
                        mate2 independent mapping result

Filtering Options:
  Options to filter the circRNA candidates

  -F, --filter          If specified, the program will perform a recommended
                        filter step on the detection results
  -f FILTERONLY FILTERONLY, --filter-only FILTERONLY FILTERONLY
                        If specified, the program will only filter based on
                        two files provided: 1) a coordinates file [BED6
                        format] and 2) a count file. E.g.: -f example.bed
                        counts.txt
  -M, --chrM            If specified, circRNA candidates located on the
                        mitochondrial chromosome will be removed
  -R REP_FILE, --rep_file REP_FILE
                        Custom repetitive region file in GTF format to filter
                        out circRNA candidates in repetitive regions
  -L LENGTH, --Ln LENGTH
                        Minimum length in base pairs to check for repetitive
                        regions [default 50]
  -Nr countthreshold replicatethreshold
                        countthreshold replicatethreshold [default: 2,5]
  -fg, --filterbygene   If specified, filter also by gene annotation
                        (candidates are not allowed to span more than one
                        gene) default: False

Host gene count Options:
  Options to count host gene expression

  -G, --gene            If specified, the program will count host gene
                        expression given circRNA coordinates [default: False]
  -C CIRC, --circ CIRC  User specified circRNA coordinates, any tab delimited
                        file with first three columns as circRNA coordinates:
                        chr start end, which circtools will use to count host
                        gene expression
  -B BAM [BAM ...], --bam BAM [BAM ...]
                        A file specifying the mapped BAM files from which host
                        gene expression is computed; must have the same order
                        as input chimeric junction files
  -A REFSEQ, --refseq REFSEQ
                        Reference sequence FASTA file

CIRIquant Options:
  Options for merging Circtools and CIRIquant matches

  -cq, --flag_ciriquant
                        If specified, -cql must also be provided. [default:
                        False]
  -cql LIST_CIRIQUANT [LIST_CIRIQUANT ...], --list_ciriquant LIST_CIRIQUANT [LIST_CIRIQUANT ...]
                        Two-column tab-separated text file with list of
                        CIRIquant output files. First column is sample ID and
                        second column is full path to .ciri output file
  -S CLEANUP, --cleanup CLEANUP
                        String to be removed from each sample name so that the
                        names of Circtools and CIRIquant are the same
                        [Default: "_STARmapping.*Chimeric.out.junction"]
```

## circtools_enrich

### Tool Description
circular RNA RBP enrichment tools

### Metadata
- **Docker Image**: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/dieterich-lab/circtools
- **Package**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/dieterich-lab/circtools
- **Stars**: N/A
### Original Help Text
```text
usage: circtools [-h] -c CIRC_RNA_INPUT -b BED_INPUT -a ANNOTATION -g
                 GENOME_FILE [-o OUTPUT_DIRECTORY] [-i NUM_ITERATIONS]
                 [-p NUM_PROCESSES] [-t TMP_DIRECTORY] [-T THRESHOLD]
                 [-P PVAL] [-W WHITELIST] [-F OUTPUT_FILENAME]
                 [-I INCLUDE_FEATURES] [-k KEEP_TEMP]

circular RNA RBP enrichment tools

options:
  -h, --help            show this help message and exit

Required options:
  -c CIRC_RNA_INPUT, --circ-file CIRC_RNA_INPUT
                        Path to the CircCoordinates file generated by
                        circtools detect
  -b BED_INPUT, --bed-input BED_INPUT
                        One or more BED files containing features to overlap
  -a ANNOTATION, --annotation ANNOTATION
                        Genome reference annotation file used to not shuffle
                        into intragenic regions
  -g GENOME_FILE, --genome GENOME_FILE
                        Genome file for use with bedtools shuffle. See
                        bedtools man page for details.

Additional options:
  -o OUTPUT_DIRECTORY, --output OUTPUT_DIRECTORY
                        The output folder for files created by circtools
                        [default: .]
  -i NUM_ITERATIONS, --iterations NUM_ITERATIONS
                        Number of iterations for CLIP shuffling [default:
                        1000]
  -p NUM_PROCESSES, --processes NUM_PROCESSES
                        Number of threads to distribute the work to
  -t TMP_DIRECTORY, --temp TMP_DIRECTORY
                        Temporary directory used by pybedtools
  -T THRESHOLD, --threshold THRESHOLD
                        p-value cutoff
  -P PVAL, --pval PVAL  p-value cutoff
  -W WHITELIST, --white-list WHITELIST
                        Path to a BED file containing coordinates of exons
                        that should be exclusively taken into account when
                        generating the enrichment. These may be exons produced
                        by the exonmodule that show enrichment in the RNase R
                        treated sample.
  -F OUTPUT_FILENAME, --output-filename OUTPUT_FILENAME
                        Defines the output file prefix [default: output]
  -I INCLUDE_FEATURES, --include-features INCLUDE_FEATURES
                        Defines the the features which should be used for
                        shuffling. May be specified multiple times. [default:
                        gene - shuffle over the the whole gene region]
  -k KEEP_TEMP, --keep-temp KEEP_TEMP
                        Keep temporary files created by circtools/bedtools
                        [default: no]
```

## circtools_exon

### Tool Description
circular RNA exon usage analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/dieterich-lab/circtools
- **Package**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/dieterich-lab/circtools
- **Stars**: N/A
### Original Help Text
```text
usage: circtools [-h] -d DETECT_DIR -l CONDITION_LIST -c CONDITION_COLUMNS -g
                 GROUPING -r REPLICATES -b BALLGOWN_DATA -G GTF_FILE -C
                 CIRCTEST_FILE [-H HAS_HEADER] [-o OUTPUT_DIRECTORY]
                 [-n OUTPUT_PREFIX] -s {hs,mm,rn,ss}

circular RNA exon usage analysis

options:
  -h, --help            show this help message and exit

Required:
  -d DETECT_DIR, --detect DETECT_DIR
                        Path to the circtools detect data directory
  -l CONDITION_LIST, --condition-list CONDITION_LIST
                        Comma-separated list of conditions which should be
                        comparedE.g. "RNaseR +","RNaseR -"
  -c CONDITION_COLUMNS, --condition-columns CONDITION_COLUMNS
                        Comma-separated list of 1-based column numbers in the
                        circtools detect output which should be compared; e.g.
                        10,11,12,13,14,15
  -g GROUPING, --grouping GROUPING
                        Comma-separated list describing the relation of the
                        columns specified via -c to the sample names specified
                        via -l; e.g. -g 1,2 and -r 3 would assign sample1 to
                        each even column and sample 2 to each odd column
  -r REPLICATES, --replicates REPLICATES
                        Comma-separated list describing the relation of the
                        samples specified via -g to the sample names specified
                        via -l; e.g. -g 1,2 and -r 3 would assign sample1 to
                        each even column and sample 2 to each odd column
  -b BALLGOWN_DATA, --ballgown-data BALLGOWN_DATA
                        Path to the ballgown data directory
  -G GTF_FILE, --gtf-file GTF_FILE
                        Path to the GTF file containing the employed genome
                        annotation
  -C CIRCTEST_FILE, --circtest-output CIRCTEST_FILE
                        Path to the CircTest CSV file containing the CircTest
                        results

Additional options:
  -H HAS_HEADER, --has-header HAS_HEADER
                        Do the CircTest result files have a header? [Default:
                        No]

Output options:
  -o OUTPUT_DIRECTORY, --output-directory OUTPUT_DIRECTORY
                        The output directory for files created by circtools
                        [Default: .]
  -n OUTPUT_PREFIX, --output-prefix OUTPUT_PREFIX
                        The output name (prefix) for files created by
                        circtools [Default: exon_analysis]
  -s {hs,mm,rn,ss}, --species {hs,mm,rn,ss}
                        Species code: hs = Homo sapiens, mm = Mus musculus, rn
                        = Rattus norvegicus, ss = Sus scrofa
```

## circtools_nanopore

### Tool Description
circular RNA detection in Oxford Nanopore data

### Metadata
- **Docker Image**: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/dieterich-lab/circtools
- **Package**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/dieterich-lab/circtools
- **Stars**: N/A
### Original Help Text
```text
usage: circtools [-h] (-r | -c | -d) [-s SAMPLE] [-R REFERENCE_PATH]
                 [-O OUTPUT_PATH]
                 [-C {hg19,hg38,mm9,mm10,rn6,rn7,susScr11,canFam6}]
                 [-t THREADS] [-D] [-k]

circular RNA detection in Oxford Nanopore data

options:
  -h, --help            show this help message and exit
  -r, --run             Run the analysis
  -c, --check           Check the installation for required software.
  -d, --download        Download third-party data, such as genomes, required
                        for the analysis.

Options:
  -s SAMPLE, --sample SAMPLE
                        Provide a sample input .fq.gz file that should be
                        processed.
  -R REFERENCE_PATH, --reference-path REFERENCE_PATH
                        Provide a path for where the reference data is
                        located. Default is './data'.
  -O OUTPUT_PATH, --output OUTPUT_PATH
                        Provide a path for where the output data is stored.
  -C {hg19,hg38,mm9,mm10,rn6,rn7,susScr11,canFam6}, --config {hg19,hg38,mm9,mm10,rn6,rn7,susScr11,canFam6}
                        Required. Select which genome build the sample that is
                        from, and specify which genome reference files should
                        be used.
  -t THREADS, --threads THREADS
                        Number of threads for parallel steps. Default: 4.
  -D, --dry-run         Perform all of the input checks without starting the
                        detection scripts.
  -k, --keep-temp       Keep all of the temporary files.
```

## circtools_padlock

### Tool Description
circular and linear RNA padlock probe design

### Metadata
- **Docker Image**: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/dieterich-lab/circtools
- **Package**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/dieterich-lab/circtools
- **Stars**: N/A
### Original Help Text
```text
usage: circtools [-h] [-d DETECT_DIR] -g GTF_FILE -f FASTA_FILE
                 [-O {mm,rn,hs,ss}] [-s SEQUENCE_FILE] [-o OUTPUT_DIR]
                 [-T EXPERIMENT_TITLE] [-t GLOBAL_TEMP_DIR]
                 [-G GENE_LIST [GENE_LIST ...]]
                 [-GL GENE_LIST_FILE [GENE_LIST_FILE ...]]
                 [-i ID_LIST [ID_LIST ...]] [-b] [-n NUM_PAIRS] [-r RNA_TYPE]
                 [-svg]

circular and linear RNA padlock probe design

options:
  -h, --help            show this help message and exit

Input:
  -d DETECT_DIR, --detect-dir DETECT_DIR
                        CircCoordinates file from circtools detect module
  -g GTF_FILE, --gtf-file GTF_FILE
                        GTF file of genome annotation e.g. ENSEMBL
  -f FASTA_FILE, --fasta FASTA_FILE
                        FASTA file with genome sequence (must match
                        annotation)
  -O {mm,rn,hs,ss}, --organism {mm,rn,hs,ss}
                        Organism of the study (used for primer BLASTing), rn =
                        Rattus norvegicus, mm = Mus musculus, hs = Homo
                        sapiens, ss = Sus scrofa
  -s SEQUENCE_FILE, --sequence SEQUENCE_FILE
                        FASTA file containing the circRNA sequence (exons and
                        introns)

Output options:
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        Output directory (must exist)
  -T EXPERIMENT_TITLE, --title EXPERIMENT_TITLE
                        Title of the experiment for HTML output and file name

Additional options:
  -t GLOBAL_TEMP_DIR, --temp GLOBAL_TEMP_DIR
                        Temporary directory (must exist)
  -G GENE_LIST [GENE_LIST ...], --genes GENE_LIST [GENE_LIST ...]
                        Space-separated list of host gene names. Primers for
                        CircRNAs of those genes will be designed.E.g. -G
                        "CAMSAP1" "RYR2"
  -GL GENE_LIST_FILE [GENE_LIST_FILE ...], --genes-file GENE_LIST_FILE [GENE_LIST_FILE ...]
                        File containing gene names for which primers need to
                        be designed. Need to provide this if -G option not
                        provided
  -i ID_LIST [ID_LIST ...], --id-list ID_LIST [ID_LIST ...]
                        Space-separated list of circRNA IDs. E.g. -i
                        "CAMSAP1_9_135850137_135850461_-"
                        "CAMSAP1_9_135881633_135883078_-"
  -b, --no-blast        Should primers be BLASTED? Even if selected yes here,
                        not more than 50 primers willbe sent to BLAST in any
                        case.
  -n NUM_PAIRS, --num-pairs NUM_PAIRS
                        Number of primer pairs to be designed
  -r RNA_TYPE, --rna-type RNA_TYPE
                        Flag for RNA type for which you want to generated
                        padlock probes . 0 for Circular RNAs only, 1 for
                        Linear RNAs only and 2 for Both. DEFAULT 2
  -svg, --no-svg        Should the SVG files for graphical representation be
                        generated?
```

## circtools_primex

### Tool Description
circular RNA primer design

### Metadata
- **Docker Image**: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/dieterich-lab/circtools
- **Package**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/dieterich-lab/circtools
- **Stars**: N/A
### Original Help Text
```text
usage: circtools [-h] -d DETECT_DIR -g GTF_FILE -f FASTA_FILE
                 [-O {mm,rn,hs,ss}] [-s SEQUENCE_FILE] [-o OUTPUT_DIR]
                 [-T EXPERIMENT_TITLE] [-t GLOBAL_TEMP_DIR]
                 [-G GENE_LIST [GENE_LIST ...]]
                 [-p PRODUCT_SIZE [PRODUCT_SIZE ...]]
                 [-i ID_LIST [ID_LIST ...]] [-j {r,n,f}] [-b] [-n NUM_PAIRS]

circular RNA primer design

options:
  -h, --help            show this help message and exit

Input:
  -d DETECT_DIR, --detect-dir DETECT_DIR
                        CircCoordinates file from circtools detect module
  -g GTF_FILE, --gtf-file GTF_FILE
                        GTF file of genome annotation e.g. ENSEMBL
  -f FASTA_FILE, --fasta FASTA_FILE
                        FASTA file with genome sequence (must match
                        annotation)
  -O {mm,rn,hs,ss}, --organism {mm,rn,hs,ss}
                        Organism of the study (used for primer BLASTing), rn =
                        Rattus norvegicus, mm = Mus musculus, hs = Homo
                        sapiens, ss = Sus scrofa
  -s SEQUENCE_FILE, --sequence SEQUENCE_FILE
                        FASTA file containing the circRNA sequence (exons and
                        introns)

Output options:
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        Output directory (must exist)
  -T EXPERIMENT_TITLE, --title EXPERIMENT_TITLE
                        Title of the experiment for HTML output and file name

Additional options:
  -t GLOBAL_TEMP_DIR, --temp GLOBAL_TEMP_DIR
                        Temporary directory (must exist)
  -G GENE_LIST [GENE_LIST ...], --genes GENE_LIST [GENE_LIST ...]
                        Space-separated list of host gene names. Primers for
                        CircRNAs of those genes will be designed.E.g. -G
                        "CAMSAP1" "RYR2"
  -p PRODUCT_SIZE [PRODUCT_SIZE ...], --product-size PRODUCT_SIZE [PRODUCT_SIZE ...]
                        Space-separated range for the desired PCR product.
                        E.g. -p 80 160 [default]
  -i ID_LIST [ID_LIST ...], --id-list ID_LIST [ID_LIST ...]
                        Space-separated list of circRNA IDs. E.g. -i
                        "CAMSAP1_9_135850137_135850461_-"
                        "CAMSAP1_9_135881633_135883078_-"
  -j {r,n,f}, --junction {r,n,f}
                        Should the forward [f] or reverse [r] primer be
                        located on the BSJ? [Default: n]
  -b, --no-blast        Should primers be BLASTED? Even if selected yes here,
                        not more than 50 primers willbe sent to BLAST in any
                        case.
  -n NUM_PAIRS, --num-pairs NUM_PAIRS
                        Number of primer pairs to be designed
```

## circtools_quickcheck

### Tool Description
circular RNA sequencing library quality assessment

### Metadata
- **Docker Image**: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/dieterich-lab/circtools
- **Package**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/dieterich-lab/circtools
- **Stars**: N/A
### Original Help Text
```text
usage: circtools [-h] -d DETECT_DIR -s STAR_DIR -l CONDITION_LIST -g GROUPING
                 [-o OUTPUT_DIRECTORY] [-n OUTPUT_NAME] [-c {colour,bw}]
                 [-C CLEANUP] [-S STARFOLDER] [-L REMOVE_SUFFIX_CHARS]
                 [-F REMOVE_PREFIX_CHARS] [-R REMOVE_COLUMNS]

circular RNA sequencing library quality assessment

options:
  -h, --help            show this help message and exit

Required:
  -d DETECT_DIR, --detect DETECT_DIR
                        Path to the circtools detect data directory
  -s STAR_DIR, --star STAR_DIR
                        Path to the base STAR data directory containing sub-
                        folders with per-sample mappings
  -l CONDITION_LIST, --condition-list CONDITION_LIST
                        Comma-separated list of conditions which should be
                        comparedE.g. "RNaseR +","RNaseR -"
  -g GROUPING, --grouping GROUPING
                        Comma-separated list describing the relation of the
                        columns specified via -c to the sample names specified
                        via -l; e.g. -g 1,2 and -r 3 would assign sample1 to
                        each even column and sample 2 to each odd column

Output options:
  -o OUTPUT_DIRECTORY, --output-directory OUTPUT_DIRECTORY
                        The output directory for files created by circtools
                        [Default: ./]
  -n OUTPUT_NAME, --output-name OUTPUT_NAME
                        The output name for files created by circtools
                        [Default: quickcheck]
  -c {colour,bw}, --colour {colour,bw}
                        Can be set to bw to create grayscale graphs for
                        manuscripts
  -C CLEANUP, --cleanup CLEANUP
                        String to be removed from each sample name [Default:
                        "_STARmapping.*Chimeric.out.junction"]
  -S STARFOLDER, --starfolder STARFOLDER
                        Suffix string of the STAR folders[Default: ""]
  -L REMOVE_SUFFIX_CHARS, --remove-last REMOVE_SUFFIX_CHARS
                        Remove last N characters from each column name of the
                        circtools detect input data [Default: 0]
  -F REMOVE_PREFIX_CHARS, --remove-first REMOVE_PREFIX_CHARS
                        Remove first N characters from each column name of the
                        circtools detect input data [Default: 0]
  -R REMOVE_COLUMNS, --remove-columns REMOVE_COLUMNS
                        Comma-separated list of columns in the circtools
                        detect data files to not includes in the check
```

## circtools_reconstruct

### Tool Description
circular RNA reconstruction

### Metadata
- **Docker Image**: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/dieterich-lab/circtools
- **Package**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/dieterich-lab/circtools
- **Stars**: N/A
### Original Help Text
```text
usage: circtools [-h] [-C CIRCLEFILE] [-D CIRCRNACOUNT] [-J CHIMERIC_JUNCTION]
                 [-F MATE1] [-R MATE2] -B BAMFILE -A BEDFILE [-O OUT_FOLDER]
                 -N SAMPLE [-r READS] [-q MAPQ] [-c SPLIT_CHARACTER]
                 [-e EXON_INDEX] [-p REF_PLATFORM] [-s SKIPPED_STEPS]
                 [-T TMP_FOLDER] [-P NUM_CPUS]

circular RNA reconstruction

options:
  -h, --help            show this help message and exit
  -C CIRCLEFILE, --circIDs CIRCLEFILE
                        Tab-separated file
                        chr:start_end(tab)read1,read2,read3.
  -D CIRCRNACOUNT, --detect CIRCRNACOUNT
                        If you mapped with STAR and are using step1 you need
                        to provide a list of circle ids (CircRNACount or
                        CircCoordinates from circtools detect)You must supply
                        either -C or -D
  -J CHIMERIC_JUNCTION, --chimericJunctions CHIMERIC_JUNCTION
                        If you mapped with STAR and are using step1 you need
                        to provide the paired end Chimeric.junction.out file
                        here
  -F MATE1, --mate1 MATE1
                        If you mapped with STAR and are using step1 you need
                        to provide the mate1.Chimeric.junction.out file here
                        (optional if ends were mapped separately)
  -R MATE2, --mate2 MATE2
                        If you mapped with STAR and are using step1 you need
                        to provide the mate2.Chimeric.junction.out file here
                        (optional if ends were mapped separately)
  -B BAMFILE, --bamfile BAMFILE
                        BAM file containing chimeric reads, linear reads may
                        be in it but are not required.
  -A BEDFILE, --annotation BEDFILE
                        bed formatted feature file including exons.
  -O OUT_FOLDER, --outFolder OUT_FOLDER
                        Output folder. There will be a sub folder for the
                        sample containing a BAM file for each circle.
  -N SAMPLE, --sampleName SAMPLE
                        sample name to title every thing.
  -r READS, --thresholdReads READS
                        Circle has to have at least <r> reads to be analysed.
  -q MAPQ, --thresholdMapq MAPQ
                        MAPQ cutoff, only reads passing this threshold will be
                        written to circle BAM file.
  -c SPLIT_CHARACTER, --splitCharacter SPLIT_CHARACTER
                        feature name separator.
  -e EXON_INDEX, --exonIndex EXON_INDEX
                        Field indicating the exon number after splitting
                        feature name by split_character (for the annotation
                        file).
  -p REF_PLATFORM, --annotationFormat REF_PLATFORM
                        Specifies the annotation platform which was used
                        (refseq or ensembl)
  -s SKIPPED_STEPS, --skipSteps SKIPPED_STEPS
                        Comma separated list of steps that should be skipped
                        (e.g. step3,step4,step6)
  -T TMP_FOLDER, --tmp TMP_FOLDER
                        Folder to store temporary files generated by
                        pybedtools.
  -P NUM_CPUS, --cpus NUM_CPUS
                        Number of CPUs used.
```

## circtools_sirna

### Tool Description
circular RNA siRNA design

### Metadata
- **Docker Image**: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/dieterich-lab/circtools
- **Package**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/circtools/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/dieterich-lab/circtools
- **Stars**: N/A
### Original Help Text
```text
usage: circtools [-h] -d DETECT_FILE -g GTF_FILE -f FASTA_FILE
                 [-O {mm,hs,rn,ss}] [-s SEQUENCE_FILE] [-fp FINDPARAMETER]
                 [-op OVERLAPPARAMETER] [-gl GLENGTH] [-tl TLENGTH]
                 [-al ALENGTH] [-mt MISMATCHTOLERANCE]
                 [-mthr MISMATCHTHRESHHOLD] [-sm] [-hp OVERHANGPARAMETER]
                 [-o OUTPUT_DIR] [-T EXPERIMENT_TITLE] [-t GLOBAL_TEMP_DIR]
                 [-tr TARGET] [-G GENE_LIST [GENE_LIST ...]]
                 [-i ID_LIST [ID_LIST ...]] [-b]

circular RNA siRNA design

options:
  -h, --help            show this help message and exit

Input:
  -d DETECT_FILE, --detect-file DETECT_FILE
                        CircCoordinates file from circtools detect module
  -g GTF_FILE, --gtf-file GTF_FILE
                        GTF file of genome annotation e.g. ENSEMBL
  -f FASTA_FILE, --fasta FASTA_FILE
                        FASTA file with genome sequence (must match
                        annotation)
  -O {mm,hs,rn,ss}, --organism {mm,hs,rn,ss}
                        Organism of the study (used for primer BLASTing), mm =
                        Mus musculus, hs = Homo sapiens, rn = Rattus
                        norvegicus, ss = Sus Scrofa
  -s SEQUENCE_FILE, --sequence SEQUENCE_FILE
                        FASTA file containing the circRNA sequence (exons and
                        introns)
  -fp FINDPARAMETER, --find_parameter FINDPARAMETER
                        Rule used to find siRNA (0 for Ui-Tei, 1 for Reynolds,
                        2 for multi-length search mode (Ui-Tei))
  -op OVERLAPPARAMETER, --overlap_parameter OVERLAPPARAMETER
                        Minimum number of base pair overlap over the BSJ for
                        all siRNAs
  -gl GLENGTH, --G_repeat_length GLENGTH
                        Maximum number of consecutive Gs in an siRNA sequence
                        that will be tolerated
  -tl TLENGTH, --T_repeat_length TLENGTH
                        Maximum number of consecutive Ts in an siRNA sequence
                        that will be tolerated
  -al ALENGTH, --A_repeat_length ALENGTH
                        Maximum number of consecutive As in an siRNA sequence
                        that will be tolerated
  -mt MISMATCHTOLERANCE, --Mismatch_tolerance MISMATCHTOLERANCE
                        Minimum number of mismatches a siRNA has to have
                        against each blast result
  -mthr MISMATCHTHRESHHOLD, --Mismatch_threshhold MISMATCHTHRESHHOLD
                        Maximum number of blast results complementary to siRNA
                        (containing fewer mismatches than mismatch tolerance)
                        that will be tolerated
  -sm, --Seed_mismatch  If chosen, this option means that the minimum number
                        of mismatches (mismatch tolerance) must be in the seed
                        region of the siRNA
  -hp OVERHANGPARAMETER, --overhang_parameter OVERHANGPARAMETER
                        Determines the type of overhang that is added to the
                        siRNA (0 for UU overhang, 1 for TT overhang, blank for
                        no overhang)

Output options:
  -o OUTPUT_DIR, --output OUTPUT_DIR
                        Output directory (must exist)
  -T EXPERIMENT_TITLE, --title EXPERIMENT_TITLE
                        Title of the experiment for HTML output and file name

Additional options:
  -t GLOBAL_TEMP_DIR, --temp GLOBAL_TEMP_DIR
                        Temporary directory (must exist)
  -tr TARGET, --target TARGET
                        Which strand the siRNA should target (ex: supplying
                        anti-sense creates an anti-sense guide RNA targeting
                        the sense strand)
  -G GENE_LIST [GENE_LIST ...], --genes GENE_LIST [GENE_LIST ...]
                        Space-separated list of host gene names. siRNAs for
                        CircRNAs of those genes will be designed.E.g. -G
                        "Camsap1" "Ryr2"
  -i ID_LIST [ID_LIST ...], --id-list ID_LIST [ID_LIST ...]
                        Space-separated list of circRNA IDs. E.g. -i
                        "CAMSAP1_9_135850137_135850461_-"
                        "CAMSAP1_9_135881633_135883078_-"
  -b, --no-blast        Should siRNAs be BLASTED? (Choosing this option means
                        siRNAs won't be blasted)
```
