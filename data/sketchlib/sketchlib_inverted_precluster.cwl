cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sketchlib
  - inverted
  - precluster
label: sketchlib_inverted_precluster
doc: "Use an inverted index to reduce query comparisons\n\nTool homepage: https://github.com/bacpop/sketchlib.rust"
inputs:
  - id: ski
    type: File
    secondaryFiles:
      - ^.skq
    doc: 'The inverted index (.ski) file used as the reference; the .skq file (build with --write-skq) must sit beside it'
    inputBinding:
      position: 1
  - id: skd
    type:
      - 'null'
      - File
    secondaryFiles:
      - ^.skd
    doc: The .skm file of a sketch database (its .skd file beside it); it must have the same samples and k-mer length as the .ski file. The tool takes the file prefix, so the .skm suffix is removed on the command line.
    inputBinding:
      position: 101
      prefix: --skd
      valueFrom: $(self.path.replace(/\.skm$/, ''))
  - id: count
    type:
      - 'null'
      - boolean
    doc: 'Do not run analysis, only return the number of comparisons'
    inputBinding:
      position: 101
      prefix: --count
  - id: knn
    type:
      - 'null'
      - int
    doc: 'Reduce to a maximum of k nearest-neighbours [default: 50]'
    inputBinding:
      position: 101
      prefix: --knn
  - id: ani
    type:
      - 'null'
      - boolean
    doc: 'Calculate ANI rather than Jaccard dists, using Poisson model'
    inputBinding:
      position: 101
      prefix: --ani
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU threads [default: 1]'
    inputBinding:
      position: 101
      prefix: --threads
  - id: completeness_file
    type:
      - 'null'
      - File
    doc: 'Completeness file'
    inputBinding:
      position: 101
      prefix: --completeness-file
  - id: completeness_cutoff
    type:
      - 'null'
      - float
    doc: 'Minimum completeness for a sample to be corrected but the completeness correction [default: 0.64]'
    inputBinding:
      position: 101
      prefix: --completeness-cutoff
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Don''t show any messages'
    inputBinding:
      position: 101
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Show progress messages'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: output_path
    type:
      - 'null'
      - string
    doc: 'Output filename (omit to output to stdout)'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Pre-clustered comparison pairs
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchlib:0.2.4--h4349ce8_0
