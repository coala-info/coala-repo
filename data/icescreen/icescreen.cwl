cwlVersion: v1.2
class: CommandLineTool
baseCommand: icescreen
label: icescreen
doc: "ICEscreen version 1.3.3\n\nTool homepage: https://forgemia.inra.fr/ices_imes_analysis/icescreen"
inputs:
  - id: analysis_name
    type:
      - 'null'
      - string
    doc: Name of the analysis
    default: None
    inputBinding:
      position: 101
      prefix: --name
  - id: galaxy
    type:
      - 'null'
      - boolean
    doc: Do not try to activate the default icescreen_env Conda environment 
      before running icescreen. This option allows to run ICEscreen on a Galaxy 
      instance.
    inputBinding:
      position: 101
      prefix: --galaxy
  - id: gbdir
    type: Directory
    doc: Path to the folder containing the genbank files (Mandatory). 
      Multigenbank files are supported. Each Genbank file must include the 
      ORIGIN nucleotide sequence at the end.
    inputBinding:
      position: 101
      prefix: --gbdir
  - id: index_genomic_resources
    type:
      - 'null'
      - boolean
    doc: Index or re-index the genomic resources related to the signature 
      proteins used by ICEscreen (proteins fasta via makeblastdb and HMM 
      profiles via hmmpress) and exit.
    inputBinding:
      position: 101
      prefix: --index_genomic_resources
  - id: install_dependencies
    type:
      - 'null'
      - boolean
    doc: Uninstall and re-install the dependencies of ICEscreen via Conda.
    inputBinding:
      position: 101
      prefix: --install_dependencies
  - id: nb_jobs
    type:
      - 'null'
      - int
    doc: Maximum number of processes running in parallel
    default: 1
    inputBinding:
      position: 101
      prefix: --jobs
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Path to where ICEscreen results will be written
    default: /root
    inputBinding:
      position: 101
      prefix: --outdir
  - id: print_version_dependencies
    type:
      - 'null'
      - boolean
    doc: Show the version of the dependencies for ICEscreen and exit.
    inputBinding:
      position: 101
      prefix: --print_version_dependencies
  - id: taxonomic_phylum
    type: string
    doc: 'Phylum of the organisms to analyse. Supported phylum: "bacillota".'
    inputBinding:
      position: 101
      prefix: --phylum
  - id: test_installation
    type:
      - 'null'
      - boolean
    doc: Test whether the process of installing ICEscreen was successful and 
      exit. If so, the sentence "The installation of ICEscreen is successful" 
      will appear.
    inputBinding:
      position: 101
      prefix: --test_installation
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/icescreen:1.3.3--py312h7e72e81_0
stdout: icescreen.out
