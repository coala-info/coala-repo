cwlVersion: v1.2
class: CommandLineTool
baseCommand: srahunter download
label: srahunter_download
doc: "Download SRA data and convert it to FASTQ format.\n\nTool homepage: https://github.com/GitEnricoNeko/srahunter"
inputs:
  - id: list
    type: File
    doc: Accession list from SRA (file path)
    inputBinding:
      position: 101
      prefix: --list
  - id: maxsize
    type:
      - 'null'
      - string
    doc: Max size of each sra file
    inputBinding:
      position: 101
      prefix: --maxsize
  - id: path
    type:
      - 'null'
      - Directory
    doc: Path to where to download .sra files
    inputBinding:
      position: 101
      prefix: --path
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: outdir_path
    type: string
    doc: Output or path parameter `outdir_path`
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Path to where to download .fastq files
    outputBinding:
      glob: $(inputs.outdir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/srahunter:0.0.9--pyhdfd78af_0
