cwlVersion: v1.2
class: CommandLineTool
baseCommand: vcf-annotator.py
label: vcf-annotator
doc: "Annotate variants from a VCF file using the reference genome's GenBank file.\n\
  \nTool homepage: https://github.com/rpetit3/vcf-annotator"
inputs:
  - id: vcf_file
    type: File
    doc: VCF file of variants
    inputBinding:
      position: 1
  - id: genbank_file
    type: File
    doc: GenBank file of the reference genome.
    inputBinding:
      position: 2
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: File to write VCF output to (Default STDOUT).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcf-annotator:0.7--hdfd78af_0
