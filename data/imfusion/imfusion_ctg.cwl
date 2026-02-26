cwlVersion: v1.2
class: CommandLineTool
baseCommand: imfusion-ctg
label: imfusion_ctg
doc: "imfusion-ctg: error: the following arguments are required: --insertions, --reference,
  --output\n\nTool homepage: https://github.com/iamsh4shank/Imfusion"
inputs:
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: List of chromosomes to analyze
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: de_threshold
    type:
      - 'null'
      - float
    doc: Threshold for differential expression analysis
    default: 0.1
    inputBinding:
      position: 101
      prefix: --de_threshold
  - id: expression
    type:
      - 'null'
      - File
    doc: Gene expression file
    inputBinding:
      position: 101
      prefix: --expression
  - id: gene_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: List of gene IDs to consider
    inputBinding:
      position: 101
      prefix: --gene_ids
  - id: insertions
    type: File
    doc: Insertions file
    inputBinding:
      position: 101
      prefix: --insertions
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum sequencing depth required
    default: 10
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: pattern
    type:
      - 'null'
      - string
    doc: Pattern to search for in insertion sequences
    inputBinding:
      position: 101
      prefix: --pattern
  - id: reference
    type: File
    doc: Reference genome file
    inputBinding:
      position: 101
      prefix: --reference
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for calling structural variants
    default: 0.05
    inputBinding:
      position: 101
      prefix: --threshold
  - id: window
    type:
      - 'null'
      - type: array
        items: int
    doc: Window size for local analysis
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output
    type: File
    doc: Output file for results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imfusion:0.3.2--pyhdfd78af_1
