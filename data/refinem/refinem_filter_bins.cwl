cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - refinem
  - filter_bins
label: refinem_filter_bins
doc: "Remove scaffolds across a set of bins.\n\nTool homepage: http://pypi.python.org/pypi/refinem/"
inputs:
  - id: genome_nt_dir
    type: Directory
    doc: directory containing nucleotide scaffolds for each genome
    inputBinding:
      position: 1
  - id: filter_file
    type: File
    doc: file specifying scaffolds to remove
    inputBinding:
      position: 2
  - id: genome_ext
    type:
      - 'null'
      - string
    doc: extension of genomes (other files in directory are ignored)
    default: fna
    inputBinding:
      position: 103
      prefix: --genome_ext
  - id: modified_only
    type:
      - 'null'
      - boolean
    doc: only copy modified bins to the output folder
    inputBinding:
      position: 103
      prefix: --modified_only
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output of logger
    inputBinding:
      position: 103
      prefix: --silent
outputs:
  - id: output_dir
    type: Directory
    doc: output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
