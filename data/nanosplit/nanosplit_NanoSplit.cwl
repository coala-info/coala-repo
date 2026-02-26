cwlVersion: v1.2
class: CommandLineTool
baseCommand: NanoSplit
label: nanosplit_NanoSplit
doc: "Perform splitting of a fastq file based on average basecall quality.\n\nTool
  homepage: https://github.com/wdecoster/nanosplit"
inputs:
  - id: fastqfile
    type: File
    doc: Fastq file to split, can be gz compressed.
    inputBinding:
      position: 1
  - id: quality
    type:
      - 'null'
      - int
    doc: Splitting on this average read quality score
    inputBinding:
      position: 102
      prefix: --quality
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Specify directory in which output has to be created.
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanosplit:0.1.4--py35_0
