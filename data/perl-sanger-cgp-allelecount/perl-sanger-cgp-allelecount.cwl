cwlVersion: v1.2
class: CommandLineTool
baseCommand: alleleCount
label: perl-sanger-cgp-allelecount
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to build or run a container
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/cancerit/alleleCount"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-sanger-cgp-allelecount:4.3.0--pl5321h7b50bb2_2
stdout: perl-sanger-cgp-allelecount.out
