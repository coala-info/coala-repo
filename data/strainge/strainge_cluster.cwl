cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- strainge
- cluster
label: strainge_cluster
doc: 'Group k-mer sets that are very similar to each other together.


  Tool homepage: https://github.com/broadinstitute/strainge'
inputs:
- id: kmerset
  type: File[]
  doc: The list of HDF5 filenames of k-mer sets to cluster.
  inputBinding:
    position: 100
- id: cutoff
  type:
  - 'null'
  - float
  doc: Minimum similarity between two sets to group them together.
  inputBinding:
    position: 1
    prefix: --cutoff
- id: similarity_scores
  type:
  - 'null'
  - File
  doc: The file with the similarity scores between kmersets (the output of 'strainge compare --all-vs-all'). Defaults to standard input.
  inputBinding:
    position: 1
    prefix: --similarity-scores
- id: discard_contained
  type:
  - 'null'
  - boolean
  doc: Discard k-mersets that are a subset of another k-merset. Requires 'subset' scoring metric in the similarity scores TSV files.
  inputBinding:
    position: 1
    prefix: --discard-contained
- id: contained_cutoff
  type:
  - 'null'
  - float
  doc: Minimum fraction of kmers to be present in another genome to discard it.
  inputBinding:
    position: 1
    prefix: --contained-cutoff
- id: warn_too_distant
  type:
  - 'null'
  - float
  doc: 'Warn when including references that that seem too distantly related, which could indicate a mislabeled reference genome. Default: 85% ANI.'
  inputBinding:
    position: 1
    prefix: --warn-too-distant
- id: priorities
  type:
  - 'null'
  - File
  doc: An optional TSV file where the first column represents the ID of a reference kmerset, and the second an integer indicating the priority for clustering. References with higher priority get precedence over references with lower priority in the same cluster.
  inputBinding:
    position: 1
    prefix: --priorities
- id: output
  type:
  - 'null'
  - string
  doc: The file where the list of kmersets to keep after clustering gets written. Defaults to standard output.
  inputBinding:
    position: 1
    prefix: --output
- id: clusters_out
  type:
  - 'null'
  - string
  doc: Output an optional tab separated file with all clusters and their entries.
  inputBinding:
    position: 1
    prefix: --clusters-out
outputs:
- id: output_result
  type:
  - 'null'
  - File
  doc: The file where the list of kmersets to keep after clustering gets written. Defaults to standard output.
  outputBinding:
    glob: $(inputs.output)
- id: clusters_out_result
  type:
  - 'null'
  - File
  doc: Output an optional tab separated file with all clusters and their entries.
  outputBinding:
    glob: $(inputs.clusters_out)
- id: stdout
  type: stdout
  doc: Standard output
stdout: strainge_cluster.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
