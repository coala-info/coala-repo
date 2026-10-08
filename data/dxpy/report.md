# dxpy CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| dxpy_dx_build | Not completed | needs a DNAnexus login token and project; the command line parses and reaches the DNAnexus server, which rejects the placeholder token. |
| dxpy_dx_cat | Not completed | needs a DNAnexus login token and project; the command line parses and reaches the DNAnexus server, which rejects the placeholder token. |
| dxpy_dx_describe | Not completed | needs a DNAnexus login token and project; the command line parses and reaches the DNAnexus server, which rejects the placeholder token. |
| dxpy_dx_download | Not completed | needs a DNAnexus login token and project; the command line parses and reaches the DNAnexus server, which rejects the placeholder token. |
| dxpy_dx_extract_dataset | Not completed | needs a DNAnexus login token and project; the command line parses and reaches the DNAnexus server, which rejects the placeholder token. |
| dxpy_dx_find_data | Not completed | needs a DNAnexus login token and project; the command line parses and reaches the DNAnexus server, which rejects the placeholder token. |
| dxpy_dx_generate_batch_inputs | Not completed | needs a DNAnexus login token and project; the command line parses and reaches the DNAnexus server, which rejects the placeholder token. |
| dxpy_dx_get | Not completed | needs a DNAnexus login token and project; the command line parses and reaches the DNAnexus server, which rejects the placeholder token. |
| dxpy_dx_head | Not completed | needs a DNAnexus login token and project; the command line parses and reaches the DNAnexus server, which rejects the placeholder token. |
| dxpy_dx_ls | Not completed | needs a DNAnexus login token and project; the command line parses and reaches the DNAnexus server, which rejects the placeholder token. |
| dxpy_dx_make_download_url | Not completed | needs a DNAnexus login token and project; the command line parses and reaches the DNAnexus server, which rejects the placeholder token. |
| dxpy_dx_run | Not completed | needs a DNAnexus login token and project; the command line parses and reaches the DNAnexus server, which rejects the placeholder token. |
| dxpy_dx_upload | Not completed | needs a DNAnexus login token and project; the command line parses and reaches the DNAnexus server, which rejects the placeholder token. |

## dxpy_dx_upload

### Tool Description
Upload local file(s) or directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
- **Homepage**: https://github.com/dnanexus/dx-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Total Downloads**: 850.9K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dnanexus/dx-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: dx upload [-h] [--visibility {hidden,visible}] [--property KEY=VALUE]
                 [--type TYPE] [--tag TAG] [--details DETAILS] [-p] [--brief |
                 --verbose] [--env-help] [--path [PATH]] [-r] [--wait]
                 [--no-progress] [--buffer-size WRITE_BUFFER_SIZE]
                 [--singlethread]
                 filename [filename ...]

Upload local file(s) or directory. If "-" is provided, stdin will be used
instead. By default, the filename will be used as its new name. If
--path/--destination is provided with a path ending in a slash, the filename
will be used, and the folder path will be used as a destination. If it does
not end in a slash, then it will be used as the final name.

positional arguments:
  filename              Local file or directory to upload ("-" indicates stdin
                        input); provide multiple times to upload multiple
                        files or directories

options:
  -h, --help            show this help message and exit
  --brief               Display a brief version of the return value; for most
                        commands, prints a DNAnexus ID per line
  --verbose             If available, displays extra verbose output
  --env-help            Display help message for overriding environment
                        variables
  --path, --destination [PATH]
                        DNAnexus path to upload file(s) to (default uses
                        current project and folder if not provided)
  -r, --recursive       Upload directories recursively
  --wait                Wait until the file has finished closing
  --no-progress         Do not show a progress bar
  --buffer-size WRITE_BUFFER_SIZE
                        Set the write buffer size (in bytes)
  --singlethread        Enable singlethreaded uploading

metadata arguments:
  --visibility {hidden,visible}
                        Whether the object is hidden or not
  --property KEY=VALUE  Key-value pair to add as a property; repeat as
                        necessary, e.g. "--property key1=val1 --property
                        key2=val2"
  --type TYPE           Type of the data object; repeat as necessary, e.g. "--
                        type type1 --type type2"
  --tag TAG             Tag of the data object; repeat as necessary, e.g. "--
                        tag tag1 --tag tag2"
  --details DETAILS     JSON to store as details
  -p, --parents         Create any parent folders necessary

Environment override options (dx <command> --env-help):
  --apiserver-host APISERVER_HOST
                        API server host
  --apiserver-port APISERVER_PORT
                        API server port
  --apiserver-protocol APISERVER_PROTOCOL
                        API server protocol (http or https)
  --project-context-id PROJECT_CONTEXT_ID
                        Default project or project context ID
  --workspace-id WORKSPACE_ID
                        Workspace ID (for jobs only)
  --security-context SECURITY_CONTEXT
                        JSON string of security context
  --auth-token AUTH_TOKEN
                        Authentication token
```

## dxpy_dx_download

### Tool Description
Download the contents of a file object or multiple objects.

### Metadata
- **Docker Image**: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
- **Homepage**: https://github.com/dnanexus/dx-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Total Downloads**: 850.9K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dnanexus/dx-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: dx download [-h] [--env-help] [-o OUTPUT] [-f] [-r] [-a]
                   [--no-progress] [--lightweight]
                   [--symlink-max-tries SYMLINK_MAX_TRIES] [--unicode]
                   path [path ...]

Download the contents of a file object or multiple objects. Use "-o -" to
direct the output to stdout.

positional arguments:
  path                  Data object ID or name, or folder to download

options:
  -h, --help            show this help message and exit
  --env-help            Display help message for overriding environment
                        variables
  -o, --output OUTPUT   Local filename or directory to be used ("-" indicates
                        stdout output); if not supplied or a directory is
                        given, the object's name on the platform will be used,
                        along with any applicable extensions
  -f, --overwrite       Resume an interupted download if the local and remote
                        file signatures match. If the signatures do not match
                        the local file will be overwritten.
  -r, --recursive       Download folders recursively
  -a, --all             If multiple objects match the input, download all of
                        them
  --no-progress         Do not show a progress bar
  --lightweight         Skip some validation steps to make fewer API calls
  --symlink-max-tries SYMLINK_MAX_TRIES
                        Set maximum number of tries for downloading symlinked
                        files using aria2c
  --unicode             Display the characters as text/unicode when writing to
                        stdout

Environment override options (dx <command> --env-help):
  --apiserver-host APISERVER_HOST
                        API server host
  --apiserver-port APISERVER_PORT
                        API server port
  --apiserver-protocol APISERVER_PROTOCOL
                        API server protocol (http or https)
  --project-context-id PROJECT_CONTEXT_ID
                        Default project or project context ID
  --workspace-id WORKSPACE_ID
                        Workspace ID (for jobs only)
  --security-context SECURITY_CONTEXT
                        JSON string of security context
  --auth-token AUTH_TOKEN
                        Authentication token
```

## dxpy_dx_cat

### Tool Description
Print file(s) to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
- **Homepage**: https://github.com/dnanexus/dx-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Total Downloads**: 850.9K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dnanexus/dx-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: dx cat [-h] [--env-help] [--unicode] path [path ...]

positional arguments:
  path        File ID or name(s) to print to stdout

options:
  -h, --help  show this help message and exit
  --env-help  Display help message for overriding environment variables
  --unicode   Display the characters as text/unicode when writing to stdout

Environment override options (dx <command> --env-help):
  --apiserver-host APISERVER_HOST
                        API server host
  --apiserver-port APISERVER_PORT
                        API server port
  --apiserver-protocol APISERVER_PROTOCOL
                        API server protocol (http or https)
  --project-context-id PROJECT_CONTEXT_ID
                        Default project or project context ID
  --workspace-id WORKSPACE_ID
                        Workspace ID (for jobs only)
  --security-context SECURITY_CONTEXT
                        JSON string of security context
  --auth-token AUTH_TOKEN
                        Authentication token
```

## dxpy_dx_head

### Tool Description
Print the first part of a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
- **Homepage**: https://github.com/dnanexus/dx-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Total Downloads**: 850.9K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dnanexus/dx-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: dx head [-h] [--color {off,on,auto}] [--env-help] [-n N] path

Print the first part of a file. By default, prints the first 10 lines.

positional arguments:
  path                  File ID or name to access

options:
  -h, --help            show this help message and exit
  --color {off,on,auto}
                        Set when color is used (color=auto is used when stdout
                        is a TTY)
  --env-help            Display help message for overriding environment
                        variables
  -n, --lines N         Print the first N lines (default 10)

Environment override options (dx <command> --env-help):
  --apiserver-host APISERVER_HOST
                        API server host
  --apiserver-port APISERVER_PORT
                        API server port
  --apiserver-protocol APISERVER_PROTOCOL
                        API server protocol (http or https)
  --project-context-id PROJECT_CONTEXT_ID
                        Default project or project context ID
  --workspace-id WORKSPACE_ID
                        Workspace ID (for jobs only)
  --security-context SECURITY_CONTEXT
                        JSON string of security context
  --auth-token AUTH_TOKEN
                        Authentication token
```

## dxpy_dx_describe

### Tool Description
Describe a DNAnexus entity.

### Metadata
- **Docker Image**: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
- **Homepage**: https://github.com/dnanexus/dx-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Total Downloads**: 850.9K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dnanexus/dx-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: dx describe [-h] [--json] [--color {off,on,auto}]
                   [--delimiter [DELIMITER]] [--env-help] [--details]
                   [--verbose] [--name] [--multi] [--try T]
                   path

Describe a DNAnexus entity.  Use this command to describe data objects by name
or ID, jobs, apps, users, organizations, etc.  If using the "--json" flag, it
will thrown an error if more than one match is found (but if you would like a
JSON array of the describe hashes of all matches, then provide the "--multi"
flag).  Otherwise, it will always display all results it finds.

NOTES:

- The project found in the path is used as a HINT when you are using an object
ID; you may still get a result if you have access to a copy of the object in
some other project, but if it exists in the specified project, its description
will be returned.

- When describing apps or applets, options marked as advanced inputs will be
hidden unless --verbose is provided

positional arguments:
  path                  Object ID or path to an object (possibly in another
                        project) to describe.

options:
  -h, --help            show this help message and exit
  --json                Display return value in JSON
  --color {off,on,auto}
                        Set when color is used (color=auto is used when stdout
                        is a TTY)
  --delimiter, --delim [DELIMITER]
                        Always use exactly one of DELIMITER to separate fields
                        to be printed; if no delimiter is provided with this
                        flag, TAB will be used
  --env-help            Display help message for overriding environment
                        variables
  --details             Include details of data objects
  --verbose             Include additional metadata
  --name                Only print the matching names, one per line
  --multi               If the flag --json is also provided, then returns a
                        JSON array of describe hashes of all matching results
  --try T               When describing a job that was restarted, describe job
                        try T. T=0 refers to the first try. Default is the
                        last job try.

Environment override options (dx <command> --env-help):
  --apiserver-host APISERVER_HOST
                        API server host
  --apiserver-port APISERVER_PORT
                        API server port
  --apiserver-protocol APISERVER_PROTOCOL
                        API server protocol (http or https)
  --project-context-id PROJECT_CONTEXT_ID
                        Default project or project context ID
  --workspace-id WORKSPACE_ID
                        Workspace ID (for jobs only)
  --security-context SECURITY_CONTEXT
                        JSON string of security context
  --auth-token AUTH_TOKEN
                        Authentication token
```

## dxpy_dx_ls

### Tool Description
List folders and/or objects in a folder.

### Metadata
- **Docker Image**: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
- **Homepage**: https://github.com/dnanexus/dx-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Total Downloads**: 850.9K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dnanexus/dx-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: dx ls [-h] [--color {off,on,auto}] [--delimiter [DELIMITER]]
             [--env-help] [--brief | --verbose] [-a] [-l] [--obj] [--folders]
             [--full]
             [path]

List folders and/or objects in a folder

positional arguments:
  path                  Folder (possibly in another project) to list the
                        contents of, default is the current directory in the
                        current project. Syntax: projectID:/folder/path

options:
  -h, --help            show this help message and exit
  --color {off,on,auto}
                        Set when color is used (color=auto is used when stdout
                        is a TTY)
  --delimiter, --delim [DELIMITER]
                        Always use exactly one of DELIMITER to separate fields
                        to be printed; if no delimiter is provided with this
                        flag, TAB will be used
  --env-help            Display help message for overriding environment
                        variables
  --brief               Display a brief version of the return value; for most
                        commands, prints a DNAnexus ID per line
  --verbose             If available, displays extra verbose output
  -a, --all             show hidden files
  -l, --long            Alias for "verbose"
  --obj                 show only objects
  --folders             show only folders
  --full                show full paths of folders

Environment override options (dx <command> --env-help):
  --apiserver-host APISERVER_HOST
                        API server host
  --apiserver-port APISERVER_PORT
                        API server port
  --apiserver-protocol APISERVER_PROTOCOL
                        API server protocol (http or https)
  --project-context-id PROJECT_CONTEXT_ID
                        Default project or project context ID
  --workspace-id WORKSPACE_ID
                        Workspace ID (for jobs only)
  --security-context SECURITY_CONTEXT
                        JSON string of security context
  --auth-token AUTH_TOKEN
                        Authentication token
```

## dxpy_dx_find_data

### Tool Description
Finds data objects subject to the given search parameters.

### Metadata
- **Docker Image**: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
- **Homepage**: https://github.com/dnanexus/dx-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Total Downloads**: 850.9K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dnanexus/dx-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: dx find data [-h] [--brief | --verbose] [--json]
                    [--color {off,on,auto}] [--delimiter [DELIMITER]]
                    [--env-help] [--property KEY[=VALUE]] [--tag TAG]
                    [--class {record,file,applet,workflow,database}]
                    [--state {open,closing,closed,any}]
                    [--visibility {hidden,visible,either}] [--name NAME]
                    [--name-mode {glob,exact,regexp}] [--type TYPE]
                    [--link LINK] [--all-projects] [--path PROJECT:FOLDER]
                    [--norecurse] [--created-after CREATED_AFTER]
                    [--created-before CREATED_BEFORE] [--mod-after MOD_AFTER]
                    [--mod-before MOD_BEFORE] [--region REGION]

Finds data objects subject to the given search parameters. By default,
restricts the search to the current project if set. To search over all
projects (excluding public projects), use --all-projects (overrides --path and
--norecurse).

options:
  -h, --help            show this help message and exit
  --brief               Display a brief version of the return value; for most
                        commands, prints a DNAnexus ID per line
  --verbose             If available, displays extra verbose output
  --json                Display return value in JSON
  --color {off,on,auto}
                        Set when color is used (color=auto is used when stdout
                        is a TTY)
  --delimiter, --delim [DELIMITER]
                        Always use exactly one of DELIMITER to separate fields
                        to be printed; if no delimiter is provided with this
                        flag, TAB will be used
  --env-help            Display help message for overriding environment
                        variables
  --property KEY[=VALUE]
                        Key-value pair of a property or simply a property key;
                        if only a key is provided, matches a result that has
                        the key with any value; repeat as necessary, e.g. "--
                        property key1=val1 --property key2"
  --tag TAG             Tag to match; repeat as necessary, e.g. "--tag tag1
                        --tag tag2" will require both tags
  --class {record,file,applet,workflow,database}
                        Data object class
  --state {open,closing,closed,any}
                        State of the object
  --visibility {hidden,visible,either}
                        Whether the object is hidden or not
  --name NAME           Search criteria for the object name, interpreted
                        according to the --name-mode
  --name-mode {glob,exact,regexp}
                        Name mode to use for searching
  --type TYPE           Type of the data object
  --link LINK           Object ID that the data object links to
  --all-projects, --allprojects
                        Extend search to all projects (excluding public
                        projects)
  --path PROJECT:FOLDER
                        Project and/or folder in which to restrict the results
  --norecurse           Do not recurse into subfolders
  --created-after CREATED_AFTER
                        Date (e.g. --created-after="2021-12-01" or --created-
                        after="2021-12-01 19:01:33") or integer Unix epoch
                        timestamp in milliseconds (e.g. --created-
                        after=1642196636000) after which the object was
                        created. You can also specify negative numbers to
                        indicate a time period in the past suffixed by s, m,
                        h, d, w, M or y to indicate seconds, minutes, hours,
                        days, weeks, months or years (e.g. --created-after=-2d
                        for objects created in the last 2 days).
  --created-before CREATED_BEFORE
                        Date (e.g. --created-before="2021-12-01" or --created-
                        before="2021-12-01 19:01:33") or integer Unix epoch
                        timestamp in milliseconds (e.g. --created-
                        before=1642196636000) before which the object was
                        created. You can also specify negative numbers to
                        indicate a time period in the past suffixed by s, m,
                        h, d, w, M or y to indicate seconds, minutes, hours,
                        days, weeks, months or years (e.g. --created-
                        before=-2d for objects created earlier than 2 days
                        ago)
  --mod-after MOD_AFTER
                        Date (e.g. --mod-after="2021-12-01" or --mod-
                        after="2021-12-01 19:01:33") or integer Unix epoch
                        timestamp in milliseconds (e.g. --mod-
                        after=1642196636000) after which the object was
                        modified. You can also specify negative numbers to
                        indicate a time period in the past suffixed by s, m,
                        h, d, w, M or y to indicate seconds, minutes, hours,
                        days, weeks, months or years (e.g. --mod-after=-2d for
                        objects modified in the last 2 days)
  --mod-before MOD_BEFORE
                        Date (e.g. --mod-before="2021-12-01" or --mod-
                        before="2021-12-01 19:01:33") or integer Unix epoch
                        timestamp in milliseconds (e.g. --mod-
                        before=1642196636000) before which the object was
                        modified. You can also specify negative numbers to
                        indicate a time period in the past suffixed by s, m,
                        h, d, w, M or y to indicate seconds, minutes, hours,
                        days, weeks, months or years (e.g. --mod-before=-2d
                        for objects modified earlier than 2 days ago)
  --region REGION       Restrict the search to the provided region

Environment override options (dx <command> --env-help):
  --apiserver-host APISERVER_HOST
                        API server host
  --apiserver-port APISERVER_PORT
                        API server port
  --apiserver-protocol APISERVER_PROTOCOL
                        API server protocol (http or https)
  --project-context-id PROJECT_CONTEXT_ID
                        Default project or project context ID
  --workspace-id WORKSPACE_ID
                        Workspace ID (for jobs only)
  --security-context SECURITY_CONTEXT
                        JSON string of security context
  --auth-token AUTH_TOKEN
                        Authentication token
```

## dxpy_dx_get

### Tool Description
Download the contents of some types of data (records, apps, applets, workflows, files, and databases).

### Metadata
- **Docker Image**: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
- **Homepage**: https://github.com/dnanexus/dx-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Total Downloads**: 850.9K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dnanexus/dx-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: dx get [-h] [--env-help] [-o OUTPUT] [--filename FILENAME]
              [--allow-all-files] [--recurse] [--no-ext] [--omit-resources]
              [-f]
              path

Download the contents of some types of data (records, apps, applets,
workflows, files, and databases). Downloading an app, applet or a workflow
will attempt to reconstruct a source directory that can be used to rebuild it
with "dx build". Use "-o -" to direct the output to stdout.

positional arguments:
  path                 Data object ID or name to access

options:
  -h, --help           show this help message and exit
  --env-help           Display help message for overriding environment
                       variables
  -o, --output OUTPUT  local file path where the data is to be saved ("-"
                       indicates stdout output for objects of class file and
                       record). If not supplied, the object's name on the
                       platform will be used, along with any applicable
                       extensions. For app(let) and workflow objects, if
                       OUTPUT does not exist, the object's source directory
                       will be created there; if OUTPUT is an existing
                       directory, a new directory with the object's name will
                       be created inside it.
  --filename FILENAME  When downloading from a database, name of the file or
                       folder to be downloaded. If omitted, all files in the
                       database will be downloaded, so use caution and include
                       the --allow-all-files argument.
  --allow-all-files    When downloading from a database, this allows all files
                       in a database to be downloaded when --filename argument
                       is omitted.
  --recurse            When downloading from a database, look for files
                       recursively down the directory structure. Otherwise, by
                       default, only look on one level.
  --no-ext             If -o is not provided, do not add an extension to the
                       filename
  --omit-resources     When downloading an app(let), omit fetching the
                       resources associated with the app(let).
  -f, --overwrite      Overwrite the local file if necessary

Environment override options (dx <command> --env-help):
  --apiserver-host APISERVER_HOST
                        API server host
  --apiserver-port APISERVER_PORT
                        API server port
  --apiserver-protocol APISERVER_PROTOCOL
                        API server protocol (http or https)
  --project-context-id PROJECT_CONTEXT_ID
                        Default project or project context ID
  --workspace-id WORKSPACE_ID
                        Workspace ID (for jobs only)
  --security-context SECURITY_CONTEXT
                        JSON string of security context
  --auth-token AUTH_TOKEN
                        Authentication token
```

## dxpy_dx_run

### Tool Description
Run an applet, app, or workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
- **Homepage**: https://github.com/dnanexus/dx-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Total Downloads**: 850.9K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dnanexus/dx-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: dx run [-i INPUT] [-j INPUT_JSON] [-f FILENAME] [--brief | --verbose]
              [--env-help] [--extra-args EXTRA_ARGS]
              [--instance-type INSTANCE_TYPE_OR_MAPPING]
              [--instance-type-by-executable DOUBLE_MAPPING]
              [--instance-type-help] [--property KEY=VALUE] [--tag TAG]
              [-d DEPENDS_ON] [-h] [--clone CLONE] [--alias ALIAS]
              [--destination PATH] [--batch-folders] [--project PROJECT]
              [--stage-output-folder STAGE_ID FOLDER]
              [--stage-relative-output-folder STAGE_ID FOLDER] [--name NAME]
              [--delay-workspace-destruction] [--priority {low,normal,high}]
              [--head-job-on-demand] [-y] [--wait] [--watch]
              [--allow-ssh [ADDRESS]] [--ssh] [--ssh-proxy <address>:<port>]
              [--debug-on {AppError,AppInternalError,ExecutionError,All}]
              [--ignore-reuse | --ignore-reuse-stage STAGE_ID]
              [--rerun-stage STAGE_ID] [--batch-tsv FILE]
              [--instance-count INSTANCE_COUNT_OR_MAPPING] [--input-help]
              [--detach] [--cost-limit cost_limit] [-r RANK]
              [--max-tree-spot-wait-time MAX_TREE_SPOT_WAIT_TIME]
              [--max-job-spot-wait-time MAX_JOB_SPOT_WAIT_TIME]
              [--detailed-job-metrics] [--preserve-job-outputs |
              --preserve-job-outputs-folder JOB_OUTPUTS_FOLDER]
              [executable]

Run an applet, app, or workflow.  To see a list of executables you can run,
hit <TAB> twice after "dx run" or run "dx find apps" or "dx find
globalworkflows" to see a list of available apps and global workflows.

If any inputs are required but not specified, an interactive mode for
selecting inputs will be launched.  Inputs can be set in multiple ways.  Run
"dx run --input-help" for more details.

Run "dx run --instance-type-help" to see a list of specifications for
computers available to run executables.

positional arguments:
  executable            Name or ID of an applet, app, or workflow to run; must
                        be provided if --clone is not set

options:
  -i, --input INPUT     An input to be added using "<input
                        name>[:<class>]=<input value>" (provide "class" if
                        there is no input spec; it can be any job IO class,
                        e.g. "string", "array:string", or "array"; if "class"
                        is "array" or not specified, the value will be
                        attempted to be parsed as JSON and is otherwise
                        treated as a string)
  -j, --input-json INPUT_JSON
                        The full input JSON (keys=input field names,
                        values=input field values)
  -f, --input-json-file FILENAME
                        Load input JSON from FILENAME ("-" to use stdin)
  --brief               Display a brief version of the return value; for most
                        commands, prints a DNAnexus ID per line
  --verbose             If available, displays extra verbose output
  --env-help            Display help message for overriding environment
                        variables
  --extra-args EXTRA_ARGS
                        Arguments (in JSON format) to pass to the underlying
                        API method, overriding the default settings
  --instance-type INSTANCE_TYPE_OR_MAPPING
                        When running an app or applet, the mapping lists
                        executable's entry points or "*" as keys, and instance
                        types to use for these entry points as values.  
                        When
                        running a workflow, the specified instance types can
                        be prefixed by a stage name or stage index followed by
                        "=" to apply to a specific stage, or apply to all
                        workflow stages without such prefix. 
                        The instance
                        type corresponding to the "*" key is applied to all
                        entry points not explicitly mentioned in the
                        --instance-type mapping. Specifying a single instance
                        type is equivalent to using it for all entry points,
                        so "--instance-type mem1_ssd1_v2_x2" is same as
                        "--instance-type '{"*":"mem1_ssd1_v2_x2"}'. 
                        Note that
                        "dx run" calls within the execution subtree may
                        override the values specified at the root of the
                        execution tree.
                        See dx run --instance-type-help for
                        details.
  --instance-type-by-executable DOUBLE_MAPPING
                        Specifies instance types by app or applet id, then by
                        entry point within the executable.
                        The order of
                        priority for this specification is:
                          *
                        --instance-type, systemRequirements and
                        stageSystemRequirements specified at runtime
                          *
                        stage's systemRequirements, systemRequirements
                        supplied to /app/new and /applet/new at
                        workflow/app/applet build time
                          *
                        systemRequirementsByExecutable specified in downstream
                        executions (if any)
                        See dx run --instance-type-help
                        for details.
  --instance-type-help  Print help for specifying instance types
  --property KEY=VALUE  Key-value pair to add as a property; repeat as
                        necessary,
                         e.g. "--property key1=val1 --property key2=val2"
  --tag TAG             Tag for the resulting execution; repeat as necessary,
                         e.g. "--tag tag1 --tag tag2"
  -d, --depends-on DEPENDS_ON
                        ID of job, analysis, or data object that must be in
                        the "done" or "closed" state, as appropriate, before
                        this executable can be run; repeat as necessary (e.g.
                        "--depends-on id1 ... --depends-on idN"). Cannot be
                        supplied when running workflows
  -h, --help            show this help message and exit
  --clone CLONE         Job or analysis ID or name from which to use as
                        default options (will use the exact same executable
                        ID, destination project and folder, job input,
                        instance type requests, and a similar name unless
                        explicitly overridden by command-line arguments. When
                        using an analysis with --clone a workflow executable
                        cannot be overriden and should not be provided.)
  --alias, --version ALIAS
                        Alias (tag) or version of the app to run (default:
                        "default" if an app)
  --destination, --folder PATH
                        The full project:folder path in which to output the
                        results. By default, the current working directory
                        will be used.
  --batch-folders       Output results to separate folders, one per batch,
                        using batch ID as the name of the output folder. The
                        batch output folder location will be relative to the
                        path set in --destination
  --project PROJECT     Project name or ID in which to run the executable.
                        This can also be specified together with the output
                        folder in --destination.
  --stage-output-folder STAGE_ID FOLDER
                        A stage identifier (ID, name, or index), and a folder
                        path to use as its output folder
  --stage-relative-output-folder STAGE_ID FOLDER
                        A stage identifier (ID, name, or index), and a
                        relative folder path to the workflow output folder to
                        use as the output folder
  --name NAME           Name for the job (default is the app or applet name)
  --delay-workspace-destruction
                        Whether to keep the job's temporary workspace around
                        for debugging purposes for 3 days after it succeeds or
                        fails
  --priority {low,normal,high}
                        Request a scheduling priority for all resulting jobs.
                        Defaults to high when --watch, --ssh, or --allow-ssh
                        flags are used.
  --head-job-on-demand  Requests that the head job of an app or applet be run
                        in an on-demand instance. Note that
                        --head-job-on-demand option will override the
                        --priority setting for the head job
  -y, --yes             Do not ask for confirmation
  --wait                Wait until the job is done before returning
  --watch               Watch the job after launching it. Defaults --priority to high.
  --allow-ssh [ADDRESS]
                        Configure the job to allow SSH access. Defaults
                        --priority to high. If an argument is supplied, it is
                        interpreted as an IP range, e.g. "--allow-ssh
                        1.2.3.4". If no argument is supplied then the client
                        IP visible to the DNAnexus API server will be used by
                        default
  --ssh                 Configure the job to allow SSH access and connect to
                        it after launching. Defaults --priority to high.
  --ssh-proxy <address>:<port>
                        SSH connect via proxy, argument supplied is used as
                        the proxy address and port
  --debug-on {AppError,AppInternalError,ExecutionError,All}
                        Configure the job to hold for debugging when any of
                        the listed errors occur
  --ignore-reuse        Disable job reuse for execution
  --ignore-reuse-stage STAGE_ID
                        A stage (using its ID, name, or index) for which job
                        reuse should be disabled, if a stage points to another
                        (nested) workflow the ignore reuse option will be
                        applied to the whole subworkflow. This option
                        overwrites any ignoreReuse fields set on app(let)s or
                        the workflow during build time; repeat as necessary
  --rerun-stage STAGE_ID
                        A stage (using its ID, name, or index) to rerun, or
                        "*" to indicate all stages should be rerun; repeat as
                        necessary
  --batch-tsv FILE      A file in tab separated value (tsv) format, with a
                        subset of the executable input arguments. A job will
                        be launched for each table row.
  --instance-count INSTANCE_COUNT_OR_MAPPING
                        Specify spark cluster instance count(s). It can be an
                        int or a mapping of the format '{"entrypoint": <number
                        of instances>}'
  --input-help          Print help and examples for how to specify inputs
  --detach              When invoked from a job, detaches the new job from the
                        creator job so the new job will appear as a typical
                        root execution. Setting DX_RUN_DETACH environment
                        variable to 1 causes this option to be set by default.
  --cost-limit cost_limit
                        Maximum cost of the job before termination. In case of
                        workflows it is cost of the entire analysis job. For
                        batch run, this limit is applied per job.
  -r, --rank RANK       Set the rank of the root execution, integer between
                        -1024 and 1023. Requires executionRankEnabled license
                        feature for the billTo. Default is 0.
  --max-tree-spot-wait-time MAX_TREE_SPOT_WAIT_TIME
                        The amount of time allocated to each path in the root
                        execution's tree to wait for Spot (in seconds, or use
                        suffix s, m, h, d, w, M, y)
  --max-job-spot-wait-time MAX_JOB_SPOT_WAIT_TIME
                        The amount of time allocated to each job in the root
                        execution's tree to wait for Spot (in seconds, or use
                        suffix s, m, h, d, w, M, y)
  --detailed-job-metrics
                        Collect CPU, memory, network and disk metrics every 60
                        seconds
  --preserve-job-outputs
                        Copy cloneable outputs of every non-reused job
                        entering "done" state in this root execution R into
                        the "intermediateJobOutputs" subfolder under R's
                        output folder.  As R's root job or root analysis'
                        stages complete, R's regular outputs will be moved to
                        R's regular output folder.
  --preserve-job-outputs-folder JOB_OUTPUTS_FOLDER
                        Similar to --preserve-job-outputs, copy cloneable
                        outputs of every non-reused job entering "done" state
                        in this root execution to the specified folder in the
                        project.  JOB_OUTPUTS_FOLDER starting with '/' refers
                        to an absolute path within the project, otherwise, it
                        refers to a subfolder under root execution's output
                        folder.

Environment override options (dx <command> --env-help):
  --apiserver-host APISERVER_HOST
                        API server host
  --apiserver-port APISERVER_PORT
                        API server port
  --apiserver-protocol APISERVER_PROTOCOL
                        API server protocol (http or https)
  --project-context-id PROJECT_CONTEXT_ID
                        Default project or project context ID
  --workspace-id WORKSPACE_ID
                        Workspace ID (for jobs only)
  --security-context SECURITY_CONTEXT
                        JSON string of security context
  --auth-token AUTH_TOKEN
                        Authentication token
```

## dxpy_dx_build

### Tool Description
Build an applet, app, or workflow object from a local source directory or an app from an existing applet in the platform.

### Metadata
- **Docker Image**: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
- **Homepage**: https://github.com/dnanexus/dx-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Total Downloads**: 850.9K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dnanexus/dx-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: dx build [-h] [--env-help] [--brief | --verbose] [--ensure-upload]
                [--force-symlinks] [--app] [--workflow] [--globalworkflow]
                [-d DESTINATION] [--dry-run] [--publish] [--from _FROM]
                [--remote] [--no-watch] [-f] [-a] [-v VERSION]
                [-b USER_OR_ORG] [--no-check-syntax]
                [--no-version-autonumbering] [--no-update]
                [--no-parallel-build] [--no-temp-build-project] [-y]
                [--extra-args EXTRA_ARGS] [--run ...] [--region REGION]
                [--keep-open] [--nextflow] [--profile PROFILE]
                [--repository REPOSITORY] [--repository-tag TAG]
                [--git-credentials GIT_CREDENTIALS] [--cache-docker]
                [--docker-secrets DOCKER_SECRETS]
                [--nextflow-pipeline-params NEXTFLOW_PIPELINE_PARAMS]
                [src_dir]

Build an applet, app, or workflow object from a local source directory or an
app from an existing applet in the platform. You can use dx-app-wizard to
generate a skeleton directory of an app/applet with the necessary files.

positional arguments:
  src_dir               Source directory that contains dxapp.json,
                        dxworkflow.json or *.nf (for --nextflow option).
                        (default: current directory)

options:
  -h, --help            show this help message and exit
  --env-help            Display help message for overriding environment
                        variables
  --brief               Display a brief version of the return value; for most
                        commands, prints a DNAnexus ID per line
  --verbose             If available, displays extra verbose output
  --ensure-upload       If specified, will bypass computing checksum of
                        resources directory and upload it unconditionally; by
                        default, will compute checksum and upload only if it
                        differs from a previously uploaded resources bundle.
  --force-symlinks      If specified, will not attempt to dereference symbolic
                        links pointing outside of the resource directory. By
                        default, any symlinks within the resource directory
                        are kept as links while links to files outside the
                        resource directory are dereferenced (note that links
                        to directories outside of the resource directory will
                        cause an error).
  --app, --create-app   Create an app.
  --workflow, --create-workflow
                        Create a workflow.
  --globalworkflow, --create-globalworkflow
                        Create a global workflow.
  --dry-run, -n         Do not create an app(let): only perform local checks
                        and compilation steps, and show the spec of the
                        app(let) that would have been created.
  --remote              Build the app remotely by uploading the source
                        directory to the DNAnexus Platform and building it
                        there. This option is useful if you would otherwise
                        need to cross-compile the app(let) to target the
                        Execution Environment.
  --no-watch            Don't watch the real-time logs of the remote builder
                        (this option is only applicable if --remote or
                        --repository is specified).
  -v, --version VERSION
                        Override the version number supplied in the manifest.
                        This option needs to be specified when using --from
                        option.
  --no-check-syntax     Warn but do not fail when syntax problems are found
                        (default is to fail on such errors).
  --no-parallel-build   Build with make instead of make -jN.
  --extra-args EXTRA_ARGS
                        Arguments (in JSON format) to pass to the /applet/new
                        API method, overriding all other settings
  --run ...             Run the app or applet after building it (options
                        following this are passed to dx run; run at high
                        priority by default).
  --keep-open           Do not close workflow after building it. Cannot be
                        used when building apps, applets or global workflows.
  --nextflow            Build Nextflow applet.

Options for creating apps or globalworkflows:
  (Only valid when --app/--create-app/--globalworkflow/--create-
  globalworkflow is specified)

  --publish             Publish the resulting app/globalworkflow and make it
                        the default.
  --from _FROM          ID or path of the source applet/workflow to create an
                        app/globalworkflow from. Source directory src_dir
                        cannot be given when using this option
  -b, --bill-to USER_OR_ORG
                        Entity (of the form user-NAME or org-ORGNAME) to bill
                        for the app/globalworkflow.
  --no-version-autonumbering
                        Only attempt to create the version number supplied in
                        the manifest (that is, do not try to create an
                        autonumbered version such as 1.2.3+git.ab1b1c1d if
                        1.2.3 already exists and is published).
  --no-update           Never update an existing unpublished
                        app/globalworkflow in place.
  --no-temp-build-project
                        When building an app in a single region, build its
                        applet in the current project instead of a temporary
                        project.
  -y, --yes             Do not ask for confirmation for potentially dangerous
                        operations
  --region REGION       Enable the app/globalworkflow in this region. This
                        flag can be specified multiple times to enable the
                        app/globalworkflow in multiple regions. If --region is
                        not specified, then the enabled region(s) will be
                        determined by 'regionalOptions' in dxapp.json, or the
                        project context.

Options for creating applets or workflows:
  (Only valid when --app/--create-app/--globalworkflow/--create-
  globalworkflow is NOT specified)

  -d, --destination DESTINATION
                        Specifies the destination project, destination folder,
                        and/or name for the applet, in the form
                        [PROJECT_NAME_OR_ID:][/[FOLDER/][NAME]]. Overrides the
                        project, folder, and name fields of the dxapp.json or
                        dxworkflow.json, if they were supplied.
  -f, --overwrite       Remove existing applet(s) of the same name in the
                        destination folder. This option is not yet supported
                        for workflows.
  -a, --archive         Archive existing applet(s) of the same name in the
                        destination folder. This option is not yet supported
                        for workflows.

Options for creating Nextflow applets:
  (Only valid when --nextflow is specified)

  --profile PROFILE     Default profile for the Nextflow pipeline.
  --repository REPOSITORY
                        Specifies a Git repository of a Nextflow pipeline.
                        Incompatible with --remote.
  --repository-tag TAG  Specifies tag for Git repository. Can be used only
                        with --repository.
  --git-credentials GIT_CREDENTIALS
                        Git credentials used to access Nextflow pipelines from
                        private Git repositories. Can be used only with
                        --repository. More information about the file syntax
                        can be found at https://www.nextflow.io/blog/2021/conf
                        igure-git-repositories-with-nextflow.html.
  --cache-docker        Stores a container image tarball in the currently
                        selected project in /.cached_dockerImages. Currently
                        only docker engine is supported. Incompatible with
                        --remote, --force, --archive, --dry-run, --json.
  --docker-secrets DOCKER_SECRETS
                        A dx file id with credentials for a private docker
                        repository.
  --nextflow-pipeline-params NEXTFLOW_PIPELINE_PARAMS
                        Custom pipeline parameters to be referenced when
                        collecting the docker images.

Environment override options (dx <command> --env-help):
  --apiserver-host APISERVER_HOST
                        API server host
  --apiserver-port APISERVER_PORT
                        API server port
  --apiserver-protocol APISERVER_PROTOCOL
                        API server protocol (http or https)
  --project-context-id PROJECT_CONTEXT_ID
                        Default project or project context ID
  --workspace-id WORKSPACE_ID
                        Workspace ID (for jobs only)
  --security-context SECURITY_CONTEXT
                        JSON string of security context
  --auth-token AUTH_TOKEN
                        Authentication token
```

## dxpy_dx_generate_batch_inputs

### Tool Description
Generate a table of input files matching desired regular expressions for each input.

### Metadata
- **Docker Image**: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
- **Homepage**: https://github.com/dnanexus/dx-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Total Downloads**: 850.9K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dnanexus/dx-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: dx generate_batch_inputs [-h] [-i INPUT] [--path PROJECT:FOLDER]
                                [-o OUTPUT_PREFIX]

Generate a table of input files matching desired regular expressions for each
input.

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     An input to be batch-processed "-i<input name>=<input
                        pattern>" where <input_pattern> is a regular
                        expression with a group corresponding to the desired
                        region to match (e.g. "-iinputa=SRR(.*)_1.gz"
                        "-iinputb=SRR(.*)_2.gz")
  --path PROJECT:FOLDER
                        Project and/or folder to which the search for input
                        files will be restricted
  -o, --output_prefix OUTPUT_PREFIX
                        Prefix for output file

Environment override options (dx <command> --env-help):
  --apiserver-host APISERVER_HOST
                        API server host
  --apiserver-port APISERVER_PORT
                        API server port
  --apiserver-protocol APISERVER_PROTOCOL
                        API server protocol (http or https)
  --project-context-id PROJECT_CONTEXT_ID
                        Default project or project context ID
  --workspace-id WORKSPACE_ID
                        Workspace ID (for jobs only)
  --security-context SECURITY_CONTEXT
                        JSON string of security context
  --auth-token AUTH_TOKEN
                        Authentication token
```

## dxpy_dx_extract_dataset

### Tool Description
Retrieves the data or generates SQL to retrieve the data from a dataset or cohort for a set of entity.fields.

### Metadata
- **Docker Image**: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
- **Homepage**: https://github.com/dnanexus/dx-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Total Downloads**: 850.9K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dnanexus/dx-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: dx extract_dataset [-h] [-ddd] [--fields FIELDS]
                          [--fields-file FIELDS_FILE] [--sql]
                          [--delim [DELIM]] [-o OUTPUT] [--list-fields]
                          [--list-entities] [--entities ENTITIES]
                          path

Retrieves the data or generates SQL to retrieve the data from a dataset or
cohort for a set of entity.fields. Additionally, the dataset's dictionary can
be extracted independently or in conjunction with data. Provides listing
options for entities and fields.

positional arguments:
  path                  v3.0 Dataset or Cohort object ID (project-id:record-id
                        where "record-id" indicates the record ID in the
                        currently selected project) or name

options:
  -h, --help            show this help message and exit
  -ddd, --dump-dataset-dictionary
                        If provided, the three dictionary files,
                        <record_name>.data_dictionary.csv,
                        <record_name>.entity_dictionary.csv, and
                        <record_name>.codings.csv will be generated. Files
                        will be comma delimited and written to the local
                        working directory, unless otherwise specified using
                        --delimiter and --output arguments. If stdout is
                        specified with the output argument, the data
                        dictionary, entity dictionary, and coding are output
                        in succession, without separators. If any of the three
                        dictionary files does not contain data (i.e. the
                        dictionary is empty), then that particular file will
                        not be created (or be output if the output is stdout).
  --fields FIELDS       A comma-separated string where each value is the
                        phenotypic entity name and field name, separated by a
                        dot. For example: "<entity_name>.<field_name>,<entity_
                        name>.<field_name>". Internal spaces are permitted. If
                        multiple entities are provided, field values will be
                        automatically inner joined. If only the --fields
                        argument is provided, data will be retrieved and
                        returned. If both --fields and --sql arguments are
                        provided, a SQL statement to retrieve the specified
                        field data will be automatically generated and
                        returned. Alternatively, use --fields-file option when
                        the number of fields to be retrieved is large.
  --fields-file FIELDS_FILE
                        A file with no header and one entry per line where
                        every entry is the phenotypic entity name and field
                        name, separated by a dot. For example:
                        <entity_name>.<field_name>. If multiple entities are
                        provided, field values will be automatically inner
                        joined. If only the --fields-file argument is
                        provided, data will be retrieved and returned. If both
                        --fields-file and --sql arguments are provided, a SQL
                        statement to retrieve the specified field data will be
                        automatically generated and returned. May not be used
                        in conjunction with the argument --fields.
  --sql                 If provided, a SQL statement (string) will be returned
                        to query the set of entity.fields, instead of
                        returning stored values from the set of entity.fields
  --delim, --delimiter [DELIM]
                        Always use exactly one of DELIMITER to separate fields
                        to be printed; if no delimiter is provided with this
                        flag, COMMA will be used
  -o, --output OUTPUT   Local filename or directory to be used ("-" indicates
                        stdout output). If not supplied, output will create a
                        file with a default name in the current folder
  --list-fields         List the names and titles of all fields available in
                        the dataset specified. When not specified together
                        with "–-entities", it will return all the fields from
                        the main entity. Output will be a two column table,
                        field names and field titles, separated by a tab,
                        where field names will be of the format, "<entity
                        name>.<field name>" and field titles will be of the
                        format, "<field title>".
  --list-entities       List the names and titles of all the entities
                        available in the dataset specified. Output will be a
                        two column table, entity names and entity titles,
                        separated by a tab.
  --entities ENTITIES   Similar output to "--list-fields", however using "--
                        entities" will allow for specific entities to be
                        specified. When multiple entities are specified, use
                        comma as the delimiter. For example: "--list-fields
                        --entities entityA,entityB,entityC"

Environment override options (dx <command> --env-help):
  --apiserver-host APISERVER_HOST
                        API server host
  --apiserver-port APISERVER_PORT
                        API server port
  --apiserver-protocol APISERVER_PROTOCOL
                        API server protocol (http or https)
  --project-context-id PROJECT_CONTEXT_ID
                        Default project or project context ID
  --workspace-id WORKSPACE_ID
                        Workspace ID (for jobs only)
  --security-context SECURITY_CONTEXT
                        JSON string of security context
  --auth-token AUTH_TOKEN
                        Authentication token
```

## dxpy_dx_make_download_url

### Tool Description
Creates a pre-authenticated link that can be used to download a file without logging in.

### Metadata
- **Docker Image**: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
- **Homepage**: https://github.com/dnanexus/dx-toolkit
- **Package**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dxpy/overview
- **Total Downloads**: 850.9K
- **Last updated**: 2025-11-06
- **GitHub**: https://github.com/dnanexus/dx-toolkit
- **Stars**: N/A
### Original Help Text
```text
usage: dx make_download_url [-h] [--duration DURATION] [--filename FILENAME]
                            path

Creates a pre-authenticated link that can be used to download a file without
logging in.

positional arguments:
  path                 Project-qualified data object ID or name, e.g. project-
                       xxxx:file-yyyy, or project-xxxx:/path/to/file.txt

options:
  -h, --help           show this help message and exit
  --duration DURATION  Time for which the URL will remain valid (in seconds,
                       or use suffix s, m, h, d, w, M, y). Default: 1 day
  --filename FILENAME  Name that the server will instruct the client to save
                       the file as (default is the filename)

Environment override options (dx <command> --env-help):
  --apiserver-host APISERVER_HOST
                        API server host
  --apiserver-port APISERVER_PORT
                        API server port
  --apiserver-protocol APISERVER_PROTOCOL
                        API server protocol (http or https)
  --project-context-id PROJECT_CONTEXT_ID
                        Default project or project context ID
  --workspace-id WORKSPACE_ID
                        Workspace ID (for jobs only)
  --security-context SECURITY_CONTEXT
                        JSON string of security context
  --auth-token AUTH_TOKEN
                        Authentication token
```
