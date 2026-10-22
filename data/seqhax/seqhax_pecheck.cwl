cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqhax
  - pecheck
label: seqhax_pecheck
doc: "Check that paired end reads match properly\n\nTool homepage: https://github.com/kdmurray91/seqhax"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Pairs of FASTQ files (r1 r2 [r1 r2 ...]), or interleaved FASTQ files with -i
    inputBinding:
      position: 1
  - id: output_path
    type:
      - 'null'
      - string
    doc: 'Output interleaved reads to FILE. Use - for stdout. All sets of paired end files end up in the
      same output (default: no output)'
    inputBinding:
      position: 102
      prefix: -o
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: Interleaved inputs
    inputBinding:
      position: 102
      prefix: -i
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't print tabular summary
    inputBinding:
      position: 102
      prefix: -q
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel threads
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Interleaved reads
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqhax:0.8.6--h43eeafb_1
stdout: seqhax_pecheck.out
