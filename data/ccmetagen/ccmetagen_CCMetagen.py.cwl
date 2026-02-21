cwlVersion: v1.2
class: CommandLineTool
baseCommand: CCMetagen.py
label: ccmetagen_CCMetagen.py
doc: "CCMetagen is a pipeline for accurate taxonomic classification and abundance
  estimation of metagenomic data, typically using KMA (K-mer Alignment) results.\n
  \nTool homepage: https://github.com/vrmarcelino/CCMetagen"
inputs:
  - id: exclude_taxa
    type:
      - 'null'
      - type: array
        items: string
    doc: Taxa to exclude from the analysis
    inputBinding:
      position: 101
      prefix: --exclude
  - id: input_file
    type: File
    doc: Input KMA .res file
    inputBinding:
      position: 101
      prefix: --input
  - id: map_file
    type:
      - 'null'
      - File
    doc: KMA .map file
    inputBinding:
      position: 101
      prefix: --m_file
  - id: min_abundance
    type:
      - 'null'
      - float
    doc: Minimum abundance threshold for reporting
    default: 0.0
    inputBinding:
      position: 101
      prefix: --min_abundance
  - id: reference_db
    type:
      - 'null'
      - File
    doc: Reference database file (e.g., NCBI taxonomy or custom database)
    inputBinding:
      position: 101
      prefix: --reference
  - id: tax_level
    type:
      - 'null'
      - string
    doc: Taxonomy level for classification (e.g., kingdom, phylum, class, order, family,
      genus, species)
    default: species
    inputBinding:
      position: 101
      prefix: --tax_level
outputs:
  - id: output_prefix
    type: File
    doc: Prefix for output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccmetagen:1.5.0--pyh7cba7a3_0
