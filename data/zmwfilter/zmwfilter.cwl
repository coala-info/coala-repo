cwlVersion: v1.2
class: CommandLineTool
baseCommand: zmwfilter
label: zmwfilter
doc: "Filter ZMWs (Zero-Mode Waveguides) from a PacBio BAM file using a whitelist
  or blacklist.\n\nTool homepage: https://github.com/PacificBiosciences/zmwfilter"
inputs:
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: blacklist
    type:
      - 'null'
      - File
    doc: File containing a list of ZMWs to discard
    inputBinding:
      position: 102
      prefix: --blacklist
  - id: compression
    type:
      - 'null'
      - int
    doc: Compression level for the output BAM file
    default: 0
    inputBinding:
      position: 102
      prefix: --compression
  - id: readnames
    type:
      - 'null'
      - boolean
    doc: Treat the whitelist/blacklist as a list of read names instead of ZMW numbers
    inputBinding:
      position: 102
      prefix: --readnames
  - id: whitelist
    type:
      - 'null'
      - File
    doc: File containing a list of ZMWs to retain
    inputBinding:
      position: 102
      prefix: --whitelist
outputs:
  - id: output_bam
    type: File
    doc: Output filtered BAM file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zmwfilter:1.0.0--h9ee0642_2
