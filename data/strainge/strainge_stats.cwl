cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- strainge
- stats
label: strainge_stats
doc: 'Obtain statistics about a given k-mer set.


  Tool homepage: https://github.com/broadinstitute/strainge'
inputs:
- id: kmerset
  type: File
  doc: The K-mer set to load
  inputBinding:
    position: 100
- id: k
  type:
  - 'null'
  - boolean
  doc: Output k-mer size.
  inputBinding:
    position: 1
    prefix: -k
- id: counts
  type:
  - 'null'
  - boolean
  doc: Output the list of k-mers in this set with corresponding counts.
  inputBinding:
    position: 1
    prefix: --counts
- id: histogram
  type:
  - 'null'
  - boolean
  doc: Write the k-mer frequency histogram to output.
  inputBinding:
    position: 1
    prefix: --histogram
- id: entropy
  type:
  - 'null'
  - boolean
  doc: Calculate Shannon entropy in bases and write to output.
  inputBinding:
    position: 1
    prefix: --entropy
- id: output
  type:
  - 'null'
  - string
  doc: Output file, defaults to standard output.
  inputBinding:
    position: 1
    prefix: --output
outputs:
- id: output_result
  type:
  - 'null'
  - File
  doc: Output file, defaults to standard output.
  outputBinding:
    glob: $(inputs.output)
- id: stdout
  type: stdout
  doc: Standard output
stdout: strainge_stats.stdout.txt
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/strainge:1.3.9--py38h737be40_0
