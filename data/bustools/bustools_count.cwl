cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bustools
  - count
label: bustools_count
doc: "Count gene matrix files from sorted BUS files\n\nTool homepage: https://github.com/BUStools/bustools"
inputs:
  - id: sorted_bus_files
    type:
      type: array
      items: File
    doc: Sorted BUS files
    inputBinding:
      position: 1
  - id: cm
    type:
      - 'null'
      - boolean
    doc: Count multiplicities instead of UMIs
    inputBinding:
      position: 102
      prefix: --cm
  - id: ecmap
    type:
      - 'null'
      - File
    doc: File for mapping equivalence classes to transcripts
    inputBinding:
      position: 102
      prefix: --ecmap
  - id: genecounts
    type:
      - 'null'
      - boolean
    doc: Aggregate counts to genes only
    inputBinding:
      position: 102
      prefix: --genecounts
  - id: genemap
    type:
      - 'null'
      - File
    doc: File for mapping transcripts to genes
    inputBinding:
      position: 102
      prefix: --genemap
  - id: multimapping
    type:
      - 'null'
      - boolean
    doc: Include bus records that pseudoalign to multiple genes
    inputBinding:
      position: 102
      prefix: --multimapping
  - id: split
    type:
      - 'null'
      - File
    doc: Split output matrix in two (plus ambiguous) based on transcripts supplied
      in this file
    inputBinding:
      position: 102
      prefix: --split
  - id: txnames
    type:
      - 'null'
      - File
    doc: File with names of transcripts
    inputBinding:
      position: 102
      prefix: --txnames
  - id: umi_gene
    type:
      - 'null'
      - boolean
    doc: Perform gene-level collapsing of UMIs
    inputBinding:
      position: 102
      prefix: --umi-gene
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory gene matrix files
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bustools:0.45.1--h6f0a7f7_0
