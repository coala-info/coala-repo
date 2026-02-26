# allelecodes CWL Generation Report

## allelecodes_assignAlleleCodes_py3.6.py

### Tool Description
Calculates nearest neighbor in hierarchical, single-linkage framework to assign that neighbor's code up to the corresponding distance threshold, or a new code if no matches found

### Metadata
- **Docker Image**: quay.io/biocontainers/allelecodes:2.1--py313hdfd78af_0
- **Homepage**: https://github.com/ncezid-biome/AlleleCodes
- **Package**: https://anaconda.org/channels/bioconda/packages/allelecodes/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/allelecodes/overview
- **Total Downloads**: 92
- **Last updated**: 2025-08-27
- **GitHub**: https://github.com/ncezid-biome/AlleleCodes
- **Stars**: N/A
### Original Help Text
```text
usage: assignAlleleCodes_py3.6.py -a ALLELES -c CONFIG -d DATADIR
                                  -p {CAMP,EC,LMO,SALM} [-h] [--nosave]
                                  [--verbose] [-o OUTPUT]

Calculates nearest neighbor in hierarchical, single-linkage framework to assign that neighbor's code up to the corresponding distance threshold, or a new code if no matches found

required arugments:
  -a, --alleles ALLELES
                        csv or tsv file. Unique Keys/IDs in first column with
                        PulseNet locus names as fields afterward, preceded
                        with acceptable prefixes CAMP, EC, LMO, or SALM (e.g.
                        EC_1, EC_2, EC_3, etc.
  -c, --config CONFIG   text file containing names of core loci to match
                        against --alleles file to denote which loci should be
                        used for assignment
  -d, --dataDir DATADIR
                        directory where logs and data files will be written if
                        --nosave is not entered as input flag
  -p, --prefix {CAMP,EC,LMO,SALM}
                        organism-specific prefix to be added to front of
                        Allele Code

optional arugments:
  -h, --help            show this help message and exit
  --nosave              whether results of run will overwrite historical
                        allele profiles and nomenclature tree; default = False
                        if not provided
  --verbose             output what's written to log file if provided; default
                        = False
  -o, --output OUTPUT   output file (tsv or csv) into which results will be
                        written (delimiter determined by input extension)

Example usage:  python assignAlleleCodes_v3.6.py -a profiles.tsv -c locusNames.txt -d $(pwd) -p CAMP --nosave

*Note:  locus order is determined by input config file and not saved to data directory.  The same file should be used in consecutive runs to ensure consistent locus-to-locus comparisons.
```

