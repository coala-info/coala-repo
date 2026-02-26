cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sinto
  - nametotag
label: sinto_nametotag
doc: "Copy cell barcode sequences from read name to read tag\n\nTool homepage: https://timoast.github.io/sinto/"
inputs:
  - id: bam_file
    type: File
    doc: Input SAM/BAM file, '-' reads from stdin
    inputBinding:
      position: 101
      prefix: --bam
  - id: barcode_regex
    type:
      - 'null'
      - string
    doc: Regular expression used to extract cell barcode from read name. Default
      ("[^:]*") matches all characters up to the first colon.
    default: '[^:]*'
    inputBinding:
      position: 101
      prefix: --barcode_regex
  - id: output_format
    type:
      - 'null'
      - string
    doc: Output format. One of 't' (SAM), 'b' (BAM), or 'u' (uncompressed BAM)
    default: t
    inputBinding:
      position: 101
      prefix: --outputformat
  - id: tag
    type:
      - 'null'
      - string
    doc: Read tag to copy to.
    inputBinding:
      position: 101
      prefix: --tag
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output SAM/BAM file, '-' outputs to stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
