cwlVersion: v1.2
class: CommandLineTool
baseCommand: dpcstruct primarycluster
label: dpcstruct_primarycluster
doc: "Identifies primary clusters given a set of query proteins.\n\nTool homepage:
  https://github.com/RitAreaSciencePark/DPCstruct"
inputs:
  - id: input_filename
    type: File
    doc: input filename
    inputBinding:
      position: 101
      prefix: -i
  - id: threads
    type: int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: output_filename_path
    type: string
    doc: Output or path parameter `output_filename_path`
    inputBinding:
      position: 102
      prefix: --output-filename
outputs:
  - id: output_filename
    type: File
    doc: output filename
    outputBinding:
      glob: $(inputs.output_filename_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dpcstruct:0.1.1--h9948957_0
