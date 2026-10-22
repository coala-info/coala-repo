# talon CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| talon | PASS |  |
| talon_abundance | PASS |  |
| talon_create_GTF | PASS |  |
| talon_create_adata | PASS |  |
| talon_fetch_reads | PASS |  |
| talon_filter_transcripts | PASS |  |
| talon_get_sjs | PASS |  |
| talon_initialize_database | PASS |  |
| talon_label_reads | PASS |  |
| talon_longest_end | PASS |  |
| talon_reformat_gtf | PASS |  |
| talon_summarize | PASS |  |

## talon

### Tool Description
TALON takes transcripts from one or more long read datasets (SAM format) and assigns them transcript and gene identifiers based on a database-bound annotation. Novel events are assigned new identifiers.

### Metadata
- **Docker Image**: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mortazavilab/TALON
- **Package**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Total Downloads**: 8.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mortazavilab/TALON
- **Stars**: N/A
### Original Help Text
```text
usage: talon [-h] [--f CONFIG_FILE] [--cb] [--db FILE,] [--build STRING,]
             [--threads THREADS] [--cov MIN_COVERAGE]
             [--identity MIN_IDENTITY] [--nsg] [--tmpDir TMP_DIR]
             [--verbosity VERBOSITY] [--o OUTPREFIX]

TALON takes transcripts from one or more long read datasets (SAM format) and
assigns them transcript and gene identifiers based on a database-bound
annotation. Novel events are assigned new identifiers.

optional arguments:
  -h, --help            show this help message and exit
  --f CONFIG_FILE       Dataset config file: dataset name, sample description,
                        platform, sam file (comma-delimited)
  --cb                  Use CB tag in input SAM file instead of including a
                        dataset name in your config file
  --db FILE,            TALON database. Created using
                        talon_initialize_database
  --build STRING,       Genome build (i.e. hg38) to use. Must be in the
                        database.
  --threads THREADS, -t THREADS
                        Number of threads to run program with.
  --cov MIN_COVERAGE, -c MIN_COVERAGE
                        Minimum alignment coverage in order to use a SAM
                        entry. Default = 0.9
  --identity MIN_IDENTITY, -i MIN_IDENTITY
                        Minimum alignment identity in order to use a SAM
                        entry. Default = 0.8
  --nsg, --create_novel_spliced_genes
                        Make novel genes with the intergenic novelty label for
                        transcripts that don't share splice junctions with any
                        other models
  --tmpDir TMP_DIR      Path to directory for tmp files. Default =
                        `talon_tmp/`
  --verbosity VERBOSITY, -v VERBOSITY
                        Verbosity of TALON output. Higher numbers = more
                        verbose.
  --o OUTPREFIX         Prefix for output files
```

## talon_initialize_database

### Tool Description
Initialize a TALON SQLite database from a GTF annotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mortazavilab/TALON
- **Package**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: talon_initialize_database [options]

Options:
  -h, --help           show this help message and exit
  --f=FILE             GTF annotation containing genes, transcripts, and
                       edges.
  --g=GENOME_BUILD     Name of genome build that the GTF file is based on (ie
                       hg38)
  --a=ANNOT_NAME       Name of supplied annotation (will be used to label
                       data)
  --l=MIN_LENGTH       Minimum required transcript length (default = 0 bp)
  --idprefix=IDPREFIX  Prefix for naming novel discoveries in eventual TALON
                       runs
  --5p=CUTOFF_5P       Maximum allowable distance (bp) at the 5' end during
                       annotation
  --3p=CUTOFF_3P       Maximum allowable distance (bp) at the 3' end during
                       annotation
  --o=FILE             Outprefix for the annotation files
```

## talon_label_reads

### Tool Description
Add a fraction-of-As tag to long-read SAM alignments to flag internal priming.

### Metadata
- **Docker Image**: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mortazavilab/TALON
- **Package**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: talon_label_reads [options]

This program reads in SAM-formatted long read alignments and adds a custom tag
to reflect the fraction of As in the sequence immediately following the
alignment. This can help indicate the likelihood of an internal priming
artifact.

Options:
  -h, --help            show this help message and exit
  --f=SAM_FILE          SAM file of transcripts
  --g=GENOME_FILE       Reference genome fasta file
  --t=THREADS           Number of threads to run
  --ar=FRACA_RANGE_SIZE
                        Size of post-transcript interval to compute fraction
                        As on. Default = 20
  --tmpDir=TMP_DIR      Path to directory for tmp files. Default =
                        tmp_label_reads
  --deleteTmp           If this option is set, the temporary directory
                        generated by the program will be removed at the end of
                        the run.
  --o=OUTPREFIX         Prefix for outfiles
```

## talon_summarize

### Tool Description
Count genes and transcripts per dataset and category in a TALON database.

### Metadata
- **Docker Image**: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mortazavilab/TALON
- **Package**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Validation**: PASS

### Original Help Text
```text
usage: talon_summarize [-h] [--db FILE,] [--groups FILE,] [--verbose]
                       [--o OUTPREFIX]

Generates a tab-delimited file of gene and transcript counts for each dataset
in the database (broken down by category).

optional arguments:
  -h, --help      show this help message and exit
  --db FILE,      TALON database
  --groups FILE,  Optional: file of comma-delimited dataset groups to process
                  together
  --verbose       Verbose mode: print out the counts in terminal
  --o OUTPREFIX   Prefix for output file
```

## talon_abundance

### Tool Description
Create an abundance matrix of TALON transcripts across datasets.

### Metadata
- **Docker Image**: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mortazavilab/TALON
- **Package**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: talon_abundance [options]

Options:
  -h, --help            show this help message and exit
  --db=FILE             TALON database
  -a ANNOT, --annot=ANNOT
                        Which annotation version to use. Will determine which
                        annotation transcripts are considered known or novel
                        relative to. Note: must be in the TALON database.
  --whitelist=FILE      Whitelist file of transcripts to include in the
                        output. First column should be TALON gene ID,
                        second column should be TALON transcript ID
  -b BUILD, --build=BUILD
                        Genome build to use. Note: must be in the TALON
                        database.
  -d FILE, --datasets=FILE
                        Optional: A file indicating which datasets should be
                        included (one dataset name per line). Default is to
                        include                   all datasets.
  --o=FILE              Prefix for output file
```

## talon_filter_transcripts

### Tool Description
Filter transcripts in a TALON database into a pass list.

### Metadata
- **Docker Image**: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mortazavilab/TALON
- **Package**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: talon_filter_transcripts [options]

talon_filter_transcripts is a utility that filters the transcripts inside a
TALON database to produce a transcript pass list. This list can then be used
by downstream analysis tools to determine which transcripts and other features
should be reported (for example in a GTF file)

Options:
  -h, --help            show this help message and exit
  --db=FILE             TALON database
  -a ANNOT, --annot=ANNOT
                        Which annotation version to use. Will determine which
                        annotation transcripts are considered known or novel
                        relative to. Note: must be in the TALON database.
  --datasets=DATASETS   Datasets to include. Can be provided as a comma-
                        delimited list on the command line, or as a file with
                        one dataset per line. If this option is omitted, all
                        datasets will be included.
  --includeAnnot        Include all transcripts from the annotation,
                        regardless of if they were observed in the data.
  --maxFracA=MAX_FRAC_A
                        Maximum fraction of As to allow in the window located
                        immediately after any read assigned to a novel
                        transcript (helps to filter out internal priming
                        artifacts). Default = 0.5. Use 1 if you preferto not
                        filter out internal priming events.
  --minCount=MIN_COUNT  Number of minimum occurrences required for a novel
                        transcript PER dataset. Default = 5
  --minDatasets=MIN_DATASETS
                        Minimum number of datasets novel transcripts must be
                        found in. Default = all datasets provided
  --allowGenomic        If this option is set, transcripts from the Genomic
                        novelty category will be permitted in the output
                        (provided they pass the thresholds). Default behavior
                        is to filter out genomic transcripts since they are
                        unlikely to be real novel isoforms.
  --excludeISM          If this option is set, transcripts from the ISM
                        novelty category will be excluded from the output.
                        Default behavior is to include those that pass other
                        filtering thresholds.
  --o=FILE              Outfile name
```

## talon_create_GTF

### Tool Description
Write a GTF annotation from a TALON database.

### Metadata
- **Docker Image**: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mortazavilab/TALON
- **Package**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: talon_create_GTF [options]

Options:
  -h, --help            show this help message and exit
  --db=FILE             TALON database
  -b BUILD, --build=BUILD
                        Genome build to use. Note: must be in the TALON
                        database.
  -a ANNOT, --annot=ANNOT
                        Which annotation version to use. Will determine which
                        annotation transcripts are considered known or novel
                        relative to. Note: must be in the TALON database.
  --whitelist=FILE      Whitelist file of transcripts to include in the
                        output. First column should be TALON gene ID,
                        second column should be TALON transcript ID
  --observed            If this option is set, the GTF file will only
                        include transcripts that were observed in at least one
                        dataset (redundant if dataset file provided).
  -d FILE, --datasets=FILE
                        Optional: A file indicating which datasets should be
                        included (one dataset name per line). Default is to
                        include                   all datasets.
  --o=FILE              Prefix for output GTF
```

## talon_create_adata

### Tool Description
Create an AnnData object of TALON counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mortazavilab/TALON
- **Package**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: talon_create_adata [options]

Options:
  -h, --help            show this help message and exit
  --db=FILE             TALON database
  -a ANNOT, --annot=ANNOT
                        Which annotation version to use. Will determine which
                        annotation transcripts are considered known or novel
                        relative to. Note: must be in the TALON database.
  --pass_list=FILE      Pass list file of transcripts to include in the
                        output. First column should be TALON gene ID,
                        second column should be TALON transcript ID
  -b BUILD, --build=BUILD
                        Genome build to use. Note: must be in the TALON
                        database.
  --gene                Output AnnData on the gene level rather than the
                        transcript
  -d FILE, --datasets=FILE
                        Optional: A file indicating which datasets should be
                        included (one dataset name per line). Default is to
                        include                   all datasets.
  --o=FILE              Output file name
```

## talon_fetch_reads

### Tool Description
Get read-specific annotation from a TALON database.

### Metadata
- **Docker Image**: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mortazavilab/TALON
- **Package**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Validation**: PASS

### Original Help Text
```text
usage: talon_fetch_reads [-h] [--db FILE,] [--build STRING,]
                         [--datasets STRING,] [--o OUTPREFIX]

This utility queries a TALON database in order to get read-specific annotation
information.

optional arguments:
  -h, --help          show this help message and exit
  --db FILE,          TALON database
  --build STRING,     Genome build (i.e. hg38) to use. Must be in the
                      database.
  --datasets STRING,  Optional: Comma-delimited list of datasets to include.
                      Default behavior is to include all datasets in the
                      database.
  --o OUTPREFIX       Prefix for output files
```

## talon_get_sjs

### Tool Description
Extract exon or intron locations from a TALON database or GTF.

### Metadata
- **Docker Image**: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mortazavilab/TALON
- **Package**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Validation**: PASS

### Original Help Text
```text
usage: talon_get_sjs [-h] [--gtf GTF] [--db DB] [--ref REF_GTF] [--mode MODE]
                     [--outprefix OUTPREFIX]

Extracts the locations, novelty, and transcript assignments of exons/introns
in a TALON database or GTF file. All positions are 1-based.

optional arguments:
  -h, --help            show this help message and exit
  --gtf GTF             TALON GTF file from which to extract exons/introns
  --db DB               TALON database from which to extract exons/introns
  --ref REF_GTF         GTF reference file (ie GENCODE). Will be used to label
                        novelty.
  --mode MODE           Choices are 'intron' or 'exon' (default is 'intron').
                        Determines whether to include introns or exons in the
                        output
  --outprefix OUTPREFIX
                        Prefix for output file
```

## talon_longest_end

### Tool Description
Replace transcript starts or ends in a GTF with the longest alternatives.

### Metadata
- **Docker Image**: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mortazavilab/TALON
- **Package**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Validation**: PASS

### Original Help Text
```text
usage: talon_longest_end [-h] [-gtf GTF] [-read_annot ANNOT]
                         [--datasets DATASETS_FILE] [--mode {tss,tes,both}]
                         [--novelty {all,novel}] [-outprefix OUTPREFIX]
                         [--verbose]

Replaces the starts or ends of transcripts in a GTF with the longest
alternatives (similar to the GENCODE model ofcalling transcripts)

optional arguments:
  -h, --help            show this help message and exit
  -gtf GTF              TALON GTF to serve as the template to modify
  -read_annot ANNOT     Read annot file from TALON to extract raw read ends
                        from
  --datasets DATASETS_FILE, --d DATASETS_FILE
                        A file indicating which datasets should be included
                        (one dataset name per line). Default is to include all
                        datasets.
  --mode {tss,tes,both}
                        Modify TSSs or TESs, 'tss', 'tes', 'both'. Default:
                        'tss'
  --novelty {all,novel}
                        Whether to only modify ends from novel or all models,
                        'all' or 'novel'. Default: 'all'
  -outprefix OUTPREFIX, -o OUTPREFIX
                        Prefix for output file
  --verbose, -v         Display in progress output
```

## talon_reformat_gtf

### Tool Description
Fix a GTF that has no gene records.

### Metadata
- **Docker Image**: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mortazavilab/TALON
- **Package**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Validation**: PASS

### Original Help Text
```text
usage: talon_reformat_gtf [-h] [-gtf GTF]

Fixes a GTF with no genes

optional arguments:
  -h, --help        show this help message and exit
  -gtf GTF, -g GTF  gtf to fix
```

