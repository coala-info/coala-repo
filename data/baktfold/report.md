# baktfold CWL Generation Report

## baktfold_citation

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/baktfold:0.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/baktfold
- **Package**: https://anaconda.org/channels/bioconda/packages/baktfold/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/baktfold/overview
- **Total Downloads**: 124
- **Last updated**: 2025-11-17
- **GitHub**: https://github.com/gbouras13/baktfold
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: baktfold citation [OPTIONS]
Try 'baktfold citation --help' for help.

Error: No such option: --h Did you mean --help?
```


## baktfold_compare

### Tool Description
Runs Foldseek vs baktfold db

### Metadata
- **Docker Image**: quay.io/biocontainers/baktfold:0.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/baktfold
- **Package**: https://anaconda.org/channels/bioconda/packages/baktfold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: baktfold compare [OPTIONS]

  Runs Foldseek vs baktfold db

Options:
  -h, --help                    Show this message and exit.
  -V, --version                 Show the version and exit.
  -i, --input PATH              Path to input file in Genbank format or
                                nucleotide FASTA format  [required]
  --predictions-dir PATH        Path to output directory from baktfold predict
  --structure-dir PATH          Path to directory with .pdb or .cif file
                                structures. The IDs need to be in the name of
                                the file i.e id.pdb or id.cif
  -o, --output PATH             Output directory   [default: output_baktfold]
  -t, --threads INTEGER         Number of threads  [default: 1]
  -p, --prefix TEXT             Prefix for output files  [default: baktfold]
  -d, --database TEXT           Specific path to installed baktfold database
  -f, --force                   Force overwrites the output directory
  -e, --evalue FLOAT            Evalue threshold for Foldseek  [default: 1e-3]
  -s, --sensitivity FLOAT       Sensitivity parameter for foldseek  [default:
                                9.5]
  --keep-tmp-files              Keep temporary intermediate files,
                                particularly the large foldseek_results.tsv of
                                all Foldseek hits
  --max-seqs INTEGER            Maximum results per query sequence allowed to
                                pass the prefilter. You may want to reduce
                                this to save disk space for enormous datasets
                                [default: 1000]
  --ultra-sensitive             Runs baktfold with maximum sensitivity by
                                skipping Foldseek prefilter. Not recommended
                                for large datasets.
  --extra-foldseek-params TEXT  Extra foldseek search params
  --custom-db TEXT              Path to custom database
  --foldseek-gpu                Use this to enable compatibility with
                                Foldseek-GPU search acceleration
  --custom-annotations PATH     Custom Foldseek DB annotations, 2 column tsv.
                                Column 1 matches the Foldseek headers, column
                                2 is the description.
  -a, --all-proteins            annotate all proteins (not just hypotheticals)
```


## baktfold_install

### Tool Description
Installs ProstT5 model and baktfold database

### Metadata
- **Docker Image**: quay.io/biocontainers/baktfold:0.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/baktfold
- **Package**: https://anaconda.org/channels/bioconda/packages/baktfold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: baktfold install [OPTIONS]

  Installs ProstT5 model and baktfold database

Options:
  -h, --help             Show this message and exit.
  -V, --version          Show the version and exit.
  -d, --database TEXT    Specific path to install the baktfold database
  --foldseek-gpu         Use this to enable compatibility with Foldseek-GPU
                         acceleration
  -t, --threads INTEGER  Number of threads  [default: 1]
```


## baktfold_predict

### Tool Description
Uses ProstT5 to predict 3Di tokens - GPU recommended

### Metadata
- **Docker Image**: quay.io/biocontainers/baktfold:0.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/baktfold
- **Package**: https://anaconda.org/channels/bioconda/packages/baktfold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: baktfold predict [OPTIONS]

  Uses ProstT5 to predict 3Di tokens - GPU recommended

Options:
  -h, --help                     Show this message and exit.
  -V, --version                  Show the version and exit.
  -i, --input PATH               Path to input file in Genbank format or
                                 nucleotide FASTA format  [required]
  -o, --output PATH              Output directory   [default: output_baktfold]
  -t, --threads INTEGER          Number of threads  [default: 1]
  -p, --prefix TEXT              Prefix for output files  [default: baktfold]
  -d, --database TEXT            Specific path to installed baktfold database
  -f, --force                    Force overwrites the output directory
  --batch-size INTEGER           batch size for ProstT5. 1 is usually fastest.
                                 [default: 1]
  --cpu                          Use cpus only.
  --omit-probs                   Do not output per residue 3Di probabilities
                                 from ProstT5. Mean per protein 3Di
                                 probabilities will always be output.
  --save-per-residue-embeddings  Save the ProstT5 embeddings per resuide in a
                                 h5 file
  --save-per-protein-embeddings  Save the ProstT5 embeddings as means per
                                 protein in a h5 file
  --mask-threshold FLOAT         Masks 3Di residues below this value of
                                 ProstT5 confidence for Foldseek searches
                                 [default: 25]
  -a, --all-proteins             annotate all proteins (not just
                                 hypotheticals)
```


## baktfold_proteins

### Tool Description
baktfold proteins-predict then comapare all in one - GPU recommended

### Metadata
- **Docker Image**: quay.io/biocontainers/baktfold:0.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/baktfold
- **Package**: https://anaconda.org/channels/bioconda/packages/baktfold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: baktfold proteins [OPTIONS]

  baktfold proteins-predict then comapare all in one - GPU recommended

Options:
  -h, --help                     Show this message and exit.
  -V, --version                  Show the version and exit.
  -i, --input PATH               Path to input file in amino acid FASTA format
                                 [required]
  -o, --output PATH              Output directory   [default: output_baktfold]
  -t, --threads INTEGER          Number of threads  [default: 1]
  -p, --prefix TEXT              Prefix for output files  [default: baktfold]
  -d, --database TEXT            Specific path to installed baktfold database
  -f, --force                    Force overwrites the output directory
  --batch-size INTEGER           batch size for ProstT5. 1 is usually fastest.
                                 [default: 1]
  --cpu                          Use cpus only.
  --omit-probs                   Do not output per residue 3Di probabilities
                                 from ProstT5. Mean per protein 3Di
                                 probabilities will always be output.
  --save-per-residue-embeddings  Save the ProstT5 embeddings per resuide in a
                                 h5 file
  --save-per-protein-embeddings  Save the ProstT5 embeddings as means per
                                 protein in a h5 file
  --mask-threshold FLOAT         Masks 3Di residues below this value of
                                 ProstT5 confidence for Foldseek searches
                                 [default: 25]
  -e, --evalue FLOAT             Evalue threshold for Foldseek  [default:
                                 1e-3]
  -s, --sensitivity FLOAT        Sensitivity parameter for foldseek  [default:
                                 9.5]
  --keep-tmp-files               Keep temporary intermediate files,
                                 particularly the large foldseek_results.tsv
                                 of all Foldseek hits
  --max-seqs INTEGER             Maximum results per query sequence allowed to
                                 pass the prefilter. You may want to reduce
                                 this to save disk space for enormous datasets
                                 [default: 1000]
  --ultra-sensitive              Runs baktfold with maximum sensitivity by
                                 skipping Foldseek prefilter. Not recommended
                                 for large datasets.
  --extra-foldseek-params TEXT   Extra foldseek search params
  --custom-db TEXT               Path to custom database
  --foldseek-gpu                 Use this to enable compatibility with
                                 Foldseek-GPU search acceleration
  --custom-annotations PATH      Custom Foldseek DB annotations, 2 column tsv.
                                 Column 1 matches the Foldseek headers, column
                                 2 is the description.
```


## baktfold_proteins-compare

### Tool Description
Runs Foldseek vs baktfold db on proteins input

### Metadata
- **Docker Image**: quay.io/biocontainers/baktfold:0.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/baktfold
- **Package**: https://anaconda.org/channels/bioconda/packages/baktfold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: baktfold proteins-compare [OPTIONS]

  Runs Foldseek vs baktfold db on proteins input

Options:
  -h, --help                    Show this message and exit.
  -V, --version                 Show the version and exit.
  -i, --input PATH              Path to input file in multiFASTA format
                                [required]
  --predictions-dir PATH        Path to output directory from baktfold
                                proteins-predict
  --structure-dir PATH          Path to directory with .pdb or .cif file
                                structures. The CDS IDs need to be in the name
                                of the file
  -o, --output PATH             Output directory   [default: output_baktfold]
  -t, --threads INTEGER         Number of threads  [default: 1]
  -p, --prefix TEXT             Prefix for output files  [default: baktfold]
  -d, --database TEXT           Specific path to installed baktfold database
  -f, --force                   Force overwrites the output directory
  -e, --evalue FLOAT            Evalue threshold for Foldseek  [default: 1e-3]
  -s, --sensitivity FLOAT       Sensitivity parameter for foldseek  [default:
                                9.5]
  --keep-tmp-files              Keep temporary intermediate files,
                                particularly the large foldseek_results.tsv of
                                all Foldseek hits
  --max-seqs INTEGER            Maximum results per query sequence allowed to
                                pass the prefilter. You may want to reduce
                                this to save disk space for enormous datasets
                                [default: 1000]
  --ultra-sensitive             Runs baktfold with maximum sensitivity by
                                skipping Foldseek prefilter. Not recommended
                                for large datasets.
  --extra-foldseek-params TEXT  Extra foldseek search params
  --custom-db TEXT              Path to custom database
  --foldseek-gpu                Use this to enable compatibility with
                                Foldseek-GPU search acceleration
  --custom-annotations PATH     Custom Foldseek DB annotations, 2 column tsv.
                                Column 1 matches the Foldseek headers, column
                                2 is the description.
```


## baktfold_proteins-predict

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/baktfold:0.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/baktfold
- **Package**: https://anaconda.org/channels/bioconda/packages/baktfold/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: baktfold proteins-predict [OPTIONS]

Error: No such option: --h Did you mean --help?
```


## baktfold_run

### Tool Description
baktfold predict then comapare all in one - GPU recommended

### Metadata
- **Docker Image**: quay.io/biocontainers/baktfold:0.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/baktfold
- **Package**: https://anaconda.org/channels/bioconda/packages/baktfold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: baktfold run [OPTIONS]

  baktfold predict then comapare all in one - GPU recommended

Options:
  -h, --help                     Show this message and exit.
  -V, --version                  Show the version and exit.
  -i, --input PATH               Path to input file in Bakta Genbank format or
                                 Bakta JSON format  [required]
  -o, --output PATH              Output directory   [default: output_baktfold]
  -t, --threads INTEGER          Number of threads  [default: 1]
  -p, --prefix TEXT              Prefix for output files  [default: baktfold]
  -d, --database TEXT            Specific path to installed baktfold database
  -f, --force                    Force overwrites the output directory
  --batch-size INTEGER           batch size for ProstT5. 1 is usually fastest.
                                 [default: 1]
  --cpu                          Use cpus only.
  --omit-probs                   Do not output per residue 3Di probabilities
                                 from ProstT5. Mean per protein 3Di
                                 probabilities will always be output.
  --save-per-residue-embeddings  Save the ProstT5 embeddings per resuide in a
                                 h5 file
  --save-per-protein-embeddings  Save the ProstT5 embeddings as means per
                                 protein in a h5 file
  --mask-threshold FLOAT         Masks 3Di residues below this value of
                                 ProstT5 confidence for Foldseek searches
                                 [default: 25]
  -e, --evalue FLOAT             Evalue threshold for Foldseek  [default:
                                 1e-3]
  -s, --sensitivity FLOAT        Sensitivity parameter for foldseek  [default:
                                 9.5]
  --keep-tmp-files               Keep temporary intermediate files,
                                 particularly the large foldseek_results.tsv
                                 of all Foldseek hits
  --max-seqs INTEGER             Maximum results per query sequence allowed to
                                 pass the prefilter. You may want to reduce
                                 this to save disk space for enormous datasets
                                 [default: 1000]
  --ultra-sensitive              Runs baktfold with maximum sensitivity by
                                 skipping Foldseek prefilter. Not recommended
                                 for large datasets.
  --extra-foldseek-params TEXT   Extra foldseek search params
  --custom-db TEXT               Path to custom database
  --foldseek-gpu                 Use this to enable compatibility with
                                 Foldseek-GPU search acceleration
  --custom-annotations PATH      Custom Foldseek DB annotations, 2 column tsv.
                                 Column 1 matches the Foldseek headers, column
                                 2 is the description.
  -a, --all-proteins             annotate all proteins (not just
                                 hypotheticals)
```

