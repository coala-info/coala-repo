cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-math-cdf
label: perl-math-cdf
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a 'no space left on device' failure
  during a container image pull.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-math-cdf:0.1--pl5321h7b50bb2_11
stdout: perl-math-cdf.out
