cwlVersion: v1.2
class: CommandLineTool
baseCommand: rilseq_map_single_fragments.py
label: rilseq_map_single_fragments.py
doc: "A tool for mapping single fragments in RIL-seq data. (Note: The provided help
  text contains only container runtime error logs and does not list specific command-line
  arguments.)\n\nTool homepage: http://github.com/asafpr/RILseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rilseq:0.82--pyhdfd78af_0
stdout: rilseq_map_single_fragments.py.out
