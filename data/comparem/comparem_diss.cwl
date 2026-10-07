cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comparem
  - diss
label: comparem_diss
doc: "Calculate the dissimilarity between usage profiles.\n\nTool homepage: https://github.com/dparks1134/CompareM"
inputs:
  - id: profile_file
    type: File
    doc: "file with usage profile for each genome"
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: "output file with pairwise dissimilarity between genomes"
    inputBinding:
      position: 2
  - id: metric
    type:
      - 'null'
      - string
    doc: "distance metric to use: euclidean, minkowski, cityblock, seuclidean, sqeuclidean, cosine, correlation, hamming, jaccard, chebyshev, canberra, braycurtis, mahalanobis, yule, matching, dice, kulsinski, rogerstanimoto, russellrao, sokalmichener, sokalsneath, wminkowski (default: euclidean)"
    inputBinding:
      position: 101
      prefix: --metric
  - id: full_matrix
    type:
      - 'null'
      - boolean
    doc: "output full dissimilarity matrix"
    inputBinding:
      position: 101
      prefix: --full_matrix
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "suppress output"
    inputBinding:
      position: 101
      prefix: --silent
outputs:
  - id: output
    type: File
    doc: "pairwise dissimilarity between genomes"
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comparem:0.1.2--py_0
