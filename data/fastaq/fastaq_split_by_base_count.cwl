cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaq split_by_base_count
label: fastaq_split_by_base_count
doc: "Splits a multi sequence file into separate files. Does not split sequences.\n\
  Puts up to max_bases into each split file. The exception is that any sequence\n\
  longer than max_bases is put into its own file.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: infile
    type: File
    doc: Name of input file to be split
    inputBinding:
      position: 1
  - id: outprefix
    type: string
    doc: Name of output file
    inputBinding:
      position: 2
  - id: max_bases
    type: int
    doc: Max bases in each output split file
    inputBinding:
      position: 3
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: Max number of sequences in each output split file
    inputBinding:
      position: 104
      prefix: --max_seqs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fastaq:v3.17.0-2-deb_cv1
stdout: fastaq_split_by_base_count.out
