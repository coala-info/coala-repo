cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - multi_to_single_fast5
label: ont-tombo_multi_to_single_fast5
doc: "The provided text does not contain help information or a description of the
  tool's functionality, as it is an error log regarding a container build failure.
  Based on the tool name, this utility is used to convert multi-read FAST5 files to
  single-read FAST5 files.\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py36r36h39af1c6_2
stdout: ont-tombo_multi_to_single_fast5.out
