cwlVersion: v1.2
class: CommandLineTool
baseCommand: ibdseq
label: ibdseq
doc: "Detects identity by descent (IBD) segments between individuals from the
  genotypes in a VCF file.\n\nTool homepage: https://faculty.washington.edu/browning/ibdseq.html"
inputs:
  - id: gt
    type: File
    doc: VCF file with GT field
    inputBinding:
      position: 1
      prefix: gt=
      separate: false
  - id: out
    type: string
    doc: Output file prefix
    inputBinding:
      position: 2
      prefix: out=
      separate: false
  - id: excludesamples
    type:
      - 'null'
      - File
    doc: Excluded samples file
    inputBinding:
      position: 3
      prefix: excludesamples=
      separate: false
  - id: excludemarkers
    type:
      - 'null'
      - File
    doc: Excluded markers file
    inputBinding:
      position: 4
      prefix: excludemarkers=
      separate: false
  - id: chrom
    type:
      - 'null'
      - string
    doc: '[chrom]:[start]-[end]'
    inputBinding:
      position: 5
      prefix: chrom=
      separate: false
  - id: minalleles
    type:
      - 'null'
      - int
    doc: Minimum minor allele count (default 2)
    inputBinding:
      position: 6
      prefix: minalleles=
      separate: false
  - id: ibdlod
    type:
      - 'null'
      - float
    doc: Min LOD score for reported IBD (default 3.0)
    inputBinding:
      position: 7
      prefix: ibdlod=
      separate: false
  - id: ibdtrim
    type:
      - 'null'
      - float
    doc: LOD score to trim from segment ends (default 0.3)
    inputBinding:
      position: 8
      prefix: ibdtrim=
      separate: false
  - id: errormax
    type:
      - 'null'
      - float
    doc: Max allele error rate (default 0.001)
    inputBinding:
      position: 9
      prefix: errormax=
      separate: false
  - id: errorprop
    type:
      - 'null'
      - float
    doc: Allele error as proportion of MAF (default 0.25)
    inputBinding:
      position: 10
      prefix: errorprop=
      separate: false
  - id: r2window
    type:
      - 'null'
      - int
    doc: Window-size when checking marker R2 (default 500)
    inputBinding:
      position: 11
      prefix: r2window=
      separate: false
  - id: r2max
    type:
      - 'null'
      - float
    doc: Max R2 permitted between markers (default 0.15)
    inputBinding:
      position: 12
      prefix: r2max=
      separate: false
  - id: nthreads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default 1)
    inputBinding:
      position: 13
      prefix: nthreads=
      separate: false
outputs:
  - id: ibd
    type: File
    doc: IBD segments (ID1, ID2, chromosome, start, end, LOD)
    outputBinding:
      glob: $(inputs.out).ibd
  - id: hbd
    type:
      - 'null'
      - File
    doc: Homozygosity by descent segments
    outputBinding:
      glob: $(inputs.out).hbd
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: $(inputs.out).log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ibdseq:r1206--1
