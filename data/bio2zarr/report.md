# bio2zarr CWL Generation Report

## bio2zarr_vcf2zarr

### Tool Description
Convert VCF file(s) to VCF Zarr format.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
- **Homepage**: https://sgkit-dev.github.io/bio2zarr/
- **Package**: https://anaconda.org/channels/bioconda/packages/bio2zarr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bio2zarr/overview
- **Total Downloads**: 478
- **Last updated**: 2026-02-03
- **GitHub**: https://github.com/sgkit-dev/bio2zarr
- **Stars**: N/A
### Original Help Text
```text
Usage: vcf2zarr [OPTIONS] COMMAND [ARGS]...

  Convert VCF file(s) to VCF Zarr format.

  See the online documentation at https://sgkit-dev.github.io/bio2zarr/

  for more information.

Options:
  --version  Show the version and exit.
  --help     Show this message and exit.

Commands:
  convert             Convert input VCF(s) directly to VCF Zarr (not...
  inspect             Inspect an intermediate columnar format or Zarr path.
  explode             Convert VCF(s) to intermediate columnar format
  mkschema            Generate a schema for zarr encoding
  encode              Convert intermediate columnar format to VCF Zarr.
  dexplode-init       Initial step for distributed conversion of VCF(s)...
  dexplode-partition  Convert a VCF partition to intermediate columnar...
  dexplode-finalise   Final step for distributed conversion of VCF(s) to...
  dencode-init        Initialise conversion of intermediate format to VCF...
  dencode-partition   Convert a partition from intermediate columnar...
  dencode-finalise    Final step for distributed conversion of ICF to VCF...
```


## bio2zarr_plink2zarr

### Tool Description
Convert plink fileset(s) to VCF Zarr format

### Metadata
- **Docker Image**: quay.io/biocontainers/bio2zarr:0.1.7--pyhdfd78af_0
- **Homepage**: https://sgkit-dev.github.io/bio2zarr/
- **Package**: https://anaconda.org/channels/bioconda/packages/bio2zarr/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: plink2zarr [OPTIONS] COMMAND [ARGS]...

  Convert plink fileset(s) to VCF Zarr format

Options:
  --version  Show the version and exit.
  --help     Show this message and exit.

Commands:
  convert  Convert plink fileset to VCF Zarr.
```

