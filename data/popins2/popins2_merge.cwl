cwlVersion: v1.2
class: CommandLineTool
baseCommand: [popins2, merge]
label: popins2_merge
doc: "Build or read a colored and compacted de Bruijn graph (CCDBG) of the contigs of all samples and generate supercontigs.\n\nTool homepage: https://github.com/kehrlab/PopIns2"
inputs:
  - id: input_seq_files
    type:
      - 'null'
      - Directory
    doc: "Path to the sample directories (<DIR>/*/assembly_final.contigs.fa)"
    inputBinding:
      position: 1
      prefix: --input-seq-files
  - id: input_ref_files
    type:
      - 'null'
      - Directory
    doc: "Path to the sample directories (no abundance filter)"
    inputBinding:
      position: 1
      prefix: --input-ref-files
  - id: input_graph_file
    type:
      - 'null'
      - File
    doc: "Source file with the dBG (GFA)"
    inputBinding:
      position: 1
      prefix: --input-graph-file
  - id: input_colors_file
    type:
      - 'null'
      - File
    doc: "Source file with the dBG colors (bfg_colors)"
    inputBinding:
      position: 1
      prefix: --input-colors-file
  - id: outputfile_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for the output files. Default: supercontigs"
    inputBinding:
      position: 1
      prefix: --outputfile-prefix
  - id: contigs_filename
    type:
      - 'null'
      - string
    doc: "Filename of the contigs to search for in the sample directories. Default: assembly_final.contigs.fa"
    inputBinding:
      position: 1
      prefix: --contigs-filename
  - id: write_setcover
    type:
      - 'null'
      - boolean
    doc: "Write a CSV file with unitig IDs of the setcover"
    inputBinding:
      position: 1
      prefix: --write-setcover
  - id: write_lecc
    type:
      - 'null'
      - boolean
    doc: "Write a CSV file with unitig IDs of the LECCs"
    inputBinding:
      position: 1
      prefix: --write-lecc
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: "Kmer length for the dBG construction. In range [1..63]. Default: 63"
    inputBinding:
      position: 1
      prefix: --kmer-length
  - id: minimizer_length
    type:
      - 'null'
      - int
    doc: "Minimizer length for the dBG construction. In range [1..61]. Default: 49"
    inputBinding:
      position: 1
      prefix: --minimizer-length
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Print more output"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: clip_tips
    type:
      - 'null'
      - boolean
    doc: "Clip tips shorter than k kmers in length"
    inputBinding:
      position: 1
      prefix: --clip-tips
  - id: del_isolated
    type:
      - 'null'
      - boolean
    doc: "Delete isolated contigs shorter than k kmers in length"
    inputBinding:
      position: 1
      prefix: --del-isolated
  - id: mercy_kmers
    type:
      - 'null'
      - boolean
    doc: "Keep low coverage k-mers (cov=1) connecting tips of the graph"
    inputBinding:
      position: 1
      prefix: --mercy-kmers
  - id: setcover_min_kmers
    type:
      - 'null'
      - int
    doc: "Minimum amount of unseen kmers to include a path into the set cover. Default: 62"
    inputBinding:
      position: 1
      prefix: --setcover-min-kmers
  - id: min_entropy
    type:
      - 'null'
      - float
    doc: "Minimum entropy for a unitig to not get flagged as low entropy. In range [0.0..1.0]. Default: 0"
    inputBinding:
      position: 1
      prefix: --min-entropy
  - id: threads
    type:
      - 'null'
      - int
    doc: "Amount of threads for parallel processing. Default: 1"
    inputBinding:
      position: 1
      prefix: --threads
outputs:
  - id: supercontigs
    type:
      - 'null'
      - File
    doc: "Supercontigs (FASTA)"
    outputBinding:
      glob: "${return (inputs.outputfile_prefix || 'supercontigs') + '.fa';}"
  - id: graph
    type:
      - 'null'
      - File
    doc: "Compacted de Bruijn graph (GFA)"
    outputBinding:
      glob: "${return (inputs.outputfile_prefix || 'supercontigs') + '.gfa';}"
  - id: colors
    type:
      - 'null'
      - File
    doc: "Graph colors"
    outputBinding:
      glob: "${return (inputs.outputfile_prefix || 'supercontigs') + '.color.bfg';}"
  - id: setcover_csv
    type:
      type: array
      items: File
    doc: "Setcover / LECC unitig IDs (with --write-setcover / --write-lecc)"
    outputBinding:
      glob: "${var p = inputs.outputfile_prefix || 'supercontigs'; return [p + '.setcover.csv', p + '.lecc.csv'];}"
  - id: log
    type: stderr
    doc: "Log messages"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/popins2:0.13.0--h077b44d_0
stderr: popins2_merge.log
