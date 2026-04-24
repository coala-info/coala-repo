cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools_stats
label: dmtools_stats
doc: "Calculate statistics from DM files.\n\nTool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: bed_file
    type:
      - 'null'
      - File
    doc: 'bed file for calculate stats, format: chrom start end (strand).'
    inputBinding:
      position: 101
      prefix: --bed
  - id: bin_size
    type:
      - 'null'
      - int
    doc: size of bin for count cytosine number.
    inputBinding:
      position: 101
      prefix: -s
  - id: context
    type:
      - 'null'
      - int
    doc: "[0/1/2/3] context for show, 0 represent 'C/ALL' context, 1 'CG' context,
      2 'CHG' context, 3 'CHH' context."
    inputBinding:
      position: 101
      prefix: --context
  - id: input_file
    type: File
    doc: input DM file
    inputBinding:
      position: 101
      prefix: -i
  - id: max_coverage
    type:
      - 'null'
      - int
    doc: '<= maximum coverage show, default: 10000'
    inputBinding:
      position: 101
      prefix: --maxcover
  - id: min_coverage
    type:
      - 'null'
      - int
    doc: '>= minumum coverage show, default: 0'
    inputBinding:
      position: 101
      prefix: --mincover
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: region for calculate stats, can be seperated by space. chr1:1-2900 
      chr2:1-200
    inputBinding:
      position: 101
      prefix: -r
  - id: strand
    type:
      - 'null'
      - int
    doc: "[0/1/2] strand for show, 0 represent '+' positive strand, 1 '-' negative
      strand, 2 '.' all information"
    inputBinding:
      position: 101
      prefix: --strand
  - id: total_cytosine_guanine
    type:
      - 'null'
      - int
    doc: total number of cytosine and guanine in genome, we will use the number 
      of site in dm file if you not provide --tc
    inputBinding:
      position: 101
      prefix: --tc
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dmtools:0.2.6--hda3def1_0
