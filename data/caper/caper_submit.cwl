cwlVersion: v1.2
class: CommandLineTool
baseCommand: caper submit
label: caper_submit
doc: "Submit a WDL workflow to Caper.\n\nTool homepage: https://github.com/ENCODE-DCC/caper"
inputs:
  - id: wdl
    type: string
    doc: 'Path, URL or URI for WDL script Example: /scratch/my.wdl, gs://some/where/our.wdl,
      http://hello.com/world/your.wdl'
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
  - id: backend
    type:
      - 'null'
      - string
    doc: Backend to run a workflow
    inputBinding:
      position: 102
      prefix: --backend
  - id: conf
    type:
      - 'null'
      - string
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
  - id: docker
    type:
      - 'null'
      - type: array
        items: string
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
  - id: gcp_zones
    type:
      - 'null'
      - string
    doc: Comma-separated GCP zones used for Genomics API. (e.g. 
      us-west1-b,us-central1-b). If you use --use-google-cloud-life-sciences 
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
  - id: hostname
    type:
      - 'null'
      - string
    doc: Hostname (or IP address) of Caper server.
    inputBinding:
      position: 102
      prefix: --hostname
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
  - id: ip
    type:
      - 'null'
      - string
    doc: Hostname (or IP address) of Caper server.
    inputBinding:
      position: 102
      prefix: --ip
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
  - id: max_retries
    type:
      - 'null'
      - int
    doc: Number of retries for failing tasks. equivalent to "maxRetries" in 
      workflow options JSON file.
    inputBinding:
      position: 102
      prefix: --max-retries
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
  - id: no_server_heartbeat
    type:
      - 'null'
      - boolean
    doc: Disable server heartbeat file.
    inputBinding:
      position: 102
      prefix: --no-server-heartbeat
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
      - type: array
        items: string
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
  - id: str_label
    type:
      - 'null'
      - string
    doc: Caper's special label for a workflow This label will be added to a 
      workflow labels JSON file as a value for a key "caper-label". DO NOT USE 
      IRREGULAR CHARACTERS. USE LETTERS, NUMBERS, DASHES AND UNDERSCORES ONLY 
      (^[A-Za-z0-9\-\_]+$) since this label is used to compose a path for 
      workflow's temporary/cache directory (.caper_tmp/label/timestamp/)
    inputBinding:
      position: 102
      prefix: --str-label
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
  - id: use_google_cloud_life_sciences
    type:
      - 'null'
      - boolean
    doc: Use Google Cloud Life Sciences API (v2beta) instead of deprecated 
      Genomics API (v2alpha1).Life Sciences API requires only one region 
      specified withgcp-region. gcp-zones will be ignored since it is for 
      Genomics API.See 
      https://cloud.google.com/life-sciences/docs/concepts/locations for 
      supported regions.
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/caper:1.1.0--py_0
stdout: caper_submit.out
