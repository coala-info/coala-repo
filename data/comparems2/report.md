# comparems2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| comparems2_compareMS2 | PASS |  |

## Metadata
- **Skill**: generated

## comparems2_compareMS2

### Tool Description
compareMS2 is developed to compare, globally, all MS/MS spectra between two datasets (in Mascot Generic Format or MGF) acquired under similar conditions. This may be useful for differentiating samples or molecular phylogenetics based on shared peptide sequences quantified by the number or frequency of highly similar tandem mass spectra.

### Metadata
- **Docker Image**: quay.io/biocontainers/comparems2:1--h7b50bb2_7
- **Homepage**: http://www.ms-utils.org/compareMS2.html
- **Package**: https://anaconda.org/channels/bioconda/packages/comparems2/overview
- **Validation**: PASS
### Original Help Text
```text
compareMS2 - (c) Magnus Palmblad 2010-

compareMS2 is developed to compare, globally, all MS/MS spectra between two datasets (in Mascot Generic Format or MGF) acquired under similar conditions. This may be useful for differentiating samples or molecular phylogenetics based on shared peptide sequences quantified by the number or frequency of highly similar tandem mass spectra. The similarity between a pair of tandem mass spectra is calculated essentially as in SpectraST [see Lam et al. Proteomics 2007, 7, 655-667 (2007)].

usage: compareMS2 -1 <first dataset filename> -2 <second dataset filename> [-o <output filename> -p <maximum difference in precursor mass>]
```

