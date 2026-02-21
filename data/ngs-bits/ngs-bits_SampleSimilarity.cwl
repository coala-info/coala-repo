cwlVersion: v1.2
class: CommandLineTool
baseCommand: SampleSimilarity
label: ngs-bits_SampleSimilarity
doc: "Calculates the similarity between two or more NGS samples based on various metrics.
  (Note: The provided help text contained only system error messages and no usage
  information.)\n\nTool homepage: https://github.com/imgag/ngs-bits"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-bits:2025_09--py313h572c47f_0
stdout: ngs-bits_SampleSimilarity.out
