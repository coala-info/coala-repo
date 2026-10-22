cwlVersion: v1.2
class: CommandLineTool
baseCommand: shigatyper
label: shigatyper_shigatyper.py
doc: "A WGS-based genoserotyping pipeline for Shigella spp. (ShigaTyper). Predicts the serotype from Illumina paired-end, single-end or ONT reads.\n\nTool homepage: https://github.com/CFSAN-Biostatistics/shigatyper"
inputs:
  - id: r1
    type: ['null', File]
    doc: Input FASTQ is R1 of paired-end reads
    inputBinding:
      position: 101
      prefix: --R1
  - id: r2
    type: ['null', File]
    doc: Input FASTQ is R2 of paired-end reads
    inputBinding:
      position: 101
      prefix: --R2
  - id: se
    type: ['null', File]
    doc: Input FASTQ is contains single-end reads
    inputBinding:
      position: 101
      prefix: --SE
  - id: ont
    type: ['null', boolean]
    doc: The input FASTQ file contains ONT reads
    inputBinding:
      position: 101
      prefix: --ont
  - id: sample_name
    type: ['null', string]
    doc: Sample name
    inputBinding:
      position: 101
      prefix: --name
  - id: verbose
    type: ['null', boolean]
    doc: Verbose mode
    inputBinding:
      position: 101
      prefix: --verbose
  - id: outdir
    type: string
    doc: Where to write output files to
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_directory
    type: Directory
    doc: Directory with the serotype prediction and hit tables
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shigatyper:2.0.5--pyhdfd78af_0
stdout: shigatyper_shigatyper.py.out
