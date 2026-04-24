cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quasitools
  - dnds
label: quasitools_dnds
doc: "Calculate dN/dS ratios for coding sequences.\n\nTool homepage: https://github.com/phac-nml/quasitools/"
inputs:
  - id: csv_file
    type: File
    doc: CSV file containing gene information.
    inputBinding:
      position: 1
  - id: reference_file
    type: File
    doc: Reference genome FASTA file.
    inputBinding:
      position: 2
  - id: offset
    type: int
    doc: Offset for gene coordinates.
    inputBinding:
      position: 3
  - id: codon_table
    type:
      - 'null'
      - string
    doc: Codon table to use (e.g., standard, vertebrate_mito).
    inputBinding:
      position: 104
      prefix: --codon-table
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum coding sequence length to consider.
    inputBinding:
      position: 104
      prefix: --min-length
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save output files.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
