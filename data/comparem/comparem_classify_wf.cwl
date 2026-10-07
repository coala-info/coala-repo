cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comparem
  - classify_wf
label: comparem_classify_wf
doc: "Identify similar genomes based on AAI value (runs call_genes, similarity and classify).\n\nTool homepage: https://github.com/dparks1134/CompareM"
inputs:
  - id: query_files
    type: Directory
    doc: "query genome files (a directory holding the files; only files ending in --file_ext are used)"
    inputBinding:
      position: 1
  - id: target_files
    type: Directory
    doc: "target genome files (a directory holding the files; only files ending in --file_ext are used)"
    inputBinding:
      position: 2
  - id: output_dir
    type: string
    doc: "output directory"
    inputBinding:
      position: 3
  - id: num_top_targets
    type:
      - 'null'
      - int
    doc: "number of top scoring target genomes to report per query genome (default: 1)"
    inputBinding:
      position: 101
      prefix: --num_top_targets
  - id: taxonomy_file
    type:
      - 'null'
      - File
    doc: "file indicating taxonomic identification of all target genomes"
    inputBinding:
      position: 101
      prefix: --taxonomy_file
  - id: evalue
    type:
      - 'null'
      - double
    doc: "e-value cutoff for identifying initial blast hits (default: 0.001)"
    inputBinding:
      position: 101
      prefix: --evalue
  - id: per_identity
    type:
      - 'null'
      - float
    doc: "percent identity for defining homology (default: 30.0)"
    inputBinding:
      position: 101
      prefix: --per_identity
  - id: per_aln_len
    type:
      - 'null'
      - float
    doc: "percent alignment length of query sequence for defining homology (default: 70.0)"
    inputBinding:
      position: 101
      prefix: --per_aln_len
  - id: file_ext
    type:
      - 'null'
      - string
    doc: "extension of files to process (default: fna)"
    inputBinding:
      position: 101
      prefix: --file_ext
  - id: proteins
    type:
      - 'null'
      - boolean
    doc: "indicates the input files contain protein sequences"
    inputBinding:
      position: 101
      prefix: --proteins
  - id: force_table
    type:
      - 'null'
      - int
    doc: "force use of specific translation table"
    inputBinding:
      position: 101
      prefix: --force_table
  - id: blastp
    type:
      - 'null'
      - boolean
    doc: "use blastp instead of DIAMOND"
    inputBinding:
      position: 101
      prefix: --blastp
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: "use sensitive mode of DIAMOND"
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: keep_headers
    type:
      - 'null'
      - boolean
    doc: "indicates FASTA headers already have the format <genome_id>~<gene_id>"
    inputBinding:
      position: 101
      prefix: --keep_headers
  - id: keep_rbhs
    type:
      - 'null'
      - boolean
    doc: "create file with reciprocal best hits"
    inputBinding:
      position: 101
      prefix: --keep_rbhs
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "specify alternative directory for temporary files (default: /tmp)"
    inputBinding:
      position: 101
      prefix: --tmp_dir
  - id: cpus
    type:
      - 'null'
      - int
    doc: "number of CPUs to use (default: 1)"
    inputBinding:
      position: 101
      prefix: --cpus
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "suppress output"
    inputBinding:
      position: 101
      prefix: --silent
outputs:
  - id: output_directory
    type: Directory
    doc: "output directory with called genes, similarity hits and classification results"
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comparem:0.1.2--py_0
