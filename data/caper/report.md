# caper CWL Generation Report

## caper_init

### Tool Description
Initialize Caper for a given platform.

### Metadata
- **Docker Image**: quay.io/biocontainers/caper:1.1.0--py_0
- **Homepage**: https://github.com/ENCODE-DCC/caper
- **Package**: https://anaconda.org/channels/bioconda/packages/caper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/caper/overview
- **Total Downloads**: 54.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ENCODE-DCC/caper
- **Stars**: N/A
### Original Help Text
```text
usage: caper init [-h] [-c CONF] [-D]
                  [--gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON]
                  [--local-loc-dir LOCAL_LOC_DIR] [--gcp-loc-dir GCP_LOC_DIR]
                  [--aws-loc-dir AWS_LOC_DIR]
                  platform

positional arguments:
  platform              Platform to initialize Caper for.

optional arguments:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF  Specify config file
  -D, --debug           Prints all logs >= DEBUG level
  --gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON
                        Secret key JSON file for Google Cloud Platform service
                        account. This service account should have enough
                        permission to Storage for client functions and
                        Storage/Compute Engine/Genomics API/Life Sciences API
                        for server/runner functions.

cache directories for localization:
  --local-loc-dir LOCAL_LOC_DIR, --tmp-dir LOCAL_LOC_DIR
                        Temporary directory to store Cromwell's intermediate
                        backend files. These files include backend.conf,
                        workflow_opts.json, imports.zip. and localized input
                        JSON files due to deepcopying (recursive
                        localization). Cromwell's MySQL/PostgreSQL DB password
                        can be exposed on backend.conf on this directory.
                        Therefore, DO NOT USE /tmp HERE. This directory is
                        also used for storing cached files for
                        local/slurm/sge/pbs backends.
  --gcp-loc-dir GCP_LOC_DIR, --tmp-gcs-bucket GCP_LOC_DIR
                        Temporary directory to store cached files for gcp
                        backend. e.g. gs://my-bucket/caper-cache-dir.
  --aws-loc-dir AWS_LOC_DIR, --tmp-s3-bucket AWS_LOC_DIR
                        Temporary directory to store cached files for aws
                        backend. e.g. s3://my-bucket/caper-cache-dir.
```


## caper_run

### Tool Description
Run a WDL script with Caper

### Metadata
- **Docker Image**: quay.io/biocontainers/caper:1.1.0--py_0
- **Homepage**: https://github.com/ENCODE-DCC/caper
- **Package**: https://anaconda.org/channels/bioconda/packages/caper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: caper run [-h] [-c CONF] [-D]
                 [--gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON]
                 [--local-loc-dir LOCAL_LOC_DIR] [--gcp-loc-dir GCP_LOC_DIR]
                 [--aws-loc-dir AWS_LOC_DIR] [-i INPUTS] [-o OPTIONS]
                 [-l LABELS] [-p IMPORTS] [-s STR_LABEL] [--hold]
                 [--singularity-cachedir SINGULARITY_CACHEDIR]
                 [--use-gsutil-for-s3] [--no-deepcopy] [--ignore-womtool]
                 [--womtool WOMTOOL] [--java-heap-womtool JAVA_HEAP_WOMTOOL]
                 [--max-retries MAX_RETRIES] [--docker [DOCKER]]
                 [--singularity [SINGULARITY]] [--no-build-singularity]
                 [--slurm-partition SLURM_PARTITION]
                 [--slurm-account SLURM_ACCOUNT]
                 [--slurm-extra-param SLURM_EXTRA_PARAM] [--sge-pe SGE_PE]
                 [--sge-queue SGE_QUEUE] [--sge-extra-param SGE_EXTRA_PARAM]
                 [--pbs-queue PBS_QUEUE] [--pbs-extra-param PBS_EXTRA_PARAM]
                 [-m METADATA_OUTPUT] [--java-heap-run JAVA_HEAP_RUN]
                 [--cromwell-stdout CROMWELL_STDOUT] [--db DB]
                 [--db-timeout DB_TIMEOUT] [--file-db FILE_DB]
                 [--mysql-db-ip MYSQL_DB_IP] [--mysql-db-port MYSQL_DB_PORT]
                 [--mysql-db-user MYSQL_DB_USER]
                 [--mysql-db-password MYSQL_DB_PASSWORD]
                 [--mysql-db-name MYSQL_DB_NAME]
                 [--postgresql-db-ip POSTGRESQL_DB_IP]
                 [--postgresql-db-port POSTGRESQL_DB_PORT]
                 [--postgresql-db-user POSTGRESQL_DB_USER]
                 [--postgresql-db-password POSTGRESQL_DB_PASSWORD]
                 [--postgresql-db-name POSTGRESQL_DB_NAME]
                 [--cromwell CROMWELL]
                 [--max-concurrent-tasks MAX_CONCURRENT_TASKS]
                 [--max-concurrent-workflows MAX_CONCURRENT_WORKFLOWS]
                 [--disable-call-caching] [--backend-file BACKEND_FILE]
                 [--soft-glob-output]
                 [--local-hash-strat {file,path,path+modtime}]
                 [--local-out-dir LOCAL_OUT_DIR] [--gcp-prj GCP_PRJ]
                 [--gcp-memory-retry-error-keys GCP_MEMORY_RETRY_ERROR_KEYS]
                 [--gcp-memory-retry-multiplier GCP_MEMORY_RETRY_MULTIPLIER]
                 [--gcp-region GCP_REGION]
                 [--gcp-call-caching-dup-strat {reference,reference}]
                 [--gcp-out-dir GCP_OUT_DIR] [--aws-batch-arn AWS_BATCH_ARN]
                 [--aws-region AWS_REGION] [--aws-out-dir AWS_OUT_DIR]
                 [-b BACKEND] [--dry-run] [--use-google-cloud-life-sciences]
                 [--gcp-zones GCP_ZONES]
                 wdl

positional arguments:
  wdl                   Path, URL or URI for WDL script Example:
                        /scratch/my.wdl, gs://some/where/our.wdl,
                        http://hello.com/world/your.wdl

optional arguments:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF  Specify config file
  -D, --debug           Prints all logs >= DEBUG level
  --gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON
                        Secret key JSON file for Google Cloud Platform service
                        account. This service account should have enough
                        permission to Storage for client functions and
                        Storage/Compute Engine/Genomics API/Life Sciences API
                        for server/runner functions.
  -i INPUTS, --inputs INPUTS
                        Workflow inputs JSON file
  -o OPTIONS, --options OPTIONS
                        Workflow options JSON file
  -l LABELS, --labels LABELS
                        Workflow labels JSON file
  -p IMPORTS, --imports IMPORTS
                        Zip file of imported subworkflows
  -s STR_LABEL, --str-label STR_LABEL
                        Caper's special label for a workflow This label will
                        be added to a workflow labels JSON file as a value for
                        a key "caper-label". DO NOT USE IRREGULAR CHARACTERS.
                        USE LETTERS, NUMBERS, DASHES AND UNDERSCORES ONLY
                        (^[A-Za-z0-9\-\_]+$) since this label is used to
                        compose a path for workflow's temporary/cache
                        directory (.caper_tmp/label/timestamp/)
  --hold                Put a hold on a workflow when submitted to a Cromwell
                        server.
  --singularity-cachedir SINGULARITY_CACHEDIR
                        Singularity cache directory. Equivalent to exporting
                        an environment variable SINGULARITY_CACHEDIR. Define
                        it to prevent repeatedly building a singularity image
                        for every pipeline task
  --use-gsutil-for-s3   Use gsutil CLI for direct trasnfer between S3 and GCS
                        buckets. Otherwise, such file transfer will stream
                        through local machine. Make sure that gsutil is
                        installed on your system and it has access to
                        credentials for AWS (e.g. ~/.boto or
                        ~/.aws/credentials).
  --no-deepcopy         (IMPORTANT) --deepcopy has been deprecated.
                        Deepcopying is now activated by default. This flag
                        disables deepcopy for JSON (.json), TSV (.tsv) and CSV
                        (.csv) files specified in an input JSON file
                        (--inputs). Find all path/URI string values in an
                        input JSON file and make copies of files on a
                        local/remote storage for a target backend. Make sure
                        that you have installed gsutil for GCS and aws for S3.
  --ignore-womtool      Ignore warnings from womtool.jar.
  --womtool WOMTOOL     Path or URL for Cromwell's womtool JAR file
  --java-heap-womtool JAVA_HEAP_WOMTOOL
                        Java heap size for Womtool (java -Xmx)
  --max-retries MAX_RETRIES
                        Number of retries for failing tasks. equivalent to
                        "maxRetries" in workflow options JSON file.
  -m METADATA_OUTPUT, --metadata-output METADATA_OUTPUT
                        An optional directory path to output metadata JSON
                        file
  --java-heap-run JAVA_HEAP_RUN
                        Cromwell Java heap size for "run" mode (java -Xmx)
  --cromwell-stdout CROMWELL_STDOUT
                        Local file to write STDOUT of Cromwell Java process
                        to. This is for Cromwell (not for Caper's logging
                        system). Note that STDERR is redirected to STDOUT.
  -b BACKEND, --backend BACKEND
                        Backend to run a workflow
  --dry-run             Caper localizes remote files and validates WDL but
                        does not run/submit a pipeline.

cache directories for localization:
  --local-loc-dir LOCAL_LOC_DIR, --tmp-dir LOCAL_LOC_DIR
                        Temporary directory to store Cromwell's intermediate
                        backend files. These files include backend.conf,
                        workflow_opts.json, imports.zip. and localized input
                        JSON files due to deepcopying (recursive
                        localization). Cromwell's MySQL/PostgreSQL DB password
                        can be exposed on backend.conf on this directory.
                        Therefore, DO NOT USE /tmp HERE. This directory is
                        also used for storing cached files for
                        local/slurm/sge/pbs backends.
  --gcp-loc-dir GCP_LOC_DIR, --tmp-gcs-bucket GCP_LOC_DIR
                        Temporary directory to store cached files for gcp
                        backend. e.g. gs://my-bucket/caper-cache-dir.
  --aws-loc-dir AWS_LOC_DIR, --tmp-s3-bucket AWS_LOC_DIR
                        Temporary directory to store cached files for aws
                        backend. e.g. s3://my-bucket/caper-cache-dir.

dependency resolver for all backends:
  Cloud-based backends (gc and aws) will only use Docker so that "--docker
  URI_FOR_DOCKER_IMG" must be specified in the command line argument or as a
  comment "#CAPER docker URI_FOR_DOCKER_IMG" or value for
  "workflow.meta.caper_docker"in a WDL file

  --docker [DOCKER]     URI for Docker image (e.g. ubuntu:latest). This can
                        also be used as a flag to use Docker image address
                        defined in your WDL file as a comment ("#CAPER
                        docker") or as "workflow.meta.caper_docker" in WDL.

dependency resolver for local backend:
  Singularity is for local backend only. Other backends (gcp and aws) will
  use Docker only. Local backend defaults to not use any container-based
  methods. Use "--singularity" or "--docker" to use containers

  --singularity [SINGULARITY]
                        URI or path for Singularity image (e.g.
                        ~/.singularity/ubuntu-latest.simg,
                        docker://ubuntu:latest, shub://vsoch/hello-world).
                        This can also be used as a flag to use Docker image
                        address defined in your WDL file as a comment ("#CAPER
                        singularity") or as "workflow.meta.caper_singularity"
                        in WDL.
  --no-build-singularity
                        Do not build singularity image before running a
                        workflow.

SLURM arguments:
  --slurm-partition SLURM_PARTITION
                        SLURM partition
  --slurm-account SLURM_ACCOUNT
                        SLURM account
  --slurm-extra-param SLURM_EXTRA_PARAM
                        SLURM extra parameters. Must be double-quoted

SGE arguments:
  --sge-pe SGE_PE       SGE parallel environment. Check with "qconf -spl"
  --sge-queue SGE_QUEUE
                        SGE queue. Check with "qconf -sql"
  --sge-extra-param SGE_EXTRA_PARAM
                        SGE extra parameters. Must be double-quoted

PBS arguments:
  --pbs-queue PBS_QUEUE
                        PBS queue
  --pbs-extra-param PBS_EXTRA_PARAM
                        PBS extra parameters. Must be double-quoted

General DB settings (for both file DB and MySQL DB):
  --db DB               Cromwell metadata database type
  --db-timeout DB_TIMEOUT
                        Milliseconds to wait for DB connection.

HyperSQL file DB arguments (unstable, not recommended):
  --file-db FILE_DB, -d FILE_DB
                        Default DB file for Cromwell's built-in HyperSQL
                        database.

MySQL DB arguments:
  --mysql-db-ip MYSQL_DB_IP
                        MySQL Database IP address (e.g. localhost)
  --mysql-db-port MYSQL_DB_PORT
                        MySQL Database TCP/IP port (e.g. 3306)
  --mysql-db-user MYSQL_DB_USER
                        MySQL DB username
  --mysql-db-password MYSQL_DB_PASSWORD
                        MySQL DB password
  --mysql-db-name MYSQL_DB_NAME
                        MySQL DB name for Cromwell

PostgreSQL DB arguments:
  --postgresql-db-ip POSTGRESQL_DB_IP
                        PostgreSQL DB IP address (e.g. localhost)
  --postgresql-db-port POSTGRESQL_DB_PORT
                        PostgreSQL DB TCP/IP port (e.g. 5432)
  --postgresql-db-user POSTGRESQL_DB_USER
                        PostgreSQL DB username
  --postgresql-db-password POSTGRESQL_DB_PASSWORD
                        PostgreSQL DB password
  --postgresql-db-name POSTGRESQL_DB_NAME
                        PostgreSQL DB name for Cromwell

Cromwell settings:
  --cromwell CROMWELL   Path or URL for Cromwell JAR file
  --max-concurrent-tasks MAX_CONCURRENT_TASKS
                        Number of concurrent tasks. "config.concurrent-job-
                        limit" in Cromwell backend configuration for each
                        backend
  --max-concurrent-workflows MAX_CONCURRENT_WORKFLOWS
                        Number of concurrent workflows. "system.max-
                        concurrent-workflows" in backend configuration
  --disable-call-caching
                        Disable Cromwell's call caching, which re-uses outputs
                        from previous workflows
  --backend-file BACKEND_FILE
                        Custom Cromwell backend configuration file to override
                        all
  --soft-glob-output    Use soft-linking when globbing outputs for a
                        filesystem that does not allow hard-linking. e.g.
                        beeGFS. This flag does not work with backends based on
                        a Docker container. i.e. gcp and aws. Also, it does
                        not work with local backends (local/slurm/sge/pbs)
                        with --. However, it works fine with --singularity.
  --local-hash-strat {file,path,path+modtime}
                        File hashing strategy for call caching. For local
                        backends (local/slurm/sge/pbs) only. file: use md5sum
                        hash (slow), path: use path only, path+modtime
                        (default): use path + mtime.

local backend arguments:
  --local-out-dir LOCAL_OUT_DIR, --out-dir LOCAL_OUT_DIR
                        Output directory path for local backend. Cloud
                        backends (gcp, aws) use different output directories.
                        For gcp, define --gcp-out-dir. For aws, define --aws-
                        out-dir.

GCP backend arguments for server/runner:
  --gcp-prj GCP_PRJ     GC project
  --gcp-memory-retry-error-keys GCP_MEMORY_RETRY_ERROR_KEYS
                        If an error caught by these comma-separated keys
                        occurs, then increase memory by --gcp-memory-retry-
                        multiplier for retrials controlled by --max-retries.
                        See https://cromwell.readthedocs.io/en/stable/backends
                        /Google/ for details.
  --gcp-memory-retry-multiplier GCP_MEMORY_RETRY_MULTIPLIER
                        If an error caught by --gcp-memory-retry-error-keys
                        occurs, then increase memory by this for retrials
                        controlled by --max-retries. See https://cromwell.read
                        thedocs.io/en/stable/backends/Google/ for details.
  --gcp-region GCP_REGION
                        GCP region for Google Cloud Life Sciences API. This is
                        used only when --use-google-cloud-life-sciences is
                        defined.
  --gcp-call-caching-dup-strat {reference,reference}
                        Duplication strategy for call-cached outputs for GCP
                        backend: copy: make a copy, reference: refer to old
                        output in metadata.json.
  --gcp-out-dir GCP_OUT_DIR, --out-gcs-bucket GCP_OUT_DIR
                        Output directory path for GCP backend. e.g. gs://my-
                        bucket/my-output.

AWS backend arguments:
  --aws-batch-arn AWS_BATCH_ARN
                        ARN for AWS Batch
  --aws-region AWS_REGION
                        AWS region (e.g. us-west-1)
  --aws-out-dir AWS_OUT_DIR, --out-s3-bucket AWS_OUT_DIR
                        Output path on S3 bucket for AWS backend. e.g.
                        s3://my-bucket/my-output.

GCP backend arguments for server/runner/client:
  --use-google-cloud-life-sciences
                        Use Google Cloud Life Sciences API (v2beta) instead of
                        deprecated Genomics API (v2alpha1).Life Sciences API
                        requires only one region specified withgcp-region.
                        gcp-zones will be ignored since it is for Genomics
                        API.See https://cloud.google.com/life-
                        sciences/docs/concepts/locations for supported
                        regions.
  --gcp-zones GCP_ZONES
                        Comma-separated GCP zones used for Genomics API. (e.g.
                        us-west1-b,us-central1-b). If you use --use-google-
                        cloud-life-sciences then define --gcp-region instead.
```


## caper_server

### Tool Description
Start Caper server

### Metadata
- **Docker Image**: quay.io/biocontainers/caper:1.1.0--py_0
- **Homepage**: https://github.com/ENCODE-DCC/caper
- **Package**: https://anaconda.org/channels/bioconda/packages/caper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: caper server [-h] [-c CONF] [-D]
                    [--gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON]
                    [--local-loc-dir LOCAL_LOC_DIR]
                    [--gcp-loc-dir GCP_LOC_DIR] [--aws-loc-dir AWS_LOC_DIR]
                    [--port PORT] [--no-server-heartbeat]
                    [--server-heartbeat-file SERVER_HEARTBEAT_FILE]
                    [--server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT]
                    [--java-heap-server JAVA_HEAP_SERVER]
                    [--cromwell-stdout CROMWELL_STDOUT] [--db DB]
                    [--db-timeout DB_TIMEOUT] [--file-db FILE_DB]
                    [--mysql-db-ip MYSQL_DB_IP]
                    [--mysql-db-port MYSQL_DB_PORT]
                    [--mysql-db-user MYSQL_DB_USER]
                    [--mysql-db-password MYSQL_DB_PASSWORD]
                    [--mysql-db-name MYSQL_DB_NAME]
                    [--postgresql-db-ip POSTGRESQL_DB_IP]
                    [--postgresql-db-port POSTGRESQL_DB_PORT]
                    [--postgresql-db-user POSTGRESQL_DB_USER]
                    [--postgresql-db-password POSTGRESQL_DB_PASSWORD]
                    [--postgresql-db-name POSTGRESQL_DB_NAME]
                    [--cromwell CROMWELL]
                    [--max-concurrent-tasks MAX_CONCURRENT_TASKS]
                    [--max-concurrent-workflows MAX_CONCURRENT_WORKFLOWS]
                    [--disable-call-caching] [--backend-file BACKEND_FILE]
                    [--soft-glob-output]
                    [--local-hash-strat {file,path,path+modtime}]
                    [--local-out-dir LOCAL_OUT_DIR] [--gcp-prj GCP_PRJ]
                    [--gcp-memory-retry-error-keys GCP_MEMORY_RETRY_ERROR_KEYS]
                    [--gcp-memory-retry-multiplier GCP_MEMORY_RETRY_MULTIPLIER]
                    [--gcp-region GCP_REGION]
                    [--gcp-call-caching-dup-strat {reference,reference}]
                    [--gcp-out-dir GCP_OUT_DIR]
                    [--aws-batch-arn AWS_BATCH_ARN] [--aws-region AWS_REGION]
                    [--aws-out-dir AWS_OUT_DIR] [-b BACKEND] [--dry-run]
                    [--use-google-cloud-life-sciences] [--gcp-zones GCP_ZONES]

optional arguments:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF  Specify config file
  -D, --debug           Prints all logs >= DEBUG level
  --gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON
                        Secret key JSON file for Google Cloud Platform service
                        account. This service account should have enough
                        permission to Storage for client functions and
                        Storage/Compute Engine/Genomics API/Life Sciences API
                        for server/runner functions.
  --port PORT           Port for Caper server
  --no-server-heartbeat
                        Disable server heartbeat file.
  --server-heartbeat-file SERVER_HEARTBEAT_FILE
                        Heartbeat file for Caper clients to get IP and port of
                        a server
  --server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT
                        Timeout for a heartbeat file in Milliseconds. A
                        heartbeat file older than this interval will be
                        ignored.
  --java-heap-server JAVA_HEAP_SERVER
                        Cromwell Java heap size for "server" mode (java -Xmx)
  --cromwell-stdout CROMWELL_STDOUT
                        Local file to write STDOUT of Cromwell Java process
                        to. This is for Cromwell (not for Caper's logging
                        system). Note that STDERR is redirected to STDOUT.
  -b BACKEND, --backend BACKEND
                        Backend to run a workflow
  --dry-run             Caper localizes remote files and validates WDL but
                        does not run/submit a pipeline.

cache directories for localization:
  --local-loc-dir LOCAL_LOC_DIR, --tmp-dir LOCAL_LOC_DIR
                        Temporary directory to store Cromwell's intermediate
                        backend files. These files include backend.conf,
                        workflow_opts.json, imports.zip. and localized input
                        JSON files due to deepcopying (recursive
                        localization). Cromwell's MySQL/PostgreSQL DB password
                        can be exposed on backend.conf on this directory.
                        Therefore, DO NOT USE /tmp HERE. This directory is
                        also used for storing cached files for
                        local/slurm/sge/pbs backends.
  --gcp-loc-dir GCP_LOC_DIR, --tmp-gcs-bucket GCP_LOC_DIR
                        Temporary directory to store cached files for gcp
                        backend. e.g. gs://my-bucket/caper-cache-dir.
  --aws-loc-dir AWS_LOC_DIR, --tmp-s3-bucket AWS_LOC_DIR
                        Temporary directory to store cached files for aws
                        backend. e.g. s3://my-bucket/caper-cache-dir.

General DB settings (for both file DB and MySQL DB):
  --db DB               Cromwell metadata database type
  --db-timeout DB_TIMEOUT
                        Milliseconds to wait for DB connection.

HyperSQL file DB arguments (unstable, not recommended):
  --file-db FILE_DB, -d FILE_DB
                        Default DB file for Cromwell's built-in HyperSQL
                        database.

MySQL DB arguments:
  --mysql-db-ip MYSQL_DB_IP
                        MySQL Database IP address (e.g. localhost)
  --mysql-db-port MYSQL_DB_PORT
                        MySQL Database TCP/IP port (e.g. 3306)
  --mysql-db-user MYSQL_DB_USER
                        MySQL DB username
  --mysql-db-password MYSQL_DB_PASSWORD
                        MySQL DB password
  --mysql-db-name MYSQL_DB_NAME
                        MySQL DB name for Cromwell

PostgreSQL DB arguments:
  --postgresql-db-ip POSTGRESQL_DB_IP
                        PostgreSQL DB IP address (e.g. localhost)
  --postgresql-db-port POSTGRESQL_DB_PORT
                        PostgreSQL DB TCP/IP port (e.g. 5432)
  --postgresql-db-user POSTGRESQL_DB_USER
                        PostgreSQL DB username
  --postgresql-db-password POSTGRESQL_DB_PASSWORD
                        PostgreSQL DB password
  --postgresql-db-name POSTGRESQL_DB_NAME
                        PostgreSQL DB name for Cromwell

Cromwell settings:
  --cromwell CROMWELL   Path or URL for Cromwell JAR file
  --max-concurrent-tasks MAX_CONCURRENT_TASKS
                        Number of concurrent tasks. "config.concurrent-job-
                        limit" in Cromwell backend configuration for each
                        backend
  --max-concurrent-workflows MAX_CONCURRENT_WORKFLOWS
                        Number of concurrent workflows. "system.max-
                        concurrent-workflows" in backend configuration
  --disable-call-caching
                        Disable Cromwell's call caching, which re-uses outputs
                        from previous workflows
  --backend-file BACKEND_FILE
                        Custom Cromwell backend configuration file to override
                        all
  --soft-glob-output    Use soft-linking when globbing outputs for a
                        filesystem that does not allow hard-linking. e.g.
                        beeGFS. This flag does not work with backends based on
                        a Docker container. i.e. gcp and aws. Also, it does
                        not work with local backends (local/slurm/sge/pbs)
                        with --. However, it works fine with --singularity.
  --local-hash-strat {file,path,path+modtime}
                        File hashing strategy for call caching. For local
                        backends (local/slurm/sge/pbs) only. file: use md5sum
                        hash (slow), path: use path only, path+modtime
                        (default): use path + mtime.

local backend arguments:
  --local-out-dir LOCAL_OUT_DIR, --out-dir LOCAL_OUT_DIR
                        Output directory path for local backend. Cloud
                        backends (gcp, aws) use different output directories.
                        For gcp, define --gcp-out-dir. For aws, define --aws-
                        out-dir.

GCP backend arguments for server/runner:
  --gcp-prj GCP_PRJ     GC project
  --gcp-memory-retry-error-keys GCP_MEMORY_RETRY_ERROR_KEYS
                        If an error caught by these comma-separated keys
                        occurs, then increase memory by --gcp-memory-retry-
                        multiplier for retrials controlled by --max-retries.
                        See https://cromwell.readthedocs.io/en/stable/backends
                        /Google/ for details.
  --gcp-memory-retry-multiplier GCP_MEMORY_RETRY_MULTIPLIER
                        If an error caught by --gcp-memory-retry-error-keys
                        occurs, then increase memory by this for retrials
                        controlled by --max-retries. See https://cromwell.read
                        thedocs.io/en/stable/backends/Google/ for details.
  --gcp-region GCP_REGION
                        GCP region for Google Cloud Life Sciences API. This is
                        used only when --use-google-cloud-life-sciences is
                        defined.
  --gcp-call-caching-dup-strat {reference,reference}
                        Duplication strategy for call-cached outputs for GCP
                        backend: copy: make a copy, reference: refer to old
                        output in metadata.json.
  --gcp-out-dir GCP_OUT_DIR, --out-gcs-bucket GCP_OUT_DIR
                        Output directory path for GCP backend. e.g. gs://my-
                        bucket/my-output.

AWS backend arguments:
  --aws-batch-arn AWS_BATCH_ARN
                        ARN for AWS Batch
  --aws-region AWS_REGION
                        AWS region (e.g. us-west-1)
  --aws-out-dir AWS_OUT_DIR, --out-s3-bucket AWS_OUT_DIR
                        Output path on S3 bucket for AWS backend. e.g.
                        s3://my-bucket/my-output.

GCP backend arguments for server/runner/client:
  --use-google-cloud-life-sciences
                        Use Google Cloud Life Sciences API (v2beta) instead of
                        deprecated Genomics API (v2alpha1).Life Sciences API
                        requires only one region specified withgcp-region.
                        gcp-zones will be ignored since it is for Genomics
                        API.See https://cloud.google.com/life-
                        sciences/docs/concepts/locations for supported
                        regions.
  --gcp-zones GCP_ZONES
                        Comma-separated GCP zones used for Genomics API. (e.g.
                        us-west1-b,us-central1-b). If you use --use-google-
                        cloud-life-sciences then define --gcp-region instead.
```


## caper_submit

### Tool Description
Submit a WDL workflow to Caper.

### Metadata
- **Docker Image**: quay.io/biocontainers/caper:1.1.0--py_0
- **Homepage**: https://github.com/ENCODE-DCC/caper
- **Package**: https://anaconda.org/channels/bioconda/packages/caper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: caper submit [-h] [-c CONF] [-D]
                    [--gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON]
                    [--local-loc-dir LOCAL_LOC_DIR]
                    [--gcp-loc-dir GCP_LOC_DIR] [--aws-loc-dir AWS_LOC_DIR]
                    [--port PORT] [--no-server-heartbeat]
                    [--server-heartbeat-file SERVER_HEARTBEAT_FILE]
                    [--server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT]
                    [--hostname HOSTNAME] [-i INPUTS] [-o OPTIONS] [-l LABELS]
                    [-p IMPORTS] [-s STR_LABEL] [--hold]
                    [--singularity-cachedir SINGULARITY_CACHEDIR]
                    [--use-gsutil-for-s3] [--no-deepcopy] [--ignore-womtool]
                    [--womtool WOMTOOL]
                    [--java-heap-womtool JAVA_HEAP_WOMTOOL]
                    [--max-retries MAX_RETRIES] [--docker [DOCKER]]
                    [--singularity [SINGULARITY]] [--no-build-singularity]
                    [--slurm-partition SLURM_PARTITION]
                    [--slurm-account SLURM_ACCOUNT]
                    [--slurm-extra-param SLURM_EXTRA_PARAM] [--sge-pe SGE_PE]
                    [--sge-queue SGE_QUEUE]
                    [--sge-extra-param SGE_EXTRA_PARAM]
                    [--pbs-queue PBS_QUEUE]
                    [--pbs-extra-param PBS_EXTRA_PARAM] [-b BACKEND]
                    [--dry-run] [--use-google-cloud-life-sciences]
                    [--gcp-zones GCP_ZONES]
                    wdl

positional arguments:
  wdl                   Path, URL or URI for WDL script Example:
                        /scratch/my.wdl, gs://some/where/our.wdl,
                        http://hello.com/world/your.wdl

optional arguments:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF  Specify config file
  -D, --debug           Prints all logs >= DEBUG level
  --gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON
                        Secret key JSON file for Google Cloud Platform service
                        account. This service account should have enough
                        permission to Storage for client functions and
                        Storage/Compute Engine/Genomics API/Life Sciences API
                        for server/runner functions.
  --port PORT           Port for Caper server
  --no-server-heartbeat
                        Disable server heartbeat file.
  --server-heartbeat-file SERVER_HEARTBEAT_FILE
                        Heartbeat file for Caper clients to get IP and port of
                        a server
  --server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT
                        Timeout for a heartbeat file in Milliseconds. A
                        heartbeat file older than this interval will be
                        ignored.
  --hostname HOSTNAME, --ip HOSTNAME
                        Hostname (or IP address) of Caper server.
  -i INPUTS, --inputs INPUTS
                        Workflow inputs JSON file
  -o OPTIONS, --options OPTIONS
                        Workflow options JSON file
  -l LABELS, --labels LABELS
                        Workflow labels JSON file
  -p IMPORTS, --imports IMPORTS
                        Zip file of imported subworkflows
  -s STR_LABEL, --str-label STR_LABEL
                        Caper's special label for a workflow This label will
                        be added to a workflow labels JSON file as a value for
                        a key "caper-label". DO NOT USE IRREGULAR CHARACTERS.
                        USE LETTERS, NUMBERS, DASHES AND UNDERSCORES ONLY
                        (^[A-Za-z0-9\-\_]+$) since this label is used to
                        compose a path for workflow's temporary/cache
                        directory (.caper_tmp/label/timestamp/)
  --hold                Put a hold on a workflow when submitted to a Cromwell
                        server.
  --singularity-cachedir SINGULARITY_CACHEDIR
                        Singularity cache directory. Equivalent to exporting
                        an environment variable SINGULARITY_CACHEDIR. Define
                        it to prevent repeatedly building a singularity image
                        for every pipeline task
  --use-gsutil-for-s3   Use gsutil CLI for direct trasnfer between S3 and GCS
                        buckets. Otherwise, such file transfer will stream
                        through local machine. Make sure that gsutil is
                        installed on your system and it has access to
                        credentials for AWS (e.g. ~/.boto or
                        ~/.aws/credentials).
  --no-deepcopy         (IMPORTANT) --deepcopy has been deprecated.
                        Deepcopying is now activated by default. This flag
                        disables deepcopy for JSON (.json), TSV (.tsv) and CSV
                        (.csv) files specified in an input JSON file
                        (--inputs). Find all path/URI string values in an
                        input JSON file and make copies of files on a
                        local/remote storage for a target backend. Make sure
                        that you have installed gsutil for GCS and aws for S3.
  --ignore-womtool      Ignore warnings from womtool.jar.
  --womtool WOMTOOL     Path or URL for Cromwell's womtool JAR file
  --java-heap-womtool JAVA_HEAP_WOMTOOL
                        Java heap size for Womtool (java -Xmx)
  --max-retries MAX_RETRIES
                        Number of retries for failing tasks. equivalent to
                        "maxRetries" in workflow options JSON file.
  -b BACKEND, --backend BACKEND
                        Backend to run a workflow
  --dry-run             Caper localizes remote files and validates WDL but
                        does not run/submit a pipeline.

cache directories for localization:
  --local-loc-dir LOCAL_LOC_DIR, --tmp-dir LOCAL_LOC_DIR
                        Temporary directory to store Cromwell's intermediate
                        backend files. These files include backend.conf,
                        workflow_opts.json, imports.zip. and localized input
                        JSON files due to deepcopying (recursive
                        localization). Cromwell's MySQL/PostgreSQL DB password
                        can be exposed on backend.conf on this directory.
                        Therefore, DO NOT USE /tmp HERE. This directory is
                        also used for storing cached files for
                        local/slurm/sge/pbs backends.
  --gcp-loc-dir GCP_LOC_DIR, --tmp-gcs-bucket GCP_LOC_DIR
                        Temporary directory to store cached files for gcp
                        backend. e.g. gs://my-bucket/caper-cache-dir.
  --aws-loc-dir AWS_LOC_DIR, --tmp-s3-bucket AWS_LOC_DIR
                        Temporary directory to store cached files for aws
                        backend. e.g. s3://my-bucket/caper-cache-dir.

dependency resolver for all backends:
  Cloud-based backends (gc and aws) will only use Docker so that "--docker
  URI_FOR_DOCKER_IMG" must be specified in the command line argument or as a
  comment "#CAPER docker URI_FOR_DOCKER_IMG" or value for
  "workflow.meta.caper_docker"in a WDL file

  --docker [DOCKER]     URI for Docker image (e.g. ubuntu:latest). This can
                        also be used as a flag to use Docker image address
                        defined in your WDL file as a comment ("#CAPER
                        docker") or as "workflow.meta.caper_docker" in WDL.

dependency resolver for local backend:
  Singularity is for local backend only. Other backends (gcp and aws) will
  use Docker only. Local backend defaults to not use any container-based
  methods. Use "--singularity" or "--docker" to use containers

  --singularity [SINGULARITY]
                        URI or path for Singularity image (e.g.
                        ~/.singularity/ubuntu-latest.simg,
                        docker://ubuntu:latest, shub://vsoch/hello-world).
                        This can also be used as a flag to use Docker image
                        address defined in your WDL file as a comment ("#CAPER
                        singularity") or as "workflow.meta.caper_singularity"
                        in WDL.
  --no-build-singularity
                        Do not build singularity image before running a
                        workflow.

SLURM arguments:
  --slurm-partition SLURM_PARTITION
                        SLURM partition
  --slurm-account SLURM_ACCOUNT
                        SLURM account
  --slurm-extra-param SLURM_EXTRA_PARAM
                        SLURM extra parameters. Must be double-quoted

SGE arguments:
  --sge-pe SGE_PE       SGE parallel environment. Check with "qconf -spl"
  --sge-queue SGE_QUEUE
                        SGE queue. Check with "qconf -sql"
  --sge-extra-param SGE_EXTRA_PARAM
                        SGE extra parameters. Must be double-quoted

PBS arguments:
  --pbs-queue PBS_QUEUE
                        PBS queue
  --pbs-extra-param PBS_EXTRA_PARAM
                        PBS extra parameters. Must be double-quoted

GCP backend arguments for server/runner/client:
  --use-google-cloud-life-sciences
                        Use Google Cloud Life Sciences API (v2beta) instead of
                        deprecated Genomics API (v2alpha1).Life Sciences API
                        requires only one region specified withgcp-region.
                        gcp-zones will be ignored since it is for Genomics
                        API.See https://cloud.google.com/life-
                        sciences/docs/concepts/locations for supported
                        regions.
  --gcp-zones GCP_ZONES
                        Comma-separated GCP zones used for Genomics API. (e.g.
                        us-west1-b,us-central1-b). If you use --use-google-
                        cloud-life-sciences then define --gcp-region instead.
```


## caper_abort

### Tool Description
List of workflow IDs to find matching workflows to commit a specified action (list, metadata and abort). Wildcards (* and ?) are allowed.

### Metadata
- **Docker Image**: quay.io/biocontainers/caper:1.1.0--py_0
- **Homepage**: https://github.com/ENCODE-DCC/caper
- **Package**: https://anaconda.org/channels/bioconda/packages/caper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: caper abort [-h] [-c CONF] [-D]
                   [--gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON]
                   [--local-loc-dir LOCAL_LOC_DIR] [--gcp-loc-dir GCP_LOC_DIR]
                   [--aws-loc-dir AWS_LOC_DIR] [--port PORT]
                   [--no-server-heartbeat]
                   [--server-heartbeat-file SERVER_HEARTBEAT_FILE]
                   [--server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT]
                   [--hostname HOSTNAME]
                   [wf_id_or_label [wf_id_or_label ...]]

positional arguments:
  wf_id_or_label        List of workflow IDs to find matching workflows to
                        commit a specified action (list, metadata and abort).
                        Wildcards (* and ?) are allowed.

optional arguments:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF  Specify config file
  -D, --debug           Prints all logs >= DEBUG level
  --gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON
                        Secret key JSON file for Google Cloud Platform service
                        account. This service account should have enough
                        permission to Storage for client functions and
                        Storage/Compute Engine/Genomics API/Life Sciences API
                        for server/runner functions.
  --port PORT           Port for Caper server
  --no-server-heartbeat
                        Disable server heartbeat file.
  --server-heartbeat-file SERVER_HEARTBEAT_FILE
                        Heartbeat file for Caper clients to get IP and port of
                        a server
  --server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT
                        Timeout for a heartbeat file in Milliseconds. A
                        heartbeat file older than this interval will be
                        ignored.
  --hostname HOSTNAME, --ip HOSTNAME
                        Hostname (or IP address) of Caper server.

cache directories for localization:
  --local-loc-dir LOCAL_LOC_DIR, --tmp-dir LOCAL_LOC_DIR
                        Temporary directory to store Cromwell's intermediate
                        backend files. These files include backend.conf,
                        workflow_opts.json, imports.zip. and localized input
                        JSON files due to deepcopying (recursive
                        localization). Cromwell's MySQL/PostgreSQL DB password
                        can be exposed on backend.conf on this directory.
                        Therefore, DO NOT USE /tmp HERE. This directory is
                        also used for storing cached files for
                        local/slurm/sge/pbs backends.
  --gcp-loc-dir GCP_LOC_DIR, --tmp-gcs-bucket GCP_LOC_DIR
                        Temporary directory to store cached files for gcp
                        backend. e.g. gs://my-bucket/caper-cache-dir.
  --aws-loc-dir AWS_LOC_DIR, --tmp-s3-bucket AWS_LOC_DIR
                        Temporary directory to store cached files for aws
                        backend. e.g. s3://my-bucket/caper-cache-dir.
```


## caper_unhold

### Tool Description
List of workflow IDs to find matching workflows to commit a specified action (list, metadata and abort). Wildcards (* and ?) are allowed.

### Metadata
- **Docker Image**: quay.io/biocontainers/caper:1.1.0--py_0
- **Homepage**: https://github.com/ENCODE-DCC/caper
- **Package**: https://anaconda.org/channels/bioconda/packages/caper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: caper unhold [-h] [-c CONF] [-D]
                    [--gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON]
                    [--local-loc-dir LOCAL_LOC_DIR]
                    [--gcp-loc-dir GCP_LOC_DIR] [--aws-loc-dir AWS_LOC_DIR]
                    [--port PORT] [--no-server-heartbeat]
                    [--server-heartbeat-file SERVER_HEARTBEAT_FILE]
                    [--server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT]
                    [--hostname HOSTNAME]
                    [wf_id_or_label [wf_id_or_label ...]]

positional arguments:
  wf_id_or_label        List of workflow IDs to find matching workflows to
                        commit a specified action (list, metadata and abort).
                        Wildcards (* and ?) are allowed.

optional arguments:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF  Specify config file
  -D, --debug           Prints all logs >= DEBUG level
  --gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON
                        Secret key JSON file for Google Cloud Platform service
                        account. This service account should have enough
                        permission to Storage for client functions and
                        Storage/Compute Engine/Genomics API/Life Sciences API
                        for server/runner functions.
  --port PORT           Port for Caper server
  --no-server-heartbeat
                        Disable server heartbeat file.
  --server-heartbeat-file SERVER_HEARTBEAT_FILE
                        Heartbeat file for Caper clients to get IP and port of
                        a server
  --server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT
                        Timeout for a heartbeat file in Milliseconds. A
                        heartbeat file older than this interval will be
                        ignored.
  --hostname HOSTNAME, --ip HOSTNAME
                        Hostname (or IP address) of Caper server.

cache directories for localization:
  --local-loc-dir LOCAL_LOC_DIR, --tmp-dir LOCAL_LOC_DIR
                        Temporary directory to store Cromwell's intermediate
                        backend files. These files include backend.conf,
                        workflow_opts.json, imports.zip. and localized input
                        JSON files due to deepcopying (recursive
                        localization). Cromwell's MySQL/PostgreSQL DB password
                        can be exposed on backend.conf on this directory.
                        Therefore, DO NOT USE /tmp HERE. This directory is
                        also used for storing cached files for
                        local/slurm/sge/pbs backends.
  --gcp-loc-dir GCP_LOC_DIR, --tmp-gcs-bucket GCP_LOC_DIR
                        Temporary directory to store cached files for gcp
                        backend. e.g. gs://my-bucket/caper-cache-dir.
  --aws-loc-dir AWS_LOC_DIR, --tmp-s3-bucket AWS_LOC_DIR
                        Temporary directory to store cached files for aws
                        backend. e.g. s3://my-bucket/caper-cache-dir.
```


## caper_list

### Tool Description
List workflows, metadata, and abort workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/caper:1.1.0--py_0
- **Homepage**: https://github.com/ENCODE-DCC/caper
- **Package**: https://anaconda.org/channels/bioconda/packages/caper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: caper list [-h] [-c CONF] [-D]
                  [--gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON]
                  [--local-loc-dir LOCAL_LOC_DIR] [--gcp-loc-dir GCP_LOC_DIR]
                  [--aws-loc-dir AWS_LOC_DIR] [--port PORT]
                  [--no-server-heartbeat]
                  [--server-heartbeat-file SERVER_HEARTBEAT_FILE]
                  [--server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT]
                  [--hostname HOSTNAME] [-f FORMAT]
                  [--hide-result-before HIDE_RESULT_BEFORE]
                  [--hide-subworkflow]
                  [wf_id_or_label [wf_id_or_label ...]]

positional arguments:
  wf_id_or_label        List of workflow IDs to find matching workflows to
                        commit a specified action (list, metadata and abort).
                        Wildcards (* and ?) are allowed.

optional arguments:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF  Specify config file
  -D, --debug           Prints all logs >= DEBUG level
  --gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON
                        Secret key JSON file for Google Cloud Platform service
                        account. This service account should have enough
                        permission to Storage for client functions and
                        Storage/Compute Engine/Genomics API/Life Sciences API
                        for server/runner functions.
  --port PORT           Port for Caper server
  --no-server-heartbeat
                        Disable server heartbeat file.
  --server-heartbeat-file SERVER_HEARTBEAT_FILE
                        Heartbeat file for Caper clients to get IP and port of
                        a server
  --server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT
                        Timeout for a heartbeat file in Milliseconds. A
                        heartbeat file older than this interval will be
                        ignored.
  --hostname HOSTNAME, --ip HOSTNAME
                        Hostname (or IP address) of Caper server.
  -f FORMAT, --format FORMAT
                        Comma-separated list of items to be shown for "list"
                        subcommand. Any key name in workflow JSON from
                        Cromwell server's response is allowed. Available keys
                        are "id" (workflow ID), "status", "str_label", "name"
                        (WDL/CWL name), "submission" (date/time), "start",
                        "end" and "user". "str_label" is a special key for
                        Caper. See help context of "--str-label" for details
  --hide-result-before HIDE_RESULT_BEFORE
                        Hide workflows submitted before this date/time. Use
                        the same (or shorter) date/time format shown in "caper
                        list". e.g. 2019-06-13, 2019-06-13T10:07
  --hide-subworkflow    Hide subworkflows from "caper list".

cache directories for localization:
  --local-loc-dir LOCAL_LOC_DIR, --tmp-dir LOCAL_LOC_DIR
                        Temporary directory to store Cromwell's intermediate
                        backend files. These files include backend.conf,
                        workflow_opts.json, imports.zip. and localized input
                        JSON files due to deepcopying (recursive
                        localization). Cromwell's MySQL/PostgreSQL DB password
                        can be exposed on backend.conf on this directory.
                        Therefore, DO NOT USE /tmp HERE. This directory is
                        also used for storing cached files for
                        local/slurm/sge/pbs backends.
  --gcp-loc-dir GCP_LOC_DIR, --tmp-gcs-bucket GCP_LOC_DIR
                        Temporary directory to store cached files for gcp
                        backend. e.g. gs://my-bucket/caper-cache-dir.
  --aws-loc-dir AWS_LOC_DIR, --tmp-s3-bucket AWS_LOC_DIR
                        Temporary directory to store cached files for aws
                        backend. e.g. s3://my-bucket/caper-cache-dir.
```


## caper_metadata

### Tool Description
List of workflow IDs to find matching workflows to commit a specified action (list, metadata and abort).

### Metadata
- **Docker Image**: quay.io/biocontainers/caper:1.1.0--py_0
- **Homepage**: https://github.com/ENCODE-DCC/caper
- **Package**: https://anaconda.org/channels/bioconda/packages/caper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: caper metadata [-h] [-c CONF] [-D]
                      [--gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON]
                      [--local-loc-dir LOCAL_LOC_DIR]
                      [--gcp-loc-dir GCP_LOC_DIR] [--aws-loc-dir AWS_LOC_DIR]
                      [--port PORT] [--no-server-heartbeat]
                      [--server-heartbeat-file SERVER_HEARTBEAT_FILE]
                      [--server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT]
                      [--hostname HOSTNAME]
                      [wf_id_or_label [wf_id_or_label ...]]

positional arguments:
  wf_id_or_label        List of workflow IDs to find matching workflows to
                        commit a specified action (list, metadata and abort).
                        Wildcards (* and ?) are allowed.

optional arguments:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF  Specify config file
  -D, --debug           Prints all logs >= DEBUG level
  --gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON
                        Secret key JSON file for Google Cloud Platform service
                        account. This service account should have enough
                        permission to Storage for client functions and
                        Storage/Compute Engine/Genomics API/Life Sciences API
                        for server/runner functions.
  --port PORT           Port for Caper server
  --no-server-heartbeat
                        Disable server heartbeat file.
  --server-heartbeat-file SERVER_HEARTBEAT_FILE
                        Heartbeat file for Caper clients to get IP and port of
                        a server
  --server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT
                        Timeout for a heartbeat file in Milliseconds. A
                        heartbeat file older than this interval will be
                        ignored.
  --hostname HOSTNAME, --ip HOSTNAME
                        Hostname (or IP address) of Caper server.

cache directories for localization:
  --local-loc-dir LOCAL_LOC_DIR, --tmp-dir LOCAL_LOC_DIR
                        Temporary directory to store Cromwell's intermediate
                        backend files. These files include backend.conf,
                        workflow_opts.json, imports.zip. and localized input
                        JSON files due to deepcopying (recursive
                        localization). Cromwell's MySQL/PostgreSQL DB password
                        can be exposed on backend.conf on this directory.
                        Therefore, DO NOT USE /tmp HERE. This directory is
                        also used for storing cached files for
                        local/slurm/sge/pbs backends.
  --gcp-loc-dir GCP_LOC_DIR, --tmp-gcs-bucket GCP_LOC_DIR
                        Temporary directory to store cached files for gcp
                        backend. e.g. gs://my-bucket/caper-cache-dir.
  --aws-loc-dir AWS_LOC_DIR, --tmp-s3-bucket AWS_LOC_DIR
                        Temporary directory to store cached files for aws
                        backend. e.g. s3://my-bucket/caper-cache-dir.
```


## caper_troubleshoot

### Tool Description
List of workflow IDs to find matching workflows to commit a specified action (list, metadata and abort). Wildcards (* and ?) are allowed.

### Metadata
- **Docker Image**: quay.io/biocontainers/caper:1.1.0--py_0
- **Homepage**: https://github.com/ENCODE-DCC/caper
- **Package**: https://anaconda.org/channels/bioconda/packages/caper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: caper troubleshoot [-h] [-c CONF] [-D]
                          [--gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON]
                          [--local-loc-dir LOCAL_LOC_DIR]
                          [--gcp-loc-dir GCP_LOC_DIR]
                          [--aws-loc-dir AWS_LOC_DIR] [--port PORT]
                          [--no-server-heartbeat]
                          [--server-heartbeat-file SERVER_HEARTBEAT_FILE]
                          [--server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT]
                          [--hostname HOSTNAME] [--show-completed-task]
                          [--show-stdout]
                          [wf_id_or_label [wf_id_or_label ...]]

positional arguments:
  wf_id_or_label        List of workflow IDs to find matching workflows to
                        commit a specified action (list, metadata and abort).
                        Wildcards (* and ?) are allowed.

optional arguments:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF  Specify config file
  -D, --debug           Prints all logs >= DEBUG level
  --gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON
                        Secret key JSON file for Google Cloud Platform service
                        account. This service account should have enough
                        permission to Storage for client functions and
                        Storage/Compute Engine/Genomics API/Life Sciences API
                        for server/runner functions.
  --port PORT           Port for Caper server
  --no-server-heartbeat
                        Disable server heartbeat file.
  --server-heartbeat-file SERVER_HEARTBEAT_FILE
                        Heartbeat file for Caper clients to get IP and port of
                        a server
  --server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT
                        Timeout for a heartbeat file in Milliseconds. A
                        heartbeat file older than this interval will be
                        ignored.
  --hostname HOSTNAME, --ip HOSTNAME
                        Hostname (or IP address) of Caper server.
  --show-completed-task
                        Show information about completed tasks.
  --show-stdout         Show STDOUT for failed tasks.

cache directories for localization:
  --local-loc-dir LOCAL_LOC_DIR, --tmp-dir LOCAL_LOC_DIR
                        Temporary directory to store Cromwell's intermediate
                        backend files. These files include backend.conf,
                        workflow_opts.json, imports.zip. and localized input
                        JSON files due to deepcopying (recursive
                        localization). Cromwell's MySQL/PostgreSQL DB password
                        can be exposed on backend.conf on this directory.
                        Therefore, DO NOT USE /tmp HERE. This directory is
                        also used for storing cached files for
                        local/slurm/sge/pbs backends.
  --gcp-loc-dir GCP_LOC_DIR, --tmp-gcs-bucket GCP_LOC_DIR
                        Temporary directory to store cached files for gcp
                        backend. e.g. gs://my-bucket/caper-cache-dir.
  --aws-loc-dir AWS_LOC_DIR, --tmp-s3-bucket AWS_LOC_DIR
                        Temporary directory to store cached files for aws
                        backend. e.g. s3://my-bucket/caper-cache-dir.
```


## caper_debug

### Tool Description
Debug workflows

### Metadata
- **Docker Image**: quay.io/biocontainers/caper:1.1.0--py_0
- **Homepage**: https://github.com/ENCODE-DCC/caper
- **Package**: https://anaconda.org/channels/bioconda/packages/caper/overview
- **Validation**: PASS

### Original Help Text
```text
usage: caper debug [-h] [-c CONF] [-D]
                   [--gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON]
                   [--local-loc-dir LOCAL_LOC_DIR] [--gcp-loc-dir GCP_LOC_DIR]
                   [--aws-loc-dir AWS_LOC_DIR] [--port PORT]
                   [--no-server-heartbeat]
                   [--server-heartbeat-file SERVER_HEARTBEAT_FILE]
                   [--server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT]
                   [--hostname HOSTNAME] [--show-completed-task]
                   [--show-stdout]
                   [wf_id_or_label [wf_id_or_label ...]]

positional arguments:
  wf_id_or_label        List of workflow IDs to find matching workflows to
                        commit a specified action (list, metadata and abort).
                        Wildcards (* and ?) are allowed.

optional arguments:
  -h, --help            show this help message and exit
  -c CONF, --conf CONF  Specify config file
  -D, --debug           Prints all logs >= DEBUG level
  --gcp-service-account-key-json GCP_SERVICE_ACCOUNT_KEY_JSON
                        Secret key JSON file for Google Cloud Platform service
                        account. This service account should have enough
                        permission to Storage for client functions and
                        Storage/Compute Engine/Genomics API/Life Sciences API
                        for server/runner functions.
  --port PORT           Port for Caper server
  --no-server-heartbeat
                        Disable server heartbeat file.
  --server-heartbeat-file SERVER_HEARTBEAT_FILE
                        Heartbeat file for Caper clients to get IP and port of
                        a server
  --server-heartbeat-timeout SERVER_HEARTBEAT_TIMEOUT
                        Timeout for a heartbeat file in Milliseconds. A
                        heartbeat file older than this interval will be
                        ignored.
  --hostname HOSTNAME, --ip HOSTNAME
                        Hostname (or IP address) of Caper server.
  --show-completed-task
                        Show information about completed tasks.
  --show-stdout         Show STDOUT for failed tasks.

cache directories for localization:
  --local-loc-dir LOCAL_LOC_DIR, --tmp-dir LOCAL_LOC_DIR
                        Temporary directory to store Cromwell's intermediate
                        backend files. These files include backend.conf,
                        workflow_opts.json, imports.zip. and localized input
                        JSON files due to deepcopying (recursive
                        localization). Cromwell's MySQL/PostgreSQL DB password
                        can be exposed on backend.conf on this directory.
                        Therefore, DO NOT USE /tmp HERE. This directory is
                        also used for storing cached files for
                        local/slurm/sge/pbs backends.
  --gcp-loc-dir GCP_LOC_DIR, --tmp-gcs-bucket GCP_LOC_DIR
                        Temporary directory to store cached files for gcp
                        backend. e.g. gs://my-bucket/caper-cache-dir.
  --aws-loc-dir AWS_LOC_DIR, --tmp-s3-bucket AWS_LOC_DIR
                        Temporary directory to store cached files for aws
                        backend. e.g. s3://my-bucket/caper-cache-dir.
```


## Metadata
- **Skill**: generated
