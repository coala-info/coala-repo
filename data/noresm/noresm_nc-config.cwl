cwlVersion: v1.2
class: CommandLineTool
baseCommand: noresm_nc-config
label: noresm_nc-config
doc: "The provided text does not contain help information for the tool. It consists
  of system error messages related to a container runtime (Apptainer/Singularity)
  failing to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/NorESMhub/NorESM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/noresm:2.0.2--py37pl5321h736fc29_1
stdout: noresm_nc-config.out
