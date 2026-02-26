# snk CWL Generation Report

## snk_install

### Tool Description
Install a workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/snk:0.31.1--pyhdfd78af_0
- **Homepage**: https://snk.wytamma.com
- **Package**: https://anaconda.org/channels/bioconda/packages/snk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snk/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wytamma/snk
- **Stars**: N/A
### Original Help Text
```text
Usage: snk install [OPTIONS] WORKFLOW                                          
                                                                                
 Install a workflow.                                                            
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    workflow      TEXT  Path, URL or Github name (user/repo) of the         │
│                          workflow to install.                                │
│                          [default: None]                                     │
│                          [required]                                          │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --name        -n      TEXT  Rename the workflow (this name will be used to   │
│                             call the CLI.)                                   │
│                             [default: None]                                  │
│ --tag         -t      TEXT  Tag (version) of the workflow to install. Can    │
│                             specify a branch name, or tag. If None the       │
│                             latest commit will be installed.                 │
│                             [default: None]                                  │
│ --commit      -c      TEXT  Commit (SHA) of the workflow to install. If None │
│                             the latest commit will be installed.             │
│                             [default: None]                                  │
│ --isolate     -i            Install the workflow in a isolated environment.  │
│ --snakemake   -s      TEXT  Snakemake version to install with the isolated   │
│                             workflow. Default is the latest version.         │
│                             [default: None]                                  │
│ --dependency  -d      TEXT  Additional pip dependencies to install with the  │
│                             workflow.                                        │
│ --config              PATH  Specify a non-standard config location.          │
│                             [default: None]                                  │
│ --snakefile           PATH  Specify a non-standard Snakefile location.       │
│                             [default: None]                                  │
│ --resource            PATH  Specify resources additional to the resources    │
│                             folder required by the workflow (copied to       │
│                             working dir at runtime).                         │
│ --no-conda                  Do not use conda environments by default.        │
│ --force       -f            Force install (overwrites existing installs).    │
│ --editable    -e            Whether to install the workflow in editable      │
│                             mode.                                            │
│ --help        -h            Show this message and exit.                      │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## snk_uninstall

### Tool Description
Uninstall a workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/snk:0.31.1--pyhdfd78af_0
- **Homepage**: https://snk.wytamma.com
- **Package**: https://anaconda.org/channels/bioconda/packages/snk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snk uninstall [OPTIONS] NAME                                            
                                                                                
 Uninstall a workflow.                                                          
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    name      TEXT  Name of the workflow to uninstall. [default: None]      │
│                      [required]                                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --force  -f        Force uninstall without asking.                           │
│ --help   -h        Show this message and exit.                               │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## snk_list

### Tool Description
List the installed workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/snk:0.31.1--pyhdfd78af_0
- **Homepage**: https://snk.wytamma.com
- **Package**: https://anaconda.org/channels/bioconda/packages/snk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snk list [OPTIONS]                                                      
                                                                                
 List the installed workflows.                                                  
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --verbose  -v        Show the workflow paths.                                │
│ --help     -h        Show this message and exit.                             │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## snk_create

### Tool Description
Create a default snk.yaml project that can be installed with snk

### Metadata
- **Docker Image**: quay.io/biocontainers/snk:0.31.1--pyhdfd78af_0
- **Homepage**: https://snk.wytamma.com
- **Package**: https://anaconda.org/channels/bioconda/packages/snk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snk create [OPTIONS] PATH                                               
                                                                                
 Create a default snk.yaml project that can be installed with snk               
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    path      PATH  [default: None] [required]                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --force  -f                                                                  │
│ --help   -h        Show this message and exit.                               │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## snk_edit

### Tool Description
Access the snk.yaml configuration file for a workflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/snk:0.31.1--pyhdfd78af_0
- **Homepage**: https://snk.wytamma.com
- **Package**: https://anaconda.org/channels/bioconda/packages/snk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snk edit [OPTIONS] WORKFLOW_NAME                                        
                                                                                
 Access the snk.yaml configuration file for a workflow.                         
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    workflow_name      TEXT  Name of the workflow to configure.             │
│                               [default: None]                                │
│                               [required]                                     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --path  -p        Show the path to the snk.yaml file.                        │
│ --help  -h        Show this message and exit.                                │
╰──────────────────────────────────────────────────────────────────────────────╯
```

