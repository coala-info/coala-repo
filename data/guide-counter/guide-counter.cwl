cwlVersion: v1.2
class: CommandLineTool
baseCommand: guide-counter
label: guide-counter
doc: "A tool for counting guides (description not available in provided text)\n\n
  Tool homepage: https://github.com/fulcrumgenomics/guide-counter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/guide-counter:0.1.3--h503566f_4
stdout: guide-counter.out
