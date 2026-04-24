cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgatk
  - vcf-to-proteindb
label: pypgatk_vcf-to-proteindb
doc: "Configuration to perform conversion between ENSEMBL Files\n\nTool homepage:
  http://github.com/bigbio/py-pgatk"
inputs:
  - id: accepted_filters
    type:
      - 'null'
      - string
    doc: Accepted filters for variant parsing
    inputBinding:
      position: 101
      prefix: --accepted_filters
  - id: af_field
    type:
      - 'null'
      - string
    doc: field name in the VCF INFO column to use for filtering on AF
    inputBinding:
      position: 101
      prefix: --af_field
  - id: af_threshold
    type:
      - 'null'
      - string
    doc: Minium AF threshold for considering common variants
    inputBinding:
      position: 101
      prefix: --af_threshold
  - id: annotation_field_name
    type:
      - 'null'
      - string
    doc: Annotation field name found in the INFO column, e.g CSQ or vep; if 
      empty it will identify overlapping transcripts from the given GTF file and
      no aa consequence will be considered
    inputBinding:
      position: 101
      prefix: --annotation_field_name
  - id: biotype_str
    type:
      - 'null'
      - string
    doc: String that is used for biotype in the VCF header INFO field
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
  - id: consequence_str
    type:
      - 'null'
      - string
    doc: String that is used for consequence in the VCF header INFO field
    inputBinding:
      position: 101
      prefix: --consequence_str
  - id: exclude_biotypes
    type:
      - 'null'
      - string
    doc: Excluded Biotypes
    inputBinding:
      position: 101
      prefix: --exclude_biotypes
  - id: exclude_consequences
    type:
      - 'null'
      - string
    doc: Excluded Consequences
    inputBinding:
      position: 101
      prefix: --exclude_consequences
  - id: gene_annotations_gtf
    type:
      - 'null'
      - File
    doc: Path to the gene annotations file
    inputBinding:
      position: 101
      prefix: --gene_annotations_gtf
  - id: ignore_filters
    type:
      - 'null'
      - boolean
    doc: enabling this option causes or variants to be parsed. By default only 
      variants that have not failed any filters will be processed (FILTER column
      is PASS, None, .) or if the filters are subset of the accepted filters. 
      (default is False)
    inputBinding:
      position: 101
      prefix: --ignore_filters
  - id: include_biotypes
    type:
      - 'null'
      - string
    doc: included_biotypes, default all
    inputBinding:
      position: 101
      prefix: --include_biotypes
  - id: include_consequences
    type:
      - 'null'
      - string
    doc: included_consequences, default all
    inputBinding:
      position: 101
      prefix: --include_consequences
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: Path to the transcript sequence
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: mito_translation_table
    type:
      - 'null'
      - int
    doc: Mito_trans_table
    inputBinding:
      position: 101
      prefix: --mito_translation_table
  - id: protein_prefix
    type:
      - 'null'
      - string
    doc: String to add before the variant peptides
    inputBinding:
      position: 101
      prefix: --protein_prefix
  - id: report_ref_seq
    type:
      - 'null'
      - boolean
    doc: In addition to var peps, also report all ref peps
    inputBinding:
      position: 101
      prefix: --report_ref_seq
  - id: skip_including_all_cds
    type:
      - 'null'
      - boolean
    doc: by default any transcript that has a defined CDS will be used, this 
      option disables this features instead
    inputBinding:
      position: 101
      prefix: --skip_including_all_cds
  - id: transcript_str
    type:
      - 'null'
      - string
    doc: String that is used for transcript ID in the VCF header INFO field
    inputBinding:
      position: 101
      prefix: --transcript_str
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Translation table
    inputBinding:
      position: 101
      prefix: --translation_table
  - id: vcf
    type:
      - 'null'
      - File
    doc: Path to the VCF file
    inputBinding:
      position: 101
      prefix: --vcf
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
