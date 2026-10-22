cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqhax
  - rebarcode
label: seqhax_rebarcode
doc: "Add index sequences from header to the start of reads\n\nTool homepage: https://github.com/kdmurray91/seqhax"
inputs:
  - id: r1
    type: File
    doc: Forward reads (FASTQ with Illumina-style headers containing the index)
    inputBinding:
      position: 1
  - id: r2
    type: File
    doc: Reverse reads
    inputBinding:
      position: 2
  - id: output_path
    type:
      - 'null'
      - string
    doc: 'Output interleaved reads to FILE. Use - for stdout. (default: stdout)'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Interleaved reads with index sequences added
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
stdout: seqhax_rebarcode.out
