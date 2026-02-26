cwlVersion: v1.2
class: CommandLineTool
baseCommand: chromosomer simulator
label: chromosomer_simulator
doc: "Simulate fragments and test assembly for testing purposes.\n\nTool homepage:
  https://github.com/gtamazian/chromosomer"
inputs:
  - id: fr_num
    type: int
    doc: the number of chromosome fragments
    inputBinding:
      position: 1
  - id: fr_len
    type: int
    doc: the length of fragments
    inputBinding:
      position: 2
  - id: chr_num
    type: int
    doc: the number of chromosomes
    inputBinding:
      position: 3
  - id: output_dir
    type: Directory
    doc: the directory for output files
    inputBinding:
      position: 4
  - id: gap_size
    type:
      - 'null'
      - int
    doc: the size of gaps between fragments on a chromosome
    inputBinding:
      position: 105
      prefix: --gap_size
  - id: prefix
    type:
      - 'null'
      - string
    doc: the prefix for output file names
    inputBinding:
      position: 105
      prefix: --prefix
  - id: unplaced
    type:
      - 'null'
      - int
    doc: the number of unplaced fragments
    inputBinding:
      position: 105
      prefix: --unplaced
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
stdout: chromosomer_simulator.out
