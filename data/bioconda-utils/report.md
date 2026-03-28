# bioconda-utils CWL Generation Report

## bioconda-utils_build

### Tool Description
Build packages for Bioconda.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
- **Homepage**: http://bioconda.github.io/build-system.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Total Downloads**: 271.6K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/bioconda/bioconda-utils
- **Stars**: N/A
### Original Help Text
```text
usage: bioconda-utils build [-h] [--packages PACKAGES [PACKAGES ...]]
                            [-g GIT_RANGE [GIT_RANGE ...]] [-t] [-f]
                            [--docker] [--mulled-test]
                            [--build-script-template BUILD_SCRIPT_TEMPLATE]
                            [--pkg-dir PKG_DIR] [-a]
                            [--mulled-upload-target MULLED_UPLOAD_TARGET]
                            [--build-image] [--keep-image] [--lint]
                            [--lint-exclude LINT_EXCLUDE [LINT_EXCLUDE ...]]
                            [-c CHECK_CHANNELS [CHECK_CHANNELS ...]]
                            [-n N_WORKERS] [-w WORKER_OFFSET]
                            [--keep-old-work]
                            [--mulled-conda-image MULLED_CONDA_IMAGE]
                            [--docker-base-image DOCKER_BASE_IMAGE] [-r]
                            [--skiplist-leafs] [--disable-live-logs]
                            [-e EXCLUDE [EXCLUDE ...]]
                            [--subdag-depth SUBDAG_DEPTH]
                            [--loglevel LOGLEVEL] [--logfile LOGFILE]
                            [--logfile-level LOGFILE_LEVEL]
                            [--log-command-max-lines LOG_COMMAND_MAX_LINES]
                            [recipe-folder] [config]

positional arguments:
  recipe-folder         Path to folder containing recipes (default: recipes/)
                        (default: -)
  config                Path to Bioconda config (default: config.yml)
                        (default: -)

options:
  -h, --help            show this help message and exit
  --packages PACKAGES [PACKAGES ...]
                        Glob for package[s] to build. Default is to build all
                        packages. Can be specified more than once (default:
                        '*')
  -g GIT_RANGE [GIT_RANGE ...], --git-range GIT_RANGE [GIT_RANGE ...]
                        Git range (e.g. commits or something like "master
                        HEAD" to check commits in HEAD vs master, or just
                        "HEAD" to include uncommitted changes). All recipes
                        modified within this range will be built if not
                        present in the channel. (default: -)
  -t, --testonly        Test packages instead of building (default: False)
  -f, --force           Force building the recipe even if it already exists in
                        the bioconda channel. If --force is specified, --git-
                        range is ignored and only those packages matching
                        --packages globs will be built. (default: False)
  --docker              Build packages in docker container. (default: -)
  --mulled-test         Run a mulled-build test on the built package (default:
                        False)
  --build-script-template BUILD_SCRIPT_TEMPLATE
                        Filename to optionally replace build script template
                        used by the Docker container. By default use
                        docker_utils.BUILD_SCRIPT_TEMPLATE. Only used if
                        --docker is True. (default: -)
  --pkg-dir PKG_DIR     Specifies the directory to which container-built
                        packages should be stored on the host. Default is to
                        use the host's conda-bld dir. If --docker is not
                        specified, then this argument is ignored. (default: -)
  -a, --anaconda-upload
                        After building recipes, upload them to Anaconda. This
                        requires $ANACONDA_TOKEN to be set. (default: False)
  --mulled-upload-target MULLED_UPLOAD_TARGET
                        Provide a quay.io target to push mulled docker images
                        to. (default: -)
  --build-image         Build temporary docker build image with conda/conda-
                        build version matching local versions (default: False)
  --keep-image          After building recipes, the created Docker image is
                        removed by default to save disk space. Use this
                        argument to disable this behavior. (default: False)
  --lint, --prelint     Just before each recipe, apply the linting functions
                        to it. This can be used as an alternative to linting
                        all recipes before any building takes place with the
                        `bioconda-utils lint` command. (default: False)
  --lint-exclude LINT_EXCLUDE [LINT_EXCLUDE ...]
                        Exclude this linting function. Can be used multiple
                        times. (default: -)
  -c CHECK_CHANNELS [CHECK_CHANNELS ...], --check-channels CHECK_CHANNELS [CHECK_CHANNELS ...]
                        Channels to check recipes against before building. Any
                        recipe already present in one of these channels will
                        be skipped. The default is the first two channels
                        specified in the config file. Note that this is
                        ignored if you specify --git-range. (default: -)
  -n N_WORKERS, --n-workers N_WORKERS
                        The number of parallel workers that are in use. This
                        is intended for use in cases such as the "bulk"
                        branch, where there are multiple parallel workers
                        building and uploading recipes. In essence, this
                        causes bioconda-utils to process every Nth sub-DAG,
                        where N is the value you give to this option. The
                        default is 1, which is intended for cases where there
                        are NOT parallel workers (i.e., the majority of
                        cases). This should generally NOT be used in
                        conjunctions with the --packages or --git-range
                        options! (default: 1)
  -w WORKER_OFFSET, --worker-offset WORKER_OFFSET
                        This is only used if --nWorkers is >1. In that case,
                        then each instance of bioconda-utils will process
                        every Nth sub-DAG. This option gives the 0-based
                        offset for that. For example, if "--n-workers 5
                        --worker-offset 0" is used, then this instance of
                        bioconda-utils will process the 1st, 6th, 11th, etc.
                        sub-DAGs. Equivalently, using "--n-workers 5 --worker-
                        offset 1" will result in sub-DAGs 2, 7, 12, etc. being
                        processed. If you use more than one worker, then make
                        sure to give each a different offset! (default: 0)
  --keep-old-work       Do not remove anything from environment, even after
                        successful build and test. (default: False)
  --mulled-conda-image MULLED_CONDA_IMAGE
                        Conda Docker image to install the package with during
                        the mulled based tests. (default:
                        'quay.io/bioconda/create-env:latest')
  --docker-base-image DOCKER_BASE_IMAGE
                        Name of base image that can be used in Dockerfile
                        template. (default: -)
  -r, --record-build-failures
                        Record build failures in build_failure.yaml next to
                        the recipe. (default: False)
  --skiplist-leafs      Skiplist leaf recipes (i.e. ones that are not depended
                        on by any other recipes) that fail to build. (default:
                        False)
  --disable-live-logs   Disable live logging during the build process
                        (default: False)
  -e EXCLUDE [EXCLUDE ...], --exclude EXCLUDE [EXCLUDE ...]
                        Packages to exclude during this run (default: -)
  --subdag-depth SUBDAG_DEPTH
                        Number of levels of root nodes to skip. (Optional, and
                        only if using n_workers) (default: -)
  --loglevel LOGLEVEL   Set logging level (debug, info, warning, error,
                        critical) (default: 'info')
  --logfile LOGFILE     Write log to file (default: -)
  --logfile-level LOGFILE_LEVEL
                        Log level for log file (default: 'debug')
  --log-command-max-lines LOG_COMMAND_MAX_LINES
                        Limit lines emitted for commands executed (default: -)
```


## bioconda-utils_dag

### Tool Description
Export the DAG of packages to a graph format file for visualization

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
- **Homepage**: http://bioconda.github.io/build-system.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconda-utils dag [-h] [-p PACKAGES [PACKAGES ...]] [-f {gml,dot,txt}]
                          [--hide-singletons] [--loglevel LOGLEVEL]
                          [--logfile LOGFILE] [--logfile-level LOGFILE_LEVEL]
                          [--log-command-max-lines LOG_COMMAND_MAX_LINES]
                          [recipe-folder] [config]

Export the DAG of packages to a graph format file for visualization

positional arguments:
  recipe-folder         Path to folder containing recipes (default: recipes/)
                        (default: -)
  config                Path to Bioconda config (default: config.yml)
                        (default: -)

options:
  -h, --help            show this help message and exit
  -p PACKAGES [PACKAGES ...], --packages PACKAGES [PACKAGES ...]
                        Glob for package[s] to show in DAG. Default is to show
                        all packages. Can be specified more than once
                        (default: '*')
  -f {gml,dot,txt}, --format {gml,dot,txt}
                        Set format to print graph. "gml" and "dot" can be
                        imported into graph visualization tools (graphviz,
                        gephi, cytoscape). "txt" will print out recipes
                        grouped by independent subdags, largest subdag first,
                        each in topologically sorted order. Singleton subdags
                        (if not hidden with --hide-singletons) are reported as
                        one large group at the end. (default: 'gml')
  --hide-singletons     Hide singletons in the printed graph. (default: False)
  --loglevel LOGLEVEL   Set logging level (debug, info, warning, error,
                        critical) (default: 'info')
  --logfile LOGFILE     Write log to file (default: -)
  --logfile-level LOGFILE_LEVEL
                        Log level for log file (default: 'debug')
  --log-command-max-lines LOG_COMMAND_MAX_LINES
                        Limit lines emitted for commands executed (default: -)
```


## bioconda-utils_dependent

### Tool Description
Print recipes dependent on a package

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
- **Homepage**: http://bioconda.github.io/build-system.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconda-utils dependent [-h] [--restrict]
                                [-d DEPENDENCIES [DEPENDENCIES ...]]
                                [--reverse-dependencies REVERSE_DEPENDENCIES [REVERSE_DEPENDENCIES ...]]
                                [--loglevel LOGLEVEL] [--logfile LOGFILE]
                                [--logfile-level LOGFILE_LEVEL]
                                [--log-command-max-lines LOG_COMMAND_MAX_LINES]
                                [recipe-folder] [config]

Print recipes dependent on a package

positional arguments:
  recipe-folder         Path to folder containing recipes (default: recipes/)
                        (default: -)
  config                Path to Bioconda config (default: config.yml)
                        (default: -)

options:
  -h, --help            show this help message and exit
  --restrict            Restrict --dependencies to packages in
                        `recipe_folder`. Has no effect if --reverse-
                        dependencies, which always looks just in the recipe
                        dir. (default: False)
  -d DEPENDENCIES [DEPENDENCIES ...], --dependencies DEPENDENCIES [DEPENDENCIES ...]
                        Return recipes in `recipe_folder` in the dependency
                        chain for the packages listed here. Answers the
                        question "what does PACKAGE need?" (default: -)
  --reverse-dependencies REVERSE_DEPENDENCIES [REVERSE_DEPENDENCIES ...]
                        Return recipes in `recipe_folder` in the reverse
                        dependency chain for packages listed here. Answers the
                        question "what depends on PACKAGE?" (default: -)
  --loglevel LOGLEVEL   Set logging level (debug, info, warning, error,
                        critical) (default: 'info')
  --logfile LOGFILE     Write log to file (default: -)
  --logfile-level LOGFILE_LEVEL
                        Log level for log file (default: 'debug')
  --log-command-max-lines LOG_COMMAND_MAX_LINES
                        Limit lines emitted for commands executed (default: -)
```


## bioconda-utils_lint

### Tool Description
Lint recipes

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
- **Homepage**: http://bioconda.github.io/build-system.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconda-utils lint [-h] [--packages PACKAGES [PACKAGES ...]]
                           [--cache CACHE] [--list-checks]
                           [-e EXCLUDE [EXCLUDE ...]] [--push-status]
                           [-u USER] [--commit COMMIT] [--push-comment]
                           [--pull-request PULL_REQUEST] [-r REPO]
                           [-g GIT_RANGE [GIT_RANGE ...]] [-f] [-t] [--pdb]
                           [--loglevel LOGLEVEL] [--logfile LOGFILE]
                           [--logfile-level LOGFILE_LEVEL]
                           [--log-command-max-lines LOG_COMMAND_MAX_LINES]
                           [recipe-folder] [config]

Lint recipes

If --push-status is not set, reports a TSV of linting results to stdout.
Otherwise pushes a commit status to the specified commit on github.

positional arguments:
  recipe-folder         Path to folder containing recipes (default: recipes/)
                        (default: -)
  config                Path to Bioconda config (default: config.yml)
                        (default: -)

options:
  -h, --help            show this help message and exit
  --packages PACKAGES [PACKAGES ...]
                        Glob for package[s] to build. Default is to build all
                        packages. Can be specified more than once (default:
                        '*')
  --cache CACHE         To speed up debugging, use repodata cached locally in
                        the provided filename. If the file does not exist, it
                        will be created the first time. (default: -)
  --list-checks         List the linting functions to be used and then exit
                        (default: False)
  -e EXCLUDE [EXCLUDE ...], --exclude EXCLUDE [EXCLUDE ...]
                        Exclude this linting function. Can be used multiple
                        times. (default: -)
  --push-status         If set, the lint status will be sent to the current
                        commit on github. Also needs --user and --repo to be
                        set. Requires the env var GITHUB_TOKEN to be set. Note
                        that pull requests from forks will not have access to
                        encrypted variables on ci, so this feature may be of
                        limited use. (default: False)
  -u USER, --user USER  Github user (default: 'bioconda')
  --commit COMMIT       Commit on github on which to update status (default:
                        -)
  --push-comment        If set, the lint status will be posted as a comment in
                        the corresponding pull request (given by --pull-
                        request). Also needs --user and --repo to be set.
                        Requires the env var GITHUB_TOKEN to be set. (default:
                        False)
  --pull-request PULL_REQUEST
                        Pull request id on github on which to post a comment.
                        (default: -)
  -r REPO, --repo REPO  Github repo (default: 'bioconda-recipes')
  -g GIT_RANGE [GIT_RANGE ...], --git-range GIT_RANGE [GIT_RANGE ...]
                        Git range (e.g. commits or something like "master
                        HEAD" to check commits in HEAD vs master, or just
                        "HEAD" to include uncommitted changes). All recipes
                        modified within this range will be built if not
                        present in the channel. (default: -)
  -f, --full-report     Default behavior is to summarize the linting results;
                        use this argument to get the full results as a TSV
                        printed to stdout. (default: False)
  -t, --try-fix         Attempt to fix problems where found (default: False)
  --pdb, -P             Drop into debugger on exception (default: False)
  --loglevel LOGLEVEL   Set logging level (debug, info, warning, error,
                        critical) (default: 'info')
  --logfile LOGFILE     Write log to file (default: -)
  --logfile-level LOGFILE_LEVEL
                        Log level for log file (default: 'debug')
  --log-command-max-lines LOG_COMMAND_MAX_LINES
                        Limit lines emitted for commands executed (default: -)
```


## bioconda-utils_duplicates

### Tool Description
Detect packages in bioconda that have duplicates in the other defined channels.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
- **Homepage**: http://bioconda.github.io/build-system.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconda-utils duplicates [-h] [--strict-version] [--strict-build] [-d]
                                 [-r] [-u] [-c CHANNEL] [--loglevel LOGLEVEL]
                                 [--logfile LOGFILE]
                                 [--logfile-level LOGFILE_LEVEL]
                                 [--log-command-max-lines LOG_COMMAND_MAX_LINES]
                                 config

Detect packages in bioconda that have duplicates in the other defined
channels.

positional arguments:
  config                Path to yaml file specifying the configuration

options:
  -h, --help            show this help message and exit
  --strict-version      Require version to strictly match. (default: False)
  --strict-build        Require version and build to strictly match. (default:
                        False)
  -d, --dryrun, -n      Only print removal plan. (default: False)
  -r, --remove          Remove packages from anaconda. (default: False)
  -u, --url             Print anaconda urls. (default: False)
  -c CHANNEL, --channel CHANNEL
                        Channel to check for duplicates (default: 'bioconda')
  --loglevel LOGLEVEL   Set logging level (debug, info, warning, error,
                        critical) (default: 'info')
  --logfile LOGFILE     Write log to file (default: -)
  --logfile-level LOGFILE_LEVEL
                        Log level for log file (default: 'debug')
  --log-command-max-lines LOG_COMMAND_MAX_LINES
                        Limit lines emitted for commands executed (default: -)
```


## bioconda-utils_update-pinning

### Tool Description
Bump a package build number and all dependencies as required due to a change in pinnings

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
- **Homepage**: http://bioconda.github.io/build-system.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconda-utils update-pinning [-h] [--packages PACKAGES [PACKAGES ...]]
                                     [--skip-additional-channels [SKIP_ADDITIONAL_CHANNELS ...]]
                                     [--skip-variants [SKIP_VARIANTS ...]]
                                     [-m MAX_BUMPS] [-n] [-c CACHE] [--pdb]
                                     [-t THREADS] [--loglevel LOGLEVEL]
                                     [--logfile LOGFILE]
                                     [--logfile-level LOGFILE_LEVEL]
                                     [--log-command-max-lines LOG_COMMAND_MAX_LINES]
                                     [recipe-folder] [config]

Bump a package build number and all dependencies as required due
to a change in pinnings

positional arguments:
  recipe-folder         Path to folder containing recipes (default: recipes/)
                        (default: -)
  config                Path to Bioconda config (default: config.yml)
                        (default: -)

options:
  -h, --help            show this help message and exit
  --packages PACKAGES [PACKAGES ...]
                        Glob for package[s] to update, as needed due to a
                        change in pinnings (default: '*')
  --skip-additional-channels [SKIP_ADDITIONAL_CHANNELS ...]
                        Skip updating/bumping packges that are already built
                        with compatible pinnings in one of the given channels
                        in addition to those listed in 'config'. (default: -)
  --skip-variants [SKIP_VARIANTS ...]
                        Skip packages that use one of the given variant keys.
                        (default: -)
  -m MAX_BUMPS, --max-bumps MAX_BUMPS
                        Maximum number of recipes that will be updated.
                        (default: -)
  -n, --no-leaves       Only update recipes with dependent packages. (default:
                        False)
  -c CACHE, --cache CACHE
                        To speed up debugging, use repodata cached locally in
                        the provided filename. If the file does not exist, it
                        will be created the first time. (default: -)
  --pdb, -P             Drop into debugger on exception (default: False)
  -t THREADS, --threads THREADS
                        Limit maximum number of processes used. (default: 16)
  --loglevel LOGLEVEL   Set logging level (debug, info, warning, error,
                        critical) (default: 'info')
  --logfile LOGFILE     Write log to file (default: -)
  --logfile-level LOGFILE_LEVEL
                        Log level for log file (default: 'debug')
  --log-command-max-lines LOG_COMMAND_MAX_LINES
                        Limit lines emitted for commands executed (default: -)
```


## bioconda-utils_bioconductor-skeleton

### Tool Description
Build a Bioconductor recipe. The recipe will be created in the 'recipes' directory and will be prefixed by "bioconductor-". If --recursive is set, then any R dependency recipes will be prefixed by "r-".

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
- **Homepage**: http://bioconda.github.io/build-system.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconda-utils bioconductor-skeleton [-h] [-v] [-f] [-p PKG_VERSION]
                                            [-b BIOC_VERSION] [-r]
                                            [-s [SKIP_IF_IN_CHANNELS ...]]
                                            [--loglevel LOGLEVEL]
                                            [--logfile LOGFILE]
                                            [--logfile-level LOGFILE_LEVEL]
                                            [--log-command-max-lines LOG_COMMAND_MAX_LINES]
                                            [recipe-folder] [config] package
                                            [bioc-data-packages]

Build a Bioconductor recipe. The recipe will be created in the 'recipes'
directory and will be prefixed by "bioconductor-". If --recursive is set,
then any R dependency recipes will be prefixed by "r-".

These R recipes must be evaluated on a case-by-case basis to determine if
they are relevant to biology (in which case they should be submitted to
bioconda) or not (submit to conda-forge).

Biology-related:
    'bioconda-utils clean-cran-skeleton <recipe> --no-windows'
    and submit to Bioconda.

Not bio-related:
    'bioconda-utils clean-cran-skeleton <recipe>'
    and submit to conda-forge.

positional arguments:
  recipe-folder         Path to folder containing recipes (default: recipes/)
                        (default: -)
  config                Path to Bioconda config (default: config.yml)
                        (default: -)
  package               Bioconductor package name. This is case-sensitive, and
                        must match the package name on the Bioconductor site.
                        If "update-all-packages" is specified, then all
                        packages in a given bioconductor release will be
                        created/updated (--force is then implied).
  bioc-data-packages    Path to folder containing the recipe for the
                        bioconductor-data-packages (default:
                        recipes/bioconductor-data-packages) (default: -)

options:
  -h, --help            show this help message and exit
  -v, --versioned       If specified, recipe will be created in
                        RECIPES/<package>/<version> (default: False)
  -f, --force           Overwrite the contents of an existing recipe. If
                        --recursive is also used, then overwrite *all* recipes
                        created. (default: False)
  -p PKG_VERSION, --pkg-version PKG_VERSION
                        Package version to use instead of the current one
                        (default: -)
  -b BIOC_VERSION, --bioc-version BIOC_VERSION
                        Version of Bioconductor to target. If not specified,
                        then automatically finds the latest version of
                        Bioconductor with the specified version in --pkg-
                        version, or if --pkg-version not specified, then finds
                        the the latest package version in the latest
                        Bioconductor version (default: -)
  -r, --recursive       Creates the recipes for all Bioconductor and CRAN
                        dependencies of the specified package. (default:
                        False)
  -s [SKIP_IF_IN_CHANNELS ...], --skip-if-in-channels [SKIP_IF_IN_CHANNELS ...]
                        When --recursive is used, it will build *all* recipes.
                        Use this argument to skip recursive building for
                        packages that already exist in the packages listed
                        here. (default: ['conda-forge', 'bioconda'])
  --loglevel LOGLEVEL   Set logging level (debug, info, warning, error,
                        critical) (default: 'debug')
  --logfile LOGFILE     Write log to file (default: -)
  --logfile-level LOGFILE_LEVEL
                        Log level for log file (default: 'debug')
  --log-command-max-lines LOG_COMMAND_MAX_LINES
                        Limit lines emitted for commands executed (default: -)
```


## bioconda-utils_clean-cran-skeleton

### Tool Description
Cleans skeletons created by ``conda skeleton cran``.

Before submitting to conda-forge or Bioconda, recipes generated with ``conda
skeleton cran`` need to be cleaned up: comments removed, licenses fixed, and
other linting.

Use --no-windows for a Bioconda submission.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
- **Homepage**: http://bioconda.github.io/build-system.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconda-utils clean-cran-skeleton [-h] [-n] [--loglevel LOGLEVEL]
                                          [--logfile LOGFILE]
                                          [--logfile-level LOGFILE_LEVEL]
                                          [--log-command-max-lines LOG_COMMAND_MAX_LINES]
                                          recipe

Cleans skeletons created by ``conda skeleton cran``.

Before submitting to conda-forge or Bioconda, recipes generated with ``conda
skeleton cran`` need to be cleaned up: comments removed, licenses fixed, and
other linting.

Use --no-windows for a Bioconda submission.

positional arguments:
  recipe                Path to recipe to be cleaned

options:
  -h, --help            show this help message and exit
  -n, --no-windows      Use this when submitting an R package to Bioconda.
                        After a CRAN skeleton is created, any Windows-related
                        lines will be removed and the bld.bat file will be
                        removed. (default: False)
  --loglevel LOGLEVEL   Set logging level (debug, info, warning, error,
                        critical) (default: 'info')
  --logfile LOGFILE     Write log to file (default: -)
  --logfile-level LOGFILE_LEVEL
                        Log level for log file (default: 'debug')
  --log-command-max-lines LOG_COMMAND_MAX_LINES
                        Limit lines emitted for commands executed (default: -)
```


## bioconda-utils_autobump

### Tool Description
Updates recipes in recipe_folder

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
- **Homepage**: http://bioconda.github.io/build-system.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconda-utils autobump [-h] [--packages PACKAGES [PACKAGES ...]]
                               [--exclude EXCLUDE [EXCLUDE ...]]
                               [--cache CACHE] [--failed-urls FAILED_URLS]
                               [-u UNPARSED_URLS] [-r RECIPE_STATUS]
                               [--exclude-subrecipes EXCLUDE_SUBRECIPES]
                               [--exclude-channels EXCLUDE_CHANNELS [EXCLUDE_CHANNELS ...]]
                               [-i] [--fetch-requirements] [--check-branch]
                               [--create-branch] [--create-pr] [-o]
                               [--no-shuffle] [-m MAX_UPDATES] [-d]
                               [--no-check-pinnings] [--no-follow-graph]
                               [--no-check-version-update]
                               [--no-check-pending-deps] [-s [SIGN]]
                               [--commit-as COMMIT_AS COMMIT_AS] [-t THREADS]
                               [--pdb] [--loglevel LOGLEVEL]
                               [--logfile LOGFILE]
                               [--logfile-level LOGFILE_LEVEL]
                               [--log-command-max-lines LOG_COMMAND_MAX_LINES]
                               [recipe-folder] [config]

Updates recipes in recipe_folder

positional arguments:
  recipe-folder         Path to folder containing recipes (default: recipes/)
                        (default: -)
  config                Path to Bioconda config (default: config.yml)
                        (default: -)

options:
  -h, --help            show this help message and exit
  --packages PACKAGES [PACKAGES ...]
                        Glob(s) for package[s] to scan. Can be specified more
                        than once (default: '*')
  --exclude EXCLUDE [EXCLUDE ...]
                        Globs for package[s] to exclude from scan. Can be
                        specified more than once (default: -)
  --cache CACHE         To speed up debugging, use repodata cached locally in
                        the provided filename. If the file does not exist, it
                        will be created the first time. Caution: The cache
                        will not be updated if exclude-channels is changed
                        (default: -)
  --failed-urls FAILED_URLS
                        Write urls with permanent failure to this file
                        (default: -)
  -u UNPARSED_URLS, --unparsed-urls UNPARSED_URLS
                        Write unrecognized urls to this file (default: -)
  -r RECIPE_STATUS, --recipe-status RECIPE_STATUS
                        Write status for each recipe to this file (default: -)
  --exclude-subrecipes EXCLUDE_SUBRECIPES
                        By default, only subrecipes explicitly enabled for
                        watch in meta.yaml are considered. Set to 'always' to
                        exclude all subrecipes. Set to 'never' to include all
                        subrecipes (default: -)
  --exclude-channels EXCLUDE_CHANNELS [EXCLUDE_CHANNELS ...]
                        Exclude recipes building packages present in other
                        channels. Set to 'none' to disable check. (default:
                        'conda-forge')
  -i, --ignore-skiplists
                        Do not exclude skiplisted recipes (default: False)
  --fetch-requirements  Try to fetch python requirements. Please note that
                        this requires downloading packages and executing
                        setup.py, so presents a potential security problem.
                        (default: False)
  --check-branch        Check if recipe has active branch (default: False)
  --create-branch       Create branch for each update (default: False)
  --create-pr           Create PR for each update. Implies create-branch.
                        (default: False)
  -o, --only-active     Check only recipes with active update (default: False)
  --no-shuffle          Do not shuffle recipe order (default: False)
  -m MAX_UPDATES, --max-updates MAX_UPDATES
                        Exit after ARG updates (default: 0)
  -d, --dry-run         Don't update remote git or github" (default: False)
  --no-check-pinnings   Don't check for pinning updates (default: False)
  --no-follow-graph     Don't process recipes in graph order or add dependent
                        recipes to checks. Implies --no-skip-pending-deps.
                        (default: False)
  --no-check-version-update
                        Don't check for version updates to recipes (default:
                        False)
  --no-check-pending-deps
                        Don't check for recipes having a dependency with a
                        pending update. Update all recipes, including those
                        having deps in need or rebuild. (default: False)
  -s [SIGN], --sign [SIGN]
                        Enable signing. Optionally takes keyid. (default: 0)
  --commit-as COMMIT_AS COMMIT_AS
                        Set user and email to use for committing. Takes
                        exactly two arguments. (default: -)
  -t THREADS, --threads THREADS
                        Limit maximum number of processes used. (default: 16)
  --pdb, -P             Drop into debugger on exception (default: False)
  --loglevel LOGLEVEL   Set logging level (debug, info, warning, error,
                        critical) (default: 'info')
  --logfile LOGFILE     Write log to file (default: -)
  --logfile-level LOGFILE_LEVEL
                        Log level for log file (default: 'debug')
  --log-command-max-lines LOG_COMMAND_MAX_LINES
                        Limit lines emitted for commands executed (default: -)
```


## bioconda-utils_handle-merged-pr

### Tool Description
Handle merged pull requests for Bioconda recipes.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
- **Homepage**: http://bioconda.github.io/build-system.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconda-utils handle-merged-pr [-h] [-r REPO]
                                       [-g GIT_RANGE [GIT_RANGE ...]] [-d]
                                       [-f {build,ignore}]
                                       [-q QUAY_UPLOAD_TARGET]
                                       [-a {azure,circleci,github-actions}]
                                       [--loglevel LOGLEVEL]
                                       [--logfile LOGFILE]
                                       [--logfile-level LOGFILE_LEVEL]
                                       [--log-command-max-lines LOG_COMMAND_MAX_LINES]
                                       [recipe-folder] [config]

positional arguments:
  recipe-folder         Path to folder containing recipes (default: recipes/)
                        (default: -)
  config                Path to Bioconda config (default: config.yml)
                        (default: -)

options:
  -h, --help            show this help message and exit
  -r REPO, --repo REPO  Name of the github repository to check (e.g.
                        bioconda/bioconda-recipes). (default: -)
  -g GIT_RANGE [GIT_RANGE ...], --git-range GIT_RANGE [GIT_RANGE ...]
                        Git range (e.g. commits or something like "master
                        HEAD" to check commits in HEAD vs master, or just
                        "HEAD" to include uncommitted changes). All recipes
                        modified within this range will be built if not
                        present in the channel. (default: -)
  -d, --dryrun          Do not actually upload anything. (default: False)
  -f {build,ignore}, --fallback {build,ignore}
                        What to do if no artifacts are found in the PR.
                        (default: 'build')
  -q QUAY_UPLOAD_TARGET, --quay-upload-target QUAY_UPLOAD_TARGET
                        Provide a quay.io target to push docker images to.
                        (default: -)
  -a {azure,circleci,github-actions}, --artifact-source {azure,circleci,github-actions}
                        Application hosting build artifacts (e.g., Azure,
                        Circle CI, or GitHub Actions). (default: 'azure')
  --loglevel LOGLEVEL   Set logging level (debug, info, warning, error,
                        critical) (default: 'info')
  --logfile LOGFILE     Write log to file (default: -)
  --logfile-level LOGFILE_LEVEL
                        Log level for log file (default: 'debug')
  --log-command-max-lines LOG_COMMAND_MAX_LINES
                        Limit lines emitted for commands executed (default: -)
```


## bioconda-utils_annotate-build-failures

### Tool Description
Annotate build failures for recipes.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
- **Homepage**: http://bioconda.github.io/build-system.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconda-utils annotate-build-failures [-h] [-s] [-r REASON]
                                              [-c {compiler error,conda/mamba bug,test failure,dependency issue,checksum mismatch,source download error}]
                                              [-p PLATFORMS [PLATFORMS ...]]
                                              [-e]
                                              recipes [recipes ...]

positional arguments:
  recipes               Paths to recipes that shall be skiplisted

options:
  -h, --help            show this help message and exit
  -s, --skiplist        Skiplist recipes. (default: False)
  -r REASON, --reason REASON
                        Reason for skiplisting. If omitted, will fail if there
                        is no existing build failure record with a log entry.
                        (default: -)
  -c {compiler error,conda/mamba bug,test failure,dependency issue,checksum mismatch,source download error}, --category {compiler error,conda/mamba bug,test failure,dependency issue,checksum mismatch,source download error}
                        Category of build failure. If omitted, will fail if
                        there is no existing build failure record with a log
                        entry. (default: -)
  -p PLATFORMS [PLATFORMS ...], --platforms PLATFORMS [PLATFORMS ...]
                        Platforms to annotate (default: ['linux-64',
                        'osx-64'])
  -e, --existing-only   Only annotate already existing build failure records.
                        The platform setting is ignored in this case.
                        (default: False)
```


## bioconda-utils_list-build-failures

### Tool Description
List recipes with build failure records

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
- **Homepage**: http://bioconda.github.io/build-system.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bioconda-utils list-build-failures [-h] [-c CHANNEL]
                                          [-o {txt,markdown}] [-l LINK_PREFIX]
                                          [-g GIT_RANGE [GIT_RANGE ...]]
                                          [recipe-folder] [config]

List recipes with build failure records

positional arguments:
  recipe-folder         Path to folder containing recipes (default: recipes/)
                        (default: -)
  config                Path to Bioconda config (default: config.yml)
                        (default: -)

options:
  -h, --help            show this help message and exit
  -c CHANNEL, --channel CHANNEL
                        Channel with packages to check (default: 'bioconda')
  -o {txt,markdown}, --output-format {txt,markdown}
                        Output format (default: 'txt')
  -l LINK_PREFIX, --link-prefix LINK_PREFIX
                        Prefix for links to build failures (default: '')
  -g GIT_RANGE [GIT_RANGE ...], --git-range GIT_RANGE [GIT_RANGE ...]
                        Git range (e.g. commits or something like "master
                        HEAD" to check commits in HEAD vs master, or just
                        "HEAD" to include uncommitted changes). (default: -)
```


## bioconda-utils_bulk-trigger-ci

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/bioconda-utils:4.0.0--pyhdfd78af_0
- **Homepage**: http://bioconda.github.io/build-system.html
- **Package**: https://anaconda.org/channels/bioconda/packages/bioconda-utils/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: bioconda-utils bulk-trigger-ci [-h]

Create an empty commit with the string "[ci run]" and push, which
triggers a bulk CI run. Must be on the `bulk` branch.

options:
  -h, --help  show this help message and exit
```


## Metadata
- **Skill**: generated
