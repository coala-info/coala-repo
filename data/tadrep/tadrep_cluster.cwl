cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadrep
label: tadrep_cluster
doc: "Cluster plasmids based on sequence identity and length difference.\n\nTool homepage:
  https://github.com/oschwengers/tadrep"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print verbose information
    inputBinding:
      position: 1
      prefix: --verbose
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use (default = number of available CPUs)
    inputBinding:
      position: 2
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Temporary directory to store blast hits
    inputBinding:
      position: 3
      prefix: --tmp-dir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for all output files (default = None)
    inputBinding:
      position: 4
      prefix: --prefix
  - id: state_dir
    type:
      - 'null'
      - Directory
    doc: Output directory of a previous TaDReP step (database, extract, characterize, cluster, detect), which is staged writable and used as the working directory
  - id: max_sequence_length_difference
    type:
      - 'null'
      - int
    doc: Maximal plasmid sequence length difference in basepairs (default = 
      1000)
    inputBinding:
      position: 101
      prefix: --max-sequence-length-difference
  - id: min_sequence_identity
    type:
      - 'null'
      - int
    doc: Minimal plasmid sequence identity (default = 90%)
    inputBinding:
      position: 101
      prefix: --min-sequence-identity
  - id: skip
    type:
      - 'null'
      - boolean
    doc: Skips clustering, one group for each plasmid
    inputBinding:
      position: 101
      prefix: --skip
outputs:
  - id: tadrep_out
    type: Directory
    doc: TaDReP output directory (working directory for the next step)
    outputBinding:
      glob: tadrep_out
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 5
    prefix: --output
    valueFrom: tadrep_out
  - position: 10
    valueFrom: cluster
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.state_dir ? [{entry: inputs.state_dir, entryname: 'tadrep_out', writable: true}] : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0
stdout: tadrep_cluster.out
