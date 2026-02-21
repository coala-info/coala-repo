cwlVersion: v1.2
class: CommandLineTool
baseCommand: arvados-cwl-runner
label: arvados-cwl-runner
doc: "Arvados executor for Common Workflow Language\n\nTool homepage: https://arvados.org"
inputs:
  - id: workflow
    type: File
    doc: The workflow to execute
    inputBinding:
      position: 1
  - id: job_order
    type:
      - 'null'
      - type: array
        items: File
    doc: The input object to the workflow.
    inputBinding:
      position: 2
  - id: always_submit_runner
    type:
      - 'null'
      - boolean
    doc: When invoked with --submit --wait, always submit a runner to manage the workflow
    inputBinding:
      position: 103
      prefix: --always-submit-runner
  - id: api
    type:
      - 'null'
      - string
    doc: Select work submission API. Only supports 'containers'
    inputBinding:
      position: 103
      prefix: --api
  - id: basedir
    type:
      - 'null'
      - Directory
    doc: Base directory used to resolve relative references in the input
    inputBinding:
      position: 103
      prefix: --basedir
  - id: collection_cache_size
    type:
      - 'null'
      - int
    doc: Collection cache size (in MiB)
    default: 256
    inputBinding:
      position: 103
      prefix: --collection-cache-size
  - id: compute_checksum
    type:
      - 'null'
      - boolean
    doc: Compute checksum of contents while collecting outputs
    inputBinding:
      position: 103
      prefix: --compute-checksum
  - id: copy_deps
    type:
      - 'null'
      - boolean
    doc: Copy dependencies into the destination project.
    inputBinding:
      position: 103
      prefix: --copy-deps
  - id: create_workflow
    type:
      - 'null'
      - boolean
    doc: Register an Arvados workflow that can be run from Workbench
    inputBinding:
      position: 103
      prefix: --create-workflow
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print even more logging
    inputBinding:
      position: 103
      prefix: --debug
  - id: defer_downloads
    type:
      - 'null'
      - boolean
    doc: When submitting a workflow, defer downloading HTTP URLs to workflow launch.
    inputBinding:
      position: 103
      prefix: --defer-downloads
  - id: disable_preemptible
    type:
      - 'null'
      - boolean
    doc: Don't use preemptible instances.
    inputBinding:
      position: 103
      prefix: --disable-preemptible
  - id: disable_resubmit_non_preemptible
    type:
      - 'null'
      - boolean
    doc: Don't resumbit when a preemptible instance is reclaimed.
    inputBinding:
      position: 103
      prefix: --disable-resubmit-non-preemptible
  - id: disable_reuse
    type:
      - 'null'
      - boolean
    doc: Disable container reuse
    inputBinding:
      position: 103
      prefix: --disable-reuse
  - id: disable_usage_report
    type:
      - 'null'
      - boolean
    doc: Disable usage report.
    inputBinding:
      position: 103
      prefix: --disable-usage-report
  - id: enable_dev
    type:
      - 'null'
      - boolean
    doc: Enable loading and running development versions of the CWL standards.
    inputBinding:
      position: 103
      prefix: --enable-dev
  - id: enable_preemptible
    type:
      - 'null'
      - boolean
    doc: Use preemptible instances.
    inputBinding:
      position: 103
      prefix: --enable-preemptible
  - id: enable_resubmit_non_preemptible
    type:
      - 'null'
      - boolean
    doc: If a workflow step fails due to preemption, re-submit with the `preemptible`
      flag disabled.
    inputBinding:
      position: 103
      prefix: --enable-resubmit-non-preemptible
  - id: enable_reuse
    type:
      - 'null'
      - boolean
    doc: Enable container reuse (default)
    inputBinding:
      position: 103
      prefix: --enable-reuse
  - id: enable_usage_report
    type:
      - 'null'
      - boolean
    doc: Create usage_report.html with a summary of each step's resource usage.
    inputBinding:
      position: 103
      prefix: --enable-usage-report
  - id: eval_timeout
    type:
      - 'null'
      - float
    doc: Time to wait for a Javascript expression to evaluate before giving an error
    default: 20.0
    inputBinding:
      position: 103
      prefix: --eval-timeout
  - id: http_timeout
    type:
      - 'null'
      - int
    doc: API request timeout in seconds.
    default: 300
    inputBinding:
      position: 103
      prefix: --http-timeout
  - id: ignore_docker_for_reuse
    type:
      - 'null'
      - boolean
    doc: Ignore Docker image version when deciding whether to reuse past containers.
    inputBinding:
      position: 103
      prefix: --ignore-docker-for-reuse
  - id: intermediate_output_ttl
    type:
      - 'null'
      - int
    doc: If N > 0, intermediate output collections will be trashed N seconds after
      creation.
    default: 0
    inputBinding:
      position: 103
      prefix: --intermediate-output-ttl
  - id: intermediate_storage_classes
    type:
      - 'null'
      - string
    doc: Specify comma separated list of storage classes to be used when saving intermediate
      workflow output to Keep.
    inputBinding:
      position: 103
      prefix: --intermediate-storage-classes
  - id: local
    type:
      - 'null'
      - boolean
    doc: Run workflow on local host (submits containers to Arvados).
    inputBinding:
      position: 103
      prefix: --local
  - id: log_timestamps
    type:
      - 'null'
      - boolean
    doc: Prefix logging lines with timestamp
    inputBinding:
      position: 103
      prefix: --log-timestamps
  - id: match_submitter_images
    type:
      - 'null'
      - boolean
    doc: Where Arvados has more than one Docker image of the same name, use image
      from the Docker instance on the submitting node.
    inputBinding:
      position: 103
      prefix: --match-submitter-images
  - id: metrics
    type:
      - 'null'
      - boolean
    doc: Print timing metrics
    inputBinding:
      position: 103
      prefix: --metrics
  - id: name
    type:
      - 'null'
      - string
    doc: Name to use for workflow execution instance.
    inputBinding:
      position: 103
      prefix: --name
  - id: no_copy_deps
    type:
      - 'null'
      - boolean
    doc: Leave dependencies where they are.
    inputBinding:
      position: 103
      prefix: --no-copy-deps
  - id: no_log_timestamps
    type:
      - 'null'
      - boolean
    doc: No timestamp on logging lines
    inputBinding:
      position: 103
      prefix: --no-log-timestamps
  - id: no_trash_intermediate
    type:
      - 'null'
      - boolean
    doc: Do not trash intermediate outputs (default).
    inputBinding:
      position: 103
      prefix: --no-trash-intermediate
  - id: no_wait
    type:
      - 'null'
      - boolean
    doc: Submit workflow runner and exit.
    inputBinding:
      position: 103
      prefix: --no-wait
  - id: on_error
    type:
      - 'null'
      - string
    doc: Desired workflow behavior when a step fails (stop, continue).
    default: continue
    inputBinding:
      position: 103
      prefix: --on-error
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name to use for collection that stores the final output.
    inputBinding:
      position: 103
      prefix: --output-name
  - id: output_tags
    type:
      - 'null'
      - string
    doc: Tags for the final output collection separated by commas
    inputBinding:
      position: 103
      prefix: --output-tags
  - id: prefer_cached_downloads
    type:
      - 'null'
      - boolean
    doc: If a HTTP URL is found in Keep, skip upstream URL freshness check.
    inputBinding:
      position: 103
      prefix: --prefer-cached-downloads
  - id: print_dot
    type:
      - 'null'
      - boolean
    doc: Print workflow visualization in graphviz format and exit
    inputBinding:
      position: 103
      prefix: --print-dot
  - id: print_keep_deps
    type:
      - 'null'
      - boolean
    doc: To assist copying, print a list of Keep collections that this workflow depends
      on.
    inputBinding:
      position: 103
      prefix: --print-keep-deps
  - id: priority
    type:
      - 'null'
      - int
    doc: Workflow priority (range 1..1000)
    inputBinding:
      position: 103
      prefix: --priority
  - id: project_uuid
    type:
      - 'null'
      - string
    doc: Project that will own the workflow containers
    inputBinding:
      position: 103
      prefix: --project-uuid
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only print warnings and errors.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: retries
    type:
      - 'null'
      - int
    doc: Maximum number of times to retry server requests that encounter temporary
      failures (e.g., server down).
    default: 10
    inputBinding:
      position: 103
      prefix: --retries
  - id: skip_schemas
    type:
      - 'null'
      - boolean
    doc: Skip loading of schemas
    inputBinding:
      position: 103
      prefix: --skip-schemas
  - id: storage_classes
    type:
      - 'null'
      - string
    doc: Specify comma separated list of storage classes to be used when saving final
      workflow output to Keep.
    inputBinding:
      position: 103
      prefix: --storage-classes
  - id: submit
    type:
      - 'null'
      - boolean
    doc: Submit workflow to run on Arvados.
    inputBinding:
      position: 103
      prefix: --submit
  - id: submit_request_uuid
    type:
      - 'null'
      - string
    doc: Update and commit to supplied container request instead of creating a new
      one.
    inputBinding:
      position: 103
      prefix: --submit-request-uuid
  - id: submit_runner_cluster
    type:
      - 'null'
      - string
    doc: Submit workflow runner to a remote cluster
    inputBinding:
      position: 103
      prefix: --submit-runner-cluster
  - id: submit_runner_image
    type:
      - 'null'
      - string
    doc: Docker image for workflow runner job
    default: arvados/jobs:3.1.2
    inputBinding:
      position: 103
      prefix: --submit-runner-image
  - id: submit_runner_ram
    type:
      - 'null'
      - int
    doc: RAM (in MiB) required for the workflow runner job
    default: 1024
    inputBinding:
      position: 103
      prefix: --submit-runner-ram
  - id: thread_count
    type:
      - 'null'
      - int
    doc: Number of threads to use for job submit and output collection.
    inputBinding:
      position: 103
      prefix: --thread-count
  - id: tool_help
    type:
      - 'null'
      - boolean
    doc: Print command line help for tool
    inputBinding:
      position: 103
      prefix: --tool-help
  - id: trash_intermediate
    type:
      - 'null'
      - boolean
    doc: Immediately trash intermediate outputs on workflow success.
    inputBinding:
      position: 103
      prefix: --trash-intermediate
  - id: update_workflow
    type:
      - 'null'
      - string
    doc: Update an existing Arvados workflow with the given UUID.
    inputBinding:
      position: 103
      prefix: --update-workflow
  - id: validate
    type:
      - 'null'
      - boolean
    doc: Validate CWL document only.
    inputBinding:
      position: 103
      prefix: --validate
  - id: varying_url_params
    type:
      - 'null'
      - string
    doc: A comma separated list of URL query parameters that should be ignored when
      storing HTTP URLs in Keep.
    inputBinding:
      position: 103
      prefix: --varying-url-params
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Default logging
    inputBinding:
      position: 103
      prefix: --verbose
  - id: wait
    type:
      - 'null'
      - boolean
    doc: After submitting workflow runner, wait for completion.
    inputBinding:
      position: 103
      prefix: --wait
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory, default current directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arvados-cwl-runner:3.1.2--pyhdfd78af_0
