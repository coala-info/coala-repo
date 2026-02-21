cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracegroomer
label: tracegroomer
doc: "The provided text is a container engine log (Apptainer/Singularity) and does
  not contain the help documentation or usage instructions for tracegroomer. As a
  result, no arguments could be extracted.\n\nTool homepage: https://github.com/cbib/TraceGroomer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tracegroomer:0.1.4--pyhdfd78af_0
stdout: tracegroomer.out
