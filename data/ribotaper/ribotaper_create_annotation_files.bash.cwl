cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotaper_create_annotation_files.bash
label: ribotaper_create_annotation_files.bash
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system logs and a fatal error related to a container image
  build process.\n\nTool homepage: https://github.com/boboppie/RiboTaper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotaper:1.3.1--0
stdout: ribotaper_create_annotation_files.bash.out
