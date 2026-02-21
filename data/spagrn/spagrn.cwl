cwlVersion: v1.2
class: CommandLineTool
baseCommand: spagrn
label: spagrn
doc: "The provided text does not contain help information for the tool 'spagrn'. It
  appears to be an error log from a container build process (Apptainer/Singularity).\n
  \nTool homepage: https://github.com/iprada/Circle-Map"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spagrn:1.1.0--pyhdfd78af_0
stdout: spagrn.out
