cwlVersion: v1.2
class: CommandLineTool
baseCommand: htsfile
label: htslib-test_htsfile
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a container image due to
  lack of disk space.\n\nTool homepage: https://github.com/samtools/htslib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/htslib-test:v1.9-11-deb_cv1
stdout: htslib-test_htsfile.out
