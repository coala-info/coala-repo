cwlVersion: v1.2
class: CommandLineTool
baseCommand: galaxy-job-config-init
label: galaxy-job-config-init
doc: "Generate job configuration YAML.\n\nTool homepage: https://github.com/galaxyproject/galaxy-job-config-init"
inputs:
  - id: all_in_one_handling
    type:
      - 'null'
      - boolean
    doc: Use all-in-one job handling configuration. No separate processes are 
      required to handle jobs or workflows. Recommended for temporary or single 
      user Galaxy instances such as created by planemo.
    inputBinding:
      position: 101
      prefix: --all-in-one-handling
  - id: docker
    type:
      - 'null'
      - boolean
    doc: Enable Docker.
    inputBinding:
      position: 101
      prefix: --docker
  - id: docker_cmd
    type:
      - 'null'
      - string
    doc: Command used to launch docker (defaults to 'docker').
    inputBinding:
      position: 101
      prefix: --docker-cmd
  - id: docker_extra_volume
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra Docker volumes.
    inputBinding:
      position: 101
      prefix: --docker-extra-volume
  - id: docker_host
    type:
      - 'null'
      - string
    doc: Docker host.
    inputBinding:
      position: 101
      prefix: --docker-host
  - id: docker_run_extra_arguments
    type:
      - 'null'
      - string
    doc: Extra arguments for Docker run.
    inputBinding:
      position: 101
      prefix: --docker-run-extra-arguments
  - id: docker_sudo
    type:
      - 'null'
      - boolean
    doc: Use sudo with Docker.
    inputBinding:
      position: 101
      prefix: --docker-sudo
  - id: docker_sudo_cmd
    type:
      - 'null'
      - string
    doc: Docker sudo command.
    inputBinding:
      position: 101
      prefix: --docker-sudo-cmd
  - id: galaxy_version
    type:
      - 'null'
      - string
    doc: Generate job config YAML for this version of Galaxy.
    inputBinding:
      position: 101
      prefix: --galaxy-version
  - id: runner
    type:
      - 'null'
      - string
    doc: Galaxy runner (e.g. DRM) to target (defaults to 'local' requiring no 
      external resource manager).
    inputBinding:
      position: 101
      prefix: --runner
  - id: singularity
    type:
      - 'null'
      - boolean
    doc: Enable Singularity.
    inputBinding:
      position: 101
      prefix: --singularity
  - id: singularity_cmd
    type:
      - 'null'
      - string
    doc: Command used to execute singularity (defaults to 'singularity').
    inputBinding:
      position: 101
      prefix: --singularity-cmd
  - id: singularity_extra_volume
    type:
      - 'null'
      - type: array
        items: string
    doc: Extra Singularity volumes.
    inputBinding:
      position: 101
      prefix: --singularity-extra-volume
  - id: singularity_sudo
    type:
      - 'null'
      - boolean
    doc: Use sudo with Singularity.
    inputBinding:
      position: 101
      prefix: --singularity-sudo
  - id: singularity_sudo_cmd
    type:
      - 'null'
      - string
    doc: Singularity sudo command.
    inputBinding:
      position: 101
      prefix: --singularity-sudo-cmd
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Configure temporary directory handling. Use 'true' for Galaxy-managed 
      temp dirs, or specify shell commands/variables for custom temp directory 
      allocation (e.g., '$DRM_VAR' or '$(mktemp -d /scratch/gxyXXXXXX)'). 
      Defaults to true.
    inputBinding:
      position: 101
      prefix: --tmp-dir
  - id: tpv
    type:
      - 'null'
      - boolean
    doc: Enable shared TPV database.
    inputBinding:
      position: 101
      prefix: --tpv
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/galaxy-job-config-init:0.1.3--pyhdfd78af_0
stdout: galaxy-job-config-init.out
