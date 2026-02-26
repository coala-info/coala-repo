cwlVersion: v1.2
class: CommandLineTool
baseCommand: prosolo estimate-mutation-rate
label: prosolo_estimate-mutation-rate
doc: "Estimate the effective mutation rate of a tumor sample from a VCF/BCF with candidate
  variants from STDIN.\n\nTool homepage: https://github.com/PROSIC/prosolo/tree/v0.2.0"
inputs:
  - id: fit_file
    type:
      - 'null'
      - File
    doc: Path to file that will contain observations and the parameters of the 
      fitted model as JSON.
    inputBinding:
      position: 101
      prefix: --fit
  - id: max_af
    type:
      - 'null'
      - float
    doc: Maximum allele frequency to consider
    default: 0.25
    inputBinding:
      position: 101
      prefix: --max-af
  - id: min_af
    type:
      - 'null'
      - float
    doc: Minimum allele frequency to consider
    default: 0.12
    inputBinding:
      position: 101
      prefix: --min-af
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prosolo:0.6.1--h2138d71_0
stdout: prosolo_estimate-mutation-rate.out
