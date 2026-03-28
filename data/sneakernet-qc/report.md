# sneakernet-qc CWL Generation Report

## sneakernet-qc_SneakerNet.roRun.pl

### Tool Description
Parses an unaltered Illumina run and formats it into something usable for SneakerNet. Fastq files must be in the format of _R1_ and _R2_ instead of _1 and _2 for this particular script.

### Metadata
- **Docker Image**: quay.io/biocontainers/sneakernet-qc:0.27.2--pl5321hdfd78af_0
- **Homepage**: https://github.com/lskatz/sneakernet
- **Package**: https://anaconda.org/channels/bioconda/packages/sneakernet-qc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sneakernet-qc/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lskatz/sneakernet
- **Stars**: N/A
### Original Help Text
```text
'SneakerNet-read-only': Parses an unaltered Illumina run and formats it
  into something usable for SneakerNet. Fastq files must be in the format of
  _R1_ and _R2_ instead of _1 and _2 for this particular script.

  Usage: SneakerNet.roRun.pl illuminaDirectory [illuminaDirectory2...]
  
  --numcpus             1
  --outdir             ''
  --tempdir            ''
  --createsamplesheet     Also create a SampleSheet.csv or samples.tsv as fallback
   at /usr/local/bin/SneakerNet.roRun.pl line 35.
```


## sneakernet-qc_SneakerNetPlugins.pl

### Tool Description
runs all SneakerNet plugins on a run directory

### Metadata
- **Docker Image**: quay.io/biocontainers/sneakernet-qc:0.27.2--pl5321hdfd78af_0
- **Homepage**: https://github.com/lskatz/sneakernet
- **Package**: https://anaconda.org/channels/bioconda/packages/sneakernet-qc/overview
- **Validation**: PASS

### Original Help Text
```text
SneakerNetPlugins.pl: runs all SneakerNet plugins on a run directory
  Usage: SneakerNetPlugins.pl dir [dir2...]
  --noemail     Do not send an email at the end.
  --no      ''  Specify a regex of which plugins to skip.
                Can provide multiple instances.  E.g.,
                --no email --no transfer --no save
                Case insensitive.
  --dry-run     Just print the plugin commands that would have been run
  --keep-going  If a plugin has an error, move onto the next anyway
  --numcpus 1
  --tempdir ''  Force a temporary directory path to each plugin
  --force
  --version     Print SneakerNet version and exit
  --workflow    Which workflow under plugins.conf should we follow?
                If not specified, will look at snok.txt.
                If not snok.txt, will use 'default'
   at /usr/local/bin/SneakerNetPlugins.pl line 36.
```


## Metadata
- **Skill**: generated
