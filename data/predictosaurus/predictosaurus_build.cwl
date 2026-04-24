cwlVersion: v1.2
class: CommandLineTool
baseCommand: predictosaurus build
label: predictosaurus_build
doc: "Build a full variant graph out of VCF files and store it\n\nTool homepage: https://github.com/fxwiegand/predictosaurus"
inputs:
  - id: calls
    type: File
    doc: Path to the calls file
    inputBinding:
      position: 101
      prefix: --calls
  - id: min_prob_present
    type:
      - 'null'
      - float
    doc: Minimum probability for a variant to be considered in the graph
    inputBinding:
      position: 101
      prefix: --min-prob-present
  - id: min_vaf
    type:
      - 'null'
      - float
    doc: Minimum VAF for a variant to be kept. The maximum VAF across samples 
      must meet or exceed this threshold
    inputBinding:
      position: 101
      prefix: --min-vaf
  - id: observations
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more observation files in the format `sample=observations.vcf`. 
      Make sure the sample names match the sample names in the calls file
    inputBinding:
      position: 101
      prefix: --observations
  - id: verbose
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Path to the output file containing the impact graph
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/predictosaurus:0.8.4--hbcba35e_0
