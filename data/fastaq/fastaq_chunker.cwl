cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq_chunker
label: fastaq_chunker
doc: "Splits a multi sequence file into separate files. Splits sequences into chunks
  of a fixed size. Aims for chunk_size chunks in each file, but allows a little extra,
  so chunk can be up to (chunk_size + tolerance), to prevent tiny chunks made from
  the ends of sequences\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file to be split
    inputBinding:
      position: 1
  - id: out
    type: string
    doc: Prefix of output file. If --onefile used, then name of single output 
      file
    inputBinding:
      position: 2
  - id: chunk_size
    type: int
    doc: Size of each chunk
    inputBinding:
      position: 3
  - id: tolerance
    type: int
    doc: Tolerance allowed in chunk size
    inputBinding:
      position: 4
  - id: onefile
    type:
      - 'null'
      - boolean
    doc: Output all the sequences in one file
    inputBinding:
      position: 105
      prefix: --onefile
  - id: skip_all_ns
    type:
      - 'null'
      - boolean
    doc: Do not output any sequence that consists of all Ns
    inputBinding:
      position: 105
      prefix: --skip_all_Ns
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
stdout: fastaq_chunker.out
