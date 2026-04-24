cwlVersion: v1.2
class: CommandLineTool
baseCommand: flaimapper
label: flaimapper
doc: "A tool for annotating and quantifying fragments from SAM/BAM files, specifically
  designed for small RNA-seq data.\n\nTool homepage: https://github.com/yhoogstrate/flaimapper/"
inputs:
  - id: alignment_file
    type: File
    doc: indexed SAM or BAM file
    inputBinding:
      position: 1
  - id: fasta
    type:
      - 'null'
      - File
    doc: Single reference FASTA file (+faid index) containing all genomic reference
      sequences
    inputBinding:
      position: 102
      prefix: --fasta
  - id: format
    type:
      - 'null'
      - int
    doc: 'file format of the output: [1: table; per fragment], [2: GTF (default)]'
    inputBinding:
      position: 102
      prefix: --format
  - id: offset3p
    type:
      - 'null'
      - int
    doc: Offset in bp added to the exon-type annotations in the GTF file. This offset
      is used in tools estimating the expression levels
    inputBinding:
      position: 102
      prefix: --offset3p
  - id: offset5p
    type:
      - 'null'
      - int
    doc: Offset in bp added to the exon-type annotations in the GTF file. This offset
      is used in tools estimating the expression levels
    inputBinding:
      position: 102
      prefix: --offset5p
  - id: parameters
    type:
      - 'null'
      - File
    doc: File containing the filtering parameters, using default if none is provided
    inputBinding:
      position: 102
      prefix: --parameters
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Enable quiet mode
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output filename; '-' for stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flaimapper:3.0.0--py36_1
