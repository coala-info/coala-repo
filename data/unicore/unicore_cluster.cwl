cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unicore
  - cluster
label: unicore_cluster
doc: "Cluster Foldseek database\n\nTool homepage: https://github.com/steineggerlab/unicore"
inputs:
  - id: input_database
    type: File
    doc: Input database (createdb output)
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Output prefix; the result will be saved as OUTPUT.tsv
    inputBinding:
      position: 2
  - id: tmp_directory
    type: Directory
    doc: Temp directory
    inputBinding:
      position: 3
  - id: cluster_options
    type:
      - 'null'
      - string
    doc: Arguments for foldseek options in string e.g. -c "-c 0.8"
    inputBinding:
      position: 104
      prefix: --cluster-options
  - id: keep_cluster_db
    type:
      - 'null'
      - boolean
    doc: Keep intermediate Foldseek cluster database
    inputBinding:
      position: 104
      prefix: --keep-cluster-db
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use; 0 to use all
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Verbosity (0: quiet, 1: +errors, 2: +warnings, 3: +info, 4: +debug)'
    inputBinding:
      position: 104
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unicore:1.1.1--h7ef3eeb_0
stdout: unicore_cluster.out
