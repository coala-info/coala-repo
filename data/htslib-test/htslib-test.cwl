cwlVersion: v1.2
class: CommandLineTool
baseCommand: htslib-test
label: htslib-test
doc: "HTSlib test suite and benchmarking tools\n\nTool homepage: https://github.com/samtools/htslib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/htslib-test:v1.9-11-deb_cv1
stdout: htslib-test.out
