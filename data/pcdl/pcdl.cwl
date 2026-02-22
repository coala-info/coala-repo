cwlVersion: v1.2
class: CommandLineTool
baseCommand: pcdl
label: pcdl
doc: "The provided text does not contain help information or a description of the
  tool; it contains error messages related to a Singularity container execution failure.\n\
  \nTool homepage: https://github.com/elmbeech/physicelldataloader"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pcdl:3.3.8--pyhdfd78af_0
stdout: pcdl.out
