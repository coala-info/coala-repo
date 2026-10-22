cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem-genotypes-plot
label: tandem-genotypes-plot
doc: "Draw graphs of tandem-genotypes output.\n\nTool homepage: https://github.com/mcfrith/tandem-genotypes"
inputs:
  - id: genotypes_file
    type: File
    doc: tandem-genotypes.txt
    inputBinding:
      position: 1
  - id: output_pdf
    type: string
    doc: output.pdf
    inputBinding:
      position: 2
  - id: rows
    type:
      - 'null'
      - int
    doc: arrange the graphs in this many rows
    inputBinding:
      position: 101
      prefix: --rows
  - id: cols
    type:
      - 'null'
      - int
    doc: arrange the graphs in this many columns
    inputBinding:
      position: 101
      prefix: --cols
  - id: num
    type:
      - 'null'
      - int
    doc: graph the top NUM repeat regions
    inputBinding:
      position: 101
      prefix: --num
  - id: sample
    type:
      - 'null'
      - int
    doc: select SAMPLE-th sample to plot
    inputBinding:
      position: 101
      prefix: --sample
  - id: pointsize
    type:
      - 'null'
      - int
    doc: text size
    inputBinding:
      position: 101
      prefix: --pointsize
  - id: reads
    type:
      - 'null'
      - File
    doc: show expected coverage for FASTA or FASTQ reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show more details
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: plot_pdf
    type: File
    doc: PDF with the graphs
    outputBinding:
      glob: $(inputs.output_pdf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tandem-genotypes:1.9.2--pyh7e72e81_0
