cwlVersion: v1.2
class: CommandLineTool
baseCommand: orfipy
label: orfipy
doc: "The provided text does not contain help information; it is a system error log
  indicating a failure to build a Singularity/Apptainer image due to insufficient
  disk space.\n\nTool homepage: https://github.com/urmi-21/orfipy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orfipy:0.0.4--py37h96cfd12_1
stdout: orfipy.out
