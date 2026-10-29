cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - divide
label: truvari_divide
doc: "Divide a VCF into independent parts\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: buffer
    type:
      - 'null'
      - int
    doc: Buffer to make mini-clusters (1000)
    inputBinding:
      position: 1
      prefix: "-b"
  - id: min
    type:
      - 'null'
      - int
    doc: Minimum number of entries per-vcf (50000)
    inputBinding:
      position: 1
      prefix: "-m"
  - id: no_compress
    type:
      - 'null'
      - boolean
    doc: Don't attempt to compress/index sub-VCFs
    inputBinding:
      position: 1
      prefix: "--no-compress"
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for compressing/indexing sub-VCFs (1)
    inputBinding:
      position: 1
      prefix: "-T"
  - id: vcf
    type: File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: VCF to split
    inputBinding:
      position: 2
  - id: dir
    type: string
    doc: Output directory to save parts (must not exist)
    inputBinding:
      position: 3
outputs:
  - id: parts
    type: Directory
    doc: Directory of divided VCF parts
    outputBinding:
      glob: "$(inputs.dir)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
