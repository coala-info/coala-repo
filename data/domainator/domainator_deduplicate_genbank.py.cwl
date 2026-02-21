cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainator_deduplicate_genbank.py
label: domainator_deduplicate_genbank.py
doc: "Deduplicate GenBank files. Note: The provided help text contained system error
  messages regarding container execution and did not list specific command-line arguments.\n
  \nTool homepage: https://github.com/nebiolabs/domainator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domainator:0.8.0--pyhdfd78af_0
stdout: domainator_deduplicate_genbank.py.out
