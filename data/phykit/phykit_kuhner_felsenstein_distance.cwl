cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - kf_distance
label: phykit_kuhner_felsenstein_distance
doc: 'Calculate Kuhner-Felsenstein (KF) branch score distance between two trees. Unlike
  Robinson-Foulds distance which only considers topology, KF distance incorporates
  both topology and branch length differences. PhyKIT will print out col 1: the plain
  KF distance and col 2: the normalized KF distance.'
inputs:
  - id: tree_file_zero
    type: File
    doc: first argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: tree_file_one
    type:
      - 'null'
      - File
    doc: second argument after function name should be a tree file
    inputBinding:
      position: 2
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 103
      prefix: --json
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
stdout: phykit_kuhner_felsenstein_distance.out
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
