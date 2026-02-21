# biomaj CWL Generation Report

## biomaj

### Tool Description
BioMAJ (Biological Management of Application for Jussieu) is a workflow engine dedicated to data management and synchronization.

### Metadata
- **Docker Image**: quay.io/biocontainers/biomaj:3.0.19--py35_0
- **Homepage**: https://github.com/genouest/biomaj
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/biomaj/overview
- **Total Downloads**: 8.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/genouest/biomaj
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/06 22:56:56  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "biomaj": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## biomaj_biomaj-cli.py

### Tool Description
BioMAJ command line interface for bank management, updates, and maintenance.

### Metadata
- **Docker Image**: quay.io/biocontainers/biomaj:3.0.19--py35_0
- **Homepage**: https://github.com/genouest/biomaj
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
--config: global.properties file path

    --status: list of banks with published release
        [OPTIONAL]
        --bank xx / bank: Get status details of bank

    --status-ko: list of banks in error status (last run)

    --log DEBUG|INFO|WARN|ERR  [OPTIONAL]: set log level in logs for this run, default is set in global.properties file

    --check: Check bank property file
        [MANDATORY]
        --bank xx: name of the bank to check (will check xx.properties)

    --owner yy: Change owner of the bank (user id)
        [MANDATORY]
        --bank xx: name of the bank

    --visibility public|private: change visibility public/private of a bank
        [MANDATORY]
        --bank xx: name of the bank

    --change-dbname yy: Change name of the bank to this new name
        [MANDATORY]
        --bank xx: current name of the bank

    --move-production-directories yy: Change bank production directories location to this new path, path must exists
        [MANDATORY]
        --bank xx: current name of the bank

    --update: Update bank
        [MANDATORY]
        --bank xx: name of the bank(s) to update, comma separated
        [OPTIONAL]
        --publish: after update set as *current* version
        --from-scratch: force a new update cycle, even if release is identical, release will be incremented like (myrel_1)
        --stop-before xx: stop update cycle before the start of step xx
        --stop-after xx: stop update cycle after step xx has completed
        --from-task xx --release yy: Force an re-update cycle for bank release *yy* or from current cycle (in production directories), skipping steps up to *xx*
        --process xx: linked to from-task, optionally specify a block, meta or process name to start from
        --release xx: release to update

    --publish: Publish bank as current release to use
        [MANDATORY]
        --bank xx: name of the bank to update
        --release xx: release of the bank to publish
    --unpublish: Unpublish bank (remove current)
        [MANDATORY]
        --bank xx: name of the bank to update

    --remove-all: Remove all bank releases and database records
        [MANDATORY]
        --bank xx: name of the bank to update
        [OPTIONAL]
        --force: remove freezed releases

    --remove-pending: Remove pending releases
        [MANDATORY]
        --bank xx: name of the bank to update

    --remove: Remove bank release (files and database release)
        [MANDATORY]
        --bank xx: name of the bank to update
        --release xx: release of the bank to remove

        Release must not be the *current* version. If this is the case, publish a new release before.

    --freeze: Freeze bank release (cannot be removed)
        [MANDATORY]
        --bank xx: name of the bank to update
        --release xx: release of the bank to remove

    --unfreeze: Unfreeze bank release (can be removed)
        [MANDATORY]
        --bank xx: name of the bank to update
        --release xx: release of the bank to remove

    --search: basic search in bank production releases, return list of banks
       --formats xx,yy : list of comma separated format
      AND/OR
       --types xx,yy : list of comma separated type

       --query "LUCENE query syntax": search in index (if activated)

    --show: Show bank files per format
      [MANDATORY]
      --bank xx: name of the bank to show
      [OPTIONAL]
      --release xx: release of the bank to show

    --maintenance on/off/status: (un)set biomaj in maintenance mode to prevent updates/removal
```

