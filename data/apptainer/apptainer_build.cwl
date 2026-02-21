cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - apptainer
  - build
label: apptainer_build
doc: "Build an Apptainer image\n\nTool homepage: https://github.com/apptainer/apptainer"
inputs:
  - id: build_spec
    type: string
    doc: The build spec target (definition file, local image, or URI)
    inputBinding:
      position: 1
  - id: bind
    type:
      - 'null'
      - type: array
        items: string
    doc: a user-bind path specification. spec has the format src[:dest[:opts]]
    inputBinding:
      position: 102
      prefix: --bind
  - id: build_arg
    type:
      - 'null'
      - type: array
        items: string
    doc: defines variable=value to replace {{ variable }} entries in build definition
      file
    inputBinding:
      position: 102
      prefix: --build-arg
  - id: build_arg_file
    type:
      - 'null'
      - File
    doc: specifies a file containing variable=value lines to replace '{{ variable
      }}' with value
    inputBinding:
      position: 102
      prefix: --build-arg-file
  - id: disable_cache
    type:
      - 'null'
      - boolean
    doc: do not use cache or create cache
    inputBinding:
      position: 102
      prefix: --disable-cache
  - id: docker_host
    type:
      - 'null'
      - string
    doc: specify a custom Docker daemon host
    inputBinding:
      position: 102
      prefix: --docker-host
  - id: docker_login
    type:
      - 'null'
      - boolean
    doc: login to a Docker Repository interactively
    inputBinding:
      position: 102
      prefix: --docker-login
  - id: encrypt
    type:
      - 'null'
      - boolean
    doc: build an image with an encrypted file system
    inputBinding:
      position: 102
      prefix: --encrypt
  - id: fakeroot
    type:
      - 'null'
      - boolean
    doc: build with the appearance of running as root
    inputBinding:
      position: 102
      prefix: --fakeroot
  - id: fix_perms
    type:
      - 'null'
      - boolean
    doc: ensure owner has rwX permissions on all container content for oci/docker
      sources
    inputBinding:
      position: 102
      prefix: --fix-perms
  - id: force
    type:
      - 'null'
      - boolean
    doc: overwrite an image file if it exists
    inputBinding:
      position: 102
      prefix: --force
  - id: json
    type:
      - 'null'
      - boolean
    doc: interpret build definition as JSON
    inputBinding:
      position: 102
      prefix: --json
  - id: library
    type:
      - 'null'
      - string
    doc: container Library URL
    inputBinding:
      position: 102
      prefix: --library
  - id: mount
    type:
      - 'null'
      - type: array
        items: string
    doc: a mount specification e.g. 'type=bind,source=/opt,destination=/hostopt'
    inputBinding:
      position: 102
      prefix: --mount
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: do NOT clean up bundle after failed build
    inputBinding:
      position: 102
      prefix: --no-cleanup
  - id: no_https
    type:
      - 'null'
      - boolean
    doc: use http instead of https for docker:// oras:// and library:// URIs
    inputBinding:
      position: 102
      prefix: --no-https
  - id: notest
    type:
      - 'null'
      - boolean
    doc: build without running tests in %test section
    inputBinding:
      position: 102
      prefix: --notest
  - id: nv
    type:
      - 'null'
      - boolean
    doc: inject host Nvidia libraries during build for post and test sections
    inputBinding:
      position: 102
      prefix: --nv
  - id: nvccli
    type:
      - 'null'
      - boolean
    doc: use nvidia-container-cli for GPU setup (experimental)
    inputBinding:
      position: 102
      prefix: --nvccli
  - id: passphrase
    type:
      - 'null'
      - boolean
    doc: prompt for an encryption passphrase
    inputBinding:
      position: 102
      prefix: --passphrase
  - id: pem_path
    type:
      - 'null'
      - File
    doc: enter an path to a PEM formatted RSA key for an encrypted container
    inputBinding:
      position: 102
      prefix: --pem-path
  - id: rocm
    type:
      - 'null'
      - boolean
    doc: inject host Rocm libraries during build for post and test sections
    inputBinding:
      position: 102
      prefix: --rocm
  - id: sandbox
    type:
      - 'null'
      - boolean
    doc: build image as sandbox format (chroot directory structure)
    inputBinding:
      position: 102
      prefix: --sandbox
  - id: section
    type:
      - 'null'
      - type: array
        items: string
    doc: only run specific section(s) of deffile (setup, post, files, environment,
      test, labels, none)
    default: all
    inputBinding:
      position: 102
      prefix: --section
  - id: update
    type:
      - 'null'
      - boolean
    doc: run definition over existing container (skips header)
    inputBinding:
      position: 102
      prefix: --update
  - id: userns
    type:
      - 'null'
      - boolean
    doc: build without using setuid even if available
    inputBinding:
      position: 102
      prefix: --userns
  - id: warn_unused_build_args
    type:
      - 'null'
      - boolean
    doc: shows warning instead of fatal message when build args are not exact matched
    inputBinding:
      position: 102
      prefix: --warn-unused-build-args
  - id: writable_tmpfs
    type:
      - 'null'
      - boolean
    doc: during the %test section, makes the file system accessible as read-write
      with non persistent data
    inputBinding:
      position: 102
      prefix: --writable-tmpfs
outputs:
  - id: image_path
    type: File
    doc: Path to the output image or sandbox directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/apptainer:latest
