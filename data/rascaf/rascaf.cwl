cwlVersion: v1.2
class: CommandLineTool
baseCommand: rascaf
label: rascaf
doc: "The provided text does not contain help information for the tool 'rascaf'. It
  appears to be a log of a failed container build process (Singularity/Apptainer).\n
  \nTool homepage: https://github.com/mourisl/Rascaf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rascaf:20180710--h5ca1c30_1
stdout: rascaf.out
