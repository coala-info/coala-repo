cwlVersion: v1.2
class: CommandLineTool
baseCommand: pirs_gc_coverage_bias
label: pirs_gc_coverage_bias
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log indicating a failure to build or fetch
  a container image due to insufficient disk space.\n\nTool homepage: https://github.com/galaxy001/pirs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pirs:2.0.2--pl5.22.0_1
stdout: pirs_gc_coverage_bias.out
