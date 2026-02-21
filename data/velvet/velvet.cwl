cwlVersion: v1.2
class: CommandLineTool
baseCommand: velvet
label: velvet
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the velvet container image.\n\nTool homepage: https://github.com/dzerbino/velvet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/velvet:1.2.10--h7132678_5
stdout: velvet.out
