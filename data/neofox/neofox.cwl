cwlVersion: v1.2
class: CommandLineTool
baseCommand: neofox
label: neofox
doc: "NeoFox 1.2.3 annotates a given set of neoantigen candidate sequences derived
  from point mutation with relevant neoantigen features\n\nTool homepage: https://github.com/tron-bioinformatics/neofox"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: an optional configuration file with all the environment variables
    inputBinding:
      position: 101
      prefix: --config
  - id: input_file
    type: File
    doc: 'Input file with neoantigens candidates represented by long mutated peptide
      sequences. Supported formats: tab-separated columns (extensions: .txt or .tsv)
      or JSON (extension: .json)'
    inputBinding:
      position: 101
      prefix: --input-file
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: number of CPUs for computation
    inputBinding:
      position: 101
      prefix: --num-cpus
  - id: organism
    type:
      - 'null'
      - string
    doc: the organism to which the data corresponds
    inputBinding:
      position: 101
      prefix: --organism
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix to name output files in the output folder
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: patient_data
    type: File
    doc: 'file with data for patients with columns: identifier, estimated_tumor_content,
      mhc_i_alleles, mhc_ii_alleles, tissue'
    inputBinding:
      position: 101
      prefix: --patient-data
  - id: rank_mhci_threshold
    type:
      - 'null'
      - float
    doc: MHC-I epitopes with a netMHCpan predicted rank greater than or equal 
      than this threshold will be filtered out
    default: 2.0
    inputBinding:
      position: 101
      prefix: --rank-mhci-threshold
  - id: rank_mhcii_threshold
    type:
      - 'null'
      - float
    doc: MHC-II epitopes with a netMHCIIpan predicted rank greater than or equal
      than this threshold will be filtered out
    default: 5.0
    inputBinding:
      position: 101
      prefix: --rank-mhcii-threshold
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose logs
    inputBinding:
      position: 101
      prefix: --verbose
  - id: with_all_neoepitopes
    type:
      - 'null'
      - boolean
    doc: output annotations for all MHC-I and MHC-II neoepitopes on all HLA 
      alleles
    inputBinding:
      position: 101
      prefix: --with-all-neoepitopes
outputs:
  - id: output_folder
    type: Directory
    doc: output folder
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neofox:1.2.3--pyhdfd78af_0
