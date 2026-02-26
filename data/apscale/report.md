# apscale CWL Generation Report

## apscale

### Tool Description
Advanced Pipeline for Simple yet Comprehensive AnaLysEs of DNA metabarcoding data, see https://github.com/DominikBuchner/apscale for detailed help.

### Metadata
- **Docker Image**: quay.io/biocontainers/apscale:4.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/DominikBuchner/apscale
- **Package**: https://anaconda.org/channels/bioconda/packages/apscale/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/apscale/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2026-01-27
- **GitHub**: https://github.com/DominikBuchner/apscale
- **Stars**: N/A
### Original Help Text
```text
usage: apscale [-h] [--create_project NAME] [--run_apscale [PATH]]
               [--pe_merging [PATH]] [--primer_trimming [PATH]]
               [--quality_filtering [PATH]] [--dereplication [PATH]]
               [--denoising [PATH]] [--swarm_clustering [PATH]]
               [--replicate_merging [PATH]] [--nc_removal [PATH]]
               [--generate_read_table [PATH]] [--analyze [PATH]]

Advanced Pipeline for Simple yet Comprehensive AnaLysEs of DNA metabarcoding
data, see https://github.com/DominikBuchner/apscale for detailed help.

options:
  -h, --help                    show this help message and exit

Creating a project:
  Creates a new apscale project in the current working directory

  --create_project NAME         Creates a new apscale project with the name
                                provided

Running a module:
  Run the apscale pipeline or any specified module. Providing a PATH is
  optional. If no path is provided apscale will run in the current working
  directory.

  --run_apscale [PATH]          Run the entire pipeline.
  --pe_merging [PATH]           Run the pe_merging module.
  --primer_trimming [PATH]      Run the primer_trimimng module.
  --quality_filtering [PATH]    Run the quality_filtering module.
  --dereplication [PATH]        Run the dereplication_pooling module.
  --denoising [PATH]            Run the denoising module.
  --swarm_clustering [PATH]     Run the swarm clustering module.
  --replicate_merging [PATH]    Run the replicate merging module.
  --nc_removal [PATH]           Run the negative control removal module.
  --generate_read_table [PATH]  Run the read table generation module.
  --analyze [PATH]              Run the analysis module
```

