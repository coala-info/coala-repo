# mimi CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mimi_mimi_cache_create | PASS | KEGG compound list built into natural and 95% C13-labelled caches; rewrote CWL from help |
| mimi_mimi_cache_dump | PASS | dump of a real cache shows metadata and compounds |
| mimi_mimi_hmdb_extract | Not completed | needs the full HMDB metabolites XML (several GB); no small real sample available |
| mimi_mimi_kegg_extract | Failed | image problem: the program fails at start with ModuleNotFoundError: No module named 'requests' |
| mimi_mimi_mass_analysis | PASS | real FT-ICR peak list matched to both caches; masses check out (prednisolone [M-H]- 359.1864, C13 shift correct); the CWL strips .pkl because the tool adds it |

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

## mimi_mimi_cache_dump

### Tool Description
MIMI cache dump tool

### Metadata
- **Docker Image**: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/NYUAD-Core-Bioinformatics/MIMI
- **Package**: https://anaconda.org/channels/bioconda/packages/mimi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mimi_cache_dump [-h] [-n NUM_COMPOUNDS] [-i NUM_ISOTOPES] [-o OUTPUT]
                       cache_file

MIMI Cache Dump Tool

positional arguments:
  cache_file            Input cache file (.pkl)

options:
  -h, --help            show this help message and exit
  -n, --num-compounds NUM_COMPOUNDS
                        Number of compounds to output (default: all)
  -i, --num-isotopes NUM_ISOTOPES
                        Number of isotopes per compound to output (default:
                        all)
  -o, --output OUTPUT   Output file (default: stdout)
```

## mimi_mimi_kegg_extract

### Tool Description
Extract compound information from KEGG within a mass range

### Metadata
- **Docker Image**: quay.io/biocontainers/mimi:1.0.4--pyhdfd78af_0
- **Homepage**: https://github.com/NYUAD-Core-Bioinformatics/MIMI
- **Package**: https://anaconda.org/channels/bioconda/packages/mimi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mimi_kegg_extract [-h] [-l MIN_MASS] [-u MAX_MASS] [-i COMPOUND_IDS]
                         [-o OUTPUT] [-b BATCH_SIZE]

options:
  -h, --help            show this help message and exit
  -l, --min-mass MIN_MASS
                        Lower bound of molecular weight in Da
  -u, --max-mass MAX_MASS
                        Upper bound of molecular weight in Da
  -i, --input COMPOUND_IDS
                        Input TSV file containing KEGG compound IDs
  -o, --output OUTPUT   Output TSV file path (default: kegg_compounds.tsv)
  -b, --batch-size BATCH_SIZE
                        Number of compounds to process in each batch (default: 5)
(help reconstructed from the argparse calls in mimi/kegg.py because the program fails to import in the image)
```

## Metadata
- **Skill**: generated
