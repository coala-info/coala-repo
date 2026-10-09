cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mantis
  - stats
label: mantis_stats
doc: 'Compute statistics of a mantis index (mono, cc_density, color_dist or jmerkmer).
  The mono and color_dist statistics are written to mcc_dist.out and color_dist.out
  inside the index directory; cc_density prints to standard output.


  Tool homepage: https://github.com/splatlab/mantis'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.index_prefix)
        writable: true
inputs:
  - id: index_prefix
    type: Directory
    doc: The directory where the index is stored; staged writable because the statistics
      files are written into it
    inputBinding:
      position: 2
      prefix: -p
      valueFrom: $(self.basename)/
  - id: number_of_samples
    type: int
    doc: Number of experiments (samples) in the index
    inputBinding:
      position: 3
      prefix: -n
  - id: stats_type
    type:
      - 'null'
      - string
    doc: 'what stats? (mono, cc_density, color_dist, jmerkmer), default: mono'
    inputBinding:
      position: 4
      prefix: -t
  - id: size_of_jmer
    type:
      - 'null'
      - int
    doc: 'value of j for constituent jmers of a kmer (default: 23)'
    inputBinding:
      position: 5
      prefix: -j
outputs:
  - id: mcc_dist
    type:
      - 'null'
      - File
    doc: Statistics of the mono type
    outputBinding:
      glob: $(inputs.index_prefix.basename)/mcc_dist.out
  - id: color_dist
    type:
      - 'null'
      - File
    doc: Statistics of the color_dist type
    outputBinding:
      glob: $(inputs.index_prefix.basename)/color_dist.out
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
stdout: mantis_stats.out
