cwlVersion: v1.2
class: CommandLineTool
baseCommand: SequenceSelector
label: rdp-readseq_select-seqs
doc: Selects sequences from input files based on a list of IDs.
inputs:
  - id: ids_file
    type: File
    doc: File containing sequence IDs to select.
    inputBinding:
      position: 1
  - id: outputformat
    type: string
    doc: Output format (fasta or fastq).
    inputBinding:
      position: 2
  - id: keep
    type: boolean
    doc: Keep sequences in ids_file (Y/N). If false or N, sequences will be 
      removed.
    inputBinding:
      position: 3
  - id: seqfile
    type:
      type: array
      items: File
    doc: Input sequence file(s) (fasta or fastq).
    inputBinding:
      position: 4
outputs:
  - id: outfile
    type: File
    doc: Output file name.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
