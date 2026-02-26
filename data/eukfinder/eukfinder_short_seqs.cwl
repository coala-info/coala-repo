cwlVersion: v1.2
class: CommandLineTool
baseCommand: eukfinder short_seqs
label: eukfinder_short_seqs
doc: "optional arguments:\n  -h, --help            show this help message and exit\n\
  \nRequired arguments:\n  Description\n\nTool homepage: https://github.com/RogerLab/Eukfinder"
inputs:
  - id: centrifuge_database
    type:
      - 'null'
      - Directory
    doc: path to centrifuge database
    inputBinding:
      position: 101
      prefix: --cdb
  - id: cov
    type:
      - 'null'
      - float
    doc: percentage coverage for plast searches
    inputBinding:
      position: 101
      prefix: --cov
  - id: e_value
    type:
      - 'null'
      - float
    doc: threshold for plast searches
    inputBinding:
      position: 101
      prefix: --e-value
  - id: kmers
    type:
      - 'null'
      - string
    doc: "kmers to use during assembly. These must be odd and\n                  \
      \      less than 128."
    default: 21,33,55
    inputBinding:
      position: 101
      prefix: --kmers
  - id: max_memory
    type:
      - 'null'
      - string
    doc: Maximum memory allocated to carry out an assembly
    inputBinding:
      position: 101
      prefix: --max_m
  - id: min_hit_length
    type:
      - 'null'
      - int
    doc: Minimum hit length by Centrifuge searches
    inputBinding:
      position: 101
      prefix: --mhlen
  - id: number_of_chunks
    type:
      - 'null'
      - int
    doc: Number of chunks to split a file
    inputBinding:
      position: 101
      prefix: --number-of-chunks
  - id: number_of_threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --number-of-threads
  - id: out_name
    type: string
    doc: output file basename
    inputBinding:
      position: 101
      prefix: --out_name
  - id: p_reads_class
    type:
      - 'null'
      - string
    doc: Classification for pair end reads
    inputBinding:
      position: 101
      prefix: --pclass
  - id: pid
    type:
      - 'null'
      - float
    doc: percentage identity for plast searches
    inputBinding:
      position: 101
      prefix: --pid
  - id: plast_database
    type:
      - 'null'
      - Directory
    doc: path to plast database
    inputBinding:
      position: 101
      prefix: --plast-database
  - id: plast_id_map
    type:
      - 'null'
      - File
    doc: path to taxonomy map for plast database
    inputBinding:
      position: 101
      prefix: --plast-id-map
  - id: r1
    type: File
    doc: left reads
    inputBinding:
      position: 101
      prefix: --r1
  - id: r2
    type: File
    doc: right reads
    inputBinding:
      position: 101
      prefix: --r2
  - id: taxonomy_update
    type:
      - 'null'
      - boolean
    doc: "Set to True the first time the program is used.\n                      \
      \  Otherwise set to False"
    inputBinding:
      position: 101
      prefix: --taxonomy-update
  - id: u_reads_class
    type:
      - 'null'
      - string
    doc: Classification for un-pair end reads
    inputBinding:
      position: 101
      prefix: --uclass
  - id: un
    type: File
    doc: orphan reads
    inputBinding:
      position: 101
      prefix: --un
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eukfinder:1.2.4--py36h503566f_0
stdout: eukfinder_short_seqs.out
