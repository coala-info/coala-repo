cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - split_by_base_count
label: pyfastaq_fastaq_split_by_base_count
doc: "Splits a multi sequence file into separate files. Does not split sequences. Puts up to max_bases into each split file. The exception is that any sequence longer than max_bases is put into its own file.\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: max_seqs
    type:
      - 'null'
      - int
    doc: "Max number of sequences in each output split file [no limit]"
    inputBinding:
      position: 1
      prefix: --max_seqs
  - id: infile
    type: File
    doc: "Name of input file to be split"
    inputBinding:
      position: 20
  - id: outprefix
    type: string
    doc: "Name of output file"
    inputBinding:
      position: 21
  - id: max_bases
    type: int
    doc: "Max bases in each output split file"
    inputBinding:
      position: 22
outputs:
  - id: split_files
    type:
      type: array
      items: File
    doc: Output split files (prefix.1, prefix.2, ...).
    outputBinding:
      glob: $(inputs.outprefix).*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
