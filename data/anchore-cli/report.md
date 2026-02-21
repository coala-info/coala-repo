# anchore-cli CWL Generation Report

## anchore-cli_account

### Tool Description
Account management operations for Anchore CLI, including adding, deleting, and managing account status and users.

### Metadata
- **Docker Image**: biocontainers/anchore-cli:latest
- **Homepage**: https://github.com/anchore/anchore-cli
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/anchore-cli/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/anchore/anchore-cli
- **Stars**: N/A
### Original Help Text
```text
Usage: anchore-cli account [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  add      Add a new account (with no populated users by default)
  del      Delete an account (must be disabled first)
  disable  Disable an enabled account
  enable   Enable a disabled account
  get      Get account information
  list     List information about all accounts (admin only)
  user     Account user operations
  whoami   Get current account/user information
```


## anchore-cli_analysis-archive

### Tool Description
Manage the analysis archive in Anchore Engine, allowing for archiving and restoring image analysis data.

### Metadata
- **Docker Image**: biocontainers/anchore-cli:latest
- **Homepage**: https://github.com/anchore/anchore-cli
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: anchore-cli analysis-archive [OPTIONS] COMMAND [ARGS]...
Try "anchore-cli analysis-archive --help" for help.

Error: no such option: --h  Did you mean --help?
```


## anchore-cli_evaluate

### Tool Description
Evaluate images against policies using anchore-cli

### Metadata
- **Docker Image**: biocontainers/anchore-cli:latest
- **Homepage**: https://github.com/anchore/anchore-cli
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: anchore-cli evaluate [OPTIONS] COMMAND [ARGS]...
Try "anchore-cli evaluate --help" for help.

Error: no such option: --h  Did you mean --help?
```


## anchore-cli_event

### Tool Description
Anchore CLI event management commands

### Metadata
- **Docker Image**: biocontainers/anchore-cli:latest
- **Homepage**: https://github.com/anchore/anchore-cli
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: anchore-cli event [OPTIONS] COMMAND [ARGS]...
Try "anchore-cli event --help" for help.

Error: no such option: --h  Did you mean --help?
```


## anchore-cli_image

### Tool Description
Manage images within Anchore CLI, including adding, analyzing, and retrieving vulnerability data.

### Metadata
- **Docker Image**: biocontainers/anchore-cli:latest
- **Homepage**: https://github.com/anchore/anchore-cli
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: anchore-cli image [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  add       Add an image
  content   Get contents of image
  del       Delete an image
  get       Get an image
  import    Import an image from anchore scanner export
  list      List all images
  metadata  Get metadata about an image
  vuln      Get image vulnerabilities
  wait      Wait for an image to analyze
```


## anchore-cli_policy

### Tool Description
Manage and interact with Anchore policies

### Metadata
- **Docker Image**: biocontainers/anchore-cli:latest
- **Homepage**: https://github.com/anchore/anchore-cli
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: anchore-cli policy [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  activate  Activate a policyid
  add       Add a policy bundle
  del       Delete a policy bundle
  describe  Describes the policy gates and triggers available
  get       Get a policy bundle
  hub       Anchore Hub Operations
  list      List all policies
```


## anchore-cli_query

### Tool Description
Query system for images based on packages or vulnerabilities

### Metadata
- **Docker Image**: biocontainers/anchore-cli:latest
- **Homepage**: https://github.com/anchore/anchore-cli
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: anchore-cli query [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  images-by-package        Search system for images with the given package
                           installed
  images-by-vulnerability  Search system for images with the given
                           vulnerability ID present
```


## anchore-cli_registry

### Tool Description
Registry management commands for anchore-cli

### Metadata
- **Docker Image**: biocontainers/anchore-cli:latest
- **Homepage**: https://github.com/anchore/anchore-cli
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: anchore-cli registry [OPTIONS] COMMAND [ARGS]...
Try "anchore-cli registry --help" for help.

Error: no such option: --h  Did you mean --help?
```


## anchore-cli_repo

### Tool Description
Manage repositories in Anchore Engine, including adding, deleting, listing, and controlling watch status.

### Metadata
- **Docker Image**: biocontainers/anchore-cli:latest
- **Homepage**: https://github.com/anchore/anchore-cli
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: anchore-cli repo [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  add      Add a repository
  del      Delete a repository from the watch list (does not delete already
           analyzed images)
  get      Get a repository
  list     List added repositories
  unwatch  Instruct engine to stop automatically watching the repo for image
           updates
  watch    Instruct engine to start automatically watching the repo for image
           updates
```


## anchore-cli_subscription

### Tool Description
Manage subscriptions for image analysis and policy updates in Anchore Engine.

### Metadata
- **Docker Image**: biocontainers/anchore-cli:latest
- **Homepage**: https://github.com/anchore/anchore-cli
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: anchore-cli subscription [OPTIONS] COMMAND [ARGS]...
Try "anchore-cli subscription --help" for help.

Error: no such option: --h  Did you mean --help?
```


## anchore-cli_system

### Tool Description
Anchore engine system operations including status checks, feed management, and service deletion.

### Metadata
- **Docker Image**: biocontainers/anchore-cli:latest
- **Homepage**: https://github.com/anchore/anchore-cli
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: anchore-cli system [OPTIONS] COMMAND [ARGS]...

Options:
  --help  Show this message and exit.

Commands:
  del         Delete a non-active service from anchore-engine
  errorcodes  Describe available anchore system error code names and
              descriptions
  feeds       Feed data operations
  status      Check current anchore-engine system status
  wait        Blocking operation that will return when anchore-engine is
              available and ready
```


## Metadata
- **Skill**: generated
