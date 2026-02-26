# defense-finder CWL Generation Report

## defense-finder_run

### Tool Description
Search for all known anti-phage defense systems in the target fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/defense-finder:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mdmparis/defense-finder
- **Package**: https://anaconda.org/channels/bioconda/packages/defense-finder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/defense-finder/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-06-16
- **GitHub**: https://github.com/mdmparis/defense-finder
- **Stars**: N/A
### Original Help Text
```text
Usage: defense-finder run [OPTIONS] FILE

  Search for all known anti-phage defense systems in the target fasta file.

Options:
  -o, --out-dir TEXT            The target directory where to store the
                                results. Defaults to the current directory.
  -w, --workers INTEGER         The workers count. By default all cores will
                                be used (w=0).
  -c, --coverage FLOAT          Minimal percentage of coverage for each
                                profiles. By default set to 0.4
  --db-type TEXT                The macsyfinder --db-type option. Run
                                macsyfinder --help for more details. Possible
                                values are               ordered_replicon,
                                gembase, unordered, defaults to
                                ordered_replicon.
  --preserve-raw                Preserve raw MacsyFinder outputs alongside
                                Defense Finder results inside the output
                                directory.
  --models-dir TEXT             Specify a directory containing your models.
  --no-cut-ga                   Advanced! Run macsyfinder in no-cut-ga mode.
                                The validity of the genes and systems found is
                                not guaranteed!
  -a, --antidefensefinder       Also run AntiDefenseFinder models to find
                                antidefense systems.
  -A, --antidefensefinder-only  Run only AntiDefenseFinder for antidefense
                                system and not DefenseFinder
  --log-level TEXT              set the logging level among DEBUG, [INFO],
                                WARNING, ERROR, CRITICAL
  --index-dir TEXT              Specify a directory to write the index files
                                required by macsyfinder when the input file is
                                in a read-only folder
  --skip-model-version-check    Skip model version check
  -h, --help                    Show this message and exit.
```


## defense-finder_update

### Tool Description
Fetches the latest defense finder models.

### Metadata
- **Docker Image**: quay.io/biocontainers/defense-finder:2.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mdmparis/defense-finder
- **Package**: https://anaconda.org/channels/bioconda/packages/defense-finder/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: defense-finder update [OPTIONS]

  Fetches the latest defense finder models.

  The models will be downloaded from mdmparis repositories and installed on
  macsydata.

  This will make them available to macsyfinder and ultimately to defense-
  finder.

  Models repository: https://github.com/mdmparis/defense-finder-models.

Options:
  --models-dir TEXT      Specify a directory containing your models.
  -f, --force-reinstall  Force update even if models in already there.
  -h, --help             Show this message and exit.
```

