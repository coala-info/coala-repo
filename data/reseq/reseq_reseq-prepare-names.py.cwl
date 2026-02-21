cwlVersion: v1.2
class: CommandLineTool
baseCommand: reseq-prepare-names.py
label: reseq_reseq-prepare-names.py
doc: "A tool from the reseq package. (Note: The provided help text contains container
  build error logs rather than command usage information.)\n\nTool homepage: https://github.com/schmeing/ReSeq/tree/devel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reseq:1.1--py310hfb68e69_5
stdout: reseq_reseq-prepare-names.py.out
