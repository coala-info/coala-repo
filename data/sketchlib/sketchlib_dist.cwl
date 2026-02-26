cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sketchlib
  - dist
label: sketchlib_dist
doc: "Calculate pairwise distances using sketches\n\nTool homepage: https://github.com/bacpop/sketchlib.rust"
inputs:
  - id: ref_db
    type: File
    doc: The .skm file used as the reference
    inputBinding:
      position: 1
  - id: query_db
    type:
      - 'null'
      - File
    doc: The .skm file used as the query (omit for ref v ref)
    inputBinding:
      position: 2
  - id: ani
    type:
      - 'null'
      - boolean
    doc: Calculate ANI rather than Jaccard dists, using Poisson model
    inputBinding:
      position: 103
      prefix: --ani
  - id: completeness_cutoff
    type:
      - 'null'
      - float
    doc: minimum completeness for a sample to be corrected but the completeness 
      correction
    default: 0.64
    inputBinding:
      position: 103
      prefix: --completeness-cutoff
  - id: completeness_file
    type:
      - 'null'
      - File
    doc: File listing sample and completeness estimate 0.0-1.0 (tab separated)
    inputBinding:
      position: 103
      prefix: --completeness-file
  - id: kmer
    type:
      - 'null'
      - int
    doc: K-mer length (if provided only calculate Jaccard distance)
    inputBinding:
      position: 103
      prefix: -k
  - id: knn
    type:
      - 'null'
      - int
    doc: Calculate sparse distances with k nearest-neighbours
    inputBinding:
      position: 103
      prefix: --knn
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Don't show any messages
    inputBinding:
      position: 103
      prefix: --quiet
  - id: subset
    type:
      - 'null'
      - string
    doc: Sample names to analyse
    inputBinding:
      position: 103
      prefix: --subset
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads
    default: 1
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show progress messages
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_filename
    type:
      - 'null'
      - File
    doc: Output filename (omit to output to stdout)
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
