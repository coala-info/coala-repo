cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, path-to-fasta]
label: physlr_path-to-fasta
doc: "Produce scaffold sequences in FASTA format from paths, joining oriented contigs with gaps of N.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: gap_size
    type: ['null', int]
    doc: "gap size used in scaffolding [100]"
    inputBinding:
      position: 1
      prefix: --gap-size
  - id: min_length
    type: ['null', int]
    doc: "remove sequences with length less than this many bp [0]"
    inputBinding:
      position: 2
      prefix: --min-length
  - id: arcs_pair
    type: ['null', File]
    doc: "ARCS scaffold pairing file"
    inputBinding:
      position: 3
      prefix: --arcs-pair
  - id: dist_est
    type: ['null', File]
    doc: "ARCS scaffold pairing distance estimation file"
    inputBinding:
      position: 4
      prefix: --dist-est
  - id: dist_type
    type: ['null', string]
    doc: "ARCS scaffold pairing distance type: min, avg or max [avg]"
    inputBinding:
      position: 5
      prefix: --dist-type
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 6
      prefix: -V
  - id: fasta_file
    type: File
    doc: "Contigs in FASTA format"
    inputBinding:
      position: 100
  - id: path_files
    type: File[]
    doc: "Path file(s) (as written by physlr bed-to-path): oriented contig names separated by spaces, one scaffold per line"
    inputBinding:
      position: 101
outputs:
  - id: result
    type: File
    doc: "Scaffolds in FASTA format"
    outputBinding:
      glob: physlr_path-to-fasta.fa
stdout: physlr_path-to-fasta.fa
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
