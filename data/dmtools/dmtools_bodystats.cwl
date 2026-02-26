cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools_bodystats
label: dmtools_bodystats
doc: "Calculate DNA methylation level of upstream and downstream N-bp window.\n\n\
  Tool homepage: https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: bed_file
    type: File
    doc: 'bed file for view, format: chrom start end [strand].'
    inputBinding:
      position: 101
      prefix: --bed
  - id: context
    type:
      - 'null'
      - int
    doc: "[0/1/2/3/4] context for show, 0 represent 'C/ALL' context, 1 'CG' context,
      2 'CHG' context, 3 'CHH' context, 4 calculate and print strand meth level seperately,
      default: 4."
    default: 4
    inputBinding:
      position: 101
      prefix: --context
  - id: gff_file
    type:
      - 'null'
      - File
    doc: 'gff file for view, format: chrom * * start end * strand * xx=geneid.'
    inputBinding:
      position: 101
      prefix: --gff
  - id: gtf_file
    type:
      - 'null'
      - File
    doc: 'gtf file for view, format: chrom * * start end * strand * xx geneid.'
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input_dm_file
    type: File
    doc: input DM file
    inputBinding:
      position: 101
      prefix: -i
  - id: method
    type:
      - 'null'
      - string
    doc: weighted/ mean
    default: weighted/ mean
    inputBinding:
      position: 101
      prefix: --method
  - id: min_cytosines
    type:
      - 'null'
      - int
    doc: min cytosines in region will used for calculate
    default: 2
    inputBinding:
      position: 101
      prefix: --minC
  - id: print_coverage
    type:
      - 'null'
      - int
    doc: '[0/1] also print countC and coverage of body instead of methratio.'
    default: 0
    inputBinding:
      position: 101
      prefix: --printcoverage
  - id: print_to_one_file
    type:
      - 'null'
      - int
    doc: '[int] print all the countC and coverage results of C/CG/CHG/CHH context
      methylation to same file, only valid when --printcoverage 1. 0 for no, 1 for
      yes.'
    default: 0
    inputBinding:
      position: 101
      prefix: --print2one
  - id: region
    type:
      - 'null'
      - type: array
        items: string
    doc: region for view, can be seperated by space. chr1:1-2900 chr2:1-200,+
    inputBinding:
      position: 101
      prefix: -r
  - id: region_extend
    type:
      - 'null'
      - int
    doc: also calculate DNA methylation level of upstream and downstream N-bp 
      window.
    default: 2000
    inputBinding:
      position: 101
      prefix: --regionextend
  - id: strand
    type:
      - 'null'
      - int
    doc: "[0/1/2/3] strand for show, 0 represent '+' positive strand, 1 '-' negative
      strand, 2 '.' all information, 3 calculate and print strand meth level seperately,
      only valid while -r para"
    inputBinding:
      position: 101
      prefix: --strand
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
