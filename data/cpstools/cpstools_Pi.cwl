cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpstools Pi
label: cpstools_Pi
doc: "Calculate pairwise pi values for a set of sequences.\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: mafft_path
    type:
      - 'null'
      - string
    doc: Path to MAFFT executable if not in environment path
    inputBinding:
      position: 101
      prefix: --mafft_path
  - id: work_dir
    type: Directory
    doc: Input directory of genbank files
    inputBinding:
      position: 101
      prefix: --work_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_Pi.out
