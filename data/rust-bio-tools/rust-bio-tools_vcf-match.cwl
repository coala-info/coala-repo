cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rbt
  - vcf-match
label: rust-bio-tools_vcf-match
doc: "Annotate for each variant in a VCF/BCF at STDIN whether it is contained in a
  given second VCF/BCF. The matching is fuzzy for indels and exact for SNVs. Results
  are printed as BCF to STDOUT, with an additional INFO tag MATCHING. The two vcfs
  do not have to be sorted.\n\nTool homepage: https://github.com/rust-bio/rust-bio-tools"
inputs:
  - id: vcf
    type: File
    doc: VCF/BCF file to match against
    inputBinding:
      position: 1
  - id: max_dist
    type:
      - 'null'
      - int
    doc: Maximum distance between centres of two indels considered to match
    default: 20
    inputBinding:
      position: 102
      prefix: --max-dist
  - id: max_len_diff
    type:
      - 'null'
      - int
    doc: Maximum difference between lengths of two indels
    default: 10
    inputBinding:
      position: 102
      prefix: --max-len-diff
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-bio-tools:0.42.2--h4458251_0
stdout: rust-bio-tools_vcf-match.out
