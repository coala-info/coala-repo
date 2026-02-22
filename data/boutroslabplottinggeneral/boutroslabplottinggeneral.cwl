cwlVersion: v1.2
class: CommandLineTool
baseCommand: boutroslabplottinggeneral
label: boutroslabplottinggeneral
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to a failed Singularity/Docker image pull due to
  insufficient disk space.\n\nTool homepage: https://github.com/uclahs-cds/docker-BoutrosLabPlottingGeneral"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/boutroslabplottinggeneral:5.3.4--r44h9ee0642_6
stdout: boutroslabplottinggeneral.out
