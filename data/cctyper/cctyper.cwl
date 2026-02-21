cwlVersion: v1.2
class: CommandLineTool
baseCommand: cctyper
label: cctyper
doc: "CRISPR-Cas Typer (cctyper) is a tool for automated detection and typing of CRISPR-Cas
  systems.\n\nTool homepage: https://github.com/Russel88/CRISPRCasTyper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cctyper:1.8.0--pyhdfd78af_1
stdout: cctyper.out
