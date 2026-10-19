cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rdp-readseq
  - split
label: rdp-readseq_split
doc: "Split a sequence file into files with a fixed number of sequences (SeqFileSplitter).

Tool homepage: https://github.com/rdpstaff/ReadSeq"
inputs:
  - id: infile
    type: File
    doc: "Input sequence file"
    inputBinding:
      position: 1
  - id: outdir
    type: string
    doc: "Output directory for the split files (created by the tool)"
    inputBinding:
      position: 2
  - id: seq_per_split
    type: int
    doc: "Number of sequences per split file"
    inputBinding:
      position: 3
outputs:
  - id: out_directory
    type: Directory
    doc: "Directory with the split sequence files"
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
