cwlVersion: v1.2
class: CommandLineTool
baseCommand: [shapemapper_read_trimmer]
label: shapemapper_read_trimmer
doc: "Trim low-quality ends of reads in a FASTQ file (ShapeMapper read trimmer).\n\nTool homepage: https://github.com/Weeks-UNC/shapemapper2"
inputs:
  - id: in_fastq
    type: File
    doc: "FASTQ input file path"
    inputBinding:
      position: 101
      prefix: --in
  - id: window_size
    type: ['null', int]
    doc: "Size of window to average quality scores"
    inputBinding:
      position: 101
      prefix: --window_size
  - id: min_phred
    type: ['null', int]
    doc: "Minimum average quality score to allow"
    inputBinding:
      position: 101
      prefix: --min_phred
  - id: min_length
    type: ['null', int]
    doc: "Minimum trimmed read length to allow"
    inputBinding:
      position: 101
      prefix: --min_length
  - id: out_path
    type: string
    doc: "Trimmed FASTQ output file path"
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: trimmed_fastq
    type: File
    doc: Trimmed FASTQ output file
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapemapper:2.3.2--h5814d7d_0
