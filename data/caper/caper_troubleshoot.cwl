cwlVersion: v1.2
class: CommandLineTool
baseCommand: caper troubleshoot
label: caper_troubleshoot
doc: "List of workflow IDs to find matching workflows to commit a specified action
  (list, metadata and abort). Wildcards (* and ?) are allowed.\n\nTool homepage: https://github.com/ENCODE-DCC/caper"
inputs:
  - id: wf_id_or_label
    type:
      - 'null'
      - type: array
        items: string
    doc: List of workflow IDs to find matching workflows to commit a specified 
      action (list, metadata and abort). Wildcards (* and ?) are allowed.
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
  - id: config_file
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
  - id: hostname
    type:
      - 'null'
      - string
    doc: Hostname (or IP address) of Caper server.
    inputBinding:
      position: 102
      prefix: --hostname
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
  - id: no_server_heartbeat
    type:
      - 'null'
      - boolean
    doc: Disable server heartbeat file.
    inputBinding:
      position: 102
      prefix: --no-server-heartbeat
  - id: port
    type:
      - 'null'
      - int
    doc: Port for Caper server
    inputBinding:
      position: 102
      prefix: --port
  - id: server_heartbeat_file
    type:
      - 'null'
      - File
    doc: Heartbeat file for Caper clients to get IP and port of a server
    inputBinding:
      position: 102
      prefix: --server-heartbeat-file
  - id: server_heartbeat_timeout
    type:
      - 'null'
      - int
    doc: Timeout for a heartbeat file in Milliseconds. A heartbeat file older 
      than this interval will be ignored.
    inputBinding:
      position: 102
      prefix: --server-heartbeat-timeout
  - id: show_completed_task
    type:
      - 'null'
      - boolean
    doc: Show information about completed tasks.
    inputBinding:
      position: 102
      prefix: --show-completed-task
  - id: show_stdout
    type:
      - 'null'
      - boolean
    doc: Show STDOUT for failed tasks.
    inputBinding:
      position: 102
      prefix: --show-stdout
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/caper:1.1.0--py_0
stdout: caper_troubleshoot.out
