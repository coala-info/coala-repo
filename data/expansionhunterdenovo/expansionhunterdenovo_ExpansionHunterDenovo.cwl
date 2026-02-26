cwlVersion: v1.2
class: CommandLineTool
baseCommand: ExpansionHunterDenovo
label: expansionhunterdenovo_ExpansionHunterDenovo
doc: "ExpansionHunter Denovo: A tool for genome-wide detection of STR expansions\n\
  \nTool homepage: https://github.com/Illumina/ExpansionHunterDenovo"
inputs:
  - id: command
    type: string
    doc: 'Command to execute: profile (Compute genome-wide STR profile) or merge (Generate
      multisample STR profile from single-sample profiles)'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/expansionhunterdenovo:0.9.0--h6ac36c1_11
stdout: expansionhunterdenovo_ExpansionHunterDenovo.out
