cwlVersion: v1.2
class: CommandLineTool
baseCommand: hivtrace
label: hivtrace
doc: "HIV TRACE\n\nTool homepage: https://github.com/veg/hivtrace"
inputs:
  - id: ambiguities
    type: string
    doc: handle ambiguous nucleotides using the specified strategy
    inputBinding:
      position: 101
      prefix: --ambiguities
  - id: attributes_file
    type:
      - 'null'
      - File
    doc: Annotate with attributes
    inputBinding:
      position: 101
      prefix: --attributes-file
  - id: compare
    type:
      - 'null'
      - boolean
    doc: Compare to supplied FASTA file
    inputBinding:
      position: 101
      prefix: --compare
  - id: curate
    type:
      - 'null'
      - string
    doc: Filter contaminants
    inputBinding:
      position: 101
      prefix: --curate
  - id: do_not_store_intermediate
    type:
      - 'null'
      - boolean
    doc: Store intermediate files
    inputBinding:
      position: 101
      prefix: --do-not-store-intermediate
  - id: filter
    type:
      - 'null'
      - string
    doc: Edge filtering option
    inputBinding:
      position: 101
      prefix: --filter
  - id: fraction
    type: float
    doc: Fraction
    inputBinding:
      position: 101
      prefix: --fraction
  - id: input
    type: File
    doc: FASTA file
    inputBinding:
      position: 101
      prefix: --input
  - id: log
    type:
      - 'null'
      - Directory
    doc: Write logs to specified directory
    inputBinding:
      position: 101
      prefix: --log
  - id: minoverlap
    type: int
    doc: Minimum Overlap
    inputBinding:
      position: 101
      prefix: --minoverlap
  - id: prior
    type:
      - 'null'
      - string
    doc: Prior network configuration
    inputBinding:
      position: 101
      prefix: --prior
  - id: reference
    type: File
    doc: reference to align to
    inputBinding:
      position: 101
      prefix: --reference
  - id: skip_alignment
    type:
      - 'null'
      - boolean
    doc: Skip alignment
    inputBinding:
      position: 101
      prefix: --skip-alignment
  - id: strip_drams
    type:
      - 'null'
      - string
    doc: "Read in an aligned Fasta file (HIV prot/rt sequences) and remove DRAM (drug
      resistance associated mutation) codon sites. It will output a new alignment
      with these sites removed. It requires input/output file names along with the
      list of DRAM sites to remove: 'lewis' or 'wheeler'."
    inputBinding:
      position: 101
      prefix: --strip_drams
  - id: threshold
    type: float
    doc: Only count edges where the distance is less than this threshold
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Specify output filename
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hivtrace:1.5.0--py_0
