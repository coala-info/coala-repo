cwlVersion: v1.2
class: CommandLineTool
baseCommand: eigenstrat_snp_coverage.py
label: eigenstratdatabasetools_eigenstrat_snp_coverage.py
doc: "A tool from the eigenstratdatabasetools suite, likely used for calculating SNP
  coverage in Eigenstrat format databases.\n\nTool homepage: https://github.com/TCLamnidis/EigenStratDatabaseTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eigenstratdatabasetools:1.1.0--hdfd78af_0
stdout: eigenstratdatabasetools_eigenstrat_snp_coverage.py.out
