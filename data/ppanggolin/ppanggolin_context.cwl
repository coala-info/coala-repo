cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin context
label: ppanggolin_context
doc: "PPanGGOLiN (2.2.6) is an open-source bioinformatics tool developed by the LABGeM
  team, and distributed under the CeCILL Free Software License Agreement.\n\nTool
  homepage: https://github.com/labgem/PPanGGOLiN"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Specify command arguments through a YAML configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: coverage
    type:
      - 'null'
      - float
    doc: min coverage percentage threshold
    inputBinding:
      position: 101
      prefix: --coverage
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of available cpus
    inputBinding:
      position: 101
      prefix: --cpu
  - id: disable_prog_bar
    type:
      - 'null'
      - boolean
    doc: disables the progress bars
    inputBinding:
      position: 101
      prefix: --disable_prog_bar
  - id: family
    type:
      - 'null'
      - string
    doc: List of family IDs of interest from the pangenome
    inputBinding:
      position: 101
      prefix: --family
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Use representative sequences of gene families for input gene alignment.
      This option is recommended for faster processing but may be less 
      sensitive. By default, all pangenome genes are used for alignment.
    inputBinding:
      position: 101
      prefix: --fast
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: graph_format
    type:
      - 'null'
      - string
    doc: Format of the context graph. Can be gexf or graphml.
    inputBinding:
      position: 101
      prefix: --graph_format
  - id: identity
    type:
      - 'null'
      - float
    doc: min identity percentage threshold
    inputBinding:
      position: 101
      prefix: --identity
  - id: jaccard
    type:
      - 'null'
      - float
    doc: minimum jaccard similarity used to filter edges between gene families. 
      Increasing it will improve precision but lower sensitivity a lot.
    inputBinding:
      position: 101
      prefix: --jaccard
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keeping temporary files (useful for debugging).
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: no_defrag
    type:
      - 'null'
      - boolean
    doc: DO NOT Realign gene families to link fragments withtheir non-fragmented
      gene family.
    inputBinding:
      position: 101
      prefix: --no_defrag
  - id: pangenome
    type: File
    doc: The pangenome.h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: sequences
    type:
      - 'null'
      - File
    doc: Fasta file with the sequences of interest
    inputBinding:
      position: 101
      prefix: --sequences
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for storing temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: transitive
    type:
      - 'null'
      - int
    doc: Size of the transitive closure used to build the graph. This indicates 
      the number of non related genes allowed in-between two related genes. 
      Increasing it will improve precision but lower sensitivity a little.
    inputBinding:
      position: 101
      prefix: --transitive
  - id: translation_table
    type:
      - 'null'
      - int
    doc: The translation table to use when the input sequences are nucleotide 
      sequences.
    inputBinding:
      position: 101
      prefix: --translation_table
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
  - id: window_size
    type:
      - 'null'
      - int
    doc: Number of neighboring genes that are considered on each side of a gene 
      of interest when searching for conserved genomic contexts.
    inputBinding:
      position: 101
      prefix: --window_size
outputs:
  - id: output
    type: Directory
    doc: Output directory where the file(s) will be written
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
