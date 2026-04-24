cwlVersion: v1.2
class: CommandLineTool
baseCommand: popins2 merge
label: popins2_merge
doc: "Build or read a colored and compacted de Bruijn Graph (CCDBG) and generate supercontigs.\n\
  \nTool homepage: https://github.com/kehrlab/PopIns2"
inputs:
  - id: clip_tips
    type:
      - 'null'
      - boolean
    doc: Clip tips shorter than k kmers in length
    inputBinding:
      position: 101
      prefix: --clip-tips
  - id: contigs_filename
    type:
      - 'null'
      - string
    doc: Specify a filename of contigs to search for in the sample directories.
    inputBinding:
      position: 101
      prefix: --contigs-filename
  - id: del_isolated
    type:
      - 'null'
      - boolean
    doc: Delete isolated contigs shorter than k kmers in length
    inputBinding:
      position: 101
      prefix: --del-isolated
  - id: input_colors_file
    type:
      - 'null'
      - File
    doc: Source file with dBG colors
    inputBinding:
      position: 101
      prefix: --input-colors-file
  - id: input_graph_file
    type:
      - 'null'
      - File
    doc: Source file with dBG
    inputBinding:
      position: 101
      prefix: --input-graph-file
  - id: input_ref_files
    type:
      - 'null'
      - Directory
    doc: Path to the sample directories. (no abundance filter)
    inputBinding:
      position: 101
      prefix: --input-ref-files
  - id: input_seq_files
    type:
      - 'null'
      - Directory
    doc: Path to the sample directories.
    inputBinding:
      position: 101
      prefix: --input-seq-files
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: Kmer length for the dBG construction In range [1..63].
    inputBinding:
      position: 101
      prefix: --kmer-length
  - id: min_entropy
    type:
      - 'null'
      - float
    doc: Minimum entropy for a unitig to not get flagged as low entropy In range
      [0.0..1.0].
    inputBinding:
      position: 101
      prefix: --min-entropy
  - id: outputfile_prefix
    type:
      - 'null'
      - string
    doc: Specify a prefix for the output files.
    inputBinding:
      position: 101
      prefix: --outputfile-prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Amount of threads for parallel processing In range [1..inf].
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stdout: popins2_merge.out
