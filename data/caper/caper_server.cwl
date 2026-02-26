cwlVersion: v1.2
class: CommandLineTool
baseCommand: caper server
label: caper_server
doc: "Start Caper server\n\nTool homepage: https://github.com/ENCODE-DCC/caper"
inputs:
  - id: aws_batch_arn
    type:
      - 'null'
      - string
    doc: ARN for AWS Batch
    inputBinding:
      position: 101
      prefix: --aws-batch-arn
  - id: aws_loc_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory to store cached files for aws backend. e.g. 
      s3://my-bucket/caper-cache-dir.
    inputBinding:
      position: 101
      prefix: --aws-loc-dir
  - id: aws_region
    type:
      - 'null'
      - string
    doc: AWS region (e.g. us-west-1)
    inputBinding:
      position: 101
      prefix: --aws-region
  - id: backend
    type:
      - 'null'
      - string
    doc: Backend to run a workflow
    inputBinding:
      position: 101
      prefix: --backend
  - id: backend_file
    type:
      - 'null'
      - File
    doc: Custom Cromwell backend configuration file to override all
    inputBinding:
      position: 101
      prefix: --backend-file
  - id: config_file
    type:
      - 'null'
      - File
    doc: Specify config file
    inputBinding:
      position: 101
      prefix: --conf
  - id: cromwell
    type:
      - 'null'
      - string
    doc: Path or URL for Cromwell JAR file
    inputBinding:
      position: 101
      prefix: --cromwell
  - id: cromwell_stdout
    type:
      - 'null'
      - File
    doc: Local file to write STDOUT of Cromwell Java process to. This is for 
      Cromwell (not for Caper's logging system). Note that STDERR is redirected 
      to STDOUT.
    inputBinding:
      position: 101
      prefix: --cromwell-stdout
  - id: db
    type:
      - 'null'
      - string
    doc: Cromwell metadata database type
    inputBinding:
      position: 101
      prefix: --db
  - id: db_timeout
    type:
      - 'null'
      - int
    doc: Milliseconds to wait for DB connection.
    inputBinding:
      position: 101
      prefix: --db-timeout
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Prints all logs >= DEBUG level
    inputBinding:
      position: 101
      prefix: --debug
  - id: disable_call_caching
    type:
      - 'null'
      - boolean
    doc: Disable Cromwell's call caching, which re-uses outputs from previous 
      workflows
    inputBinding:
      position: 101
      prefix: --disable-call-caching
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Caper localizes remote files and validates WDL but does not run/submit 
      a pipeline.
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: file_db
    type:
      - 'null'
      - File
    doc: Default DB file for Cromwell's built-in HyperSQL database.
    inputBinding:
      position: 101
      prefix: --file-db
  - id: gcp_call_caching_dup_strat
    type:
      - 'null'
      - string
    doc: 'Duplication strategy for call-cached outputs for GCP backend: copy: make
      a copy, reference: refer to old output in metadata.json.'
    inputBinding:
      position: 101
      prefix: --gcp-call-caching-dup-strat
  - id: gcp_loc_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory to store cached files for gcp backend. e.g. 
      gs://my-bucket/caper-cache-dir.
    inputBinding:
      position: 101
      prefix: --gcp-loc-dir
  - id: gcp_memory_retry_error_keys
    type:
      - 'null'
      - string
    doc: If an error caught by these comma-separated keys occurs, then increase 
      memory by --gcp-memory-retry-multiplier for retrials controlled by 
      --max-retries. See 
      https://cromwell.readthedocs.io/en/stable/backends/Google/ for details.
    inputBinding:
      position: 101
      prefix: --gcp-memory-retry-error-keys
  - id: gcp_memory_retry_multiplier
    type:
      - 'null'
      - float
    doc: If an error caught by --gcp-memory-retry-error-keys occurs, then 
      increase memory by this for retrials controlled by --max-retries. See 
      https://cromwell.read thedocs.io/en/stable/backends/Google/ for details.
    inputBinding:
      position: 101
      prefix: --gcp-memory-retry-multiplier
  - id: gcp_prj
    type:
      - 'null'
      - string
    doc: GC project
    inputBinding:
      position: 101
      prefix: --gcp-prj
  - id: gcp_region
    type:
      - 'null'
      - string
    doc: GCP region for Google Cloud Life Sciences API. This is used only when 
      --use-google-cloud-life-sciences is defined.
    inputBinding:
      position: 101
      prefix: --gcp-region
  - id: gcp_service_account_key_json
    type:
      - 'null'
      - File
    doc: Secret key JSON file for Google Cloud Platform service account. This 
      service account should have enough permission to Storage for client 
      functions and Storage/Compute Engine/Genomics API/Life Sciences API for 
      server/runner functions.
    inputBinding:
      position: 101
      prefix: --gcp-service-account-key-json
  - id: gcp_zones
    type:
      - 'null'
      - string
    doc: Comma-separated GCP zones used for Genomics API. (e.g. 
      us-west1-b,us-central1-b). If you use --use-google-cloud-life-sciences 
      then define --gcp-region instead.
    inputBinding:
      position: 101
      prefix: --gcp-zones
  - id: java_heap_server
    type:
      - 'null'
      - string
    doc: Cromwell Java heap size for "server" mode (java -Xmx)
    inputBinding:
      position: 101
      prefix: --java-heap-server
  - id: local_hash_strat
    type:
      - 'null'
      - string
    doc: 'File hashing strategy for call caching. For local backends (local/slurm/sge/pbs)
      only. file: use md5sum hash (slow), path: use path only, path+modtime (default):
      use path + mtime.'
    default: path+modtime
    inputBinding:
      position: 101
      prefix: --local-hash-strat
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
      position: 101
      prefix: --local-loc-dir
  - id: local_out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory path for local backend. Cloud backends (gcp, aws) use 
      different output directories. For gcp, define --gcp-out-dir. For aws, 
      define --aws- out-dir.
    inputBinding:
      position: 101
      prefix: --local-out-dir
  - id: max_concurrent_tasks
    type:
      - 'null'
      - int
    doc: Number of concurrent tasks. "config.concurrent-job- limit" in Cromwell 
      backend configuration for each backend
    inputBinding:
      position: 101
      prefix: --max-concurrent-tasks
  - id: max_concurrent_workflows
    type:
      - 'null'
      - int
    doc: Number of concurrent workflows. "system.max- concurrent-workflows" in 
      backend configuration
    inputBinding:
      position: 101
      prefix: --max-concurrent-workflows
  - id: mysql_db_ip
    type:
      - 'null'
      - string
    doc: MySQL Database IP address (e.g. localhost)
    inputBinding:
      position: 101
      prefix: --mysql-db-ip
  - id: mysql_db_name
    type:
      - 'null'
      - string
    doc: MySQL DB name for Cromwell
    inputBinding:
      position: 101
      prefix: --mysql-db-name
  - id: mysql_db_password
    type:
      - 'null'
      - string
    doc: MySQL DB password
    inputBinding:
      position: 101
      prefix: --mysql-db-password
  - id: mysql_db_port
    type:
      - 'null'
      - int
    doc: MySQL Database TCP/IP port (e.g. 3306)
    inputBinding:
      position: 101
      prefix: --mysql-db-port
  - id: mysql_db_user
    type:
      - 'null'
      - string
    doc: MySQL DB username
    inputBinding:
      position: 101
      prefix: --mysql-db-user
  - id: no_server_heartbeat
    type:
      - 'null'
      - boolean
    doc: Disable server heartbeat file.
    inputBinding:
      position: 101
      prefix: --no-server-heartbeat
  - id: port
    type:
      - 'null'
      - int
    doc: Port for Caper server
    inputBinding:
      position: 101
      prefix: --port
  - id: postgresql_db_ip
    type:
      - 'null'
      - string
    doc: PostgreSQL DB IP address (e.g. localhost)
    inputBinding:
      position: 101
      prefix: --postgresql-db-ip
  - id: postgresql_db_name
    type:
      - 'null'
      - string
    doc: PostgreSQL DB name for Cromwell
    inputBinding:
      position: 101
      prefix: --postgresql-db-name
  - id: postgresql_db_password
    type:
      - 'null'
      - string
    doc: PostgreSQL DB password
    inputBinding:
      position: 101
      prefix: --postgresql-db-password
  - id: postgresql_db_port
    type:
      - 'null'
      - int
    doc: PostgreSQL DB TCP/IP port (e.g. 5432)
    inputBinding:
      position: 101
      prefix: --postgresql-db-port
  - id: postgresql_db_user
    type:
      - 'null'
      - string
    doc: PostgreSQL DB username
    inputBinding:
      position: 101
      prefix: --postgresql-db-user
  - id: server_heartbeat_file
    type:
      - 'null'
      - File
    doc: Heartbeat file for Caper clients to get IP and port of a server
    inputBinding:
      position: 101
      prefix: --server-heartbeat-file
  - id: server_heartbeat_timeout
    type:
      - 'null'
      - int
    doc: Timeout for a heartbeat file in Milliseconds. A heartbeat file older 
      than this interval will be ignored.
    inputBinding:
      position: 101
      prefix: --server-heartbeat-timeout
  - id: soft_glob_output
    type:
      - 'null'
      - boolean
    doc: Use soft-linking when globbing outputs for a filesystem that does not 
      allow hard-linking. e.g. beeGFS. This flag does not work with backends 
      based on a Docker container. i.e. gcp and aws. Also, it does not work with
      local backends (local/slurm/sge/pbs) with --. However, it works fine with 
      --singularity.
    inputBinding:
      position: 101
      prefix: --soft-glob-output
  - id: use_google_cloud_life_sciences
    type:
      - 'null'
      - boolean
    doc: Use Google Cloud Life Sciences API (v2beta) instead of deprecated 
      Genomics API (v2alpha1).Life Sciences API requires only one region 
      specified withgcp-region. gcp-zones will be ignored since it is for 
      Genomics API.See https://cloud.google.com/life- 
      sciences/docs/concepts/locations for supported regions.
    inputBinding:
      position: 101
      prefix: --use-google-cloud-life-sciences
outputs:
  - id: gcp_out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory path for GCP backend. e.g. gs://my- bucket/my-output.
    outputBinding:
      glob: $(inputs.gcp_out_dir)
  - id: aws_out_dir
    type:
      - 'null'
      - Directory
    doc: Output path on S3 bucket for AWS backend. e.g. 
      s3://my-bucket/my-output.
    outputBinding:
      glob: $(inputs.aws_out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/caper:1.1.0--py_0
