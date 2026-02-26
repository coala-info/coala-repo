cwlVersion: v1.2
class: CommandLineTool
baseCommand: migrate-n
label: migrate-n
doc: "MIGRATION RATE AND POPULATION SIZE ESTIMATION using Markov Chain Monte Carlo
  simulation\n\nTool homepage: http://popgen.sc.fsu.edu/Migrate/Migrate-n.html"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input filename for reading
    inputBinding:
      position: 1
  - id: data_type
    type:
      - 'null'
      - string
    doc: 'Data type currently set to: DNA sequence model'
    inputBinding:
      position: 102
      prefix: D
  - id: input_output_formats
    type:
      - 'null'
      - string
    doc: Input/Output formats
    inputBinding:
      position: 102
      prefix: I
  - id: parameters
    type:
      - 'null'
      - string
    doc: Parameters [start, migration model]
    inputBinding:
      position: 102
      prefix: P
  - id: pdf_output
    type:
      - 'null'
      - boolean
    doc: PDF output enabled [Letter-size]
    inputBinding:
      position: 102
  - id: quit
    type:
      - 'null'
      - string
    doc: Quit the program
    inputBinding:
      position: 102
      prefix: Q
  - id: search_strategy
    type:
      - 'null'
      - string
    doc: Search strategy
    inputBinding:
      position: 102
      prefix: S
  - id: start_program
    type:
      - 'null'
      - boolean
    doc: Start the program with typing Yes or Y
    inputBinding:
      position: 102
  - id: write_parmfile
    type:
      - 'null'
      - string
    doc: Write a parmfile
    inputBinding:
      position: 102
      prefix: W
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/migrate-n:3.6.11--haf0c795_7
stdout: migrate-n.out
