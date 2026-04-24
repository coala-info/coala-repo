cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi similarity
label: odgi_similarity
doc: "Provides a sparse similarity matrix for paths or groups of paths. Each line
  prints in a tab-delimited format to stdout.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Emit entries for all pairs of paths/groups, including those with zero 
      intersection.
    inputBinding:
      position: 101
      prefix: --all
  - id: delim
    type:
      - 'null'
      - string
    doc: The part of each path name before this delimiter CHAR is a group 
      identifier.
    inputBinding:
      position: 101
      prefix: --delim
  - id: delim_pos
    type:
      - 'null'
      - int
    doc: Consider the N-th occurrence of the delimiter specified with **-D, 
      --delim** to obtain the group identifier. Specify 1 for the 1st occurrence
      (default).
    inputBinding:
      position: 101
      prefix: --delim-pos
  - id: distances
    type:
      - 'null'
      - boolean
    doc: Provide distances (dissimilarities) instead of similarities. Outputs 
      additional columns with the Euclidean and Manhattan distances.
    inputBinding:
      position: 101
      prefix: --distances
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: mask
    type:
      - 'null'
      - File
    doc: Load node mask from this file. Each line contains a 0 or 1, where 0 
      means the node at that position should be ignored in similarity 
      computation.
    inputBinding:
      position: 101
      prefix: --mask
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_similarity.out
