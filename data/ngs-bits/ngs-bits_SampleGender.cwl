cwlVersion: v1.2
class: CommandLineTool
baseCommand: SampleGender
label: ngs-bits_SampleGender
doc: "Determines the gender of a sample from a BAM/CRAM file.\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_SampleGender.out
