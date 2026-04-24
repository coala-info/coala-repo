cwlVersion: v1.2
class: CommandLineTool
baseCommand: elastic-blast status
label: elastic-blast_status
doc: "Check the status of an ElasticBLAST job.\n\nTool homepage: https://pypi.org/project/elastic-blast/"
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
  - id: exit_code
    type:
      - 'null'
      - boolean
    doc: Return status through exit code
    inputBinding:
      position: 101
      prefix: --exit-code
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
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Detailed information about jobs
    inputBinding:
      position: 101
      prefix: --verbose
  - id: wait
    type:
      - 'null'
      - boolean
    doc: Wait for job completion
    inputBinding:
      position: 101
      prefix: --wait
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0
stdout: elastic-blast_status.out
