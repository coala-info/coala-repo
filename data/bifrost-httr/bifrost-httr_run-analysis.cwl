cwlVersion: v1.2
class: CommandLineTool
baseCommand: bifrost-httr run-analysis
label: bifrost-httr_run-analysis
doc: "Run concentration-response analysis on BIFROST data files.\n\nTool homepage:
  https://github.com/seqera-services/bifrost-httr"
inputs:
  - id: data_files
    type:
      type: array
      items: File
    doc: List of probe .pkl files to process
    inputBinding:
      position: 101
      prefix: --data-files
  - id: model_executable
    type:
      - 'null'
      - File
    doc: Path to compiled Stan model executable (optional, will use default 
      model if not provided)
    inputBinding:
      position: 101
      prefix: --model-executable
  - id: n_cores
    type:
      - 'null'
      - int
    doc: Number of cores to use in multiprocessing
    inputBinding:
      position: 101
      prefix: --n-cores
  - id: output_dir
    type: Directory
    doc: Directory to store outputs
    inputBinding:
      position: 101
      prefix: --output-dir
  - id: seed
    type:
      - 'null'
      - int
    doc: Optional random seed for reproducibility
    inputBinding:
      position: 101
      prefix: --seed
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bifrost-httr:0.5.0--pyhdfd78af_0
stdout: bifrost-httr_run-analysis.out
