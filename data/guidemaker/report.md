# guidemaker CWL Generation Report

## guidemaker

### Tool Description
GuideMaker: Software to design gRNAs pools in non-model genomes and CRISPR-Cas systems

### Metadata
- **Docker Image**: quay.io/biocontainers/guidemaker:0.4.2--pyhdfd78af_0
- **Homepage**: https://github.com/USDA-ARS-GBRU/GuideMaker
- **Package**: https://anaconda.org/channels/bioconda/packages/guidemaker/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/guidemaker/overview
- **Total Downloads**: 11.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/USDA-ARS-GBRU/GuideMaker
- **Stars**: N/A
### Original Help Text
```text
usage: guidemaker [-h] [--genbank GENBANK [GENBANK ...]]
                  [--fasta FASTA [FASTA ...]] [--gff GFF [GFF ...]] --pamseq
                  PAMSEQ --outdir OUTDIR [--raw_output_only]
                  [--pam_orientation {5prime,3prime}] [--guidelength [10-27]]
                  [--lsr [0-27]] [--dtype {hamming,leven}] [--dist [0-5]]
                  [--before [1-500]] [--into [1-500]] [--knum [2-20]]
                  [--controls [0-100000]] [--threads THREADS] [--log LOG]
                  [--tempdir TEMPDIR]
                  [--restriction_enzyme_list [RESTRICTION_ENZYME_LIST ...]]
                  [--attribute_key ATTRIBUTE_KEY]
                  [--filter_by_attribute [FILTER_BY_ATTRIBUTE ...]]
                  [--doench_efficiency_score] [--cfd_score] [--keeptemp]
                  [--plot] [--config CONFIG] [-V]

GuideMaker: Software to design gRNAs pools in non-model genomes and CRISPR-Cas
systems

optional arguments:
  -h, --help            show this help message and exit
  --genbank GENBANK [GENBANK ...], -i GENBANK [GENBANK ...]
                        One or more genbank .gbk or gzipped .gbk files for a
                        single genome. Provide this or GFF/GTF and fasta files
  --fasta FASTA [FASTA ...], -f FASTA [FASTA ...]
                        One or more fasta or gzipped fasta files for a single
                        genome. If using a fasta, a GFF/GTF file must also be
                        provided but not a genbank file.
  --gff GFF [GFF ...], -g GFF [GFF ...]
                        One or more GFF or GTF files (optionally gzipped) for
                        a single genome. If using a GFF/GTF a fasta file must
                        also be provided but not a genbank file.
  --pamseq PAMSEQ, -p PAMSEQ
                        A short PAM motif to search for, it may use IUPAC
                        ambiguous alphabet
  --outdir OUTDIR, -o OUTDIR
                        The directory for data output
  --raw_output_only     if selected only the raw guide RNAs their positions
                        will be returned the meet lsr and dist criteria
  --pam_orientation {5prime,3prime}, -r {5prime,3prime}
                        The PAM position relative to the target: 5prime:
                        [PAM][target], 3prime: [target][PAM]. For example,
                        SpCas9 is 3prime. Default: '3prime'.
  --guidelength [10-27], -l [10-27]
                        Length of the guide sequence. Default: 20.
  --lsr [0-27]          Length of a seed region near the PAM site required to
                        be unique. Default: 10.
  --dtype {hamming,leven}
                        Select the distance type. Default: hamming.
  --dist [0-5]          Minimum edit distance from any other potential guide.
                        Default: 2.
  --before [1-500]      keep guides this far in front of a feature. Default:
                        100.
  --into [1-500]        keep guides this far inside (past the start site)of a
                        feature. Default: 200.
  --knum [2-20]         how many sequences similar to the guide to report.
                        Default: 5.
  --controls [0-100000]
                        Number of random control RNAs to generate. Default:
                        1000.
  --threads THREADS     The number of cpu threads to use. Default: 2
  --log LOG             Log file
  --tempdir TEMPDIR     The temp file directory
  --restriction_enzyme_list [RESTRICTION_ENZYME_LIST ...]
                        List of sequence representing restriction enzymes.
                        Default: None.
  --attribute_key ATTRIBUTE_KEY
                        the attribute key in column 9 of the GFF/GTF file to
                        use for filtering. Default: ID
  --filter_by_attribute [FILTER_BY_ATTRIBUTE ...]
                        List of locus ids. Default: None.
  --doench_efficiency_score
                        On-target scoring from Doench et al. 2016 - only for
                        NGG PAM and guidelength=25: Default: None.
  --cfd_score           CFD score for assessing off-target activity of gRNAs
                        with NGG pam: Default: None.
  --keeptemp            Option to keep intermediate files be kept
  --plot                Option to create GuideMaker plots
  --config CONFIG       Path to YAML formatted configuration file, default is
                        /usr/local/lib/python3.9/site-
                        packages/guidemaker/data/config_default.yaml
  -V, --version         show program's version number and exit

To run the web app locally, in terminal run:
-----------------------------------------------------------------------
streamlit run /usr/local/lib/python3.9/site-packages/guidemaker/data/app.py
-----------------------------------------------------------------------
```

