# sina CWL Generation Report

## sina

### Tool Description
SINA (Structure-based Alignment of Nucleic Acids) is a tool for aligning nucleic acid sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/sina:1.7.2--h9aa86b4_0
- **Homepage**: https://github.com/epruesse/SINA
- **Package**: https://anaconda.org/channels/bioconda/packages/sina/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sina/overview
- **Total Downloads**: 118.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/epruesse/SINA
- **Stars**: N/A
### Original Help Text
```text
Usage:
 sina -i input [-o output] [--prealigned|--db reference] [--search] [--search-db search.arb] [options]

Options:
  -h [ --help ]            show short help
  -H [ --help-all ]        show full help (long)
  -i [ --in ] arg (="-")   input file (arb or fasta)
  -o [ --out ] arg         output file (arb, fasta or csv; may be specified 
                           multiple times)
  --add-relatives arg      add the ARG nearest relatives for each sequence to 
                           output
  -S [ --search ]          enable search stage
  -P [ --prealigned ]      skip alignment stage
  -p [ --threads ] arg     limit number of threads (automatic)
  --num-pts arg (=20)      number of PT servers to start
  -V [ --version ]         show version
  -v [ --verbose ]         increase verbosity
  -q [ --quiet ]           decrease verbosity
  --log-file arg           file to write log to
  --meta-fmt arg           meta data in (*none*|header|comment|csv)
  -r [ --db ] arg          reference database
  -t [ --turn ] arg        check other strand as well
                           'all' checks all four frames

Reference Selection:
  --fs-engine arg          search engine to use for reference selection 
                           [*pt-server*|internal]
  --fs-kmer-len arg        length of k-mers (10)
  --fs-req arg             required number of reference sequences (1)
                           queries with less matches will be dropped
  --fs-min arg             number of references used regardless of shared 
                           fraction (40)
  --fs-max arg             number of references used at most (40)
  --fs-msc arg             required fractional identity of references (0.7)
  --fs-req-full arg        required number of full length references (1)
  --fs-full-len arg        minimum length of full length reference (1400)
  --fs-req-gaps arg        ignore references with less internal gaps (10)
  --fs-min-len arg         minimal reference length (150)

Search & Classify:
  --search-db arg          reference db if different from -r/--db
  --search-engine arg      engine if different from --fs-engine
  --search-min-sim arg     required sequence similarity (0.7)
  --search-max-result arg  desired number of search results (10)
  --lca-fields arg         names of fields containing source taxonomy (colon 
                           separated list)
  --lca-quorum arg         fraction of search result that must share resulting 
                           classification (0.7)
```


## Metadata
- **Skill**: generated
