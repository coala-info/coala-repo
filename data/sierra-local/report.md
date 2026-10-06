# sierra-local CWL Generation Report

## sierra-local_sierralocal

### Tool Description
Local execution of Stanford HIVdb algorithm for mutation-based resistance scoring of sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/sierra-local:0.4.3--py310hdfd78af_0
- **Homepage**: https://github.com/PoonLab/sierra-local
- **Package**: https://anaconda.org/channels/bioconda/packages/sierra-local/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sierra-local/overview
- **Total Downloads**: 170
- **Last updated**: 2025-09-10
- **GitHub**: https://github.com/PoonLab/sierra-local
- **Stars**: N/A
### Original Help Text
```text
usage: sierralocal [-h] [-o OUTFILE] [-xml XML] [-json JSON] [--cleanup]
                   [--forceupdate] [-alignment {post,nuc}]
                   [-apobec_csv APOBEC_CSV] [-unusual_csv UNUSUAL_CSV]
                   [-sdrms_csv SDRMS_CSV] [-mutation_csv MUTATION_CSV]
                   [-updater_outdir UPDATER_OUTDIR]
                   fasta [fasta ...]

Local execution of Stanford HIVdb algorithm for mutation-based resistance
scoring of sequences.

positional arguments:
  fasta                 List of input files.

options:
  -h, --help            show this help message and exit
  -o OUTFILE            Output filename.
  -xml XML              <optional> Path to HIVdb ASI2 XML file (default:
                        HIVDB_9.4.xml)
  -json JSON            <optional> Path to JSON HIVdb APOBEC DRM file
  --cleanup             Deletes NucAmino alignment file after processing.
  --forceupdate         Forces update of HIVdb algorithm. Requires network
                        connection.
  -alignment {post,nuc}
                        Alignment program to use, "post" for post align and
                        "nuc" for nucamino
  -apobec_csv APOBEC_CSV
                        <optional> Path to CSV APOBEC csv file (default:
                        apobecs.csv)
  -unusual_csv UNUSUAL_CSV
                        <optional> Path to CSV file to determine if is unusual
                        (default: rx-all_subtype-all.csv)
  -sdrms_csv SDRMS_CSV  <optional> Path to CSV file to determine SDRM
                        mutations (default: sdrms_hiv1.csv)
  -mutation_csv MUTATION_CSV
                        <optional> Path to CSV file to determine mutation type
                        (default: mutation-type-pairs_hiv1.csv)
  -updater_outdir UPDATER_OUTDIR
                        <optional> Path to folder to store updated files from
                        updater (default: sierralocal/data folder))
```

