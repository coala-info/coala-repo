cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - inStrain
  - parse_annotations
label: instrain_parse_annotations
doc: "Run a number of outputs based a table of gene annotations\n\nTool homepage: https://github.com/MrOlm/inStrain"
inputs:
  - id: input
    type:
      type: array
      items: Directory
    doc: 'A list of inStrain objects, all mapped to the same .fasta file'
    inputBinding:
      position: 101
      prefix: --input
  - id: annotations
    type:
      type: array
      items: File
    doc: 'A table or set of tables with gene annotations. Must be a .csv file with two columns, `gene` and `anno`'
    inputBinding:
      position: 101
      prefix: --annotations
  - id: output
    type:
      - 'null'
      - string
    doc: 'Output prefix (default: annotation_output)'
    default: annotation_output
    inputBinding:
      position: 101
      prefix: --output
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to use (default: 6)'
    inputBinding:
      position: 101
      prefix: --processes
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Make extra debugging output (default: False)'
    inputBinding:
      position: 101
      prefix: --debug
  - id: min_genome_breadth
    type:
      - 'null'
      - float
    doc: 'Only annotate genomes on genomes with at least this genome breadth. Requires having genomes called. Set to 0 to include all genes (default: 0.5)'
    inputBinding:
      position: 101
      prefix: --min_genome_breadth
  - id: min_gene_breadth
    type:
      - 'null'
      - float
    doc: 'Only annotate genes with at least this breadth. Set to 0 to include all genes (default: 0.8)'
    inputBinding:
      position: 101
      prefix: --min_gene_breadth
  - id: store_rawdata
    type:
      - 'null'
      - boolean
    doc: 'Store the raw data dictionary (default: False)'
    inputBinding:
      position: 101
      prefix: --store_rawdata
outputs:
  - id: annotation_dir
    type: Directory
    doc: Annotation output directory (named by the output prefix)
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
