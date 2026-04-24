cwlVersion: v1.2
class: CommandLineTool
baseCommand: kcftools_getAttributes
label: kcftools_getAttributes
doc: "Extract attributes from KCF files\n\nTool homepage: https://github.com/sivasubramanics/kcftools"
inputs:
  - id: attributes
    type:
      - 'null'
      - type: array
        items: string
    doc: "Attributes to extract. Default: all\n                             - obs\
      \        : observed kmers\n                             - var        : variations\n\
      \                             - kd         : mean kmer count\n             \
      \                - score      : score\n                             - totalkmers
      : total kmers per window\n                             - winlen     : effective
      window length\n                             - inDist     : inner distance\n\
      \                             - tailDist   : tail distance"
    inputBinding:
      position: 101
      prefix: --attributes
  - id: input_file
    type: File
    doc: KCF file name
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output_file
    type: File
    doc: Output file name prefix
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kcftools:0.4.0--hdfd78af_0
