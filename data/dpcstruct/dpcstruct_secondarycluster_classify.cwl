cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dpcstruct
  - secondarycluster
  - classify
label: dpcstruct_secondarycluster_classify
doc: "Classify primary clusters into secondary clusters or metaclusters.\n\nTool homepage:
  https://github.com/RitAreaSciencePark/DPCstruct"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: list of space-separated files (distance matrices from secondarycluster distance)
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads (TBI)
    inputBinding:
      position: 101
      prefix: -t
  - id: output_path
    type: string
    doc: output file containing the classified primary clusters
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: classification
    type: File
    doc: output file containing the classified primary clusters
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
