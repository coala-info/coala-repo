cwlVersion: v1.2
class: CommandLineTool
baseCommand: elastic-blast submit
label: elastic-blast_submit
doc: "Submit a BLAST search to ElasticBLAST\n\nTool homepage: https://pypi.org/project/elastic-blast/"
inputs:
  - id: blast_opts
    type:
      - 'null'
      - type: array
        items: string
    doc: Options to pass to BLAST program
    inputBinding:
      position: 1
  - id: aws_region
    type:
      - 'null'
      - string
    doc: AWS region to run ElasticBLAST
    inputBinding:
      position: 102
      prefix: --aws-region
  - id: batch_len
    type:
      - 'null'
      - int
    doc: Query size for each BLAST job
    inputBinding:
      position: 102
      prefix: --batch-len
  - id: cfg
    type:
      - 'null'
      - File
    doc: ElasticBLAST configuration file
    inputBinding:
      position: 102
      prefix: --cfg
  - id: db
    type:
      - 'null'
      - string
    doc: BLAST database to search
    inputBinding:
      position: 102
      prefix: --db
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Do not perform any actions
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: gcp_project
    type:
      - 'null'
      - string
    doc: GCP project to run ElasticBLAST
    inputBinding:
      position: 102
      prefix: --gcp-project
  - id: gcp_region
    type:
      - 'null'
      - string
    doc: GCP region to run ElasticBLAST
    inputBinding:
      position: 102
      prefix: --gcp-region
  - id: gcp_zone
    type:
      - 'null'
      - string
    doc: GCP zone to run ElasticBLAST
    inputBinding:
      position: 102
      prefix: --gcp-zone
  - id: logfile
    type:
      - 'null'
      - File
    doc: 'Default: elastic-blast.log'
    inputBinding:
      position: 102
      prefix: --logfile
  - id: loglevel
    type:
      - 'null'
      - string
    doc: 'Default: DEBUG'
    inputBinding:
      position: 102
      prefix: --loglevel
  - id: machine_type
    type:
      - 'null'
      - string
    doc: Instance type to use
    inputBinding:
      position: 102
      prefix: --machine-type
  - id: mem_limit
    type:
      - 'null'
      - string
    doc: Memory limit for each BLAST job
    inputBinding:
      position: 102
      prefix: --mem-limit
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: Number of threads to run in each BLAST job
    inputBinding:
      position: 102
      prefix: --num-cpus
  - id: num_nodes
    type:
      - 'null'
      - int
    doc: Number of worker nodes to use
    inputBinding:
      position: 102
      prefix: --num-nodes
  - id: program
    type:
      - 'null'
      - string
    doc: BLAST program to run
    inputBinding:
      position: 102
      prefix: --program
  - id: query
    type:
      - 'null'
      - string
    doc: Query sequence data, can be provided as a local path or GCS bucket URI 
      to a single file/tarball
    inputBinding:
      position: 102
      prefix: --query
  - id: results
    type:
      - 'null'
      - string
    doc: Bucket URI where to save the output from ElasticBLAST
    inputBinding:
      position: 102
      prefix: --results
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0
stdout: elastic-blast_submit.out
