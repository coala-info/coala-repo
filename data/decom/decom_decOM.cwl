cwlVersion: v1.2
class: CommandLineTool
baseCommand: decOM
label: decom_decOM
doc: "Microbial source tracking for contamination assessment of ancient oral samples
  using k-mer-based methods\n\nTool homepage: https://github.com/CamilaDuitama/decOM"
inputs:
  - id: key
    type: string
    doc: filtering key (a kmtricks fof with only one sample). When this argument
      is set, -s/--sink must be defined too.
    inputBinding:
      position: 101
      prefix: --key
  - id: memory
    type: string
    doc: 'Write down how much memory you want to use for this process. Ex: 10GB'
    inputBinding:
      position: 101
      prefix: --memory
  - id: path_keys
    type: Directory
    doc: Path to folder with filtering keys (a kmtricks fof with only one 
      sample). You should have as many .fof files as sinks. When this argument 
      is set, -p_sinks/--path_sinks must be defined too.
    inputBinding:
      position: 101
      prefix: --path_keys
  - id: path_sinks
    type: File
    doc: .txt file with a list of sinks limited by a newline (\n). When this 
      argument is set, -p_keys/--path_keys must be defined too.
    inputBinding:
      position: 101
      prefix: --path_sinks
  - id: path_sources
    type: Directory
    doc: path to folder downloaded from 
      https://zenodo.org/record/6513520/files/decOM_sources.tar.gz
    inputBinding:
      position: 101
      prefix: --path_sources
  - id: plot
    type:
      - 'null'
      - boolean
    doc: True if you want a plot (in pdf and html format) with the source 
      proportions of the sink, else False
    default: 'False'
    inputBinding:
      position: 101
      prefix: --plot
  - id: sink
    type: string
    doc: Write down the name of your sink. It must be the same as the first 
      element of key.fof. When this argument is set, -k/--key must be defined 
      too
    inputBinding:
      position: 101
      prefix: --sink
  - id: threads
    type: int
    doc: 'Number of threads to use. Ex: 5'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Path to output folder, where you want decOM to write the results. 
      Folder must not exist, it won't be overwritten.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/decom:0.0.32--pyhdfd78af_2
