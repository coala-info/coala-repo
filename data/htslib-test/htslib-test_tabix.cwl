cwlVersion: v1.2
class: CommandLineTool
baseCommand: htslib-test_tabix
label: htslib-test_tabix
doc: "The provided text does not contain help information for the tool; it contains
  system error messages regarding container image building and disk space.\n\nTool
  homepage: https://github.com/samtools/htslib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/htslib-test:v1.9-11-deb_cv1
stdout: htslib-test_tabix.out
