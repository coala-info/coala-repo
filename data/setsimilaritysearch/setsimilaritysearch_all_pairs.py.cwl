cwlVersion: v1.2
class: CommandLineTool
baseCommand: setsimilaritysearch_all_pairs.py
label: setsimilaritysearch_all_pairs.py
doc: "Find all pairs of sets with similarities over a given threshold.\n\nTool homepage:
  https://github.com/ekzhu/SetSimilaritySearch"
inputs:
  - id: input_sets
    type:
      type: array
      items: File
    doc: 'Input flattened set files with each line a (SetID Token) tuple: 1 file for
      finding self all pairs (self- join); 2 files for finding cross-collection all
      pairs (join).'
    inputBinding:
      position: 101
      prefix: --input-sets
  - id: reversed_tuple
    type:
      - 'null'
      - boolean
    doc: Whether the input tuples are reversed i.e. (Token SetID).
    inputBinding:
      position: 101
      prefix: --reversed-tuple
  - id: sample_k
    type:
      - 'null'
      - int
    doc: The number of sampled sets from the second file to use as queries; 
      default use all sets.
    inputBinding:
      position: 101
      prefix: --sample-k
  - id: similarity_func
    type:
      - 'null'
      - string
    doc: Similarity function to use.
    inputBinding:
      position: 101
      prefix: --similarity-func
  - id: similarity_threshold
    type:
      - 'null'
      - float
    doc: Minimum similarity threshold for pairs.
    inputBinding:
      position: 101
      prefix: --similarity-threshold
outputs:
  - id: output_pairs
    type: File
    doc: Output file with each line a (SetID_X, SetID_Y, Size_X, Size_Y, 
      Similarity) tuple.
    outputBinding:
      glob: $(inputs.output_pairs)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/setsimilaritysearch:1.0.0
