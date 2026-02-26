# mapula CWL Generation Report

## mapula_count

### Tool Description
Count mapping stats from a SAM/BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/mapula:2.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/epi2me-labs/mapula
- **Package**: https://anaconda.org/channels/bioconda/packages/mapula/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mapula/overview
- **Total Downloads**: 12.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/epi2me-labs/mapula
- **Stars**: N/A
### Original Help Text
```text
usage: mapula [-h] -r [...] [-c] [-p] [-f] [-s  [...]] [-n] [...]

Count mapping stats from a SAM/BAM file

positional arguments:
              Input alignments in SAM format. (Default: [stdin]).

optional arguments:
  -h, --help  show this help message and exit
  -r [ ...]   Reference .fasta file(s).
  -c          Expected counts CSV. Required columns: reference,expected_count.
  -p          Enable relay of input SAM records to stdout.
  -f          If aggregating [-a], output results in this format. [Choices:
              csv, json, all] (Default: csv).
  -s  [ ...]  Change aggregation behaviour to split by these criteria, space
              separated. [Choices: source fasta run_id barcode read_group
              reference] (Default: all).
  -n          Prefix of the output files, if there are any.
```


## mapula_merge

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/mapula:2.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/epi2me-labs/mapula
- **Package**: https://anaconda.org/channels/bioconda/packages/mapula/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Running: Mapula (merge)
[1/2] Merging aggregations
Traceback (most recent call last):
  File "/usr/local/bin/mapula", line 10, in <module>
    sys.exit(run_main())
  File "/usr/local/lib/python3.9/site-packages/mapula/main.py", line 41, in run_main
    MappingStats()
  File "/usr/local/lib/python3.9/site-packages/mapula/main.py", line 31, in __init__
    getattr(self, args.command)(sys.argv[2:])
  File "/usr/local/lib/python3.9/site-packages/mapula/main.py", line 37, in merge
    MergeMappingStats.execute(argv)
  File "/usr/local/lib/python3.9/site-packages/mapula/merge.py", line 150, in execute
    cls(
  File "/usr/local/lib/python3.9/site-packages/mapula/merge.py", line 36, in __init__
    self.aggregations = self.merge_aggregations(
  File "/usr/local/lib/python3.9/site-packages/mapula/merge.py", line 62, in merge_aggregations
    existing_data = load_data(path)
  File "/usr/local/lib/python3.9/site-packages/mapula/utils.py", line 21, in load_data
    with open(path) as data:
TypeError: expected str, bytes or os.PathLike object, not TextIOWrapper
```

