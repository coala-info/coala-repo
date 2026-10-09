cwlVersion: v1.2
class: CommandLineTool
baseCommand: mason_materializer
label: mason_mason_materializer
doc: "Apply variants from IN.vcf to IN.fa and write the results to out.fa.\n\nTool homepage: https://www.seqan.de/apps/mason.html"
inputs:
  - id: input_reference
    type: File
    doc: "Path to FASTA file to read the reference from."
    inputBinding:
      position: 101
      prefix: --input-reference
  - id: input_vcf
    type: File
    doc: "Path to the VCF file with variants to apply."
    inputBinding:
      position: 101
      prefix: --input-vcf
  - id: version_check
    type:
      - 'null'
      - string
    doc: "Turn this option off to disable version update notifications of the application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO."
    inputBinding:
      position: 101
      prefix: --version-check
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Low verbosity."
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Higher verbosity."
    inputBinding:
      position: 101
      prefix: --verbose
  - id: very_verbose
    type:
      - 'null'
      - boolean
    doc: "Highest verbosity."
    inputBinding:
      position: 101
      prefix: --very-verbose
  - id: seed
    type:
      - 'null'
      - long
    doc: "Seed for random number generation. Default: 0."
    inputBinding:
      position: 101
      prefix: --seed
  - id: meth_seed
    type:
      - 'null'
      - long
    doc: "Seed for methylation simulation random number generation. Default: 0."
    inputBinding:
      position: 101
      prefix: --meth-seed
  - id: haplotype_name_sep
    type:
      - 'null'
      - string
    doc: "String separating contig name from haplotype number. Default: /."
    inputBinding:
      position: 101
      prefix: --haplotype-name-sep
  - id: meth_fasta_in
    type:
      - 'null'
      - File
    doc: "FASTA file with methylation levels of the input file."
    inputBinding:
      position: 101
      prefix: --meth-fasta-in
  - id: methylation_levels
    type:
      - 'null'
      - boolean
    doc: "Enable methylation level simulation."
    inputBinding:
      position: 101
      prefix: --methylation-levels
  - id: meth_cg_mu
    type:
      - 'null'
      - float
    doc: "Median of beta distribution for methylation level of CpG loci. In range [0..1]. Default: 0.6."
    inputBinding:
      position: 101
      prefix: --meth-cg-mu
  - id: meth_cg_sigma
    type:
      - 'null'
      - float
    doc: "Standard deviation of beta distribution for methylation level of CpG loci. In range [0..1]. Default: 0.03."
    inputBinding:
      position: 101
      prefix: --meth-cg-sigma
  - id: meth_chg_mu
    type:
      - 'null'
      - float
    doc: "Median of beta distribution for methylation level of CHG loci. In range [0..1]. Default: 0.08."
    inputBinding:
      position: 101
      prefix: --meth-chg-mu
  - id: meth_chg_sigma
    type:
      - 'null'
      - float
    doc: "Standard deviation of beta distribution for methylation level of CHG loci. In range [0..1]. Default: 0.008."
    inputBinding:
      position: 101
      prefix: --meth-chg-sigma
  - id: meth_chh_mu
    type:
      - 'null'
      - float
    doc: "Median of beta distribution for methylation level of CHH loci. In range [0..1]. Default: 0.05."
    inputBinding:
      position: 101
      prefix: --meth-chh-mu
  - id: meth_chh_sigma
    type:
      - 'null'
      - float
    doc: "Standard deviation of beta distribution for methylation level of CHH loci. In range [0..1]. Default: 0.005."
    inputBinding:
      position: 101
      prefix: --meth-chh-sigma
  - id: out_path
    type: string
    doc: "Output of materialized contigs."
    inputBinding:
      position: 103
      prefix: --out
  - id: out_breakpoints_path
    type:
      - 'null'
      - string
    doc: "TSV file to write breakpoints in variants to."
    inputBinding:
      position: 104
      prefix: --out-breakpoints
  - id: meth_fasta_out_path
    type:
      - 'null'
      - string
    doc: "FASTA file with methylation levels of the output file."
    inputBinding:
      position: 104
      prefix: --meth-fasta-out
outputs:
  - id: out
    type: File
    doc: Materialized contigs.
    outputBinding:
      glob: $(inputs.out_path)
  - id: out_breakpoints
    type:
      - 'null'
      - File
    doc: Breakpoints TSV.
    outputBinding:
      glob: $(inputs.out_breakpoints_path)
  - id: meth_fasta_out
    type:
      - 'null'
      - File
    doc: Methylation levels of the output.
    outputBinding:
      glob: $(inputs.meth_fasta_out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mason:2.0.13--h7f3286b_0
