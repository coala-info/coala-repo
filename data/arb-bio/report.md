# arb-bio CWL Generation Report

## arb-bio

### Tool Description
The provided text does not contain help information or a description of the tool; it appears to be a log of a failed execution or build process.

### Metadata
- **Docker Image**: quay.io/biocontainers/arb-bio:6.0.6--0
- **Homepage**: http://www.arb-home.de
- **Package**: https://anaconda.org/channels/bioconda/packages/arb-bio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/arb-bio/overview
- **Total Downloads**: 12.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/06 21:04:51  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "arb-bio": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## arb-bio_arb

### Tool Description
Main ARB database and phylogeny tool for starting ARB, merging databases, or importing files.

### Metadata
- **Docker Image**: quay.io/biocontainers/arb-bio:6.0.6--0
- **Homepage**: http://www.arb-home.de
- **Package**: https://anaconda.org/channels/bioconda/packages/arb-bio/overview
- **Validation**: PASS
### Original Help Text
```text
Using ARBHOME='/usr/local/lib/arb'
Using properties from /user/qianghu/.arb_prop
Please wait while the program ARB is starting .....
Waiting for '/user/qianghu/.arb_tmp/sockets/arb_launcher.483368'..
[arb_launcher[0]: Starting 'arb_ntree -help'..]

arb_ntree version arb-6.0.6.rev15220
(C) 1993-2017 Lehrstuhl fuer Mikrobiologie - TU Muenchen
http://www.arb-home.de/
(version build by: root@testing-gce-2bfab580-2a1b-44ad-8da4-dcc4b75d4b18.somewhere)

Possible usage:
  arb_ntree               => start ARB (intro)
  arb_ntree DB            => start ARB with DB
  arb_ntree DB1 DB2       => merge from DB1 into DB2
  arb_ntree --import FILE => import FILE into new database (FILE may be a filemask)

Additional arguments possible with command lines above:
  --execute macroname     => execute macro 'macroname' after startup

Each DB argument may be one of the following:
  database.arb            -> use existing or new database
  ":"                     -> connect to database of a running instance of ARB
  directory               -> prompt for databases inside directory
  filemask                -> also prompt for DB, but more specific (e.g. "prot*.arb")

[arb_launcher[0]: 'arb_ntree -help' has terminated with success]
[arb_launcher[0]: Still have 1 arb processes..]
[arb_launcher[0]: All launched processes terminated]

Session log has been stored in /user/qianghu/.arb_prop/logs/session.20260206_210626.483404.tgz
    and is also accessible via /user/qianghu/ARB_last_session.tgz
```

## arb-bio_arb_edit4

### Tool Description
Edit ARB database or connect to arb-database-server

### Metadata
- **Docker Image**: quay.io/biocontainers/arb-bio:6.0.6--0
- **Homepage**: http://www.arb-home.de
- **Package**: https://anaconda.org/channels/bioconda/packages/arb-bio/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
Usage: arb_edit4 [options] database
       database    name of database or ':' to connect to arb-database-server

       options:
       -c config   loads configuration 'config' (default: 'default_configuration')
```

