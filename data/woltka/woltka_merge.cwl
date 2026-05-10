cwlVersion: v1.2
class: CommandLineTool
baseCommand: woltka_merge
label: woltka_merge
doc: "Merge multiple profiles into one profile.\n\nTool homepage: https://github.com/qiyunzhu/woltka"
inputs:
  - id: input_paths
    type:
      type: array
      items: Directory
    doc: Path to input profiles or directories containing profiles. Can accept 
      multiple paths.
    inputBinding:
      position: 101
      prefix: --input
  - id: output_file_path
    type: string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 102
      prefix: --output-file
outputs:
  - id: output_file
    type: File
    doc: Path to output profile.
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
