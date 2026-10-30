cwlVersion: v1.2
class: CommandLineTool
baseCommand: lsaBGC-Sociate
label: lsabgc_lsaBGC-Sociate
doc: "Assess co-occurrence and association of gene cluster families (GCFs) and ortholog groups across samples.\n\nTool homepage: https://github.com/Kalan-Lab/lsaBGC-Pan"
inputs:
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
  - id: visual_output_directory
    type: string
    doc: "Visual output directory. The directory is created in the working directory."
    inputBinding:
      position: 1
      prefix: --visual_output_directory
  - id: species_phylogeny
    type: File
    doc: "The species phylogeny in Newick format."
    inputBinding:
      position: 1
      prefix: --species_phylogeny
  - id: report_hits_with_notes
    type:
      - 'null'
      - boolean
    doc: "Report hits with 'notes'."
    inputBinding:
      position: 1
      prefix: --report_hits_with_notes
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for MCL step [Default is 1]."
    inputBinding:
      position: 1
      prefix: --threads
  - id: timeout_time
    type:
      - 'null'
      - int
    doc: "Timeout for alignments in seconds [Default is 1800]."
    inputBinding:
      position: 1
      prefix: --timeout_time
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
  - id: visual_output_directory_dir
    type: Directory
    doc: Results directory written with --visual_output_directory.
    outputBinding:
      glob: $(inputs.visual_output_directory)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      - envName: GECCO_DOMAIN_WEIGHTS_PKL_FILE
        envValue: "$(inputs.gecco_domain_weights ? inputs.gecco_domain_weights.path : '')"
  - class: InitialWorkDirRequirement
    listing: "$(inputs.staged_dirs ? inputs.staged_dirs : [])"
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lsabgc:1.1.10--pyhdfd78af_0
    dockerOutputDirectory: /w
