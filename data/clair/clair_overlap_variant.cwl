cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - clair.py
  - overlap_variant
label: clair_overlap_variant
doc: "Resolve overlapping variants in a Clair VCF (VCF read from standard input, written to standard output)\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs:
  - id: vcf
    type: File
    doc: "Clair VCF, read from standard input"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
stdin: "$(inputs.vcf.path)"
stdout: clair_overlap_variant.out
