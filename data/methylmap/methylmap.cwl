cwlVersion: v1.2
class: CommandLineTool
baseCommand: methylmap
label: methylmap
doc: "Plotting tool for population scale nucleotide modifications.\n\nTool homepage:
  https://github.com/EliseCoopman/methylmap"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Run the app in debug mode
    inputBinding:
      position: 101
      prefix: --debug
  - id: dendro
    type:
      - 'null'
      - boolean
    doc: perform hierarchical clustering on the samples/haplotypes and visualize
      with dendrogram on sorted heatmap as output
    inputBinding:
      position: 101
      prefix: --dendro
  - id: fasta
    type:
      - 'null'
      - File
    doc: fasta reference file, required when input is BAM/CRAM files or 
      overviewtable with BAM/CRAM files
    inputBinding:
      position: 101
      prefix: --fasta
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: list with BAM/CRAM files or nanopolish (processed with 
      calculate_methylation_frequency.py) files
    inputBinding:
      position: 101
      prefix: --files
  - id: gff
    type: File
    doc: add annotation track based on GFF3 file
    inputBinding:
      position: 101
      prefix: --gff
  - id: groups
    type:
      - 'null'
      - type: array
        items: string
    doc: list of experimental group for each sample
    inputBinding:
      position: 101
      prefix: --groups
  - id: hapl
    type:
      - 'null'
      - boolean
    doc: display modification frequencies in input BAM/CRAM file for each 
      haplotype (alternating haplotypes in methylmap)
    inputBinding:
      position: 101
      prefix: --hapl
  - id: host
    type:
      - 'null'
      - string
    doc: Host IP used to serve the application
    inputBinding:
      position: 101
      prefix: --host
  - id: mod
    type:
      - 'null'
      - string
    doc: 'modified base of interest when BAM/CRAM files as input. Options are: m,
      h, default = m'
    default: m
    inputBinding:
      position: 101
      prefix: --mod
  - id: names
    type:
      - 'null'
      - type: array
        items: string
    doc: list with sample names
    inputBinding:
      position: 101
      prefix: --names
  - id: port
    type:
      - 'null'
      - int
    doc: Port used to serve the application
    inputBinding:
      position: 101
      prefix: --port
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: suppress modkit output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: simplify
    type:
      - 'null'
      - boolean
    doc: simplify annotation track to show genes rather than transcripts
    inputBinding:
      position: 101
      prefix: --simplify
  - id: table
    type:
      - 'null'
      - File
    doc: methfreqtable input
    inputBinding:
      position: 101
      prefix: --table
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use when processing BAM/CRAM files
    inputBinding:
      position: 101
      prefix: --threads
  - id: tsv
    type:
      - 'null'
      - File
    doc: overviewtable input
    inputBinding:
      position: 101
      prefix: --tsv
  - id: window
    type:
      - 'null'
      - string
    doc: 'region to visualise, format: chr:start-end (example: chr20:58839718-58911192)'
    inputBinding:
      position: 101
      prefix: --window
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: TSV file to write the frequencies to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylmap:0.5.11--pyhdfd78af_0
