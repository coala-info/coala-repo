cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
label: atlas_vcfcompare
doc: "Comparing genotype calls in two VCF files\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas/wiki/Home"
inputs:
  - id: vcf_file1
    type: File
    doc: First VCF file to compare
    inputBinding:
      position: 1
  - id: vcf_file2
    type: File
    doc: Second VCF file to compare
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_vcfcompare.out
