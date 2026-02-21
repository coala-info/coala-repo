cwlVersion: v1.2
class: CommandLineTool
baseCommand: smc++
label: smcpp_smc++
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container build failure.\n\nTool homepage:
  https://github.com/popgenmethods/smcpp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smcpp:1.15.4--py39hac1eaed_0
stdout: smcpp_smc++.out
