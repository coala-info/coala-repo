# cannoli CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| cannoli_bcftoolsCall | Failed | image problem: bcftools is not in the image (Cannot run program bcftools), and Spark also fails under --net=none because it cannot resolve the container host name. |

## Metadata
- **Skill**: generated

## cannoli_bcftoolsCall

### Tool Description
Call variant contexts with bcftools call via Cannoli/Spark.

### Metadata
- **Docker Image**: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
- **Homepage**: https://github.com/bigdatagenomics/cannoli
- **Package**: https://anaconda.org/channels/bioconda/packages/cannoli/overview
- **Validation**: PASS
### Original Help Text
```text
INPUT                                                                     : Location to pipe variant contexts from (e.g. .vcf, .vcf.gz, .vcf.bgz).
                                                                             If extension is not detected, Parquet is assumed.
 OUTPUT                                                                    : Location to pipe variant contexts to (e.g. .vcf, .vcf.gz, .vcf.bgz). If
                                                                             extension is not detected, Parquet is assumed.
 -add_files                                                                : If true, use the SparkFiles mechanism to distribute files to executors.
                                                                             (default: false)
 -bcftools_args VAL                                                        : Additional arguments for Bcftools, must be double-quoted, e.g.
                                                                             -bcftools_args "--gcvf 5,15"
 -defer_merging                                                            : Defers merging single file output. (default: false)
 -disable_fast_concat                                                      : Disables the parallel file concatenation engine. (default: false)
 -docker_image VAL                                                         : Container image to use. Defaults to quay.io/biocontainers/bcftools:1.19--
                                                                             h8b25389_0. (default: quay.io/biocontainers/bcftools:1.19--h8b25389_0)
 -executable VAL                                                           : Path to the bcftools executable. Defaults to bcftools. (default:
                                                                             bcftools)
 -h (-help, --help, -?)                                                    : Print help (default: true)
 -parquet_block_size N                                                     : Parquet block size (default = 128mb) (default: 134217728)
 -parquet_compression_codec [UNCOMPRESSED | SNAPPY | GZIP | LZO | BROTLI   : Parquet compression codec (default: GZIP)
 | LZ4 | ZSTD | LZ4_RAW]                                                      
 -parquet_disable_dictionary                                               : Disable dictionary encoding (default: false)
 -parquet_logging_level VAL                                                : Parquet logging level (default = severe) (default: SEVERE)
 -parquet_page_size N                                                      : Parquet page size (default = 1mb) (default: 1048576)
 -single                                                                   : Saves OUTPUT as single file. (default: false)
 -stringency VAL                                                           : Stringency level for various checks; can be SILENT, LENIENT, or STRICT.
                                                                             Defaults to STRICT. (default: STRICT)
 -sudo                                                                     : Run via sudo. (default: false)
 -use_docker                                                               : If true, uses Docker to launch bcftools. (default: false)
 -use_singularity                                                          : If true, uses Singularity to launch bcftools. (default: false)
```

