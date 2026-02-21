cwlVersion: v1.2
class: CommandLineTool
baseCommand: rascaf-wrapper.pl
label: rascaf_rascaf-wrapper.pl
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build/execution process.\n\n
  Tool homepage: https://github.com/mourisl/Rascaf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rascaf:20180710--h5ca1c30_1
stdout: rascaf_rascaf-wrapper.pl.out
