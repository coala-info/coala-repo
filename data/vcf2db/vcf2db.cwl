cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf2db
label: vcf2db
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error message regarding a failed image build.\n
  \nTool homepage: https://github.com/quinlan-lab/vcf2db"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf2db:2020.02.24--hdfd78af_1
stdout: vcf2db.out
