cwlVersion: v1.2
class: CommandLineTool
baseCommand: virprof
label: virprof_ymp
doc: "A tool for viral profiling (Note: The provided text contains system logs and
  error messages rather than command-line help documentation. No arguments could be
  extracted from the input.)\n\nTool homepage: https://github.com/seiboldlab/virprof"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
stdout: virprof_ymp.out
