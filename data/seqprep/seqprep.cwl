cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqprep
label: seqprep
doc: "The provided text does not contain help information for seqprep; it is a system
  error log indicating a failure to build or extract a container image due to lack
  of disk space.\n\nTool homepage: https://github.com/jstjohn/SeqPrep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seqprep:v1.3.2-3-deb_cv1
stdout: seqprep.out
