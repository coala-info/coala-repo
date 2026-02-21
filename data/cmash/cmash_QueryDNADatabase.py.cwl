cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmash_QueryDNADatabase.py
label: cmash_QueryDNADatabase.py
doc: "The provided text does not contain help information; it is an error log indicating
  a failure to build or run the container (no space left on device).\n\nTool homepage:
  https://github.com/dkoslicki/CMash"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cmash:0.5.2--pyh5e36f6f_0
stdout: cmash_QueryDNADatabase.py.out
