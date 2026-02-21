cwlVersion: v1.2
class: CommandLineTool
baseCommand: uvp_gatk-register
label: uvp_gatk-register
doc: "A tool for GATK registration. Note: The provided text contains container runtime
  logs and error messages rather than command-line help documentation, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/CPTR-ReSeqTB/UVP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uvp:2.7.0--py_0
stdout: uvp_gatk-register.out
