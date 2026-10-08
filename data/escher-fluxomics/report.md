# escher-fluxomics CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| escher-fluxomics_best_fit_fluxes2escher_fluxes_csv | Failed | image problem: the image entrypoint is create_site_for_data, so any other command is passed to it as arguments and this script never runs |
| escher-fluxomics_create_site_for_data | PASS | New file for the real script (it relies on the image entrypoint); built an Escher site from a real Escher map and iso2flux flux data. |

## escher-fluxomics_create_site_for_data

### Tool Description
Creates an Escher web site folder that shows a metabolic map with reaction data.

### Metadata
- **Docker Image**: biocontainers/escher-fluxomics:phenomenal-v1.6.0-beta.4_cv1.1.20
- **Homepage**: https://escher.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/escher-fluxomics/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: create_site_for_data OUTPUTDIR MAP_FILE RXN_DATA_CSV

Copies the Escher template site to OUTPUTDIR, the map to OUTPUTDIR/metabolic_map.json
and the reaction data to OUTPUTDIR/rxn_data.csv. (The tool has no help option; this
usage is taken from the script in the image.)
```

## escher-fluxomics_best_fit_fluxes2escher_fluxes_csv

### Tool Description
Converts an iso2flux best-fit fluxes CSV into the ID,Avg CSV used by Escher.

### Metadata
- **Docker Image**: biocontainers/escher-fluxomics:phenomenal-v1.6.0-beta.4_cv1.1.20
- **Homepage**: https://escher.github.io
- **Package**: https://anaconda.org/channels/bioconda/packages/escher-fluxomics/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: best_fit_fluxes2escher_fluxes_csv INPUT_CSV OUTPUT_CSV

Converts an iso2flux best-fit fluxes CSV file (0.2, 0.6.1 or 0.7) into a CSV file with
the columns ID,Avg. (The tool has no help option; this usage is taken from the script in the image.)
```

## Metadata
- **Skill**: generated
