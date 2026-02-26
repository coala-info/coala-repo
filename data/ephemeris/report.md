# ephemeris CWL Generation Report

## ephemeris_shed-tools

### Tool Description
A command-line tool for managing tools in Galaxy from the Tool Shed.

### Metadata
- **Docker Image**: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproject/ephemeris
- **Package**: https://anaconda.org/channels/bioconda/packages/ephemeris/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ephemeris/overview
- **Total Downloads**: 63.4K
- **Last updated**: 2025-09-26
- **GitHub**: https://github.com/galaxyproject/ephemeris
- **Stars**: N/A
### Original Help Text
```text
usage: shed-tools [-h] {install,update,test} ...

positional arguments:
  {install,update,test}
    install             This installs tools in Galaxy from the Tool Shed.Use
                        shed-tools install --help for more information
    update              This updates all tools in Galaxy to the latest
                        revision. Use shed-tools update --help for more
                        information
    test                This tests the supplied list of tools in Galaxy. Use
                        shed-tools test --help for more information

options:
  -h, --help            show this help message and exit
```


## ephemeris_get-tool-list

### Tool Description
Generates a tool_list.yml file for Galaxy.

### Metadata
- **Docker Image**: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproject/ephemeris
- **Package**: https://anaconda.org/channels/bioconda/packages/ephemeris/overview
- **Validation**: PASS

### Original Help Text
```text
usage: get-tool-list [-h] [-v] [-g GALAXY] [-u USER] [-p PASSWORD]
                     [-a API_KEY] -o OUTPUT [--include-tool-panel-id]
                     [--skip-tool-panel-name] [--skip-changeset-revision]
                     [--get-data-managers] [--get-all-tools]

options:
  -h, --help            show this help message and exit
  -o, --output-file OUTPUT
                        tool_list.yml output file (default: None)
  --include-tool-panel-id
                        Include tool_panel_id in tool_list.yml ? Use this only
                        if the tool panel id already exists. See
                        https://github.com/galaxyproject/ansible-galaxy-
                        tools/blob/master/files/tool_list.yaml.sample
                        (default: False)
  --skip-tool-panel-name
                        Do not include tool_panel_name in tool_list.yml ?
                        (default: False)
  --skip-changeset-revision
                        Do not include the changeset revision when generating
                        the tool list.Use this if you would like to use the
                        list to update all the tools inyour galaxy instance
                        using shed-install. (default: False)
  --get-data-managers   Include the data managers in the tool list. Requires
                        admin login details (default: False)
  --get-all-tools       Get all tools and revisions, not just those which are
                        present on the web ui.Requires login details.
                        (default: False)

General options:
  -v, --verbose         Increase output verbosity. (default: False)

Galaxy connection:
  -g, --galaxy GALAXY   Target Galaxy instance URL/IP address (default:
                        http://localhost:8080)
  -u, --user USER       Galaxy user email address (default: None)
  -p, --password PASSWORD
                        Password for the Galaxy user (default: None)
  -a, --api-key API_KEY
                        Galaxy admin user API key (required if not defined in
                        the tools list file) (default: None)
```


## ephemeris_galaxy-tool-test

### Tool Description
Script to quickly run a tool test against a running Galaxy instance.

### Metadata
- **Docker Image**: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproject/ephemeris
- **Package**: https://anaconda.org/channels/bioconda/packages/ephemeris/overview
- **Validation**: PASS

### Original Help Text
```text
usage: galaxy-tool-test [-h] [-u GALAXY_URL] [-k KEY] [-a ADMIN_KEY]
                        [--force_path_paste] [-t TOOL_ID]
                        [--tool-version TOOL_VERSION] [-i TEST_INDEX]
                        [-o OUTPUT] [--append] [--skip-previously-executed |
                        --skip-previously-successful] [-j OUTPUT_JSON]
                        [--verbose] [-c CLIENT_TEST_CONFIG]
                        [--suite-name SUITE_NAME] [--with-reference-data]
                        [--skip-with-reference-data] [--history-per-suite |
                        --history-per-test-case | --history-name HISTORY_NAME]
                        [--no-history-reuse] [--no-history-cleanup]
                        [--publish-history] [--parallel-tests PARALLEL_TESTS]
                        [--retries RETRIES] [--page-size PAGE_SIZE]
                        [--page-number PAGE_NUMBER]
                        [--download-attempts DOWNLOAD_ATTEMPTS]
                        [--download-sleep DOWNLOAD_SLEEP]
                        [--test-data TEST_DATA]

Script to quickly run a tool test against a running Galaxy instance.

options:
  -h, --help            show this help message and exit
  -u, --galaxy-url GALAXY_URL
                        Galaxy URL
  -k, --key KEY         Galaxy User API Key
  -a, --admin-key ADMIN_KEY
                        Galaxy Admin API Key
  --force_path_paste    This requires Galaxy-side config option
                        "allow_path_paste" enabled. Allows for fetching test
                        data locally. Only for admins.
  -t, --tool-id TOOL_ID
                        Tool ID
  --tool-version TOOL_VERSION
                        Tool Version (if tool id supplied). Defaults to just
                        latest version, use * to test all versions
  -i, --test-index TEST_INDEX
                        Tool Test Index (starting at 0) - by default all tests
                        will run.
  -o, --output OUTPUT   directory to dump outputs to
  --append              Extend a test record json (created with --output-json)
                        with additional tests.
  --skip-previously-executed
                        When used with --append, skip any test previously
                        executed.
  --skip-previously-successful
                        When used with --append, skip any test previously
                        executed successfully.
  -j, --output-json OUTPUT_JSON
                        output metadata json
  --verbose             Verbose logging.
  -c, --client-test-config CLIENT_TEST_CONFIG
                        Test config YAML to help with client testing
  --suite-name SUITE_NAME
                        Suite name for tool test output
  --with-reference-data
  --skip-with-reference-data
                        Skip tests the Galaxy server believes use data tables
                        or loc files.
  --history-per-suite   Create new history per test suite (all tests in same
                        history).
  --history-per-test-case
                        Create new history per test case.
  --history-name HISTORY_NAME
                        Override default history name
  --no-history-reuse    Do not reuse histories if a matching one already
                        exists.
  --no-history-cleanup  Perserve histories created for testing.
  --publish-history     Publish test history. Useful for CI testing.
  --parallel-tests PARALLEL_TESTS
                        Parallel tests.
  --retries RETRIES     Retry failed tests.
  --page-size PAGE_SIZE
                        If positive, use pagination and just run one 'page' to
                        tool tests.
  --page-number PAGE_NUMBER
                        If page size is used, run this 'page' of tests -
                        starts with 0.
  --download-attempts DOWNLOAD_ATTEMPTS
                        Galaxy may return a transient 500 status code for
                        download if test results are written but not yet
                        accessible.
  --download-sleep DOWNLOAD_SLEEP
                        If download attempts is greater than 1, the amount to
                        sleep between download attempts.
  --test-data TEST_DATA
                        Add local test data path to search for missing test
                        data
```

