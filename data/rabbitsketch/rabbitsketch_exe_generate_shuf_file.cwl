cwlVersion: v1.2
class: CommandLineTool
baseCommand: rabbitsketch_exe_generate_shuf_file
label: rabbitsketch_exe_generate_shuf_file
doc: "A tool to generate shuffle files for RabbitSketch. (Note: The provided help
  text contains only container runtime logs and no argument definitions.)\n\nTool
  homepage: https://github.com/RabbitBio/RabbitSketch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rabbitsketch:0.1.1--py39h5ca1c30_0
stdout: rabbitsketch_exe_generate_shuf_file.out
