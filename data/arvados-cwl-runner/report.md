# arvados-cwl-runner CWL Generation Report

## arvados-cwl-runner

### Tool Description
Arvados executor for Common Workflow Language

### Metadata
- **Docker Image**: quay.io/biocontainers/arvados-cwl-runner:3.1.2--pyhdfd78af_0
- **Homepage**: https://arvados.org
- **Package**: https://anaconda.org/channels/bioconda/packages/arvados-cwl-runner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/arvados-cwl-runner/overview
- **Total Downloads**: 184.7K
- **Last updated**: 2025-08-16
- **GitHub**: https://github.com/curoverse/arvados
- **Stars**: N/A
### Original Help Text
```text
usage: arvados-cwl-runner [-h] [--retries RETRIES] [--basedir BASEDIR]
                          [--outdir OUTDIR] [--eval-timeout EVAL_TIMEOUT]
                          [--print-dot | --version | --validate]
                          [--verbose | --quiet | --debug] [--metrics]
                          [--tool-help] [--enable-reuse | --disable-reuse]
                          [--project-uuid UUID] [--output-name OUTPUT_NAME]
                          [--output-tags OUTPUT_TAGS]
                          [--ignore-docker-for-reuse]
                          [--submit | --local | --create-template | --create-workflow | --update-workflow UUID | --print-keep-deps]
                          [--wait | --no-wait]
                          [--log-timestamps | --no-log-timestamps]
                          [--api {containers}] [--compute-checksum]
                          [--submit-runner-ram SUBMIT_RUNNER_RAM]
                          [--submit-runner-image SUBMIT_RUNNER_IMAGE]
                          [--always-submit-runner] [--match-submitter-images]
                          [--submit-request-uuid UUID | --submit-runner-cluster CLUSTER_ID]
                          [--collection-cache-size COLLECTION_CACHE_SIZE]
                          [--name NAME] [--on-error {stop,continue}]
                          [--enable-dev] [--storage-classes STORAGE_CLASSES]
                          [--intermediate-storage-classes INTERMEDIATE_STORAGE_CLASSES]
                          [--intermediate-output-ttl N] [--priority PRIORITY]
                          [--thread-count THREAD_COUNT]
                          [--http-timeout HTTP_TIMEOUT] [--defer-downloads]
                          [--varying-url-params VARYING_URL_PARAMS]
                          [--prefer-cached-downloads]
                          [--enable-preemptible | --disable-preemptible]
                          [--enable-resubmit-non-preemptible | --disable-resubmit-non-preemptible]
                          [--copy-deps | --no-copy-deps] [--skip-schemas]
                          [--trash-intermediate | --no-trash-intermediate]
                          [--enable-usage-report | --disable-usage-report]
                          workflow ...

Arvados executor for Common Workflow Language

positional arguments:
  workflow              The workflow to execute
  job_order             The input object to the workflow.

options:
  -h, --help            show this help message and exit
  --retries RETRIES     Maximum number of times to retry server requests that
                        encounter temporary failures (e.g., server down).
                        Default 10.
  --basedir BASEDIR     Base directory used to resolve relative references in
                        the input, default to directory of input object file
                        or current directory (if inputs piped/provided on
                        command line).
  --outdir OUTDIR       Output directory, default current directory
  --eval-timeout EVAL_TIMEOUT
                        Time to wait for a Javascript expression to evaluate
                        before giving an error, default 20s.
  --print-dot           Print workflow visualization in graphviz format and
                        exit
  --version             Print version and exit
  --validate            Validate CWL document only.
  --verbose             Default logging
  --quiet               Only print warnings and errors.
  --debug               Print even more logging
  --metrics             Print timing metrics
  --tool-help           Print command line help for tool
  --enable-reuse        Enable container reuse (default)
  --disable-reuse       Disable container reuse
  --project-uuid UUID   Project that will own the workflow containers, if not
                        provided, will go to home project.
  --output-name OUTPUT_NAME
                        Name to use for collection that stores the final
                        output.
  --output-tags OUTPUT_TAGS
                        Tags for the final output collection separated by
                        commas, e.g., '--output-tags tag0,tag1,tag2'.
  --ignore-docker-for-reuse
                        Ignore Docker image version when deciding whether to
                        reuse past containers.
  --submit              Submit workflow to run on Arvados.
  --local               Run workflow on local host (submits containers to
                        Arvados).
  --create-template     (Deprecated) synonym for --create-workflow.
  --create-workflow     Register an Arvados workflow that can be run from
                        Workbench
  --update-workflow UUID
                        Update an existing Arvados workflow with the given
                        UUID.
  --print-keep-deps     To assist copying, print a list of Keep collections
                        that this workflow depends on.
  --wait                After submitting workflow runner, wait for completion.
  --no-wait             Submit workflow runner and exit.
  --log-timestamps      Prefix logging lines with timestamp
  --no-log-timestamps   No timestamp on logging lines
  --api {containers}    Select work submission API. Only supports 'containers'
  --compute-checksum    Compute checksum of contents while collecting outputs
  --submit-runner-ram SUBMIT_RUNNER_RAM
                        RAM (in MiB) required for the workflow runner job
                        (default 1024)
  --submit-runner-image SUBMIT_RUNNER_IMAGE
                        Docker image for workflow runner job, default
                        arvados/jobs:3.1.2
  --always-submit-runner
                        When invoked with --submit --wait, always submit a
                        runner to manage the workflow, even when only running
                        a single CommandLineTool
  --match-submitter-images
                        Where Arvados has more than one Docker image of the
                        same name, use image from the Docker instance on the
                        submitting node.
  --submit-request-uuid UUID
                        Update and commit to supplied container request
                        instead of creating a new one.
  --submit-runner-cluster CLUSTER_ID
                        Submit workflow runner to a remote cluster
  --collection-cache-size COLLECTION_CACHE_SIZE
                        Collection cache size (in MiB, default 256).
  --name NAME           Name to use for workflow execution instance.
  --on-error {stop,continue}
                        Desired workflow behavior when a step fails. One of
                        'stop' (do not submit any more steps) or 'continue'
                        (may submit other steps that are not downstream from
                        the error). Default is 'continue'.
  --enable-dev          Enable loading and running development versions of the
                        CWL standards.
  --storage-classes STORAGE_CLASSES
                        Specify comma separated list of storage classes to be
                        used when saving final workflow output to Keep.
  --intermediate-storage-classes INTERMEDIATE_STORAGE_CLASSES
                        Specify comma separated list of storage classes to be
                        used when saving intermediate workflow output to Keep.
  --intermediate-output-ttl N
                        If N > 0, intermediate output collections will be
                        trashed N seconds after creation. Default is 0 (don't
                        trash).
  --priority PRIORITY   Workflow priority (range 1..1000, higher has
                        precedence over lower)
  --thread-count THREAD_COUNT
                        Number of threads to use for job submit and output
                        collection.
  --http-timeout HTTP_TIMEOUT
                        API request timeout in seconds. Default is 300 seconds
                        (5 minutes).
  --defer-downloads     When submitting a workflow, defer downloading HTTP
                        URLs to workflow launch instead of downloading to Keep
                        before submit.
  --varying-url-params VARYING_URL_PARAMS
                        A comma separated list of URL query parameters that
                        should be ignored when storing HTTP URLs in Keep.
  --prefer-cached-downloads
                        If a HTTP URL is found in Keep, skip upstream URL
                        freshness check (will not notice if the upstream has
                        changed, but also not error if upstream is
                        unavailable).
  --enable-preemptible  Use preemptible instances. Control individual steps
                        with arv:UsePreemptible hint.
  --disable-preemptible
                        Don't use preemptible instances.
  --enable-resubmit-non-preemptible
                        If a workflow step fails due to the instance it is
                        running on being preempted, re-submit the container
                        with the `preemptible` flag disabled. Control
                        individual steps with arv:PreemptionBehavior hint.
  --disable-resubmit-non-preemptible
                        Don't resumbit when a preemptible instance is
                        reclaimed.
  --copy-deps           Copy dependencies into the destination project.
  --no-copy-deps        Leave dependencies where they are.
  --skip-schemas        Skip loading of schemas
  --trash-intermediate  Immediately trash intermediate outputs on workflow
                        success.
  --no-trash-intermediate
                        Do not trash intermediate outputs (default).
  --enable-usage-report
                        Create usage_report.html with a summary of each step's
                        resource usage.
  --disable-usage-report
                        Disable usage report.
```


## Metadata
- **Skill**: not generated
