cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgatk dnaseq-to-proteindb
label: pypgatk_dnaseq-to-proteindb
doc: "Configuration to perform conversion between ENSEMBL Files\n\nTool homepage:
  http://github.com/bigbio/py-pgatk"
inputs:
  - id: biotype_str
    type:
      - 'null'
      - string
    doc: String used to identify gene/transcript biotype in the gtf file.
    inputBinding:
      position: 101
      prefix: --biotype_str
  - id: config_file
    type:
      - 'null'
      - string
    doc: Configuration to perform conversion between ENSEMBL Files
    inputBinding:
      position: 101
      prefix: --config_file
  - id: exclude_biotypes
    type:
      - 'null'
      - string
    doc: Exclude Biotypes
    inputBinding:
      position: 101
      prefix: --exclude_biotypes
  - id: expression_str
    type:
      - 'null'
      - string
    doc: String to be used for extracting expression value (TPM, FPKM, etc).
    inputBinding:
      position: 101
      prefix: --expression_str
  - id: expression_thresh
    type:
      - 'null'
      - float
    doc: Threshold used to filter transcripts based on their expression values
    inputBinding:
      position: 101
      prefix: --expression_thresh
  - id: include_biotypes
    type:
      - 'null'
      - string
    doc: Include Biotypes
    inputBinding:
      position: 101
      prefix: --include_biotypes
  - id: input_fasta
    type:
      - 'null'
      - string
    doc: Path to sequences fasta
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: num_orfs
    type:
      - 'null'
      - int
    doc: Number of ORFs
    inputBinding:
      position: 101
      prefix: --num_orfs
  - id: num_orfs_complement
    type:
      - 'null'
      - int
    doc: Number of ORFs from the reverse side
    inputBinding:
      position: 101
      prefix: --num_orfs_complement
  - id: protein_prefix
    type:
      - 'null'
      - string
    doc: String to add before the variant protein
    inputBinding:
      position: 101
      prefix: --protein_prefix
  - id: skip_including_all_cds
    type:
      - 'null'
      - boolean
    doc: By default any transcript that has a defined CDS will be translated, 
      this option disables this features instead it only depends on the biotypes
    inputBinding:
      position: 101
      prefix: --skip_including_all_cds
  - id: transcript_description_sep
    type:
      - 'null'
      - string
    doc: Separator used to separate features in the fasta headers, usually 
      either (space, / or semicolon).
    inputBinding:
      position: 101
      prefix: --transcript_description_sep
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Translation Table
    inputBinding:
      position: 101
      prefix: --translation_table
outputs:
  - id: output_proteindb
    type:
      - 'null'
      - File
    doc: Output file name, exits if already exists
    outputBinding:
      glob: $(inputs.output_proteindb)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
