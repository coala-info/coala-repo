cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar ibdseq.jar
label: ibdseq
doc: Calculates Identity By Descent (IBD) segments between individuals in a VCF 
  file.
inputs:
  - id: chrom
    type:
      - 'null'
      - string
    doc: '[chrom]:[start]-[end]'
    inputBinding:
      position: 101
  - id: errormax
    type:
      - 'null'
      - float
    doc: max allele error rate
    inputBinding:
      position: 101
  - id: errorprop
    type:
      - 'null'
      - float
    doc: allele error as proportion of MAF
    inputBinding:
      position: 101
  - id: excludemarkers
    type:
      - 'null'
      - File
    doc: excluded markers file
    inputBinding:
      position: 101
  - id: excludesamples
    type:
      - 'null'
      - File
    doc: excluded samples file
    inputBinding:
      position: 101
  - id: gt
    type: File
    doc: VCF file with GT field
    inputBinding:
      position: 101
  - id: ibdlod
    type:
      - 'null'
      - float
    doc: min LOD score for reported IBD
    inputBinding:
      position: 101
  - id: ibdtrim
    type:
      - 'null'
      - float
    doc: LOD score to trim from segment ends
    inputBinding:
      position: 101
  - id: minalleles
    type:
      - 'null'
      - int
    doc: minimum minor allele count
    inputBinding:
      position: 101
  - id: nthreads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
  - id: out
    type: string
    doc: output file prefix
    inputBinding:
      position: 101
  - id: r2max
    type:
      - 'null'
      - float
    doc: max R2 permitted between markers
    inputBinding:
      position: 101
  - id: r2window
    type:
      - 'null'
      - int
    doc: window-size when checking marker R2
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdseq:r1206--1
stdout: ibdseq.out
