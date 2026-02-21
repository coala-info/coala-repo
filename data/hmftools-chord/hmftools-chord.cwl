cwlVersion: v1.2
class: CommandLineTool
baseCommand: chord
label: hmftools-chord
doc: "CHORD (Classifier of HOmologous Recombination Deficiency) is a tool used to
  predict homologous recombination deficiency status. Note: The provided help text
  contains only system error messages regarding container execution and does not list
  available command-line arguments.\n\nTool homepage: https://github.com/hartwigmedical/hmftools/blob/master/chord/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmftools-chord:2.1.2--hdfd78af_0
stdout: hmftools-chord.out
