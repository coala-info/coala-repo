cwlVersion: v1.2
class: CommandLineTool
baseCommand: tracetuner
label: tracetuner
doc: "A tool for base calling and quality value calculation for DNA sequencing chromatograms
  (Note: The provided input text contains system error logs rather than help text;
  no arguments could be extracted).\n\nTool homepage: https://github.com/uzbit/tracetuner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tracetuner:v3.0.6betadfsg-1-deb_cv1
stdout: tracetuner.out
