cwlVersion: v1.2
class: CommandLineTool
baseCommand: krakenhll
label: krakenhll_krakenuniq
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error regarding container image building (no space left
  on device).\n\nTool homepage: https://github.com/fbreitwieser/krakenhll"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakenhll:0.4.8--pl5.22.0_0
stdout: krakenhll_krakenuniq.out
