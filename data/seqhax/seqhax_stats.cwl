cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqhax
  - stats
label: seqhax_stats
doc: "Basic statistics about sequence files (FASTQs, optionally gzip-compressed)\n\nTool homepage: https://github.com/kdmurray91/seqhax"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: FASTQ files, optionally gzip-compressed
    inputBinding:
      position: 1
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel jobs [1]
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
stdout: seqhax_stats.out
