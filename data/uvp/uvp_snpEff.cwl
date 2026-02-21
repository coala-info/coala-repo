cwlVersion: v1.2
class: CommandLineTool
baseCommand: uvp_snpEff
label: uvp_snpEff
doc: "The provided text does not contain help information or usage instructions; it
  consists of container runtime log messages indicating a failure to fetch the OCI
  image.\n\nTool homepage: https://github.com/CPTR-ReSeqTB/UVP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uvp:2.7.0--py_0
stdout: uvp_snpEff.out
