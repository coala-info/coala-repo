cwlVersion: v1.2
class: CommandLineTool
baseCommand: check_circurarity.pl
label: sprai_check_circularity.pl
doc: "Check for circularity in a FASTA assembly.\n\nTool homepage: http://zombie.cb.k.u-tokyo.ac.jp/sprai/"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file containing the assembly
    inputBinding:
      position: 1
  - id: temporary_dir
    type: Directory
    doc: Directory for temporary files
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sprai:0.9.9.23--py27pl5.22.0_0
stdout: sprai_check_circularity.pl.out
