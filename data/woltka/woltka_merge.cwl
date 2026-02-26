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
outputs:
  - id: output_file
    type: File
    doc: Path to output profile.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
