cwlVersion: v1.2
class: CommandLineTool
baseCommand: phast_phastmotif
label: phast_phastmotif
doc: "PHAST package program for finding motifs.\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: input_file
    type: File
    doc: Input file for phastMotif
    inputBinding:
      position: 1
  - id: background_model
    type:
      - 'null'
      - string
    doc: Background model to use (e.g., 'uniform', 'gc', 'empirical')
    inputBinding:
      position: 102
      prefix: --background-model
  - id: max_motifs
    type:
      - 'null'
      - int
    doc: Maximum number of motifs to report
    inputBinding:
      position: 102
      prefix: --max-motifs
  - id: min_score
    type:
      - 'null'
      - float
    doc: Minimum score for a motif to be reported
    inputBinding:
      position: 102
      prefix: --min-score
  - id: motif_length
    type:
      - 'null'
      - int
    doc: Length of motifs to search for
    inputBinding:
      position: 102
      prefix: --motif-length
  - id: pseudocounts
    type:
      - 'null'
      - float
    doc: Pseudocounts to add to motif counts
    inputBinding:
      position: 102
      prefix: --pseudocounts
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for motifs
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
