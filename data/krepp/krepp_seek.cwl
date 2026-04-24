cwlVersion: v1.2
class: CommandLineTool
baseCommand: krepp seek
label: krepp_seek
doc: "Seek query sequences in a sketch and estimate distances.\n\nTool homepage: https://github.com/bo1929/krepp"
inputs:
  - id: hdist_th
    type:
      - 'null'
      - int
    doc: Maximum Hamming distance for a k-mer to match.
    inputBinding:
      position: 101
      prefix: --hdist-th
  - id: query
    type: File
    doc: Query FASTA/FASTQ file <path> (or URL) (gzip compatible).
    inputBinding:
      position: 101
      prefix: --query
  - id: sketch_path
    type: File
    doc: Sketch file at <path> to query.
    inputBinding:
      position: 101
      prefix: --sketch-path
outputs:
  - id: output_path
    type:
      - 'null'
      - File
    doc: Write output to a file at <path>.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krepp:0.7.1--hdb29145_0
