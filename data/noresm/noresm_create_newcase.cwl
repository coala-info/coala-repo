cwlVersion: v1.2
class: CommandLineTool
baseCommand: noresm_create_newcase
label: noresm_create_newcase
doc: "The provided text does not contain help information or usage instructions; it
  is an error log indicating a failure to build a Singularity/Apptainer image due
  to insufficient disk space.\n\nTool homepage: https://github.com/NorESMhub/NorESM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/noresm:2.0.2--py37pl5321h736fc29_1
stdout: noresm_create_newcase.out
