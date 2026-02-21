cwlVersion: v1.2
class: CommandLineTool
baseCommand: covar
label: covar
doc: "Calls physically-linked mutation clusters from wastewater amplicon sequencing
  data\n\nTool homepage: https://github.com/andersen-lab/covar"
inputs:
  - id: annotation
    type: File
    doc: Annotation GFF3 file. Used for translating mutations to respective amino
      acid mutation
    inputBinding:
      position: 101
      prefix: --annotation
  - id: end_site
    type:
      - 'null'
      - int
    doc: Genomic end site for variant calling. Defaults to the length of the reference
      genome
    inputBinding:
      position: 101
      prefix: --end_site
  - id: input
    type: File
    doc: Input BAM file (must be primer trimmed, sorted and indexed)
    inputBinding:
      position: 101
      prefix: --input
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum coverage depth for a mutation cluster to be considered
    default: 1
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_frequency
    type:
      - 'null'
      - float
    doc: Minimum frequency (cluster depth / total depth) to include a cluster in output
    default: 0.001
    inputBinding:
      position: 101
      prefix: --min_frequency
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality for variant calling
    default: 20
    inputBinding:
      position: 101
      prefix: --min_quality
  - id: reference
    type: File
    doc: Reference genome FASTA file
    inputBinding:
      position: 101
      prefix: --reference
  - id: start_site
    type:
      - 'null'
      - int
    doc: Genomic start site for variant calling
    default: 0
    inputBinding:
      position: 101
      prefix: --start_site
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to spawn for variant calling
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Optional output file path. If not provided, output will be printed to stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/covar:0.3.0--h3dc2dae_0
