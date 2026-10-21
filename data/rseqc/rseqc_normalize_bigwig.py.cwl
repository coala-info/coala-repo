cwlVersion: v1.2
class: CommandLineTool
baseCommand: [normalize_bigwig.py]
label: rseqc_normalize_bigwig.py
doc: "Normalize a BigWig file to a given total signal (wigsum) and write it as wig or bedGraph.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs:
  - id: bwfile
    type: File
    doc: "Input BigWig file."
    inputBinding:
      position: 1
      prefix: --bwfile
  - id: output_wig
    type: string
    doc: "Output wig file."
    inputBinding:
      position: 1
      prefix: --output
  - id: wigsum
    type:
      - 'null'
      - int
    doc: "Specified wigsum. 100000000 equals to coverage of 1 million 100nt reads. default=100000000"
    inputBinding:
      position: 1
      prefix: --wigsum
  - id: refgene
    type:
      - 'null'
      - File
    doc: "Reference gene model in bed format."
    inputBinding:
      position: 1
      prefix: --refgene
  - id: chunk
    type:
      - 'null'
      - int
    doc: "Chromosome chunk size. Each chomosome will be cut into samll chunks of this size. Decrease chunk size will save more RAM. default=500000 (bp)"
    inputBinding:
      position: 1
      prefix: --chunk
  - id: format
    type:
      - 'null'
      - string
    doc: "Output format. either \"wig\" or \"bgr\". \"bgr\" save disk space but make program slower. default=bgr"
    inputBinding:
      position: 1
      prefix: --format
outputs:
  - id: output_file
    type: File
    doc: "Normalized output (wig or bedGraph) file."
    outputBinding:
      glob: "$(inputs.output_wig)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
