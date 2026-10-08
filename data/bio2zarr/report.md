# bio2zarr CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| bio2zarr_plink2zarr_convert | PASS |  |
| bio2zarr_tskit2zarr_convert | PASS |  |
| bio2zarr_vcf2zarr_convert | PASS |  |
| bio2zarr_vcf2zarr_dencode_finalise | PASS |  |
| bio2zarr_vcf2zarr_dencode_init | PASS |  |
| bio2zarr_vcf2zarr_dencode_partition | PASS |  |
| bio2zarr_vcf2zarr_dexplode_finalise | PASS |  |
| bio2zarr_vcf2zarr_dexplode_init | PASS |  |
| bio2zarr_vcf2zarr_dexplode_partition | PASS |  |
| bio2zarr_vcf2zarr_encode | PASS |  |
| bio2zarr_vcf2zarr_explode | PASS |  |
| bio2zarr_vcf2zarr_inspect | PASS |  |
| bio2zarr_vcf2zarr_mkschema | PASS |  |
| bio2zarr_vcfpartition | PASS |  |

## bio2zarr_vcf2zarr_convert

### Tool Description
Convert input VCF(s) directly to VCF Zarr (not recommended for large files).

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
Usage: vcf2zarr convert [OPTIONS] VCFS... ZARR_PATH

  Convert input VCF(s) directly to VCF Zarr (not recommended for large files).

Options:
  -f, --force                     Force overwriting of existing directories
  -l, --variants-chunk-size INTEGER
                                  Chunk size in the variants dimension
  -w, --samples-chunk-size INTEGER
                                  Chunk size in the samples dimension
  -v, --verbose                   Increase verbosity
  -P, --progress / -Q, --no-progress
                                  Show progress bars (default: show)
  -p, --worker-processes INTEGER  Number of worker processes  [default: 0]
  --local-alleles / --no-local-alleles
                                  Use local allele fields to reduce the
                                  storage requirements of the output.
                                  [default: no-local-alleles]
  --help                          Show this message and exit.
```

## bio2zarr_vcf2zarr_inspect

### Tool Description
Inspect an intermediate columnar format or Zarr path.

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
Usage: vcf2zarr inspect [OPTIONS] PATH

  Inspect an intermediate columnar format or Zarr path.

Options:
  -v, --verbose  Increase verbosity
  --help         Show this message and exit.
```

## bio2zarr_vcf2zarr_explode

### Tool Description
Convert VCF(s) to intermediate columnar format

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
Usage: vcf2zarr explode [OPTIONS] VCFS... ICF_PATH

  Convert VCF(s) to intermediate columnar format

Options:
  -f, --force                     Force overwriting of existing directories
  -v, --verbose                   Increase verbosity
  -c, --column-chunk-size INTEGER
                                  Approximate uncompressed size of exploded
                                  column chunks in MiB
  -C, --compressor [lz4|zstd]     Codec to use for compressing column chunks
                                  (Default=zstd).
  -P, --progress / -Q, --no-progress
                                  Show progress bars (default: show)
  -p, --worker-processes INTEGER  Number of worker processes  [default: 0]
  --help                          Show this message and exit.
```

## bio2zarr_vcf2zarr_mkschema

### Tool Description
Generate a schema for zarr encoding

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
Usage: vcf2zarr mkschema [OPTIONS] ICF_PATH

  Generate a schema for zarr encoding

Options:
  -l, --variants-chunk-size INTEGER
                                  Chunk size in the variants dimension
  -w, --samples-chunk-size INTEGER
                                  Chunk size in the samples dimension
  --local-alleles / --no-local-alleles
                                  Use local allele fields to reduce the
                                  storage requirements of the output.
                                  [default: no-local-alleles]
  --help                          Show this message and exit.
```

## bio2zarr_vcf2zarr_encode

### Tool Description
Convert intermediate columnar format to VCF Zarr.

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
Usage: vcf2zarr encode [OPTIONS] ICF_PATH ZARR_PATH

  Convert intermediate columnar format to VCF Zarr.

Options:
  -f, --force                     Force overwriting of existing directories
  -v, --verbose                   Increase verbosity
  -s, --schema PATH
  -l, --variants-chunk-size INTEGER
                                  Chunk size in the variants dimension
  -w, --samples-chunk-size INTEGER
                                  Chunk size in the samples dimension
  -V, --max-variant-chunks INTEGER
                                  Truncate the output in the variants
                                  dimension to have this number of chunks.
                                  Mainly intended to help with schema tuning.
  -M, --max-memory TEXT           An approximate bound on overall memory usage
                                  (e.g. 10G),
  -P, --progress / -Q, --no-progress
                                  Show progress bars (default: show)
  -p, --worker-processes INTEGER  Number of worker processes  [default: 0]
  --help                          Show this message and exit.
```

## bio2zarr_vcf2zarr_dexplode_init

### Tool Description
Initial step for distributed conversion of VCF(s) to intermediate columnar format over some number of paritions.

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
Usage: vcf2zarr dexplode-init [OPTIONS] VCFS... ICF_PATH

  Initial step for distributed conversion of VCF(s) to intermediate columnar
  format over some number of paritions.

Options:
  -n, --num-partitions INTEGER RANGE
                                  Target number of partitions to split into
                                  [x>=1]
  -f, --force                     Force overwriting of existing directories
  -c, --column-chunk-size INTEGER
                                  Approximate uncompressed size of exploded
                                  column chunks in MiB
  -C, --compressor [lz4|zstd]     Codec to use for compressing column chunks
                                  (Default=zstd).
  --json                          Output summary data in JSON format
  -v, --verbose                   Increase verbosity
  -P, --progress / -Q, --no-progress
                                  Show progress bars (default: show)
  -p, --worker-processes INTEGER  Number of worker processes  [default: 0]
  --help                          Show this message and exit.
```

## bio2zarr_vcf2zarr_dexplode_partition

### Tool Description
Convert a VCF partition to intermediate columnar format. Must be called after the ICF path has been initialised with dexplode_init. By default, partition indexes are from 0 to the number of partitions N (returned by dexplode_init), exclusive. If the --one-based option is specifed, partition indexes are in the range 1 to N, inclusive.

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
Usage: vcf2zarr dexplode-partition [OPTIONS] ICF_PATH PARTITION

  Convert a VCF partition to intermediate columnar format. Must be called
  after the ICF path has been initialised with dexplode_init. By default,
  partition indexes are from 0 to the number of partitions N (returned by
  dexplode_init), exclusive. If the --one-based option is specifed, partition
  indexes are in the range 1 to N, inclusive.

Options:
  -v, --verbose  Increase verbosity
  --one-based    Partition indexes are interpreted as one-based
  --help         Show this message and exit.
```

## bio2zarr_vcf2zarr_dexplode_finalise

### Tool Description
Final step for distributed conversion of VCF(s) to intermediate columnar format.

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
Usage: vcf2zarr dexplode-finalise [OPTIONS] ICF_PATH

  Final step for distributed conversion of VCF(s) to intermediate columnar
  format.

Options:
  -v, --verbose  Increase verbosity
  --help         Show this message and exit.
```

## bio2zarr_vcf2zarr_dencode_init

### Tool Description
Initialise conversion of intermediate format to VCF Zarr. This will set up the specified ZARR_PATH to perform this conversion over some number of partitions.

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
Usage: vcf2zarr dencode-init [OPTIONS] ICF_PATH ZARR_PATH

  Initialise conversion of intermediate format to VCF Zarr. This will set up
  the specified ZARR_PATH to perform this conversion over some number of
  partitions.

  The output of this commmand is the actual number of partitions generated
  (which may be less then the requested number, if there is not sufficient
  chunks in the variants dimension) and a rough lower-bound on the amount of
  memory required to encode a partition.

  NOTE: the format of this output will likely change in subsequent releases;
  it should not be considered machine-readable for now.

Options:
  -n, --num-partitions INTEGER RANGE
                                  Target number of partitions to split into
                                  [x>=1]
  -f, --force                     Force overwriting of existing directories
  -s, --schema PATH
  -l, --variants-chunk-size INTEGER
                                  Chunk size in the variants dimension
  -w, --samples-chunk-size INTEGER
                                  Chunk size in the samples dimension
  -V, --max-variant-chunks INTEGER
                                  Truncate the output in the variants
                                  dimension to have this number of chunks.
                                  Mainly intended to help with schema tuning.
  --json                          Output summary data in JSON format
  -P, --progress / -Q, --no-progress
                                  Show progress bars (default: show)
  -v, --verbose                   Increase verbosity
  --help                          Show this message and exit.
```

## bio2zarr_vcf2zarr_dencode_partition

### Tool Description
Convert a partition from intermediate columnar format to VCF Zarr. Must be called after the Zarr path has been initialised with dencode_init. By default, partition indexes are from 0 to the number of partitions N (returned by dencode_init), exclusive. If the --one-based option is specifed, partition indexes are in the range 1 to N, inclusive.

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
Usage: vcf2zarr dencode-partition [OPTIONS] ZARR_PATH PARTITION

  Convert a partition from intermediate columnar format to VCF Zarr. Must be
  called after the Zarr path has been initialised with dencode_init. By
  default, partition indexes are from 0 to the number of partitions N
  (returned by dencode_init), exclusive. If the --one-based option is
  specifed, partition indexes are in the range 1 to N, inclusive.

Options:
  -v, --verbose  Increase verbosity
  --one-based    Partition indexes are interpreted as one-based
  --help         Show this message and exit.
```

## bio2zarr_vcf2zarr_dencode_finalise

### Tool Description
Final step for distributed conversion of ICF to VCF Zarr.

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
Usage: vcf2zarr dencode-finalise [OPTIONS] ZARR_PATH

  Final step for distributed conversion of ICF to VCF Zarr.

Options:
  -v, --verbose                   Increase verbosity
  -P, --progress / -Q, --no-progress
                                  Show progress bars (default: show)
  --help                          Show this message and exit.
```

## bio2zarr_plink2zarr_convert

### Tool Description
Convert plink fileset to VCF Zarr. Results are equivalent to `plink1.9 --bfile prefix --keep-allele-order --recode vcf-iid --out tmp` then running `vcf2zarr convert tmp.vcf zarr_path`

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
Usage: plink2zarr convert [OPTIONS] IN_PATH ZARR_PATH

  Convert plink fileset to VCF Zarr. Results are equivalent to `plink1.9
  --bfile prefix --keep-allele-order --recode vcf-iid --out tmp` then running
  `vcf2zarr convert tmp.vcf zarr_path`

Options:
  -f, --force                     Force overwriting of existing directories
  -p, --worker-processes INTEGER  Number of worker processes  [default: 0]
  -P, --progress / -Q, --no-progress
                                  Show progress bars (default: show)
  -v, --verbose                   Increase verbosity
  -l, --variants-chunk-size INTEGER
                                  Chunk size in the variants dimension
  -w, --samples-chunk-size INTEGER
                                  Chunk size in the samples dimension
  --help                          Show this message and exit.
```

## bio2zarr_vcfpartition

### Tool Description
Output bcftools region strings that partition indexed VCF/BCF files into parts.

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
Usage: vcfpartition [OPTIONS] VCFS...

  Output bcftools region strings that partition the indexed VCF/BCF files into
  either an approximate number of parts (-n), or parts of approximately a
  given size (-s). One of -n or -s must be supplied.

  If multiple VCF/BCF files are provided, the number of parts (-n) is
  interpreted as the total number of partitions across all the files, and the
  partitions are distributed evenly among the files.

  Note that both the number of partitions and sizes are a target, and the
  returned number of partitions may not exactly correspond. In particular,
  there is a maximum level of granularity determined by the associated index
  which cannot be exceeded.

  Note also that the partitions returned may vary considerably in the number
  of records that they contain.

Options:
  --version                       Show the version and exit.
  -v, --verbose                   Increase verbosity
  -n, --num-partitions INTEGER RANGE
                                  Target number of partitions to split into
                                  [x>=1]
  -s, --partition-size TEXT       Target (compressed) size of VCF partitions,
                                  e.g. 100KB, 10MiB, 1G.
  --help                          Show this message and exit.
```

## bio2zarr_tskit2zarr_convert

### Tool Description
Convert tskit tree sequence(s) to VCF Zarr format.

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
Usage: tskit2zarr convert [OPTIONS] TS_PATH ZARR_PATH

Options:
  --contig-id TEXT                Contig/chromosome ID (default: '1')
  --isolated-as-missing / --isolated-as-ancestral
                                  Treat isolated samples without mutations as
                                  missing or ancestral (default: tskit
                                  default)
  -l, --variants-chunk-size INTEGER
                                  Chunk size in the variants dimension
  -w, --samples-chunk-size INTEGER
                                  Chunk size in the samples dimension
  -v, --verbose                   Increase verbosity
  -P, --progress / -Q, --no-progress
                                  Show progress bars (default: show)
  -p, --worker-processes INTEGER  Number of worker processes  [default: 0]
  -f, --force                     Force overwriting of existing directories
  --help                          Show this message and exit.
```

## Metadata
- **Skill**: generated
