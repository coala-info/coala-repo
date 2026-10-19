cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - overlap2dot
label: ra_overlap2dot
doc: "Converts a dovetail overlaps file (such as the output of depot dump_overlaps)\
  \ to a dot graph on standard output.\n\nTool homepage: https://github.com/mariokostelac/ra"
inputs:
  - id: reads
    type: File
    doc: reads file
    inputBinding:
      position: 102
      prefix: --reads
  - id: overlaps
    type: File
    doc: overlaps file
    inputBinding:
      position: 102
      prefix: --overlaps
  - id: reads_format
    type:
      - 'null'
      - string
    doc: 'reads format; supported: fasta, fastq, afg (default fasta)'
    inputBinding:
      position: 102
      prefix: --reads_format
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ra:0.9--h503566f_8
stdout: ra_overlap2dot.out
