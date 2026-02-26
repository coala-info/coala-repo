# omark CWL Generation Report

## omark

### Tool Description
Compute an OMA quality score from the OMAmer file of a proteome.

### Metadata
- **Docker Image**: quay.io/biocontainers/omark:0.4.1--pyh7e72e81_0
- **Homepage**: https://github.com/DessimozLab/omark
- **Package**: https://anaconda.org/channels/bioconda/packages/omark/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/omark/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-12-04
- **GitHub**: https://github.com/DessimozLab/omark
- **Stars**: N/A
### Original Help Text
```text
usage: omark [-h] (-f FILE | -c | -s) -d DATABASE [-t TAXID] [-o OUTPUTFOLDER]
             [-n MIN_N_SPECIES] [-r TAXONOMIC_RANK] [-e ETE_NCBI_DB]
             [-of OG_FASTA] [-i ISOFORM_FILE] [-v]

Compute an OMA quality score from the OMAmer file of a proteome.

options:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  Input OMAmer file - obtained as output from an OMAmer
                        search.
  -c, --output_cHOGs    Switch OMArk mode to only computing a list of
                        conserved HOGs and output it as list. Can be used to
                        obtain a set of genes on which to train
  -s, --summarize_db    Switch OMArk mode to summarize the clade content of
                        the OMAmer DB (Number of species per clade, number of
                        HOGs used,...). This mode will take a few hours to
                        run. Refer to the data availableat
                        https://omabrowser.org/oma/current/ if you are using
                        the default database.
  -d DATABASE, --database DATABASE
                        The OMAmer database.
  -t TAXID, --taxid TAXID
                        Taxonomic identifier
  -o OUTPUTFOLDER, --outputFolder OUTPUTFOLDER
                        The folder containing output data the script wilp
                        generate.
  -n MIN_N_SPECIES, --min_n_species MIN_N_SPECIES
                        The minimal number of species in the database
                        belonging to a clade to select it as an ancestral
                        lineage
  -r TAXONOMIC_RANK, --taxonomic_rank TAXONOMIC_RANK
                        The narrowest taxonomic rank (genus, order, family...)
                        that should be used as ancestral lineage.
  -e ETE_NCBI_DB, --ete_ncbi_db ETE_NCBI_DB
                        Path to the ete3 NCBI database to be used. Default
                        will use the default location at
                        ~/.etetoolkit/taxa.sqlite
  -of OG_FASTA, --og_fasta OG_FASTA
                        Original FASTA file
  -i ISOFORM_FILE, --isoform_file ISOFORM_FILE
                        A semi-colon separated file, listing all isoforoms of
                        each genes, with one gene per line.
  -v, --verbose         Turn on logging information about OMArk process
```

