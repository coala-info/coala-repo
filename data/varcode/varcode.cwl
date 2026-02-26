cwlVersion: v1.2
class: CommandLineTool
baseCommand: varcode
label: varcode
doc: "Annotate variants with overlapping gene names and predicted coding effects\n\
  \nTool homepage: https://github.com/openvax/varcode"
inputs:
  - id: variant
    type:
      - 'null'
      - type: array
        items: string
    doc: "Individual variant as 4 arguments giving chromsome, position, ref, and alt.
      Example: chr1 3848 C G. Use '.' to indicate empty alleles for insertions or
      deletions."
    inputBinding:
      position: 1
  - id: download_reference_genome_data
    type:
      - 'null'
      - boolean
    doc: Automatically download genome reference data required for annotation 
      using PyEnsembl. Otherwise you must first run 'pyensembl install' for the 
      release/species corresponding to the genome used in your VCF.
    inputBinding:
      position: 102
      prefix: --download-reference-genome-data
  - id: genome
    type:
      - 'null'
      - string
    doc: "What reference assembly your variant coordinates are using. Examples: 'hg19',
      'GRCh38', or 'mm9'. This argument is ignored for MAF files, since each row includes
      the reference. For VCF files, this is used if specified, and otherwise is guessed
      from the header. For variants specfied on the commandline with --variant, this
      option is required."
    inputBinding:
      position: 102
      prefix: --genome
  - id: json_variants
    type:
      - 'null'
      - File
    doc: Path to Varcode.VariantCollection object serialized as a JSON file.
    inputBinding:
      position: 102
      prefix: --json-variants
  - id: maf
    type:
      - 'null'
      - File
    doc: Genomic variants in TCGA's MAF format
    inputBinding:
      position: 102
      prefix: --maf
  - id: one_per_variant
    type:
      - 'null'
      - boolean
    doc: Only return highest priority effect overlapping a variant, otherwise 
      all overlapping transcripts are returned.
    inputBinding:
      position: 102
      prefix: --one-per-variant
  - id: only_coding
    type:
      - 'null'
      - boolean
    doc: Filter silent and non-coding effects
    inputBinding:
      position: 102
      prefix: --only-coding
  - id: vcf
    type:
      - 'null'
      - File
    doc: Genomic variants in VCF format
    inputBinding:
      position: 102
      prefix: --vcf
outputs:
  - id: output_csv
    type:
      - 'null'
      - File
    doc: Output path to CSV
    outputBinding:
      glob: $(inputs.output_csv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varcode:1.2.1--pyh7e72e81_0
