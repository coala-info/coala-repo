cwlVersion: v1.2
class: CommandLineTool
baseCommand: portcullis
label: portcullis
doc: "The provided text does not contain help information for the tool 'portcullis'.
  It appears to be a log of a failed container build/fetch process using Singularity/Apptainer.\n
  \nTool homepage: https://github.com/maplesond/portcullis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/portcullis:1.2.4--py39hc87ae8a_4
stdout: portcullis.out
