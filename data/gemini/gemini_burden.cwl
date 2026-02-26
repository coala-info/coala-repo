cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini_burden
label: gemini_burden
doc: "Calculate burden statistics for variants in a GEMINI database.\n\nTool homepage:
  https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried.
    inputBinding:
      position: 1
  - id: calpha
    type:
      - 'null'
      - boolean
    doc: Run the C-alpha association test.
    inputBinding:
      position: 102
      prefix: --calpha
  - id: cases
    type:
      - 'null'
      - type: array
        items: string
    doc: Space separated list of cases for association testing.
    inputBinding:
      position: 102
      prefix: --cases
  - id: controls
    type:
      - 'null'
      - type: array
        items: string
    doc: Space separated list of controls for association testing.
    inputBinding:
      position: 102
      prefix: --controls
  - id: max_aaf
    type:
      - 'null'
      - float
    doc: The max. alt. allele frequency for a variant to be included.
    inputBinding:
      position: 102
      prefix: --max-aaf
  - id: min_aaf
    type:
      - 'null'
      - float
    doc: The min. alt. allele frequency for a variant to be included.
    inputBinding:
      position: 102
      prefix: --min-aaf
  - id: nonsynonymous
    type:
      - 'null'
      - boolean
    doc: Count all nonsynonymous variants as contributing burden.
    inputBinding:
      position: 102
      prefix: --nonsynonymous
  - id: permutations
    type:
      - 'null'
      - int
    doc: Number of permutations to run for the C-alpha test (try 1000 to start).
    inputBinding:
      position: 102
      prefix: --permutations
  - id: save_tscores
    type:
      - 'null'
      - boolean
    doc: Save the permuted T-scores to a file.
    inputBinding:
      position: 102
      prefix: --save_tscores
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_burden.out
