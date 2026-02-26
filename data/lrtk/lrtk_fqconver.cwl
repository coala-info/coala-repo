cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrtk
label: lrtk_fqconver
doc: "lrtk version 2.0\n\nTool homepage: https://github.com/ericcombiolab/LRTK"
inputs:
  - id: command
    type: string
    doc: Subcommand to run (choose from 'MKFQ', 'FQCONVER', 'ALIGN', 'RLF', 
      'SNV', 'SV', 'PHASE', 'ASSEMBLY', 'WGS', 'MWGS')
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrtk:2.0--pyh7cba7a3_0
stdout: lrtk_fqconver.out
