cwlVersion: v1.2
class: CommandLineTool
baseCommand: xsv
label: xsv
doc: "The provided text does not contain help information for the tool 'xsv'. It appears
  to be an error log from a container runtime (Apptainer/Singularity) failing to fetch
  or build the tool's image.\n\nTool homepage: https://github.com/BurntSushi/xsv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsv:0.10.3--0
stdout: xsv.out
