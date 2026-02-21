cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda-script_fa2table
label: igda-script_fa2table
doc: "A script to convert FASTA files to table format. (Note: The provided text contains
  system error messages regarding container execution and does not include usage or
  argument definitions).\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script_fa2table.out
