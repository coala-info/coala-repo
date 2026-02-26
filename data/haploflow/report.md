# haploflow CWL Generation Report

## haploflow

### Tool Description
HaploFlow parameters

### Metadata
- **Docker Image**: quay.io/biocontainers/haploflow:1.0--h9948957_5
- **Homepage**: https://github.com/hzi-bifo/Haploflow
- **Package**: https://anaconda.org/channels/bioconda/packages/haploflow/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/haploflow/overview
- **Total Downloads**: 7.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hzi-bifo/Haploflow
- **Stars**: N/A
### Original Help Text
```text
HaploFlow parameters:
  --help                           Produce this help message
  --read-file arg                  read file (fastq)
  --dump-file arg                  deBruijn graph dump file produced by 
                                   HaploFlow
  --log arg                        log file (default: standard out)
  --k arg (=41)                    k-mer size, default 41, please use an odd 
                                   number
  --out arg                        folder for output, will be created if not 
                                   present. WARNING: Old results will get 
                                   overwritten
  --error-rate arg (=0.0199999996) percentage filter for erroneous kmers - 
                                   kmers appearing less than relatively e% will
                                   be ignored
  --create-dump arg                create dump of the deBruijn graph. WARNING: 
                                   This file may be huge
  --from-dump arg                  run from a Haploflow dump of the deBruijn 
                                   graph.
  --two-strain arg (=0)            mode for known two-strain mixtures
  --strict arg (=5)                more strict error correction, should be set 
                                   to 5 in first run on new data set to reduce 
                                   run time. Set to 0 if low abundant strains 
                                   are expected to be present
  --filter arg (=500)              filter contigs shorter than value
  --thresh arg (=-1)               Provide a custom threshold for complex/bad 
                                   data
  --long arg (=0)                  Try to maximise contig lengths (might 
                                   introduce errors)
  --true-flow arg (=0)             Do not perform flow correction, assume 
                                   perfect flows
  --debug arg (=0)                 Report all temporary graphs and coverage 
                                   histograms
```

