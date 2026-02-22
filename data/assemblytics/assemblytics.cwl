cwlVersion: v1.2
class: CommandLineTool
baseCommand: Assemblytics
label: assemblytics
doc: "Assemblytics is a tool for detecting and analyzing structural variants from
  a genome assembly compared to a reference genome. It takes a MUMmer .delta file
  as input.\n\nTool homepage: http://assemblytics.com/"
inputs:
  - id: delta_file
    type: File
    doc: MUMmer .delta file from aligning a query assembly to a reference genome
    inputBinding:
      position: 1
  - id: unique_anchor_length
    type: int
    doc: Minimum unique anchor length (e.g., 10000)
    inputBinding:
      position: 2
  - id: min_variant_size
    type: int
    doc: Minimum variant size to report (e.g., 50)
    inputBinding:
      position: 3
  - id: max_variant_size
    type: int
    doc: Maximum variant size to report (e.g., 100000)
    inputBinding:
      position: 4
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for all output files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/assemblytics:1.2.1--0
