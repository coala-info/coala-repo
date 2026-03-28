# pypgatk CWL Generation Report

## pypgatk_blast_get_position

### Tool Description
Get the position of peptides in a reference database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Total Downloads**: 41.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bigbio/py-pgatk
- **Stars**: N/A
### Original Help Text
```text
Usage: pypgatk blast_get_position [OPTIONS]

Options:
  -c, --config_file TEXT          Configuration file for the fdr peptides
                                  pipeline.
  -i, --input_psm_to_blast TEXT   The file name of the input PSM table to
                                  blast.
  -o, --output_psm TEXT           The file name of the output PSM table.
  -r, --input_reference_database TEXT
                                  The file name of the refence protein
                                  database to blast. The reference database
                                  includes Uniprot Proteomes with isoforms,
                                  ENSEMBL, RefSeq, etc.
  -n, --number_of_processes TEXT  Used to specify the number of processes.
                                  Default is 40.
  -h, --help                      Show this message and exit.
```


## pypgatk_variation

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/lib/python3.9/site-packages/Bio/pairwise2.py:278: BiopythonDeprecationWarning: Bio.pairwise2 has been deprecated, and we intend to remove it in a future release of Biopython. As an alternative, please consider using Bio.Align.PairwiseAligner as a replacement, and contact the Biopython developers if you still need the Bio.pairwise2 module.
  warnings.warn(
Usage: pypgatk [OPTIONS] COMMAND [ARGS]...
Try 'pypgatk -h' for help.

Error: No such command 'variation'.
```


## pypgatk_cbioportal-downloader

### Tool Description
Download data from cBioPortal

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pypgatk cbioportal-downloader [OPTIONS]

Options:
  -c, --config_file TEXT       Configuration file for the ensembl data
                               downloader pipeline
  -o, --output_directory TEXT  Output directory for the peptide databases
  -l, --list_studies           Print the list of all the studies in cBioPortal
                               (https://www.cbioportal.org)
  -d, --download_study TEXT    Download a specific Study from cBioPortal --
                               (all to download all studies)
  -th, --multithreading        Enable multithreading to download multiple
                               files ad the same time
  --url_file TEXT              Add the url to a downloaded file
  -h, --help                   Show this message and exit.
```


## pypgatk_cbioportal-to-proteindb

### Tool Description
Configuration for cbioportal to proteindb tool

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pypgatk cbioportal-to-proteindb [OPTIONS]

Options:
  -c, --config_file TEXT          Configuration for cbioportal to proteindb
                                  tool
  -in, --input_mutation TEXT      Cbioportal mutation file
  -fa, --input_cds TEXT           CDS genes from ENSEMBL database
  -out, --output_db TEXT          Protein database including all the mutations
  -f, --filter_column TEXT        Column in the VCF file to be used for
                                  filtering or splitting mutations
  -a, --accepted_values TEXT      Limit mutations to values (tissue type,
                                  sample name, etc) considered for generating
                                  proteinDBs, by default mutations from all
                                  records are considered (e.g. "")
  -s, --split_by_filter_column    Use this flag to generate a proteinDB per
                                  group as specified in the filter_column,
                                  default is False
  -cl, --clinical_sample_file TEXT
                                  File to get tissue type from for the samples
                                  in input_mutation file
  -h, --help                      Show this message and exit.
```


## pypgatk_proteindb

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/lib/python3.9/site-packages/Bio/pairwise2.py:278: BiopythonDeprecationWarning: Bio.pairwise2 has been deprecated, and we intend to remove it in a future release of Biopython. As an alternative, please consider using Bio.Align.PairwiseAligner as a replacement, and contact the Biopython developers if you still need the Bio.pairwise2 module.
  warnings.warn(
Usage: pypgatk [OPTIONS] COMMAND [ARGS]...
Try 'pypgatk -h' for help.

Error: No such command 'proteindb'.
```


## pypgatk_cosmic-downloader

### Tool Description
Download mutation data from COSMIC

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/lib/python3.9/site-packages/Bio/pairwise2.py:278: BiopythonDeprecationWarning: Bio.pairwise2 has been deprecated, and we intend to remove it in a future release of Biopython. As an alternative, please consider using Bio.Align.PairwiseAligner as a replacement, and contact the Biopython developers if you still need the Bio.pairwise2 module.
  warnings.warn(
Traceback (most recent call last):
  File "/usr/local/bin/pypgatk", line 10, in <module>
    sys.exit(main())
  File "/usr/local/lib/python3.9/site-packages/pypgatk/pypgatk_cli.py", line 55, in main
    cli()
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1157, in __call__
    return self.main(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1078, in main
    rv = self.invoke(ctx)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1688, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 1434, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/usr/local/lib/python3.9/site-packages/click/core.py", line 783, in invoke
    return __callback(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/click/decorators.py", line 33, in new_func
    return f(get_current_context(), *args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/pypgatk/commands/cosmic_downloader.py", line 37, in cosmic_downloader
    cosmic_downloader_service.download_mutation_file(url_file_name=url_file)
  File "/usr/local/lib/python3.9/site-packages/pypgatk/cgenomes/cosmic_downloader.py", line 116, in download_mutation_file
    self.download_file_cosmic(mutation_url, mutation_output_file, token)
  File "/usr/local/lib/python3.9/site-packages/pypgatk/cgenomes/cosmic_downloader.py", line 141, in download_file_cosmic
    url = json.loads(response.text)['url']
  File "/usr/local/lib/python3.9/json/__init__.py", line 346, in loads
    return _default_decoder.decode(s)
  File "/usr/local/lib/python3.9/json/decoder.py", line 337, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "/usr/local/lib/python3.9/json/decoder.py", line 355, in raw_decode
    raise JSONDecodeError("Expecting value", s, err.value) from None
json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
```


## pypgatk_cosmic-to-proteindb

### Tool Description
Convert COSMIC mutation data to a protein database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pypgatk cosmic-to-proteindb [OPTIONS]

Options:
  -c, --config_file TEXT        Configuration file for the cosmic data
                                pipelines
  -in, --input_mutation TEXT    Cosmic Mutation data file
  -fa, --input_genes TEXT       All Cosmic genes
  -out, --output_db TEXT        Protein database including all the mutations
  -f, --filter_column TEXT      Column in the VCF file to be used for
                                filtering or splitting mutations
  -a, --accepted_values TEXT    Limit mutations to values (tissue type, sample
                                name, etc) considered for generating
                                proteinDBs, by default mutations from all
                                records are considered (e.g. "")
  -s, --split_by_filter_column  Use this flag to generate a proteinDB per
                                group as specified in the filter_column,
                                default is False
  -h, --help                    Show this message and exit.
```


## pypgatk_dnaseq-to-proteindb

### Tool Description
Configuration to perform conversion between ENSEMBL Files

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pypgatk dnaseq-to-proteindb [OPTIONS]

Options:
  -c, --config_file TEXT          Configuration to perform conversion between
                                  ENSEMBL Files
  --input_fasta TEXT              Path to sequences fasta
  --translation_table INTEGER     Translation Table (default 1)
  --num_orfs INTEGER              Number of ORFs (default 3)
  --num_orfs_complement INTEGER   Number of ORFs from the reverse side
                                  (default 0)
  --output_proteindb TEXT         Output file name, exits if already exists
  -p, --protein_prefix TEXT       String to add before the variant protein
  --skip_including_all_cds        By default any transcript that has a defined
                                  CDS will be translated, this option disables
                                  this features instead it only depends on the
                                  biotypes
  --include_biotypes TEXT         Include Biotypes
  --exclude_biotypes TEXT         Exclude Biotypes
  --biotype_str TEXT              String used to identify gene/transcript
                                  biotype in the gtf file.
  --transcript_description_sep TEXT
                                  Separator used to separate features in the
                                  fasta headers, usually either (space, / or
                                  semicolon).
  --expression_str TEXT           String to be used for extracting expression
                                  value (TPM, FPKM, etc).
  --expression_thresh FLOAT       Threshold used to filter transcripts based
                                  on their expression values
  -h, --help                      Show this message and exit.
```


## pypgatk_ensembl-check

### Tool Description
Perform Ensembl database check

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pypgatk ensembl-check [OPTIONS]

Options:
  -c, --config_file TEXT    Configuration to perform Ensembl database check
  -in, --input_fasta TEXT   input_fasta file to perform the translation
  -out, --output TEXT       Output File
  -adds, --add_stop_codons  If a stop codons is found, add a new protein with
                            suffix (_Codon_{num})
  -aa, --num_aa INTEGER     Minimun number of aminoacids for a protein to be
                            included in the database
  -h, --help                Show this message and exit.
```


## pypgatk_gaps

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/lib/python3.9/site-packages/Bio/pairwise2.py:278: BiopythonDeprecationWarning: Bio.pairwise2 has been deprecated, and we intend to remove it in a future release of Biopython. As an alternative, please consider using Bio.Align.PairwiseAligner as a replacement, and contact the Biopython developers if you still need the Bio.pairwise2 module.
  warnings.warn(
Usage: pypgatk [OPTIONS] COMMAND [ARGS]...
Try 'pypgatk -h' for help.

Error: No such command 'gaps'.
```


## pypgatk_ensembl-downloader

### Tool Description
This tool enables to download from enseml ftp the FASTA and GTF files

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pypgatk ensembl-downloader [OPTIONS]

  This tool enables to download from enseml ftp the FASTA and GTF files

Options:
  -c, --config_file TEXT          Configuration file for the ensembl data
                                  downloader pipeline
  -o, --output_directory TEXT     Output directory for the peptide databases
  -t, --taxonomy TEXT             Taxonomy identifiers (comma separated list
                                  can be given) that will be use to download
                                  the data from Ensembl
  -fp, --folder_prefix_release TEXT
                                  Output folder prefix to download the data
  -sg, --skip_gtf                 Skip the GTF file during the download
  -sp, --skip_protein             Skip the protein fasta file during download
  -sc, --skip_cds                 Skip the CDS file download
  -sdn, --skip_cdna               Skip the cDNA file download
  -sn, --skip_ncrna               Skip the ncRNA file download
  -sd, --skip_dna                 Skip the DNA (reference genome assembly)
                                  file download
  -sv, --skip_vcf                 Skip the VCF variant file
  -en, --ensembl_name TEXT        Ensembl name code to download, it can be use
                                  instead of taxonomy (e.g. homo_sapiens)
  --grch37                        Download a previous version GRCh37 of
                                  ensembl genomes
  --url_file TEXT                 Add the url to a downloaded file
  -h, --help                      Show this message and exit.
```


## pypgatk_generate-decoy

### Tool Description
Generate decoy protein sequences for a target protein database.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pypgatk generate-decoy [OPTIONS]

Options:
  -c, --config_file TEXT          Configuration file for the protein database
                                  decoy generation
  -out, --output_database TEXT    Output file for decoy database
  -in, --input_database TEXT      FASTA file of target proteins sequences for
                                  which to create decoys (*.fasta|*.fa)
  -m, --method [protein-reverse|protein-shuffle|decoypyrat|pgdbdeep]
                                  The method that would be used to generate
                                  the decoys: protein-reverse: reverse protein
                                  sequences protein-shuffle: shuffle protein
                                  sequences decoypyrat: method developed for
                                  proteogenomics that shuffle redundant
                                  peptides in decoy databases pgdbdeep: method
                                  developed for proteogenomics developed by
                                  pypgatk
  -d, --decoy_prefix TEXT         Set accession prefix for decoy proteins in
                                  output. Default=DECOY_
  -e, --enzyme [Trypsin|Arg-C|Arg-C/P|Asp-N|Asp-N/B|Asp-N_ambic|Chymotrypsin|Chymotrypsin/P|CNBr|Formic_acid|Lys-C|Lys-N|Lys-C/P|PepsinA|TrypChymo|Trypsin/P|V8-DE|V8-E|leukocyte elastase|proline endopeptidase|glutamyl endopeptidase|alphaLP|2-iodobenzoate|iodosobenzoate|staphylococcal protease/D|proline-endopeptidase/HKR|Glu-C+P|PepsinA + P|cyanogen-bromide|Clostripain/P|elastase-trypsin-chymotrypsin|unspecific cleavage]
                                  Enzyme used for clevage the protein sequence
                                  (Default: Trypsin)
  --cleavage_position [c|n]       Set cleavage to be c or n terminal of
                                  specified cleavage sites. Options [c, n],
                                  Default = c
  -s, --max_missed_cleavages INTEGER
                                  Number of allowed missed cleavages in the
                                  protein sequence when digestion is performed
  --min_peptide_length INTEGER    Set minimum length of peptides (Default = 5)
  --max_peptide_length INTEGER    Set maximum length of peptides (Default =
                                  100)
  --max_iterations INTEGER        Set maximum number of times to shuffle a
                                  peptide to make it non-target before
                                  failing. Default=100
  --do_not_shuffle                Turn OFF shuffling of decoy peptides that
                                  are in the target database. Default=false
  --do_not_switch                 Turn OFF switching of cleavage site with
                                  preceding amino acid. Default=false
  --temp_file TEXT                Set temporary file to write decoys prior to
                                  shuffling. Default=tmp.fa
  --no_isobaric                   Do not make decoy peptides isobaric.
                                  Default=false
  --keep_target_hits              Keep peptides duplicate in target and decoy
                                  databases
  --memory_save                   Slower but uses less memory (does not store
                                  decoy peptide list). Default=false
  -h, --help                      Show this message and exit.
```


## pypgatk_methods

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/lib/python3.9/site-packages/Bio/pairwise2.py:278: BiopythonDeprecationWarning: Bio.pairwise2 has been deprecated, and we intend to remove it in a future release of Biopython. As an alternative, please consider using Bio.Align.PairwiseAligner as a replacement, and contact the Biopython developers if you still need the Bio.pairwise2 module.
  warnings.warn(
Usage: pypgatk [OPTIONS] COMMAND [ARGS]...
Try 'pypgatk -h' for help.

Error: No such command 'methods'.
```


## pypgatk_mztab_class_fdr

### Tool Description
Filter peptides by global-fdr and class-fdr

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pypgatk mztab_class_fdr [OPTIONS]

Options:
  -c, --config_file TEXT          Configuration file for the fdr peptides
                                  pipeline
  -i, --input_mztab TEXT          The file name of the input mzTab
  -o, --outfile_name TEXT         The file name of the psm table filtered by
                                  global-fdr and class-fdr
  -d, --decoy_prefix TEXT         Default is "decoy"
  -gf, --global_fdr_cutoff TEXT   PSM peptide global-fdr cutoff or threshold.
                                  Default is 0.01
  -cf, --class_fdr_cutoff TEXT    PSM peptide class-fdr cutoff or threshold.
                                  Default is 0.01
  -g, --peptide_groups_prefix TEXT
                                  Peptide class groups e.g. "{non_canonical:[a
                                  ltorf,pseudo,ncRNA];mutations:[COSMIC,cbiomu
                                  t];variants:[var_mut,var_rs]}"
  -h, --help                      Show this message and exit.
```


## pypgatk_fdr

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/lib/python3.9/site-packages/Bio/pairwise2.py:278: BiopythonDeprecationWarning: Bio.pairwise2 has been deprecated, and we intend to remove it in a future release of Biopython. As an alternative, please consider using Bio.Align.PairwiseAligner as a replacement, and contact the Biopython developers if you still need the Bio.pairwise2 module.
  warnings.warn(
Usage: pypgatk [OPTIONS] COMMAND [ARGS]...
Try 'pypgatk -h' for help.

Error: No such command 'fdr'.
```


## pypgatk_peptide-class-fdr

### Tool Description
The peptide_class_fdr allows to filter the peptide psm files (IdXML files) using two different FDR threshold types: - Global FDR - Global FDR + Peptide Class FDR The peptide classes can be defined in two ways as simple class: - "altorf,pseudo,ncRNA,COSMIC,cbiomut,var_mut,var_rs" where each class represent only one kind of peptide source pseudo gene, ncRNA, etc. The second for of representing peptide classes is using groups of classes: - "{ non_canonical:[altorf,pseudo,ncRNA];mutations:[COSMIC,cbiomut];variants:[var _mut,var_rs]}" in this case a class is a group of peptide sources for example: mutations with two difference sources as COSMIC and cbiomut (CBioportal mutation) .

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pypgatk peptide-class-fdr [OPTIONS]

  The peptide_class_fdr allows to filter the peptide psm files (IdXML files)
  using two different FDR threshold types:  - Global FDR  - Global FDR +
  Peptide Class FDR The peptide classes can be defined in two ways as simple
  class:  - "altorf,pseudo,ncRNA,COSMIC,cbiomut,var_mut,var_rs" where each
  class represent only one kind of peptide source pseudo gene, ncRNA, etc. The
  second for of representing peptide classes is using groups of classes:  - "{
  non_canonical:[altorf,pseudo,ncRNA];mutations:[COSMIC,cbiomut];variants:[var
  _mut,var_rs]}" in this case a class is a group of peptide sources for
  example: mutations with two difference sources as COSMIC and cbiomut
  (CBioportal mutation) .

  :param ctx: :param config_file: Configuration file :param input_file: Input
  idXML/Triqler containing peptide identifications :param output_file: Output
  idXML/Triqler containing peptide identifications after filtering :param
  min_peptide_length: Minimum peptide length :param psm_pep_fdr_cutoff:
  Global FDR cutoff :param psm_pep_class_fdr_cutoff: Peptide class FDR cutoff
  :param peptide_groups_prefix: Peptide groups prefix for the Peptide classes
  FDR :param peptide_classes_prefix: Peptide classes :param file_type: File
  type to compute the FDR and class FDR () :param disable_class_fdr: Do not
  compute class FDR and not filtering the PSMs :return:

Options:
  -c, --config_file TEXT          Configuration to perform Peptide Class FDR
  -in, --input-file TEXT          input file with the peptides and proteins
  -out, --output-file TEXT        idxml from openms with filtered peptides and
                                  proteins
  --file-type TEXT                File types supported by the tool (TSV
                                  (.tsv), IDXML (.idxml), MZTAB (.mztab))
  --min-peptide-length TEXT       minimum peptide length
  --psm-pep-fdr-cutoff TEXT       PSM peptide FDR cutoff or threshold
  --psm-pep-class-fdr-cutoff TEXT
                                  PSM class peptide FDR cutoff or threshold
  --peptide-groups-prefix TEXT    Peptide class groups e.g. "{non_canonical:[a
                                  ltorf,pseudo,ncRNA];mutations:[COSMIC,cbiomu
                                  t];variants:[var_mut,var_rs]}"
  --peptide-classes-prefix TEXT   Peptides classes e.g. "altorf,pseudo,ncRNA,C
                                  OSMIC,cbiomut,var_mut,var_rs"
  --disable-class-fdr             Disable Class-FDR, only compute Global FDR
  -h, --help                      Show this message and exit.
```


## pypgatk_threeframe-translation

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/lib/python3.9/site-packages/Bio/pairwise2.py:278: BiopythonDeprecationWarning: Bio.pairwise2 has been deprecated, and we intend to remove it in a future release of Biopython. As an alternative, please consider using Bio.Align.PairwiseAligner as a replacement, and contact the Biopython developers if you still need the Bio.pairwise2 module.
  warnings.warn(
Usage: pypgatk threeframe-translation [OPTIONS]
Try 'pypgatk threeframe-translation -h' for help.

Error: No such option: --h Did you mean --help?
```


## pypgatk_validate_peptides

### Tool Description
Validate peptides using the pypgatk pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pypgatk validate_peptides [OPTIONS]

Options:
  -c, --config_file TEXT          Configuration file for the validate peptides
                                  pipeline
  -p, --mzml_path TEXT            The mzml file path.You only need to use
                                  either mzml_path or mzml_files
  -f, --mzml_files TEXT           The mzml files.Different files are separated
                                  by ",".You only need to use either mzml_path
                                  or mzml_files
  -i, --infile_name TEXT          Variant peptide PSMs table
  -o, --outfile_name TEXT         Output file for the results
  -ion, --ions_tolerance TEXT     MS2 fragment ions mass accuracy
  -n, --number_of_processes TEXT  Used to specify the number of processes.
                                  Default is 40.
  -r, --relative                  When using ppm as ions_tolerance (not Da),
                                  it needs to be turned on
  -msgf, --msgf                   If it is the standard format of MSGF output,
                                  please turn on this switch, otherwise it
                                  defaults to mzTab format
  -h, --help                      Show this message and exit.
```


## pypgatk_subsititution

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/lib/python3.9/site-packages/Bio/pairwise2.py:278: BiopythonDeprecationWarning: Bio.pairwise2 has been deprecated, and we intend to remove it in a future release of Biopython. As an alternative, please consider using Bio.Align.PairwiseAligner as a replacement, and contact the Biopython developers if you still need the Bio.pairwise2 module.
  warnings.warn(
Usage: pypgatk [OPTIONS] COMMAND [ARGS]...
Try 'pypgatk -h' for help.

Error: No such command 'subsititution'.
```


## pypgatk_vcf-to-proteindb

### Tool Description
Configuration to perform conversion between ENSEMBL Files

### Metadata
- **Docker Image**: quay.io/biocontainers/pypgatk:0.0.24--pyhdfd78af_0
- **Homepage**: http://github.com/bigbio/py-pgatk
- **Package**: https://anaconda.org/channels/bioconda/packages/pypgatk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pypgatk vcf-to-proteindb [OPTIONS]

Options:
  -c, --config_file TEXT          Configuration to perform conversion between
                                  ENSEMBL Files
  -f, --input_fasta TEXT          Path to the transcript sequence
  -v, --vcf TEXT                  Path to the VCF file
  -g, --gene_annotations_gtf TEXT
                                  Path to the gene annotations file
  -t, --translation_table INTEGER
                                  Translation table (Default 1)
  -m, --mito_translation_table INTEGER
                                  Mito_trans_table (default 2)
  -p, --protein_prefix TEXT       String to add before the variant peptides
  --report_ref_seq                In addition to var peps, also report all ref
                                  peps
  -o, --output_proteindb TEXT     Output file name, exits if already exists
  --annotation_field_name TEXT    Annotation field name found in the INFO
                                  column, e.g CSQ or vep; if empty it will
                                  identify overlapping transcripts from the
                                  given GTF file and no aa consequence will be
                                  considered
  --af_field TEXT                 field name in the VCF INFO column to use for
                                  filtering on AF, (Default None)
  --af_threshold TEXT             Minium AF threshold for considering common
                                  variants
  --transcript_str TEXT           String that is used for transcript ID in the
                                  VCF header INFO field
  --biotype_str TEXT              String that is used for biotype in the VCF
                                  header INFO field
  --exclude_biotypes TEXT         Excluded Biotypes
  --include_biotypes TEXT         included_biotypes, default all
  --consequence_str TEXT          String that is used for consequence in the
                                  VCF header INFO field
  --exclude_consequences TEXT     Excluded Consequences
  -s, --skip_including_all_cds    by default any transcript that has a defined
                                  CDS will be used, this option disables this
                                  features instead
  --include_consequences TEXT     included_consequences, default all
  --ignore_filters                enabling this option causes or variants to
                                  be parsed. By default only variants that
                                  have not failed any filters will be
                                  processed (FILTER column is PASS, None, .)
                                  or if the filters are subset of the accepted
                                  filters. (default is False)
  --accepted_filters TEXT         Accepted filters for variant parsing
  -h, --help                      Show this message and exit.
```


## Metadata
- **Skill**: generated
