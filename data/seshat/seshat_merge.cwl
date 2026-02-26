cwlVersion: v1.2
class: CommandLineTool
baseCommand: seshat_merge
label: seshat_merge
doc: "Merge VCF files with annotations.\n\nTool homepage: https://github.com/clintval/tp53"
inputs:
  - id: annotations
    type: File
    doc: The annotation text file output from Seshat.
    inputBinding:
      position: 101
      prefix: --annotations
  - id: input_vcf
    type: File
    doc: The path to the input VCF file.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output_vcf
    type: File
    doc: The path to the output VCF file.
    outputBinding:
      glob: $(inputs.output_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seshat:0.10.0--py313hdfd78af_0
