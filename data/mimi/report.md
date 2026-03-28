# mimi CWL Generation Report

## mimi_mimi_kegg_extract

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/NYUAD-Core-Bioinformatics/MIMI
- **Package**: https://anaconda.org/channels/bioconda/packages/mimi/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/mimi/overview
- **Total Downloads**: 355
- **Last updated**: 2025-10-20
- **GitHub**: https://github.com/NYUAD-Core-Bioinformatics/MIMI
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/mimi_kegg_extract", line 6, in <module>
    from mimi.kegg import main
  File "/usr/local/lib/python3.14/site-packages/mimi/kegg.py", line 28, in <module>
    import requests
ModuleNotFoundError: No module named 'requests'
```


## mimi_mimi_hmdb_extract

### Tool Description
Extract metabolite information from HMDB XML file

### Metadata
- **Docker Image**: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/NYUAD-Core-Bioinformatics/MIMI
- **Package**: https://anaconda.org/channels/bioconda/packages/mimi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mimi_hmdb_extract [-h] [--id-tag ID_TAG] -x XML [-l MIN_MASS]
                         [-u MAX_MASS] [-o OUTPUT]

Extract metabolite information from HMDB XML file

options:
  -h, --help            show this help message and exit
  --id-tag ID_TAG       Preferred ID tag to use. Options: accession, kegg_id,
                        chebi_id, pubchem_compound_id, drugbank_id
  -x, --xml XML         Path to HMDB metabolites XML file
  -l, --min-mass MIN_MASS
                        Lower bound of molecular weight in Da
  -u, --max-mass MAX_MASS
                        Upper bound of molecular weight in Da
  -o, --output OUTPUT   Output TSV file path (default: metabolites.tsv)
```


## mimi_mimi_cache_create

### Tool Description
Molecular Isotope Mass Identifier

### Metadata
- **Docker Image**: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/NYUAD-Core-Bioinformatics/MIMI
- **Package**: https://anaconda.org/channels/bioconda/packages/mimi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mimi_cache_create [-h] [-l JSON] [-n CUTOFF] -d DBTSV [DBTSV ...]
                         -i {pos,neg} -c DBBINARY

Molecular Isotope Mass Identifier

options:
  -h, --help            show this help message and exit
  -l, --label JSON      Labeled atoms
  -n, --noise CUTOFF    Threshold for filtering molecular isotope variants
                        with relative abundance below CUTOFF w.r.t. the
                        monoisotopic mass (defaults to 1e-5)
  -d, --dbfile DBTSV [DBTSV ...]
                        File(s) with list of compounds
  -i, --ion {pos,neg}   Ionisation mode
  -c, --cache DBBINARY  Binary DB output file (if not specified, will use base
                        name from JSON file)
```


## mimi_mimi_mass_analysis

### Tool Description
Molecular Isotope Mass Identifier

### Metadata
- **Docker Image**: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/NYUAD-Core-Bioinformatics/MIMI
- **Package**: https://anaconda.org/channels/bioconda/packages/mimi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mimi_mass_analysis [-h] -p PPM -vp VPPM [--iso-validation]
                          -c DBBINARY [DBBINARY ...] -s SAMPLE [SAMPLE ...]
                          -o OUTPUT

Molecular Isotope Mass Identifier

options:
  -h, --help            show this help message and exit
  -p, --ppm PPM         Parts per million for the mono isotopic mass of
                        chemical formula
  -vp VPPM              Parts per million for verification of isotopes
  --iso-validation      Include isotope validation counts in output (adds
                        'iso_valid' column) (default: False)
  -c, --cache DBBINARY [DBBINARY ...]
                        Binary DB input file(s)
  -s, --sample SAMPLE [SAMPLE ...]
                        Input sample file
  -o, --output OUTPUT   Output file
```


## Metadata
- **Skill**: generated
