# profile_dists CWL Generation Report

## profile_dists

### Tool Description
Calculate genetic distances based on allele profiles v. 1.0.10

### Metadata
- **Docker Image**: quay.io/biocontainers/profile_dists:1.0.10--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/profile-dists
- **Package**: https://anaconda.org/channels/bioconda/packages/profile_dists/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/profile_dists/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-11-13
- **GitHub**: https://github.com/phac-nml/profile_dists
- **Stars**: N/A
### Original Help Text
```text
usage: profile_dists [-h] --query QUERY --ref REF --outdir OUTDIR
                     [--outfmt OUTFMT] [--file_type FILE_TYPE] [--distm DISTM]
                     [--missing_thresh MISSING_THRESH]
                     [--sample_qual_thresh SAMPLE_QUAL_THRESH]
                     [--match_threshold MATCH_THRESHOLD]
                     [--mapping_file MAPPING_FILE] [--batch_size BATCH_SIZE]
                     [--max_mem MAX_MEM] [--force] [-s] [--columns COLUMNS]
                     [-n] [-p CPUS] [-V]

Profile Dists: Calculate genetic distances based on allele profiles v. 1.0.10

options:
  -h, --help            show this help message and exit
  --query QUERY, -q QUERY
                        Query allelic profiles (default: None)
  --ref REF, -r REF     Reference allelic profiles (default: None)
  --outdir OUTDIR, -o OUTDIR
                        Result output files (default: None)
  --outfmt OUTFMT, -u OUTFMT
                        Out format [matrix, pairwise] (default: matrix)
  --file_type FILE_TYPE, -e FILE_TYPE
                        Out format [text, parquet] (default: text)
  --distm DISTM, -d DISTM
                        Distance method raw hamming or scaled difference
                        [hamming, scaled] (default: scaled)
  --missing_thresh MISSING_THRESH, -t MISSING_THRESH
                        Maximum percentage of missing data allowed per locus
                        (0 - 1) (default: 1.0)
  --sample_qual_thresh SAMPLE_QUAL_THRESH, -c SAMPLE_QUAL_THRESH
                        Maximum percentage of missing data allowed per sample
                        (0 - 1) (default: 1.0)
  --match_threshold MATCH_THRESHOLD, -a MATCH_THRESHOLD
                        Either a integer or float depending on what distance
                        method is used (only used with pairwise format
                        (default: -1)
  --mapping_file MAPPING_FILE, -m MAPPING_FILE
                        json formatted allele mapping (default: None)
  --batch_size BATCH_SIZE
                        Manual selection of how many records should be
                        included in a batch, default=auto (default: None)
  --max_mem MAX_MEM     Maximum amount of memory to use (default: None)
  --force, -f           Overwrite existing directory (default: False)
  -s, --skip            Skip QA/QC steps (default: False)
  --columns COLUMNS     Single column file with one column name per line or
                        list of columns comma separate (default: None)
  -n, --count_missing   Count missing as differences (default: False)
  -p CPUS, --cpus CPUS  Count missing as differences (default: 1)
  -V, --version         show program's version number and exit
```


## Metadata
- **Skill**: generated
