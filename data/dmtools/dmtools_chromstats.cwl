cwlVersion: v1.2
class: CommandLineTool
baseCommand: dmtools chromstats
label: dmtools_chromstats
doc: "Calculate chromosome methylation statistics from DM files.\n\nTool homepage:
  https://github.com/ZhouQiangwei/dmtools"
inputs:
  - id: chromstep
    type:
      - 'null'
      - int
    doc: step mean bin size for chromosome region
    default: 100000
    inputBinding:
      position: 101
      prefix: --chromstep
  - id: context
    type:
      - 'null'
      - int
    doc: context for show, 0 represent 'C/ALL' context, 1 'CG' context, 2 'CHG' 
      context, 3 'CHH' context, 4 calculate and print context meth level 
      seperately.
    default: 4
    inputBinding:
      position: 101
      prefix: --context
  - id: fstrand
    type:
      - 'null'
      - int
    doc: strand for calculation, 0 represent '+' positive strand, 1 '-' negative
      strand, 2 '.' without strand information, 3 calculate and print strand 
      meth level seperately.
    default: 2
    inputBinding:
      position: 101
      prefix: --fstrand
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
    doc: weighted/ mean/ min/ max/ cover/ dev
    inputBinding:
      position: 101
      prefix: --method
  - id: print2one
    type:
      - 'null'
      - int
    doc: print all the countC and coverage results of C/CG/CHG/CHH context 
      methylation to same file, only valid when --printcoverage 1. 0 for no, 1 
      for yes.
    default: 0
    inputBinding:
      position: 101
      prefix: --print2one
  - id: printcoverage
    type:
      - 'null'
      - int
    doc: print countC and coverage instead of methratio.
    default: 0
    inputBinding:
      position: 101
      prefix: --printcoverage
  - id: stepmove
    type:
      - 'null'
      - int
    doc: step move, if no overlap, please define same as --chromstep
    default: 50000
    inputBinding:
      position: 101
      prefix: --stepmove
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
