cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sambamba
  - subsample
label: sambamba_subsample
doc: "Subsample a bam file.\n\nTool homepage: https://github.com/biod/sambamba"
inputs:
  - id: input_bam
    type:
      type: array
      items: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: Input BAM file(s)
    inputBinding:
      position: 3
  - id: type
    type:
      - 'null'
      - string
    doc: Algorithm for subsampling (fasthash, default is none)
    inputBinding:
      position: 1
      prefix: --type=
      separate: false
  - id: max_cov
    type:
      - 'null'
      - int
    doc: Maximum coverage (approx)
    inputBinding:
      position: 1
      prefix: --max-cov=
      separate: false
  - id: remove
    type:
      - 'null'
      - boolean
    doc: Remove over sampled reads from output
    inputBinding:
      position: 1
      prefix: --remove
  - id: output_path
    type:
      - 'null'
      - string
    doc: Set output file (default stdout)
    inputBinding:
      position: 2
      prefix: -o
      separate: false
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: Subsampled BAM file
    outputBinding:
      glob: $(inputs.output_path)
  - id: stdout
    type: stdout
    doc: Standard output (BAM stream when no output file is given)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sambamba:1.0.1--he614052_4
stdout: sambamba_subsample.out
