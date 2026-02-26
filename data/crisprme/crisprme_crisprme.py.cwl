cwlVersion: v1.2
class: CommandLineTool
baseCommand: crisprme.py
label: crisprme_crisprme.py
doc: "CRISPRme is a tool for analyzing CRISPR-Cas9 off-target effects.\n\nTool homepage:
  https://github.com/samuelecancellieri/CRISPRme"
inputs:
  - id: function
    type: string
    doc: 'The functionality to execute. Options include: complete-search, complete-test,
      validate-test, targets-integration, gnomAD-converter, generate-personal-card,
      web-interface.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisprme:2.1.9--py38hdfd78af_0
stdout: crisprme_crisprme.py.out
