# neurodocker CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| neurodocker_generate_docker | PASS | Dockerfile checked for the requested base, packages, env, ANTs and miniconda |
| neurodocker_generate_singularity | PASS | recipe checked for base image, environment and miniconda |
| neurodocker_reprozip_merge | Failed | image problem: rsync is missing in the image (RuntimeError) |
| neurodocker_reprozip_trace | Failed | image problem: the docker python package is missing (ImportError), and it needs a running container |

## neurodocker_generate_docker

### Tool Description
Generate a Dockerfile.

### Metadata
- **Docker Image**: quay.io/biocontainers/neurodocker:0.5.0--py_0
- **Homepage**: https://github.com/kaczmarj/neurodocker
- **Package**: https://anaconda.org/channels/bioconda/packages/neurodocker/overview
- **Validation**: PASS

### Original Help Text
```text
usage: neurodocker generate docker [-h] [-b BASE] [-p {yum,apt}]
                                   [--add-to-entrypoint ADD_TO_ENTRYPOINT]
                                   [--copy COPY [COPY ...]]
                                   [--install INSTALL [INSTALL ...]]
                                   [--entrypoint ENTRYPOINT]
                                   [-e ENV [ENV ...]] [-r RUN]
                                   [--run-bash RUN_BASH] [-u USER]
                                   [-w WORKDIR] [--json] [-o OUTPUT]
                                   [--no-print] [--afni  [...]]
                                   [--ants  [...]] [--convert3d  [...]]
                                   [--dcm2niix  [...]] [--freesurfer  [...]]
                                   [--fsl  [...]] [--matlabmcr  [...]]
                                   [--minc  [...]] [--miniconda  [...]]
                                   [--mrtrix3 [[...]]] [--ndfreeze  [...]]
                                   [--neurodebian  [...]] [--petpvc  [...]]
                                   [--spm12  [...]] [--vnc  [...]]
                                   [--add ADD [ADD ...]] [--arg ARG [ARG ...]]
                                   [--cmd CMD [CMD ...]]
                                   [--expose EXPOSE [EXPOSE ...]]
                                   [--label LABEL [LABEL ...]]
                                   [--volume VOLUME [VOLUME ...]]
                                   [file]

positional arguments:
  file                  Generate file from JSON. Overrides other `generate`
                        arguments

optional arguments:
  -h, --help            show this help message and exit
  -b BASE, --base BASE  Base Docker image. E.g., debian:stretch
  -p {yum,apt}, --pkg-manager {yum,apt}
                        Linux package manager.
  --add-to-entrypoint ADD_TO_ENTRYPOINT
                        Add a command to the file /neurodocker/startup.sh,
                        which is the container's default entrypoint.
  --copy COPY [COPY ...]
                        Copy files into container. Use format <src>... <dest>
  --install INSTALL [INSTALL ...]
                        Install system packages with apt-get or yum, depending
                        on the package manager specified.
  --entrypoint ENTRYPOINT
                        Set the container's entrypoint (Docker) / append to
                        runscript (Singularity)
  -e ENV [ENV ...], --env ENV [ENV ...]
                        Set environment variable(s). Use the format KEY=VALUE
  -r RUN, --run RUN     Run a command when building container
  --run-bash RUN_BASH   Run a command in bash
  -u USER, --user USER  Switch current user (creates user if necessary)
  -w WORKDIR, --workdir WORKDIR
                        Set working directory
  --json                Print Neurodocker JSON spec
  -o OUTPUT, --output OUTPUT
                        If specified, save Dockerfile to file with this name.
  --no-print            Do not print the generated file
  --add ADD [ADD ...]   Dockerfile ADD instruction. Use format <src>... <dest>
  --arg ARG [ARG ...]   Dockerfile ARG instruction. Use format
                        KEY[=DEFAULT_VALUE] ...
  --cmd CMD [CMD ...]   Dockerfile CMD instruction.
  --expose EXPOSE [EXPOSE ...]
                        Dockerfile EXPOSE instruction.
  --label LABEL [LABEL ...]
                        Dockerfile LABEL instruction.
  --volume VOLUME [VOLUME ...]
                        Dockerfile VOLUME instruction.

software package arguments:
  Install software packages. Each argument takes a list of key=value pairs.
  Where applicable, the default installation behavior is to install by
  downloading and uncompressing binaries. Some programs can be built from
  source.

  --afni  [ ...]        Install AFNI. Valid keys are version (required),
                        method, install_path, install_r, install_r_pkgs,
                        install_python2, and install_python3. Only the latest
                        version and version 17.2.02 are supported at this
                        time.
  --ants  [ ...]        Install ANTs. Valid keys are version (required),
                        method install_path, cmake_opts, and make_opts.
                        Version can be a git commit hash if building from
                        source.
  --convert3d  [ ...]   Install Convert3D. Valid keys are version (required),
                        method, and install_path.
  --dcm2niix  [ ...]    Install dcm2niix. Valid keys are version, method,
                        install_path, cmake_opts, and make_opts
  --freesurfer  [ ...]  Install FreeSurfer. Valid keys are version (required),
                        method, install_path, and exclude_paths. A FreeSurfer
                        license is required to run the software and is not
                        provided by Neurodocker.
  --fsl  [ ...]         Install FSL. Valid keys are version (required),
                        method, install_path, and exclude_paths.
  --matlabmcr  [ ...]   Install Matlab Compiler Runtime. Valid keys are
                        version, method, and install_path
  --minc  [ ...]        Install MINC. Valid keys is version (required),
                        method, and install_path. Only version 1.9.15 is
                        supported at this time.
  --miniconda  [ ...]   Install Miniconda. Valid keys are install_path,
                        env_name, conda_install, pip_install, conda_opts,
                        pip_opts, activate (default false), and version
                        (defaults to latest). The options conda_install and
                        pip_install accept strings of packages:
                        conda_install="python=3.6 numpy traits".
  --mrtrix3 [ [ ...]]   Install MRtrix3. Valid keys are version (required),
                        method, and install_path
  --ndfreeze  [ ...]    Use the NeuroDebian command `nd_freeze` to freeze the
                        apt sources to a certain date. This will only have an
                        effect on Debian and NeuroDebian APT sources.
  --neurodebian  [ ...]
                        Add NeuroDebian repository. Valid keys are os_codename
                        (e.g., zesty), server (e.g., usa-nh), and full (if
                        true, use non-free packages). Valid download servers
                        are australia, china-tsinghua, china-scitech, china-
                        zhejiang, germany-munich, germany-magdeburg, greece,
                        japan, usa-ca, usa-nh, usa-tn.
  --petpvc  [ ...]      Install PETPVC. Valid keys are version (required),
                        method, and install_path.
  --spm12  [ ...]       Install SPM12 and its dependency, Matlab Compiler
                        Runtime. Valid keys are version and install_path.
  --vnc  [ ...]         Install a VNC server. Valid keys are passwd
                        (required), start_at_runtime, and geometry.
```

## neurodocker_generate_singularity

### Tool Description
Generate a Singularity recipe.

### Metadata
- **Docker Image**: quay.io/biocontainers/neurodocker:0.5.0--py_0
- **Homepage**: https://github.com/kaczmarj/neurodocker
- **Package**: https://anaconda.org/channels/bioconda/packages/neurodocker/overview
- **Validation**: PASS

### Original Help Text
```text
usage: neurodocker generate singularity [-h] [-b BASE] [-p {yum,apt}]
                                        [--add-to-entrypoint ADD_TO_ENTRYPOINT]
                                        [--copy COPY [COPY ...]]
                                        [--install INSTALL [INSTALL ...]]
                                        [--entrypoint ENTRYPOINT]
                                        [-e ENV [ENV ...]] [-r RUN]
                                        [--run-bash RUN_BASH] [-u USER]
                                        [-w WORKDIR] [--json] [-o OUTPUT]
                                        [--no-print] [--afni  [...]]
                                        [--ants  [...]] [--convert3d  [...]]
                                        [--dcm2niix  [...]]
                                        [--freesurfer  [...]] [--fsl  [...]]
                                        [--matlabmcr  [...]] [--minc  [...]]
                                        [--miniconda  [...]]
                                        [--mrtrix3 [[...]]]
                                        [--ndfreeze  [...]]
                                        [--neurodebian  [...]]
                                        [--petpvc  [...]] [--spm12  [...]]
                                        [--vnc  [...]]
                                        [file]

positional arguments:
  file                  Generate file from JSON. Overrides other `generate`
                        arguments

optional arguments:
  -h, --help            show this help message and exit
  -b BASE, --base BASE  Base Docker image. E.g., debian:stretch
  -p {yum,apt}, --pkg-manager {yum,apt}
                        Linux package manager.
  --add-to-entrypoint ADD_TO_ENTRYPOINT
                        Add a command to the file /neurodocker/startup.sh,
                        which is the container's default entrypoint.
  --copy COPY [COPY ...]
                        Copy files into container. Use format <src>... <dest>
  --install INSTALL [INSTALL ...]
                        Install system packages with apt-get or yum, depending
                        on the package manager specified.
  --entrypoint ENTRYPOINT
                        Set the container's entrypoint (Docker) / append to
                        runscript (Singularity)
  -e ENV [ENV ...], --env ENV [ENV ...]
                        Set environment variable(s). Use the format KEY=VALUE
  -r RUN, --run RUN     Run a command when building container
  --run-bash RUN_BASH   Run a command in bash
  -u USER, --user USER  Switch current user (creates user if necessary)
  -w WORKDIR, --workdir WORKDIR
                        Set working directory
  --json                Print Neurodocker JSON spec
  -o OUTPUT, --output OUTPUT
                        If specified, save Dockerfile to file with this name.
  --no-print            Do not print the generated file

software package arguments:
  Install software packages. Each argument takes a list of key=value pairs.
  Where applicable, the default installation behavior is to install by
  downloading and uncompressing binaries. Some programs can be built from
  source.

  --afni  [ ...]        Install AFNI. Valid keys are version (required),
                        method, install_path, install_r, install_r_pkgs,
                        install_python2, and install_python3. Only the latest
                        version and version 17.2.02 are supported at this
                        time.
  --ants  [ ...]        Install ANTs. Valid keys are version (required),
                        method install_path, cmake_opts, and make_opts.
                        Version can be a git commit hash if building from
                        source.
  --convert3d  [ ...]   Install Convert3D. Valid keys are version (required),
                        method, and install_path.
  --dcm2niix  [ ...]    Install dcm2niix. Valid keys are version, method,
                        install_path, cmake_opts, and make_opts
  --freesurfer  [ ...]  Install FreeSurfer. Valid keys are version (required),
                        method, install_path, and exclude_paths. A FreeSurfer
                        license is required to run the software and is not
                        provided by Neurodocker.
  --fsl  [ ...]         Install FSL. Valid keys are version (required),
                        method, install_path, and exclude_paths.
  --matlabmcr  [ ...]   Install Matlab Compiler Runtime. Valid keys are
                        version, method, and install_path
  --minc  [ ...]        Install MINC. Valid keys is version (required),
                        method, and install_path. Only version 1.9.15 is
                        supported at this time.
  --miniconda  [ ...]   Install Miniconda. Valid keys are install_path,
                        env_name, conda_install, pip_install, conda_opts,
                        pip_opts, activate (default false), and version
                        (defaults to latest). The options conda_install and
                        pip_install accept strings of packages:
                        conda_install="python=3.6 numpy traits".
  --mrtrix3 [ [ ...]]   Install MRtrix3. Valid keys are version (required),
                        method, and install_path
  --ndfreeze  [ ...]    Use the NeuroDebian command `nd_freeze` to freeze the
                        apt sources to a certain date. This will only have an
                        effect on Debian and NeuroDebian APT sources.
  --neurodebian  [ ...]
                        Add NeuroDebian repository. Valid keys are os_codename
                        (e.g., zesty), server (e.g., usa-nh), and full (if
                        true, use non-free packages). Valid download servers
                        are australia, china-tsinghua, china-scitech, china-
                        zhejiang, germany-munich, germany-magdeburg, greece,
                        japan, usa-ca, usa-nh, usa-tn.
  --petpvc  [ ...]      Install PETPVC. Valid keys are version (required),
                        method, and install_path.
  --spm12  [ ...]       Install SPM12 and its dependency, Matlab Compiler
                        Runtime. Valid keys are version and install_path.
  --vnc  [ ...]         Install a VNC server. Valid keys are passwd
                        (required), start_at_runtime, and geometry.
```

## neurodocker_reprozip_trace

### Tool Description
Trace commands in a running container with ReproZip.

### Metadata
- **Docker Image**: quay.io/biocontainers/neurodocker:0.5.0--py_0
- **Homepage**: https://github.com/kaczmarj/neurodocker
- **Package**: https://anaconda.org/channels/bioconda/packages/neurodocker/overview
- **Validation**: PASS

### Original Help Text
```text
usage: neurodocker reprozip trace [-h] [--dir PACKFILE_SAVE_DIR]
                                  [-v {debug,info,warning,error,critical}]
                                  container commands [commands ...]

positional arguments:
  container             Running container in which to trace commands.
  commands              Command(s) to trace.

optional arguments:
  -h, --help            show this help message and exit
  --dir PACKFILE_SAVE_DIR, -d PACKFILE_SAVE_DIR
                        Directory in which to save pack file. Default is
                        current directory.
  -v {debug,info,warning,error,critical}, --verbosity {debug,info,warning,error,critical}
```

## neurodocker_reprozip_merge

### Tool Description
Merge ReproZip pack files.

### Metadata
- **Docker Image**: quay.io/biocontainers/neurodocker:0.5.0--py_0
- **Homepage**: https://github.com/kaczmarj/neurodocker
- **Package**: https://anaconda.org/channels/bioconda/packages/neurodocker/overview
- **Validation**: PASS

### Original Help Text
```text
usage: neurodocker reprozip merge [-h]
                                  [-v {debug,info,warning,error,critical}]
                                  outfile pack_files [pack_files ...]

positional arguments:
  outfile               Filepath to merged pack file.
  pack_files            Pack files to merge.

optional arguments:
  -h, --help            show this help message and exit
  -v {debug,info,warning,error,critical}, --verbosity {debug,info,warning,error,critical}
```

## Metadata
- **Skill**: generated
