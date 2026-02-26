cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaptamer_count
label: fastaptamer_fastaptamer_count
doc: "FASTAptamer-Count serves as the gateway to the FASTAptamer toolkit. For a given
  .FASTQ input file (or FASTA input file if the -f flag is used), FASTAptamer-Count
  will determine the number of times each sequence was read, rank and sort sequences
  by decreasing total reads, and normalize sequence frequency to reads per million.\n\
  \nTool homepage: http://burkelab.missouri.edu/fastaptamer.html"
inputs:
  - id: fasta_format
    type:
      - 'null'
      - boolean
    doc: input file is in FASTA format (otherwise it must be FASTQ)
    inputBinding:
      position: 101
      prefix: -f
  - id: input_file
    type: File
    doc: input file. REQUIRED (FASTQ unless -f specified).
    inputBinding:
      position: 101
      prefix: -i
  - id: suppress_report
    type:
      - 'null'
      - boolean
    doc: Suppress STDOUT of run report.
    inputBinding:
      position: 101
      prefix: -q
  - id: unique_ids
    type:
      - 'null'
      - boolean
    doc: Create unique sequence ID's
    inputBinding:
      position: 101
      prefix: -u
outputs:
  - id: output_file
    type: File
    doc: FASTA output file. REQUIRED.
    outputBinding:
      glob: $(inputs.output_file)
  - id: csv_output
    type:
      - 'null'
      - File
    doc: output CSV format (to file CSV_OUT)
    outputBinding:
      glob: $(inputs.csv_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
