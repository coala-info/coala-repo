cwlVersion: v1.2
class: CommandLineTool
baseCommand: [neurodocker, generate, docker]
label: neurodocker_generate_docker
doc: "Generate a Dockerfile from the given options.\n\nTool homepage: https://github.com/kaczmarj/neurodocker"
inputs:
  - id: base
    type:
      - 'null'
      - string
    doc: "Base Docker image, for example debian:stretch."
    inputBinding:
      position: 10
      prefix: --base
  - id: pkg_manager
    type:
      - 'null'
      - type: enum
        symbols: [apt, yum]
        name: neurodocker_docker_pkg_manager
    doc: Linux package manager.
    inputBinding:
      position: 11
      prefix: --pkg-manager
  - id: add_to_entrypoint
    type:
      - 'null'
      - string
    doc: "Add a command to the file /neurodocker/startup.sh, which is the default entrypoint."
    inputBinding:
      position: 12
      prefix: --add-to-entrypoint
  - id: copy
    type:
      - 'null'
      - type: array
        items: string
    doc: "Copy files into the container. Use format <src>... <dest>."
    inputBinding:
      position: 13
      prefix: --copy
  - id: install
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install system packages with apt-get or yum."
    inputBinding:
      position: 14
      prefix: --install
  - id: entrypoint
    type:
      - 'null'
      - string
    doc: "Set the container entrypoint (Docker) or append to the runscript (Singularity)."
    inputBinding:
      position: 15
      prefix: --entrypoint
  - id: env
    type:
      - 'null'
      - type: array
        items: string
    doc: "Set environment variables, format KEY=VALUE."
    inputBinding:
      position: 16
      prefix: --env
  - id: run
    type:
      - 'null'
      - string
    doc: "Run a command when building the container."
    inputBinding:
      position: 17
      prefix: --run
  - id: run_bash
    type:
      - 'null'
      - string
    doc: "Run a command in bash."
    inputBinding:
      position: 18
      prefix: --run-bash
  - id: user
    type:
      - 'null'
      - string
    doc: "Switch current user (creates the user if necessary)."
    inputBinding:
      position: 19
      prefix: --user
  - id: workdir
    type:
      - 'null'
      - string
    doc: "Set working directory."
    inputBinding:
      position: 20
      prefix: --workdir
  - id: json
    type:
      - 'null'
      - boolean
    doc: "Print the Neurodocker JSON spec."
    inputBinding:
      position: 21
      prefix: --json
  - id: output
    type:
      - 'null'
      - string
    doc: "Save the generated file with this name."
    inputBinding:
      position: 22
      prefix: --output
  - id: no_print
    type:
      - 'null'
      - boolean
    doc: "Do not print the generated file."
    inputBinding:
      position: 23
      prefix: --no-print
  - id: afni
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install AFNI. Keys: version (required), method, install_path, install_r, install_r_pkgs, install_python2, install_python3. Each item is a key=value pair."
    inputBinding:
      position: 24
      prefix: --afni
  - id: ants
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install ANTs. Keys: version (required), method, install_path, cmake_opts, make_opts. Each item is a key=value pair."
    inputBinding:
      position: 25
      prefix: --ants
  - id: convert3d
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install Convert3D. Keys: version (required), method, install_path. Each item is a key=value pair."
    inputBinding:
      position: 26
      prefix: --convert3d
  - id: dcm2niix
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install dcm2niix. Keys: version, method, install_path, cmake_opts, make_opts. Each item is a key=value pair."
    inputBinding:
      position: 27
      prefix: --dcm2niix
  - id: freesurfer
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install FreeSurfer. Keys: version (required), method, install_path, exclude_paths. Each item is a key=value pair."
    inputBinding:
      position: 28
      prefix: --freesurfer
  - id: fsl
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install FSL. Keys: version (required), method, install_path, exclude_paths. Each item is a key=value pair."
    inputBinding:
      position: 29
      prefix: --fsl
  - id: matlabmcr
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install Matlab Compiler Runtime. Keys: version, method, install_path. Each item is a key=value pair."
    inputBinding:
      position: 30
      prefix: --matlabmcr
  - id: minc
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install MINC. Keys: version (required), method, install_path. Each item is a key=value pair."
    inputBinding:
      position: 31
      prefix: --minc
  - id: miniconda
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install Miniconda. Keys: install_path, env_name, conda_install, pip_install, conda_opts, pip_opts, activate, version. Each item is a key=value pair."
    inputBinding:
      position: 32
      prefix: --miniconda
  - id: mrtrix3
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install MRtrix3. Keys: version (required), method, install_path. Each item is a key=value pair."
    inputBinding:
      position: 33
      prefix: --mrtrix3
  - id: ndfreeze
    type:
      - 'null'
      - type: array
        items: string
    doc: "Freeze the apt sources to a date with nd_freeze. Key: date. Each item is a key=value pair."
    inputBinding:
      position: 34
      prefix: --ndfreeze
  - id: neurodebian
    type:
      - 'null'
      - type: array
        items: string
    doc: "Add the NeuroDebian repository. Keys: os_codename, server, full. Each item is a key=value pair."
    inputBinding:
      position: 35
      prefix: --neurodebian
  - id: petpvc
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install PETPVC. Keys: version (required), method, install_path. Each item is a key=value pair."
    inputBinding:
      position: 36
      prefix: --petpvc
  - id: spm12
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install SPM12 and Matlab Compiler Runtime. Keys: version, install_path. Each item is a key=value pair."
    inputBinding:
      position: 37
      prefix: --spm12
  - id: vnc
    type:
      - 'null'
      - type: array
        items: string
    doc: "Install a VNC server. Keys: passwd (required), start_at_runtime, geometry. Each item is a key=value pair."
    inputBinding:
      position: 38
      prefix: --vnc
  - id: add
    type:
      - 'null'
      - type: array
        items: string
    doc: "Dockerfile ADD instruction. Use format <src>... <dest>."
    inputBinding:
      position: 39
      prefix: --add
  - id: arg
    type:
      - 'null'
      - type: array
        items: string
    doc: "Dockerfile ARG instruction, KEY[=DEFAULT_VALUE]."
    inputBinding:
      position: 40
      prefix: --arg
  - id: cmd
    type:
      - 'null'
      - type: array
        items: string
    doc: "Dockerfile CMD instruction."
    inputBinding:
      position: 41
      prefix: --cmd
  - id: expose
    type:
      - 'null'
      - type: array
        items: string
    doc: "Dockerfile EXPOSE instruction."
    inputBinding:
      position: 42
      prefix: --expose
  - id: label
    type:
      - 'null'
      - type: array
        items: string
    doc: "Dockerfile LABEL instruction."
    inputBinding:
      position: 43
      prefix: --label
  - id: volume
    type:
      - 'null'
      - type: array
        items: string
    doc: "Dockerfile VOLUME instruction."
    inputBinding:
      position: 44
      prefix: --volume
  - id: json_spec_file
    type:
      - 'null'
      - File
    doc: Generate the file from a JSON spec. Overrides the other generate arguments.
    inputBinding:
      position: 100
outputs:
  - id: stdout
    type: stdout
    doc: The generated recipe printed on standard output.
  - id: output_file
    type:
      - 'null'
      - File
    doc: The recipe saved with the output option.
    outputBinding:
      glob: |-
        ${ return inputs.output ? inputs.output : null; }
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neurodocker:0.5.0--py_0
stdout: neurodocker_generate_docker.out
