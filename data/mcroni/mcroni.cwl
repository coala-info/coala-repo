cwlVersion: v1.2
class: CommandLineTool
baseCommand: mcroni
label: mcroni
doc: "Analyse the local genomic context of mcr-1.\n\nTool homepage: https://github.com/liampshaw/mcroni"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.fasta_files || [])
      - $(inputs.fasta)
inputs:
  - id: append
    type:
      - 'null'
      - boolean
    doc: Append to existing output files.
    inputBinding:
      position: 101
      prefix: --append
  - id: fasta
    type:
      - 'null'
      - File
    doc: Fasta file (staged in the working directory, because mcroni builds a BLAST database beside it)
    inputBinding:
      position: 101
      prefix: --fasta
      valueFrom: $(self.basename)
  - id: filelist
    type:
      - 'null'
      - File
    doc: 'Alternatively: a list of fasta files'
    inputBinding:
      position: 101
      prefix: --filelist
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: The fasta files named in filelist, staged in the working directory so the names in the list resolve.
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwriting of output files.
    inputBinding:
      position: 101
      prefix: --force
  - id: output
    type: string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --output
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output
    outputBinding:
      glob: $(inputs.output)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mcroni:1.0.4--pyh5e36f6f_0
stdout: mcroni.out
