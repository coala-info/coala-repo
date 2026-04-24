cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncotator
label: oncotator
doc: "Oncotator is a tool for annotating human genomic point mutations and indels
  with data relevant to cancer researchers.\n\nTool homepage: https://github.com/broadinstitute/oncotator"
inputs:
  - id: input_file
    type: File
    doc: Input file to be annotated. Type is specified through options.
    inputBinding:
      position: 1
  - id: genome_build
    type: string
    doc: 'Genome build. For example: hg19'
    inputBinding:
      position: 2
  - id: allow_overwriting
    type:
      - 'null'
      - boolean
    doc: Allow annotations to be overwritten (no DuplicateAnnotationException 
      errors). This should only be used in rare cases and user should know when 
      that is. Automatically turned on with -i TCGAMAF
    inputBinding:
      position: 103
      prefix: --allow-overwriting
  - id: annotate_default
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify default values for annotations. Can be specified multiple 
      times. E.g. -d 'name1:value1' -d 'name2:value2'
    inputBinding:
      position: 103
      prefix: --annotate-default
  - id: annotate_manual
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify annotations to override. Can be specified multiple times. E.g. 
      -a 'name1:value1' -a 'name2:value2'
    inputBinding:
      position: 103
      prefix: --annotate-manual
  - id: cache_url
    type:
      - 'null'
      - string
    doc: URL to use for cache. See help for examples.
    inputBinding:
      position: 103
      prefix: --cache-url
  - id: canonical_tx_file
    type:
      - 'null'
      - File
    doc: Simple text file with list of transcript IDs (one per line) to always 
      select where possible for variants. Transcript IDs must match the ones 
      used by the transcript provider in your datasource (e.g. gencode 
      ENST00000123456). If more than one transcript can be selected for a 
      variant, uses the method defined by --tx-mode to break ties. Using this 
      list means that a transcript will be selected from this list first, 
      possibly superseding a best-effect. Note that transcript version number is
      not considered, whether included in the list or not.
    inputBinding:
      position: 103
      prefix: --canonical-tx-file
  - id: collapse_filter_cols
    type:
      - 'null'
      - boolean
    doc: Render FILTER columns from VCF input as single 'filter' column when 
      using TCGAMAF output option.
    inputBinding:
      position: 103
      prefix: --collapse-filter-cols
  - id: collapse_number_annotations
    type:
      - 'null'
      - boolean
    doc: 'Advanced: For TCGA MAF output, collapse a set of known numeric fields that
      may have been annotated with a pipe. This can be useful for downstream tools
      that are expecting a single value.'
    inputBinding:
      position: 103
      prefix: --collapse-number-annotations
  - id: db_dir
    type:
      - 'null'
      - Directory
    doc: Main annotation database directory.
    inputBinding:
      position: 103
      prefix: --db-dir
  - id: default_config
    type:
      - 'null'
      - File
    doc: File path to default annotation values in a config file format (section
      is 'manual_annotations' and annotation:value pairs).
    inputBinding:
      position: 103
      prefix: --default_config
  - id: infer_genotypes
    type:
      - 'null'
      - string
    doc: Forces the VCF output renderer to populate the output genotypes as 
      heterozygous. This option should only be used when converting a MAFLITE to
      a VCF; otherwise, the option has no effect.
    inputBinding:
      position: 103
      prefix: --infer_genotypes
  - id: infer_onps
    type:
      - 'null'
      - boolean
    doc: Will merge adjacent SNPs,DNPs,TNPs,etc if they are in the same sample. 
      This assumes that the input file is position sorted. This may cause 
      problems with VCF -> VCF conversion, and does not guarantee input order is
      maintained.
    inputBinding:
      position: 103
      prefix: --infer-onps
  - id: input_format
    type:
      - 'null'
      - string
    doc: Input format. Note that MAFLITE will work for any tsv file with 
      appropriate headers, so long as all of the required headers (or an alias 
      -- see maflite.config) are present. Note that "-i TCGAMAF" is the same as 
      specifying "-i MAFLITE --prune-tcga-maf-cols --allow-overwriting"
    inputBinding:
      position: 103
      prefix: --input_format
  - id: log_name
    type:
      - 'null'
      - string
    doc: Specify log output location.
    inputBinding:
      position: 103
      prefix: --log_name
  - id: longer_other_tx
    type:
      - 'null'
      - boolean
    doc: Adds some select field(s) to the other_transcript field
    inputBinding:
      position: 103
      prefix: --longer-other-tx
  - id: no_multicore
    type:
      - 'null'
      - boolean
    doc: Disables all multicore functionality.
    inputBinding:
      position: 103
      prefix: --no-multicore
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format.
    inputBinding:
      position: 103
      prefix: --output_format
  - id: override_config
    type:
      - 'null'
      - File
    doc: File path to manual annotations in a config file format (section is 
      'manual_annotations' and annotation:value pairs).
    inputBinding:
      position: 103
      prefix: --override_config
  - id: prepend
    type:
      - 'null'
      - boolean
    doc: If specified for TCGAMAF output, will put a 'i_' in front of fields 
      that are not directly rendered in Oncotator TCGA MAFs
    inputBinding:
      position: 103
      prefix: --prepend
  - id: prune_filter_cols
    type:
      - 'null'
      - boolean
    doc: Prune mutations from VCF input as based on 'filter' column when using 
      TCGAMAF output option.
    inputBinding:
      position: 103
      prefix: --prune-filter-cols
  - id: read_only_cache
    type:
      - 'null'
      - boolean
    doc: Makes the cache read-only
    inputBinding:
      position: 103
      prefix: --read_only_cache
  - id: reannotate_tcga_maf_cols
    type:
      - 'null'
      - boolean
    doc: Prefer new, annotated values to those specified by the input file. Only
      useful when output is TCGA MAF and when --allow-overwriting is specified. 
      Automatically turned on with -i TCGAMAF
    inputBinding:
      position: 103
      prefix: --reannotate-tcga-maf-cols
  - id: skip_no_alt
    type:
      - 'null'
      - boolean
    doc: If specified, any mutation with annotation alt_allele_seen of 'False' 
      will not be annotated or rendered. Do not use if output format is a VCF. 
      If alt_allele_seen annotation is missing, render the mutation.
    inputBinding:
      position: 103
      prefix: --skip-no-alt
  - id: tx_mode
    type:
      - 'null'
      - string
    doc: Specify transcript mode for transcript providing datasources that 
      support multiple modes.
    inputBinding:
      position: 103
      prefix: --tx-mode
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: set verbosity level
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Output file name of annotated file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncotator:1.9.9.0--py_0
