cwlVersion: v1.2
class: CommandLineTool
baseCommand: peddy
label: peddy
doc: "Calculate and visualize pedigree-related statistics from a VCF and PED file.\n
  \nTool homepage: https://github.com/brentp/peddy"
inputs:
  - id: vcf
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: ped
    type: File
    doc: Input PED file
    inputBinding:
      position: 2
  - id: each
    type:
      - 'null'
      - boolean
    doc: Run peddy on each sample individually
    inputBinding:
      position: 103
      prefix: --each
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peddy:0.4.8--pyh5e36f6f_0
stdout: peddy.out
