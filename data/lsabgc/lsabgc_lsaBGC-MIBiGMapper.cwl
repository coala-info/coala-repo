cwlVersion: v1.2
class: CommandLineTool
baseCommand: lsaBGC-MIBiGMapper
label: lsabgc_lsaBGC-MIBiGMapper
doc: "Map the BGCs of one gene cluster family (GCF) to the MIBiG database of known BGCs.\n\nTool homepage: https://github.com/Kalan-Lab/lsaBGC-Pan"
inputs:
  - id: gcf_id
    type: string
    doc: "GCF identifier."
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
    doc: "OrthoFinder homolog by sample matrix."
    inputBinding:
      position: 1
      prefix: --orthomatrix
  - id: output_directory
    type: string
    doc: "Output directory. The directory is created in the working directory."
    inputBinding:
      position: 1
      prefix: --output_directory
  - id: identity
    type:
      - 'null'
      - float
    doc: "Minimal identity of MIBiG proteins to match GCF proteins to be assigned same homolog group [Default is 80.0]."
    inputBinding:
      position: 1
      prefix: --identity
  - id: coverage
    type:
      - 'null'
      - float
    doc: "Minimal coverage of GCF proteins needed to assign MIBiG protein to same homolog group [Default is 70.0]."
    inputBinding:
      position: 1
      prefix: --coverage
  - id: shared
    type:
      - 'null'
      - int
    doc: "Minimal number of homolog groups of representative BGC found in MIBiG BGC to consider potential match [Default is 5]."
    inputBinding:
      position: 1
      prefix: --shared
  - id: syntenic_correlation_cutoff
    type:
      - 'null'
      - float
    doc: "Minimum absolute correlation coefficient of MIBiG BGC with representative BGC from GCF. Is not regarded if '--draft_mode' specified. [Default is 0.0]."
    inputBinding:
      position: 1
      prefix: --syntenic_correlation_cutoff
  - id: draft_mode
    type:
      - 'null'
      - boolean
    doc: "BGCs in GCF listing are fragmented. Will assess MIBiG BGCs to all instances of GCF in sample - assuming multiple BGCs are due to assembly fragmentation."
    inputBinding:
      position: 1
      prefix: --draft_mode
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use [Default is 1]."
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
