cwlVersion: v1.2
class: CommandLineTool
baseCommand: strainge_cluster
label: strainge_cluster
doc: "Group k-mer sets that are very similar to each other together.\n\nTool homepage:
  The package home page"
inputs:
  - id: kmerset
    type:
      type: array
      items: File
    doc: The list of HDF5 filenames of k-mer sets to cluster.
    inputBinding:
      position: 1
  - id: contained_cutoff
    type:
      - 'null'
      - float
    doc: Minimum fraction of kmers to be present in another genome to discard 
      it.
    inputBinding:
      position: 102
      prefix: --contained-cutoff
  - id: cutoff
    type:
      - 'null'
      - float
    doc: Minimum similarity between two sets to group them together.
    inputBinding:
      position: 102
      prefix: --cutoff
  - id: discard_contained
    type:
      - 'null'
      - boolean
    doc: Discard k-mersets that are a subset of another k-merset. Requires 
      'subset' scoring metric in the similarity scores TSV files.
    inputBinding:
      position: 102
      prefix: --discard-contained
  - id: priorities
    type:
      - 'null'
      - File
    doc: An optional TSV file where the first column represents the ID of a 
      reference kmerset, and the second an integer indicating the priority for 
      clustering. References with higher priority get precedence over references
      with lower priority in the same cluster.
    inputBinding:
      position: 102
      prefix: --priorities
  - id: similarity_scores
    type:
      - 'null'
      - File
    doc: The file with the similarity scores between kmersets (the output of 
      'strainge compare --all-vs-all'). Defaults to standard input.
    inputBinding:
      position: 102
      prefix: --similarity-scores
  - id: warn_too_distant
    type:
      - 'null'
      - float
    doc: 'Warn when including references that that seem too distantly related, which
      could indicate a mislabeled reference genome. Default: 85% ANI.'
    default: 85.0
    inputBinding:
      position: 102
      prefix: --warn-too-distant
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The file where the list of kmersets to keep after clustering gets 
      written. Defaults to standard output.
    outputBinding:
      glob: $(inputs.output)
  - id: clusters_out
    type:
      - 'null'
      - File
    doc: Output an optional tab separated file with all clusters and their 
      entries.
    outputBinding:
      glob: $(inputs.clusters_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
