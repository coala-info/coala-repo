# aspera-cli CWL Generation Report

## aspera-cli_ascli

### Tool Description
Use Aspera application to perform operations on command line.

### Metadata
- **Docker Image**: quay.io/biocontainers/aspera-cli:4.20.0--hdfd78af_0
- **Homepage**: https://github.com/IBM/aspera-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/aspera-cli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/aspera-cli/overview
- **Total Downloads**: 7.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/IBM/aspera-cli
- **Stars**: N/A
### Original Help Text
```text
W, [2026-02-24T23:44:22.803852 #1]  WARN -- : No config file found. New configuration file: /root/.aspera/ascli/config.yaml
NAME
        ascli -- a command line tool for Aspera Applications (v4.20.0)

SYNOPSIS
        ascli COMMANDS [OPTIONS] [ARGS]

DESCRIPTION
        Use Aspera application to perform operations on command line.
        Documentation and examples: https://rubygems.org/gems/aspera-cli
        execute: ascli conf doc
        or visit: https://www.rubydoc.info/gems/aspera-cli
        source repo: https://github.com/IBM/aspera-cli

ENVIRONMENT VARIABLES
        Any option can be set as an environment variable, refer to the manual

COMMANDS
        To list first level commands, execute: ascli
        Note that commands can be written shortened (provided it is unique).

OPTIONS
        Options begin with a '-' (minus), and value is provided on command line.
        Special values are supported beginning with special prefix @pfx:, where pfx is one of:
        val, base64, csvt, env, file, uri, json, lines, list, none, path, re, ruby, secret, stdin, stdbin, yaml, zlib, extend, preset, vault
        Dates format is 'DD-MM-YY HH:MM:SS', or 'now' or '-<num>h'

ARGS
        Some commands require mandatory arguments, e.g. a path.

OPTIONS: global
        --interactive=ENUM           Use interactive input of missing params: [no], yes
        --ask-options=ENUM           Ask even optional options: [no], yes
        --struct-parser=ENUM         Default parser when expected value is a struct: json, ruby
        --format=ENUM                Output format: text, nagios, ruby, json, jsonpp, yaml, [table], csv, image
        --output=VALUE               Destination for results (String)
        --display=ENUM               Output only some information: [info], data, error
        --fields=VALUE               Comma separated list of: fields, or ALL, or DEF (String, Array, Regexp, Proc)
        --select=VALUE               Select only some items in lists: column, value (Hash, Proc)
        --table-style=VALUE          Table display style (Hash)
        --flat-hash=ENUM             (Table) Display deep values as additional keys: no, [yes]
        --transpose-single=ENUM      (Table) Single object fields output vertically: no, [yes]
        --multi-table=ENUM           (Table) Each element of a table are displayed as a table: [no], yes
        --show-secrets=ENUM          Show secrets on command output: [no], yes
        --image=VALUE                Options for image display (Hash)
    -h, --help                       Show this message
        --bash-comp                  Generate bash completion for command
        --show-config                Display parameters used for the provided action
    -v, --version                    Display version
        --ui=ENUM                    Method to start browser: [text], graphical
        --log-level=ENUM             Log level: trace2, trace1, debug, info, [warn], error, fatal, unknown
        --logger=ENUM                Logging method: [stderr], stdout, syslog
        --lock-port=VALUE            Prevent dual execution of a command, e.g. in cron (Integer)
        --once-only=ENUM             Process only new items (some commands): [no], yes
        --log-secrets=ENUM           Show passwords in logs: [no], yes
        --clean-temp=ENUM            Cleanup temporary files on exit: no, [yes]
        --pid-file=VALUE             Write process identifier to file, delete on exit (String)
        --home=VALUE                 Home folder for tool (String)
        --config-file=VALUE          Path to YAML file with preset configuration
        --secret=VALUE               Secret for access keys
        --vault=VALUE                Vault for secrets (Hash)
        --vault-password=VALUE       Vault password
        --query=VALUE                Additional filter for for some commands (list/delete) (Hash, Array)
        --property=VALUE             Name of property to set (modify operation)
        --bulk=ENUM                  Bulk operation (only some): [no], yes
        --bfail=ENUM                 Bulk operation error handling: no, [yes]
    -N, --no-default                 Do not load default configuration for plugin
    -P, --presetVALUE                Load the named option preset from current config file
        --version-check-days=VALUE   Period in days to check new version (zero to disable)
        --plugin-folder=VALUE        Folder where to find additional plugins
        --override=ENUM              Wizard: override existing value: [no], yes
        --default=ENUM               Wizard: set as default configuration for specified plugin (also: update): no, [yes]
        --test-mode=ENUM             Wizard: skip private key check step: [no], yes
        --key-path=VALUE             Wizard: path to private key for JWT
        --ascp-path=VALUE            Path to ascp
        --use-product=VALUE          Use ascp from specified product
        --sdk-url=VALUE              URL to get SDK
        --sdk-folder=VALUE           SDK folder path
        --progress-bar=ENUM          Display progress bar: [no], yes
        --smtp=VALUE                 SMTP configuration (Hash)
        --notify-to=VALUE            Email recipient for notification of transfers
        --notify-template=VALUE      Email ERB template for notification of transfers
        --insecure=ENUM              Do not validate any HTTPS certificate: [no], yes
        --ignore-certificate=VALUE   Do not validate HTTPS certificate for these URLs (Array)
        --silent-insecure=ENUM       Issue a warning if certificate is ignored: no, [yes]
        --cert-stores=VALUE          List of folder with trusted certificates (Array, String)
        --http-options=VALUE         Options for HTTP/S socket (Hash)
        --http-proxy=VALUE           URL for HTTP proxy with optional credentials (String)
        --cache-tokens=ENUM          Save and reuse OAuth tokens: no, [yes]
        --fpac=VALUE                 Proxy auto configuration script
        --proxy-credentials=VALUE    HTTP proxy credentials for fpac: user, password (Array)
        --ts=VALUE                   Override transfer spec values (Hash)
        --to-folder=VALUE            Destination folder for transferred files
        --sources=VALUE              How list of transferred files is provided (@args,@ts,Array)
        --src-type=ENUM              Type of file list: [list], pair
        --transfer=ENUM              Type of transfer agent: trsdk, alpha, httpgw, [direct], node, connect
        --transfer-info=VALUE        Parameters for transfer agent (Hash)

COMMAND: config
SUBCOMMANDS: ascp check_update coffee detect documentation echo email_test file flush_tokens folder gem genkey image initdemo open platform plugins preset proxy_check pubkey remote_certificate smtp_settings test vault wizard


COMMAND: preview
SUBCOMMANDS: check events scan show test trevents
OPTIONS:
        --url=VALUE                  URL of application, e.g. https://faspex.example.com/aspera/faspex
        --username=VALUE             User's name to log in
        --password=VALUE             User's password
        --skip-format=ENUM           Skip this preview format (multiple possible): png, mp4
        --folder-reset-cache=ENUM    Force detection of generated preview by refresh cache: [no], header, read
        --skip-types=VALUE           Skip types in comma separated list
        --previews-folder=VALUE      Preview folder in storage root
        --temp-folder=VALUE          Path to temp folder
        --skip-folders=VALUE         List of folder to skip
        --base=VALUE                 Basename of output for for test
        --scan-path=VALUE            Subpath in folder id to start scan in (default=/)
        --scan-id=VALUE              Folder id in storage to start scan in, default is access key main folder id
        --mimemagic=ENUM             Use Mime type detection of gem mimemagic: [no], yes
        --overwrite=ENUM             When to overwrite result file: always, never, [mtime]
        --file-access=ENUM           How to read and write files in repository: [local], remote
        --max-size=VALUE             Maximum size (in bytes) of preview file
        --thumb-vid-scale=VALUE      Png: video: size (ffmpeg scale argument)
        --thumb-vid-fraction=VALUE   Png: video: time percent position of snapshot
        --thumb-img-size=VALUE       Png: non-video: height (and width)
        --thumb-text-font=VALUE      Png: plaintext: font to render text with imagemagick convert (identify -list font)
        --video-conversion=ENUM      Mp4: method for preview generation: [reencode], blend, clips
        --video-png-conv=ENUM        Mp4: method for thumbnail generation: [fixed], animated
        --video-scale=VALUE          Mp4: all: video scale (ffmpeg)
        --video-start-sec=VALUE      Mp4: all: start offset (seconds) of video preview
        --reencode-ffmpeg=VALUE      Mp4: reencode: options to ffmpeg
        --blend-keyframes=VALUE      Mp4: blend: # key frames
        --blend-pauseframes=VALUE    Mp4: blend: # pause frames
        --blend-transframes=VALUE    Mp4: blend: # transition blend frames
        --blend-fps=VALUE            Mp4: blend: frame per second
        --clips-count=VALUE          Mp4: clips: number of clips
        --clips-length=VALUE         Mp4: clips: length in seconds of each clips


COMMAND: faspio
SUBCOMMANDS: bridges health
OPTIONS:
        --url=VALUE                  URL of application, e.g. https://faspex.example.com/aspera/faspex
        --username=VALUE             User's name to log in
        --password=VALUE             User's password
        --auth=ENUM                  OAuth type of authentication: jwt, basic
        --client-id=VALUE            OAuth client identifier
        --private-key=VALUE          OAuth JWT RSA private key PEM value (prefix file path with @file:)
        --passphrase=VALUE           OAuth JWT RSA private key passphrase


COMMAND: cos
SUBCOMMANDS: node
OPTIONS:
        --bucket=VALUE               Bucket name
        --endpoint=VALUE             Storage endpoint (URL)
        --apikey=VALUE               Storage API key
        --crn=VALUE                  Resource instance id (CRN)
        --service-credentials=VALUE  IBM Cloud service credentials (Hash)
        --region=VALUE               Storage region
        --identity=VALUE             Authentication URL (https://iam.cloud.ibm.com/identity)


COMMAND: faspex
SUBCOMMANDS: address_book dropbox health login_methods me package source v4
OPTIONS:
        --url=VALUE                  URL of application, e.g. https://faspex.example.com/aspera/faspex
        --username=VALUE             User's name to log in
        --password=VALUE             User's password
        --link=VALUE                 Public link for specific operation
        --delivery-info=VALUE        Package delivery information (Hash)
        --remote-source=VALUE        Remote source for package send (id or %name:)
        --storage=VALUE              Faspex local storage definition (for browsing source)
        --recipient=VALUE            Use if recipient is a dropbox (with *)
        --box=ENUM                   Package box: [inbox], archive, sent


COMMAND: console
SUBCOMMANDS: health transfer
OPTIONS:
        --url=VALUE                  URL of application, e.g. https://faspex.example.com/aspera/faspex
        --username=VALUE             User's name to log in
        --password=VALUE             User's password
        --filter-from=DATE           Only after date
        --filter-to=DATE             Only before date


COMMAND: server
SUBCOMMANDS: browse cp delete df download du health info ls md5sum mkdir mv rename rm sync upload
OPTIONS:
        --url=VALUE                  URL of application, e.g. https://faspex.example.com/aspera/faspex
        --username=VALUE             User's name to log in
        --password=VALUE             User's password
        --ssh-keys=VALUE             SSH key path list (Array or single)
        --passphrase=VALUE           SSH private key passphrase
        --ssh-options=VALUE          SSH options (Hash)
        --sync-info=VALUE            Information for sync instance and sessions (Hash)


COMMAND: alee
SUBCOMMANDS: entitlement health
OPTIONS:
        --url=VALUE                  URL of application, e.g. https://faspex.example.com/aspera/faspex
        --username=VALUE             User's name to log in
        --password=VALUE             User's password


COMMAND: orchestrator
SUBCOMMANDS: health info plugins processes workflow
OPTIONS:
        --url=VALUE                  URL of application, e.g. https://faspex.example.com/aspera/faspex
        --username=VALUE             User's name to log in
        --password=VALUE             User's password
        --result=VALUE               Specify result value as: 'work_step:parameter'
        --synchronous=ENUM           Wait for completion: [no], yes
        --ret-style=ENUM             How return type is requested in api: header, [arg], ext
        --auth-style=ENUM            Authentication type: arg_pass, [head_basic], apikey


COMMAND: shares
SUBCOMMANDS: admin files health
OPTIONS:
        --url=VALUE                  URL of application, e.g. https://faspex.example.com/aspera/faspex
        --username=VALUE             User's name to log in
        --password=VALUE             User's password


COMMAND: httpgw
SUBCOMMANDS: health info
OPTIONS:
        --url=VALUE                  URL of application, e.g. https://app.example.com/aspera/app


COMMAND: faspex5
SUBCOMMANDS: admin bearer_token gateway health invitations packages postprocessing shared_folders user version
OPTIONS:
        --url=VALUE                  URL of application, e.g. https://faspex.example.com/aspera/faspex
        --username=VALUE             User's name to log in
        --password=VALUE             User's password
        --client-id=VALUE            OAuth client identifier
        --client-secret=VALUE        OAuth client secret
        --redirect-uri=VALUE         OAuth redirect URI for web authentication
        --auth=ENUM                  OAuth type of authentication: web, [jwt], boot
        --private-key=VALUE          OAuth JWT RSA private key PEM value (prefix file path with @file:)
        --passphrase=VALUE           OAuth JWT RSA private key passphrase
        --box=VALUE                  Package inbox, either shared inbox name or one of: inbox, inbox_history, inbox_all, inbox_all_history, outbox, outbox_history, pending, pending_history, all or ALL
        --shared-folder=VALUE        Send package with files from shared folder
        --group-type=ENUM            Type of shared box: [shared_inboxes], workgroups


COMMAND: node
SUBCOMMANDS: access_keys api_details asperabrowser async basic_token bearer_token browse central delete download events health http_node_download info license mkdir mkfile mklink rename search service simulator slash space ssync stream sync transfer transport upload watch_folder
OPTIONS:
        --url=VALUE                  URL of application, e.g. https://faspex.example.com/aspera/faspex
        --username=VALUE             User's name to log in
        --password=VALUE             User's password
        --validator=VALUE            Identifier of validator (optional for central)
        --asperabrowserurl=VALUE     URL for simple aspera web ui
        --sync-name=VALUE            Sync name
        --default-ports=ENUM         Use standard FASP ports or get from node api (gen4): no, [yes]
        --node-cache=ENUM            Set to no to force actual file system read (gen4): no, [yes]
        --root-id=VALUE              File id of top folder when using access key (override AK root id)
        --sync-info=VALUE            Information for sync instance and sessions (Hash)


COMMAND: aoc
SUBCOMMANDS: admin automation bearer_token files gateway organization packages reminder servers tier_restrictions user
OPTIONS:
        --url=VALUE                  URL of application, e.g. https://faspex.example.com/aspera/faspex
        --username=VALUE             User's name to log in
        --password=VALUE             User's password
        --auth=ENUM                  OAuth type of authentication: web, [jwt]
        --client-id=VALUE            OAuth API client identifier
        --client-secret=VALUE        OAuth API client secret
        --scope=VALUE                OAuth scope for AoC API calls
        --redirect-uri=VALUE         OAuth API client redirect URI
        --private-key=VALUE          OAuth JWT RSA private key PEM value (prefix file path with @file:)
        --passphrase=VALUE           RSA private key passphrase (String)
        --workspace=VALUE            Name of workspace (String, NilClass)
        --new-user-option=VALUE      New user creation option for unknown package recipients (Hash)
        --validate-metadata=ENUM     Validate shared inbox metadata: no, [yes]


COMMAND: ats
SUBCOMMANDS: access_key api_key aws_trust_policy cluster
OPTIONS:
        --ibm-api-key=VALUE          IBM API key, see https://cloud.ibm.com/iam/apikeys
        --instance=VALUE             ATS instance in ibm cloud
        --ats-key=VALUE              ATS key identifier (ats_xxx)
        --ats-secret=VALUE           ATS key secret
        --params=VALUE               Parameters access key creation (@json:)
        --cloud=VALUE                Cloud provider
        --region=VALUE               Cloud region
```

