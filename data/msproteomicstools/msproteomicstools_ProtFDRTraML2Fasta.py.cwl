cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ProtFDRTraML2Fasta.py
label: msproteomicstools_ProtFDRTraML2Fasta.py
doc: "Convert a TSV that was converted from a TraML file into a FASTA file with the peptides of each protein concatenated.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: input_tsv
    type: File
    doc: "TSV converted from a TraML file"
    inputBinding:
      position: 1
  - id: output_path
    type: string
    doc: "Output FASTA file"
    inputBinding:
      position: 2
outputs:
  - id: output
    type: File
    doc: "FASTA file"
    outputBinding:
      glob: "$(inputs.output_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
