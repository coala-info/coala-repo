cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcfwave
label: vcflib_vcfwave
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a container build failure.\n\nTool homepage:
  https://github.com/vcflib/vcflib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcflib:1.0.14--h34261f4_0
stdout: vcflib_vcfwave.out
