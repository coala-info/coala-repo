cwlVersion: v1.2
class: CommandLineTool
baseCommand: grapetree
label: grapetree
doc: "GrapeTree generates a NEWICK tree to the default output (screen) or a redirect
  output, e.g., a file.\n\nTool homepage: https://github.com/achtman-lab/GrapeTree"
inputs:
  - id: block_penalty
    type:
      - 'null'
      - float
    doc: The penalty given to a different locus if it is led by another 
      difference. Only works for "-x blockwise".
    inputBinding:
      position: 101
      prefix: --block_penalty
  - id: check
    type:
      - 'null'
      - boolean
    doc: Only calculate the expected time/memory requirements.
    inputBinding:
      position: 101
      prefix: --check
  - id: heuristic
    type:
      - 'null'
      - string
    doc: 'Tiebreak heuristic for MSTree and MSTreeV2. Options: "eBurst", "harmonic".'
    inputBinding:
      position: 101
      prefix: --heuristic
  - id: matrix_type
    type:
      - 'null'
      - string
    doc: 'Type of distance matrix. Options: "symmetric", "asymmetric", "blockwise".'
    inputBinding:
      position: 101
      prefix: --matrix
  - id: method
    type:
      - 'null'
      - string
    doc: 'Method for tree generation. Options: "MSTreeV2", "MSTree", "NJ", "RapidNJ",
      "ninja", "distance".'
    inputBinding:
      position: 101
      prefix: --method
  - id: missing_handler
    type:
      - 'null'
      - string
    doc: 'Handler for missing data in pairwise comparison. Options: 0 (ignore), 1
      (remove column), 2 (treat as allele), 3 (absolute number of allelic differences).'
    inputBinding:
      position: 101
      prefix: --missing
  - id: n_proc
    type:
      - 'null'
      - int
    doc: Number of CPU processes in parallel use.
    inputBinding:
      position: 101
      prefix: --n_proc
  - id: profile
    type: File
    doc: An input filename of a file containing MLST or SNP character data, OR a
      fasta file containing aligned sequences.
    inputBinding:
      position: 101
      prefix: --profile
  - id: recraft
    type:
      - 'null'
      - boolean
    doc: Triggers local branch recrafting.
    inputBinding:
      position: 101
      prefix: --recraft
  - id: wgmlst
    type:
      - 'null'
      - boolean
    doc: Enables better support of wgMLST schemes.
    inputBinding:
      position: 101
      prefix: --wgMLST
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grapetree:2.1--pyh3252c3a_0
stdout: grapetree.out
