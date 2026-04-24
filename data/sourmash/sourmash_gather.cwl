cwlVersion: v1.2
class: CommandLineTool
baseCommand: sourmash gather
label: sourmash_gather
doc: "Selects the best reference genomes to use for a metagenome analysis, by finding
  the smallest set of non-overlapping matches to the query in a database. This is
  specifically meant for metagenome and genome bin analysis.\n\nTool homepage: https://github.com/sourmash-bio/sourmash"
inputs:
  - id: query
    type: string
    doc: query signature
    inputBinding:
      position: 1
  - id: databases
    type:
      type: array
      items: string
    doc: signatures/SBTs to search
    inputBinding:
      position: 2
  - id: cache_size
    type:
      - 'null'
      - int
    doc: 'number of internal SBT nodes to cache in memory (default: 0, cache all nodes)'
    inputBinding:
      position: 103
      prefix: --cache-size
  - id: create_empty_results
    type:
      - 'null'
      - boolean
    doc: create an empty results file even if no matches.
    inputBinding:
      position: 103
      prefix: --create-empty-results
  - id: dayhoff
    type:
      - 'null'
      - boolean
    doc: choose Dayhoff-encoded amino acid signatures
    inputBinding:
      position: 103
      prefix: --dayhoff
  - id: debug
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --debug
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
  - id: fail_on_empty_database
    type:
      - 'null'
      - boolean
    doc: stop at databases that contain no compatible signatures
    inputBinding:
      position: 103
      prefix: --fail-on-empty-database
  - id: hydrophobic_polar
    type:
      - 'null'
      - boolean
    doc: choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 103
      prefix: --hydrophobic-polar
  - id: ignore_abundance
    type:
      - 'null'
      - boolean
    doc: do NOT use k-mer abundances if present
    inputBinding:
      position: 103
      prefix: --ignore-abundance
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
    doc: force a low-memory but maybe slower database search
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
  - id: no_fail_on_empty_database
    type:
      - 'null'
      - boolean
    doc: continue past databases that contain no compatible signatures
    inputBinding:
      position: 103
      prefix: --no-fail-on-empty-database
  - id: no_hydrophobic_polar
    type:
      - 'null'
      - boolean
    doc: do not choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 103
      prefix: --no-hp, --no-hydrophobic-polar
  - id: no_linear
    type:
      - 'null'
      - boolean
    inputBinding:
      position: 103
      prefix: --no-linear
  - id: no_nucleotide
    type:
      - 'null'
      - boolean
    doc: do not choose a nucleotide signature
    inputBinding:
      position: 103
      prefix: --no-dna, --no-rna, --no-nucleotide
  - id: no_prefetch
    type:
      - 'null'
      - boolean
    doc: do not use prefetch before gather; see documentation
    inputBinding:
      position: 103
      prefix: --no-prefetch
  - id: no_protein
    type:
      - 'null'
      - boolean
    doc: do not choose a protein signature
    inputBinding:
      position: 103
      prefix: --no-protein
  - id: no_skipmer_m1n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m1n3) signatures
    inputBinding:
      position: 103
      prefix: --no-skipm1n3, --no-skipmer-m1n3
  - id: no_skipmer_m2n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m2n3) signatures
    inputBinding:
      position: 103
      prefix: --no-skipm2n3, --no-skipmer-m2n3
  - id: nucleotide
    type:
      - 'null'
      - boolean
    doc: 'choose a nucleotide signature (default: True)'
    inputBinding:
      position: 103
      prefix: --dna, --rna, --nucleotide
  - id: num_results
    type:
      - 'null'
      - int
    doc: 'number of results to report (default: terminate at --threshold-bp)'
    inputBinding:
      position: 103
      prefix: --num-results
  - id: output_unassigned
    type:
      - 'null'
      - File
    doc: output unassigned portions of the query as a signature to the specified
      file
    inputBinding:
      position: 103
      prefix: --output-unassigned
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
  - id: prefetch
    type:
      - 'null'
      - boolean
    doc: use prefetch before gather; see documentation
    inputBinding:
      position: 103
      prefix: --prefetch
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
  - id: save_matches
    type:
      - 'null'
      - File
    doc: save gather matched signatures from the database to the specified file
    inputBinding:
      position: 103
      prefix: --save-matches
  - id: save_prefetch
    type:
      - 'null'
      - File
    doc: save all prefetch-matched signatures from the databases to the 
      specified file or directory
    inputBinding:
      position: 103
      prefix: --save-prefetch
  - id: save_prefetch_csv
    type:
      - 'null'
      - File
    doc: save a csv with information from all prefetch-matched signatures to the
      specified file
    inputBinding:
      position: 103
      prefix: --save-prefetch-csv
  - id: scaled
    type:
      - 'null'
      - float
    doc: downsample to this scaled; value should be between 100 and 1e6
    inputBinding:
      position: 103
      prefix: --scaled
  - id: skipmer_m1n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m1n3) signatures
    inputBinding:
      position: 103
      prefix: --skipmer-m1n3
  - id: skipmer_m2n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m2n3) signatures
    inputBinding:
      position: 103
      prefix: --skipmer-m2n3
  - id: threshold_bp
    type:
      - 'null'
      - float
    doc: reporting threshold (in bp) for estimated overlap with remaining query 
      (default=50kb)
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
