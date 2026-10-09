cwlVersion: v1.2
class: CommandLineTool
baseCommand: mason_methylation
label: mason_mason_methylation
doc: "Simulate methylation levels for IN.fa and write them to OUT.fa.\n\nTool homepage: https://www.seqan.de/apps/mason.html"
inputs:
  - id: in_path
    type: File
    doc: "Input FASTA file with genome."
    inputBinding:
      position: 101
      prefix: --in
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
    doc: "Seed for RNG. Default: 0."
    inputBinding:
      position: 101
      prefix: --seed
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
    doc: "Output FASTA file with the simulated methylation levels."
    inputBinding:
      position: 103
      prefix: --out
outputs:
  - id: out
    type: File
    doc: FASTA file with methylation levels.
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_path)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mason:2.0.13--h7f3286b_0
