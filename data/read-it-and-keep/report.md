# read-it-and-keep CWL Generation Report

## read-it-and-keep_readItAndKeep

### Tool Description
Read-it-and-keep is a tool to filter reads based on mapping information.

### Metadata
- **Docker Image**: quay.io/biocontainers/read-it-and-keep:0.3.0--h5ca1c30_3
- **Homepage**: https://github.com/GenomePathogenAnalysisService/read-it-and-keep
- **Package**: https://anaconda.org/channels/bioconda/packages/read-it-and-keep/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/read-it-and-keep/overview
- **Total Downloads**: 14.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/GenomePathogenAnalysisService/read-it-and-keep
- **Stars**: N/A
### Original Help Text
```text
Usage: readItAndKeep [OPTIONS]

Options:
  -h,--help                   Print this help message and exit
  --tech TEXT                 Sequencing technology, must be 'illumina' or 'ont' [illumina]
  --ref_fasta TEXT:FILE REQUIRED
                              Reference genome FASTA filename
  --reads1 TEXT:FILE REQUIRED Name of first reads file
  --reads2 TEXT:FILE          Name of second reads file, ie mates file for paired reads
  -o,--outprefix TEXT REQUIRED
                              Prefix of output files
  --enumerate_names           Rename the reads 1,2,3,... (for paired reads, will also add /1 or /2 on the end of names)
  --debug                     Debug mode. More verbose and writes debugging files
  --min_map_length UINT       Minimum length of match required to keep a read in bp [50]
  --min_map_length_pc FLOAT   Minimum length of match required to keep a read, as a percent of the read length [50.0]
  -V,--version                Show version and exit
```

