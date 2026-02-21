# pbhoover CWL Generation Report

## pbhoover

### Tool Description
A tool for calling variants and consensus from PacBio cmp.h5 files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbhoover:1.1.0--pyhdfd78af_1
- **Homepage**: https://gitlab.com/LPCDRP/pbhoover
- **Package**: https://anaconda.org/channels/bioconda/packages/pbhoover/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbhoover/overview
- **Total Downloads**: 13.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: pbhoover [-h] [--version] [-c] [-i INPUT] [-o OUTPUT] [-r REFERENCE]
                [-n NPROC] [-s CHUNKSIZE] [--min-vf MIN_VF]
                [--min-vf-si MIN_VF_SI] [-t TEMPDIR] [-d]

optional arguments:
  -h, --help            show this help message and exit
  --version             Print program version and exit
  -c, --consensus       Call consensus (output all positions to VCF)
  -i INPUT, --input INPUT
                        Input cmp.h5 file
  -o OUTPUT, --output OUTPUT
                        Output VCF file name, stdout by default
  -r REFERENCE, --reference REFERENCE
                        Reference FASTA file for indel normalization
  -n NPROC, --nproc NPROC
                        number of processors to be used, uses all available by
                        default
  -s CHUNKSIZE, --chunksize CHUNKSIZE
                        Genome chunk size used for parallelizaton, 5000 by
                        default
  --min-vf MIN_VF       Minimum variant frequency to call heterogeneous SNPs
                        and multi-base indels (default 0.1)
  --min-vf-si MIN_VF_SI
                        Minimum variant frequency to call heterogeneous
                        single-base indels (default 0.2)
  -t TEMPDIR, --tempdir TEMPDIR
                        Temporary directory for analysis.
  -d, --debug           Flag for debugging purposes. Writes more information
                        to log
```


## Metadata
- **Skill**: generated
