cwlVersion: v1.2
class: CommandLineTool
baseCommand: unimap
label: unimap
doc: "The provided text does not contain help information for the tool 'unimap'. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch the image.\n\nTool homepage: https://github.com/lh3/unimap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unimap:0.1--h577a1d6_7
stdout: unimap.out
