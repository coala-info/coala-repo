cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools_profile
label: dmtools_profile
doc: "Calculate the methylation matrix mode of every region or gene.\n\nTool homepage:
  https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: bed_file
    type: File
    doc: 'bed file for view, format: chrom start end [strand].'
    inputBinding:
      position: 101
      prefix: --bed
  - id: body_x
    type:
      - 'null'
      - float
    doc: the gene body bin size is N multiple of the bin size of the upstream 
      and downstream extension region.
    inputBinding:
      position: 101
      prefix: --bodyX
  - id: context
    type:
      - 'null'
      - int
    doc: "[0/1/2/3] context for calculate, 0 represent 'C/ALL' context, 1 'CG' context,
      2 'CHG' context, 3 'CHH' context."
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
  - id: matrix_x
    type:
      - 'null'
      - int
    doc: the bin size is N times of the profile bin size, so the bin size should
      be N*profilestep [5], please note N*profilestep must < 1 and N must >= 1, 
      used for calculation per gene.
    inputBinding:
      position: 101
      prefix: --matrixX
  - id: print_to_one
    type:
      - 'null'
      - int
    doc: '[int] print all the matrix results of C/CG/CHG/CHH context methylation to
      same file. 0 for no, 1 for yes.'
    inputBinding:
      position: 101
      prefix: --print2one
  - id: profile_mode
    type:
      - 'null'
      - int
    doc: calculate the methylation matrix mode of every region or gene. 0 for 
      gene and flanks mode, 1 for tss and flanks, 2 for tts and flanks, 3 for 
      region center and flanks.
    inputBinding:
      position: 101
      prefix: --profilemode
  - id: profile_move_step
    type:
      - 'null'
      - float
    doc: 'step move, default: profilestep/2, if no overlap, please define same as
      --profilestep'
    inputBinding:
      position: 101
      prefix: --profilemovestep
  - id: profile_step
    type:
      - 'null'
      - float
    doc: 'step mean bin size for chromosome region, default: 0.02 (2%)'
    inputBinding:
      position: 101
      prefix: --profilestep
  - id: region_extend
    type:
      - 'null'
      - int
    doc: region extend for upstream and downstram
    inputBinding:
      position: 101
      prefix: --regionextend
  - id: strand
    type:
      - 'null'
      - int
    doc: "[0/1/2] strand for calculate, 0 represent '+' positive strand, 1 '-' negative
      strand, 2 '.' all information"
    inputBinding:
      position: 101
      prefix: --strand
  - id: threads
    type:
      - 'null'
      - int
    doc: threads
    inputBinding:
      position: 101
      prefix: -p
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
