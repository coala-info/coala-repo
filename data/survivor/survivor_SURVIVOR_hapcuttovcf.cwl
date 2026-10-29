cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SURVIVOR
  - hapcuttovcf
label: survivor_hapcuttovcf
doc: "Converts the Hapcut2 final file to a VCF file using the original SNP file provided to Hapcut2\n\nTool homepage: https://github.com/fritzsedlazeck/SURVIVOR"
inputs:
  - id: original_snp_vcf
    type: File
    doc: "Original SNP file (VCF) provided to Hapcut2."
    inputBinding:
      position: 1
  - id: hapcut2_file
    type: File
    doc: "Hapcut2 final file."
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "Output: vcf file."
    inputBinding:
      position: 3
outputs:
  - id: vcf
    type: File
    doc: "Phased VCF file."
    outputBinding:
      glob: '$(inputs.output)'
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survivor:1.0.7--h077b44d_7
stdout: survivor_hapcuttovcf.out
