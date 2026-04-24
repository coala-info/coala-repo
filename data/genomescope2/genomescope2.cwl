cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomescope2
label: genomescope2
doc: "Reference-free profiling of polyploid genomes from k-mer frequencies.\n\nTool
  homepage: https://github.com/tbenavi1/genomescope2.0"
inputs:
  - id: input
    type: File
    doc: Input histogram file from KMC or Jellyfish
    inputBinding:
      position: 101
      prefix: --input
  - id: kmer_size
    type: int
    doc: K-mer size used to generate the histogram
    inputBinding:
      position: 101
      prefix: --kmer_size
  - id: lambda
    type:
      - 'null'
      - int
    doc: Initial guess for the average k-mer coverage (lambda)
    inputBinding:
      position: 101
      prefix: --lambda
  - id: max_kmer_cov
    type:
      - 'null'
      - int
    doc: Maximum k-mer coverage to consider
    inputBinding:
      position: 101
      prefix: --max_kmer_cov
  - id: name
    type:
      - 'null'
      - string
    doc: Name of the run for output files
    inputBinding:
      position: 101
      prefix: --name
  - id: ploidy
    type:
      - 'null'
      - int
    doc: Ploidy of the genome
    inputBinding:
      position: 101
      prefix: --ploidy
  - id: testing
    type:
      - 'null'
      - boolean
    doc: Run in testing mode
    inputBinding:
      position: 101
      prefix: --testing
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomescope2:2.1.0--py313r44hdfd78af_0
