cwlVersion: v1.2
class: CommandLineTool
baseCommand: caper run
label: caper_run
doc: "Run a WDL script with Caper\n\nTool homepage: https://github.com/ENCODE-DCC/caper"
inputs:
  - id: wdl
    type: string
    doc: 'Path, URL or URI for WDL script Example: /scratch/my.wdl, gs://some/where/our.wdl,
      http://hello.com/world/your.wdl'
    inputBinding:
      position: 1
  - id: aws_batch_arn
    type:
      - 'null'
      - string
    doc: ARN for AWS Batch
    inputBinding:
      position: 102
      prefix: --aws-batch-arn
  - id: aws_loc_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory to store cached files for aws backend. e.g. 
      s3://my-bucket/caper-cache-dir.
    inputBinding:
      position: 102
      prefix: --aws-loc-dir
  - id: aws_region
    type:
      - 'null'
      - string
    doc: AWS region (e.g. us-west-1)
    inputBinding:
      position: 102
      prefix: --aws-region
  - id: backend
    type:
      - 'null'
      - string
    doc: Backend to run a workflow
    inputBinding:
      position: 102
      prefix: --backend
  - id: backend_file
    type:
      - 'null'
      - File
    doc: Custom Cromwell backend configuration file to override all
    inputBinding:
      position: 102
      prefix: --backend-file
  - id: conf
    type:
      - 'null'
      - string
    doc: Specify config file
    inputBinding:
      position: 102
      prefix: --conf
  - id: cromwell
    type:
      - 'null'
      - File
    doc: Path or URL for Cromwell JAR file
    inputBinding:
      position: 102
      prefix: --cromwell
  - id: cromwell_stdout
    type:
      - 'null'
      - File
    doc: Local file to write STDOUT of Cromwell Java process to. This is for 
      Cromwell (not for Caper's logging system). Note that STDERR is redirected 
      to STDOUT.
    inputBinding:
      position: 102
      prefix: --cromwell-stdout
  - id: db
    type:
      - 'null'
      - string
    doc: Cromwell metadata database type
    inputBinding:
      position: 102
      prefix: --db
  - id: db_timeout
    type:
      - 'null'
      - int
    doc: Milliseconds to wait for DB connection.
    inputBinding:
      position: 102
      prefix: --db-timeout
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Prints all logs >= DEBUG level
    inputBinding:
      position: 102
      prefix: --debug
  - id: disable_call_caching
    type:
      - 'null'
      - boolean
    doc: Disable Cromwell's call caching, which re-uses outputs from previous 
      workflows
    inputBinding:
      position: 102
      prefix: --disable-call-caching
  - id: docker
    type:
      - 'null'
      - string
    doc: URI for Docker image (e.g. ubuntu:latest). This can also be used as a 
      flag to use Docker image address defined in your WDL file as a comment 
      ("#CAPER docker") or as "workflow.meta.caper_docker"in a WDL file
    inputBinding:
      position: 102
      prefix: --docker
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Caper localizes remote files and validates WDL but does not run/submit 
      a pipeline.
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: file_db
    type:
      - 'null'
      - File
    doc: Default DB file for Cromwell's built-in HyperSQL database.
    inputBinding:
      position: 102
      prefix: --file-db
  - id: gcp_call_caching_dup_strat
    type:
      - 'null'
      - string
    doc: 'Duplication strategy for call-cached outputs for GCP backend: copy: make
      a copy, reference: refer to old output in metadata.json.'
    inputBinding:
      position: 102
      prefix: --gcp-call-caching-dup-strat
  - id: gcp_loc_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory to store cached files for gcp backend. e.g. 
      gs://my-bucket/caper-cache-dir.
    inputBinding:
      position: 102
      prefix: --gcp-loc-dir
  - id: gcp_memory_retry_error_keys
    type:
      - 'null'
      - string
    doc: If an error caught by these comma-separated keys occurs, then increase 
      memory by --gcp-memory-retry- multiplier for retrials controlled by 
      --max-retries. See 
      https://cromwell.readthedocs.io/en/stable/backends/Google/ for details.
    inputBinding:
      position: 102
      prefix: --gcp-memory-retry-error-keys
  - id: gcp_memory_retry_multiplier
    type:
      - 'null'
      - float
    doc: If an error caught by --gcp-memory-retry-error-keys occurs, then 
      increase memory by this for retrials controlled by --max-retries. See 
      https://cromwell.readthedocs.io/en/stable/backends/Google/ for details.
    inputBinding:
      position: 102
      prefix: --gcp-memory-retry-multiplier
  - id: gcp_prj
    type:
      - 'null'
      - string
    doc: GC project
    inputBinding:
      position: 102
      prefix: --gcp-prj
  - id: gcp_region
    type:
      - 'null'
      - string
    doc: GCP region for Google Cloud Life Sciences API. This is used only when 
      --use-google-cloud-life-sciences is defined.
    inputBinding:
      position: 102
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
      position: 102
      prefix: --gcp-service-account-key-json
  - id: gcp_zones
    type:
      - 'null'
      - string
    doc: Comma-separated GCP zones used for Genomics API. (e.g. 
      us-west1-b,us-central1-b). If you use --use-google- cloud-life-sciences 
      then define --gcp-region instead.
    inputBinding:
      position: 102
      prefix: --gcp-zones
  - id: hold
    type:
      - 'null'
      - boolean
    doc: Put a hold on a workflow when submitted to a Cromwell server.
    inputBinding:
      position: 102
      prefix: --hold
  - id: ignore_womtool
    type:
      - 'null'
      - boolean
    doc: Ignore warnings from womtool.jar.
    inputBinding:
      position: 102
      prefix: --ignore-womtool
  - id: imports
    type:
      - 'null'
      - File
    doc: Zip file of imported subworkflows
    inputBinding:
      position: 102
      prefix: --imports
  - id: inputs
    type:
      - 'null'
      - File
    doc: Workflow inputs JSON file
    inputBinding:
      position: 102
      prefix: --inputs
  - id: java_heap_run
    type:
      - 'null'
      - string
    doc: Cromwell Java heap size for "run" mode (java -Xmx)
    inputBinding:
      position: 102
      prefix: --java-heap-run
  - id: java_heap_womtool
    type:
      - 'null'
      - string
    doc: Java heap size for Womtool (java -Xmx)
    inputBinding:
      position: 102
      prefix: --java-heap-womtool
  - id: labels
    type:
      - 'null'
      - File
    doc: Workflow labels JSON file
    inputBinding:
      position: 102
      prefix: --labels
  - id: local_hash_strat
    type:
      - 'null'
      - string
    doc: 'File hashing strategy for call caching. For local backends (local/slurm/sge/pbs)
      only. file: use md5sum hash (slow), path: use path only, path+modtime (default):
      use path + mtime.'
    default: path+modtime
    inputBinding:
      position: 102
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
      position: 102
      prefix: --local-loc-dir
  - id: local_out_dir
    type:
      - 'null'
      - Directory
    doc: Output directory path for local backend. Cloud backends (gcp, aws) use 
      different output directories. For gcp, define --gcp-out-dir. For aws, 
      define --aws- out-dir.
    inputBinding:
      position: 102
      prefix: --local-out-dir
  - id: max_concurrent_tasks
    type:
      - 'null'
      - int
    doc: Number of concurrent tasks. "config.concurrent-job- limit" in Cromwell 
      backend configuration for each backend
    inputBinding:
      position: 102
      prefix: --max-concurrent-tasks
  - id: max_concurrent_workflows
    type:
      - 'null'
      - int
    doc: Number of concurrent workflows. "system.max- concurrent-workflows" in 
      backend configuration
    inputBinding:
      position: 102
      prefix: --max-concurrent-workflows
  - id: max_retries
    type:
      - 'null'
      - int
    doc: Number of retries for failing tasks. equivalent to "maxRetries" in 
      workflow options JSON file.
    inputBinding:
      position: 102
      prefix: --max-retries
  - id: metadata_output
    type:
      - 'null'
      - Directory
    doc: An optional directory path to output metadata JSON file
    inputBinding:
      position: 102
      prefix: --metadata-output
  - id: mysql_db_ip
    type:
      - 'null'
      - string
    doc: MySQL Database IP address (e.g. localhost)
    inputBinding:
      position: 102
      prefix: --mysql-db-ip
  - id: mysql_db_name
    type:
      - 'null'
      - string
    doc: MySQL DB name for Cromwell
    inputBinding:
      position: 102
      prefix: --mysql-db-name
  - id: mysql_db_password
    type:
      - 'null'
      - string
    doc: MySQL DB password
    inputBinding:
      position: 102
      prefix: --mysql-db-password
  - id: mysql_db_port
    type:
      - 'null'
      - int
    doc: MySQL Database TCP/IP port (e.g. 3306)
    inputBinding:
      position: 102
      prefix: --mysql-db-port
  - id: mysql_db_user
    type:
      - 'null'
      - string
    doc: MySQL DB username
    inputBinding:
      position: 102
      prefix: --mysql-db-user
  - id: no_build_singularity
    type:
      - 'null'
      - boolean
    doc: Do not build singularity image before running a workflow.
    inputBinding:
      position: 102
      prefix: --no-build-singularity
  - id: no_deepcopy
    type:
      - 'null'
      - boolean
    doc: (IMPORTANT) --deepcopy has been deprecated. Deepcopying is now 
      activated by default. This flag disables deepcopy for JSON (.json), TSV 
      (.tsv) and CSV (.csv) files specified in an input JSON file (--inputs). 
      Find all path/URI string values in an input JSON file and make copies of 
      files on a local/remote storage for a target backend. Make sure that you 
      have installed gsutil for GCS and aws for S3.
    inputBinding:
      position: 102
      prefix: --no-deepcopy
  - id: options
    type:
      - 'null'
      - File
    doc: Workflow options JSON file
    inputBinding:
      position: 102
      prefix: --options
  - id: pbs_extra_param
    type:
      - 'null'
      - string
    doc: PBS extra parameters. Must be double-quoted
    inputBinding:
      position: 102
      prefix: --pbs-extra-param
  - id: pbs_queue
    type:
      - 'null'
      - string
    doc: PBS queue
    inputBinding:
      position: 102
      prefix: --pbs-queue
  - id: postgresql_db_ip
    type:
      - 'null'
      - string
    doc: PostgreSQL DB IP address (e.g. localhost)
    inputBinding:
      position: 102
      prefix: --postgresql-db-ip
  - id: postgresql_db_name
    type:
      - 'null'
      - string
    doc: PostgreSQL DB name for Cromwell
    inputBinding:
      position: 102
      prefix: --postgresql-db-name
  - id: postgresql_db_password
    type:
      - 'null'
      - string
    doc: PostgreSQL DB password
    inputBinding:
      position: 102
      prefix: --postgresql-db-password
  - id: postgresql_db_port
    type:
      - 'null'
      - int
    doc: PostgreSQL DB TCP/IP port (e.g. 5432)
    inputBinding:
      position: 102
      prefix: --postgresql-db-port
  - id: postgresql_db_user
    type:
      - 'null'
      - string
    doc: PostgreSQL DB username
    inputBinding:
      position: 102
      prefix: --postgresql-db-user
  - id: sge_extra_param
    type:
      - 'null'
      - string
    doc: SGE extra parameters. Must be double-quoted
    inputBinding:
      position: 102
      prefix: --sge-extra-param
  - id: sge_pe
    type:
      - 'null'
      - string
    doc: SGE parallel environment. Check with "qconf -spl"
    inputBinding:
      position: 102
      prefix: --sge-pe
  - id: sge_queue
    type:
      - 'null'
      - string
    doc: SGE queue. Check with "qconf -sql"
    inputBinding:
      position: 102
      prefix: --sge-queue
  - id: singularity
    type:
      - 'null'
      - string
    doc: URI or path for Singularity image (e.g. 
      ~/.singularity/ubuntu-latest.simg, docker://ubuntu:latest, 
      shub://vsoch/hello-world). This can also be used as a flag to use Docker 
      image address defined in your WDL file as a comment ("#CAPER singularity")
      or as "workflow.meta.caper_singularity" in WDL.
    inputBinding:
      position: 102
      prefix: --singularity
  - id: singularity_cachedir
    type:
      - 'null'
      - Directory
    doc: Singularity cache directory. Equivalent to exporting an environment 
      variable SINGULARITY_CACHEDIR. Define it to prevent repeatedly building a 
      singularity image for every pipeline task
    inputBinding:
      position: 102
      prefix: --singularity-cachedir
  - id: slurm_account
    type:
      - 'null'
      - string
    doc: SLURM account
    inputBinding:
      position: 102
      prefix: --slurm-account
  - id: slurm_extra_param
    type:
      - 'null'
      - string
    doc: SLURM extra parameters. Must be double-quoted
    inputBinding:
      position: 102
      prefix: --slurm-extra-param
  - id: slurm_partition
    type:
      - 'null'
      - string
    doc: SLURM partition
    inputBinding:
      position: 102
      prefix: --slurm-partition
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
      position: 102
      prefix: --soft-glob-output
  - id: str_label
    type:
      - 'null'
      - string
    doc: Caper's special label for a workflow This label will be added to a 
      workflow labels JSON file as a value for a key "caper-label". DO NOT USE 
      IRREGULAR CHARACTERS. USE LETTERS, NUMBERS, DASHES AND UNDERSCORES ONLY 
      (^[A-Za-z0-9\-_]+$) since this label is used to compose a path for 
      workflow's temporary/cache directory (.caper_tmp/label/timestamp/)
    inputBinding:
      position: 102
      prefix: --str-label
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
      position: 102
      prefix: --use-google-cloud-life-sciences
  - id: use_gsutil_for_s3
    type:
      - 'null'
      - boolean
    doc: Use gsutil CLI for direct trasnfer between S3 and GCS buckets. 
      Otherwise, such file transfer will stream through local machine. Make sure
      that gsutil is installed on your system and it has access to credentials 
      for AWS (e.g. ~/.boto or ~/.aws/credentials).
    inputBinding:
      position: 102
      prefix: --use-gsutil-for-s3
  - id: womtool
    type:
      - 'null'
      - File
    doc: Path or URL for Cromwell's womtool JAR file
    inputBinding:
      position: 102
      prefix: --womtool
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
