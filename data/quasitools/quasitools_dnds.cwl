cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - quasitools
  - dnds
label: quasitools_dnds
doc: "Calculate the dn/ds value for each region in a bed file.\n\nTool homepage: https://github.com/phac-nml/quasitools/"
inputs:
  - id: csv_file
    type: File
    doc: CSV file of codon variants (output of quasitools call codonvar).
    inputBinding:
      position: 1
  - id: reference_file
    type: File
    doc: Reference genome FASTA file.
    inputBinding:
      position: 2
  - id: offset
    type: int
    doc: Offset of the gene region in the reference.
    inputBinding:
      position: 3
  - id: output_filename_path
    type:
      - 'null'
      - string
    doc: Output file (CSV).
    inputBinding:
      position: 101
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output file (CSV).
    outputBinding:
      glob: $(inputs.output_filename_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasitools:0.7.0--py_0
stdout: quasitools_dnds.out
