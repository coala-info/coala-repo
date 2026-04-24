cwlVersion: v1.2
class: CommandLineTool
baseCommand: arv-keepdocker
label: arvados-python-client_arv-keepdocker
doc: "Upload or list Docker images in Arvados\n\nTool homepage: https://github.com/curoverse/arvados/tree/main/sdk/python"
inputs:
  - id: image
    type:
      - 'null'
      - string
    doc: 'Docker image to upload: repo, repo:tag, or hash'
    inputBinding:
      position: 1
  - id: tag
    type:
      - 'null'
      - string
    doc: Tag of the Docker image to upload (default 'latest'), if image is given as
      an untagged repo name
    inputBinding:
      position: 2
  - id: batch
    type:
      - 'null'
      - boolean
    doc: Retries with '--no-resume --no-cache' if cached state contains invalid/expired
      block signatures.
    inputBinding:
      position: 103
      prefix: --batch
  - id: batch_progress
    type:
      - 'null'
      - boolean
    doc: Display machine-readable progress on stderr (bytes and, if known, total data
      size).
    inputBinding:
      position: 103
      prefix: --batch-progress
  - id: cache
    type:
      - 'null'
      - boolean
    doc: Save upload state in a cache file for resuming (default).
    inputBinding:
      position: 103
      prefix: --cache
  - id: force
    type:
      - 'null'
      - boolean
    doc: Re-upload the image even if it already exists on the server
    inputBinding:
      position: 103
      prefix: --force
  - id: force_image_format
    type:
      - 'null'
      - boolean
    doc: Proceed even if the image format is not supported by the server
    inputBinding:
      position: 103
      prefix: --force-image-format
  - id: name
    type:
      - 'null'
      - string
    doc: Save the collection with the specified name.
    inputBinding:
      position: 103
      prefix: --name
  - id: no_cache
    type:
      - 'null'
      - boolean
    doc: Do not save upload state in a cache file for resuming.
    inputBinding:
      position: 103
      prefix: --no-cache
  - id: no_progress
    type:
      - 'null'
      - boolean
    doc: Do not display human-readable progress on stderr, even if stderr is a tty.
    inputBinding:
      position: 103
      prefix: --no-progress
  - id: no_pull
    type:
      - 'null'
      - boolean
    doc: Use locally installed image only, don't pull image from Docker registry (default)
    inputBinding:
      position: 103
      prefix: --no-pull
  - id: no_resume
    type:
      - 'null'
      - boolean
    doc: Do not continue interrupted uploads from cached state.
    inputBinding:
      position: 103
      prefix: --no-resume
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Display human-readable progress on stderr (bytes and, if possible, percentage
      of total data size). This is the default behavior when stderr is a tty.
    inputBinding:
      position: 103
      prefix: --progress
  - id: project_uuid
    type:
      - 'null'
      - string
    doc: Store the collection in the specified project, instead of your Home project.
    inputBinding:
      position: 103
      prefix: --project-uuid
  - id: pull
    type:
      - 'null'
      - boolean
    doc: Try to pull the latest image from Docker registry
    inputBinding:
      position: 103
      prefix: --pull
  - id: resume
    type:
      - 'null'
      - boolean
    doc: Continue interrupted uploads from cached state (default).
    inputBinding:
      position: 103
      prefix: --resume
  - id: retries
    type:
      - 'null'
      - int
    doc: Maximum number of times to retry server requests that encounter temporary
      failures (e.g., server down). Default 10.
    inputBinding:
      position: 103
      prefix: --retries
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Do not print any debug messages to console. (Any error messages will still
      be displayed.)
    inputBinding:
      position: 103
      prefix: --silent
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arvados-python-client:3.2.0--pyh7e72e81_0
stdout: arvados-python-client_arv-keepdocker.out
