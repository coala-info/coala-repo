cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_nr_pangenome_matrix.pl
label: get_homologues_make_nr_pangenome_matrix.pl
doc: "Makes a non-redundant pangenome matrix by merging clusters of a pangenome matrix made by compare_clusters.pl, using BLAST similarities between median cluster sequences; optionally matches clusters to a reference.\n\nTool homepage: https://github.com/eead-csic-compbio/get_homologues"
inputs:
  - id: input_matrix
    type: File
    doc: 'input pangenome matrix .tab (made by compare_clusters.pl)'
    inputBinding:
      position: 1
      prefix: -m
  - id: clusters_source_path
    type: string
    doc: 'absolute path of the cluster folder, as written after ''source:'' in the first line of the matrix (the tool reads the cluster files there; the folder is made available at this path)'
  - id: clusters_dir
    type: Directory
    doc: 'cluster folder written by compare_clusters.pl together with the matrix'
  - id: min_taxa
    type:
      - 'null'
      - int
    doc: 'consider only clusters with at least t taxa (default:1)'
    inputBinding:
      position: 1
      prefix: -t
  - id: min_mean_length
    type:
      - 'null'
      - int
    doc: 'min mean sequence length per cluster (default:0)'
    inputBinding:
      position: 1
      prefix: -l
  - id: identity_cutoff
    type:
      - 'null'
      - int
    doc: '%sequence identity cutoff (default:90)'
    inputBinding:
      position: 1
      prefix: -S
  - id: coverage_cutoff
    type:
      - 'null'
      - int
    doc: '%alignment coverage cutoff, calculated over longest sequence (default:75)'
    inputBinding:
      position: 1
      prefix: -C
  - id: peptides
    type:
      - 'null'
      - boolean
    doc: 'sequences are peptides (by default expects nucleotides)'
    inputBinding:
      position: 1
      prefix: -P
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads for BLAST jobs (default:2)'
    inputBinding:
      position: 1
      prefix: -n
  - id: est_sequences
    type:
      - 'null'
      - boolean
    doc: 'sequences are (probably) incomplete ESTs (calculates coverage over shortest)'
    inputBinding:
      position: 1
      prefix: -e
  - id: reference_clusters_dir
    type:
      - 'null'
      - Directory
    doc: 'reference clusters contained in directory (example: -r cross_species_clusters)'
    inputBinding:
      position: 1
      prefix: -r
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: 'parse sequences in this file (ignores -r; example: -f swissprot.faa)'
    inputBinding:
      position: 1
      prefix: -f
  - id: reference_identity_cutoff
    type:
      - 'null'
      - int
    doc: '%sequence identity cutoff for matching reference seqs (default:50)'
    inputBinding:
      position: 1
      prefix: -s
  - id: reference_coverage_cutoff
    type:
      - 'null'
      - int
    doc: '%alignment coverage cutoff for matching reference seqs, calculated over longest sequence (default:50)'
    inputBinding:
      position: 1
      prefix: -c
outputs:
  - id: nr_matrix
    type: File
    doc: 'Non-redundant pangenome matrix.'
    outputBinding:
      glob: $(inputs.input_matrix.nameroot)_nr_*.tab
  - id: nr_fasta
    type:
      - 'null'
      - File
    doc: 'FASTA file with the median sequence of each cluster.'
    outputBinding:
      glob:
        - $(inputs.input_matrix.nameroot)_nr_*.faa
        - $(inputs.input_matrix.nameroot)_nr_*.fna
  - id: blast_result
    type:
      - 'null'
      - File
    doc: 'BLAST search of the median cluster sequences against each other.'
    outputBinding:
      glob: $(inputs.input_matrix.nameroot)_nr_*.blast
  - id: log
    type:
      - 'null'
      - File
    doc: 'Log of merged clusters.'
    outputBinding:
      glob: $(inputs.input_matrix.nameroot)_nr_*.log
  - id: stdout
    type: stdout
    doc: 'Standard output'
stdout: get_homologues_make_nr_pangenome_matrix.pl.out
requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_matrix)
        writable: true
      - entryname: $(inputs.clusters_source_path)
        entry: $(inputs.clusters_dir)
