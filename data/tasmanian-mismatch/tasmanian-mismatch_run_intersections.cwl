cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tasmanian-mismatch_run_intersections
label: tasmanian-mismatch_run_intersections
doc: "The provided text does not contain help information or a description of the
  tool. It contains error logs related to a container image build failure.\n\nTool
  homepage: https://github.com/nebiolabs/tasmanian-mismatch"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tasmanian-mismatch:1.0.9--pyhdfd78af_0
stdout: tasmanian-mismatch_run_intersections.out
