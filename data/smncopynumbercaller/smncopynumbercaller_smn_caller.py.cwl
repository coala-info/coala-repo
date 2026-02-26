cwlVersion: v1.2
class: CommandLineTool
baseCommand: smn_caller.py
label: smncopynumbercaller_smn_caller.py
doc: "Call Copy number of full-length SMN1, full-length SMN2 and SMN* (Exon7-8 deletion)
  from a WGS bam file.\n\nTool homepage: https://github.com/Illumina/SMNCopyNumberCaller"
inputs:
  - id: countFilePath
    type:
      - 'null'
      - File
    doc: Optional path to count files
    inputBinding:
      position: 101
      prefix: --countFilePath
  - id: genome
    type: string
    doc: Reference genome, select from 19, 37, or 38
    inputBinding:
      position: 101
      prefix: --genome
  - id: manifest
    type: File
    doc: Manifest listing absolute paths to input BAM/CRAM files
    inputBinding:
      position: 101
      prefix: --manifest
  - id: outDir
    type: Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outDir
  - id: prefix
    type: string
    doc: Prefix to output file
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reference
    type:
      - 'null'
      - File
    doc: Optional path to reference fasta file for CRAM
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Default is 1
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smncopynumbercaller:1.1.2--py312h7e72e81_1
stdout: smncopynumbercaller_smn_caller.py.out
