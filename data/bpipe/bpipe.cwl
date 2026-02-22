cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpipe
label: bpipe
doc: "A tool for running and managing bioinformatics pipelines. (Note: The provided
  text appears to be a system error log rather than help text, so no arguments could
  be extracted from it.)\n\nTool homepage: http://docs.bpipe.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bpipe:0.9.13--hdfd78af_0
stdout: bpipe.out
