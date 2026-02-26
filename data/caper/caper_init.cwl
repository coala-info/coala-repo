cwlVersion: v1.2
class: CommandLineTool
baseCommand: caper_init
label: caper_init
doc: "Initialize Caper for a given platform.\n\nTool homepage: https://github.com/ENCODE-DCC/caper"
inputs:
  - id: platform
    type: string
    doc: Platform to initialize Caper for.
    inputBinding:
      position: 1
  - id: aws_loc_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory to store cached files for aws backend. e.g. 
      s3://my-bucket/caper-cache-dir.
    inputBinding:
      position: 102
      prefix: --aws-loc-dir
  - id: conf
    type:
      - 'null'
      - File
    doc: Specify config file
    inputBinding:
      position: 102
      prefix: --conf
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Prints all logs >= DEBUG level
    inputBinding:
      position: 102
      prefix: --debug
  - id: gcp_loc_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory to store cached files for gcp backend. e.g. 
      gs://my-bucket/caper-cache-dir.
    inputBinding:
      position: 102
      prefix: --gcp-loc-dir
  - id: gcp_service_account_key_json
    type:
      - 'null'
      - File
    doc: Secret key JSON file for Google Cloud Platform service account. This 
      service account should have enough permission to Storage for client 
      functions and Storage/Compute Engine/Genomics API/Life Sciences API for 
      server/runner functions.
    inputBinding:
      position: 102
      prefix: --gcp-service-account-key-json
  - id: local_loc_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory to store Cromwell's intermediate backend files. 
      These files include backend.conf, workflow_opts.json, imports.zip. and 
      localized input JSON files due to deepcopying (recursive localization). 
      Cromwell's MySQL/PostgreSQL DB password can be exposed on backend.conf on 
      this directory. Therefore, DO NOT USE /tmp HERE. This directory is also 
      used for storing cached files for local/slurm/sge/pbs backends.
    inputBinding:
      position: 102
      prefix: --local-loc-dir
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory to store Cromwell's intermediate backend files. 
      These files include backend.conf, workflow_opts.json, imports.zip. and 
      localized input JSON files due to deepcopying (recursive localization). 
      Cromwell's MySQL/PostgreSQL DB password can be exposed on backend.conf on 
      this directory. Therefore, DO NOT USE /tmp HERE. This directory is also 
      used for storing cached files for local/slurm/sge/pbs backends.
    inputBinding:
      position: 102
      prefix: --tmp-dir
  - id: tmp_gcs_bucket
    type:
      - 'null'
      - Directory
    doc: Temporary directory to store cached files for gcp backend. e.g. 
      gs://my-bucket/caper-cache-dir.
    inputBinding:
      position: 102
      prefix: --tmp-gcs-bucket
  - id: tmp_s3_bucket
    type:
      - 'null'
      - Directory
    doc: Temporary directory to store cached files for aws backend. e.g. 
      s3://my-bucket/caper-cache-dir.
    inputBinding:
      position: 102
      prefix: --tmp-s3-bucket
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/caper:1.1.0--py_0
stdout: caper_init.out
