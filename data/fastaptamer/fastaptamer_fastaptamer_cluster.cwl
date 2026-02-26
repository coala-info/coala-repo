cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaptamer_cluster
label: fastaptamer_fastaptamer_cluster
doc: "FASTAptamer-Cluster uses the Levenshtein algorithm to cluster together sequences
  based on a user-defined edit distance. The most abundant and unclustered sequence
  is used as the \"seed sequence\" for which edit distance is calculated from.\n\n\
  Tool homepage: http://burkelab.missouri.edu/fastaptamer.html"
inputs:
  - id: edit_distance
    type: int
    doc: Edit distance for clustering sequences. REQUIRED.
    inputBinding:
      position: 101
      prefix: -d
  - id: input_file
    type: File
    doc: Input file from FASTAptamer-Count. REQUIRED.
    inputBinding:
      position: 101
      prefix: -i
  - id: max_clusters
    type:
      - 'null'
      - int
    doc: Maximum number of clusters to find.
    inputBinding:
      position: 101
      prefix: -c
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: Quiet mode. Suppresses standard output of file I/O, number of clusters,
      cluster size and execution time.
    inputBinding:
      position: 101
      prefix: -q
  - id: read_filter
    type:
      - 'null'
      - int
    doc: Read filter. Only sequences with total reads greater than the value 
      supplied will be clustered.
    inputBinding:
      position: 101
      prefix: -f
outputs:
  - id: output_file
    type: File
    doc: Output file, FASTA format. REQUIRED.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
