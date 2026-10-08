cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dx
  - run
label: dxpy_dx_run
doc: 'Run an applet, app, or workflow.  To see a list of executables you can run,
  hit <TAB> twice after "dx run" or run "dx find apps" or "dx find globalworkflows"
  to see a list of available apps and global workflows.  If any inputs are required
  but not specified, an interactive mode for selecting inputs will be launched.  Inputs
  can be set in multiple ways.  Run "dx run --input-help" for more details.  Run "dx
  run --instance-type-help" to see a list of specifications for computers available
  to run executables.


  Tool homepage: https://github.com/dnanexus/dx-toolkit'
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: executable
    type:
      - 'null'
      - string
    doc: Name or ID of an applet, app, or workflow to run; must be provided if --clone
      is not set
    inputBinding:
      position: 1
  - id: inputs_spec
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --input
    doc: An input to be added using "<input name>[:<class>]=<input value>" (provide
      "class" if there is no input spec; it can be any job IO class, e.g. "string",
      "array:string", or "array"; if "class" is "array" or not specified, the value
      will be attempted to be parsed as JSON and is otherwise treated as a string)
    inputBinding:
      position: 101
  - id: input_json
    type:
      - 'null'
      - string
    doc: The full input JSON (keys=input field names, values=input field values)
    inputBinding:
      position: 101
      prefix: --input-json
  - id: input_json_file
    type:
      - 'null'
      - File
    doc: Load input JSON from FILENAME ("-" to use stdin)
    inputBinding:
      position: 101
      prefix: --input-json-file
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
  - id: extra_args
    type:
      - 'null'
      - string
    doc: Arguments (in JSON format) to pass to the underlying API method, overriding
      the default settings
    inputBinding:
      position: 101
      prefix: --extra-args
  - id: instance_type
    type:
      - 'null'
      - string
    doc: When running an app or applet, the mapping lists executable's entry points
      or "*" as keys, and instance types to use for these entry points as values.
      When running a workflow, the specified instance types can be prefixed by a stage
      name or stage index followed by "=" to apply to a specific stage, or apply to
      all workflow stages without such prefix. The instance type corresponding to
      the "*" key is applied to all entry points not explicitly mentioned in the --instance-type
      mapping. Specifying a single instance type is equivalent to using it for all
      entry points, so "--instance-type mem1_ssd1_v2_x2" is same as "--instance-type
      '{"*":"mem1_ssd1_v2_x2"}'. Note that "dx run" calls within the execution subtree
      may override the values specified at the root of the execution tree. See dx
      run --instance-type-help for details.
    inputBinding:
      position: 101
      prefix: --instance-type
  - id: instance_type_by_executable
    type:
      - 'null'
      - string
    doc: 'Specifies instance types by app or applet id, then by entry point within
      the executable. The order of priority for this specification is: * --instance-type,
      systemRequirements and stageSystemRequirements specified at runtime * stage''s
      systemRequirements, systemRequirements supplied to /app/new and /applet/new
      at workflow/app/applet build time * systemRequirementsByExecutable specified
      in downstream executions (if any) See dx run --instance-type-help for details.'
    inputBinding:
      position: 101
      prefix: --instance-type-by-executable
  - id: instance_type_help
    type:
      - 'null'
      - boolean
    doc: Print help for specifying instance types
    inputBinding:
      position: 101
      prefix: --instance-type-help
  - id: property
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --property
    doc: Key-value pair to add as a property; repeat as necessary, e.g. "--property
      key1=val1 --property key2=val2"
    inputBinding:
      position: 101
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --tag
    doc: Tag for the resulting execution; repeat as necessary, e.g. "--tag tag1 --tag
      tag2"
    inputBinding:
      position: 101
  - id: depends_on
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --depends-on
    doc: ID of job, analysis, or data object that must be in the "done" or "closed"
      state, as appropriate, before this executable can be run; repeat as necessary
      (e.g. "--depends-on id1 ... --depends-on idN"). Cannot be supplied when running
      workflows
    inputBinding:
      position: 101
  - id: clone
    type:
      - 'null'
      - string
    doc: Job or analysis ID or name from which to use as default options (will use
      the exact same executable ID, destination project and folder, job input, instance
      type requests, and a similar name unless explicitly overridden by command-line
      arguments. When using an analysis with --clone a workflow executable cannot
      be overriden and should not be provided.)
    inputBinding:
      position: 101
      prefix: --clone
  - id: alias
    type:
      - 'null'
      - string
    doc: 'Alias (tag) or version of the app to run (default: "default" if an app)'
    inputBinding:
      position: 101
      prefix: --alias
  - id: destination
    type:
      - 'null'
      - string
    doc: The full project:folder path in which to output the results. By default,
      the current working directory will be used.
    inputBinding:
      position: 101
      prefix: --destination
  - id: batch_folders
    type:
      - 'null'
      - boolean
    doc: Output results to separate folders, one per batch, using batch ID as the
      name of the output folder. The batch output folder location will be relative
      to the path set in --destination
    inputBinding:
      position: 101
      prefix: --batch-folders
  - id: project
    type:
      - 'null'
      - string
    doc: Project name or ID in which to run the executable. This can also be specified
      together with the output folder in --destination.
    inputBinding:
      position: 101
      prefix: --project
  - id: stage_output_folder
    type:
      - 'null'
      - string
    doc: A stage identifier (ID, name, or index), and a folder path to use as its
      output folder
    inputBinding:
      position: 101
      prefix: --stage-output-folder
  - id: stage_relative_output_folder
    type:
      - 'null'
      - string
    doc: A stage identifier (ID, name, or index), and a relative folder path to the
      workflow output folder to use as the output folder
    inputBinding:
      position: 101
      prefix: --stage-relative-output-folder
  - id: name
    type:
      - 'null'
      - string
    doc: Name for the job (default is the app or applet name)
    inputBinding:
      position: 101
      prefix: --name
  - id: delay_workspace_destruction
    type:
      - 'null'
      - boolean
    doc: Whether to keep the job's temporary workspace around for debugging purposes
      for 3 days after it succeeds or fails
    inputBinding:
      position: 101
      prefix: --delay-workspace-destruction
  - id: priority
    type:
      - 'null'
      - string
    doc: Request a scheduling priority for all resulting jobs. Defaults to high when
      --watch, --ssh, or --allow-ssh flags are used.
    inputBinding:
      position: 101
      prefix: --priority
  - id: head_job_on_demand
    type:
      - 'null'
      - boolean
    doc: Requests that the head job of an app or applet be run in an on-demand instance.
      Note that --head-job-on-demand option will override the --priority setting for
      the head job
    inputBinding:
      position: 101
      prefix: --head-job-on-demand
  - id: 'yes'
    type:
      - 'null'
      - boolean
    doc: Do not ask for confirmation
    inputBinding:
      position: 101
      prefix: --yes
  - id: wait
    type:
      - 'null'
      - boolean
    doc: Wait until the job is done before returning
    inputBinding:
      position: 101
      prefix: --wait
  - id: watch
    type:
      - 'null'
      - boolean
    doc: Watch the job after launching it. Defaults --priority to high.
    inputBinding:
      position: 101
      prefix: --watch
  - id: allow_ssh
    type:
      - 'null'
      - string
    doc: Configure the job to allow SSH access. Defaults --priority to high. If an
      argument is supplied, it is interpreted as an IP range, e.g. "--allow-ssh 1.2.3.4".
      If no argument is supplied then the client IP visible to the DNAnexus API server
      will be used by default
    inputBinding:
      position: 101
      prefix: --allow-ssh
  - id: ssh
    type:
      - 'null'
      - boolean
    doc: Configure the job to allow SSH access and connect to it after launching.
      Defaults --priority to high.
    inputBinding:
      position: 101
      prefix: --ssh
  - id: ssh_proxy
    type:
      - 'null'
      - string
    doc: SSH connect via proxy, argument supplied is used as the proxy address and
      port
    inputBinding:
      position: 101
      prefix: --ssh-proxy
  - id: debug_on
    type:
      - 'null'
      - string
    doc: Configure the job to hold for debugging when any of the listed errors occur
    inputBinding:
      position: 101
      prefix: --debug-on
  - id: ignore_reuse
    type:
      - 'null'
      - boolean
    doc: Disable job reuse for execution
    inputBinding:
      position: 101
      prefix: --ignore-reuse
  - id: ignore_reuse_stage
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ignore-reuse-stage
    doc: A stage (using its ID, name, or index) for which job reuse should be disabled,
      if a stage points to another (nested) workflow the ignore reuse option will
      be applied to the whole subworkflow. This option overwrites any ignoreReuse
      fields set on app(let)s or the workflow during build time; repeat as necessary
    inputBinding:
      position: 101
  - id: rerun_stage
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --rerun-stage
    doc: A stage (using its ID, name, or index) to rerun, or "*" to indicate all stages
      should be rerun; repeat as necessary
    inputBinding:
      position: 101
  - id: batch_tsv
    type:
      - 'null'
      - File
    doc: A file in tab separated value (tsv) format, with a subset of the executable
      input arguments. A job will be launched for each table row.
    inputBinding:
      position: 101
      prefix: --batch-tsv
  - id: instance_count
    type:
      - 'null'
      - string
    doc: 'Specify spark cluster instance count(s). It can be an int or a mapping of
      the format ''{"entrypoint": <number of instances>}'''
    inputBinding:
      position: 101
      prefix: --instance-count
  - id: input_help
    type:
      - 'null'
      - boolean
    doc: Print help and examples for how to specify inputs
    inputBinding:
      position: 101
      prefix: --input-help
  - id: detach
    type:
      - 'null'
      - boolean
    doc: When invoked from a job, detaches the new job from the creator job so the
      new job will appear as a typical root execution. Setting DX_RUN_DETACH environment
      variable to 1 causes this option to be set by default.
    inputBinding:
      position: 101
      prefix: --detach
  - id: cost_limit
    type:
      - 'null'
      - string
    doc: Maximum cost of the job before termination. In case of workflows it is cost
      of the entire analysis job. For batch run, this limit is applied per job.
    inputBinding:
      position: 101
      prefix: --cost-limit
  - id: rank
    type:
      - 'null'
      - string
    doc: Set the rank of the root execution, integer between -1024 and 1023. Requires
      executionRankEnabled license feature for the billTo. Default is 0.
    inputBinding:
      position: 101
      prefix: --rank
  - id: max_tree_spot_wait_time
    type:
      - 'null'
      - string
    doc: The amount of time allocated to each path in the root execution's tree to
      wait for Spot (in seconds, or use suffix s, m, h, d, w, M, y)
    inputBinding:
      position: 101
      prefix: --max-tree-spot-wait-time
  - id: max_job_spot_wait_time
    type:
      - 'null'
      - string
    doc: The amount of time allocated to each job in the root execution's tree to
      wait for Spot (in seconds, or use suffix s, m, h, d, w, M, y)
    inputBinding:
      position: 101
      prefix: --max-job-spot-wait-time
  - id: detailed_job_metrics
    type:
      - 'null'
      - boolean
    doc: Collect CPU, memory, network and disk metrics every 60 seconds
    inputBinding:
      position: 101
      prefix: --detailed-job-metrics
  - id: preserve_job_outputs
    type:
      - 'null'
      - boolean
    doc: Copy cloneable outputs of every non-reused job entering "done" state in this
      root execution R into the "intermediateJobOutputs" subfolder under R's output
      folder.  As R's root job or root analysis' stages complete, R's regular outputs
      will be moved to R's regular output folder.
    inputBinding:
      position: 101
      prefix: --preserve-job-outputs
  - id: preserve_job_outputs_folder
    type:
      - 'null'
      - string
    doc: Similar to --preserve-job-outputs, copy cloneable outputs of every non-reused
      job entering "done" state in this root execution to the specified folder in
      the project.  JOB_OUTPUTS_FOLDER starting with '/' refers to an absolute path
      within the project, otherwise, it refers to a subfolder under root execution's
      output folder.
    inputBinding:
      position: 101
      prefix: --preserve-job-outputs-folder
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
stdout: dxpy_dx_run.out
