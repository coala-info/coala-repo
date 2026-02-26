cwlVersion: v1.2
class: CommandLineTool
baseCommand: kcftools_scoreRecalc
label: kcftools_scoreRecalc
doc: "Recalculate scores in a KCF file\n\nTool homepage: https://github.com/sivasubramanics/kcftools"
inputs:
  - id: inner_distance_weight
    type:
      - 'null'
      - float
    doc: Inner kmer distance weight
    default: 0.3
    inputBinding:
      position: 101
      prefix: --wi
  - id: input_file
    type: File
    doc: Input KCF file
    inputBinding:
      position: 101
      prefix: --input
  - id: kmer_ratio_weight
    type:
      - 'null'
      - float
    doc: Kmer ratio weight
    default: 0.4
    inputBinding:
      position: 101
      prefix: --wr
  - id: tail_distance_weight
    type:
      - 'null'
      - float
    doc: Tail kmer distance weight
    default: 0.3
    inputBinding:
      position: 101
      prefix: --wt
outputs:
  - id: output_file
    type: File
    doc: Output KCF file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
