cwlVersion: v1.2
class: CommandLineTool
baseCommand: SeqPrep
label: seqprep-data_SeqPrep
doc: "The provided text does not contain help information as the tool execution failed
  due to a system error (no space left on device) during the container build process.\n
  \nTool homepage: https://github.com/jstjohn/SeqPrep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seqprep-data:v1.3.2-3-deb_cv1
stdout: seqprep-data_SeqPrep.out
