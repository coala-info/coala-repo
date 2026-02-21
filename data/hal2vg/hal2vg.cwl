cwlVersion: v1.2
class: CommandLineTool
baseCommand: hal2vg
label: hal2vg
doc: "Convert HAL alignment to VG format\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/hal2vg"
inputs:
  - id: hal_path
    type: File
    doc: Input HAL file
    inputBinding:
      position: 1
  - id: chop
    type:
      - 'null'
      - int
    doc: Chop nodes to be at most this long
    inputBinding:
      position: 102
      prefix: --chop
  - id: no_ancestors
    type:
      - 'null'
      - boolean
    doc: Do not include ancestral genomes
    inputBinding:
      position: 102
      prefix: --noAncestors
  - id: only_ref
    type:
      - 'null'
      - boolean
    doc: Only include the reference genome
    inputBinding:
      position: 102
      prefix: --onlyRef
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show progress
    inputBinding:
      position: 102
      prefix: --progress
  - id: ref_genome
    type: string
    doc: Reference genome name
    inputBinding:
      position: 102
      prefix: --refGenome
  - id: ref_seq
    type:
      - 'null'
      - string
    doc: Reference sequence name
    inputBinding:
      position: 102
      prefix: --refSeq
  - id: root_genome
    type:
      - 'null'
      - string
    doc: Root genome name
    inputBinding:
      position: 102
      prefix: --rootGenome
  - id: target_genomes
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of target genomes
    inputBinding:
      position: 102
      prefix: --targetGenomes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hal2vg:1.1.8--hee927d3_0
stdout: hal2vg.out
