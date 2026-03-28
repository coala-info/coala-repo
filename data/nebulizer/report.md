# nebulizer CWL Generation Report

## nebulizer_add_key

### Tool Description
Store new Galaxy URL and API key.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Total Downloads**: 10.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pjbriggs/nebulizer
- **Stars**: N/A
### Original Help Text
```text
Usage: nebulizer add_key [OPTIONS] ALIAS GALAXY_URL [API_KEY]

  Store new Galaxy URL and API key.

  ALIAS is the name that the instance will be stored against; GALAXY_URL is
  the URL for the instance; API_KEY is the corresponding API key.

  If API_KEY is not supplied then nebulizer will attempt to fetch one
  automatically.

Options:
  --help  Show this message and exit.
```


## nebulizer_add_library_datasets

### Tool Description
Add datasets to a data library.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer add_library_datasets [OPTIONS] GALAXY DEST [FILE]...

  Add datasets to a data library.

  Uploads one or more FILEs as new datasets in the data library folder DEST
  in GALAXY.

  DEST should be a path to a data library or library folder of the form
  'data_library[/folder[/subfolder[...]]]'. The library and folder must
  already exist.

Options:
  --file-type TEXT  Galaxy data type to assign the files to (default is
                    'auto'). Must be a valid Galaxy data type. If not 'auto'
                    then all files will be assigned the same type.
  --dbkey TEXT      dbkey to assign to files (default is '?')
  --server          upload files from the Galaxy server file system (default
                    is to upload files from local system)
  --link            create symlinks to files on server (only valid if used
                    with --server; default is to copy files into Galaxy)
  --help            Show this message and exit.
```


## nebulizer_config

### Tool Description
Report the Galaxy configuration.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer config [OPTIONS] GALAXY

  Report the Galaxy configuration.

  Reports the available configuration information from GALAXY. Use --name to
  filter which items are reported.

Options:
  --name TEXT  only show configuration items that match NAME. Can include
               glob-style wild-cards.
  --help       Show this message and exit.
```


## nebulizer_create_batch_users

### Tool Description
Create multiple Galaxy users from a template.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer create_batch_users [OPTIONS] GALAXY TEMPLATE START [END]

  Create multiple Galaxy users from a template.

  Creates a batch of users in GALAXY using TEMPLATE; this should be a
  template email address which includes a '#' symbol as a placeholder for an
  integer index.

  The range of integers is defined by START and END; if only one of these is
  supplied then START is assumed to be 1 and the supplied value is END.

  For example: using the template 'user#@example.org' with the range 1 to 5
  will create new accounts:

  user1@galaxy.org ... user5@galaxy.org

Options:
  -p, --password TEXT  specify password for new user accounts (otherwise
                       program will prompt for password). All accounts will be
                       created with the same password.
  -c, --check          check user details but don't try to create the new
                       account.
  --help               Show this message and exit.
```


## nebulizer_create_library

### Tool Description
Create new data library.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer create_library [OPTIONS] GALAXY NAME

  Create new data library.

  Makes a new data library NAME in GALAXY. A library with the same name must
  not already.

Options:
  -d, --description TEXT  description of the new library
  -s, --synopsis TEXT     synopsis text for the new library
  --help                  Show this message and exit.
```


## nebulizer_create_library_folder

### Tool Description
Create new folder in a data library.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer create_library_folder [OPTIONS] GALAXY PATH

  Create new folder in a data library.

  Makes a new folder or folder tree within an existing data library in
  GALAXY.

  The new folder(s) are specified by PATH, which should be of the form
  'data_library[/folder[/subfolder[...]]]'. Although the data library must
  already exist, PATH must not address an existing folder.

Options:
  -d, --description TEXT  description of the new folder
  --help                  Show this message and exit.
```


## nebulizer_create_user

### Tool Description
Create new Galaxy user.

Creates a new user in GALAXY, using EMAIL for the username. If PUBLIC_NAME
is not supplied then it will be generated automatically from the leading
part of the email address.

If a password for the new account is not supplied using the --password
option then nebulizer will prompt for one.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer create_user [OPTIONS] GALAXY EMAIL [PUBLIC_NAME]

  Create new Galaxy user.

  Creates a new user in GALAXY, using EMAIL for the username. If PUBLIC_NAME
  is not supplied then it will be generated automatically from the leading
  part of the email address.

  If a password for the new account is not supplied using the --password
  option then nebulizer will prompt for one.

Options:
  -p, --password TEXT  specify password for new user account (otherwise
                       program will prompt for password)
  -c, --check          check user details but don't try to create the new
                       account
  -m, --message PATH   Mako template to populate and output
  --help               Show this message and exit.
```


## nebulizer_create_users_from_file

### Tool Description
Create multiple Galaxy users from a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer create_users_from_file [OPTIONS] GALAXY FILE

  Create multiple Galaxy users from a file.

  Creates user accounts in GALAXY instance from contents of FILE, which
  should be a tab-delimited file with details of a new user on each line;
  the columns should be 'email', 'password', and optionally 'public_name'.

  (If the 'public_name' is missing then it will be generated automatically
  from the leading part of the email.)

Options:
  -c, --check         check user details but don't try to create the new
                      account.
  -m, --message PATH  Mako template to populate and output.
  --help              Show this message and exit.
```


## nebulizer_delete_user

### Tool Description
Delete a user account from a Galaxy instance

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer delete_user [OPTIONS] GALAXY EMAIL

  Delete a user account from a Galaxy instance

  Removes user account with username EMAIL from GALAXY.

Options:
  -p, --purge  also purge (permanently delete) the user.
  -y, --yes    don't ask for confirmation of deletions.
  --help       Show this message and exit.
```


## nebulizer_install_tool

### Tool Description
Install tool(s) from toolshed.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer install_tool [OPTIONS] GALAXY [REPOSITORY]...

  Install tool(s) from toolshed.

  Installs the specified tool from REPOSITORY into GALAXY, where REPOSITORY
  can be as one of:

  - full URL including the revision e.g.
  https://toolshed.g2.bx.psu.edu/view/devteam/fastqc/e7b2202befea

  - full URL without revision e.g.
  https://toolshed.g2.bx.psu.edu/view/devteam/fastqc

  - OWNER/TOOLNAME combination e.g. devteam/fastqc (toolshed is assumed to
  be main Galaxy toolshed)

  - [ TOOLSHED ] OWNER TOOLNAME [ REVISION ] e.g.
  https://toolshed.g2.bx.psu.edu devteam fastqc

  If a changeset REVISION isn't specified then the latest revision will be
  assumed.

  Installation will fail if the specified revision is not installable, or if
  no installable revisions are found.

  Alternatively multiple tools can be installed in a single invocation of
  the command by specifying the --file option instead of a repository, in
  which case TSV_FILE should be a tab-delimited file with the columns:

  TOOLSHED|OWNER|REPOSITORY|REVISON|SECTION

  (This is the format generated by 'list_tools --mode=export'.)

  If the REVISION field is blank then nebulizer will attempt to install the
  latest revision; if the SECTION field is blank then the tool will be
  installed at the top level of the tool panel (i.e. not in any section).

Options:
  --tool-panel-section TEXT       tool panel section name or id to install the
                                  tool under; if the section doesn't exist
                                  then it will be created. If this option is
                                  omitted then the tool will be installed at
                                  the top-level i.e. not in any section.
  --install-tool-dependencies [yes|no]
                                  install tool dependencies via the toolshed,
                                  if any are defined (default is 'yes')
  --install-repository-dependencies [yes|no]
                                  install repository dependencies via the
                                  toolshed, if any are defined (default is
                                  'yes')
  --install-resolver-dependencies [yes|no]
                                  install dependencies through a resolver that
                                  supports installation (e.g. conda) (default
                                  is 'yes')
  --file TSV_FILE                 install tools specified in TSV_FILE.
  --timeout TIMEOUT               wait up to TIMEOUT seconds for tool
                                  installationsto complete (default is 600).
  --no-wait                       don't wait for lengthy tool installations to
                                  complete.
  -y, --yes                       don't ask for confirmation of installation.
  --help                          Show this message and exit.
```


## nebulizer_list_keys

### Tool Description
List stored Galaxy API key aliases.

  Prints a list of stored aliases with the associated Galaxy URLs;
  optionally also show the API key string.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer list_keys [OPTIONS]

  List stored Galaxy API key aliases.

  Prints a list of stored aliases with the associated Galaxy URLs;
  optionally also show the API key string.

Options:
  --name TEXT          list only aliases matching name. Can include glob-style
                       wild-cards.
  -s, --show-api-keys  show the API key string associated with each alias
  --help               Show this message and exit.
```


## nebulizer_list_libraries

### Tool Description
List data libraries and contents.

  Prints details of the data library and folders specified by PATH, in
  GALAXY instance.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer list_libraries [OPTIONS] GALAXY [PATH]

  List data libraries and contents.

  Prints details of the data library and folders specified by PATH, in
  GALAXY instance.

  PATH should be of the form 'data_library[/folder[/subfolder[...]]]'

Options:
  -l         use a long listing format that includes descriptions, file sizes,
             dbkeys and paths)
  --show_id  include internal Galaxy IDs for data libraries, folders and
             datasets.
  --help     Show this message and exit.
```


## nebulizer_list_tool_panel

### Tool Description
List tool panel contents.

  Prints details of tool panel sections including the displayed text and the
  internal section id, and any tools available outside of any section.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer list_tool_panel [OPTIONS] GALAXY

  List tool panel contents.

  Prints details of tool panel sections including the displayed text and the
  internal section id, and any tools available outside of any section.

Options:
  --name NAME   only list tool panel sections where name or id match NAME. Can
                include glob-style wild-cards.
  --list-tools  also list the associated tools for each section
  --help        Show this message and exit.
```


## nebulizer_list_tools

### Tool Description
List information about tools and installed tool repositories.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer list_tools [OPTIONS] GALAXY

  List information about tools and installed tool repositories.

  Prints details of the tools and installed tool repositories in GALAXY
  instance.

  In the default 'repository-centric' mode, the installed tool repositories
  are listed with details including: repository name, toolshed, owner,
  revision id and changeset, and installation status.

  Repository details are also preceeded by a single-character 'status'
  indicator ('D' = deprecated; '^' = newer revision installed; 'u' = update
  available but not installed; 'U' = upgrade available but not installed;
  '*' = latest revision).

  (Note that there may still be a newer revision of a tool available from
  the toolshed, even when the repository is marked as '*'. Use the --check-
  toolshed option to also explicitly check against the toolshed, in which
  case a '!' status indicates that a newer version has been found on
  toolshed. Note that this option incurs a significant overhead when
  checking a large number of tools.)

  Different reporting modes are available: the default is a 'repository-
  centric' mode, alternatively a 'tool-centric' mode (which lists tools
  according to their names as they appear in the Galaxy tool panel) and an
  'export' mode (which produces output suitable for use with 'install_tool')
  are also available. The --mode option is used to switch between the
  default 'repos' mode and the alternative 'tools' and 'export' modes.

  In export mode the output is a set of tab-delimited values, with each line
  consisting of:

  TOOLSHED|OWNER|REPOSITORY|CHANGESET|TOOL_PANEL_SECTION

  If the --built-in option is specified then built-in tools (i.e. tools not
  installed from a toolshed) will also be included. (NB this option is
  ignored in 'export' mode.)

Options:
  --name NAME                  only list tool repositories matching NAME. Can
                               include glob-style wild-cards.
  --toolshed TOOLSHED          only list repositories installed from toolshed
                               matching TOOLSHED. Can include glob-style wild-
                               cards.
  --owner OWNER                only list repositories from matching OWNER. Can
                               include glob-style wild-cards.
  --updateable                 only show repositories with uninstalled updates
                               or upgrades.
  --built-in                   include built-in tools.
  --mode [repos|tools|export]  set reporting mode: either 'repos' (repository-
                               centric view, the default), 'tools' (tool-
                               centric view) or 'export' (tab-delimited format
                               for use with 'install_tool').
  --check-toolshed             check installed revisions directly against
                               those available in the toolshed. NB this can be
                               extremely slow.
  --help                       Show this message and exit.
```


## nebulizer_list_users

### Tool Description
List users in Galaxy instance.

  Prints details of user accounts in GALAXY instance.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer list_users [OPTIONS] GALAXY

  List users in Galaxy instance.

  Prints details of user accounts in GALAXY instance.

Options:
  --name TEXT                     list only users with matching email or user
                                  name. Can include glob-style wild-cards.
  --status [active|deleted|purged|all]
                                  list users with the specified status; can be
                                  one of 'active', 'deleted', 'purged', 'all'
                                  (default: 'active')
  -l, --long                      use a long listing format that includes ids,
                                  disk usage and admin status.
  --sort TEXT                     comma-separated list of fields to output on;
                                  valid fields are 'email', 'disk_usage',
                                  'quota', 'quota_usage' (default: 'email').
  --show_id                       include internal Galaxy user ID.
  --help                          Show this message and exit.
```


## nebulizer_ping

### Tool Description
Sends a request to GALAXY and reports the status of the response and the time taken.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer ping [OPTIONS] GALAXY

  'Ping' a Galaxy instance.

  Sends a request to GALAXY and reports the status of the response and the
  time taken.

Options:
  -c, --count COUNT        if set then stop after sending COUNT requests
                           (default is to send requests forever).
  -i, --interval INTERVAL  set the interval between sending requests in
                           seconds (default is 5 seconds).
  -t, --timeout LIMIT      specify timeout limit in seconds when no connection
                           can be made.
  --help                   Show this message and exit.
```


## nebulizer_quota_add

### Tool Description
Create new quota.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer quota_add [OPTIONS] GALAXY NAME QUOTA

  Create new quota.

  Makes a new quota called NAME in GALAXY. A quota with the same name must
  not already exist.

  QUOTA specifies the type of quota, and must be of the form

  [OPERATION][AMOUNT]

  where OPERATION is any valid operation ('=','+','-'; defaults to '=' if
  not specified) and AMOUNT is any valid amount (e.g. '10000MB', '99 gb',
  '0.2T', 'unlimited').

  If DESCRIPTION is not supplied then it will be the same as the NAME.

  If supplied then DEFAULT_FOR must be one of 'registered' or
  'unregistered', in which case the new quota will become the default for
  that class of user (overriding any default which was previously defined).

  Users and groups can also be associated with the new quota with the
  -u/--users and -g/--groups options.

Options:
  -d, --description TEXT         description of the new quota (will be the
                                 same as the NAME if not supplied).
  --default_for TEXT             set the quota as the default for either
                                 'registered' or 'unregistered' users.
  -u, --users EMAIL[,EMAIL...]   list of user emails to associate with the
                                 quota, separated by commas.
  -g, --groups GROUP[,GROUP...]  list of group names to associate with the
                                 quota, separated by commas.
  --help                         Show this message and exit.
```


## nebulizer_quota_del

### Tool Description
Deletes QUOTA from GALAXY.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer quota_del [OPTIONS] GALAXY QUOTA

  Delete quota.

  Deletes QUOTA from GALAXY.

Options:
  -y, --yes  don't ask for confirmation of deletions.
  --help     Show this message and exit.
```


## nebulizer_quota_mod

### Tool Description
Modify an existing quota.

  Updates the definition of the existing QUOTA in GALAXY.

  The command line arguments can be used to modify any of the quota's
  attributes, to set a new name, description or quota size and type.

  Users and groups can also be associated with or disassociated from the
  quota, and deleted quotas can be restored and modified.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer quota_mod [OPTIONS] GALAXY QUOTA

  Modify an existing quota.

  Updates the definition of the existing QUOTA in GALAXY.

  The command line arguments can be used to modify any of the quota's
  attributes, to set a new name, description or quota size and type.

  Users and groups can also be associated with or disassociated from the
  quota, and deleted quotas can be restored and modified.

Options:
  -n, --name NEW_NAME             new name for the quota.
  -d, --description NEW_DESCRIPTION
                                  new description for the quota.
  -q, --quota-size NEW_QUOTA_SIZE
                                  new quota size in the form
                                  '[OPERATION][AMOUNT]' (e.g. '=0.2T').
  --default_for registered|unregistered
                                  set the quota as the default for either
                                  'registered' or 'unregistered' users.
  -a, --add-users EMAIL[,EMAIL...]
                                  list of user emails to associate with the
                                  quota, separated by commas.
  -r, --remove-users EMAIL[,EMAIL...]
                                  list of user emails to disassociate from the
                                  quota, separated by commas.
  -A, --add-groups GROUP[,GROUP...]
                                  list of group names to associate with the
                                  quota, separated by commas.
  -R, --remove-groups GROUP[,GROUP...]
                                  list of group names to disassociate from the
                                  quota, separated by commas.
  -u, --undelete                  restores a previously deleted quota
  --help                          Show this message and exit.
```


## nebulizer_quotas

### Tool Description
List quotas in Galaxy instance.

  Prints details of quotas in GALAXY instance.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer quotas [OPTIONS] GALAXY

  List quotas in Galaxy instance.

  Prints details of quotas in GALAXY instance.

Options:
  --name TEXT                    list only quotas with matching name. Can
                                 include glob-style wild-cards.
  --status [active|deleted|all]  list quotas with the specified status; can be
                                 one of 'active', 'deleted', 'all' (default:
                                 'active')
  -l, --long                     use a long listing format that includes lists
                                 of associated users and groups.
  --help                         Show this message and exit.
```


## nebulizer_remove_key

### Tool Description
Remove stored Galaxy API key.

Removes the Galaxy URL/API key pair associated with ALIAS from the list of
stored keys.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer remove_key [OPTIONS] ALIAS

  Remove stored Galaxy API key.

  Removes the Galaxy URL/API key pair associated with ALIAS from the list of
  stored keys.

Options:
  --help  Show this message and exit.
```


## nebulizer_search_toolshed

### Tool Description
Search for repositories on a Galaxy toolshed.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer search_toolshed [OPTIONS] QUERY_STRING

  Search for repositories on a Galaxy toolshed.

  Searches for repositories on the main Galaxy toolshed using the specified
  QUERY_STRING.

  Specify other toolsheds by an alias (either 'main' or 'test') or by
  supplying the shed URL.

  If a GALAXY instance is supplied then also check whether the tool
  repositories are already installed.

Options:
  --toolshed TOOLSHED  specify a toolshed URL to search, or 'main' (the main
                       Galaxy toolshed, the default) or 'test' (the test
                       Galaxy toolshed)
  --galaxy GALAXY      check if tool repositories are installed in GALAXY
                       instance
  -l                   use a long listing format that includes tool
                       descriptions
  --help               Show this message and exit.
```


## nebulizer_uninstall_tool

### Tool Description
Uninstall previously installed tool.

Uninstalls the specified tool which was previously installed from
REPOSITORY into GALAXY, where REPOSITORY can be as one of:

- full URL (without revision) e.g.
https://toolshed.g2.bx.psu.edu/view/devteam/fastqc

- OWNER/TOOLNAME combination e.g. devteam/fastqc (toolshed is assumed to
be main Galaxy toolshed)

- [ TOOLSHED ] OWNER TOOLNAME e.g. https://toolshed.g2.bx.psu.edu devteam
fastqc

The tool must already be present in GALAXY; a revision must be specified
if more than one revision is installed (use '*' to match all revisions).

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer uninstall_tool [OPTIONS] GALAXY [REPOSITORY]...

  Uninstall previously installed tool.

  Uninstalls the specified tool which was previously installed from
  REPOSITORY into GALAXY, where REPOSITORY can be as one of:

  - full URL (without revision) e.g.
  https://toolshed.g2.bx.psu.edu/view/devteam/fastqc

  - OWNER/TOOLNAME combination e.g. devteam/fastqc (toolshed is assumed to
  be main Galaxy toolshed)

  - [ TOOLSHED ] OWNER TOOLNAME e.g. https://toolshed.g2.bx.psu.edu devteam
  fastqc

  The tool must already be present in GALAXY; a revision must be specified
  if more than one revision is installed (use '*' to match all revisions).

Options:
  --remove_from_disk  remove the uninstalled tool from disk (otherwise tool is
                      just deactivated).
  -y, --yes           don't ask for confirmation of uninstallation.
  --help              Show this message and exit.
```


## nebulizer_update_key

### Tool Description
Update stored Galaxy API key.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer update_key [OPTIONS] ALIAS

  Update stored Galaxy API key.

  Update the Galaxy URL and/or API key stored against ALIAS.

Options:
  --new-url TEXT      specify new URL for Galaxy instance
  --new-api-key TEXT  specify new API key for Galaxy instance
  --fetch-api-key     fetch new API key for Galaxy instance
  --help              Show this message and exit.
```


## nebulizer_update_tool

### Tool Description
Update tool installed from toolshed.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer update_tool [OPTIONS] GALAXY [REPOSITORY]...

  Update tool installed from toolshed.

  Updates the specified tool from REPOSITORY into GALAXY, where REPOSITORY
  can be as one of:

  - full URL (without revision) e.g.
  https://toolshed.g2.bx.psu.edu/view/devteam/fastqc

  - OWNER/TOOLNAME combination e.g. devteam/fastqc (toolshed is assumed to
  be main Galaxy toolshed)

  - [ TOOLSHED ] OWNER TOOLNAME e.g. https://toolshed.g2.bx.psu.edu devteam
  fastqc

  OWNER and TOOLNAME can include glob-style wildcards; use '*/*' to update
  all tools.

  The tool must already be present in GALAXY and a newer changeset revision
  must be available. The update will be installed into the same tool panel
  section as the original tool.

Options:
  --install-tool-dependencies [yes|no]
                                  install tool dependencies via the toolshed,
                                  if any are defined (default is 'yes')
  --install-repository-dependencies [yes|no]
                                  install repository dependencies via the
                                  toolshed, if any are defined (default is
                                  'yes')
  --install-resolver-dependencies [yes|no]
                                  install dependencies through a resolver that
                                  supports installation (e.g. conda) (default
                                  is 'yes')
  --timeout TIMEOUT               wait up to TIMEOUT seconds for tool
                                  installationsto complete (default is 600).
  --no-wait                       don't wait for lengthy tool installations to
                                  complete.
  --check-toolshed                check installed revisions directly against
                                  those available in the toolshed.
  -y, --yes                       don't ask for confirmation of updates.
  --help                          Show this message and exit.
```


## nebulizer_whoami

### Tool Description
Print user details associated with API key.

### Metadata
- **Docker Image**: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
- **Homepage**: https://github.com/pjbriggs/nebulizer
- **Package**: https://anaconda.org/channels/bioconda/packages/nebulizer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nebulizer whoami [OPTIONS] GALAXY

  Print user details associated with API key.

Options:
  --help  Show this message and exit.
```


## Metadata
- **Skill**: generated
