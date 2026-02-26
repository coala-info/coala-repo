cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicberg tidy
label: hicberg_tidy
doc: "Tidy output folder.\n\nTool homepage: https://github.com/sebgra/hicberg"
inputs:
  - id: output_folder
    type: Directory
    doc: Output folder to save results.
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicberg:1.0.1--py312hcf36b3e_0
stdout: hicberg_tidy.out
