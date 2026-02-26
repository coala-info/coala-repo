cwlVersion: v1.2
class: CommandLineTool
baseCommand: vtools-evaluate
label: vtools_vtools-evaluate
doc: "Evaluate calls in a VCF against a set of known calls.\n\nTool homepage: https://github.com/LUMC/vtools"
inputs:
  - id: call_samples
    type:
      type: array
      items: string
    doc: Sample(s) in call-vcf to consider. May be called multiple times
    inputBinding:
      position: 101
      prefix: --call-samples
  - id: call_vcf
    type: File
    doc: Path to VCF with calls to be evaluated
    inputBinding:
      position: 101
      prefix: --call-vcf
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth of variants to consider
    inputBinding:
      position: 101
      prefix: --min-depth
  - id: min_qual
    type:
      - 'null'
      - float
    doc: Minimum quality of variants to consider
    inputBinding:
      position: 101
      prefix: --min-qual
  - id: positive_samples
    type:
      type: array
      items: string
    doc: Sample(s) in positive-vcf to consider. May be called multiple times
    inputBinding:
      position: 101
      prefix: --positive-samples
  - id: positive_vcf
    type: File
    doc: Path to VCF with known calls
    inputBinding:
      position: 101
      prefix: --positive-vcf
outputs:
  - id: stats
    type:
      - 'null'
      - File
    doc: Path to output stats json file
    outputBinding:
      glob: $(inputs.stats)
  - id: discordant_vcf
    type:
      - 'null'
      - File
    doc: Path to output the discordant vcf file
    outputBinding:
      glob: $(inputs.discordant_vcf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vtools:1.1.0--py311h93dcfea_7
