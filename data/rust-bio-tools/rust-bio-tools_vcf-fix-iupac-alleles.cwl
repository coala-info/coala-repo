cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - vcf-fix-iupac-alleles
label: rust-bio-tools_vcf-fix-iupac-alleles
doc: "Convert any IUPAC codes in alleles into Ns (in order to comply with VCF 4 specs).
  Reads VCF/BCF from STDIN and writes BCF to STDOUT.\n\nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: input_vcf
    type: File
    doc: VCF/BCF file to fix (read from STDIN)
outputs:
  - id: fixed_bcf
    type: stdout
    doc: BCF file with IUPAC codes in alleles replaced by N
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
stdin: $(inputs.input_vcf.path)
stdout: iupac-fixed.bcf
