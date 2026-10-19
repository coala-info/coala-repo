# pyonsite CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pyonsite_all | Not completed | LucXor step needs at least 50 high-scoring phospho PSMs; the small real data sets (OpenMS LuciPHOr2 test, bigbio onsite rep1) have fewer and the all command has no option to lower it |
| pyonsite_ascore | PASS | ran on OpenMS LuciPHOr2 test mzML and idXML (8 phospho PSMs); AScore scores written; note --threads 2 hangs |
| pyonsite_lucxor | PASS | ran on OpenMS LuciPHOr2 test mzML and idXML with min-num-psms-model 2 and modeling-score-threshold 0; LuciPHOr2 scores and FLR written |
| pyonsite_phosphors | PASS | ran on OpenMS LuciPHOr2 test mzML and idXML (8 phospho PSMs); PhosphoRS scores written; note --threads 2 hangs |

## pyonsite_ascore

### Tool Description
Phosphorylation site localization scoring tool using AScore algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyonsite:0.0.2--pyhdfd78af_0
- **Homepage**: https://www.github.com/bigbio/onsite
- **Package**: https://anaconda.org/channels/bioconda/packages/pyonsite/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: onsite ascore [OPTIONS]

  Phosphorylation site localization scoring tool using AScore algorithm.

  This tool processes MS/MS spectra and peptide identifications to localize
  phosphorylation sites using the AScore algorithm.

Options:
  -in, --in-file PATH             Input mzML file path  [required]
  -id, --id-file PATH             Input idXML file path  [required]
  -out, --out-file PATH           Output idXML file path  [required]
  --fragment-mass-tolerance FLOAT
                                  Fragment mass tolerance value (default:
                                  0.05)
  --fragment-mass-unit [Da|ppm]   Tolerance unit (default: Da)
  --threads INTEGER               Number of parallel threads (default: 1)
  --debug                         Enable debug output and write debug log
  --add-decoys                    Include A (PhosphoDecoy) as potential
                                  phosphorylation site
  --compute-all-scores            Run all three algorithms (AScore, PhosphoRS,
                                  LucXor) and merge results
  --help                          Show this message and exit.
```

## pyonsite_phosphors

### Tool Description
Phosphorylation site localization scoring tool using PhosphoRS algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyonsite:0.0.2--pyhdfd78af_0
- **Homepage**: https://www.github.com/bigbio/onsite
- **Package**: https://anaconda.org/channels/bioconda/packages/pyonsite/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: onsite phosphors [OPTIONS]

  Phosphorylation site localization scoring tool using PhosphoRS algorithm.

  This tool processes MS/MS spectra and peptide identifications to localize
  phosphorylation sites using the PhosphoRS algorithm.

Options:
  -in, --in-file PATH             Input mzML file path  [required]
  -id, --id-file PATH             Input idXML file path  [required]
  -out, --out-file PATH           Output idXML file path  [required]
  --fragment-mass-tolerance FLOAT
                                  Fragment mass tolerance value (default:
                                  0.05)
  --fragment-mass-unit [Da|ppm]   Tolerance unit (default: Da)
  --threads INTEGER               Number of parallel processes (default: 1)
  --debug                         Enable debug output and write debug log
  --add-decoys                    Include A (PhosphoDecoy) as potential
                                  phosphorylation site
  --compute-all-scores            Run all three algorithms (AScore, PhosphoRS,
                                  LucXor) and merge results
  --help                          Show this message and exit.
```

## pyonsite_lucxor

### Tool Description
Modification site localization using pyLuciPHOr2 algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyonsite:0.0.2--pyhdfd78af_0
- **Homepage**: https://www.github.com/bigbio/onsite
- **Package**: https://anaconda.org/channels/bioconda/packages/pyonsite/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: onsite lucxor [OPTIONS]

  Modification site localization using pyLuciPHOr2 algorithm.

  This tool processes MS/MS spectra and peptide identifications to localize
  post-translational modifications using the LuciPHOr2 algorithm with false
  localization rate (FLR) calculation.

Options:
  -in, --input-spectrum PATH      Input spectrum file (mzML)  [required]
  -id, --input-id PATH            Input identification file (idXML)
                                  [required]
  -out, --output PATH             Output file (idXML)  [required]
  --fragment-method [cid|hcd]     Fragmentation method (default: CID)
  --fragment-mass-tolerance FLOAT
                                  Tolerance of the peaks in the fragment
                                  spectrum (default: 0.5)
  --fragment-error-units [da|ppm]
                                  Unit of fragment mass tolerance (default:
                                  Da)
  --min-mz FLOAT                  Do not consider peaks below this value
                                  (default: 150.0)
  --target-modifications TEXT     List of target modifications (default:
                                  Phospho (S), Phospho (T), Phospho (Y))
  --neutral-losses TEXT           List of neutral losses (default: sty -H3PO4
                                  -97.97690)
  --decoy-mass FLOAT              Mass to add for decoy generation (default:
                                  79.966331)
  --decoy-neutral-losses TEXT     List of decoy neutral losses (default: X
                                  -H3PO4 -97.97690)
  --max-charge-state INTEGER      Maximum charge state to consider (default:
                                  5)
  --max-peptide-length INTEGER    Maximum peptide length (default: 40)
  --max-num-perm INTEGER          Maximum number of permutations (default:
                                  16384)
  --modeling-score-threshold FLOAT
                                  Minimum score for modeling (default: 0.95)
  --scoring-threshold FLOAT       Minimum score threshold (default: 0.0)
  --min-num-psms-model INTEGER    Minimum number of PSMs for modeling
                                  (default: 50)
  --threads INTEGER               Number of threads to use (default: 1)
  --rt-tolerance FLOAT            Retention time tolerance (default: 0.01)
  --debug                         Enable debug mode
  --log-file TEXT                 Log file path (only used in debug mode,
                                  default: {output_base}_debug.log)
  --disable-split-by-charge       Disable splitting PSMs by charge state for
                                  model training (train a single global model)
  --compute-all-scores            Run all three algorithms (AScore, PhosphoRS,
                                  LucXor) and merge results
  --help                          Show this message and exit.
```

## pyonsite_all

### Tool Description
Run all three algorithms (AScore, PhosphoRS, LucXor) and merge results.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyonsite:0.0.2--pyhdfd78af_0
- **Homepage**: https://www.github.com/bigbio/onsite
- **Package**: https://anaconda.org/channels/bioconda/packages/pyonsite/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: onsite all [OPTIONS]

  Run all three algorithms (AScore, PhosphoRS, LucXor) and merge results.

  This command runs all three phosphorylation site localization algorithms
  sequentially and merges their scores and site assignments into a single
  output file. Each algorithm's specific scores and metadata are preserved.

  When --add-decoys is specified: - AScore and PhosphoRS: Include A
  (PhosphoDecoy) as potential site - LucXor: Use target modifications
  "Phospho(S), Phospho(T), Phospho(Y), PhosphoDecoy(A)"

Options:
  -in, --in-file PATH             Input mzML file path  [required]
  -id, --id-file PATH             Input idXML file path  [required]
  -out, --out-file PATH           Output idXML file path  [required]
  --fragment-mass-tolerance FLOAT
                                  Fragment mass tolerance value (default:
                                  0.05)
  --fragment-mass-unit [Da|ppm]   Tolerance unit (default: Da)
  --threads INTEGER               Number of parallel threads (default: 1)
  --debug                         Enable debug output and write debug log
  --add-decoys                    Include A (PhosphoDecoy) as potential
                                  phosphorylation site for all algorithms
  --help                          Show this message and exit.
```
