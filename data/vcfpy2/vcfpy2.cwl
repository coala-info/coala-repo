cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfpy2
label: vcfpy2
doc: "The provided text does not contain help information or usage instructions for
  vcfpy2. It appears to be a log of a failed container build/fetch process.\n\nTool
  homepage: https://github.com/robertopreste/vcfpy2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfpy2:0.1.2--pyhdfd78af_0
stdout: vcfpy2.out
