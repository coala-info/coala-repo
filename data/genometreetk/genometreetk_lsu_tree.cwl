cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometreetk lsu_tree
label: genometreetk_lsu_tree
doc: "Infer 23S tree spanning GTDB genomes.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: gtdb_metadata_file
    type: File
    doc: metadata file from GTDB (CSV format)
    inputBinding:
      position: 1
  - id: gtdb_lsu_file
    type: File
    doc: file with 23S sequences (FASTA format)
    inputBinding:
      position: 2
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 3
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of cpus
    inputBinding:
      position: 104
      prefix: --cpus
  - id: disable_tax_filter
    type:
      - 'null'
      - boolean
    doc: disable filtering of sequences with incongruent taxonomy
    inputBinding:
      position: 104
      prefix: --disable_tax_filter
  - id: genome_list
    type:
      - 'null'
      - string
    doc: explicit list of genomes to use
    inputBinding:
      position: 104
      prefix: --genome_list
  - id: max_contigs
    type:
      - 'null'
      - int
    doc: maximum contigs comprising a genome for it to be included in tree
    inputBinding:
      position: 104
      prefix: --max_contigs
  - id: min_lsu_length
    type:
      - 'null'
      - int
    doc: minimum length of 23S sequence to be include in tree
    inputBinding:
      position: 104
      prefix: --min_lsu_length
  - id: min_n50
    type:
      - 'null'
      - int
    doc: minimum N50 of contigs for a genome to be include in tree
    inputBinding:
      position: 104
      prefix: --min_N50
  - id: min_quality
    type:
      - 'null'
      - int
    doc: minimum quality (completeness - 5*contamination) for a genome to be 
      included in tree [0, 100]
    inputBinding:
      position: 104
      prefix: --min_quality
  - id: min_scaffold_length
    type:
      - 'null'
      - int
    doc: minimum length of scaffold containing 23S sequence to be include in 
      tree
    inputBinding:
      position: 104
      prefix: --min_scaffold_length
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 104
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
stdout: genometreetk_lsu_tree.out
