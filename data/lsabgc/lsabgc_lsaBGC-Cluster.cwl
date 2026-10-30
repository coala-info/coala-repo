cwlVersion: v1.2
class: CommandLineTool
baseCommand: lsaBGC-Cluster
label: lsabgc_lsaBGC-Cluster
doc: "Cluster BGC GenBank files into gene cluster families with MCL, based on ortholog group presence and absence.\n\nTool homepage: https://github.com/Kalan-Lab/lsaBGC-Pan"
inputs:
  - id: bgc_listings
    type: File
    doc: "BGC listing file. Tab delimited 3-column file: (1) sample name, (2) path to predicted BGC in Genbank format, (3) prediction software (either antismash or gecco)."
    inputBinding:
      position: 1
      prefix: --bgc_listings
  - id: orthofinder_matrix
    type: File
    doc: "Sample vs. ortholog matrix."
    inputBinding:
      position: 1
      prefix: --orthofinder_matrix
  - id: output_directory
    type: string
    doc: "Output directory. The directory is created in the working directory."
    inputBinding:
      position: 1
      prefix: --output_directory
  - id: mcl_inflation
    type:
      - 'null'
      - float
    doc: "Inflation parameter to be used for MCL [Default is 1.4]."
    inputBinding:
      position: 1
      prefix: --mcl_inflation
  - id: jaccard_cutoff
    type:
      - 'null'
      - float
    doc: "Cutoff for Jaccard similarity of homolog groups shared between two BGCs [Default is 50.0]."
    inputBinding:
      position: 1
      prefix: --jaccard_cutoff
  - id: syntenic_correlation_cutoff
    type:
      - 'null'
      - float
    doc: "Minimum absolute correlation coefficient between two BGCs [Default is 0.0]."
    inputBinding:
      position: 1
      prefix: --syntenic_correlation_cutoff
  - id: containment_cutoff
    type:
      - 'null'
      - float
    doc: "Percentage of fragmented gene clusters OGs needed to be present in the comparing gene cluster to be considered a pair automatically - assumming syntenic similarity is also met [Default is 70.0]."
    inputBinding:
      position: 1
      prefix: --containment_cutoff
  - id: edge_distance_cutoff
    type:
      - 'null'
      - int
    doc: "Maximum distance to edge of contig to be considered fragmented [Default is 5000]."
    inputBinding:
      position: 1
      prefix: --edge_distance_cutoff
  - id: split_by_annotation
    type:
      - 'null'
      - boolean
    doc: "Partition BGCs into groups based on annotation first."
    inputBinding:
      position: 1
      prefix: --split_by_annotation
  - id: run_parameter_tests
    type:
      - 'null'
      - boolean
    doc: "Run tests for selecting the best inflation parameter and jaccard for MCL analysis and exit."
    inputBinding:
      position: 1
      prefix: --run_parameter_tests
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads to use for MCL step."
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
