cwlVersion: v1.2
class: CommandLineTool
baseCommand: afragmenter
label: afragmenter
doc: "A tool for clustering and fragmenting protein structures based on AlphaFold
  PAE data using Leiden clustering.\n\nTool homepage: https://github.com/sverwimp/AFragmenter"
inputs:
  - id: afdb
    type:
      - 'null'
      - string
    doc: 'Uniprot identifier to fetch data from the AlphaFold database [required:
      either --json or --afdb]'
    inputBinding:
      position: 101
      prefix: --afdb
  - id: json
    type:
      - 'null'
      - File
    doc: 'Path to the AlphaFold json file containing the PAE data [required: either
      --json or --afdb]'
    inputBinding:
      position: 101
      prefix: --json
  - id: min_avg_pae
    type:
      - 'null'
      - float
    doc: Minimum average PAE for a cluster to be kept.
    inputBinding:
      position: 101
      prefix: --min-avg-pae
  - id: min_size
    type:
      - 'null'
      - int
    doc: Minimum size of partition to be considered. Attempts to merge 
      partitions that are too small with adjecent larger ones.
    default: 10
    inputBinding:
      position: 101
      prefix: --min-size
  - id: n_iterations
    type:
      - 'null'
      - int
    doc: Number of iterations for Leiden clustering. Negative values will run 
      the algorithm until a stable iteration is reached
    default: -1
    inputBinding:
      position: 101
      prefix: --n-iterations
  - id: name
    type:
      - 'null'
      - string
    doc: Name used to format fasta header and first column of the result table. 
      Will be parsed from the structure file (if available) if set to 'auto'.
    default: auto
    inputBinding:
      position: 101
      prefix: --name
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: Do not attempt to merge small partitions with larger paritions, just 
      discard them
    inputBinding:
      position: 101
      prefix: --no-merge
  - id: objective_function
    type:
      - 'null'
      - string
    doc: Objective function for Leiden clustering (not case sensitive) 
      [modularity|cpm]
    default: modularity
    inputBinding:
      position: 101
      prefix: --objective-function
  - id: resolution
    type:
      - 'null'
      - float
    doc: 'Resolution used with Leiden clustering [default: 0.7 for modularity, 0.3
      for CPM]'
    inputBinding:
      position: 101
      prefix: --resolution
  - id: structure
    type:
      - 'null'
      - File
    doc: Path to a PDB or mmCIF file containing the protein structure and 
      sequence
    inputBinding:
      position: 101
      prefix: --structure
  - id: threshold
    type:
      - 'null'
      - float
    doc: Contrast thresold for the PAE values. This is a soft cut-off point to 
      increase the contrast between low and high PAE values.
    default: 2
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: save_result
    type:
      - 'null'
      - File
    doc: Path to save the result table (csv) file. If not set, the result will 
      be printed to the console
    outputBinding:
      glob: $(inputs.save_result)
  - id: plot_result
    type:
      - 'null'
      - File
    doc: Path to save the result plot
    outputBinding:
      glob: $(inputs.plot_result)
  - id: save_fasta
    type:
      - 'null'
      - File
    doc: Path to save the output fasta file (requires --structure if using 
      --json)
    outputBinding:
      glob: $(inputs.save_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/afragmenter:0.0.6--pyhdfd78af_0
