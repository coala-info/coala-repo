cwlVersion: v1.2
class: CommandLineTool
baseCommand: amplicov
label: amplicon_coverage_plot_amplicov
doc: "Script to parse amplicon region coverage and generate barplot in html\n\nTool
  homepage: https://github.com/chienchi/amplicon_coverage_plot"
inputs:
  - id: bam
    type:
      - 'null'
      - File
    doc: 'sorted bam file (ex: samtools sort input.bam -o sorted.bam)'
    inputBinding:
      position: 101
      prefix: --bam
  - id: bed
    type:
      - 'null'
      - File
    doc: amplicon bed file (bed6 format)
    inputBinding:
      position: 101
      prefix: --bed
  - id: bedpe
    type:
      - 'null'
      - File
    doc: amplicon bedpe file
    inputBinding:
      position: 101
      prefix: --bedpe
  - id: count_primer
    type:
      - 'null'
      - boolean
    doc: count overlapped primer region to unqiue coverage
    inputBinding:
      position: 101
      prefix: --count_primer
  - id: cov
    type:
      - 'null'
      - File
    doc: coverage file [position coverage]
    inputBinding:
      position: 101
      prefix: --cov
  - id: depth_lines
    type:
      - 'null'
      - type: array
        items: int
    doc: Add option to display lines at these depths (provide depths as a list of
      integers)
    default:
      - 5
      - 10
      - 20
      - 50
    inputBinding:
      position: 101
      prefix: --depth_lines
  - id: gff
    type:
      - 'null'
      - File
    doc: gff file for data hover info annotation
    inputBinding:
      position: 101
      prefix: --gff
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: minimum coverage to count as ambiguous N site
    default: 10
    inputBinding:
      position: 101
      prefix: --mincov
  - id: prefix
    type:
      - 'null'
      - string
    doc: output prefix
    inputBinding:
      position: 101
      prefix: --prefix
  - id: proper_paired
    type:
      - 'null'
      - boolean
    doc: process proper paired only reads from bam file (illumina)
    inputBinding:
      position: 101
      prefix: --pp
  - id: ref_id
    type:
      - 'null'
      - string
    doc: reference accession (bed file first field)
    inputBinding:
      position: 101
      prefix: --refID
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amplicon_coverage_plot:0.3.4--pyhdfd78af_0
