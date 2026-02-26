cwlVersion: v1.2
class: CommandLineTool
baseCommand: prefetch
label: sourmash_prefetch
doc: "Search for query signatures within specified databases.\n\nTool homepage: https://github.com/sourmash-bio/sourmash"
inputs:
  - id: query
    type: string
    doc: query signature
    inputBinding:
      position: 1
  - id: databases
    type:
      - 'null'
      - type: array
        items: string
    doc: one or more databases to search
    inputBinding:
      position: 2
  - id: dayhoff
    type:
      - 'null'
      - boolean
    doc: choose Dayhoff-encoded amino acid signatures
    inputBinding:
      position: 103
      prefix: --dayhoff
  - id: db_from_file
    type:
      - 'null'
      - File
    doc: list of paths containing signatures to search
    inputBinding:
      position: 103
      prefix: --db-from-file
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --debug
  - id: dna
    type:
      - 'null'
      - boolean
    doc: 'choose a nucleotide signature (default: True)'
    default: true
    inputBinding:
      position: 103
      prefix: --dna
  - id: estimate_ani_ci
    type:
      - 'null'
      - boolean
    doc: also output confidence intervals for ANI estimates
    inputBinding:
      position: 103
      prefix: --estimate-ani-ci
  - id: exclude_db_pattern
    type:
      - 'null'
      - string
    doc: search only signatures that do not match this pattern in name, 
      filename, or md5
    inputBinding:
      position: 103
      prefix: --exclude-db-pattern
  - id: hp
    type:
      - 'null'
      - boolean
    doc: choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 103
      prefix: --hp
  - id: include_db_pattern
    type:
      - 'null'
      - string
    doc: search only signatures that match this pattern in name, filename, or 
      md5
    inputBinding:
      position: 103
      prefix: --include-db-pattern
  - id: ksize
    type:
      - 'null'
      - int
    doc: k-mer size to select; no default.
    inputBinding:
      position: 103
      prefix: --ksize
  - id: linear
    type:
      - 'null'
      - boolean
    doc: force linear traversal of indexes to minimize loading time and memory 
      use
    inputBinding:
      position: 103
      prefix: --linear
  - id: md5
    type:
      - 'null'
      - string
    doc: select the signature with this md5 as query
    inputBinding:
      position: 103
      prefix: --md5
  - id: no_dayhoff
    type:
      - 'null'
      - boolean
    doc: do not choose Dayhoff-encoded amino acid signatures
    inputBinding:
      position: 103
      prefix: --no-dayhoff
  - id: no_dna
    type:
      - 'null'
      - boolean
    doc: do not choose a nucleotide signature
    inputBinding:
      position: 103
      prefix: --no-dna
  - id: no_hp
    type:
      - 'null'
      - boolean
    doc: do not choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 103
      prefix: --no-hp
  - id: no_linear
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --no-linear
  - id: no_protein
    type:
      - 'null'
      - boolean
    doc: do not choose a protein signature
    inputBinding:
      position: 103
      prefix: --no-protein
  - id: no_skipm1n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m1n3) signatures
    inputBinding:
      position: 103
      prefix: --no-skipm1n3
  - id: no_skipm2n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m2n3) signatures
    inputBinding:
      position: 103
      prefix: --no-skipm2n3
  - id: picklist
    type:
      - 'null'
      - string
    doc: select signatures based on a picklist, i.e. 'file.csv:colname:coltype'
    inputBinding:
      position: 103
      prefix: --picklist
  - id: picklist_require_all
    type:
      - 'null'
      - boolean
    doc: require that all picklist values be found or else fail
    inputBinding:
      position: 103
      prefix: --picklist-require-all
  - id: protein
    type:
      - 'null'
      - boolean
    doc: choose a protein signature; by default, a nucleotide signature is used
    inputBinding:
      position: 103
      prefix: --protein
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress non-error output
    inputBinding:
      position: 103
      prefix: --quiet
  - id: scaled
    type:
      - 'null'
      - float
    doc: downsample to this scaled; value should be between 100 and 1e6
    inputBinding:
      position: 103
      prefix: --scaled
  - id: skipm1n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m1n3) signatures
    inputBinding:
      position: 103
      prefix: --skipm1n3
  - id: skipm2n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m2n3) signatures
    inputBinding:
      position: 103
      prefix: --skipm2n3
  - id: threshold_bp
    type:
      - 'null'
      - float
    doc: reporting threshold (in bp) for estimated overlap with remaining query 
      hashes
    default: 50kb
    inputBinding:
      position: 103
      prefix: --threshold-bp
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output CSV containing matches to this file
    outputBinding:
      glob: $(inputs.output_file)
  - id: save_matches
    type:
      - 'null'
      - File
    doc: save all matching signatures from the databases to the specified file 
      or directory
    outputBinding:
      glob: $(inputs.save_matches)
  - id: save_unmatched_hashes
    type:
      - 'null'
      - File
    doc: output unmatched query hashes as a signature to the specified file
    outputBinding:
      glob: $(inputs.save_unmatched_hashes)
  - id: save_matching_hashes
    type:
      - 'null'
      - File
    doc: output matching query hashes as a signature to the specified file
    outputBinding:
      glob: $(inputs.save_matching_hashes)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
