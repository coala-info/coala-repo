cwlVersion: v1.2
class: CommandLineTool
baseCommand: detectExtremeDepth.pl
label: perl-pcap_detectExtremeDepth.pl
doc: "Find regions of extreme depth in a BigWig file and write them as a BED file\n\nTool homepage: https://github.com/ICGC-TCGA-PanCancer/PCAP-core"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({"class": "Directory", "basename": inputs.output, "listing": []})'
        writable: true
  - class: InlineJavascriptRequirement
inputs:
  - id: bigwig
    type: File
    doc: "BigWig file to scan for extreme depth"
    inputBinding:
      position: 101
      prefix: -bigwig
  - id: output
    type: string
    doc: "Existing folder to write the .bed file to"
    inputBinding:
      position: 101
      prefix: -output
  - id: ref
    type:
      - 'null'
      - string
    doc: "Only process this chromosome"
    inputBinding:
      position: 101
      prefix: -ref
  - id: decode
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -decode
    doc: "Decode a chromosome number to a name, as NUMBER:NAME (use with -ref)"
    inputBinding:
      position: 101
  - id: sd
    type:
      - 'null'
      - int
    doc: "Number of standard deviations above the mean to call extreme depth [12]"
    inputBinding:
      position: 101
      prefix: -sd
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: "Folder with the BED file of extreme-depth regions"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pcap:3.5.2--pl526h14c3975_0
stdout: perl-pcap_detectExtremeDepth.pl.out
