cwlVersion: v1.2
class: CommandLineTool
baseCommand: mach2
label: mach2
doc: "A tool for genotype imputation and haplotype reconstruction (Note: The provided
  help text contains only container runtime error logs and no usage information).\n
  \nTool homepage: https://github.com/elkebir-group/mach2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mach2:1.0.2--pyhdfd78af_0
stdout: mach2.out
