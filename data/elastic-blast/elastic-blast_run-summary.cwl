cwlVersion: v1.2
class: CommandLineTool
baseCommand: elastic-blast run-summary
label: elastic-blast_run-summary
doc: "Show a summary of the ElasticBLAST run.\n\nTool homepage: https://pypi.org/project/elastic-blast/"
inputs:
  - id: aws_region
    type:
      - 'null'
      - string
    doc: AWS region to run ElasticBLAST
    inputBinding:
      position: 101
      prefix: --aws-region
  - id: cfg
    type:
      - 'null'
      - File
    doc: ElasticBLAST configuration file
    inputBinding:
      position: 101
      prefix: --cfg
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Do not perform any actions
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: force_from_cluster
    type:
      - 'null'
      - boolean
    doc: Force reading logs from cluster, not from cache
    inputBinding:
      position: 101
      prefix: --force-from-cluster
  - id: gcp_project
    type:
      - 'null'
      - string
    doc: GCP project to run ElasticBLAST
    inputBinding:
      position: 101
      prefix: --gcp-project
  - id: gcp_region
    type:
      - 'null'
      - string
    doc: GCP region to run ElasticBLAST
    inputBinding:
      position: 101
      prefix: --gcp-region
  - id: gcp_zone
    type:
      - 'null'
      - string
    doc: GCP zone to run ElasticBLAST
    inputBinding:
      position: 101
      prefix: --gcp-zone
  - id: logfile
    type:
      - 'null'
      - File
    doc: 'Default: elastic-blast.log'
    inputBinding:
      position: 101
      prefix: --logfile
  - id: loglevel
    type:
      - 'null'
      - string
    doc: 'Default: DEBUG'
    inputBinding:
      position: 101
      prefix: --loglevel
  - id: results
    type:
      - 'null'
      - string
    doc: Bucket URI where to save the output from ElasticBLAST
    inputBinding:
      position: 101
      prefix: --results
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: 'Output file, default: stdout'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0
