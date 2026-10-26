cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - call
label: vcfkit_vk_call
doc: "Compare variants found in sequences (FASTA) against a VCF using BLAST.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: seq
    type: File
    doc: "Sequence file (FASTA) to align to the reference"
    inputBinding:
      position: 1
  - id: ref
    type: string
    doc: "Reference genome name or path"
    inputBinding:
      position: 2
      prefix: --ref=
      separate: false
  - id: all_sites
    type:
      - 'null'
      - boolean
    doc: "Report all sites"
    inputBinding:
      position: 3
      prefix: --all-sites
  - id: vcf_sites
    type:
      - 'null'
      - boolean
    doc: "Report only sites in the VCF"
    inputBinding:
      position: 3
      prefix: --vcf-sites
  - id: vcf
    type: File
    doc: "Input VCF or BCF file"
    inputBinding:
      position: 4
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk_call.out
