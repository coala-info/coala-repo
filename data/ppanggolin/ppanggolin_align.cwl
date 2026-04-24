cwlVersion: v1.2
class: CommandLineTool
baseCommand: ppanggolin align
label: ppanggolin_align
doc: "Align sequences (nucleotides or amino acids) on the pangenome gene families.\n\
  \nTool homepage: https://github.com/labgem/PPanGGOLiN"
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
  - id: draw_related
    type:
      - 'null'
      - boolean
    doc: Draw figures and provide graphs in a gexf format of the eventual spots 
      associated to the input sequences
    inputBinding:
      position: 101
      prefix: --draw_related
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Use representative sequences of gene families for input gene alignment.
      This option is faster but may be less sensitive. By default, all pangenome
      genes are used.
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
  - id: getinfo
    type:
      - 'null'
      - boolean
    doc: Use this option to extract info related to the best hit of each query, 
      such as the RGP it is in, or the spots.
    inputBinding:
      position: 101
      prefix: --getinfo
  - id: identity
    type:
      - 'null'
      - float
    doc: min identity percentage threshold
    inputBinding:
      position: 101
      prefix: --identity
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keeping temporary files (useful for debugging).
    inputBinding:
      position: 101
      prefix: --keep_tmp
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
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
    doc: The pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: sequences
    type: File
    doc: sequences (nucleotides or amino acids) to align on the pangenome gene 
      families
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
  - id: translation_table
    type:
      - 'null'
      - string
    doc: Translation table (genetic code) to use.
    inputBinding:
      position: 101
      prefix: --translation_table
  - id: use_pseudo
    type:
      - 'null'
      - boolean
    doc: In the context of provided annotation, use this option to read 
      pseudogenes. (Default behavior is to ignore them)
    inputBinding:
      position: 101
      prefix: --use_pseudo
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: Directory
    doc: Output directory where the file(s) will be written
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ppanggolin:2.2.6--py310h1fe012e_0
