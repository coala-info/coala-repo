cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ppanggolin
  - msa
label: ppanggolin_msa
doc: "compute Multiple Sequence Alignment of the gene families in the given partition\n\
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
  - id: dup_margin
    type:
      - 'null'
      - float
    doc: minimum ratio of genomes in which the family must have multiple genes 
      for it to be considered 'duplicated'
    inputBinding:
      position: 101
      prefix: --dup_margin
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing in output directory and in pangenome output file.
    inputBinding:
      position: 101
      prefix: --force
  - id: log
    type:
      - 'null'
      - File
    doc: log output file
    inputBinding:
      position: 101
      prefix: --log
  - id: pangenome
    type: File
    doc: The pangenome .h5 file
    inputBinding:
      position: 101
      prefix: --pangenome
  - id: partition
    type:
      - 'null'
      - string
    doc: compute Multiple Sequence Alignment of the gene families in the given 
      partition
    default: all
    inputBinding:
      position: 101
      prefix: --partition
  - id: phylo
    type:
      - 'null'
      - boolean
    doc: Writes a whole genome msa file for additional phylogenetic analysis
    inputBinding:
      position: 101
      prefix: --phylo
  - id: single_copy
    type:
      - 'null'
      - boolean
    doc: Use report gene families that are considered 'single copy', for details
      see option --dup_margin
    inputBinding:
      position: 101
      prefix: --single_copy
  - id: soft_core
    type:
      - 'null'
      - string
    doc: Soft core threshold to use if 'softcore' partition is chosen
    inputBinding:
      position: 101
      prefix: --soft_core
  - id: source
    type:
      - 'null'
      - string
    doc: indicates whether to use protein or dna sequences to compute the msa
    inputBinding:
      position: 101
      prefix: --source
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
      - int
    doc: Translation table (genetic code) to use.
    inputBinding:
      position: 101
      prefix: --translation_table
  - id: use_gene_id
    type:
      - 'null'
      - boolean
    doc: Use gene identifiers rather than genome names for sequences in the 
      family MSA (genome names are used by default)
    inputBinding:
      position: 101
      prefix: --use_gene_id
  - id: verbose
    type:
      - 'null'
      - int
    doc: Indicate verbose level (0 for warning and errors only, 1 for info, 2 
      for debug)
    default: 0
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
