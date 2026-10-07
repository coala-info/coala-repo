cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comparem
  - similarity
label: comparem_similarity
doc: "Perform sequence similarity search between genes.\n\nTool homepage: https://github.com/dparks1134/CompareM"
inputs:
  - id: query_proteins
    type: Directory
    doc: "query protein files to process (a directory holding the files; only files ending in --file_ext are used)"
    inputBinding:
      position: 1
  - id: target_proteins
    type: Directory
    doc: "target protein files to process (a directory holding the files; only files ending in --file_ext are used)"
    inputBinding:
      position: 2
  - id: output_dir
    type: string
    doc: "output directory"
    inputBinding:
      position: 3
  - id: evalue
    type:
      - 'null'
      - double
    doc: "maximum e-value for reporting an alignments (default: 0.001)"
    inputBinding:
      position: 101
      prefix: --evalue
  - id: per_identity
    type:
      - 'null'
      - float
    doc: "minimum percent identity for reporting an alignment (default: 30.0)"
    inputBinding:
      position: 101
      prefix: --per_identity
  - id: per_aln_len
    type:
      - 'null'
      - float
    doc: "minimum percent coverage of query sequence for reporting an alignment (default: 70.0)"
    inputBinding:
      position: 101
      prefix: --per_aln_len
  - id: file_ext
    type:
      - 'null'
      - string
    doc: "extension of files to process (default: faa)"
    inputBinding:
      position: 101
      prefix: --file_ext
  - id: blastp
    type:
      - 'null'
      - boolean
    doc: "use Blastp-fast instead of DIAMOND"
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
    doc: "output directory with query_genes.faa, target_genes.faa and hits_sorted.tsv"
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comparem:0.1.2--py_0
