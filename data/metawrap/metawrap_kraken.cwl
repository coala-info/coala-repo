cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - kraken
label: metawrap_kraken
doc: "Run on any number of fasta assembly files and/or or paired-end reads.\n\nTool
  homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: assembly_fasta
    type:
      - 'null'
      - File
    doc: Fasta assembly file
    inputBinding:
      position: 1
  - id: reads_1_fastq
    type:
      - 'null'
      - File
    doc: Paired-end read file 1
    inputBinding:
      position: 2
  - id: reads_2_fastq
    type:
      - 'null'
      - File
    doc: Paired-end read file 2
    inputBinding:
      position: 3
  - id: no_preload
    type:
      - 'null'
      - boolean
    doc: do not pre-load the kraken DB into memory (slower, but lower memory 
      requirement)
    inputBinding:
      position: 104
      prefix: --no-preload
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 104
      prefix: -o
  - id: read_subsampling
    type:
      - 'null'
      - int
    doc: read subsampling number
    default: all
    inputBinding:
      position: 104
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 104
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metawrap:1.2--0
stdout: metawrap_kraken.out
