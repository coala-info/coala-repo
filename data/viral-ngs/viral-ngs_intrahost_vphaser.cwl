cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - intrahost.py
  - vphaser
label: viral-ngs_intrahost_vphaser
doc: "Run V-Phaser 2 on the input file without any additional filtering. Combine the non-header lines of the CHROM.var.raw.txt files it produces, adding CHROM as the first field on each line.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: false
    doc: "Input Bam file."
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: out_tab
    type: string
    doc: "Tab-separated headerless output file."
    inputBinding:
      position: 2
  - id: num_threads
    type:
      - 'null'
      - int
    doc: "Number of threads in call to V-Phaser 2."
    inputBinding:
      position: 20
      prefix: --numThreads
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: out_tab_file
    type: File
    doc: "Output file written to out_tab"
    outputBinding:
      glob: $(inputs.out_tab)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_bam)
        writable: true

hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
