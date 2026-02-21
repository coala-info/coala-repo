cwlVersion: v1.2
class: CommandLineTool
baseCommand: virprof
label: virprof
doc: "A tool for viral profiling. (Note: The provided text contains container runtime
  logs and error messages rather than CLI help documentation; therefore, no arguments
  could be extracted.)\n\nTool homepage: https://github.com/seiboldlab/virprof"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
stdout: virprof.out
