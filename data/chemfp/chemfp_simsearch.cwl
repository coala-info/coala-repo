cwlVersion: v1.2
class: CommandLineTool
baseCommand: simsearch
label: chemfp_simsearch
doc: "Search a set of target fingerprints for those similar to the query fingerprints.\n
  \nTool homepage: https://chemfp.com"
inputs:
  - id: queries
    type: File
    doc: Query fingerprints file
    inputBinding:
      position: 1
  - id: targets
    type:
      - 'null'
      - File
    doc: Target fingerprints file (if not provided, queries are searched against themselves)
    inputBinding:
      position: 2
  - id: k_nearest
    type:
      - 'null'
      - int
    doc: Return the k nearest neighbors
    inputBinding:
      position: 103
      prefix: --count
  - id: memory
    type:
      - 'null'
      - boolean
    doc: Load targets into memory for faster searching
    inputBinding:
      position: 103
      prefix: --memory
  - id: out_format
    type:
      - 'null'
      - string
    doc: Output format (e.g., 'sim', 'txt')
    inputBinding:
      position: 103
      prefix: --out
  - id: threshold
    type:
      - 'null'
      - float
    doc: Minimum similarity threshold
    inputBinding:
      position: 103
      prefix: --threshold
  - id: times
    type:
      - 'null'
      - boolean
    doc: Print timing information to stderr
    inputBinding:
      position: 103
      prefix: --times
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write output to FILE
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chemfp:1.6.1--py27h9801fc8_2
