[Ephemeris](../index.html)

* [Introduction](../readme.html)
* [Installation](../installation.html)
* [Commands](../commands.html)
  + [Galaxy-wait](galaxy-wait.html)
  + [Get-tool-list](get-tool-list.html)
  + [Run-data-managers](run-data-managers.html)
  + [Setup-data-libraries](setup-data-libraries.html)
  + Shed-tools
    - [Usage](#usage)
      * [Sub-commands](#Sub-commands)
  + [Install-tool-deps](install-tool-deps.html)
  + [Workflow-install](workflow-install.html)
  + [Workflow-to-tools](workflow-to-tools.html)
* [Code of conduct](../conduct.html)
* [Contributing](../contributing.html)
* [Project Governance](../organization.html)
* [Release Checklist](../developing.html)
* [History](../history.html)

[Ephemeris](../index.html)

* [Commands](../commands.html)
* Shed-tools
* [View page source](../_sources/commands/shed-tools.rst.txt)

---

# Shed-tools[¶](#module-ephemeris.shed_tools "Link to this heading")

A tool to automate installation of tool repositories from a Galaxy Tool Shed
into an instance of Galaxy.

Shed-tools has three commands: update, test and install.

Update simply updates all the tools in a Galaxy given connection details on the command line.

Test tests the specified tools in the Galaxy Instance.

Install allows installation of tools in multiple ways.
Galaxy instance details and the installed tools can be provided in one of three
ways:

1. In the YAML format via dedicated files (a sample can be found
   [here](https://github.com/galaxyproject/ansible-galaxy-tools/blob/master/files/tool_list.yaml.sample)).
2. On the command line as dedicated script options (see the usage help).
3. As a single composite parameter to the script. The parameter must be a
   single, YAML-formatted string with the keys corresponding to the keys
   available for use in the YAML formatted file (for example:
   –yaml\_tool “{‘owner’: ‘kellrott’, ‘tool\_shed\_url’:
   ‘https://testtoolshed.g2.bx.psu.edu’, ‘tool\_panel\_section\_id’:
   ‘peak\_calling’, ‘name’: ‘synapse\_interface’}”).

Only one of the methods can be used with each invocation of the script but if
more than one are provided are provided, precedence will correspond to order
of the items in the list above.
When installing tools, Galaxy expects any tool\_panel\_section\_id provided when
installing a tool to already exist in the configuration. If the section
does not exist, the tool will be installed outside any section. See
shed\_tool\_conf.xml.sample in this directory for a sample of such file. Before
running this script to install the tools, make sure to place such file into
Galaxy’s configuration directory and set Galaxy configuration option
tool\_config\_file to include it.

## Usage[¶](#usage "Link to this heading")

```
usage: shed-tools [-h] {install,update,test} ...
```

### Sub-commands[¶](#Sub-commands "Link to this heading")

#### install[¶](#install "Link to this heading")

This installs tools in Galaxy from the Tool Shed.Use shed-tools install –help for more information

```
shed-tools install [-h] [-v] [--log-file LOG_FILE] [-g GALAXY] [-u USER]
                   [-p PASSWORD] [-a API_KEY] [-t TOOL_LIST_FILE]
                   [-y TOOL_YAML] [--name NAME] [--owner OWNER]
                   [--revisions [REVISIONS ...]] [--tool-shed TOOL_SHED_URL]
                   [--install-tool-dependencies]
                   [--skip-install-resolver-dependencies]
                   [--skip-install-repository-dependencies] [--test]
                   [--test-existing] [--test-json TEST_JSON]
                   [--test-user-api-key TEST_USER] [--test-user TEST_USER]
                   [--parallel-tests PARALLEL_TESTS]
                   [--section TOOL_PANEL_SECTION_ID]
                   [--section-label TOOL_PANEL_SECTION_LABEL] [--latest]
```

##### Named Arguments[¶](#named-arguments "Link to this heading")

`-t, --tools-file, --toolsfile`
:   Tools file to use (see tool\_list.yaml.sample)

`-y, --yaml-tool, --yaml_tool`
:   Install tool represented by yaml string

`--name`
:   The name of the tool to install (only applicable if the tools file is not provided).

`--owner`
:   The owner of the tool to install (only applicable if the tools file is not provided).

`--revisions`
:   The revisions of the tool repository that will be installed. All revisions must be specified after this flag by a space.Example: –revisions 0a5c7992b1ac f048033da666(Only applicable if the tools file is not provided).

`--tool-shed, --toolshed`
:   The Tool Shed URL where to install the tool from. This is applicable only if the tool info is provided as an option vs. in the tools file.

`--install-tool-dependencies, --install_tool_dependencies`
:   Turn on installation of tool dependencies using classic toolshed packages. Can be overwritten on a per-tool basis in the tools file.

    Default: `False`

`--skip-install-resolver-dependencies, --skip_install_resolver_dependencies`
:   Skip installing tool dependencies through resolver (e.g. conda). Will be ignored on galaxy releases older than 16.07. Can be overwritten on a per-tool basis in the tools file

    Default: `False`

`--skip-install-repository-dependencies, --skip_install_repository_dependencies`
:   Skip installing the repository dependencies.

    Default: `False`

`--test`
:   Run tool tests on install tools, requires Galaxy 18.05 or newer.

    Default: `False`

`--test-existing, --test_existing`
:   If testing tools during install, also run tool tests on repositories already installed (i.e. skipped repositories).

    Default: `False`

`--test-json, --test_json`
:   If testing tools, record tool test output to specified file. This file can be turned into reports with `planemo test_reports <output.json>`.

    Default: `'tool_test_output.json'`

`--test-user-api-key, --test_user_api_key`
:   If testing tools, a user is needed to execute the tests. This can be different the –api\_key which is assumed to be an admin key. If –api\_key is a valid user (e.g. it is not a master API key) this does not need to be specified and –api\_key will be reused.

`--test-user, --test_user`
:   If testing tools, a user is needed to execute the tests. If –api\_key is a master api key (i.e. not tied to a real user) and –test\_user\_api\_key isn’t specified, this user email will be used. This user will be created if needed.

`--parallel-tests, --parallel_tests`
:   Specify the maximum number of tests that will be run in parallel.

    Default: `1`

`--section`
:   Galaxy tool panel section ID where the tool will be installed (the section must exist in Galaxy; only applicable if the tools file is not provided).

`--section-label, --section_label`
:   Galaxy tool panel section label where tool will be installed (if the section does not exist, it will be created; only applicable if the tools file is not provided).

`--latest`
:   Will override the revisions in the tools file and always install the latest revision.

    Default: `False`

##### General options[¶](#general-options "Link to this heading")

`-v, --verbose`
:   Increase output verbosity.

    Default: `False`

`--log-file, --log_file`
:   Where the log file should be stored. Default is a file in your system’s temp folder

##### Galaxy connection[¶](#galaxy-connection "Link to this heading")

`-g, --galaxy`
:   Target Galaxy instance URL/IP address

    Default: `'http://localhost:8080'`

`-u, --user`
:   Galaxy user email address

`-p, --password`
:   Password for the Galaxy user

`-a, --api-key, --api_key`
:   Galaxy admin user API key (required if not defined in the tools list file)

#### update[¶](#update "Link to this heading")

This updates all tools in Galaxy to the latest revision. Use shed-tools update –help for more information

```
shed-tools update [-h] [-v] [--log-file LOG_FILE] [-g GALAXY] [-u USER]
                  [-p PASSWORD] [-a API_KEY] [-t TOOL_LIST_FILE]
                  [-y TOOL_YAML] [--name NAME] [--owner OWNER]
                  [--revisions [REVISIONS ...]] [--tool-shed TOOL_SHED_URL]
                  [--install-tool-dependencies]
                  [--skip-install-resolver-dependencies]
                  [--skip-install-repository-dependencies] [--test]
                  [--test-existing] [--test-json TEST_JSON]
                  [--test-user-api-key TEST_USER] [--test-user TEST_USER]
                  [--parallel-tests PARALLEL_TESTS]
```

##### Named Arguments[¶](#named-arguments_repeat1 "Link to this heading")

`-t, --tools-file, --toolsfile`
:   Tools file to use (see tool\_list.yaml.sample)

`-y, --yaml-tool, --yaml_tool`
:   Install tool represented by yaml string

`--name`
:   The name of the tool to install (only applicable if the tools file is not provided).

`--owner`
:   The owner of the tool to install (only applicable if the tools file is not provided).

`--revisions`
:   The revisions of the tool repository that will be installed. All revisions must be specified after this flag by a space.Example: –revisions 0a5c7992b1ac f048033da666(Only applicable if the tools file is not provided).

`--tool-shed, --toolshed`
:   The Tool Shed URL where to install the tool from. This is applicable only if the tool info is provided as an option vs. in the tools file.

`--install-tool-dependencies, --install_tool_dependencies`
:   Turn on installation of tool dependencies using classic toolshed packages. Can be overwritten on a per-tool basis in the tools file.

    Default: `False`

`--skip-install-resolver-dependencies, --skip_install_resolver_dependencies`
:   Skip installing tool dependencies through resolver (e.g. conda). Will be ignored on galaxy releases older than 16.07. Can be overwritten on a per-tool basis in the tools file

    Default: `False`

`--skip-install-repository-dependencies, --skip_install_repository_dependencies`
:   Skip installing the repository dependencies.

    Default: `False`

`--test`
:   Run tool tests on install tools, requires Galaxy 18.05 or newer.

    Default: `False`

`--test-existing, --test_existing`
:   If testing tools during install, also run tool tests on repositories already installed (i.e. skipped repositories).

    Default: `False`

`--test-json, --test_json`
:   If testing tools, record tool test output to specified file. This file can be turned into reports with `planemo test_reports <output.json>`.

    Default: `'tool_test_output.json'`

`--test-user-api-key, --test_user_api_key`
:   If testing tools, a user is needed to execute the tests. This can be different the –api\_key which is assumed to be an admin key. If –api\_key is a valid user (e.g. it is not a master API key) this does not need to be specified and –api\_key will be reused.

`--test-user, --test_user`
:   If testing tools, a user is needed to execute the tests. If –api\_key is a master api key (i.e. not tied to a real user) and –test\_user\_api\_key isn’t specified, this user email will be used. This user will be created if needed.

`--parallel-tests, --parallel_tests`
:   Specify the maximum number of tests that will be run in parallel.

    Default: `1`

##### General options[¶](#general-options_repeat1 "Link to this heading")

`-v, --verbose`
:   Increase output verbosity.

    Default: `False`

`--log-file, --log_file`
:   Where the log file should be stored. Default is a file in your system’s temp folder

##### Galaxy connection[¶](#galaxy-connection_repeat1 "Link to this heading")

`-g, --galaxy`
:   Target Galaxy instance URL/IP address

    Default: `'http://localhost:8080'`

`-u, --user`
:   Galaxy user email address

`-p, --password`
:   Password for the Galaxy user

`-a, --api-key, --api_key`
:   Galaxy admin user API key (required if not defined in the tools list file)

#### test[¶](#test "Link to this heading")

This tests the supplied list of tools in Galaxy. Use shed-tools test –help for more information

```
shed-tools test [-h] [-v] [--log-file LOG_FILE] [-g GALAXY] [-u USER]
                [-p PASSWORD] [-a API_KEY] [-t TOOL_LIST_FILE] [-y TOOL_YAML]
                [--name NAME] [--owner OWNER] [--revisions [REVISIONS ...]]
                [--tool-shed TOOL_SHED_URL] [--test-json TEST_JSON]
                [--test-user-api-key TEST_USER_API_KEY]
                [--test-user TEST_USER]
                [--test-history-name TEST_HISTORY_NAME]
                [--parallel-tests PARALLEL_TESTS] [--test-all-versions]
                [--client-test-config CLIENT_TEST_CONFIG]
```

##### Named Arguments[¶](#named-arguments_repeat2 "Link to this heading")

`-t, --tools-file, --toolsfile`
:   Tools file to use (see tool\_list.yaml.sample)

`-y, --yaml-tool, --yaml_tool`
:   Install tool represented by yaml string

`--name`
:   The name of the tool to install (only applicable if the tools file is not provided).

`--owner`
:   The owner of the tool to install (only applicable if the tools file is not provided).

`--revisions`
:   The revisions of the tool repository that will be installed. All revisions must be specified after this flag by a space.Example: –revisions 0a5c7992b1ac f048033da666(Only applicable if the tools file is not provided).

`--tool-shed, --toolshed`
:   The Tool Shed URL where to install the tool from. This is applicable only if the tool info is provided as an option vs. in the tools file.

`--test-json, --test_json`
:   Record tool test output to specified file. This file can be turned into reports with `planemo test_reports <output.json>`.

    Default: `'tool_test_output.json'`

`--test-user-api-key, --test_user_api_key`
:   A user is needed to execute the tests. This can be different the –api\_key which is assumed to be an admin key. If –api\_key is a valid user (e.g. it is not a master API key) this does not need to be specified and –api\_key will be reused.

`--test-user, --test_user`
:   A user is needed to execute the tests. If –api\_key is a master api key (i.e. not tied to a real user) and –test\_user\_api\_key isn’t specified, this user email will be used. This user will be created if needed.

`--test-history-name, --test_history_name`
:   Use existing history or create history with provided name if none exists. If –test\_history\_name is not set, a new history with a default name will always be created. If multiple histories match the provided name, the first (newest) one returned by the Galaxy API will be selected.

`--parallel-tests, --parallel_tests`
:   Specify the maximum number of tests that will be run in parallel.

    Default: `1`

`--test-all-versions, --test_all_versions`
:   Run tests on all installed versions of tools. This will only apply for tools where revisions have not been provided through the –revisions arg, –tool\_file or –tool\_yaml.

    Default: `False`

`--client-test-config, --client_test_config`
:   Annotate expectations about tools in client testing YAML configuration file.

##### General options[¶](#general-options_repeat2 "Link to this heading")

`-v, --verbose`
:   Increase output verbosity.

    Default: `False`

`--log-file, --log_file`
:   Where the log file sh