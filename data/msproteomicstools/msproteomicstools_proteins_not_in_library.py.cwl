cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - proteins_not_in_library.py
label: msproteomicstools_proteins_not_in_library.py
doc: "Display which proteins of a FASTA file are not present in a library csv (column ProteinName); entries starting with DECOY and sp| are ignored.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: fasta_file
    type: File
    doc: "A fasta file"
    inputBinding:
      prefix: --fasta
  - id: csv_file
    type: File
    doc: "A csv file with the column ProteinName"
    inputBinding:
      prefix: --in
  - id: output_path
    type: string
    doc: "A csv output file containing all proteins not in the csv file"
    inputBinding:
      prefix: --out
outputs:
  - id: output
    type: File
    doc: "Proteins not in the library"
    outputBinding:
      glob: "$(inputs.output_path)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
stdout: msproteomicstools_proteins_not_in_library.py.out
