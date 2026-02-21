cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqprep-data
label: seqprep-data
doc: "The provided text does not contain help information or usage instructions for
  seqprep-data; it is a log of a failed container build process due to insufficient
  disk space.\n\nTool homepage: https://github.com/jstjohn/SeqPrep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seqprep-data:v1.3.2-3-deb_cv1
stdout: seqprep-data.out
