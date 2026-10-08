cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dx
  - build
label: dxpy_dx_build
doc: 'Build an applet, app, or workflow object from a local source directory or an
  app from an existing applet in the platform. You can use dx-app-wizard to generate
  a skeleton directory of an app/applet with the necessary files.


  Tool homepage: https://github.com/dnanexus/dx-toolkit'
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: src_dir
    type:
      - 'null'
      - Directory
    doc: 'Source directory that contains dxapp.json, dxworkflow.json or *.nf (for
      --nextflow option). (default: current directory)'
    inputBinding:
      position: 1
  - id: brief
    type:
      - 'null'
      - boolean
    doc: Display a brief version of the return value; for most commands, prints a
      DNAnexus ID per line
    inputBinding:
      position: 101
      prefix: --brief
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: If available, displays extra verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: ensure_upload
    type:
      - 'null'
      - boolean
    doc: If specified, will bypass computing checksum of resources directory and upload
      it unconditionally; by default, will compute checksum and upload only if it
      differs from a previously uploaded resources bundle.
    inputBinding:
      position: 101
      prefix: --ensure-upload
  - id: force_symlinks
    type:
      - 'null'
      - boolean
    doc: If specified, will not attempt to dereference symbolic links pointing outside
      of the resource directory. By default, any symlinks within the resource directory
      are kept as links while links to files outside the resource directory are dereferenced
      (note that links to directories outside of the resource directory will cause
      an error).
    inputBinding:
      position: 101
      prefix: --force-symlinks
  - id: app
    type:
      - 'null'
      - boolean
    doc: Create an app.
    inputBinding:
      position: 101
      prefix: --app
  - id: workflow
    type:
      - 'null'
      - boolean
    doc: Create a workflow.
    inputBinding:
      position: 101
      prefix: --workflow
  - id: globalworkflow
    type:
      - 'null'
      - boolean
    doc: Create a global workflow.
    inputBinding:
      position: 101
      prefix: --globalworkflow
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: 'Do not create an app(let): only perform local checks and compilation steps,
      and show the spec of the app(let) that would have been created.'
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: remote
    type:
      - 'null'
      - boolean
    doc: Build the app remotely by uploading the source directory to the DNAnexus
      Platform and building it there. This option is useful if you would otherwise
      need to cross-compile the app(let) to target the Execution Environment.
    inputBinding:
      position: 101
      prefix: --remote
  - id: no_watch
    type:
      - 'null'
      - boolean
    doc: Don't watch the real-time logs of the remote builder (this option is only
      applicable if --remote or --repository is specified).
    inputBinding:
      position: 101
      prefix: --no-watch
  - id: version
    type:
      - 'null'
      - string
    doc: Override the version number supplied in the manifest. This option needs to
      be specified when using --from option.
    inputBinding:
      position: 101
      prefix: --version
  - id: no_check_syntax
    type:
      - 'null'
      - boolean
    doc: Warn but do not fail when syntax problems are found (default is to fail on
      such errors).
    inputBinding:
      position: 101
      prefix: --no-check-syntax
  - id: no_parallel_build
    type:
      - 'null'
      - boolean
    doc: Build with make instead of make -jN.
    inputBinding:
      position: 101
      prefix: --no-parallel-build
  - id: extra_args
    type:
      - 'null'
      - string
    doc: Arguments (in JSON format) to pass to the /applet/new API method, overriding
      all other settings
    inputBinding:
      position: 101
      prefix: --extra-args
  - id: run
    type:
      - 'null'
      - type: array
        items: string
    doc: Run the app or applet after building it (options following this are passed
      to dx run; run at high priority by default). Takes all remaining arguments,
      so it is placed last.
    inputBinding:
      position: 200
      prefix: --run
  - id: keep_open
    type:
      - 'null'
      - boolean
    doc: Do not close workflow after building it. Cannot be used when building apps,
      applets or global workflows.
    inputBinding:
      position: 101
      prefix: --keep-open
  - id: nextflow
    type:
      - 'null'
      - boolean
    doc: Build Nextflow applet.
    inputBinding:
      position: 101
      prefix: --nextflow
  - id: publish
    type:
      - 'null'
      - boolean
    doc: Publish the resulting app/globalworkflow and make it the default.
    inputBinding:
      position: 101
      prefix: --publish
  - id: from
    type:
      - 'null'
      - string
    doc: ID or path of the source applet/workflow to create an app/globalworkflow
      from. Source directory src_dir cannot be given when using this option
    inputBinding:
      position: 101
      prefix: --from
  - id: bill_to
    type:
      - 'null'
      - string
    doc: Entity (of the form user-NAME or org-ORGNAME) to bill for the app/globalworkflow.
    inputBinding:
      position: 101
      prefix: --bill-to
  - id: no_version_autonumbering
    type:
      - 'null'
      - boolean
    doc: Only attempt to create the version number supplied in the manifest (that
      is, do not try to create an autonumbered version such as 1.2.3+git.ab1b1c1d
      if 1.2.3 already exists and is published).
    inputBinding:
      position: 101
      prefix: --no-version-autonumbering
  - id: no_update
    type:
      - 'null'
      - boolean
    doc: Never update an existing unpublished app/globalworkflow in place.
    inputBinding:
      position: 101
      prefix: --no-update
  - id: no_temp_build_project
    type:
      - 'null'
      - boolean
    doc: When building an app in a single region, build its applet in the current
      project instead of a temporary project.
    inputBinding:
      position: 101
      prefix: --no-temp-build-project
  - id: 'yes'
    type:
      - 'null'
      - boolean
    doc: Do not ask for confirmation for potentially dangerous operations
    inputBinding:
      position: 101
      prefix: --yes
  - id: region
    type:
      - 'null'
      - string
    doc: Enable the app/globalworkflow in this region. This flag can be specified
      multiple times to enable the app/globalworkflow in multiple regions. If --region
      is not specified, then the enabled region(s) will be determined by 'regionalOptions'
      in dxapp.json, or the project context.
    inputBinding:
      position: 101
      prefix: --region
  - id: destination
    type:
      - 'null'
      - string
    doc: Specifies the destination project, destination folder, and/or name for the
      applet, in the form [PROJECT_NAME_OR_ID:][/[FOLDER/][NAME]]. Overrides the project,
      folder, and name fields of the dxapp.json or dxworkflow.json, if they were supplied.
    inputBinding:
      position: 101
      prefix: --destination
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Remove existing applet(s) of the same name in the destination folder. This
      option is not yet supported for workflows.
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: archive
    type:
      - 'null'
      - boolean
    doc: Archive existing applet(s) of the same name in the destination folder. This
      option is not yet supported for workflows.
    inputBinding:
      position: 101
      prefix: --archive
  - id: profile
    type:
      - 'null'
      - string
    doc: Default profile for the Nextflow pipeline.
    inputBinding:
      position: 101
      prefix: --profile
  - id: repository
    type:
      - 'null'
      - string
    doc: Specifies a Git repository of a Nextflow pipeline. Incompatible with --remote.
    inputBinding:
      position: 101
      prefix: --repository
  - id: repository_tag
    type:
      - 'null'
      - string
    doc: Specifies tag for Git repository. Can be used only with --repository.
    inputBinding:
      position: 101
      prefix: --repository-tag
  - id: git_credentials
    type:
      - 'null'
      - File
    doc: Git credentials used to access Nextflow pipelines from private Git repositories.
      Can be used only with --repository. More information about the file syntax can
      be found at https://www.nextflow.io/blog/2021/conf igure-git-repositories-with-nextflow.html.
    inputBinding:
      position: 101
      prefix: --git-credentials
  - id: cache_docker
    type:
      - 'null'
      - boolean
    doc: Stores a container image tarball in the currently selected project in /.cached_dockerImages.
      Currently only docker engine is supported. Incompatible with --remote, --force,
      --archive, --dry-run, --json.
    inputBinding:
      position: 101
      prefix: --cache-docker
  - id: docker_secrets
    type:
      - 'null'
      - File
    doc: A dx file id with credentials for a private docker repository.
    inputBinding:
      position: 101
      prefix: --docker-secrets
  - id: nextflow_pipeline_params
    type:
      - 'null'
      - string
    doc: Custom pipeline parameters to be referenced when collecting the docker images.
    inputBinding:
      position: 101
      prefix: --nextflow-pipeline-params
  - id: apiserver_host
    type:
      - 'null'
      - string
    doc: API server host (environment override option, see dx --env-help)
    inputBinding:
      position: 101
      prefix: --apiserver-host
  - id: apiserver_port
    type:
      - 'null'
      - string
    doc: API server port (environment override option, see dx --env-help)
    inputBinding:
      position: 101
      prefix: --apiserver-port
  - id: apiserver_protocol
    type:
      - 'null'
      - string
    doc: API server protocol (http or https) (environment override option, see dx
      --env-help)
    inputBinding:
      position: 101
      prefix: --apiserver-protocol
  - id: project_context_id
    type:
      - 'null'
      - string
    doc: Default project or project context ID (environment override option, see dx
      --env-help)
    inputBinding:
      position: 101
      prefix: --project-context-id
  - id: workspace_id
    type:
      - 'null'
      - string
    doc: Workspace ID (for jobs only) (environment override option, see dx --env-help)
    inputBinding:
      position: 101
      prefix: --workspace-id
  - id: security_context
    type:
      - 'null'
      - string
    doc: JSON string of security context (environment override option, see dx --env-help)
    inputBinding:
      position: 101
      prefix: --security-context
  - id: auth_token
    type:
      - 'null'
      - string
    doc: Authentication token (environment override option, see dx --env-help)
    inputBinding:
      position: 101
      prefix: --auth-token
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
stdout: dxpy_dx_build.out
