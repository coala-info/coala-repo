cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alleyoop
  - rates
label: slamdunk_alleyoop_rates
doc: "Calculate overall conversion rates on SLAM-seq datasets\n\nTool homepage: http://t-neumann.github.io/slamdunk"
inputs:
  - id: bam
    type:
      type: array
      items: File
    doc: 'Bam file(s)'
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 100
  - id: reference
    type: File
    doc: 'Reference fasta file'
    secondaryFiles:
      - pattern: .fai
        required: false
    inputBinding:
      position: 1
      prefix: --reference
  - id: min_basequality
    type: ['null', int]
    doc: 'Minimal base quality for SNPs (default: 27)'
    inputBinding:
      position: 1
      prefix: --min-basequality
  - id: threads
    type: ['null', int]
    doc: 'Thread number (default: 1)'
    inputBinding:
      position: 1
      prefix: --threads
  - id: output_dir
    type: string
    default: rates_out
    doc: Output directory
    inputBinding:
      position: 1
      prefix: --outputDir
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slamdunk:0.4.3--py_0
