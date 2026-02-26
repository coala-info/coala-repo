cwlVersion: v1.2
class: CommandLineTool
baseCommand: SeqFileSplitter
label: rdp-readseq_split
doc: Splits a sequence file into smaller files.
inputs:
  - id: infile
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
  - id: outdir
    type: Directory
    doc: Output directory for split files
    inputBinding:
      position: 2
  - id: seq_per_split
    type: int
    doc: Number of sequences per split file
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
stdout: rdp-readseq_split.out
