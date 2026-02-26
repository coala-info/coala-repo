cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmvc
label: mmvc
doc: "call variants using a multinomial model sampled by MCMC\n\nTool homepage: https://github.com/veg/mmvc"
inputs:
  - id: msa
    type: string
    doc: Multiple Sequence Alignment file
    inputBinding:
      position: 1
  - id: burnin_fraction
    type:
      - 'null'
      - float
    doc: Fraction of the MCMC chain to discard as burn-in
    default: 0.5
    inputBinding:
      position: 102
      prefix: --burnin-fraction
  - id: chain_length
    type:
      - 'null'
      - int
    doc: Length of the MCMC chain
    default: 2000000
    inputBinding:
      position: 102
      prefix: --chain-length
  - id: filter
    type:
      - 'null'
      - string
    doc: Filter to apply to variant calls
    inputBinding:
      position: 102
      prefix: --filter
  - id: grid_density
    type:
      - 'null'
      - int
    doc: Grid density for the multinomial model
    default: 10
    inputBinding:
      position: 102
      prefix: --grid-density
  - id: json_report
    type:
      - 'null'
      - string
    doc: Path to save JSON report
    inputBinding:
      position: 102
      prefix: --json-report
  - id: posterior_threshold
    type:
      - 'null'
      - float
    doc: Minimum posterior probability for a variant call
    default: 0.95
    inputBinding:
      position: 102
      prefix: --posterior-threshold
  - id: target_rate
    type:
      - 'null'
      - float
    doc: Target variant rate
    default: 0.01
    inputBinding:
      position: 102
      prefix: --target-rate
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmvc:1.0.2--0
stdout: mmvc.out
