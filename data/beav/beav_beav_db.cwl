cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - beav
  - db
label: beav_beav_db
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process due to insufficient
  disk space.\n\nTool homepage: https://github.com/weisberglab/beav"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beav:1.4.0--hdfd78af_1
stdout: beav_beav_db.out
