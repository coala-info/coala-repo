cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - vcf-split
label: fuc_vcf-split
doc: "Split a VCF file by individual.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: vcf
    type: File
    doc: VCF file to be split.
    inputBinding:
      position: 1
  - id: output
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 2
  - id: clean
    type:
      - 'null'
      - boolean
    doc: By default, the command will only return variants present in each 
      individual. Use the tag to stop this behavior and make sure that all 
      individuals have the same number of variants.
    inputBinding:
      position: 103
      prefix: --clean
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the output directory if it already exists.
    inputBinding:
      position: 103
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_vcf-split.out
