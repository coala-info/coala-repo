# oncotator CWL Generation Report

## oncotator

### Tool Description
Oncotator is a tool for annotating human genomic point mutations and indels with data relevant to cancer researchers.

### Metadata
- **Docker Image**: quay.io/biocontainers/oncotator:1.9.9.0--py_0
- **Homepage**: https://github.com/broadinstitute/oncotator
- **Package**: https://anaconda.org/channels/bioconda/packages/oncotator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/oncotator/overview
- **Total Downloads**: 4.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/broadinstitute/oncotator
- **Stars**: N/A
### Original Help Text
```text
usage: oncotator [-h] [-v] [-V] [-i {TCGAMAF,SEG_FILE,VCF,MAFLITE}]
                 [--db-dir DBDIR]
                 [-o {TCGAMAF,VCF,SIMPLE_TSV,TCGAVCF,SIMPLE_BED,GENE_LIST}]
                 [--override_config OVERRIDE_CONFIG]
                 [--default_config DEFAULT_CONFIG] [--no-multicore]
                 [-a OVERRIDE_CLI] [-d DEFAULT_CLI] [-u CACHE_URL] [-r]
                 [--tx-mode {CANONICAL,EFFECT}]
                 [--infer_genotypes {yes,true,t,1,y,no,false,f,0,n}]
                 [--skip-no-alt] [--log_name LOG_NAME] [--prepend]
                 [--infer-onps] [-c CANONICAL_TX_FILE]
                 [--collapse-filter-cols] [--reannotate-tcga-maf-cols] [-w]
                 [--collapse-number-annotations] [--longer-other-tx]
                 [--prune-filter-cols]
                 input_file output_file genome_build

oncotator v1.9.9.0

    Oncotator is a tool for annotating human genomic point mutations and indels with data relevant to cancer researchers.

    

positional arguments:
  input_file            Input file to be annotated. Type is specified through
                        options.
  output_file           Output file name of annotated file.
  genome_build          Genome build. For example: hg19

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         set verbosity level [default: 5]
  -V, --version         show program's version number and exit
  -i {TCGAMAF,SEG_FILE,VCF,MAFLITE}, --input_format {TCGAMAF,SEG_FILE,VCF,MAFLITE}
                        Input format. Note that MAFLITE will work for any tsv
                        file with appropriate headers, so long as all of the
                        required headers (or an alias -- see maflite.config)
                        are present. Note that "-i TCGAMAF" is the same as
                        specifying "-i MAFLITE --prune-tcga-maf-cols --allow-
                        overwriting" [default: MAFLITE]
  --db-dir DBDIR        Main annotation database directory. [default: /xchip/c
                        ga/reference/annotation/db/oncotator_v1_ds_gencode_cur
                        rent/]
  -o {TCGAMAF,VCF,SIMPLE_TSV,TCGAVCF,SIMPLE_BED,GENE_LIST}, --output_format {TCGAMAF,VCF,SIMPLE_TSV,TCGAVCF,SIMPLE_BED,GENE_LIST}
                        Output format. [default: TCGAMAF]
  --override_config OVERRIDE_CONFIG
                        File path to manual annotations in a config file
                        format (section is 'manual_annotations' and
                        annotation:value pairs).
  --default_config DEFAULT_CONFIG
                        File path to default annotation values in a config
                        file format (section is 'manual_annotations' and
                        annotation:value pairs).
  --no-multicore        Disables all multicore functionality.
  -a OVERRIDE_CLI, --annotate-manual OVERRIDE_CLI
                        Specify annotations to override. Can be specified
                        multiple times. E.g. -a 'name1:value1' -a
                        'name2:value2'
  -d DEFAULT_CLI, --annotate-default DEFAULT_CLI
                        Specify default values for annotations. Can be
                        specified multiple times. E.g. -d 'name1:value1' -d
                        'name2:value2'
  -u CACHE_URL, --cache-url CACHE_URL
                        URL to use for cache. See help for examples.
  -r, --read_only_cache
                        Makes the cache read-only
  --tx-mode {CANONICAL,EFFECT}
                        Specify transcript mode for transcript providing
                        datasources that support multiple modes. [default:
                        CANONICAL]
  --infer_genotypes {yes,true,t,1,y,no,false,f,0,n}
                        Forces the VCF output renderer to populate the output
                        genotypes as heterozygous. This option should only be
                        used when converting a MAFLITE to a VCF; otherwise,
                        the option has no effect. [default: false]
  --skip-no-alt         If specified, any mutation with annotation
                        alt_allele_seen of 'False' will not be annotated or
                        rendered. Do not use if output format is a VCF. If
                        alt_allele_seen annotation is missing, render the
                        mutation.
  --log_name LOG_NAME   Specify log output location. Default: oncotator.log
  --prepend             If specified for TCGAMAF output, will put a 'i_' in
                        front of fields that are not directly rendered in
                        Oncotator TCGA MAFs
  --infer-onps          Will merge adjacent SNPs,DNPs,TNPs,etc if they are in
                        the same sample. This assumes that the input file is
                        position sorted. This may cause problems with VCF ->
                        VCF conversion, and does not guarantee input order is
                        maintained.
  -c CANONICAL_TX_FILE, --canonical-tx-file CANONICAL_TX_FILE
                        Simple text file with list of transcript IDs (one per
                        line) to always select where possible for variants.
                        Transcript IDs must match the ones used by the
                        transcript provider in your datasource (e.g. gencode
                        ENST00000123456). If more than one transcript can be
                        selected for a variant, uses the method defined by
                        --tx-mode to break ties. Using this list means that a
                        transcript will be selected from this list first,
                        possibly superseding a best-effect. Note that
                        transcript version number is not considered, whether
                        included in the list or not.
  --collapse-filter-cols
                        Render FILTER columns from VCF input as single
                        'filter' column when using TCGAMAF output option.
  --reannotate-tcga-maf-cols
                        Prefer new, annotated values to those specified by the
                        input file. Only useful when output is TCGA MAF and
                        when --allow-overwriting is specified. Automatically
                        turned on with -i TCGAMAF
  -w, --allow-overwriting
                        Allow annotations to be overwritten (no
                        DuplicateAnnotationException errors). This should only
                        be used in rare cases and user should know when that
                        is. Automatically turned on with -i TCGAMAF
  --collapse-number-annotations
                        Advanced: For TCGA MAF output, collapse a set of known
                        numeric fields that may have been annotated with a
                        pipe. This can be useful for downstream tools that are
                        expecting a single value.
  --longer-other-tx     Adds some select field(s) to the other_transcript
                        field
  --prune-filter-cols   Prune mutations from VCF input as based on 'filter'
                        column when using TCGAMAF output option.

    Example usage
    -------------
    oncotator -v --input_format=MAFLITE --output_format=TCGAMAF myInputFile.maflite myOutputFile.maf.annotated hg19
    
    IMPORTANT NOTE:  hg19 is only supported genome build for now.

    Default values specified by -d or --default_annotation_values are used when an annotation does not exist or is populated with an empty string ("")

    Both default and override config files and command line specifications stack.

    Example of an override_config or default_config file:

    # Create center, source, sequencer, and score annotations, with the values broad.mit.edu, WXS, Illumina GAIIx, and <blank> for all mutations.
    #  This will overwrite all mutations.
    [manual_annotations]
    override:center=broad.mit.edu,source=WXS,sequencer=Illumina GAIIx,score=

    Example of cache urls:

    # Use a file (/home/user/myfile.cache) ... note the three forward slashes after "file:" for absolute path.
    -u file:///home/user/myfile.cache
    -u file://relative_file.cache

    # memcache
    -u memcache://localhost:11211

    Please note that only VCF input will populate the alt_allele_seen annotation.  All other inputs assume that the alternate is present if it appears at all.
        This feature is to allow users to include or exclude GT of 0/0 or ./. variants when converting VCFs to MAF.

        If --skip-no-alt is specified, VCF input processing will remove mutations with alt_allele_seen of False entirely (the mutations will not even seen when output format is SIMPLE_TSV).

    -----
    Copyright 2012 Broad Institute. All rights reserved.  Distributed on an "AS IS" basis without warranties or conditions of any kind, either express or implied.
    Oncotator is free for non-profit use.  See LICENSE for complete licensing information.
```

