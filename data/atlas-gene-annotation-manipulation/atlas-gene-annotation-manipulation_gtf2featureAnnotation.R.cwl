cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtf2featureAnnotation.R
label: atlas-gene-annotation-manipulation_gtf2featureAnnotation.R
doc: "R script for manipulating GTF files to create feature annotations.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/atlas-gene-annotation-manipulation"
inputs:
  - id: feature_type
    type:
      - 'null'
      - string
    doc: Feature type to use
    default: gene
    inputBinding:
      position: 101
      prefix: --feature-type
  - id: fields
    type:
      - 'null'
      - string
    doc: Comma-separated list of output fields to retain
    default: all
    inputBinding:
      position: 101
      prefix: --fields
  - id: fill_empty
    type:
      - 'null'
      - string
    doc: Where --fields is specified, fill empty specified columns with the 
      content of the specified field. Useful when you need to guarantee a value,
      for example a gene ID for a transcript/gene mapping.
    inputBinding:
      position: 101
      prefix: --fill-empty
  - id: first_field
    type:
      - 'null'
      - string
    doc: Field to place first in output table
    default: gene_id
    inputBinding:
      position: 101
      prefix: --first-field
  - id: gtf_file
    type: File
    doc: Path to a valid GTF file
    inputBinding:
      position: 101
      prefix: --gtf-file
  - id: mito
    type:
      - 'null'
      - boolean
    doc: Mark mitochondrial elements with reference to chromsomes and biotypes
    inputBinding:
      position: 101
      prefix: --mito
  - id: mito_biotypes
    type:
      - 'null'
      - string
    doc: If specified, marks in a column called "mito" features with the 
      specified biotypes (case insensitve)
    inputBinding:
      position: 101
      prefix: --mito-biotypes
  - id: mito_chr
    type:
      - 'null'
      - string
    doc: If specified, marks in a column called "mito" features on the specified
      chromosomes (case insensitive)
    inputBinding:
      position: 101
      prefix: --mito-chr
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Suppress header on output
    inputBinding:
      position: 101
      prefix: --no-header
  - id: parse_cdna_field
    type:
      - 'null'
      - string
    doc: Where --parse-cdnas is specified, what field should be used to compare 
      to identfiers from the FASTA?
    inputBinding:
      position: 101
      prefix: --parse-cdna-field
  - id: parse_cdna_names
    type:
      - 'null'
      - boolean
    doc: Where --parse-cdnas is specified, parse out info from the Fasta name. 
      Will likely only work for Ensembl GTFs
    inputBinding:
      position: 101
      prefix: --parse-cdna-names
  - id: parse_cdnas
    type:
      - 'null'
      - File
    doc: Provide a cDNA file for extracting meta info and/or filtering.
    inputBinding:
      position: 101
      prefix: --parse-cdnas
  - id: version_transcripts
    type:
      - 'null'
      - boolean
    doc: 'Where the GTF contains transcript versions, should these be appended to
      transcript identifiers? Useful when generating transcript/gene mappings for
      use with transcriptomes. NOTE: if --filter-cdnas-field is set, the setting of
      this field is set to best match transcript identifiers in the cDNAs FASTA.'
    inputBinding:
      position: 101
      prefix: --version-transcripts
outputs:
  - id: filter_cdnas_output
    type:
      - 'null'
      - File
    doc: Where --parse-cdnas is specified, filter sequences and output to the 
      specified file. No file will be output if this is not specified (for 
      example for use of --dummy-from-cdnas only).
    outputBinding:
      glob: $(inputs.filter_cdnas_output)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/atlas-gene-annotation-manipulation:1.1.1--hdfd78af_0
