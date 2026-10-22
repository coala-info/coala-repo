cwlVersion: v1.2
class: CommandLineTool
baseCommand: fix_gtf_ids.py
label: tsebra_fix_gtf_ids
doc: "Fix the gene and transcript IDs of a GTF file (for example braker.gtf) so that TSEBRA can read it.\n\nTool homepage: https://github.com/Gaius-Augustus/TSEBRA"
inputs:
  - id: gtf
    type: File
    doc: "Input GTF file"
    inputBinding:
      position: 101
      prefix: --gtf
  - id: out_path
    type: string
    doc: "Output GTF file"
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: out
    type: File
    doc: "GTF file with fixed IDs"
    outputBinding:
      glob: "$(inputs.out_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
