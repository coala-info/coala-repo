cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - vcf-baf
label: rust-bio-tools_vcf-baf
doc: "Annotate b-allele frequency for each single nucleotide variant and sample.\n\
  \nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: input_vcf
    type: File
    doc: Input VCF/BCF file (usually via stdin)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
stdout: rust-bio-tools_vcf-baf.out
