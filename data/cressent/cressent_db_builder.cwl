cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - db_builder
label: cressent_db_builder
doc: "Build taxonomy-based database for ssDNA tool\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: taxonomy_file
    type: File
    doc: "Path to taxonomy_accession_number.csv file"
    inputBinding:
      position: 101
      prefix: --taxonomy-file
  - id: taxonomy_level
    type: string
    doc: "Taxonomy level to use for selection (Realm, Subrealm, Kingdom, Subkingdom, Phylum, Subphylum, Class, Subclass, Order, Suborder, Family, Subfamily, Genus, Subgenus, Species)"
    inputBinding:
      position: 101
      prefix: --taxonomy-level
  - id: selected_taxonomies
    type:
      - 'null'
      - string
    doc: "Selected taxonomies, space-separated (if not provided, will list available options)"
    inputBinding:
      position: 101
      prefix: --selected-taxonomies
  - id: output_dir
    type: string
    doc: "Output directory for database (created by the tool; collected as the output)"
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: email
    type:
      - 'null'
      - string
    doc: "Email for NCBI Entrez"
    inputBinding:
      position: 101
      prefix: --email
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use (default: 8)"
    inputBinding:
      position: 101
      prefix: --threads
  - id: cd_hit_identity
    type:
      - 'null'
      - float
    doc: "CD-HIT identity threshold (default: 0.95)"
    inputBinding:
      position: 101
      prefix: --cd-hit-identity
  - id: mcl_inflation
    type:
      - 'null'
      - float
    doc: "MCL inflation parameter (default: 1.5)"
    inputBinding:
      position: 101
      prefix: --mcl-inflation
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
