cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2db.py
label: vcf2db_vcf2db.py
doc: "The provided text does not contain help information or a description of the
  tool; it appears to be a container runtime error log.\n\nTool homepage: https://github.com/quinlan-lab/vcf2db"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2db:2020.02.24--hdfd78af_1
stdout: vcf2db_vcf2db.py.out
