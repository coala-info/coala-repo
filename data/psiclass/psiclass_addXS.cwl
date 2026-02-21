cwlVersion: v1.2
class: CommandLineTool
baseCommand: psiclass_addXS
label: psiclass_addXS
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container execution (Apptainer/Singularity) while attempting
  to fetch the image.\n\nTool homepage: https://github.com/splicebox/PsiCLASS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psiclass:1.0.3--h5ca1c30_6
stdout: psiclass_addXS.out
