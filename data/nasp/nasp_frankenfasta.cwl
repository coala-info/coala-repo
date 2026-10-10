cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nasp, frankenfasta]
label: nasp_frankenfasta
doc: "Create a FASTA that is 1-to-1 position aligned with a reference FASTA by combining a sample FASTA with a nucmer alignment delta file.\n\nTool homepage: https://github.com/TGenNorth/NASP"
inputs:
  - id: mummer_deltas
    type:
      type: array
      items: File
    doc: "Delta-filtered nucmer delta file(s) of reference against sample. The FASTA files named inside the delta must be readable at those paths."
    inputBinding:
      position: 101
  - id: sequence_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "FASTA files named in the delta header; staged in the working directory (/data in the container)."
outputs:
  - id: output
    type: stdout
    doc: "Frankenfasta, written to standard output."
stdout: nasp_frankenfasta.fasta
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.sequence_files ? inputs.sequence_files : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
    dockerOutputDirectory: /data
