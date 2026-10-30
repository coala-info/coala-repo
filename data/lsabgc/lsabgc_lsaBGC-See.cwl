cwlVersion: v1.2
class: CommandLineTool
baseCommand: lsaBGC-See
label: lsabgc_lsaBGC-See
doc: "Create a visual for one gene cluster family (GCF), with gene schematics, ortholog groups and, optionally, a GCF phylogeny.\n\nTool homepage: https://github.com/Kalan-Lab/lsaBGC-Pan"
inputs:
  - id: gcf_id
    type: string
    doc: "Focal GCF identifier."
    inputBinding:
      position: 1
      prefix: --gcf_id
  - id: lsabgc_detailed_listing
    type: File
    doc: "lsaBGC-Pan detailed listing with GCF and population structure information."
    inputBinding:
      position: 1
      prefix: --lsabgc_detailed_listing
  - id: orthomatrix
    type: File
    doc: "OrthoFinder/Panaroo ortholog by sample matrix."
    inputBinding:
      position: 1
      prefix: --orthomatrix
  - id: output_directory
    type: string
    doc: "Output directory. The directory is created in the working directory."
    inputBinding:
      position: 1
      prefix: --output_directory
  - id: species_phylogeny
    type:
      - 'null'
      - File
    doc: "The species phylogeny in Newick format."
    inputBinding:
      position: 1
      prefix: --species_phylogeny
  - id: create_gcf_phylogeny
    type:
      - 'null'
      - boolean
    doc: "Create phylogeny from sequences of homolog groups in GCF."
    inputBinding:
      position: 1
      prefix: --create_gcf_phylogeny
  - id: only_scc
    type:
      - 'null'
      - boolean
    doc: "Use only single-copy-core homolog groups for constructing GCF phylogeny."
    inputBinding:
      position: 1
      prefix: --only_scc
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for MCL step [Default is 1]."
    inputBinding:
      position: 1
      prefix: --threads
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
