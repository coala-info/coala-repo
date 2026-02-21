cwlVersion: v1.2
class: CommandLineTool
baseCommand: ripser
label: ripser
doc: "The provided text does not contain help information for the tool 'ripser'. It
  contains error logs from a container runtime (Singularity/Apptainer) failure while
  attempting to fetch the image.\n\nTool homepage: http://ripser.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ripser:1.0.1--h6bb024c_0
stdout: ripser.out
