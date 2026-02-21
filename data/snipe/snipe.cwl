cwlVersion: v1.2
class: CommandLineTool
baseCommand: snipe
label: snipe
doc: "The provided text does not contain help information for the tool 'snipe'. It
  appears to be a log of a failed container build process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/snipe-bio/snipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snipe:0.1.6--pyhdfd78af_0
stdout: snipe.out
