cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- Funcotator
label: gatk_Funcotator
doc: |-
  Create functional annotations on given variants cross-referenced by a given set of data sources. A GATK functional annotation tool (similar functionality to Oncotator).

  Tool homepage: https://www.broadinstitute.org/gatk/
inputs:
- id: data_sources_path
  type:
    type: array
    items: Directory
    inputBinding:
      prefix: --data-sources-path
  doc: The path to a data source folder for Funcotator. May be specified more than
    once to handle multiple data source folders. This argument must be specified at
    least once.
- id: output
  type: string
  doc: Output file to which annotated variants should be written.
  inputBinding:
    prefix: --output
- id: output_file_format
  type: string
  doc: 'The output file format. Either VCF, MAF, or SEG. Please note that MAF output
    for germline use case VCFs is unsupported. SEG will generate two output files:
    a simple tsv and a gene list. Possible values: {VCF, MAF, SEG}'
  inputBinding:
    prefix: --output-file-format
- id: ref_version
  type: string
  doc: The version of the Human Genome reference to use (e.g. hg19, hg38, etc.). This
    will correspond to a sub-folder of each data source corresponding to that data
    source for the given reference.
  inputBinding:
    prefix: --ref-version
- id: reference
  type: File
  doc: Reference sequence file
  inputBinding:
    prefix: --reference
  secondaryFiles:
  - pattern: .fai
    required: true
  - pattern: ^.dict
    required: true
- id: variant
  type: File
  doc: A VCF file containing variants
  inputBinding:
    prefix: --variant
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
- id: annotation_default
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --annotation-default
  doc: Annotations to include in all annotated variants if the annotation is not specified
    in the data sources (in the format <ANNOTATION>:<VALUE>). This will add the specified
    annotation to every annotated variant if it is not already present. This argument
    may be specified 0 or more times.
- id: annotation_override
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --annotation-override
  doc: Override values for annotations (in the format <ANNOTATION>:<VALUE>). Replaces
    existing annotations of the given name with given values. This argument may be
    specified 0 or more times.
- id: custom_variant_classification_order
  type:
  - 'null'
  - File
  doc: 'TSV File containing custom Variant Classification severity map of the form:
    VARIANT_CLASSIFICATION SEV. VARIANT_CLASSIFICATION must match one of the VariantClassification
    names (COULD_NOT_DETERMINE, INTRON, FIVE_PRIME_UTR, THREE_PRIME_UTR, IGR, FIVE_PRIME_FLANK,
    THREE_PRIME_FLANK, MISSENSE, NONSENSE, NONSTOP, SILENT, SPLICE_SITE, IN_FRAME_DEL,
    IN_FRAME_INS, FRAME_SHIFT_INS, FRAME_SHIFT_DEL, START_CODON_SNP, START_CODON_INS,
    START_CODON_DEL, DE_NOVO_START_IN_FRAME, DE_NOVO_START_OUT_FRAME, RNA, LINCRNA).
    SEV is an unsigned integer, where lower is sorted first. When using this option
    it is HIGHLY recommended you also use the `BEST_EFFECT` transcript selection mode.'
  inputBinding:
    prefix: --custom-variant-classification-order
- id: exclude_field
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --exclude-field
  doc: Fields that should not be rendered in the final output. Only exact name matches
    will be excluded. This argument may be specified 0 or more times.
- id: exclude_intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --exclude-intervals
  doc: One or more genomic intervals to exclude from processing This argument may
    be specified 0 or more times.
- id: five_prime_flank_size
  type:
  - 'null'
  - int
  doc: 'Variants within this many bases of the 5'' end of a transcript (and not overlapping
    any part of the transcript itself) will be annotated as being in the 5'' flanking
    region of that transcript Default value: 5000.'
  inputBinding:
    prefix: --five-prime-flank-size
- id: interval_padding
  type:
  - 'null'
  - int
  doc: 'Amount of padding (in bp) to add to each interval you are including. Default
    value: 0.'
  inputBinding:
    prefix: --interval-padding
- id: intervals
  type:
  - 'null'
  - type: array
    items:
    - string
    - File
    inputBinding:
      prefix: --intervals
  doc: One or more genomic intervals over which to operate This argument may be specified
    0 or more times.
- id: lookahead_cache_bp
  type:
  - 'null'
  - int
  doc: 'Number of base-pairs to cache when querying variants. Can be overridden in
    individual data source configuration files. Default value: 100000.'
  inputBinding:
    prefix: --lookahead-cache-bp
- id: reannotate_vcf
  type:
  - 'null'
  - boolean
  doc: 'When input VCF has already been annotated, still annotate again. Default value:
    false. Possible values: {true, false}'
  inputBinding:
    prefix: --reannotate-vcf
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: remove_filtered_variants
  type:
  - 'null'
  - boolean
  doc: 'Ignore/drop variants that have been filtered in the input. These variants
    will not appear in the output file. Default value: false. Possible values: {true,
    false}'
  inputBinding:
    prefix: --remove-filtered-variants
    valueFrom: '$(self ? ''true'' : ''false'')'
- id: splice_site_window_size
  type:
  - 'null'
  - int
  doc: 'Number of bases on either side of a splice site for a variant to be classified
    as a SPLICE_SITE variant (default: 2). Default value: 2.'
  inputBinding:
    prefix: --splice-site-window-size
- id: three_prime_flank_size
  type:
  - 'null'
  - int
  doc: 'Variants within this many bases of the 3'' end of a transcript (and not overlapping
    any part of the transcript itself) will be annotated as being in the 3'' flanking
    region of that transcript Default value: 0.'
  inputBinding:
    prefix: --three-prime-flank-size
- id: transcript_list
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --transcript-list
  doc: File to use as a list of transcripts (one transcript ID per line, version numbers
    are ignored) OR A set of transcript IDs to use for annotation to override selected
    transcript. This argument may be specified 0 or more times.
- id: transcript_selection_mode
  type:
  - 'null'
  - string
  doc: 'Method of detailed transcript selection. This will select the transcript for
    detailed annotation (CANONICAL, ALL, or BEST_EFFECT). Default value: CANONICAL.
    Possible values: {BEST_EFFECT, CANONICAL, ALL}'
  inputBinding:
    prefix: --transcript-selection-mode
- id: min_num_bases_for_segment_funcotation
  type:
  - 'null'
  - int
  doc: 'The minimum number of bases for a variant to be annotated as a segment. Recommended
    to be changed only for use with FuncotateSegments. Defaults to 150 Default value:
    150.'
  inputBinding:
    prefix: --min-num-bases-for-segment-funcotation
- id: prefer_mane_transcripts
  type:
  - 'null'
  - boolean
  doc: 'If this flag is set, Funcotator will prefer ''MANE_Plus_Clinical'' followed
    by ''MANE_select'' transcripts (including those not tagged ''basic'') if one is
    present for a given variant. If neither tag is present it use the default behavior
    (only base transcripts). Default value: false. Possible values: {true, false}'
  inputBinding:
    prefix: --prefer-mane-transcripts
    valueFrom: '$(self ? ''true'' : ''false'')'
outputs:
- id: output_output
  type: File
  doc: Output file to which annotated variants should be written.
  outputBinding:
    glob: $(inputs.output)
  secondaryFiles:
  - pattern: .idx
    required: false
  - pattern: .tbi
    required: false
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
