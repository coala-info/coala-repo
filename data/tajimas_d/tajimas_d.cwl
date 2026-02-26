cwlVersion: v1.2
class: CommandLineTool
baseCommand: tajimas_d
label: tajimas_d
doc: "Compute Tajima's D, the Pi- or Watterson-Estimator for multiple sequences.\n\
  \nTool homepage: https://github.com/not-a-feature/tajimas_d"
inputs:
  - id: file
    type: File
    doc: Path to fasta file with all sequences.
    inputBinding:
      position: 101
      prefix: --file
  - id: pi
    type:
      - 'null'
      - boolean
    doc: Compute the Pi-Estimator score.
    default: true
    inputBinding:
      position: 101
      prefix: --pi
  - id: tajima
    type:
      - 'null'
      - boolean
    doc: Compute Tajima's D
    inputBinding:
      position: 101
      prefix: --tajima
  - id: watterson
    type:
      - 'null'
      - boolean
    doc: Compute the Watterson-Estimator score.
    inputBinding:
      position: 101
      prefix: --watterson
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tajimas_d:2.0.4--pyhdfd78af_0
stdout: tajimas_d.out
