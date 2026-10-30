cwlVersion: v1.2
class: CommandLineTool
baseCommand: popstrat
label: lsabgc_popstrat
doc: "Define populations from the ortholog group alignment (average amino acid identity cutoff) and show them on the species tree.\n\nTool homepage: https://github.com/Kalan-Lab/lsaBGC-Pan"
inputs:
  - id: alignment
    type: File
    doc: "The processed orthogroup by sample matrix."
    inputBinding:
      position: 1
      prefix: --alignment
  - id: phylogeny
    type:
      - 'null'
      - File
    doc: "A newick file describing the species tree (can be produced by phylogenate)."
    inputBinding:
      position: 1
      prefix: --phylogeny
  - id: output_directory
    type: string
    doc: "Parent output/workspace directory. The directory is created in the working directory."
    inputBinding:
      position: 1
      prefix: --output_directory
  - id: test_parameters
    type:
      - 'null'
      - boolean
    doc: "Test cutoffs for AAI for grouping populations and create visuals showing them."
    inputBinding:
      position: 1
      prefix: --test_parameters
  - id: identity_cutoff
    type:
      - 'null'
      - float
    doc: "The AAI between [Default is 99.0]."
    inputBinding:
      position: 1
      prefix: --identity_cutoff
  - id: skip_midpoint
    type:
      - 'null'
      - boolean
    doc: "Skip midpoint rooting of phylogeny - note tree should be rooted in some way for visualization!."
    inputBinding:
      position: 1
      prefix: --skip_midpoint
  - id: staged_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Directories that hold the files named in the listing inputs, for example the lsaBGC-Pan results. They are staged in the working directory so relative paths in the listings resolve.
outputs:
  - id: output_directory_dir
    type: Directory
    doc: Results directory written with --output_directory.
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.staged_dirs ? inputs.staged_dirs : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsabgc:1.1.10--pyhdfd78af_0
