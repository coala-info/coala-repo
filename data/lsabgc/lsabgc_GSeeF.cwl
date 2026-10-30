cwlVersion: v1.2
class: CommandLineTool
baseCommand: GSeeF
label: lsabgc_GSeeF
doc: "Create an interactive view of gene cluster families (GCFs) along a species tree from the lsaBGC-Pan detailed listing.\n\nTool homepage: https://github.com/Kalan-Lab/lsaBGC-Pan"
inputs:
  - id: lsabgc_detailed_listing
    type: File
    doc: "lsaBGC-Pan detailed listing with GCF and population structure information."
    inputBinding:
      position: 1
      prefix: --lsabgc_detailed_listing
  - id: species_tree
    type: File
    doc: "Provide species tree in Newick format."
    inputBinding:
      position: 1
      prefix: --species_tree
  - id: output_directory
    type: string
    doc: "Parent output/workspace directory. The directory is created in the working directory."
    inputBinding:
      position: 1
      prefix: --output_directory
  - id: max_gcfs
    type:
      - 'null'
      - int
    doc: "The maximum number of GCFs to consider (will prioritize inclusion of more common GCFs). (Default is no limit)."
    inputBinding:
      position: 1
      prefix: --max_gcfs
  - id: staged_dirs
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Directories that hold the files named in the listing inputs, for example the lsaBGC-Pan results. They are staged in the working directory /w, so the absolute /w/... paths in the lsaBGC-Pan listings resolve. The lsaBGC-Pan results must be staged at /w as in the lsaBGC-Pan run.
  - id: gecco_domain_weights
    type:
      - 'null'
      - File
    doc: GECCO_PF_Weights.pkl file, needed when the BGCs were predicted by GECCO. It is passed to the program in the environment variable GECCO_DOMAIN_WEIGHTS_PKL_FILE.
outputs:
  - id: output_directory_dir
    type: Directory
    doc: Results directory written with --output_directory.
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: GECCO_DOMAIN_WEIGHTS_PKL_FILE
        envValue: "$(inputs.gecco_domain_weights ? inputs.gecco_domain_weights.path : '')"
  - class: InitialWorkDirRequirement
    listing: "$(inputs.staged_dirs ? inputs.staged_dirs : [])"
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsabgc:1.1.10--pyhdfd78af_0
    dockerOutputDirectory: /w
