cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainator_compare_contigs.py
label: domainator_compare_contigs.py
doc: "The provided text does not contain help information for the tool; it contains
  system error messages regarding a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/nebiolabs/domainator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domainator:0.8.0--pyhdfd78af_0
stdout: domainator_compare_contigs.py.out
