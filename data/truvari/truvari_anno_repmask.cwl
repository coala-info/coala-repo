cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - truvari
  - anno
  - repmask
label: truvari_anno_repmask
doc: "Wrapper around RepeatMasker to annotate insertion sequences in a VCF\n\nTool homepage: https://github.com/ACEnglish/truvari"
inputs:
  - id: input
    type: File
    doc: VCF to annotate (None)
    inputBinding:
      position: 1
      prefix: "-i"
  - id: output
    type:
      - 'null'
      - string
    default: repmask.vcf
    doc: Output filename (/dev/stdout)
    inputBinding:
      position: 1
      prefix: "-o"
  - id: executable
    type:
      - 'null'
      - File
    doc: Path to RepeatMasker (RepeatMasker); give the executable as a file when it is not on PATH in the image
    inputBinding:
      position: 1
      prefix: "-e"
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum size of entry to annotate (50)
    inputBinding:
      position: 1
      prefix: "-m"
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum size of entry to annotate (50000)
    inputBinding:
      position: 1
      prefix: "-M"
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold for pct of allele covered (0.8)
    inputBinding:
      position: 1
      prefix: "-t"
  - id: params
    type:
      - 'null'
      - string
    doc: Default parameter string to send to RepeatMasker (-pa {threads} -qq -e hmmer -species human -lcambig -nocut -div 50 -no_id -s {fasta})
    inputBinding:
      position: 1
      prefix: "-p="
      separate: false
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (1)
    inputBinding:
      position: 1
      prefix: "-T"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose logging
    inputBinding:
      position: 1
      prefix: "--debug"
outputs:
  - id: output_vcf
    type: File
    doc: Annotated VCF
    outputBinding:
      glob: "$(inputs.output)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/truvari:5.4.0--pyhdfd78af_0
