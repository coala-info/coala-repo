cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - chunker
label: pyfastaq_fastaq_chunker
doc: "Splits a multi sequence file into separate files. Splits sequences into chunks of a fixed size. Aims for chunk_size chunks in each file, but allows a little extra, so chunk can be up to (chunk_size + tolerance), to prevent tiny chunks made from the ends of sequences\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: onefile
    type:
      - 'null'
      - boolean
    doc: "Output all the sequences in one file"
    inputBinding:
      position: 1
      prefix: --onefile
  - id: skip_all_Ns
    type:
      - 'null'
      - boolean
    doc: "Do not output any sequence that consists of all Ns"
    inputBinding:
      position: 2
      prefix: --skip_all_Ns
  - id: infile
    type: File
    doc: "Name of input file to be split"
    inputBinding:
      position: 20
  - id: out
    type: string
    doc: "Prefix of output file. If --onefile used, then name of single output file"
    inputBinding:
      position: 21
  - id: chunk_size
    type: int
    doc: "Size of each chunk"
    inputBinding:
      position: 22
  - id: tolerance
    type: int
    doc: "Tolerance allowed in chunk size"
    inputBinding:
      position: 23
outputs:
  - id: chunks
    type:
      type: array
      items: File
    doc: Output chunk files (prefix.1, prefix.2, ... and prefix.coords), or the single output file with --onefile.
    outputBinding:
      glob: $(inputs.out)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
