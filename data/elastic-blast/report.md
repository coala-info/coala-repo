# elastic-blast CWL Generation Report

## elastic-blast_submit

### Tool Description
Submit a BLAST search to ElasticBLAST

### Metadata
- **Docker Image**: quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/elastic-blast/
- **Package**: https://anaconda.org/channels/bioconda/packages/elastic-blast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/elastic-blast/overview
- **Total Downloads**: 43.7K
- **Last updated**: 2025-12-01
- **GitHub**: https://github.com/ncbi/elastic-blast
- **Stars**: N/A
### Original Help Text
```text
usage: elastic-blast submit [-h] [--aws-region AWS_REGION]
                            [--gcp-project GCP_PROJECT]
                            [--gcp-region GCP_REGION] [--gcp-zone GCP_ZONE]
                            [--cfg FILE] [--results RESULTS]
                            [--logfile LOGFILE]
                            [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--dry-run]
                            [--program {blastp,blastn,blastx,psiblast,rpsblast,rpstblastn,tblastn,tblastx}]
                            [--query QUERY] [--db DB] [--batch-len BATCH_LEN]
                            [--machine-type MACHINE_TYPE]
                            [--num-nodes NUM_NODES] [--num-cpus NUM_CPUS]
                            [--mem-limit MEM_LIMIT]
                            ...

options:
  -h, --help            show this help message and exit

Cloud Service Provider options:
  --aws-region AWS_REGION
                        AWS region to run ElasticBLAST
  --gcp-project GCP_PROJECT
                        GCP project to run ElasticBLAST
  --gcp-region GCP_REGION
                        GCP region to run ElasticBLAST
  --gcp-zone GCP_ZONE   GCP zone to run ElasticBLAST

ElasticBLAST configuration options:
  --cfg FILE            ElasticBLAST configuration file
  --results RESULTS     Bucket URI where to save the output from ElasticBLAST

Application options:
  --logfile LOGFILE     Default: elastic-blast.log
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Default: DEBUG
  --dry-run             Do not perform any actions

BLAST options:
  --program {blastp,blastn,blastx,psiblast,rpsblast,rpstblastn,tblastn,tblastx}
                        BLAST program to run
  --query QUERY         Query sequence data, can be provided as a local path
                        or GCS bucket URI to a single file/tarball
  --db DB               BLAST database to search
  BLAST_OPTS            Options to pass to BLAST program

ElasticBLAST configuration options:
  --batch-len BATCH_LEN
                        Query size for each BLAST job
  --machine-type MACHINE_TYPE
                        Instance type to use
  --num-nodes NUM_NODES
                        Number of worker nodes to use
  --num-cpus NUM_CPUS   Number of threads to run in each BLAST job
  --mem-limit MEM_LIMIT
                        Memory limit for each BLAST job
```


## elastic-blast_status

### Tool Description
Check the status of an ElasticBLAST job.

### Metadata
- **Docker Image**: quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/elastic-blast/
- **Package**: https://anaconda.org/channels/bioconda/packages/elastic-blast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: elastic-blast status [-h] [--aws-region AWS_REGION]
                            [--gcp-project GCP_PROJECT]
                            [--gcp-region GCP_REGION] [--gcp-zone GCP_ZONE]
                            [--cfg FILE] [--results RESULTS]
                            [--logfile LOGFILE]
                            [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--dry-run] [--wait] [--verbose] [--exit-code]

options:
  -h, --help            show this help message and exit
  --wait                Wait for job completion
  --verbose             Detailed information about jobs
  --exit-code           Return status through exit code

Cloud Service Provider options:
  --aws-region AWS_REGION
                        AWS region to run ElasticBLAST
  --gcp-project GCP_PROJECT
                        GCP project to run ElasticBLAST
  --gcp-region GCP_REGION
                        GCP region to run ElasticBLAST
  --gcp-zone GCP_ZONE   GCP zone to run ElasticBLAST

ElasticBLAST configuration options:
  --cfg FILE            ElasticBLAST configuration file
  --results RESULTS     Bucket URI where to save the output from ElasticBLAST

Application options:
  --logfile LOGFILE     Default: elastic-blast.log
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Default: DEBUG
  --dry-run             Do not perform any actions
```


## elastic-blast_delete

### Tool Description
Deletes an ElasticBLAST job.

### Metadata
- **Docker Image**: quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/elastic-blast/
- **Package**: https://anaconda.org/channels/bioconda/packages/elastic-blast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: elastic-blast delete [-h] [--aws-region AWS_REGION]
                            [--gcp-project GCP_PROJECT]
                            [--gcp-region GCP_REGION] [--gcp-zone GCP_ZONE]
                            [--cfg FILE] [--results RESULTS]
                            [--logfile LOGFILE]
                            [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                            [--dry-run]

options:
  -h, --help            show this help message and exit

Cloud Service Provider options:
  --aws-region AWS_REGION
                        AWS region to run ElasticBLAST
  --gcp-project GCP_PROJECT
                        GCP project to run ElasticBLAST
  --gcp-region GCP_REGION
                        GCP region to run ElasticBLAST
  --gcp-zone GCP_ZONE   GCP zone to run ElasticBLAST

ElasticBLAST configuration options:
  --cfg FILE            ElasticBLAST configuration file
  --results RESULTS     Bucket URI where to save the output from ElasticBLAST

Application options:
  --logfile LOGFILE     Default: elastic-blast.log
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Default: DEBUG
  --dry-run             Do not perform any actions
```


## elastic-blast_run-summary

### Tool Description
Show a summary of the ElasticBLAST run.

### Metadata
- **Docker Image**: quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/elastic-blast/
- **Package**: https://anaconda.org/channels/bioconda/packages/elastic-blast/overview
- **Validation**: PASS

### Original Help Text
```text
usage: elastic-blast run-summary [-h] [--aws-region AWS_REGION]
                                 [--gcp-project GCP_PROJECT]
                                 [--gcp-region GCP_REGION]
                                 [--gcp-zone GCP_ZONE] [--cfg FILE]
                                 [--results RESULTS] [--logfile LOGFILE]
                                 [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                                 [--dry-run] [-o OUTPUT] [-f]

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Output file, default: stdout
  -f, --force-from-cluster
                        Force reading logs from cluster, not from cache

Cloud Service Provider options:
  --aws-region AWS_REGION
                        AWS region to run ElasticBLAST
  --gcp-project GCP_PROJECT
                        GCP project to run ElasticBLAST
  --gcp-region GCP_REGION
                        GCP region to run ElasticBLAST
  --gcp-zone GCP_ZONE   GCP zone to run ElasticBLAST

ElasticBLAST configuration options:
  --cfg FILE            ElasticBLAST configuration file
  --results RESULTS     Bucket URI where to save the output from ElasticBLAST

Application options:
  --logfile LOGFILE     Default: elastic-blast.log
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Default: DEBUG
  --dry-run             Do not perform any actions
```


## Metadata
- **Skill**: generated

## elastic-blast

### Tool Description
This application facilitates running BLAST on large amounts of query sequence data on the cloud

### Metadata
- **Docker Image**: quay.io/biocontainers/elastic-blast:1.5.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/elastic-blast/
- **Package**: https://anaconda.org/channels/bioconda/packages/elastic-blast/overview
- **Validation**: PASS
### Original Help Text
```text
usage: elastic-blast [-h] [--version] {submit,status,delete,run-summary} ...

This application facilitates running BLAST on large amounts of query sequence
data on the cloud

positional arguments:
  {submit,status,delete,run-summary}
    submit              Submit an ElasticBLAST search
    status              Get the status of an ElasticBLAST search
    delete              Delete resources associated with an ElasticBLAST
                        search
    run-summary         ElasticBLAST run summary generation tool

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit

To get help about specific command run elastic-blast command --help
```

