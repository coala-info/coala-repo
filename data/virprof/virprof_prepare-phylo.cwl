cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - virprof
  - prepare-phylo
label: virprof_prepare-phylo
doc: "Prepares sequences for phylogenetic analysis\n\nTool homepage: https://github.com/seiboldlab/virprof"
inputs:
  - id: in_fasta
    type:
      - 'null'
      - type: array
        items: File
    doc: Input FASTA files
    inputBinding:
      position: 1
  - id: add_all_genomes
    type:
      - 'null'
      - boolean
    doc: Add all NCBI genomes for selected species to output
    inputBinding:
      position: 102
      prefix: --add-all-genomes
  - id: add_outgroup
    type:
      - 'null'
      - boolean
    doc: Not implemented
    inputBinding:
      position: 102
      prefix: --add-outgroup
  - id: add_references
    type:
      - 'null'
      - boolean
    doc: Add reference sequences to output
    inputBinding:
      position: 102
      prefix: --add-references
  - id: exclude_full
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --exclude-full
  - id: exclude_short
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --exclude-short
  - id: in_filter
    type:
      - 'null'
      - string
    doc: Specify regex to filter FASTA input sequences by name
    inputBinding:
      position: 102
      prefix: --in-filter
  - id: include_full
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --include-full
  - id: include_short
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 102
      prefix: --include-short
  - id: max_bp
    type:
      - 'null'
      - int
    doc: Maximum number of unambious base pairs (for reference include only).
    inputBinding:
      position: 102
      prefix: --min-bp
  - id: min_bp
    type:
      - 'null'
      - int
    doc: Minimum number of unambious base pairs.
    inputBinding:
      position: 102
      prefix: --min-bp
  - id: ncbi_api_key
    type:
      - 'null'
      - string
    doc: NCBI API Key
    inputBinding:
      position: 102
      prefix: --ncbi-api-key
  - id: no_add_all_genomes
    type:
      - 'null'
      - boolean
    doc: Add all NCBI genomes for selected species to output
    inputBinding:
      position: 102
      prefix: --no-add-all-genomes
  - id: no_add_outgroup
    type:
      - 'null'
      - boolean
    doc: Not implemented
    inputBinding:
      position: 102
      prefix: --no-add-outgroup
  - id: no_add_references
    type:
      - 'null'
      - boolean
    doc: Add reference sequences to output
    inputBinding:
      position: 102
      prefix: --no-add-references
  - id: only_references
    type:
      - 'null'
      - boolean
    doc: Only export reference sequences
    inputBinding:
      position: 102
      prefix: --only-references
  - id: species
    type:
      - 'null'
      - type: array
        items: string
    doc: Species to fetch sequences for. May be specified multiple times. If 
      given, species names will not be autodetected from input fasta file names
    inputBinding:
      position: 102
      prefix: --species
outputs:
  - id: out_fasta
    type: File
    doc: Output FASTA file for alignment+treeing
    outputBinding:
      glob: $(inputs.out_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
