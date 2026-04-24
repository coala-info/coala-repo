cwlVersion: v1.2
class: CommandLineTool
baseCommand: serotypefinder
label: serotypefinder
doc: "SerotypeFinder identifies serotypes in total or partial genome sequences of
  E. coli.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/serotypefinder"
inputs:
  - id: database_path
    type:
      - 'null'
      - Directory
    doc: Path to the SerotypeFinder database.
    inputBinding:
      position: 101
      prefix: --db_path
  - id: ext_db_path
    type:
      - 'null'
      - string
    doc: Specific databases to search (e.g., 'o_antigen,h_antigen').
    inputBinding:
      position: 101
      prefix: --databases
  - id: input_file
    type:
      type: array
      items: File
    doc: Input file (FASTA or FASTQ). Multiple files can be provided.
    inputBinding:
      position: 101
      prefix: --inputfile
  - id: kmer_threshold
    type:
      - 'null'
      - float
    doc: Threshold for k-mer based identification.
    inputBinding:
      position: 101
      prefix: --kmer_threshold
  - id: min_length
    type:
      - 'null'
      - float
    doc: Minimum coverage (0.00-1.00).
    inputBinding:
      position: 101
      prefix: --mincov
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Disable output to stdout.
    inputBinding:
      position: 101
      prefix: --quiet
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for identity (0.00-1.00).
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output_directory
    type: Directory
    doc: Directory to save the output files.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/serotypefinder:2.0.2--py312hdfd78af_1
