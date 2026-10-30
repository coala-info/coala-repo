cwlVersion: v1.2
class: CommandLineTool
baseCommand: vsnp3_group_reporter.py
label: vsnp3_vsnp3_group_reporter.py
doc: "Report the defining-SNP groups of a VCF file (used by vsnp3 step 1).\n\nTool homepage:\
  \ https://github.com/USDA-VS/vsnp3"
inputs:
  - id: vcf
    type: File
    doc: 'Required: vcf file'
    inputBinding:
      position: 101
      prefix: -vcf
  - id: reference_type
    type: string
    doc: Provide reference option. See vsnp3_path_adder.py -s for options
    inputBinding:
      position: 101
      prefix: -r
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vsnp3:3.33--hdfd78af_0
stdout: vsnp3_vsnp3_group_reporter.py.stdout.txt
