cwlVersion: v1.2
class: CommandLineTool
baseCommand: cenmap
label: cenmap
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a failed container build process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/logsdon-lab/CenMAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cenmap:1.2.0--h577a1d6_0
stdout: cenmap.out
