cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bcftools
  - +gtc2vcf
label: bcftools-gtc2vcf-plugin
doc: "Convert Illumina GTC files to VCF. This tool is a plugin for bcftools that processes
  Illumina Genotype Call (GTC) files and converts them into VCF format using a manifest
  file and a reference genome.\n\nTool homepage: https://github.com/freeseek/gtc2vcf"
inputs:
  - id: capacity
    type:
      - 'null'
      - int
    doc: Initial capacity for the VCF records
    inputBinding:
      position: 101
      prefix: --capacity
  - id: fasta_ref
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --fasta-ref
  - id: gender
    type:
      - 'null'
      - string
    doc: Sample gender (e.g., M, F, or 1, 2)
    inputBinding:
      position: 101
      prefix: --gender
  - id: gtc
    type: File
    doc: Input GTC file
    inputBinding:
      position: 101
      prefix: --gtc
  - id: manifest
    type: File
    doc: Illumina manifest file (.bpm or .csv)
    inputBinding:
      position: 101
      prefix: --manifest
  - id: no_version
    type:
      - 'null'
      - boolean
    doc: Do not append version and command line to the header
    inputBinding:
      position: 101
      prefix: --no-version
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name to use in the VCF
    inputBinding:
      position: 101
      prefix: --sample-name
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output VCF file name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcftools-gtc2vcf-plugin:1.22--hb66fcc3_0
