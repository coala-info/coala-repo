# cwltool CWL Generation Report

## cwltool

### Tool Description
Reference executor for Common Workflow Language standards.

### Metadata
- **Docker Image**: quay.io/biocontainers/cwltool:1.0.20180225105849--py36_0
- **Homepage**: https://github.com/common-workflow-language/cwltool
- **Package**: https://anaconda.org/channels/bioconda/packages/cwltool/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cwltool/overview
- **Total Downloads**: 158.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/common-workflow-language/cwltool
- **Stars**: N/A
### Original Help Text
```text
usage: cwltool [-h] [--basedir BASEDIR] [--outdir OUTDIR] [--parallel]
               [--preserve-environment ENVVAR | --preserve-entire-environment]
               [--rm-container | --leave-container] [--record-container-id]
               [--cidfile-dir CIDFILE_DIR] [--cidfile-prefix CIDFILE_PREFIX]
               [--tmpdir-prefix TMPDIR_PREFIX]
               [--tmp-outdir-prefix TMP_OUTDIR_PREFIX | --cachedir CACHEDIR]
               [--rm-tmpdir | --leave-tmpdir]
               [--move-outputs | --leave-outputs | --copy-outputs]
               [--enable-pull | --disable-pull]
               [--rdf-serializer RDF_SERIALIZER] [--eval-timeout EVAL_TIMEOUT]
               [--print-rdf | --print-dot | --print-pre | --print-deps | --print-input-deps | --pack | --version | --validate | --print-supported-versions]
               [--strict | --non-strict] [--skip-schemas]
               [--verbose | --quiet | --debug] [--timestamps] [--js-console]
               [--user-space-docker-cmd CMD | --singularity | --no-container]
               [--tool-help] [--relative-deps {primary,cwd}] [--enable-dev]
               [--enable-ext] [--default-container DEFAULT_CONTAINER]
               [--no-match-user] [--disable-net] [--custom-net CUSTOM_NET]
               [--enable-ga4gh-tool-registry | --disable-ga4gh-tool-registry]
               [--add-ga4gh-tool-registry GA4GH_TOOL_REGISTRIES]
               [--on-error {stop,continue}] [--compute-checksum]
               [--no-compute-checksum] [--relax-path-checks] [--make-template]
               [--force-docker-pull] [--no-read-only] [--overrides OVERRIDES]
               [cwl_document] ...

Reference executor for Common Workflow Language standards.

positional arguments:
  cwl_document          path or URL to a CWL Workflow, CommandLineTool, or
                        ExpressionTool. If the `inputs_object` has a
                        `cwl:tool` field indicating the path or URL to the
                        cwl_document, then the `workflow` argument is
                        optional.
  inputs_object         path or URL to a YAML or JSON formatted description of
                        the required input values for the given
                        `cwl_document`.

optional arguments:
  -h, --help            show this help message and exit
  --basedir BASEDIR
  --outdir OUTDIR       Output directory, default current directory
  --parallel            [experimental] Run jobs in parallel. Does not
                        currently keep track of ResourceRequirements like the
                        number of coresor memory and can overload this system
  --preserve-environment ENVVAR
                        Preserve specific environment variable when running
                        CommandLineTools. May be provided multiple times.
  --preserve-entire-environment
                        Preserve all environment variable when running
                        CommandLineTools.
  --rm-container        Delete Docker container used by jobs after they exit
                        (default)
  --leave-container     Do not delete Docker container used by jobs after they
                        exit
  --tmpdir-prefix TMPDIR_PREFIX
                        Path prefix for temporary directories
  --tmp-outdir-prefix TMP_OUTDIR_PREFIX
                        Path prefix for intermediate output directories
  --cachedir CACHEDIR   Directory to cache intermediate workflow outputs to
                        avoid recomputing steps.
  --rm-tmpdir           Delete intermediate temporary directories (default)
  --leave-tmpdir        Do not delete intermediate temporary directories
  --move-outputs        Move output files to the workflow output directory and
                        delete intermediate output directories (default).
  --leave-outputs       Leave output files in intermediate output directories.
  --copy-outputs        Copy output files to the workflow output directory,
                        don't delete intermediate output directories.
  --enable-pull         Try to pull Docker images
  --disable-pull        Do not try to pull Docker images
  --rdf-serializer RDF_SERIALIZER
                        Output RDF serialization format used by --print-rdf
                        (one of turtle (default), n3, nt, xml)
  --eval-timeout EVAL_TIMEOUT
                        Time to wait for a Javascript expression to evaluate
                        before giving an error, default 20s.
  --print-rdf           Print corresponding RDF graph for workflow and exit
  --print-dot           Print workflow visualization in graphviz format and
                        exit
  --print-pre           Print CWL document after preprocessing.
  --print-deps          Print CWL document dependencies.
  --print-input-deps    Print input object document dependencies.
  --pack                Combine components into single document and print.
  --version             Print version and exit
  --validate            Validate CWL document only.
  --print-supported-versions
                        Print supported CWL specs.
  --strict              Strict validation (unrecognized or out of place fields
                        are error)
  --non-strict          Lenient validation (ignore unrecognized fields)
  --skip-schemas        Skip loading of schemas
  --verbose             Default logging
  --quiet               Only print warnings and errors.
  --debug               Print even more logging
  --timestamps          Add timestamps to the errors, warnings, and
                        notifications.
  --js-console          Enable javascript console output
  --user-space-docker-cmd CMD
                        (Linux/OS X only) Specify a user space docker command
                        (like udocker or dx-docker) that will be used to call
                        'pull' and 'run'
  --singularity         [experimental] Use Singularity runtime for running
                        containers. Requires Singularity v2.3.2+ and Linux
                        with kernel version v3.18+ or with overlayfs support
                        backported.
  --no-container        Do not execute jobs in a Docker container, even when
                        `DockerRequirement` is specified under `hints`.
  --tool-help           Print command line help for tool
  --relative-deps {primary,cwd}
                        When using --print-deps, print paths relative to
                        primary file or current working directory.
  --enable-dev          Enable loading and running development versions of CWL
                        spec.
  --enable-ext          Enable loading and running cwltool extensions to CWL
                        spec.
  --default-container DEFAULT_CONTAINER
                        Specify a default docker container that will be used
                        if the workflow fails to specify one.
  --no-match-user       Disable passing the current uid to `docker run --user`
  --disable-net         Use docker's default networking for containers; the
                        default is to enable networking.
  --custom-net CUSTOM_NET
                        Will be passed to `docker run` as the '--net'
                        parameter. Implies '--enable-net'.
  --enable-ga4gh-tool-registry
                        Enable resolution using GA4GH tool registry API
  --disable-ga4gh-tool-registry
                        Disable resolution using GA4GH tool registry API
  --add-ga4gh-tool-registry GA4GH_TOOL_REGISTRIES
                        Add a GA4GH tool registry endpoint to use for
                        resolution, default ['https://dockstore.org:8443']
  --on-error {stop,continue}
                        Desired workflow behavior when a step fails. One of
                        'stop' or 'continue'. Default is 'stop'.
  --compute-checksum    Compute checksum of contents while collecting outputs
  --no-compute-checksum
                        Do not compute checksum of contents while collecting
                        outputs
  --relax-path-checks   Relax requirements on path names to permit spaces and
                        hash characters.
  --make-template       Generate a template input object
  --force-docker-pull   Pull latest docker image even if it is locally present
  --no-read-only        Do not set root directory in the container as read-
                        only
  --overrides OVERRIDES
                        Read process requirement overrides from file.

Options for recording the Docker container identifier into a file:
  --record-container-id
                        If enabled, store the Docker container ID into a file.
                        See --cidfile-dir to specify the directory.
  --cidfile-dir CIDFILE_DIR
                        Directory for storing the Docker container ID file.
                        The default is the current directory
  --cidfile-prefix CIDFILE_PREFIX
                        Specify a prefix to the container ID filename. Final
                        file name will be followed by a timestamp. The default
                        is no prefix.
```

