cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - guide-counter
  - count
label: guide-counter_count
doc: "Counts the guides observed in a CRISPR screen, starting from one or more FASTQs.
  FASTQs are one per sample and currently only single-end FASTQ inputs are supported.\n\
  \nTool homepage: https://github.com/fulcrumgenomics/guide-counter"
inputs:
  - id: control_guides
    type:
      - 'null'
      - File
    doc: Optional path to file with list control guide IDs. IDs should appear 
      one per line and are case sensitive. If the file has multiple 
      tab-separated columns, the first column is used
    inputBinding:
      position: 101
      prefix: --control-guides
  - id: control_pattern
    type:
      - 'null'
      - string
    doc: Optional regular expression used to ID control guides. Pattern is 
      matched, case insensitive, to guide IDs and Gene names
    inputBinding:
      position: 101
      prefix: --control-pattern
  - id: essential_genes
    type:
      - 'null'
      - File
    doc: Optional path to file with list of essential genes. Gene names should 
      appear one per line and are case sensitive. If the file has multiple 
      tab-separated columns, the first column is used
    inputBinding:
      position: 101
      prefix: --essential-genes
  - id: exact_match
    type:
      - 'null'
      - boolean
    doc: Perform exact matching only, don't allow mismatches between reads and 
      guides
    inputBinding:
      position: 101
      prefix: --exact-match
  - id: input
    type:
      type: array
      items: File
    doc: Input fastq file(s)
    inputBinding:
      position: 101
      prefix: --input
  - id: library
    type: File
    doc: 'Path to the guide library metadata. May be a tab- or comma-separated file.
      Must have a header line, and the first three fields must be (in order): i) the
      ID of the guide, ii) the base sequence of the guide, iii) the gene the guide
      targets'
    inputBinding:
      position: 101
      prefix: --library
  - id: nonessential_genes
    type:
      - 'null'
      - File
    doc: Optional path to file with list of nonessential genes. Gene names 
      should appear one per line and are case sensitive. If the file has 
      multiple tab-separated columns, the first column is used
    inputBinding:
      position: 101
      prefix: --nonessential-genes
  - id: offset_min_fraction
    type:
      - 'null'
      - float
    doc: After sampling the first `offset_sample_size` reads, use offsets that
    default: 0.0025
    inputBinding:
      position: 101
      prefix: --offset-min-fraction
  - id: offset_sample_size
    type:
      - 'null'
      - int
    doc: The number of reads to be examined when determining the offsets at 
      which guides may be found in the input reads
    default: 100000
    inputBinding:
      position: 101
      prefix: --offset-sample-size
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Sample names corresponding to the input fastqs. If provided must be the
      same length as input. Otherwise will be inferred from input file names
    inputBinding:
      position: 101
      prefix: --samples
outputs:
  - id: output
    type: File
    doc: Path prefix to use for all output files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/guide-counter:0.1.3--h503566f_4
