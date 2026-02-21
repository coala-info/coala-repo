cwlVersion: v1.2
class: CommandLineTool
baseCommand: lr_gapcloser
label: lr_gapcloser
doc: "A tool for closing gaps in genome assemblies using long reads.\n\nTool homepage:
  https://github.com/CAFS-bioinformatics/LR_Gapcloser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lr_gapcloser:1.0--pl5321hdfd78af_0
stdout: lr_gapcloser.out
