cwlVersion: v1.2
class: CommandLineTool
baseCommand: prosic estimate-mutation-rate
label: prosic_estimate-mutation-rate
doc: "Estimate the effective mutation rate of a tumor sample from a VCF/BCF with candidate
  variants from STDIN.\n\nTool homepage: https://prosic.github.io"
inputs:
  - id: fit_file
    type:
      - 'null'
      - File
    doc: Path to file that will observations and the parameters of the fitted 
      model as JSON.
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
    dockerPull: quay.io/biocontainers/prosic:2.1.2--hc7800f0_1
stdout: prosic_estimate-mutation-rate.out
