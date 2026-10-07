cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comparem
  - classify
label: comparem_classify
doc: "Identify similar genomes based on AAI value.\n\nTool homepage: https://github.com/dparks1134/CompareM"
inputs:
  - id: query_gene_file
    type: File
    doc: "file with all query genes"
    inputBinding:
      position: 1
  - id: target_gene_file
    type: File
    doc: "file with all target genes"
    inputBinding:
      position: 2
  - id: sorted_hit_table
    type: File
    doc: "sorted file indicating genes passing sequence similarity criteria"
    inputBinding:
      position: 3
  - id: output_dir
    type: string
    doc: "output directory"
    inputBinding:
      position: 4
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
  - id: keep_rbhs
    type:
      - 'null'
      - boolean
    doc: "create file with reciprocal best hits"
    inputBinding:
      position: 101
      prefix: --keep_rbhs
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
    doc: "output directory with classification results"
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comparem:0.1.2--py_0
