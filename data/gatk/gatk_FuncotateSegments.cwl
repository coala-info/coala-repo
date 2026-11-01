cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- FuncotateSegments
label: gatk_FuncotateSegments
doc: |-
  Perform functional annotation on a segment file (tsv). Outputs two files. The first is a tsv where each row is a segment and the annotations are the covered genes and which genes+exon is overlapped by the segment breakpoints. The second file has a gene for each row. The rest of the information is the segment on which it is covered. The first file will have the name as specified by the output parameter. The second will have '.gene_list.txt' appended. The functionality here is the same as seen in Oncotator with a SEG file as input, but with both SIMPLE_TSV and GENE_LIST as outputs. Note that FuncotateSegments will support seg files from the GATK, whereas Oncotator will not. FuncotateSegments can support hg38 seg files from the GATK. FuncotateSegments does not support direct reading of cloud-based datasources. For more information about Oncotator, on small variants, see Ramos AH, Lichtenstein L, et al. Oncotator: Cancer Variant Annotation Tool. Human Mutation (2015). http://dx.doi.org/10.1002/humu.22771

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
- id: segments
  type: File
  doc: Input segment file (tab-separated values). Must have a call column.
  inputBinding:
    prefix: --segments
- id: alias_to_key_mapping
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --alias-to-key-mapping
  doc: '(Advanced) Mapping between an alias and key values that are recognized by
    the backend. Users should not typically have to specify this. This argument may
    be specified 0 or more times. Default value: [MEAN_LOG2_COPY_RATIO:Segment_Mean,
    CALL:Segment_Call, sample:Sample, sample_id:Sample, NUM_POINTS_COPY_RATIO:Num_Probes].'
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
- id: splice_site_window_size
  type:
  - 'null'
  - int
  doc: 'Number of bases on either side of a splice site for a variant to be classified
    as a SPLICE_SITE variant (default: 2). Default value: 2.'
  inputBinding:
    prefix: --splice-site-window-size
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
  - pattern: .gene_list.txt
    required: true
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://www.broadinstitute.org/gatk/
$namespaces:
  s: https://schema.org/
