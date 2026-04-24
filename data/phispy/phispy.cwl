cwlVersion: v1.2
class: CommandLineTool
baseCommand: phispy
label: phispy
doc: "PhiSpy is a tool for identifying prophages in bacterial genomes. It combines
  similarity searches and several statistical characteristics of prophage regions
  to identify prophages.\n\nTool homepage: https://github.com/linsalrob/PhiSpy"
inputs:
  - id: infile
    type: File
    doc: The input file in GenBank format or a directory containing the GenBank 
      file.
    inputBinding:
      position: 1
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep intermediate files.
    inputBinding:
      position: 102
      prefix: --keep
  - id: min_length
    type:
      - 'null'
      - int
    doc: The minimum length of a prophage region in base pairs.
    inputBinding:
      position: 102
      prefix: --min_length
  - id: non_prophage_gene_window
    type:
      - 'null'
      - int
    doc: The number of non-prophage genes to allow in a prophage region.
    inputBinding:
      position: 102
      prefix: --non_prophage_gene_window
  - id: number
    type:
      - 'null'
      - int
    doc: The number of consecutive genes to be considered a prophage.
    inputBinding:
      position: 102
      prefix: --number
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Run in quiet mode (no output to screen).
    inputBinding:
      position: 102
      prefix: --quiet
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 102
      prefix: --threads
  - id: training_set
    type:
      - 'null'
      - File
    doc: A training set file to use for the predictions.
    inputBinding:
      position: 102
      prefix: --training_set
  - id: window_size
    type:
      - 'null'
      - int
    doc: The window size to use for the sliding window.
    inputBinding:
      position: 102
      prefix: --window_size
outputs:
  - id: output_dir
    type: Directory
    doc: The directory to write the results to.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phispy:4.2.21--py39h2de1943_8
