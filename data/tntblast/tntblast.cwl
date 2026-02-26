cwlVersion: v1.2
class: CommandLineTool
baseCommand: tntblast
label: tntblast
doc: "A tool for simulating PCR and DNA hybridization using thermodynamic parameters
  to predict melting temperatures and binding affinities.\n\nTool homepage: https://github.com/jgans/thermonucleotideBLAST"
inputs:
  - id: database_file
    type:
      - 'null'
      - File
    doc: Database file to search against (FASTA format)
    inputBinding:
      position: 101
      prefix: -d
  - id: forward_primer
    type:
      - 'null'
      - string
    doc: Forward primer sequence
    inputBinding:
      position: 101
      prefix: -f
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file containing sequences or primers
    inputBinding:
      position: 101
      prefix: -i
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches allowed
    inputBinding:
      position: 101
      prefix: -m
  - id: min_tm
    type:
      - 'null'
      - float
    doc: Minimum melting temperature (Tm) for a match
    inputBinding:
      position: 101
      prefix: -e
  - id: reverse_primer
    type:
      - 'null'
      - string
    doc: Reverse primer sequence
    inputBinding:
      position: 101
      prefix: -r
  - id: salt_concentration
    type:
      - 'null'
      - float
    doc: Salt concentration in Molar (M)
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for computation
    default: 20
    inputBinding:
      position: 101
      prefix: -T
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: File to write the results to
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tntblast:2.66--h6b557da_0
