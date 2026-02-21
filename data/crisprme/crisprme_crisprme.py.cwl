cwlVersion: v1.2
class: CommandLineTool
baseCommand: crisprme_crisprme.py
label: crisprme_crisprme.py
doc: "The provided text does not contain help information; it is an error log indicating
  a failure to build or extract the container image due to insufficient disk space.\n
  \nTool homepage: https://github.com/samuelecancellieri/CRISPRme"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisprme:2.1.9--py38hdfd78af_0
stdout: crisprme_crisprme.py.out
