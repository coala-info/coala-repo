cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metawrap
  - kraken
label: metawrap-kraken_metawrap kraken
doc: "Run on any number of fasta assembly files and/or or paired-end reads.\n\nTool
  homepage: https://github.com/bxlab/metaWRAP"
inputs:
  - id: assembly_fasta
    type: File
    doc: fasta assembly files
    inputBinding:
      position: 1
  - id: reads_1
    type:
      - 'null'
      - type: array
        items: File
    doc: paired-end reads (read 1)
    inputBinding:
      position: 2
  - id: reads_2
    type:
      - 'null'
      - type: array
        items: File
    doc: paired-end reads (read 2)
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
    dockerPull: quay.io/biocontainers/metawrap-kraken:1.3.0--hdfd78af_3
stdout: metawrap-kraken_metawrap kraken.out
