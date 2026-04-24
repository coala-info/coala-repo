cwlVersion: v1.2
class: CommandLineTool
baseCommand: savana evaluate
label: savana_evaluate
doc: "Evaluate VCF files by comparing them against reference VCFs and adding labels
  to the INFO field.\n\nTool homepage: https://github.com/cortes-ciriano-lab/savana"
inputs:
  - id: by_distance
    type:
      - 'null'
      - boolean
    doc: 'Comparison method: tie-break by min. distance'
    inputBinding:
      position: 101
      prefix: --by_distance
  - id: by_support
    type:
      - 'null'
      - boolean
    doc: 'Comparison method: tie-break by read support'
    inputBinding:
      position: 101
      prefix: --by_support
  - id: curate
    type:
      - 'null'
      - boolean
    doc: Attempt to reduce false labels for training (allow label to be used 
      twice)
    inputBinding:
      position: 101
      prefix: --curate
  - id: germline
    type:
      - 'null'
      - File
    doc: Germline VCF file to evaluate against (optional)
    inputBinding:
      position: 101
      prefix: --germline
  - id: input
    type: File
    doc: VCF file to evaluate
    inputBinding:
      position: 101
      prefix: --input
  - id: overlap_buffer
    type:
      - 'null'
      - int
    doc: Buffer for considering an overlap
    inputBinding:
      position: 101
      prefix: --overlap_buffer
  - id: qual_filter
    type:
      - 'null'
      - string
    doc: Impose a quality filter on comparator variants
    inputBinding:
      position: 101
      prefix: --qual_filter
  - id: somatic
    type: File
    doc: Somatic VCF file to evaluate against
    inputBinding:
      position: 101
      prefix: --somatic
  - id: stats
    type:
      - 'null'
      - File
    doc: Output file for statistics on comparison if desired
    inputBinding:
      position: 101
      prefix: --stats
outputs:
  - id: output
    type: File
    doc: Output VCF with LABEL added to INFO
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/savana:1.3.6--pyhdfd78af_0
