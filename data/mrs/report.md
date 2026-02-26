# mrs CWL Generation Report

## mrs_blast

### Tool Description
Perform BLAST search

### Metadata
- **Docker Image**: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
- **Homepage**: https://github.com/ctu-mrs/mrs_uav_system
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mrs/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/ctu-mrs/mrs_uav_system
- **Stars**: N/A
### Original Help Text
```text
mrs blast:
  -i [ --query ] arg        File containing query in FastA format
  -p [ --program ] arg      Blast program (only supported program is blastp for
                            now...)
  -d [ --databank ] arg     Databank(s) in FastA format, can be specified 
                            multiple times
  -o [ --output ] arg       Output file, default is stdout
  -b [ --report-limit ] arg Number of results to report
  -M [ --matrix ] arg       Matrix (default is BLOSUM62)
  -W [ --word-size ] arg    Word size (0 invokes default)
  -G [ --gap-open ] arg     Cost to open a gap (-1 invokes default)
  -E [ --gap-extend ] arg   Cost to extend a gap (-1 invokes default)
  --no-filter               Do not mask low complexity regions in the query 
                            sequence
  --ungapped                Do not search for gapped alignments, only ungapped
  -e [ --expect ] arg       Expectation value, default is 10.0
  -a [ --threads ] arg      Nr of threads
  -v [ --verbose ]          Be verbose
  -c [ --config ] arg       Configuration file
  -h [ --help ]             Display help message
```


## mrs_build

### Tool Description
Build a databank

### Metadata
- **Docker Image**: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
- **Homepage**: https://github.com/ctu-mrs/mrs_uav_system
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
mrs build:
  -d [ --databank ] arg Databank
  -c [ --config ] arg   Configuration file
  -v [ --verbose ]      Be verbose
  -a [ --threads ] arg  Nr of threads/pipelines
  -h [ --help ]         Display help message
```


## mrs_dump

### Tool Description
Dump mrs data

### Metadata
- **Docker Image**: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
- **Homepage**: https://github.com/ctu-mrs/mrs_uav_system
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
mrs dump:
  -i [ --index ] arg    Index to dump
  -d [ --databank ] arg Databank
  -c [ --config ] arg   Configuration file
  -v [ --verbose ]      Be verbose
  -a [ --threads ] arg  Nr of threads/pipelines
  -h [ --help ]         Display help message
```


## mrs_entry

### Tool Description
Display entry information

### Metadata
- **Docker Image**: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
- **Homepage**: https://github.com/ctu-mrs/mrs_uav_system
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
mrs entry:
  -e [ --entry ] arg    Entry ID to display
  -d [ --databank ] arg Databank
  -c [ --config ] arg   Configuration file
  -v [ --verbose ]      Be verbose
  -a [ --threads ] arg  Nr of threads/pipelines
  -h [ --help ]         Display help message
```


## mrs_fetch

### Tool Description
Fetch data from a databank.

### Metadata
- **Docker Image**: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
- **Homepage**: https://github.com/ctu-mrs/mrs_uav_system
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
mrs fetch:
  -d [ --databank ] arg Databank
  -c [ --config ] arg   Configuration file
  -v [ --verbose ]      Be verbose
  -a [ --threads ] arg  Nr of threads/pipelines
  -h [ --help ]         Display help message
```


## mrs_info

### Tool Description
Display information about mrs tool

### Metadata
- **Docker Image**: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
- **Homepage**: https://github.com/ctu-mrs/mrs_uav_system
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
mrs info:
  -d [ --databank ] arg Databank
  -c [ --config ] arg   Configuration file
  -v [ --verbose ]      Be verbose
  -a [ --threads ] arg  Nr of threads/pipelines
  -h [ --help ]         Display help message
```


## mrs_query

### Tool Description
Query the MRS databank

### Metadata
- **Docker Image**: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
- **Homepage**: https://github.com/ctu-mrs/mrs_uav_system
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
mrs query:
  -d [ --databank ] arg Databank
  -c [ --config ] arg   Configuration file
  -v [ --verbose ]      Be verbose
  -a [ --threads ] arg  Nr of threads/pipelines
  -h [ --help ]         Display help message
  -q [ --query ] arg    Query term
  --count arg           Result count (default = 10)
  --offset arg          Result offset (default = 0)
```


## mrs_server

### Tool Description
N/A

### Metadata
- **Docker Image**: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
- **Homepage**: https://github.com/ctu-mrs/mrs_uav_system
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
mrs server:
  -c [ --config ] arg   Configuration file
  -u [ --user ] arg     User to run as (e.g. nobody)
  -p [ --pidfile ] arg  Create file with process ID (pid)
  -F [ --no-daemon ]    Do not run as background process
  --command arg         Command, one of start, stop, status or reload
  -h [ --help ]         Display help message
```


## mrs_vacuum

### Tool Description
mrs vacuum

### Metadata
- **Docker Image**: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
- **Homepage**: https://github.com/ctu-mrs/mrs_uav_system
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
mrs vacuum:
  -d [ --databank ] arg Databank
  -c [ --config ] arg   Configuration file
  -v [ --verbose ]      Be verbose
  -a [ --threads ] arg  Nr of threads/pipelines
  -h [ --help ]         Display help message
```


## mrs_validate

### Tool Description
Validate MRS data

### Metadata
- **Docker Image**: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
- **Homepage**: https://github.com/ctu-mrs/mrs_uav_system
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
mrs validate:
  -d [ --databank ] arg Databank
  -c [ --config ] arg   Configuration file
  -v [ --verbose ]      Be verbose
  -a [ --threads ] arg  Nr of threads/pipelines
  -h [ --help ]         Display help message
```


## mrs_update

### Tool Description
Update the mrs databank.

### Metadata
- **Docker Image**: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
- **Homepage**: https://github.com/ctu-mrs/mrs_uav_system
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
mrs update:
  -d [ --databank ] arg Databank
  -c [ --config ] arg   Configuration file
  -v [ --verbose ]      Be verbose
  -a [ --threads ] arg  Nr of threads/pipelines
  -h [ --help ]         Display help message
```


## mrs_password

### Tool Description
Modify user password information

### Metadata
- **Docker Image**: biocontainers/mrs:v6.0.5dfsg-2b2-deb_cv1
- **Homepage**: https://github.com/ctu-mrs/mrs_uav_system
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
mrs password:
  -c [ --config ] arg   Configuration file
  -u [ --user ] arg     User to modify
  -r [ --realm ] arg    Realm to modify
  -h [ --help ]         Display help message
```

