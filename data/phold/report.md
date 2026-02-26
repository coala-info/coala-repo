# phold CWL Generation Report

## phold_autotune

### Tool Description
Determines optimal batch size for 3Di prediction with your hardware

### Metadata
- **Docker Image**: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/phold
- **Package**: https://anaconda.org/channels/bioconda/packages/phold/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phold/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2026-01-31
- **GitHub**: https://github.com/gbouras13/phold
- **Stars**: N/A
### Original Help Text
```text
Usage: phold autotune [OPTIONS]

  Determines optimal batch size for 3Di prediction with your hardware

Options:
  -h, --help             Show this message and exit.
  -V, --version          Show the version and exit.
  -i, --input PATH       Optional path to input file of proteins if you do not
                         want to use the default sample of 5000 Phold DB
                         proteins
  --cpu                  Use cpus only.
  -t, --threads INTEGER  Number of threads  [default: 1]
  -d, --database TEXT    Specific path to installed phold database
  --min_batch INTEGER    Minimum batch size to test  [default: 1]
  --step INTEGER         Controls batch size step increment  [default: 10]
  --max_batch INTEGER    Maximum batch size to test  [default: 251]
  --sample_seqs INTEGER  Number of proteins to subsample from input.
                         [default: 500]
```


## phold_citation

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/phold
- **Package**: https://anaconda.org/channels/bioconda/packages/phold/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: phold citation [OPTIONS]
Try 'phold citation --help' for help.

Error: No such option: -h
```


## phold_compare

### Tool Description
Runs Foldseek vs phold db

### Metadata
- **Docker Image**: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/phold
- **Package**: https://anaconda.org/channels/bioconda/packages/phold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phold compare [OPTIONS]

  Runs Foldseek vs phold db

Options:
  -h, --help                    Show this message and exit.
  -V, --version                 Show the version and exit.
  -i, --input PATH              Path to input file in Genbank format or
                                nucleotide FASTA format  [required]
  --predictions_dir PATH        Path to output directory from phold predict
  --structures                  Use if you have .pdb or .cif file structures
                                for the input proteins (e.g. with
                                AF2/Colabfold .pdb or AF3 for .cif) in a
                                directory that you specify with
                                --structure_dir
  --structure_dir PATH          Path to directory with .pdb or .cif file
                                structures. The CDS IDs need to be in the name
                                of the file
  --filter_structures           Flag that creates a copy of the .pdb or .cif
                                files structures with matching record IDs
                                found in the input GenBank file. Helpful if
                                you have a directory with lots of .pdb files
                                and want to annotate only e.g. 1 phage.
  -o, --output PATH             Output directory   [default: output_phold]
  -t, --threads INTEGER         Number of threads  [default: 1]
  -p, --prefix TEXT             Prefix for output files  [default: phold]
  -d, --database TEXT           Specific path to installed phold database
  -f, --force                   Force overwrites the output directory
  -e, --evalue FLOAT            Evalue threshold for Foldseek  [default: 1e-3]
  -s, --sensitivity FLOAT       Sensitivity parameter for foldseek  [default:
                                9.5]
  --keep_tmp_files              Keep temporary intermediate files,
                                particularly the large foldseek_results.tsv of
                                all Foldseek hits
  --card_vfdb_evalue FLOAT      Stricter E-value threshold for Foldseek CARD
                                and VFDB hits  [default: 1e-10]
  --separate                    Output separate GenBank files for each contig
  --max_seqs INTEGER            Maximum results per query sequence allowed to
                                pass the prefilter. You may want to reduce
                                this to save disk space for enormous datasets
                                [default: 1000]
  --ultra_sensitive             Runs phold with maximum sensitivity by
                                skipping Foldseek prefilter. Not recommended
                                for large datasets.
  --extra_foldseek_params TEXT  Extra foldseek search params
  --custom_db TEXT              Path to custom database
  --foldseek_gpu                Use this to enable compatibility with
                                Foldseek-GPU search acceleration
  --restart                     Use this to restart phold from 'Processing
                                Foldseek output' after foldseek_results.tsv is
                                generated
```


## phold_createdb

### Tool Description
Creates foldseek DB from AA FASTA and 3Di FASTA input files

### Metadata
- **Docker Image**: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/phold
- **Package**: https://anaconda.org/channels/bioconda/packages/phold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phold createdb [OPTIONS]

  Creates foldseek DB from AA FASTA and 3Di FASTA input files

Options:
  -h, --help             Show this message and exit.
  -V, --version          Show the version and exit.
  --fasta_aa PATH        Path to input Amino Acid FASTA file of proteins
                         [required]
  --fasta_3di PATH       Path to input 3Di FASTA file of proteins  [required]
  -o, --output PATH      Output directory   [default:
                         output_phold_foldseek_db]
  -t, --threads INTEGER  Number of threads to use with Foldseek  [default: 1]
  -p, --prefix TEXT      Prefix for Foldseek database  [default:
                         phold_foldseek_db]
  -f, --force            Force overwrites the output directory
```


## phold_install

### Tool Description
Installs ProstT5 model and phold database

### Metadata
- **Docker Image**: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/phold
- **Package**: https://anaconda.org/channels/bioconda/packages/phold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phold install [OPTIONS]

  Installs ProstT5 model and phold database

Options:
  -h, --help             Show this message and exit.
  -V, --version          Show the version and exit.
  -d, --database TEXT    Specific path to install the phold database
  --foldseek_gpu         Use this to enable compatibility with Foldseek-GPU
                         acceleration
  --extended_db          Download the extended Phold DB 3.16M including 1.8M
                         efam and enVhog proteins without functional labels
                         instead of the default Phold Search 1.36M. Using the
                         extended database will likely marginally reduce
                         functional annotation sensitivity and increase
                         runtime, but may find more hits overall i.e.
                         including to efam and enVhog proteins that have no
                         functional labels.
  -t, --threads INTEGER  Number of threads  [default: 1]
```


## phold_plot

### Tool Description
Creates Phold Circular Genome Plots

### Metadata
- **Docker Image**: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/phold
- **Package**: https://anaconda.org/channels/bioconda/packages/phold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phold plot [OPTIONS]

  Creates Phold Circular Genome Plots

Options:
  -h, --help                      Show this message and exit.
  -V, --version                   Show the version and exit.
  -i, --input PATH                Path to input file in Genbank format (in the
                                  phold output directory)  [required]
  -o, --output PATH               Output directory to store phold plots
                                  [default: phold_plots]
  -p, --prefix TEXT               Prefix for output files. Needs to match what
                                  phold was run with.  [default: phold]
  -f, --force                     Force overwrites the output directory
  -a, --all                       Plot every contig.
  -t, --plot_title TEXT           Plot title. Only applies if --all is not
                                  specified. Will default to the phage's
                                  contig id.
  --label_hypotheticals           Flag to label hypothetical or unknown
                                  proteins. By default these are not labelled
  --remove_other_features_labels  Flag to remove labels for
                                  tRNA/tmRNA/CRISPRs. By default these are
                                  labelled.  They will still be plotted in
                                  black
  --title_size FLOAT              Controls title size. Must be an integer.
                                  Defaults to 20
  --label_size INTEGER            Controls annotation label size. Must be an
                                  integer. Defaults to 8
  --interval INTEGER              Axis tick interval. Must be an integer. Must
                                  be an integer. Defaults to 5000.
  --truncate INTEGER              Number of characters to include in annoation
                                  labels before truncation with ellipsis.
                                  Must be an integer. Defaults to 20.
  --dpi INTEGER                   Resultion (dots per inch). Must be an
                                  integer. Defaults to 600.
  --annotations FLOAT             Controls the proporition of annotations
                                  labelled. Must be a proportion between 0 and
                                  1 inclusive.  0 = no annotations, 0.5 = half
                                  of the annotations, 1 = all annotations.
                                  Defaults to 1. Chosen in order of CDS size.
  --label_ids TEXT                Text file with list of CDS IDs (from gff
                                  file) that are guaranteed to be labelled.
```


## phold_predict

### Tool Description
Uses ProstT5 to predict 3Di tokens - GPU recommended

### Metadata
- **Docker Image**: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/phold
- **Package**: https://anaconda.org/channels/bioconda/packages/phold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phold predict [OPTIONS]

  Uses ProstT5 to predict 3Di tokens - GPU recommended

Options:
  -h, --help                     Show this message and exit.
  -V, --version                  Show the version and exit.
  -i, --input PATH               Path to input file in Genbank format or
                                 nucleotide FASTA format  [required]
  -o, --output PATH              Output directory   [default: output_phold]
  -t, --threads INTEGER          Number of threads  [default: 1]
  -p, --prefix TEXT              Prefix for output files  [default: phold]
  -d, --database TEXT            Specific path to installed phold database
  -f, --force                    Force overwrites the output directory
  --autotune                     Run autotuning to detect and automatically
                                 use best batch size for your hardware.
                                 Recommended only if you have a large dataset
                                 (e.g. thousands of proteins), or else
                                 autotuning will add rather than save runtime.
  --batch_size INTEGER           batch size for ProstT5.  [default: 1]
  --cpu                          Use cpus only.
  --omit_probs                   Do not output per residue 3Di probabilities
                                 from ProstT5. Mean per protein 3Di
                                 probabilities will always be output.
  --save_per_residue_embeddings  Save the ProstT5 embeddings per resuide in a
                                 h5 file
  --save_per_protein_embeddings  Save the ProstT5 embeddings as means per
                                 protein in a h5 file
  --mask_threshold FLOAT         Masks 3Di residues below this value of
                                 ProstT5 confidence for Foldseek searches
                                 [default: 25]
  --finetune                     Use gbouras13/ProstT5Phold encoder + CNN
                                 model both finetuned on phage proteins
  --vanilla                      Use vanilla CNN model (trained on CASP14)
                                 with ProstT5Phold encoder instead of the one
                                 trained on phage proteins
  --hyps                         Use this to only annotate hypothetical
                                 proteins from a Pharokka GenBank input
```


## phold_proteins-compare

### Tool Description
Runs Foldseek vs phold db on proteins input

### Metadata
- **Docker Image**: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/phold
- **Package**: https://anaconda.org/channels/bioconda/packages/phold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phold proteins-compare [OPTIONS]

  Runs Foldseek vs phold db on proteins input

Options:
  -h, --help                    Show this message and exit.
  -V, --version                 Show the version and exit.
  -i, --input PATH              Path to input file in multiFASTA format
                                [required]
  --predictions_dir PATH        Path to output directory from phold proteins-
                                predict
  --structures                  Use if you have .pdb or .cif file structures
                                for the input proteins (e.g. with
                                AF2/Colabfold) in a directory that you specify
                                with --structure_dir
  --structure_dir PATH          Path to directory with .pdb or .cif file
                                structures. The CDS IDs need to be in the name
                                of the file
  --filter_structures           Flag that creates a copy of the .pdb or .cif
                                files structures with matching record IDs
                                found in the input GenBank file. Helpful if
                                you have a directory with lots of .pdb files
                                and want to annotate only e.g. 1 phage.
  -o, --output PATH             Output directory   [default: output_phold]
  -t, --threads INTEGER         Number of threads  [default: 1]
  -p, --prefix TEXT             Prefix for output files  [default: phold]
  -d, --database TEXT           Specific path to installed phold database
  -f, --force                   Force overwrites the output directory
  -e, --evalue FLOAT            Evalue threshold for Foldseek  [default: 1e-3]
  -s, --sensitivity FLOAT       Sensitivity parameter for foldseek  [default:
                                9.5]
  --keep_tmp_files              Keep temporary intermediate files,
                                particularly the large foldseek_results.tsv of
                                all Foldseek hits
  --card_vfdb_evalue FLOAT      Stricter E-value threshold for Foldseek CARD
                                and VFDB hits  [default: 1e-10]
  --separate                    Output separate GenBank files for each contig
  --max_seqs INTEGER            Maximum results per query sequence allowed to
                                pass the prefilter. You may want to reduce
                                this to save disk space for enormous datasets
                                [default: 1000]
  --ultra_sensitive             Runs phold with maximum sensitivity by
                                skipping Foldseek prefilter. Not recommended
                                for large datasets.
  --extra_foldseek_params TEXT  Extra foldseek search params
  --custom_db TEXT              Path to custom database
  --foldseek_gpu                Use this to enable compatibility with
                                Foldseek-GPU search acceleration
  --restart                     Use this to restart phold from 'Processing
                                Foldseek output' after foldseek_results.tsv is
                                generated
```


## phold_proteins-predict

### Tool Description
Runs ProstT5 on a multiFASTA input - GPU recommended

### Metadata
- **Docker Image**: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/phold
- **Package**: https://anaconda.org/channels/bioconda/packages/phold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phold proteins-predict [OPTIONS]

  Runs ProstT5 on a multiFASTA input - GPU recommended

Options:
  -h, --help                     Show this message and exit.
  -V, --version                  Show the version and exit.
  -i, --input PATH               Path to input multiFASTA file  [required]
  -o, --output PATH              Output directory   [default: output_phold]
  -t, --threads INTEGER          Number of threads  [default: 1]
  -p, --prefix TEXT              Prefix for output files  [default: phold]
  -d, --database TEXT            Specific path to installed phold database
  -f, --force                    Force overwrites the output directory
  --autotune                     Run autotuning to detect and automatically
                                 use best batch size for your hardware.
                                 Recommended only if you have a large dataset
                                 (e.g. thousands of proteins), or else
                                 autotuning will add rather than save runtime.
  --batch_size INTEGER           batch size for ProstT5.  [default: 1]
  --cpu                          Use cpus only.
  --omit_probs                   Do not output per residue 3Di probabilities
                                 from ProstT5. Mean per protein 3Di
                                 probabilities will always be output.
  --save_per_residue_embeddings  Save the ProstT5 embeddings per resuide in a
                                 h5 file
  --save_per_protein_embeddings  Save the ProstT5 embeddings as means per
                                 protein in a h5 file
  --mask_threshold FLOAT         Masks 3Di residues below this value of
                                 ProstT5 confidence for Foldseek searches
                                 [default: 25]
  --finetune                     Use gbouras13/ProstT5Phold encoder + CNN
                                 model both finetuned on phage proteins
  --vanilla                      Use vanilla CNN model (trained on CASP14)
                                 with ProstT5Phold encoder instead of the one
                                 trained on phage proteins
  --hyps                         Use this to only annotate hypothetical
                                 proteins from a Pharokka GenBank input
```


## phold_remote

### Tool Description
Uses Foldseek API to run ProstT5 then Foldseek locally

### Metadata
- **Docker Image**: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/phold
- **Package**: https://anaconda.org/channels/bioconda/packages/phold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phold remote [OPTIONS]

  Uses Foldseek API to run ProstT5 then Foldseek locally

Options:
  -h, --help                    Show this message and exit.
  -V, --version                 Show the version and exit.
  -i, --input PATH              Path to input file in Genbank format or
                                nucleotide FASTA format  [required]
  -o, --output PATH             Output directory   [default: output_phold]
  -t, --threads INTEGER         Number of threads  [default: 1]
  -p, --prefix TEXT             Prefix for output files  [default: phold]
  -d, --database TEXT           Specific path to installed phold database
  -f, --force                   Force overwrites the output directory
  -e, --evalue FLOAT            Evalue threshold for Foldseek  [default: 1e-3]
  -s, --sensitivity FLOAT       Sensitivity parameter for foldseek  [default:
                                9.5]
  --keep_tmp_files              Keep temporary intermediate files,
                                particularly the large foldseek_results.tsv of
                                all Foldseek hits
  --card_vfdb_evalue FLOAT      Stricter E-value threshold for Foldseek CARD
                                and VFDB hits  [default: 1e-10]
  --separate                    Output separate GenBank files for each contig
  --max_seqs INTEGER            Maximum results per query sequence allowed to
                                pass the prefilter. You may want to reduce
                                this to save disk space for enormous datasets
                                [default: 1000]
  --ultra_sensitive             Runs phold with maximum sensitivity by
                                skipping Foldseek prefilter. Not recommended
                                for large datasets.
  --extra_foldseek_params TEXT  Extra foldseek search params
  --custom_db TEXT              Path to custom database
  --foldseek_gpu                Use this to enable compatibility with
                                Foldseek-GPU search acceleration
  --restart                     Use this to restart phold from 'Processing
                                Foldseek output' after foldseek_results.tsv is
                                generated
```


## phold_run

### Tool Description
phold predict then comapare all in one - GPU recommended

### Metadata
- **Docker Image**: quay.io/biocontainers/phold:1.2.2--pyhdfd78af_0
- **Homepage**: https://github.com/gbouras13/phold
- **Package**: https://anaconda.org/channels/bioconda/packages/phold/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phold run [OPTIONS]

  phold predict then comapare all in one - GPU recommended

Options:
  -h, --help                     Show this message and exit.
  -V, --version                  Show the version and exit.
  -i, --input PATH               Path to input file in Genbank format or
                                 nucleotide FASTA format  [required]
  -o, --output PATH              Output directory   [default: output_phold]
  -t, --threads INTEGER          Number of threads  [default: 1]
  -p, --prefix TEXT              Prefix for output files  [default: phold]
  -d, --database TEXT            Specific path to installed phold database
  -f, --force                    Force overwrites the output directory
  --autotune                     Run autotuning to detect and automatically
                                 use best batch size for your hardware.
                                 Recommended only if you have a large dataset
                                 (e.g. thousands of proteins), or else
                                 autotuning will add rather than save runtime.
  --batch_size INTEGER           batch size for ProstT5.  [default: 1]
  --cpu                          Use cpus only.
  --omit_probs                   Do not output per residue 3Di probabilities
                                 from ProstT5. Mean per protein 3Di
                                 probabilities will always be output.
  --save_per_residue_embeddings  Save the ProstT5 embeddings per resuide in a
                                 h5 file
  --save_per_protein_embeddings  Save the ProstT5 embeddings as means per
                                 protein in a h5 file
  --mask_threshold FLOAT         Masks 3Di residues below this value of
                                 ProstT5 confidence for Foldseek searches
                                 [default: 25]
  --finetune                     Use gbouras13/ProstT5Phold encoder + CNN
                                 model both finetuned on phage proteins
  --vanilla                      Use vanilla CNN model (trained on CASP14)
                                 with ProstT5Phold encoder instead of the one
                                 trained on phage proteins
  --hyps                         Use this to only annotate hypothetical
                                 proteins from a Pharokka GenBank input
  -e, --evalue FLOAT             Evalue threshold for Foldseek  [default:
                                 1e-3]
  -s, --sensitivity FLOAT        Sensitivity parameter for foldseek  [default:
                                 9.5]
  --keep_tmp_files               Keep temporary intermediate files,
                                 particularly the large foldseek_results.tsv
                                 of all Foldseek hits
  --card_vfdb_evalue FLOAT       Stricter E-value threshold for Foldseek CARD
                                 and VFDB hits  [default: 1e-10]
  --separate                     Output separate GenBank files for each contig
  --max_seqs INTEGER             Maximum results per query sequence allowed to
                                 pass the prefilter. You may want to reduce
                                 this to save disk space for enormous datasets
                                 [default: 1000]
  --ultra_sensitive              Runs phold with maximum sensitivity by
                                 skipping Foldseek prefilter. Not recommended
                                 for large datasets.
  --extra_foldseek_params TEXT   Extra foldseek search params
  --custom_db TEXT               Path to custom database
  --foldseek_gpu                 Use this to enable compatibility with
                                 Foldseek-GPU search acceleration
  --restart                      Use this to restart phold from 'Processing
                                 Foldseek output' after foldseek_results.tsv
                                 is generated
```

