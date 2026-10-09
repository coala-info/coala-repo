cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lorax
  - convert
label: lorax_convert
doc: "Convert a pan-genome graph alignment (GAF) to BAM.\n\nTool homepage: https://github.com/tobiasrausch/lorax"
inputs:
  - id: sample_gaf_gz
    type: File
    doc: sample graph alignments in GAF format (gzipped)
    inputBinding:
      position: 1
  - id: chunk
    type:
      - 'null'
      - int
    doc: chunk size, 0 for all at once [default 500000]
    inputBinding:
      position: 101
      prefix: --chunk
  - id: graph
    type: File
    doc: GFA pan-genome graph
    inputBinding:
      position: 101
      prefix: --graph
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: FASTA reference (with BAM/CRAM input)
    inputBinding:
      position: 101
      prefix: --reference
  - id: align
    type:
      - 'null'
      - File
    secondaryFiles:
      - .bai
    doc: BAM/CRAM file
    inputBinding:
      position: 101
      prefix: --align
  - id: fastq
    type:
      - 'null'
      - File
    doc: FASTA/FASTQ file (instead of BAM/CRAM)
    inputBinding:
      position: 101
      prefix: --fastq
  - id: sequences_path
    type:
      - 'null'
      - string
    doc: output sequences [default out.fa]
    inputBinding:
      position: 102
      prefix: --sequences
  - id: outfile_path
    type: string
    doc: output alignments
    inputBinding:
      position: 103
      prefix: --outfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: output alignments
    outputBinding:
      glob: $(inputs.outfile_path)
  - id: sequences
    type:
      - 'null'
      - File
    doc: output sequences
    outputBinding:
      glob: "$(inputs.sequences_path ? inputs.sequences_path : 'out.fa')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lorax:0.5.1--h4d20210_0
