cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-taxonomy
label: autometa_autometa-taxonomy
doc: "Filter metagenome by taxonomy.\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: votes
    type: File
    doc: "Input path to voted taxids table; should contain (at least) 'contig' and 'taxid' columns"
    inputBinding:
      position: 1
      prefix: --votes
  - id: assembly
    type: File
    doc: "Path to metagenome assembly (nucleotide fasta)."
    inputBinding:
      position: 1
      prefix: --assembly
  - id: output
    type: string
    doc: "Output directory to write specified canonical ranks fasta files and taxon-binning results table"
    inputBinding:
      position: 1
      prefix: --output
  - id: prefix
    type:
      - 'null'
      - string
    doc: "prefix to use for each file written e.g. `prefix`.taxonomy.tsv (not a directory)"
    inputBinding:
      position: 1
      prefix: --prefix
  - id: split_rank_and_write
    type:
      - 'null'
      - string
    doc: "If specified, split contigs by this canonical-rank column then write to `output` directory (superkingdom, phylum, class, order, family, genus, species)"
    inputBinding:
      position: 1
      prefix: --split-rank-and-write
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: "Path to taxonomy database directory."
    inputBinding:
      position: 1
      prefix: --dbdir
  - id: dbtype
    type:
      - 'null'
      - string
    doc: "Taxonomy database to use (ncbi, gtdb) (default: ncbi)"
    inputBinding:
      position: 1
      prefix: --dbtype
outputs:
  - id: output_dir
    type: Directory
    doc: "Taxonomy results directory"
    outputBinding:
      glob: "$(inputs.output)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
