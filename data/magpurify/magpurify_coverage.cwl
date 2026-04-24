cwlVersion: v1.2
class: CommandLineTool
baseCommand: magpurify_coverage
label: magpurify_coverage
doc: "Find contigs with outlier coverage profile.\n\nTool homepage: https://github.com/snayfach/MAGpurify"
inputs:
  - id: fna
    type: File
    doc: Path to input genome in FASTA format
    inputBinding:
      position: 1
  - id: out
    type: Directory
    doc: Output directory to store results and intermediate files
    inputBinding:
      position: 2
  - id: bams
    type:
      type: array
      items: File
    doc: Path to input sorted BAM file(s)
    inputBinding:
      position: 3
  - id: max_deviation
    type:
      - 'null'
      - float
    doc: Contigs with coverage greater than [max-deviation * mean coverage] or 
      less than [(1/max-deviation) * mean coverage] will be flagged as outliers
    inputBinding:
      position: 104
      prefix: --max-deviation
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    inputBinding:
      position: 104
      prefix: --threads
  - id: weighted_mean
    type:
      - 'null'
      - boolean
    doc: Compute the mean weighted by the contig length
    inputBinding:
      position: 104
      prefix: --weighted-mean
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2
stdout: magpurify_coverage.out
