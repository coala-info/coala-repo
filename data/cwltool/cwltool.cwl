cwlVersion: v1.2
class: CommandLineTool
baseCommand: cwltool
label: cwltool
doc: "Reference executor for Common Workflow Language standards.\n\nTool homepage:
  https://github.com/common-workflow-language/cwltool"
inputs:
  - id: cwl_document
    type:
      type: array
      items: string
    doc: path or URL to a CWL Workflow, CommandLineTool, or ExpressionTool. If 
      the `inputs_object` has a `cwl:tool` field indicating the path or URL to 
      the cwl_document, then the `workflow` argument is optional.
    inputBinding:
      position: 1
  - id: inputs_object
    type:
      - 'null'
      - string
    doc: path or URL to a YAML or JSON formatted description of the required 
      input values for the given cwl_document.
    inputBinding:
      position: 2
  - id: add_ga4gh_tool_registry
    type:
      - 'null'
      - type: array
        items: string
    doc: Add a GA4GH tool registry endpoint to use for resolution, default 
      ['https://dockstore.org:8443']
    inputBinding:
      position: 103
      prefix: --add-ga4gh-tool-registry
  - id: basedir
    type:
      - 'null'
      - string
    inputBinding:
      position: 103
      prefix: --basedir
  - id: cachedir
    type:
      - 'null'
      - Directory
    doc: Directory to cache intermediate workflow outputs to avoid recomputing 
      steps.
    inputBinding:
      position: 103
      prefix: --cachedir
  - id: cidfile_dir
    type:
      - 'null'
      - Directory
    doc: Directory for storing the Docker container ID file. The default is the 
      current directory
    inputBinding:
      position: 103
      prefix: --cidfile-dir
  - id: cidfile_prefix
    type:
      - 'null'
      - string
    doc: Specify a prefix to the container ID filename. Final file name will be 
      followed by a timestamp. The default is no prefix.
    inputBinding:
      position: 103
      prefix: --cidfile-prefix
  - id: compute_checksum
    type:
      - 'null'
      - boolean
    doc: Compute checksum of contents while collecting outputs
    inputBinding:
      position: 103
      prefix: --compute-checksum
  - id: copy_outputs
    type:
      - 'null'
      - boolean
    doc: Copy output files to the workflow output directory, don't delete 
      intermediate output directories.
    inputBinding:
      position: 103
      prefix: --copy-outputs
  - id: custom_net
    type:
      - 'null'
      - string
    doc: Will be passed to `docker run` as the '--net' parameter. Implies 
      '--enable-net'.
    inputBinding:
      position: 103
      prefix: --custom-net
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print even more logging
    inputBinding:
      position: 103
      prefix: --debug
  - id: default_container
    type:
      - 'null'
      - string
    doc: Specify a default docker container that will be used if the workflow 
      fails to specify one.
    inputBinding:
      position: 103
      prefix: --default-container
  - id: disable_ga4gh_tool_registry
    type:
      - 'null'
      - boolean
    doc: Disable resolution using GA4GH tool registry API
    inputBinding:
      position: 103
      prefix: --disable-ga4gh-tool-registry
  - id: disable_net
    type:
      - 'null'
      - boolean
    doc: Use docker's default networking for containers; the default is to 
      enable networking.
    inputBinding:
      position: 103
      prefix: --disable-net
  - id: disable_pull
    type:
      - 'null'
      - boolean
    doc: Do not try to pull Docker images
    inputBinding:
      position: 103
      prefix: --disable-pull
  - id: enable_dev
    type:
      - 'null'
      - boolean
    doc: Enable loading and running development versions of CWL spec.
    inputBinding:
      position: 103
      prefix: --enable-dev
  - id: enable_ext
    type:
      - 'null'
      - boolean
    doc: Enable loading and running cwltool extensions to CWL spec.
    inputBinding:
      position: 103
      prefix: --enable-ext
  - id: enable_ga4gh_tool_registry
    type:
      - 'null'
      - boolean
    doc: Enable resolution using GA4GH tool registry API
    inputBinding:
      position: 103
      prefix: --enable-ga4gh-tool-registry
  - id: enable_pull
    type:
      - 'null'
      - boolean
    doc: Try to pull Docker images
    inputBinding:
      position: 103
      prefix: --enable-pull
  - id: eval_timeout
    type:
      - 'null'
      - string
    doc: Time to wait for a Javascript expression to evaluate before giving an 
      error, default 20s.
    inputBinding:
      position: 103
      prefix: --eval-timeout
  - id: force_docker_pull
    type:
      - 'null'
      - boolean
    doc: Pull latest docker image even if it is locally present
    inputBinding:
      position: 103
      prefix: --force-docker-pull
  - id: js_console
    type:
      - 'null'
      - boolean
    doc: Enable javascript console output
    inputBinding:
      position: 103
      prefix: --js-console
  - id: leave_container
    type:
      - 'null'
      - boolean
    doc: Do not delete Docker container used by jobs after they exit
    inputBinding:
      position: 103
      prefix: --leave-container
  - id: leave_outputs
    type:
      - 'null'
      - boolean
    doc: Leave output files in intermediate output directories.
    inputBinding:
      position: 103
      prefix: --leave-outputs
  - id: leave_tmpdir
    type:
      - 'null'
      - boolean
    doc: Do not delete intermediate temporary directories
    inputBinding:
      position: 103
      prefix: --leave-tmpdir
  - id: make_template
    type:
      - 'null'
      - boolean
    doc: Generate a template input object
    inputBinding:
      position: 103
      prefix: --make-template
  - id: move_outputs
    type:
      - 'null'
      - boolean
    doc: Move output files to the workflow output directory and delete 
      intermediate output directories (default).
    inputBinding:
      position: 103
      prefix: --move-outputs
  - id: no_compute_checksum
    type:
      - 'null'
      - boolean
    doc: Do not compute checksum of contents while collecting outputs
    inputBinding:
      position: 103
      prefix: --no-compute-checksum
  - id: no_container
    type:
      - 'null'
      - boolean
    doc: Do not execute jobs in a Docker container, even when 
      `DockerRequirement` is specified under `hints`.
    inputBinding:
      position: 103
      prefix: --no-container
  - id: no_match_user
    type:
      - 'null'
      - boolean
    doc: Disable passing the current uid to `docker run --user`
    inputBinding:
      position: 103
      prefix: --no-match-user
  - id: no_read_only
    type:
      - 'null'
      - boolean
    doc: Do not set root directory in the container as read-only
    inputBinding:
      position: 103
      prefix: --no-read-only
  - id: non_strict
    type:
      - 'null'
      - boolean
    doc: Lenient validation (ignore unrecognized fields)
    inputBinding:
      position: 103
      prefix: --non-strict
  - id: on_error
    type:
      - 'null'
      - string
    doc: Desired workflow behavior when a step fails. One of 'stop' or 
      'continue'. Default is 'stop'.
    inputBinding:
      position: 103
      prefix: --on-error
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory, default current directory
    inputBinding:
      position: 103
      prefix: --outdir
  - id: overrides
    type:
      - 'null'
      - File
    doc: Read process requirement overrides from file.
    inputBinding:
      position: 103
      prefix: --overrides
  - id: pack
    type:
      - 'null'
      - boolean
    doc: Combine components into single document and print.
    inputBinding:
      position: 103
      prefix: --pack
  - id: parallel
    type:
      - 'null'
      - boolean
    doc: '[experimental] Run jobs in parallel. Does not currently keep track of ResourceRequirements
      like the number of coresor memory and can overload this system'
    inputBinding:
      position: 103
      prefix: --parallel
  - id: preserve_entire_environment
    type:
      - 'null'
      - boolean
    doc: Preserve all environment variable when running CommandLineTools.
    inputBinding:
      position: 103
      prefix: --preserve-entire-environment
  - id: preserve_environment
    type:
      - 'null'
      - type: array
        items: string
    doc: Preserve specific environment variable when running CommandLineTools. 
      May be provided multiple times.
    inputBinding:
      position: 103
      prefix: --preserve-environment
  - id: print_deps
    type:
      - 'null'
      - boolean
    doc: Print CWL document dependencies.
    inputBinding:
      position: 103
      prefix: --print-deps
  - id: print_dot
    type:
      - 'null'
      - boolean
    doc: Print workflow visualization in graphviz format and exit
    inputBinding:
      position: 103
      prefix: --print-dot
  - id: print_input_deps
    type:
      - 'null'
      - boolean
    doc: Print input object document dependencies.
    inputBinding:
      position: 103
      prefix: --print-input-deps
  - id: print_pre
    type:
      - 'null'
      - boolean
    doc: Print CWL document after preprocessing.
    inputBinding:
      position: 103
      prefix: --print-pre
  - id: print_rdf
    type:
      - 'null'
      - boolean
    doc: Print corresponding RDF graph for workflow and exit
    inputBinding:
      position: 103
      prefix: --print-rdf
  - id: print_supported_versions
    type:
      - 'null'
      - boolean
    doc: Print supported CWL specs.
    inputBinding:
      position: 103
      prefix: --print-supported-versions
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Only print warnings and errors.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: rdf_serializer
    type:
      - 'null'
      - string
    doc: Output RDF serialization format used by --print-rdf (one of turtle 
      (default), n3, nt, xml)
    inputBinding:
      position: 103
      prefix: --rdf-serializer
  - id: record_container_id
    type:
      - 'null'
      - boolean
    doc: If enabled, store the Docker container ID into a file. See 
      --cidfile-dir to specify the directory.
    inputBinding:
      position: 103
      prefix: --record-container-id
  - id: relative_deps
    type:
      - 'null'
      - string
    doc: When using --print-deps, print paths relative to primary file or 
      current working directory.
    inputBinding:
      position: 103
      prefix: --relative-deps
  - id: relax_path_checks
    type:
      - 'null'
      - boolean
    doc: Relax requirements on path names to permit spaces and hash characters.
    inputBinding:
      position: 103
      prefix: --relax-path-checks
  - id: rm_container
    type:
      - 'null'
      - boolean
    doc: Delete Docker container used by jobs after they exit (default)
    inputBinding:
      position: 103
      prefix: --rm-container
  - id: rm_tmpdir
    type:
      - 'null'
      - boolean
    doc: Delete intermediate temporary directories (default)
    inputBinding:
      position: 103
      prefix: --rm-tmpdir
  - id: singularity
    type:
      - 'null'
      - boolean
    doc: '[experimental] Use Singularity runtime for running containers. Requires
      Singularity v2.3.2+ and Linux with kernel version v3.18+ or with overlayfs support
      backported.'
    inputBinding:
      position: 103
      prefix: --singularity
  - id: skip_schemas
    type:
      - 'null'
      - boolean
    doc: Skip loading of schemas
    inputBinding:
      position: 103
      prefix: --skip-schemas
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Strict validation (unrecognized or out of place fields are error)
    inputBinding:
      position: 103
      prefix: --strict
  - id: timestamps
    type:
      - 'null'
      - boolean
    doc: Add timestamps to the errors, warnings, and notifications.
    inputBinding:
      position: 103
      prefix: --timestamps
  - id: tmp_outdir_prefix
    type:
      - 'null'
      - Directory
    doc: Path prefix for intermediate output directories
    inputBinding:
      position: 103
      prefix: --tmp-outdir-prefix
  - id: tmpdir_prefix
    type:
      - 'null'
      - string
    doc: Path prefix for temporary directories
    inputBinding:
      position: 103
      prefix: --tmpdir-prefix
  - id: tool_help
    type:
      - 'null'
      - boolean
    doc: Print command line help for tool
    inputBinding:
      position: 103
      prefix: --tool-help
  - id: user_space_docker_cmd
    type:
      - 'null'
      - string
    doc: (Linux/OS X only) Specify a user space docker command (like udocker or 
      dx-docker) that will be used to call 'pull' and 'run'
    inputBinding:
      position: 103
      prefix: --user-space-docker-cmd
  - id: validate
    type:
      - 'null'
      - boolean
    doc: Validate CWL document only.
    inputBinding:
      position: 103
      prefix: --validate
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Default logging
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cwltool:1.0.20180225105849--py36_0
stdout: cwltool.out
