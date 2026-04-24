cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis
label: mantis_stats
doc: "Mantis is a k-mer based de Bruijn graph construction and querying tool.\n\n\
  Tool homepage: https://github.com/splatlab/mantis"
inputs:
  - id: index_prefix
    type: Directory
    doc: The directory where the index is stored.
    inputBinding:
      position: 101
      prefix: --index_prefix
  - id: number_of_samples
    type: int
    doc: Number of experiments.
    inputBinding:
      position: 101
      prefix: --number_of_samples
  - id: size_of_jmer
    type:
      - 'null'
      - int
    doc: value of j for constituent jmers of a kmer
    inputBinding:
      position: 101
      prefix: --size-of-jmer
  - id: stats_type
    type:
      - 'null'
      - string
    doc: what stats? (mono, cc_density, color_dist, jmerkmer)
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
stdout: mantis_stats.out
