cwlVersion: v1.2
class: CommandLineTool
baseCommand: variabel_vcf_compare.py
label: variabel_vcf_compare.py
doc: "A tool for comparing VCF files (Note: The provided help text contains only container
  runtime error logs and no usage information).\n\nTool homepage: https://gitlab.com/treangenlab/variabel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/variabel:1.0.0--hdfd78af_0
stdout: variabel_vcf_compare.py.out
