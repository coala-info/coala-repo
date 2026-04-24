cwlVersion: v1.2
class: CommandLineTool
baseCommand: dnadotplot
label: dnadotplot
doc: "A DNA dot plot generator\n\nTool homepage: https://github.com/quadram-institute-bioscience/dnadotplot"
inputs:
  - id: first_file
    type: File
    doc: Path to the first FASTA file (can be gzipped)
    inputBinding:
      position: 101
      prefix: --first-file
  - id: first_name
    type:
      - 'null'
      - string
    doc: Name of the FASTA sequence in the first file
    inputBinding:
      position: 101
      prefix: --first-name
  - id: img_size
    type:
      - 'null'
      - float
    doc: 'Image size: if >1 use as pixels, if <1 use as fraction of longest sequence'
    inputBinding:
      position: 101
      prefix: --img-size
  - id: revcompl
    type:
      - 'null'
      - boolean
    doc: Also look for reverse complement matches
    inputBinding:
      position: 101
      prefix: --revcompl
  - id: second_file
    type:
      - 'null'
      - File
    doc: Path to the second FASTA file (if omitted, self alignment of the first)
    inputBinding:
      position: 101
      prefix: --second-file
  - id: second_name
    type:
      - 'null'
      - string
    doc: Name of the FASTA sequence in the second file
    inputBinding:
      position: 101
      prefix: --second-name
  - id: svg
    type:
      - 'null'
      - boolean
    doc: Force SVG output (auto-detected from .svg extension)
    inputBinding:
      position: 101
      prefix: --svg
  - id: window
    type:
      - 'null'
      - int
    doc: 'Window size for matching (default: 10)'
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output
    type: File
    doc: Path to the output file (PNG or SVG based on extension)
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dnadotplot:0.1.4--hc1c3326_0
