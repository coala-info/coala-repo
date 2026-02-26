cwlVersion: v1.2
class: CommandLineTool
baseCommand: pgap2_add
label: pgap2_add
doc: "Add new sequences to an existing PGAP2 analysis.\n\nTool homepage: https://github.com/bucongfan/PGAP2"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: The aligner used to pairwise alignment.
    default: diamond
    inputBinding:
      position: 101
      prefix: --aligner
  - id: annot
    type:
      - 'null'
      - boolean
    doc: Discard original annotation, and re-annote the genome privately using 
      prodigal
    default: false
    inputBinding:
      position: 101
      prefix: --annot
  - id: clust_method
    type:
      - 'null'
      - string
    doc: The method used to cluster the genes.
    default: mmseqs2
    inputBinding:
      position: 101
      prefix: --clust_method
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Debug mode. Note: very verbose'
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: disable
    type:
      - 'null'
      - boolean
    doc: Disable progress bar
    default: false
    inputBinding:
      position: 101
      prefix: --disable
  - id: gcode
    type:
      - 'null'
      - int
    doc: The genetic code of your species.
    default: 11
    inputBinding:
      position: 101
      prefix: --gcode
  - id: id_attr_key
    type:
      - 'null'
      - string
    doc: Only for gff file as input, Attribute key to extract from the 9th 
      column as the record ID (e.g., 'ID', 'gene', 'locus_tag').
    default: ID
    inputBinding:
      position: 101
      prefix: --id-attr-key
  - id: indir
    type: Directory
    doc: Input file contained, same prefix seems as the same strain.
    inputBinding:
      position: 101
      prefix: --indir
  - id: min_falen
    type:
      - 'null'
      - int
    doc: protein length of throw_away_sequences, at least 11
    default: 20
    inputBinding:
      position: 101
      prefix: --min_falen
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: previous
    type:
      - 'null'
      - Directory
    doc: The previous PGAP2 result directory, used to resume the partition step 
      quickly.
    default: None
    inputBinding:
      position: 101
      prefix: --previous
  - id: retrieve
    type:
      - 'null'
      - boolean
    doc: Retrieve gene that may lost with annotations
    default: false
    inputBinding:
      position: 101
      prefix: --retrieve
  - id: threads
    type:
      - 'null'
      - int
    doc: threads used in parallel
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: type_filter
    type:
      - 'null'
      - string
    doc: Only for gff file as input, feature type (3rd column) to include, Only 
      lines matching these types will be processed.
    default: CDS
    inputBinding:
      position: 101
      prefix: --type-filter
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pgap2:1.1.0--pyhdfd78af_0
stdout: pgap2_add.out
