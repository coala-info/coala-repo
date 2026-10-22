cwlVersion: v1.2
class: CommandLineTool
baseCommand: slclust
label: slclust
doc: "Single linkage clustering of pairs, with a Jaccard coefficient to split loosely
  connected clusters. Reads pairs (two identifiers per line) from standard input and
  writes one cluster per line to standard output.\n\nTool homepage: https://github.com/brianjohnhaas/SLCLUST"
inputs:
  - id: file_of_pairs
    type: File
    doc: File of pairs to cluster (two whitespace-separated identifiers per line)
  - id: jaccard_coefficient
    type: ['null', float]
    doc: Jaccard coefficient threshold for clustering
    inputBinding:
      position: 1
      prefix: -j
  - id: min_links_for_jaccard
    type: ['null', int]
    doc: Minimum number of links for the Jaccard coefficient to apply (not shown in the help; used in the tool's own tests)
    inputBinding:
      position: 1
      prefix: --min_links_for_J
  - id: verbose
    type: ['null', boolean]
    doc: Verbosity at 'info'
    inputBinding:
      position: 1
      prefix: -v
  - id: very_verbose
    type: ['null', boolean]
    doc: Verbosity at 'debug'
    inputBinding:
      position: 1
      prefix: -vv
stdin: $(inputs.file_of_pairs.path)
stdout: clusters.txt
outputs:
  - id: clusters
    type: File
    doc: Clusters, one per line
    outputBinding:
      glob: clusters.txt
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/slclust:02022010--h077b44d_6
