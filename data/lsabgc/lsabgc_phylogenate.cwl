cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylogenate
label: lsabgc_phylogenate
doc: "Build a species phylogeny from single-copy core ortholog groups (alignment with MUSCLE and tree with FastTree2 or IQ-TREE).\n\nTool homepage: https://github.com/Kalan-Lab/lsaBGC-Pan"
inputs:
  - id: orthogroup_matrix
    type:
      - 'null'
      - File
    doc: "Processed orthogroup by sample matrix."
    inputBinding:
      position: 1
      prefix: --orthogroup_matrix
  - id: genome_genbanks
    type:
      - 'null'
      - File
    doc: "A listing connecting sample names to full-genome GenBank files."
    inputBinding:
      position: 1
      prefix: --genome_genbanks
  - id: core_proportion
    type:
      - 'null'
      - float
    doc: "Proportion of genomes with single-copy orthogroup needed to be considered as part of core and used for phylogeny construction [Default is 1.0]."
    inputBinding:
      position: 1
      prefix: --core_proportion
  - id: max_genes
    type:
      - 'null'
      - int
    doc: "The maximum number of single-copy core/near-core orthogroups to use for phylogeny building [Default is 500]."
    inputBinding:
      position: 1
      prefix: --max_genes
  - id: output_directory
    type: string
    doc: "Parent output/workspace directory. The directory is created in the working directory."
    inputBinding:
      position: 1
      prefix: --output_directory
  - id: high_quality
    type:
      - 'null'
      - boolean
    doc: "Prioritize phylogeny accuracy over speed of construction. Uses muscle align instead of muscle super5 and IQ-TREE instead of FastTree2."
    inputBinding:
      position: 1
      prefix: --high_quality
  - id: threads
    type:
      - 'null'
      - int
    doc: "Total number of threads/threads. Note, this is the total number of threads to use. (Default is 1)."
    inputBinding:
      position: 1
      prefix: --threads
  - id: staged_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Directories that hold the files named in the listing inputs, for example the lsaBGC-Pan results. They are staged in the working directory /w, so the absolute /w/... paths in the lsaBGC-Pan listings resolve. The lsaBGC-Pan results must be staged at /w as in the lsaBGC-Pan run.
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
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsabgc:1.1.10--pyhdfd78af_0
    dockerOutputDirectory: /w
