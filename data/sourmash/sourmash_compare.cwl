cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sourmash
  - compare
label: sourmash_compare
doc: "Compares one or more signatures (created with `sketch`) using estimated Jaccard
  index [1] or (if signatures are created with `-p abund`) the angular similarity
  [2]).\n\nTool homepage: https://github.com/sourmash-bio/sourmash"
inputs:
  - id: signatures
    type:
      type: array
      items: File
    doc: list of signatures to compare
    inputBinding:
      position: 1
  - id: ANI
    type:
      - 'null'
      - boolean
    doc: return ANI estimated from jaccard, containment, average containment, or
      max containment; see https://doi.org/10.1101/2022.01.11.475870
    inputBinding:
      position: 102
      prefix: --ANI
  - id: ani
    type:
      - 'null'
      - boolean
    doc: return ANI estimated from jaccard, containment, average containment, or
      max containment; see https://doi.org/10.1101/2022.01.11.475870
    inputBinding:
      position: 102
      prefix: --ani
  - id: average_containment
    type:
      - 'null'
      - boolean
    doc: calculate average containment instead of similarity
    inputBinding:
      position: 102
      prefix: --average-containment
  - id: avg_containment
    type:
      - 'null'
      - boolean
    doc: calculate average containment instead of similarity
    inputBinding:
      position: 102
      prefix: --avg-containment
  - id: containment
    type:
      - 'null'
      - boolean
    doc: calculate containment instead of similarity
    inputBinding:
      position: 102
      prefix: --containment
  - id: dayhoff
    type:
      - 'null'
      - boolean
    doc: choose Dayhoff-encoded amino acid signatures
    inputBinding:
      position: 102
      prefix: --dayhoff
  - id: distance_matrix
    type:
      - 'null'
      - boolean
    doc: output a distance matrix, instead of a similarity matrix
    inputBinding:
      position: 102
      prefix: --distance-matrix
  - id: dna
    type:
      - 'null'
      - boolean
    doc: 'choose a nucleotide signature (default: True)'
    inputBinding:
      position: 102
      prefix: --dna
  - id: estimate_ani
    type:
      - 'null'
      - boolean
    doc: return ANI estimated from jaccard, containment, average containment, or
      max containment; see https://doi.org/10.1101/2022.01.11.475870
    inputBinding:
      position: 102
      prefix: --estimate-ani
  - id: exclude_db_pattern
    type:
      - 'null'
      - string
    doc: search only signatures that do not match this pattern in name, 
      filename, or md5
    inputBinding:
      position: 102
      prefix: --exclude-db-pattern
  - id: force
    type:
      - 'null'
      - boolean
    doc: continue past errors in file loading
    inputBinding:
      position: 102
      prefix: --force
  - id: from_file
    type:
      - 'null'
      - File
    doc: a text file containing a list of files to load signatures from
    inputBinding:
      position: 102
      prefix: --from-file
  - id: hp
    type:
      - 'null'
      - boolean
    doc: choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 102
      prefix: --hp
  - id: hydrophobic_polar
    type:
      - 'null'
      - boolean
    doc: choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 102
      prefix: --hydrophobic-polar
  - id: ignore_abundance
    type:
      - 'null'
      - boolean
    doc: do NOT use k-mer abundances even if present
    inputBinding:
      position: 102
      prefix: --ignore-abundance
  - id: include_db_pattern
    type:
      - 'null'
      - string
    doc: search only signatures that match this pattern in name, filename, or 
      md5
    inputBinding:
      position: 102
      prefix: --include-db-pattern
  - id: ksize
    type:
      - 'null'
      - int
    doc: k-mer size to select; no default.
    inputBinding:
      position: 102
      prefix: --ksize
  - id: labels_save
    type:
      - 'null'
      - File
    doc: a CSV file containing label information
    inputBinding:
      position: 102
      prefix: --labels-save
  - id: labels_to
    type:
      - 'null'
      - File
    doc: a CSV file containing label information
    inputBinding:
      position: 102
      prefix: --labels-to
  - id: max_containment
    type:
      - 'null'
      - boolean
    doc: calculate max containment instead of similarity
    inputBinding:
      position: 102
      prefix: --max-containment
  - id: no_dayhoff
    type:
      - 'null'
      - boolean
    doc: do not choose Dayhoff-encoded amino acid signatures
    inputBinding:
      position: 102
      prefix: --no-dayhoff
  - id: no_dna
    type:
      - 'null'
      - boolean
    doc: do not choose a nucleotide signature
    inputBinding:
      position: 102
      prefix: --no-dna
  - id: no_hp
    type:
      - 'null'
      - boolean
    doc: do not choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 102
      prefix: --no-hp
  - id: no_hydrophobic_polar
    type:
      - 'null'
      - boolean
    doc: do not choose hydrophobic-polar-encoded amino acid signatures
    inputBinding:
      position: 102
      prefix: --no-hydrophobic-polar
  - id: no_nucleotide
    type:
      - 'null'
      - boolean
    doc: do not choose a nucleotide signature
    inputBinding:
      position: 102
      prefix: --no-nucleotide
  - id: no_protein
    type:
      - 'null'
      - boolean
    doc: do not choose a protein signature
    inputBinding:
      position: 102
      prefix: --no-protein
  - id: no_rna
    type:
      - 'null'
      - boolean
    doc: do not choose a nucleotide signature
    inputBinding:
      position: 102
      prefix: --no-rna
  - id: no_skipm1n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m1n3) signatures
    inputBinding:
      position: 102
      prefix: --no-skipm1n3
  - id: no_skipm2n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m2n3) signatures
    inputBinding:
      position: 102
      prefix: --no-skipm2n3
  - id: no_skipmer_m1n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m1n3) signatures
    inputBinding:
      position: 102
      prefix: --no-skipmer-m1n3
  - id: no_skipmer_m2n3
    type:
      - 'null'
      - boolean
    doc: do not choose skipmer (m2n3) signatures
    inputBinding:
      position: 102
      prefix: --no-skipmer-m2n3
  - id: nucleotide
    type:
      - 'null'
      - boolean
    doc: 'choose a nucleotide signature (default: True)'
    inputBinding:
      position: 102
      prefix: --nucleotide
  - id: picklist
    type:
      - 'null'
      - string
    doc: select signatures based on a picklist, i.e. 'file.csv:colname:coltype'
    inputBinding:
      position: 102
      prefix: --picklist
  - id: picklist_require_all
    type:
      - 'null'
      - boolean
    doc: require that all picklist values be found or else fail
    inputBinding:
      position: 102
      prefix: --picklist-require-all
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes to use to calculate similarity
    inputBinding:
      position: 102
      prefix: --processes
  - id: protein
    type:
      - 'null'
      - boolean
    doc: choose a protein signature; by default, a nucleotide signature is used
    inputBinding:
      position: 102
      prefix: --protein
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress non-error output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: rna
    type:
      - 'null'
      - boolean
    doc: 'choose a nucleotide signature (default: True)'
    inputBinding:
      position: 102
      prefix: --rna
  - id: scaled
    type:
      - 'null'
      - float
    doc: downsample to this scaled; value should be between 100 and 1e6
    inputBinding:
      position: 102
      prefix: --scaled
  - id: similarity_matrix
    type:
      - 'null'
      - boolean
    doc: output a similarity matrix; this is the default
    inputBinding:
      position: 102
      prefix: --similarity-matrix
  - id: skipm1n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m1n3) signatures
    inputBinding:
      position: 102
      prefix: --skipm1n3
  - id: skipm2n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m2n3) signatures
    inputBinding:
      position: 102
      prefix: --skipm2n3
  - id: skipmer_m1n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m1n3) signatures
    inputBinding:
      position: 102
      prefix: --skipmer-m1n3
  - id: skipmer_m2n3
    type:
      - 'null'
      - boolean
    doc: choose skipmer (m2n3) signatures
    inputBinding:
      position: 102
      prefix: --skipmer-m2n3
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: file to which output will be written; default is terminal (standard 
      output)
    outputBinding:
      glob: $(inputs.output)
  - id: csv
    type:
      - 'null'
      - File
    doc: write matrix to specified file in CSV format (with column headers)
    outputBinding:
      glob: $(inputs.csv)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
