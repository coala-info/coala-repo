cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vk
  - rename
label: vcfkit_vk_rename
doc: "Rename samples in a VCF file.\n\nTool homepage: https://github.com/AndersenLab/VCF-kit"
inputs:
  - id: vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to add to sample names
    inputBinding:
      position: 102
      prefix: --prefix=
      separate: false
  - id: subst
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --subst=
          separate: false
    doc: Substitution rules in the format 'old=new' (old:new or old,new also work)
    inputBinding:
      position: 102
  - id: suffix
    type:
      - 'null'
      - string
    doc: Suffix to add to sample names
    inputBinding:
      position: 102
      prefix: --suffix=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcfkit:0.2.9--pyh5bfb8f1_0
stdout: vcfkit_vk_rename.out