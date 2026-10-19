cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdp-readseq
  - select-seqs
label: rdp-readseq_select-seqs
doc: "Select or deselect sequences listed in an id file from fasta or fastq files (SequenceSelector).

Tool homepage: https://github.com/rdpstaff/ReadSeq"
inputs:
  - id: ids_file
    type: File
    doc: "File with the sequence ids to select, one per line"
    inputBinding:
      position: 1
  - id: outfile
    type: string
    doc: "Output file name"
    inputBinding:
      position: 2
  - id: outputformat
    type: string
    doc: "Output format, fasta or fastq (fastq only if the inputs are fastq)"
    inputBinding:
      position: 3
  - id: keep
    type: string
    doc: "Y keeps the sequences in the ids file (default behaviour); N removes them from the output"
    inputBinding:
      position: 4
  - id: seqfiles
    type:
      type: array
      items: File
    doc: "Input sequence file(s), fasta or fastq"
    inputBinding:
      position: 5
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: "Selected sequences"
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
