cwlVersion: v1.2
class: CommandLineTool
baseCommand: psdm
label: psdm
doc: "Compute a pairwise SNP distance matrix from one or two alignment(s)\n\nTool
  homepage: https://github.com/mbhall88/psdm"
inputs:
  - id: alignments
    type:
      - 'null'
      - type: array
        items: File
    doc: FASTA alignment file(s) to compute the pairwise distance for. Providing
      two files will compute the distances for all sequences in one file against
      all sequences from the other file.
    inputBinding:
      position: 1
  - id: case_sensitive
    type:
      - 'null'
      - boolean
    doc: Case matters - i.e., dist(a, A) = 1
    inputBinding:
      position: 102
      prefix: --case-sensitive
  - id: delim
    type:
      - 'null'
      - string
    doc: Delimiting character for the output table
    inputBinding:
      position: 102
      prefix: --delim
  - id: ignored_chars
    type:
      - 'null'
      - string
    doc: String of characters to ignore - e.g., `-e N-` -> dist(A, N) = 0 and 
      dist(A, -) = 0
    inputBinding:
      position: 102
      prefix: --ignored-chars
  - id: long
    type:
      - 'null'
      - boolean
    doc: Output as long-form ("melted") table
    inputBinding:
      position: 102
      prefix: --long
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Show a progress bar
    inputBinding:
      position: 102
      prefix: --progress
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: No logging (except progress info if `-P` is given)
    inputBinding:
      position: 102
      prefix: --quiet
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Sort the alignment(s) by ID
    inputBinding:
      position: 102
      prefix: --sort
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. Setting to 0 will use all available
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psdm:0.3.0--hc1c3326_2
