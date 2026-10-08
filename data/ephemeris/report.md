# ephemeris CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ephemeris_galaxy-tool-test | Not completed | needs a running Galaxy server and an API key |
| ephemeris_get-tool-list | PASS | Fixed the output file and option prefixes; listed 1861 tools from the public usegalaxy.org server. |
| ephemeris_shed-tools_install | Not completed | needs a Galaxy server with an admin API key |
| ephemeris_shed-tools_test | Not completed | needs a Galaxy server with an admin API key |
| ephemeris_shed-tools_update | Not completed | needs a Galaxy server with an admin API key |

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


## ephemeris_shed-tools_install

### Tool Description
shed-tools install: Galaxy Tool Shed tool management.

### Metadata
- **Docker Image**: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproject/ephemeris
- **Package**: https://anaconda.org/channels/bioconda/packages/ephemeris/overview
- **Validation**: PASS

### Original Help Text
```text
usage: shed-tools install [-h] [-v] [--log-file LOG_FILE] [-g GALAXY]
                          [-u USER] [-p PASSWORD] [-a API_KEY]
                          [-t TOOL_LIST_FILE] [-y TOOL_YAML] [--name NAME]
                          [--owner OWNER] [--revisions [REVISIONS ...]]
                          [--tool-shed TOOL_SHED_URL]
                          [--install-tool-dependencies]
                          [--skip-install-resolver-dependencies]
                          [--skip-install-repository-dependencies] [--test]
                          [--test-existing] [--test-json TEST_JSON]
                          [--test-user-api-key TEST_USER]
                          [--test-user TEST_USER]
                          [--parallel-tests PARALLEL_TESTS]
                          [--section TOOL_PANEL_SECTION_ID]
                          [--section-label TOOL_PANEL_SECTION_LABEL]
                          [--latest]

options:
  -h, --help            show this help message and exit
  -t, --tools-file, --toolsfile TOOL_LIST_FILE
                        Tools file to use (see tool_list.yaml.sample)
  -y, --yaml-tool TOOL_YAML
                        Install tool represented by yaml string
  --name NAME           The name of the tool to install (only applicable if
                        the tools file is not provided).
  --owner OWNER         The owner of the tool to install (only applicable if
                        the tools file is not provided).
  --revisions [REVISIONS ...]
                        The revisions of the tool repository that will be
                        installed. All revisions must be specified after this
                        flag by a space.Example: --revisions 0a5c7992b1ac
                        f048033da666(Only applicable if the tools file is not
                        provided).
  --tool-shed, --toolshed TOOL_SHED_URL
                        The Tool Shed URL where to install the tool from. This
                        is applicable only if the tool info is provided as an
                        option vs. in the tools file.
  --install-tool-dependencies
                        Turn on installation of tool dependencies using
                        classic toolshed packages. Can be overwritten on a
                        per-tool basis in the tools file.
  --skip-install-resolver-dependencies
                        Skip installing tool dependencies through resolver
                        (e.g. conda). Will be ignored on galaxy releases older
                        than 16.07. Can be overwritten on a per-tool basis in
                        the tools file
  --skip-install-repository-dependencies
                        Skip installing the repository dependencies.
  --test                Run tool tests on install tools, requires Galaxy 18.05
                        or newer.
  --test-existing       If testing tools during install, also run tool tests
                        on repositories already installed (i.e. skipped
                        repositories).
  --test-json TEST_JSON
                        If testing tools, record tool test output to specified
                        file. This file can be turned into reports with
                        ``planemo test_reports <output.json>``.
  --test-user-api-key TEST_USER
                        If testing tools, a user is needed to execute the
                        tests. This can be different the --api_key which is
                        assumed to be an admin key. If --api_key is a valid
                        user (e.g. it is not a master API key) this does not
                        need to be specified and --api_key will be reused.
  --test-user TEST_USER
                        If testing tools, a user is needed to execute the
                        tests. If --api_key is a master api key (i.e. not tied
                        to a real user) and --test_user_api_key isn't
                        specified, this user email will be used. This user
                        will be created if needed.
  --parallel-tests PARALLEL_TESTS
                        Specify the maximum number of tests that will be run
                        in parallel.
  --section TOOL_PANEL_SECTION_ID
                        Galaxy tool panel section ID where the tool will be
                        installed (the section must exist in Galaxy; only
                        applicable if the tools file is not provided).
  --section-label TOOL_PANEL_SECTION_LABEL
                        Galaxy tool panel section label where tool will be
                        installed (if the section does not exist, it will be
                        created; only applicable if the tools file is not
                        provided).
  --latest              Will override the revisions in the tools file and
                        always install the latest revision.

General options:
  -v, --verbose         Increase output verbosity.
  --log-file LOG_FILE   Where the log file should be stored. Default is a file
                        in your system's temp folder

Galaxy connection:
  -g, --galaxy GALAXY   Target Galaxy instance URL/IP address
  -u, --user USER       Galaxy user email address
  -p, --password PASSWORD
                        Password for the Galaxy user
  -a, --api-key API_KEY
                        Galaxy admin user API key (required if not defined in
                        the tools list file)
```

## ephemeris_shed-tools_update

### Tool Description
shed-tools update: Galaxy Tool Shed tool management.

### Metadata
- **Docker Image**: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproject/ephemeris
- **Package**: https://anaconda.org/channels/bioconda/packages/ephemeris/overview
- **Validation**: PASS

### Original Help Text
```text
usage: shed-tools update [-h] [-v] [--log-file LOG_FILE] [-g GALAXY] [-u USER]
                         [-p PASSWORD] [-a API_KEY] [-t TOOL_LIST_FILE]
                         [-y TOOL_YAML] [--name NAME] [--owner OWNER]
                         [--revisions [REVISIONS ...]]
                         [--tool-shed TOOL_SHED_URL]
                         [--install-tool-dependencies]
                         [--skip-install-resolver-dependencies]
                         [--skip-install-repository-dependencies] [--test]
                         [--test-existing] [--test-json TEST_JSON]
                         [--test-user-api-key TEST_USER]
                         [--test-user TEST_USER]
                         [--parallel-tests PARALLEL_TESTS]

options:
  -h, --help            show this help message and exit
  -t, --tools-file, --toolsfile TOOL_LIST_FILE
                        Tools file to use (see tool_list.yaml.sample)
  -y, --yaml-tool TOOL_YAML
                        Install tool represented by yaml string
  --name NAME           The name of the tool to install (only applicable if
                        the tools file is not provided).
  --owner OWNER         The owner of the tool to install (only applicable if
                        the tools file is not provided).
  --revisions [REVISIONS ...]
                        The revisions of the tool repository that will be
                        installed. All revisions must be specified after this
                        flag by a space.Example: --revisions 0a5c7992b1ac
                        f048033da666(Only applicable if the tools file is not
                        provided).
  --tool-shed, --toolshed TOOL_SHED_URL
                        The Tool Shed URL where to install the tool from. This
                        is applicable only if the tool info is provided as an
                        option vs. in the tools file.
  --install-tool-dependencies
                        Turn on installation of tool dependencies using
                        classic toolshed packages. Can be overwritten on a
                        per-tool basis in the tools file.
  --skip-install-resolver-dependencies
                        Skip installing tool dependencies through resolver
                        (e.g. conda). Will be ignored on galaxy releases older
                        than 16.07. Can be overwritten on a per-tool basis in
                        the tools file
  --skip-install-repository-dependencies
                        Skip installing the repository dependencies.
  --test                Run tool tests on install tools, requires Galaxy 18.05
                        or newer.
  --test-existing       If testing tools during install, also run tool tests
                        on repositories already installed (i.e. skipped
                        repositories).
  --test-json TEST_JSON
                        If testing tools, record tool test output to specified
                        file. This file can be turned into reports with
                        ``planemo test_reports <output.json>``.
  --test-user-api-key TEST_USER
                        If testing tools, a user is needed to execute the
                        tests. This can be different the --api_key which is
                        assumed to be an admin key. If --api_key is a valid
                        user (e.g. it is not a master API key) this does not
                        need to be specified and --api_key will be reused.
  --test-user TEST_USER
                        If testing tools, a user is needed to execute the
                        tests. If --api_key is a master api key (i.e. not tied
                        to a real user) and --test_user_api_key isn't
                        specified, this user email will be used. This user
                        will be created if needed.
  --parallel-tests PARALLEL_TESTS
                        Specify the maximum number of tests that will be run
                        in parallel.

General options:
  -v, --verbose         Increase output verbosity.
  --log-file LOG_FILE   Where the log file should be stored. Default is a file
                        in your system's temp folder

Galaxy connection:
  -g, --galaxy GALAXY   Target Galaxy instance URL/IP address
  -u, --user USER       Galaxy user email address
  -p, --password PASSWORD
                        Password for the Galaxy user
  -a, --api-key API_KEY
                        Galaxy admin user API key (required if not defined in
                        the tools list file)
```

## ephemeris_shed-tools_test

### Tool Description
shed-tools test: Galaxy Tool Shed tool management.

### Metadata
- **Docker Image**: quay.io/biocontainers/ephemeris:0.10.11--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproject/ephemeris
- **Package**: https://anaconda.org/channels/bioconda/packages/ephemeris/overview
- **Validation**: PASS

### Original Help Text
```text
usage: shed-tools test [-h] [-v] [--log-file LOG_FILE] [-g GALAXY] [-u USER]
                       [-p PASSWORD] [-a API_KEY] [-t TOOL_LIST_FILE]
                       [-y TOOL_YAML] [--name NAME] [--owner OWNER]
                       [--revisions [REVISIONS ...]]
                       [--tool-shed TOOL_SHED_URL] [--test-json TEST_JSON]
                       [--test-user-api-key TEST_USER_API_KEY]
                       [--test-user TEST_USER]
                       [--test-history-name TEST_HISTORY_NAME]
                       [--parallel-tests PARALLEL_TESTS] [--test-all-versions]
                       [--client-test-config CLIENT_TEST_CONFIG]

options:
  -h, --help            show this help message and exit
  -t, --tools-file, --toolsfile TOOL_LIST_FILE
                        Tools file to use (see tool_list.yaml.sample)
  -y, --yaml-tool TOOL_YAML
                        Install tool represented by yaml string
  --name NAME           The name of the tool to install (only applicable if
                        the tools file is not provided).
  --owner OWNER         The owner of the tool to install (only applicable if
                        the tools file is not provided).
  --revisions [REVISIONS ...]
                        The revisions of the tool repository that will be
                        installed. All revisions must be specified after this
                        flag by a space.Example: --revisions 0a5c7992b1ac
                        f048033da666(Only applicable if the tools file is not
                        provided).
  --tool-shed, --toolshed TOOL_SHED_URL
                        The Tool Shed URL where to install the tool from. This
                        is applicable only if the tool info is provided as an
                        option vs. in the tools file.
  --test-json TEST_JSON
                        Record tool test output to specified file. This file
                        can be turned into reports with ``planemo test_reports
                        <output.json>``.
  --test-user-api-key TEST_USER_API_KEY
                        A user is needed to execute the tests. This can be
                        different the --api_key which is assumed to be an
                        admin key. If --api_key is a valid user (e.g. it is
                        not a master API key) this does not need to be
                        specified and --api_key will be reused.
  --test-user TEST_USER
                        A user is needed to execute the tests. If --api_key is
                        a master api key (i.e. not tied to a real user) and
                        --test_user_api_key isn't specified, this user email
                        will be used. This user will be created if needed.
  --test-history-name TEST_HISTORY_NAME
                        Use existing history or create history with provided
                        name if none exists. If --test_history_name is not
                        set, a new history with a default name will always be
                        created. If multiple histories match the provided
                        name, the first (newest) one returned by the Galaxy
                        API will be selected.
  --parallel-tests PARALLEL_TESTS
                        Specify the maximum number of tests that will be run
                        in parallel.
  --test-all-versions   Run tests on all installed versions of tools. This
                        will only apply for tools where revisions have not
                        been provided through the --revisions arg, --tool_file
                        or --tool_yaml.
  --client-test-config CLIENT_TEST_CONFIG
                        Annotate expectations about tools in client testing
                        YAML configuration file.

General options:
  -v, --verbose         Increase output verbosity.
  --log-file LOG_FILE   Where the log file should be stored. Default is a file
                        in your system's temp folder

Galaxy connection:
  -g, --galaxy GALAXY   Target Galaxy instance URL/IP address
  -u, --user USER       Galaxy user email address
  -p, --password PASSWORD
                        Password for the Galaxy user
  -a, --api-key API_KEY
                        Galaxy admin user API key (required if not defined in
                        the tools list file)
```

## Metadata
- **Skill**: generated
