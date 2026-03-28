[Skip to main content](#main-content)

Back to top

`Ctrl`+`K`

[Neurodocker documentation](../index.html)

* [User Guide](index.html)
* [API Reference](../api.html)

Search
`Ctrl`+`K`

* [GitHub](https://github.com/ReproNim/neurodocker "GitHub")
* [Docker Hub](https://hub.docker.com/r/repronim/neurodocker "Docker Hub")

Search
`Ctrl`+`K`

* [User Guide](index.html)
* [API Reference](../api.html)

* [GitHub](https://github.com/ReproNim/neurodocker "GitHub")
* [Docker Hub](https://hub.docker.com/r/repronim/neurodocker "Docker Hub")

Section Navigation

* [Installation](installation.html)
* [Quickstart](quickstart.html)
* Command-line Interface
* [Examples](examples.html)
* [Common Uses](common_uses.html)
* [Minify Containers](minify.html)
* [Templates and Renderers](templates_renderers.html)
* [Add software to Neurodocker](add_template.html)
* [Known Issues](known_issues.html)

* [User Guide](index.html)
* Command-line Interface

# Command-line Interface[#](#command-line-interface "Permalink to this heading")

Neurodocker provides the command-line program `neurodocker`.
This program has two subcommands: `generate` and `minify`.

## neurodocker[#](#neurodocker "Permalink to this heading")

```
Usage: neurodocker [OPTIONS] COMMAND [ARGS]...

  Generate custom containers, and minify existing containers.

Options:
  --version  Show the version and exit.
  --help     Show this message and exit.

Commands:
  generate     Generate a container.
  genfromjson  Generate a container from a ReproEnv JSON file.
  minify       Minify a container.
```

### neurodocker generate[#](#neurodocker-generate "Permalink to this heading")

```
Usage: neurodocker generate [OPTIONS] COMMAND [ARGS]...

  Generate a container.

Options:
  --template-path DIRECTORY  Path to directories with templates to register
                             [env var: REPROENV_TEMPLATE_PATH]
  --help                     Show this message and exit.

Commands:
  docker       Generate a Dockerfile.
  singularity  Generate a Singularity recipe.
```

The `neurodocker generate` command has two subcommands: docker and singularity.
Most of the arguments for these subcommands are identical, but please check the details below.

#### neurodocker generate docker[#](#neurodocker-generate-docker "Permalink to this heading")

```
Usage: neurodocker generate docker [OPTIONS]

  Generate a Dockerfile.

Options:
  -p, --pkg-manager [yum|apt]  System package manager  [required]
  -b, --base-image TEXT        Base image  [required]
  --arg KEY=VALUE              Build-time variables (do not persist after
                               container is built)
  --copy TUPLE                 Copy files into the container. Provide at least
                               two paths. The last path is always the
                               destination path in the container.
  --add TUPLE                  Extract a tar file as a layer in the container.
                               Provide a source and destination path.
  --env KEY=VALUE              Set persistent environment variables
  --entrypoint TUPLE           Set entrypoint of the container
  --install TUPLE              Install packages with system package manager
  --label KEY=VALUE            Set labels on the container
  --run TEXT                   Run commands in /bin/sh
  --run-bash TEXT              Run commands in a bash shell
  --user TEXT                  Switch to a different user (create user if it
                               does not exist)
  --workdir TEXT               Set the working directory
  --yes                        Reply yes to all prompts.
  --json                       Output instructions as JSON. This can be used
                               to generate Dockerfiles or Singularity recipes
                               with Neurodocker.
  --afni KEY=VALUE             Add afni
                                 method=[binaries|source]
                                 options for method=binaries
                                   - install_path [default: /opt/afni-{{ self.version }}]
                                   - version [default: latest]
                                   - install_r_pkgs [default: false]
                                   - install_python3 [default: false]
                                 options for method=source
                                   - version [required]
                                   - repo [default: https://github.com/afni/afni.git]
                                   - install_path [default: /opt/afni-{{ self.version }}]
                                   - install_r_pkgs [default: false]
                                   - install_python3 [default: false]
  --ants KEY=VALUE             Add ants
                                 method=[binaries|source]
                                 options for method=binaries
                                   - version [required]
                                       version=[2.6.2|2.6.1|2.6.0|2.5.4|2.5.3|2.5.2|2.5.1|2.5.0|2.4.4|2.4.3|2.4.2|2.4.1|2.3.4|2.3.2|2.3.1|2.3.0|2.2.0|2.1.0|2.0.3|2.0.0]
                                   - install_path [default: /opt/ants-{{ self.version }}]
                                 options for method=source
                                   - version [required]
                                   - repo [default: https://github.com/ANTsX/ANTs.git]
                                   - install_path [default: /opt/ants-{{ self.version }}]
                                   - cmake_opts [default: -DCMAKE_INSTALL_PREFIX={{ self.install_path }} -DBUILD_SHARED_LIBS=ON -DBUILD_TESTING=OFF]
                                   - make_opts [default: -j1]
  --bids_validator KEY=VALUE   Add bids_validator
                                 method=[binaries]
                                 options for method=binaries
                                   - version [required]
                                       version=[1.9.0|1.13.0|1.12.0|1.11.0|1.10.0]
                                   - node_version [default: 20]
  --cat12 KEY=VALUE            Add cat12
                                 method=[binaries]
                                 options for method=binaries
                                   - version [required]
                                       version=[r2166_R2017b|r1933_R2017b|12.9_R2023b]
                                   - install_path [default: /opt/CAT12-{{ self.version }}]
  --convert3d KEY=VALUE        Add convert3d
                                 method=[binaries]
                                 options for method=binaries
                                   - version [required]
                                       version=[nightly|1.0.0]
                                   - install_path [default: /opt/convert3d-{{ self.version }}]
  --dcm2niix KEY=VALUE         Add dcm2niix
                                 method=[binaries|source]
                                 options for method=binaries
                                   - version [required]
                                       version=[v1.0.20250506|v1.0.20250505|v1.0.20241211|v1.0.20241208|v1.0.20240202|v1.0.20230411|v1.0.20220720|v1.0.20211006|v1.0.20210317|v1.0.20201102|v1.0.20200331|v1.0.20190902|latest]
                                   - install_path [default: /opt/dcm2niix-{{ self.version }}]
                                 options for method=source
                                   - version [required]
                                   - repo [default: https://github.com/rordenlab/dcm2niix]
                                   - install_path [default: /opt/dcm2niix-{{ self.version }}]
                                   - cmake_opts [default: ]
                                   - make_opts [default: -j1]
  --freesurfer KEY=VALUE       Add freesurfer
                                 method=[binaries]
                                 options for method=binaries
                                   - version [required]
                                       version=[7.4.1|7.3.2|7.3.1|7.3.0|7.2.0|7.1.1-min|7.1.1|7.1.0|6.0.1|6.0.0-min|6.0.0]
                                   - install_path [default: /opt/freesurfer-{{ self.version }}]
                                   - exclude_paths [default: average/mult-comp-cor
                               lib/cuda
                               lib/qt
                               subjects/V1_average
                               subjects/bert
                               subjects/cvs_avg35
                               subjects/cvs_avg35_inMNI152
                               subjects/fsaverage3
                               subjects/fsaverage4
                               subjects/fsaverage5
                               subjects/fsaverage6
                               subjects/fsaverage_sym
                               trctrain
                               ]
  --fsl KEY=VALUE              Add fsl
                                 method=[binaries]
                                 options for method=binaries
                                   - version [required]
                                       version=[6.0.7.8|6.0.7.4|6.0.7.19|6.0.7.18|6.0.7.16|6.0.7.14|6.0.7.1|6.0.6.4|6.0.6.3|6.0.6.2|6.0.6.1|6.0.6|6.0.5.2|6.0.5.1|6.0.5|6.0.4|6.0.3|6.0.2|6.0.1|6.0.0|5.0.9|5.0.8|5.0.11|5.0.10]
                                   - install_path [default: /opt/fsl-{{ self.version }}]
                                   - exclude_paths [default: ]
                               **Note**: FSL is non-free. If you are considering commercial use of FSL, please consult the relevant license(s).
  --jq KEY=VALUE               Add jq
                                 method=[binaries|source]
                                 options for method=binaries
                                   - version [required]
                                       version=[1.7.1|1.7|1.6]
                                 options for method=source
                                   - version [required]
  --matlabmcr KEY=VALUE        Add matlabmcr
                                 method=[binaries]
                                 options for method=binaries
                                   - version [required]
                                       version=[2023b|2023a|2022b|2022a|2021b|2021a|2020b|2020a|2019b|2019a|2018b|2018a|2017b|2017a|2016b|2016a|2015b|2015aSP1|2015a|2014b|2014a|2013b|2013a|2012b|2012a|2010a]
                                   - curl_opts [default: ]
                                   - install_path [default: /opt/MCR-{{ self.version }}]
  --minc KEY=VALUE             Add minc
                                 method=[binaries]
                                 options for method=binaries
                                   - version [required]
                                       version=[1.9.18|1.9.17|1.9.16|1.9.15]
                                   - install_path [default: /opt/minc-{{ self.version }}]
  --miniconda KEY=VALUE        Add miniconda
                                 method=[binaries]
                                 options for method=binaries
                                   - version [required]
                                       version=[latest|*]
                                   - install_path [default: /opt/miniconda-{{ self.version }}]
                                   - installed [default: false]
                                   - env_name [default: base]
                                   - env_exists [default: true]
                                   - conda_install [default: ]
                                   - pip_install [default: ]
                                   - conda_opts [default: ]
                                   - pip_opts [default: ]
                                   - yaml_file [default: ]
                                   - mamba [default: false]
                                   - arch [default: x86_64]
  --mricron KEY=VALUE          Add mricron
                                 method=[binaries]
                                 options for method=binaries
                                   - version [required]
                                       version=[1.0.20190902|1.0.20190410|1.0.20181114|1.0.20180614|1.0.20180404|1.0.20171220]
                                   - install_path [default: /opt/mricron-{{ self.version }}]
  --mrtrix3 KEY=VALUE          Add mrtrix3
                                 method=[binaries|source]
                                 options for method=binaries
                                   - version [required]
                                       version=[3.0.4|3.0.3|3.0.2|3.0.1|3.0.0]
                                   - install_path [default: /opt/mrtrix3-{{ self.version }}]
                                   - build_processes [default: 1]
                                 options for method=source
                                   - version [required]
                                   - repo [default: https://github.com/MRtrix3/mrtrix3.git]
                                   - install_path [default: /opt/mrtrix3-{{ self.version }}]
                                   - build_processes [default: 1]
  --ndfreeze KEY=VALUE         Add ndfreeze
                                 method=[source]
                                 options for method=source
                                   - date [required]
                                   - opts [default: ]
  --neurodebian KEY=VALUE      Add neurodebian
                                 method=[binaries]
                                 options for method=binaries
                                   - os_codename [required]
                                   - version [required]
                                       version=[usa-tn|usa-nh|usa-ca|japan|greece|germany-munich|germany-magdeburg|china-zhejiang|china-tsinghua|china-scitech|australia]
                                   - full_or_libre [default: full]
  --niftyreg KEY=VALUE         Add niftyreg
                                 method=[source]
                                 options for method=source
                                   - version [required]
                                   - repo [default: https://github.com/KCL-BMEIS/niftyreg]
                                   - install_path [default: /opt/niftyreg-{{ self.version }}]
                                   - cmake_opts [default: -DCMAKE_INSTALL_PREFIX={{ self.install_path }} -DBUILD_SHARED_LIBS=ON -DBUILD_TESTING=OFF]
                                   - make_opts [default: -j1]
  --petpvc KEY=VALUE           Add petpvc
                                 method=[binaries]
                                 options for method=binaries
                                   - version [required]
                                       version=[1.2.4|1.2.2|1.2.1|1.2.0-b|1.2.0-a|1.1.0|1.0.0]
                                   - install_path [default: /opt/petpvc-{{ self.version }}]
  --spm12 KEY=VALUE            Add spm12
  