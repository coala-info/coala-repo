cwlVersion: v1.2
class: CommandLineTool
baseCommand: labrat
label: labrat
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the SIF format due to lack of disk space.\n\nTool homepage: https://github.com/TaliaferroLab/LABRAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/labrat:0.3.0--pyhdfd78af_1
stdout: labrat.out
