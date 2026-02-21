cwlVersion: v1.2
class: CommandLineTool
baseCommand: rilseq_map_chimeric_fragments.py
label: rilseq_map_chimeric_fragments.py
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a container execution error log.\n\nTool homepage: http://github.com/asafpr/RILseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rilseq:0.82--pyhdfd78af_0
stdout: rilseq_map_chimeric_fragments.py.out
