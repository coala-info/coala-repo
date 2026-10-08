# varfish-cli CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| varfish-cli_cases_case-list | Not completed | needs a VarFish server and account |
| varfish-cli_cases_case-retrieve | Not completed | needs a VarFish server and account |
| varfish-cli_importer_caseimportinfo-create | Not completed | needs a VarFish server and account |
| varfish-cli_importer_caseimportinfo-list | Not completed | needs a VarFish server and account |
| varfish-cli_projects_project-list | Not completed | needs a VarFish server and account |
| varfish-cli_projects_project-retrieve | Not completed | needs a VarFish server and account |
| varfish-cli_tools_dragen-to-bam-qc | PASS |  |
| varfish-cli_varannos_varannoset-create | Not completed | needs a VarFish server and account |
| varfish-cli_varannos_varannoset-delete | Not completed | needs a VarFish server and account |
| varfish-cli_varannos_varannoset-list | Not completed | needs a VarFish server and account |
| varfish-cli_varannos_varannoset-retrieve | Not completed | needs a VarFish server and account |
| varfish-cli_varannos_varannoset-update | Not completed | needs a VarFish server and account |
| varfish-cli_varannos_varannosetentry-create | Not completed | needs a VarFish server and account |
| varfish-cli_varannos_varannosetentry-delete | Not completed | needs a VarFish server and account |
| varfish-cli_varannos_varannosetentry-list | Not completed | needs a VarFish server and account |
| varfish-cli_varannos_varannosetentry-retrieve | Not completed | needs a VarFish server and account |
| varfish-cli_varannos_varannosetentry-update | Not completed | needs a VarFish server and account |

## varfish-cli_cases_case-list

### Tool Description
List all Case entries for the project.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli cases case-list [OPTIONS] PROJECT_UUID                                                    
 List all Case entries for the                                                                                
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    project_uuid      UUID  UUID of project to list cases for [default: None] [required]                  │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --output-file             TEXT              Path to file to write to [default: -]                          │
│ --output-format           [table|csv|json]  Output format [default: table]                                 │
│ --output-delimiter        TEXT              Delimiter for CSV output [default: ,]                          │
│ --output-fields           TEXT              Output fields [default: None]                                  │
│ --help                                      Show this message and exit.                                    │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_cases_case-retrieve

### Tool Description
Retrieve Case by UUID.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli cases case-retrieve [OPTIONS] OBJECT_UUID                                                 
 Retrieve Case by UUID                                                                                        
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    object_uuid      UUID  UUID of the object to retrieve [default: None] [required]                      │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --output-file        TEXT  Path to file to write to [default: -]                                           │
│ --help                     Show this message and exit.                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_importer_caseimportinfo-create

### Tool Description
Create case import info and upload the files.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli importer caseimportinfo-create [OPTIONS] PROJECT_UUID                                     
                                                   [PATHS]...                                                 
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    project_uuid      UUID        UUID of project to list cases for [default: None] [required]            │
│      paths             [PATHS]...  Path(s) to files to use for the import. Must include PED, and           │
│                                    annotation TSV files                                                    │
│                                    [default: None]                                                         │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --strip-family-regex                        TEXT             Regular expression to process family name     │
│                                                              with                                          │
│                                                              [default: ^FAM_]                              │
│ --case-name-suffix                          TEXT             Suffix to append to case name                 │
│ --force-fresh           --no-force-fresh                     Force using fresh case import even if old     │
│                                                              draft found                                   │
│                                                              [default: no-force-fresh]                     │
│ --resubmit              --no-resubmit                        Force resubmission of cases in submit state   │
│                                                              [default: no-resubmit]                        │
│ --genomebuild                               [GRCh37|GRCh38]  The genome build (GRCh37/GRCh38) of this      │
│                                                              case, defaults to GRCh37.                     │
│                                                              [default: GRCh37]                             │
│ --index                                     TEXT             Name of the index case in the pedigree,       │
│                                                              defaults to the first affected member of the  │
│                                                              pedigree file.                                │
│                                                              [default: None]                               │
│ --help                                                       Show this message and exit.                   │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_importer_caseimportinfo-list

### Tool Description
List case import infos.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli importer caseimportinfo-list [OPTIONS] PROJECT_UUID                                       
 List case import infos.                                                                                      
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    project_uuid      UUID  UUID of project to list cases for [default: None] [required]                  │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --owner              TEXT  Optionally, name of owner to filter for [default: None]                         │
│ --output-file        TEXT  Path to file to write to [default: -]                                           │
│ --help                     Show this message and exit.                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_projects_project-list

### Tool Description
List all projects.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli projects project-list [OPTIONS]                                                           
 List all projects                                                                                            
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --output-file             TEXT              Path to file to write to [default: -]                          │
│ --output-format           [table|csv|json]  Output format [default: table]                                 │
│ --output-delimiter        TEXT              Delimiter for CSV output [default: ,]                          │
│ --output-fields           TEXT              Output fields [default: None]                                  │
│ --help                                      Show this message and exit.                                    │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_projects_project-retrieve

### Tool Description
Retrieve project by UUID.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli projects project-retrieve [OPTIONS] OBJECT_UUID                                           
 Retrieve project by UUID                                                                                     
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    object_uuid      UUID  UUID of the object to retrieve [default: None] [required]                      │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --output-file        TEXT  Path to file to write to [default: -]                                           │
│ --help                     Show this message and exit.                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_tools_dragen-to-bam-qc

### Tool Description
Convert DRAGEN QC files to legacy 'bam-qc' format.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli tools dragen-to-bam-qc [OPTIONS] OUTPUT_FILE INPUT_FILES...                               
 Convert DRAGEN QC files to legacy 'bam-qc' format.                                                           
 :param ctx: Typer Context :param output_file: Path to output file :param input_files: List of input files    
 :raise typer.Exit: If input files are not found                                                              
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    output_file      TEXT            Path to 'legacy' varfish BAM QC [default: None] [required]           │
│ *    input_files      INPUT_FILES...  Path to DRAGEN QC files (*.ped, *.qc-coverage*.csv and               │
│                                       *.mapping_metrics.csv)                                               │
│                                       [default: None]                                                      │
│                                       [required]                                                           │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                                                │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_varannos_varannoset-create

### Tool Description
Create new Varannoset.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli varannos varannoset-create [OPTIONS] PROJECT_UUID                                         
                                               [PAYLOAD_OR_PATH]                                              
 Create new Varannoset                                                                                        
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    project_uuid         UUID               UUID of the project to create it in [default: None]           │
│                                              [required]                                                    │
│      payload_or_path      [PAYLOAD_OR_PATH]  JSON with payload to use or @path with JSON [default: -]      │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --output-file        TEXT  Path to file to write to [default: -]                                           │
│ --help                     Show this message and exit.                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_varannos_varannoset-delete

### Tool Description
Delete a Varannoset.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli varannos varannoset-delete [OPTIONS] OBJECT_UUID                                          
 Create new Varannoset                                                                                        
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    object_uuid      UUID  UUID of the varannoset to delete [default: None] [required]                    │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                                                │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_varannos_varannoset-list

### Tool Description
List all Varannoset entries for the project.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli varannos varannoset-list [OPTIONS] PROJECT_UUID                                           
 List all Varannoset entries for the                                                                          
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    project_uuid      UUID  UUID of project to list varannosets for [default: None] [required]            │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --output-file             TEXT              Path to file to write to [default: -]                          │
│ --output-format           [table|csv|json]  Output format [default: table]                                 │
│ --output-delimiter        TEXT              Delimiter for CSV output [default: ,]                          │
│ --output-fields           TEXT              Output fields [default: None]                                  │
│ --help                                      Show this message and exit.                                    │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_varannos_varannoset-retrieve

### Tool Description
Retrieve Varannoset by UUID.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli varannos varannoset-retrieve [OPTIONS] OBJECT_UUID                                        
 Retrieve Varannoset by UUID                                                                                  
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    object_uuid      UUID  UUID of the object to retrieve [default: None] [required]                      │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --output-file        TEXT  Path to file to write to [default: -]                                           │
│ --help                     Show this message and exit.                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_varannos_varannoset-update

### Tool Description
Update a Varannoset.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli varannos varannoset-update [OPTIONS] OBJECT_UUID                                          
                                               [PAYLOAD_OR_PATH]                                              
 Create new Varannoset                                                                                        
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    object_uuid          UUID               UUID of the varannoset to update [default: None] [required]   │
│      payload_or_path      [PAYLOAD_OR_PATH]  JSON with payload to use or @path with JSON [default: -]      │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --output-file        TEXT  Path to file to write to [default: -]                                           │
│ --help                     Show this message and exit.                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_varannos_varannosetentry-create

### Tool Description
Create new Varannosetentry.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli varannos varannosetentry-create [OPTIONS] VARANNOSET_UUID                                 
                                                    [PAYLOAD_OR_PATH]                                         
 Create new Varannoset                                                                                        
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    varannoset_uuid      UUID               UUID of the Varannoset to create it in [default: None]        │
│                                              [required]                                                    │
│      payload_or_path      [PAYLOAD_OR_PATH]  JSON with payload to use or @path with JSON [default: -]      │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --output-file        TEXT  Path to file to write to [default: -]                                           │
│ --help                     Show this message and exit.                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_varannos_varannosetentry-delete

### Tool Description
Delete a Varannosetentry.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli varannos varannosetentry-delete [OPTIONS] OBJECT_UUID                                     
 Create new varannosetentry                                                                                   
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    object_uuid      UUID  UUID of the varannosetentry to delete [default: None] [required]               │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                                                │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_varannos_varannosetentry-list

### Tool Description
List all Varannoset entries for the varannoset.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli varannos varannosetentry-list [OPTIONS] VARANNOSET_UUID                                   
 List all Varannoset entries for the                                                                          
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    varannoset_uuid      UUID  UUID of varannoset to list entries for [default: None] [required]          │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --output-file             TEXT              Path to file to write to [default: -]                          │
│ --output-format           [table|csv|json]  Output format [default: table]                                 │
│ --output-delimiter        TEXT              Delimiter for CSV output [default: ,]                          │
│ --output-fields           TEXT              Output fields [default: None]                                  │
│ --help                                      Show this message and exit.                                    │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_varannos_varannosetentry-retrieve

### Tool Description
Retrieve VarannosetEntry by UUID.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli varannos varannosetentry-retrieve [OPTIONS] OBJECT_UUID                                   
 Retrieve VarannosetEntry by UUID                                                                             
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    object_uuid      UUID  UUID of the object to retrieve [default: None] [required]                      │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --output-file        TEXT  Path to file to write to [default: -]                                           │
│ --help                     Show this message and exit.                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## varfish-cli_varannos_varannosetentry-update

### Tool Description
Update a Varannosetentry.

### Metadata
- **Docker Image**: quay.io/biocontainers/varfish-cli:0.7.0--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/varfish-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/varfish-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: varfish-cli [OPTIONS] COMMAND [ARGS]...                                                               
 Callback for main entry point                                                                                
 This function handles the global configuration from configuration file, environment variables, and command   
 line (in increasing priority).                                                                               
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --version                                                                                                  │
│ --verbose             -v                           Enable verbose output                                   │
│ --verify-ssl              --no-verify-ssl          Disable SSL verification [default: verify-ssl]          │
│ --config-path                                TEXT  Path to configuration file   [env var: VARFISH_RC_PATH] │
│                                                    [default: ~/.varfishrc.toml]                            │
│ --varfish-server-url                         TEXT  VarFish server URL key to use, defaults to env          │
│                                                    VARFISH_SERVER_URL or read from configfile              │
│                                                    [env var: VARFISH_SERVER_URL]                           │
│                                                    [default: None]                                         │
│ --varfish-server-url                         TEXT  VarFish API token to use, defaults to env               │
│                                                    VARFISH_API_TOKEN or read from configfile               │
│                                                    [env var: VARFISH_API_TOKEN]                            │
│                                                    [default: None]                                         │
│ --install-completion                               Install completion for the current shell.               │
│ --show-completion                                  Show completion for the current shell, to copy it or    │
│                                                    customize the installation.                             │
│ --help                                             Show this message and exit.                             │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Commands ─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ version    Print version as "varfish-cli $version".                                                        │
│ varannos   Subcommands for 'varannos' API                                                                  │
│ projects   Subcommands for 'project' API                                                                   │
│ cases      Subcommands for 'cases' API                                                                     │
│ importer   Subcommands for 'importer' API                                                                  │
│ tools      Subcommands for 'tools' API                                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
 Usage: varfish-cli varannos varannosetentry-update [OPTIONS] OBJECT_UUID                                     
                                                    [PAYLOAD_OR_PATH]                                         
 Create new Varannoset                                                                                        
╭─ Arguments ────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    object_uuid          UUID               UUID of the varannosetentry to update [default: None]         │
│                                              [required]                                                    │
│      payload_or_path      [PAYLOAD_OR_PATH]  JSON with payload to use or @path with JSON [default: -]      │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --output-file        TEXT  Path to file to write to [default: -]                                           │
│ --help                     Show this message and exit.                                                     │
╰────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## Metadata
- **Skill**: generated
