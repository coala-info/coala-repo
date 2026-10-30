cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastaq
  - sequence_trim
label: pyfastaq_fastaq_sequence_trim
doc: "Trims sequences off the start of all sequences in a pair of sequence files, whenever there is a perfect match. Only keeps a read pair if both reads of the pair are at least a minimum length after any trimming\n\nTool homepage: https://github.com/sanger-pathogens/Fastaq"
inputs:
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Minimum length of output sequences [50]"
    inputBinding:
      position: 1
      prefix: --min_length
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: "Trim the end of each sequence if it matches the reverse complement. This option is intended for PCR primer trimming"
    inputBinding:
      position: 2
      prefix: --revcomp
  - id: infile_1
    type: File
    doc: "Name of forward fasta/q file to be trimmed"
    inputBinding:
      position: 20
  - id: infile_2
    type: File
    doc: "Name of reverse fasta/q file to be trimmed"
    inputBinding:
      position: 21
  - id: outfile_1
    type: string
    doc: "Name of output forward fasta/q file"
    inputBinding:
      position: 22
  - id: outfile_2
    type: string
    doc: "Name of output reverse fasta/q file"
    inputBinding:
      position: 23
  - id: trim_seqs
    type: File
    doc: "Name of file of sequences to search for at the start of each input sequence"
    inputBinding:
      position: 24
outputs:
  - id: output_forward
    type: File
    doc: "Name of output forward fasta/q file"
    outputBinding:
      glob: $(inputs.outfile_1)
  - id: output_reverse
    type: File
    doc: "Name of output reverse fasta/q file"
    outputBinding:
      glob: $(inputs.outfile_2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastaq:3.18.0--pyhdfd78af_0
