cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sourmash
  - search
label: sourmash_search
doc: "Searches a collection of signatures or SBTs for matches to the query signature.
  It can search for matches with either high Jaccard similarity or containment; the
  default is to use Jaccard similarity, unless --containment is specified. -o/--output
  will create a CSV file containing the matches.\n\nTool homepage: https://github.com/sourmash-bio/sourmash"
inputs:
  - id: query
    type: File
    doc: query signature
    inputBinding:
      position: 1
  - id: databases
    type:
      type: array
      items: File
    doc: signatures/SBTs to search
    inputBinding:
      position: 2
  - id: best_only
    type:
      - 'null'
      - boolean
    doc: report only the best match (with greater speed)
    inputBinding:
      position: 103
      prefix: --best-only
  - id: containment
    type:
      - 'null'
      - boolean
    doc: score based on containment rather than similarity
    inputBinding:
      position: 103
      prefix: --containment
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
    doc: output debug information
    inputBinding:
      position: 103
      prefix: --debug
  - id: estimate_ani_ci
    type:
      - 'null'
      - boolean
    doc: for containment searches, also output confidence intervals for ANI 
      estimates
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
    doc: 'do NOT use k-mer abundances if present; note: has no effect if --containment
      or --max-containment is specified'
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
  - id: max_containment
    type:
      - 'null'
      - boolean
    doc: score based on max containment rather than similarity
    inputBinding:
      position: 103
      prefix: --max-containment
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
      prefix: --no-hydrophobic-polar
  - id: no_nucleotide
    type:
      - 'null'
      - boolean
    doc: do not choose a nucleotide signature
    inputBinding:
      position: 103
      prefix: --no-nucleotide
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
      prefix: --no-skipmer-m1n3
  - id: no_skipmer_m2n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m2n3) signatures
    inputBinding:
      position: 103
      prefix: --no-skipmer-m2n3
  - id: nucleotide
    type:
      - 'null'
      - boolean
    doc: 'choose a nucleotide signature (default: True)'
    default: true
    inputBinding:
      position: 103
      prefix: --nucleotide
  - id: num_results
    type:
      - 'null'
      - int
    doc: number of results to display to user; 0 to report all
    inputBinding:
      position: 103
      prefix: --num-results
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
  - id: threshold
    type:
      - 'null'
      - float
    doc: minimum threshold for reporting matches
    default: 0.08
    inputBinding:
      position: 103
      prefix: --threshold
outputs:
  - id: save_matches
    type:
      - 'null'
      - File
    doc: output matching signatures to the specified file
    outputBinding:
      glob: $(inputs.save_matches)
  - id: output
    type:
      - 'null'
      - File
    doc: output CSV containing matches to this file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
