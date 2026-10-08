cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dpcstruct
  - secondarycluster
  - distance
label: dpcstruct_secondarycluster_distance
doc: "Calculate distances between primary clusters.\n\nTool homepage: https://github.com/RitAreaSciencePark/DPCstruct"
inputs:
  - id: input_a
    type: File
    doc: input file A (primary clusters from primarycluster)
    inputBinding:
      position: 101
      prefix: -i
  - id: input_b
    type: File
    doc: input file B (primary clusters from primarycluster)
    inputBinding:
      position: 101
      prefix: -j
  - id: producers
    type: int
    doc: producer threads
    inputBinding:
      position: 101
      prefix: -p
  - id: consumers
    type: int
    doc: consumer threads (must be greater than 1)
    inputBinding:
      position: 101
      prefix: -c
  - id: output_path
    type: string
    doc: output file for the distance matrix
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: distance_matrix
    type: File
    doc: output file for the distance matrix
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
