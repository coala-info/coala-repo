# pyonsite CWL Generation Report

## pyonsite_onsite

### Tool Description
Mass spectrometry post-translational modification localization tool

### Metadata
- **Docker Image**: quay.io/biocontainers/pyonsite:0.0.2--pyhdfd78af_0
- **Homepage**: https://www.github.com/bigbio/onsite
- **Package**: https://anaconda.org/channels/bioconda/packages/pyonsite/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyonsite/overview
- **Total Downloads**: 80
- **Last updated**: 2025-12-26
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: onsite [OPTIONS] COMMAND [ARGS]...

  OnSite: Mass spectrometry post-translational modification localization tool

  Available algorithms:   ascore      AScore algorithm for phosphorylation
  site localization   phosphors   PhosphoRS algorithm for phosphorylation site
  localization   lucxor      LucXor (LuciPHOr2) algorithm for PTM localization
  all         Run all three algorithms and merge results

  Examples:   onsite ascore -in spectra.mzML -id identifications.idXML -out
  results.idXML   onsite phosphors -in spectra.mzML -id identifications.idXML
  -out results.idXML   onsite lucxor -in spectra.mzML -id
  identifications.idXML -out results.idXML   onsite all -in spectra.mzML -id
  identifications.idXML -out results.idXML --add-decoys

Options:
  --version  Show the version and exit.
  --help     Show this message and exit.

Commands:
  all        Run all three algorithms (AScore, PhosphoRS, LucXor) and...
  ascore     Phosphorylation site localization scoring tool using AScore...
  lucxor     Modification site localization using pyLuciPHOr2 algorithm.
  phosphors  Phosphorylation site localization scoring tool using...
```

