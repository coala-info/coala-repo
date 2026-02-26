# ipyrad CWL Generation Report

## ipyrad

### Tool Description
ipyrad is a tool for assembling RAD-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/ipyrad:0.9.108--pyhdfd78af_0
- **Homepage**: http://github.com/dereneaton/ipyrad
- **Package**: https://anaconda.org/channels/bioconda/packages/ipyrad/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ipyrad/overview
- **Total Downloads**: 196.2K
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/dereneaton/ipyrad
- **Stars**: N/A
### Original Help Text
```text
usage: ipyrad [-h] [-v] [-r] [-f] [-q] [-d] [-n NEW] [-p PARAMS] [-s STEPS]
              [-b [BRANCH ...]] [-m [MERGE ...]] [-c cores] [-t threading]
              [--MPI] [--ipcluster [IPCLUSTER]] [--download [DOWNLOAD ...]]

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -r, --results         show results summary for Assembly in params.txt and
                        exit
  -f, --force           force overwrite of existing data
  -q, --quiet           do not print to stderror or stdout.
  -d, --debug           print lots more info to ipyrad_log.txt.
  -n NEW                create new file 'params-{new}.txt' in current
                        directory
  -p PARAMS             path to params file for Assembly:
                        params-{assembly_name}.txt
  -s STEPS              Set of assembly steps to run, e.g., -s 123
  -b [BRANCH ...]       create new branch of Assembly as params-{branch}.txt,
                        and can be used to drop samples from Assembly.
  -m [MERGE ...]        merge multiple Assemblies into one joint Assembly, and
                        can be used to merge Samples into one Sample.
  -c cores              number of CPU cores to use (Default=0=All)
  -t threading          tune threading of multi-threaded binaries (Default=2)
  --MPI                 connect to parallel CPUs across multiple nodes
  --ipcluster [IPCLUSTER]
                        connect to running ipcluster, enter profile name or
                        profile='default'
  --download [DOWNLOAD ...]
                        download fastq files by accession (e.g., SRP or SRR)

  * Example command-line usage: 
    ipyrad -n data                       ## create new file called params-data.txt 
    ipyrad -p params-data.txt -s 123     ## run only steps 1-3 of assembly.
    ipyrad -p params-data.txt -s 3 -f    ## run step 3, overwrite existing data.

  * HPC parallelization across 32 cores
    ipyrad -p params-data.txt -s 3 -c 32 --MPI

  * Print results summary 
    ipyrad -p params-data.txt -r 

  * Branch/Merging Assemblies
    ipyrad -p params-data.txt -b newdata  
    ipyrad -m newdata params-1.txt params-2.txt [params-3.txt, ...]

  * Subsample taxa during branching
    ipyrad -p params-data.txt -b newdata taxaKeepList.txt

  * Download sequence data from SRA into directory 'sra-fastqs/' 
    ipyrad --download SRP021469 sra-fastqs/ 

  * Documentation: http://ipyrad.readthedocs.io
```

