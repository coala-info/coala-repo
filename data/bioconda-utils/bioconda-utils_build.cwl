cwlVersion: v1.2
class: CommandLineTool
baseCommand: bioconda-utils build
label: bioconda-utils_build
doc: "Build packages for Bioconda.\n\nTool homepage: http://bioconda.github.io/build-system.html"
inputs:
  - id: recipe_folder
    type:
      - 'null'
      - Directory
    doc: Path to folder containing recipes
    default: recipes/
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - File
    doc: Path to Bioconda config
    default: config.yml
    inputBinding:
      position: 2
  - id: anaconda_upload
    type:
      - 'null'
      - boolean
    doc: After building recipes, upload them to Anaconda. This requires 
      $ANACONDA_TOKEN to be set.
    inputBinding:
      position: 103
      prefix: --anaconda-upload
  - id: build_image
    type:
      - 'null'
      - boolean
    doc: Build temporary docker build image with conda/conda-build version 
      matching local versions
    inputBinding:
      position: 103
      prefix: --build-image
  - id: build_script_template
    type:
      - 'null'
      - File
    doc: Filename to optionally replace build script template used by the Docker
      container. By default use docker_utils.BUILD_SCRIPT_TEMPLATE. Only used if
      --docker is True.
    default: '-'
    inputBinding:
      position: 103
      prefix: --build-script-template
  - id: check_channels
    type:
      - 'null'
      - type: array
        items: string
    doc: Channels to check recipes against before building. Any recipe already 
      present in one of these channels will be skipped. The default is the first
      two channels specified in the config file. Note that this is ignored if 
      you specify --git-range.
    default: '-'
    inputBinding:
      position: 103
      prefix: --check-channels
  - id: disable_live_logs
    type:
      - 'null'
      - boolean
    doc: Disable live logging during the build process
    inputBinding:
      position: 103
      prefix: --disable-live-logs
  - id: docker
    type:
      - 'null'
      - boolean
    doc: Build packages in docker container.
    inputBinding:
      position: 103
      prefix: --docker
  - id: docker_base_image
    type:
      - 'null'
      - string
    doc: Name of base image that can be used in Dockerfile template.
    default: '-'
    inputBinding:
      position: 103
      prefix: --docker-base-image
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Packages to exclude during this run
    default: '-'
    inputBinding:
      position: 103
      prefix: --exclude
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force building the recipe even if it already exists in the bioconda 
      channel. If --force is specified, --git-range is ignored and only those 
      packages matching --packages globs will be built.
    inputBinding:
      position: 103
      prefix: --force
  - id: git_range
    type:
      - 'null'
      - type: array
        items: string
    doc: Git range (e.g. commits or something like "master HEAD" to check 
      commits in HEAD vs master, or just "HEAD" to include uncommitted changes).
      All recipes modified within this range will be built if not present in the
      channel.
    default: '-'
    inputBinding:
      position: 103
      prefix: --git-range
  - id: keep_image
    type:
      - 'null'
      - boolean
    doc: After building recipes, the created Docker image is removed by default 
      to save disk space. Use this argument to disable this behavior.
    inputBinding:
      position: 103
      prefix: --keep-image
  - id: keep_old_work
    type:
      - 'null'
      - boolean
    doc: Do not remove anything from environment, even after successful build 
      and test.
    inputBinding:
      position: 103
      prefix: --keep-old-work
  - id: lint
    type:
      - 'null'
      - boolean
    doc: Just before each recipe, apply the linting functions to it. This can be
      used as an alternative to linting all recipes before any building takes 
      place with the `bioconda-utils lint` command.
    inputBinding:
      position: 103
      prefix: --lint
  - id: lint_exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude this linting function. Can be used multiple times.
    default: '-'
    inputBinding:
      position: 103
      prefix: --lint-exclude
  - id: log_command_max_lines
    type:
      - 'null'
      - int
    doc: Limit lines emitted for commands executed
    default: '-'
    inputBinding:
      position: 103
      prefix: --log-command-max-lines
  - id: logfile
    type:
      - 'null'
      - File
    doc: Write log to file
    default: '-'
    inputBinding:
      position: 103
      prefix: --logfile
  - id: logfile_level
    type:
      - 'null'
      - string
    doc: Log level for log file
    default: debug
    inputBinding:
      position: 103
      prefix: --logfile-level
  - id: loglevel
    type:
      - 'null'
      - string
    doc: Set logging level (debug, info, warning, error, critical)
    default: info
    inputBinding:
      position: 103
      prefix: --loglevel
  - id: mulled_conda_image
    type:
      - 'null'
      - string
    doc: Conda Docker image to install the package with during the mulled based 
      tests.
    default: quay.io/bioconda/create-env:latest
    inputBinding:
      position: 103
      prefix: --mulled-conda-image
  - id: mulled_test
    type:
      - 'null'
      - boolean
    doc: Run a mulled-build test on the built package
    inputBinding:
      position: 103
      prefix: --mulled-test
  - id: mulled_upload_target
    type:
      - 'null'
      - string
    doc: Provide a quay.io target to push mulled docker images to.
    default: '-'
    inputBinding:
      position: 103
      prefix: --mulled-upload-target
  - id: n_workers
    type:
      - 'null'
      - int
    doc: The number of parallel workers that are in use. This is intended for 
      use in cases such as the "bulk" branch, where there are multiple parallel 
      workers building and uploading recipes. In essence, this causes 
      bioconda-utils to process every Nth sub-DAG, where N is the value you give
      to this option. The default is 1, which is intended for cases where there 
      are NOT parallel workers (i.e., the majority of cases). This should 
      generally NOT be used in conjunctions with the --packages or --git-range 
      options!
    default: 1
    inputBinding:
      position: 103
      prefix: --n-workers
  - id: packages
    type:
      - 'null'
      - type: array
        items: string
    doc: Glob for package[s] to build. Default is to build all packages. Can be 
      specified more than once
    default: '*'
    inputBinding:
      position: 103
      prefix: --packages
  - id: pkg_dir
    type:
      - 'null'
      - Directory
    doc: Specifies the directory to which container-built packages should be 
      stored on the host. Default is to use the host's conda-bld dir. If 
      --docker is not specified, then this argument is ignored.
    default: '-'
    inputBinding:
      position: 103
      prefix: --pkg-dir
  - id: prelint
    type:
      - 'null'
      - boolean
    doc: Just before each recipe, apply the linting functions to it. This can be
      used as an alternative to linting all recipes before any building takes 
      place with the `bioconda-utils lint` command.
    inputBinding:
      position: 103
      prefix: --prelint
  - id: record_build_failures
    type:
      - 'null'
      - boolean
    doc: Record build failures in build_failure.yaml next to the recipe.
    inputBinding:
      position: 103
      prefix: --record-build-failures
  - id: skiplist_leafs
    type:
      - 'null'
      - boolean
    doc: Skiplist leaf recipes (i.e. ones that are not depended on by any other 
      recipes) that fail to build.
    inputBinding:
      position: 103
      prefix: --skiplist-leafs
  - id: subdag_depth
    type:
      - 'null'
      - int
    doc: Number of levels of root nodes to skip. (Optional, and only if using 
      n_workers)
    default: '-'
    inputBinding:
      position: 103
      prefix: --subdag-depth
  - id: testonly
    type:
      - 'null'
      - boolean
    doc: Test packages instead of building
    inputBinding:
      position: 103
      prefix: --testonly
  - id: worker_offset
    type:
      - 'null'
      - int
    doc: This is only used if --nWorkers is >1. In that case, then each instance
      of bioconda-utils will process every Nth sub-DAG. This option gives the 
      0-based offset for that. For example, if "--n-workers 5 --worker-offset 0"
      is used, then this instance of bioconda-utils will process the 1st, 6th, 
      11th, etc. sub-DAGs. Equivalently, using "--n-workers 5 --worker-offset 1"
      will result in sub-DAGs 2, 7, 12, etc. being processed. If you use more 
      than one worker, then make sure to give each a different offset!
    default: 0
    inputBinding:
      position: 103
      prefix: --worker-offset
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
stdout: bioconda-utils_build.out
