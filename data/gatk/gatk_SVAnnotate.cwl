cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gatk
  - SVAnnotate
label: gatk_SVAnnotate
doc: |-
  Adds predicted functional consequence, gene overlap, and noncoding element overlap annotations to SV VCF from GATK-SV pipeline. Input files are an SV VCF, a GTF file containing primary or canonical transcripts, and a BED file containing noncoding elements. Output file is an annotated SV VCF.

  Tool homepage: https://gatk.broadinstitute.org/
inputs:
  - id: variant
    type: File
    inputBinding:
      position: 101
      prefix: --variant
    doc: A VCF file containing variants
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
  - id: disable_sequence_dictionary_validation
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --disable-sequence-dictionary-validation
    doc: 'If specified, do not check the sequence dictionaries from our inputs for
      compatibility. Use at your own risk! Default value: false. Possible values:
      {true, false}'
  - id: exclude_intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude-intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals to exclude from processing This argument may
      be specified 0 or more times.
  - id: input
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --input
    inputBinding:
      position: 101
    doc: BAM/SAM/CRAM file containing reads This argument may be specified 0 or more
      times.
    secondaryFiles:
      - pattern: .bai
        required: false
      - pattern: ^.bai
        required: false
      - pattern: .crai
        required: false
      - pattern: ^.crai
        required: false
      - pattern: .sbi
        required: false
  - id: intervals
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --intervals
    inputBinding:
      position: 101
    doc: One or more genomic intervals over which to operate This argument may be
      specified 0 or more times.
  - id: max_breakend_as_cnv_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --max-breakend-as-cnv-length
    doc: 'Length in bp. Provide to annotate BNDs smaller than this size as deletions
      or duplications if applicable. Recommended value: < 2000000 Default value: -1.'
  - id: non_coding_bed
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --non-coding-bed
    doc: 'BED file (with header) containing non-coding features. Columns: chrom, start,
      end, name, score (.), strand'
  - id: output
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --output
    doc: Output file (if not provided, defaults to STDOUT)
  - id: promoter_window_length
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --promoter-window-length
    doc: 'Promoter window (bp) upstream of TSS. Promoters will be inferred as the
      {window} bases upstream of the TSS. Default: 1000 Default value: 1000.'
  - id: protein_coding_gtf
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --protein-coding-gtf
    doc: Protein-coding GTF file containing primary or canonical transcripts (1-2
      transcripts per gene only)
  - id: reference
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --reference
    doc: Reference sequence
    secondaryFiles:
      - pattern: .fai
        required: false
      - pattern: ^.dict
        required: false
      - pattern: .gzi
        required: false
      - pattern: ^^.dict
        required: false
  - id: sequence_dictionary
    type:
      - 'null'
      - File
    inputBinding:
      position: 101
      prefix: --sequence-dictionary
    doc: Use the given sequence dictionary as the master/canonical sequence dictionary.
      Must be a .dict file.
  - id: variant_output_filtering
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --variant-output-filtering
    doc: 'Restrict the output variants to ones that match the specified intervals
      according to the specified matching mode. Default value: null. STARTS_IN (starts
      within any of the given intervals) ENDS_IN (ends within any of the given intervals)
      OVERLAPS (overlaps any of the given intervals) CONTAINED (contained completely
      within a contiguous block of intervals without overlap) ANYWHERE (no filtering)'
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: Output file (if not provided, defaults to STDOUT)
    outputBinding:
      glob: $(inputs.output)
    secondaryFiles:
      - pattern: .tbi
        required: false
      - pattern: .idx
        required: false
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: broadinstitute/gatk:4.7.0.0
s:url: https://gatk.broadinstitute.org/
$namespaces:
  s: https://schema.org/
