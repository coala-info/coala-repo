cwlVersion: v1.2
class: CommandLineTool
baseCommand: autometa-binning-summary
label: autometa_autometa-binning-summary
doc: "Summarize Autometa results writing genome fastas and their respective taxonomies/assembly metrics for respective metagenomes\n\nTool homepage: https://github.com/KwanLab/Autometa"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: binning_main
    type: File
    doc: "Path to Autometa binning main table (output from --binning-main argument)"
    inputBinding:
      position: 1
      prefix: --binning-main
  - id: markers
    type: File
    doc: "Path to annotated markers respective to domain (bacteria or archaea) binned"
    inputBinding:
      position: 1
      prefix: --markers
  - id: metagenome
    type: File
    doc: "Path to metagenome assembly"
    inputBinding:
      position: 1
      prefix: --metagenome
  - id: dbdir
    type:
      - 'null'
      - Directory
    doc: "Path to user taxonomy database directory (Required for retrieving metabin taxonomies)"
    inputBinding:
      position: 1
      prefix: --dbdir
  - id: dbtype
    type:
      - 'null'
      - string
    doc: "Taxonomy database type to use (ncbi, gtdb) (default: ncbi)"
    inputBinding:
      position: 1
      prefix: --dbtype
  - id: binning_column
    type:
      - 'null'
      - string
    doc: "Binning column to use for grouping metabins (default: cluster)"
    inputBinding:
      position: 1
      prefix: --binning-column
  - id: output_stats
    type: string
    doc: "Path to write metabins stats table"
    inputBinding:
      position: 1
      prefix: --output-stats
  - id: output_taxonomy
    type: string
    doc: "Path to write metabins taxonomies table"
    inputBinding:
      position: 1
      prefix: --output-taxonomy
  - id: output_metabins
    type: string
    doc: "Path to output directory (must not exist; it will be created)"
    inputBinding:
      position: 1
      prefix: --output-metabins
outputs:
  - id: stats_out
    type: File
    doc: "Metabins stats table"
    outputBinding:
      glob: "$(inputs.output_stats)"
  - id: taxonomy_out
    type: File?
    doc: "Metabins taxonomies table"
    outputBinding:
      glob: "$(inputs.output_taxonomy)"
  - id: metabins_out
    type: Directory
    doc: "Directory of metabin fasta files"
    outputBinding:
      glob: "$(inputs.output_metabins)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/autometa:2.2.3--pyh7e72e81_0
