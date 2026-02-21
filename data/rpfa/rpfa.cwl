cwlVersion: v1.2
class: CommandLineTool
baseCommand: rpfa
label: rpfa
doc: "Relative Protein Fraction Analysis. (Note: The provided text is a container
  build log and does not contain usage instructions or argument definitions.)\n\n
  Tool homepage: https://github.com/brsynth/rpFbaAnalysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rpfa:1.0.1--pyh5e36f6f_0
stdout: rpfa.out
