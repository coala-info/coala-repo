cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alleyoop
  - utrrates
label: slamdunk_alleyoop_utrrates
doc: "Calculate conversion rates per UTR on SLAM-seq datasets\n\nTool homepage: http://t-neumann.github.io/slamdunk"
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
  - id: multi_tc_stringency
    type: ['null', boolean]
    doc: 'Multi T>C stringency'
    inputBinding:
      position: 1
      prefix: --multiTCStringency
  - id: threads
    type: ['null', int]
    doc: 'Thread number (default: 1)'
    inputBinding:
      position: 1
      prefix: --threads
  - id: bed_file
    type: File
    doc: 'BED file'
    inputBinding:
      position: 1
      prefix: --bed
  - id: max_read_length
    type: ['null', int]
    doc: 'Max read length in BAM file (default: None)'
    inputBinding:
      position: 1
      prefix: --max-read-length
  - id: output_dir
    type: string
    default: utrrates_out
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
