cwlVersion: v1.2
class: CommandLineTool
baseCommand: phast_pbsencode
label: phast_pbsencode
doc: "Encodes a position-specific scoring matrix (PSSM) into a PSSM that is suitable
  for use with phastCons.\n\nTool homepage: http://compgen.cshl.edu/phast/"
inputs:
  - id: input_pssm
    type: File
    doc: Input PSSM file
    inputBinding:
      position: 1
  - id: alphabet
    type:
      - 'null'
      - string
    doc: 'Alphabet of the PSSM (DNA, RNA, or PROTEIN). Default: DNA.'
    inputBinding:
      position: 102
      prefix: --alphabet
  - id: background
    type:
      - 'null'
      - string
    doc: Background frequencies for each base in the alphabet. For DNA, this can
      be a string of four numbers (e.g., "0.25 0.25 0.25 0.25") or a predefined 
      string like "equimolar" or "human".
    inputBinding:
      position: 102
      prefix: --background
  - id: pseudo_count
    type:
      - 'null'
      - float
    doc: 'Pseudo-count to add to each entry in the PSSM. Default: 0.01.'
    inputBinding:
      position: 102
      prefix: --pseudo-count
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_pssm
    type: File
    doc: Output PSSM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phast:1.9.7--h7eac25e_0
