cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - copy_accesion.py
label: msproteomicstools_copy_accesion.py
doc: "Swap the two accession codes of every protein in a FASTA file; the result is written to the input file name plus '.new'.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: fasta_file
    type: File
    doc: "FASTA file (a new file with suffix .new is written)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  - id: output
    type: File
    doc: "FASTA file with swapped accession codes"
    outputBinding:
      glob: "$(inputs.fasta_file.basename).new"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_file)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
