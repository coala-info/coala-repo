cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaptamer_enrich
label: fastaptamer_fastaptamer_enrich
doc: "FASTAptamer-Enrich rapidly calculates fold-enrichment values for each sequence
  across two or three input files. Output is provided as a tab-delimited plain text
  file and is formatted to include sequence composition, length, rank, reads, reads
  per million (RPM), and enrichment values for each sequence. If any files from FASTAptamer-Cluster
  are provided, output will include cluster information for that population. A threshold
  filter can be applied to exclude sequences with total reads per million (across
  all input populations) less than the number entered after the [-f] option. Default
  behavior is to include all sequences. Enrichment is calculated by dividing reads
  per million of y/x (and z/y and z/x, if a third input file is specified).\n\nTool
  homepage: http://burkelab.missouri.edu/fastaptamer.html"
inputs:
  - id: first_input_file
    type: File
    doc: First input file from FASTAptamer-Count or FASTAptamer-Cluster.
    inputBinding:
      position: 101
      prefix: -x
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: Quiet mode. Suppresses standard output of file I/O, number of matched 
      sequences and execution time.
    inputBinding:
      position: 101
      prefix: -q
  - id: reads_per_million_threshold
    type:
      - 'null'
      - int
    doc: Optional reads per million threshold filter.
    inputBinding:
      position: 101
      prefix: -f
  - id: second_input_file
    type: File
    doc: Second input file from FASTAptamer-Count or FASTAptamer-Cluster. *** 
      For two populations only, use -x and -y. ***
    inputBinding:
      position: 101
      prefix: -y
  - id: third_input_file
    type:
      - 'null'
      - File
    doc: Optional third input file from FASTAptamer-Count or 
      FASTAptamer-Cluster.
    inputBinding:
      position: 101
      prefix: -z
outputs:
  - id: output_file
    type: File
    doc: Plain text output file with tab separated values.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
