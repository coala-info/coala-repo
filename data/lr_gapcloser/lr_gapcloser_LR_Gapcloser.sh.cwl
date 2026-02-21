cwlVersion: v1.2
class: CommandLineTool
baseCommand: LR_Gapcloser.sh
label: lr_gapcloser_LR_Gapcloser.sh
doc: "A tool for closing gaps in genome assemblies using long reads. (Note: The provided
  help text contains only system error messages and does not list specific command-line
  arguments.)\n\nTool homepage: https://github.com/CAFS-bioinformatics/LR_Gapcloser"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lr_gapcloser:1.0--pl5321hdfd78af_0
stdout: lr_gapcloser_LR_Gapcloser.sh.out
