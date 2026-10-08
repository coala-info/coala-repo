# gget CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| gget_alphafold | Not completed | needs gget setup alphafold (extra packages and about 4 GB of model weights, GPU advised), not in the image |
| gget_archs4 | PASS |  |
| gget_bgee | PASS |  |
| gget_blast | Not completed | NCBI BLAST service did not return a result within the 8 minute limit even for a 21-residue peptide |
| gget_blat | Not completed | UCSC blocks automated queries with a bot check (CAPTCHA), so no result is returned |
| gget_cbio_plot | Failed | image problem: bravado package missing in the image; the data download fails with error 'actions' and no figure is made |
| gget_cbio_search | Failed | image problem: bravado package missing in the image, so the search returns an empty list |
| gget_cellxgene | Failed | image problem: cellxgene-census dependencies are missing in the image (gget setup cellxgene was not run) |
| gget_cosmic | Not completed | COSMIC now requires an account and licence; the query page returns no data and gget crashes with IndexError |
| gget_diamond | Failed | image problem: the DIAMOND binary bundled in the image crashes with a segmentation fault (also as root) |
| gget_elm | Failed | image problem: ELM database files are not in the image (gget setup elm was not run) and the bundled DIAMOND binary crashes |
| gget_enrichr | PASS |  |
| gget_info | PASS |  |
| gget_muscle | Failed | image problem: gget muscle runs chmod on its own muscle binary, which fails for the non-root user in the read-only image, so no alignment is written |
| gget_mutate | PASS | synthetic data: mutations written by hand on a real gene fragment; both changes appear in the output |
| gget_opentargets | PASS | default diseases mode works; drugs, pharmacogenetics and expression crash with HTTP 400 from the Open Targets API |
| gget_pdb | PASS |  |
| gget_ref | PASS |  |
| gget_search | Failed | image problem: gget search cannot connect to the Ensembl MySQL server because the mysql_native_password plugin is missing in the image |
| gget_seq | PASS |  |

## gget_ref

### Tool Description
Fetch FTPs for reference genomes and annotations by species.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Total Downloads**: 50.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pachterlab/gget
- **Stars**: N/A
### Original Help Text
```text
usage: gget ref [-h] [-l] [-liv] [-w WHICH] [-r RELEASE] [-ftp] [-d]
                [-od OUT_DIR] [-o OUT] [-q] [-s SPECIES_DEPRECATED]
                [species]

Fetch FTPs for reference genomes and annotations by species.

positional arguments:
  species               Species or database to be searched. Species should be passed in the format 'genus_species', e.g. 'homo_sapiens'.
                        Supported shortcuts: 'human', 'mouse', 'human_grch37' (accesses the GRCh37 genome assembly)

optional arguments:
  -h, --help            show this help message and exit
  -l, --list_species    List all available vertebrate species from the Ensembl database.
                        (Combine with `--release` to get the available species from a specific Ensembl release.)
  -liv, --list_iv_species
                        List all available invertebrate species from the Ensembl database.
                        (Combine with `--release` to get the available species from a specific Ensembl release.)
  -w WHICH, --which WHICH
                        Defines which results to return.
                        Default: 'all' -> Returns all available results.
                        Possible entries are one or a combination (as a comma-separated list) of the following:
                        'gtf' - Returns the annotation (GTF).
                        'cdna' - Returns the trancriptome (cDNA).
                        'dna' - Returns the genome (DNA).
                        'cds - Returns the coding sequences corresponding to Ensembl genes. (Does not contain UTR or intronic sequence.)
                        'cdrna' - Returns transcript sequences corresponding to non-coding RNA genes (ncRNA).
                        'pep' - Returns the protein translations of Ensembl genes.
                        Example: '-w dna,gtf' (default: all)
  -r RELEASE, --release RELEASE
                        Ensembl release the FTPs will be fetched from, e.g. 104 (default: latest Ensembl release).
  -ftp, --ftp           Return only the FTP link(s).
  -d, --download        Download FTPs to the directory specified by --out_dir using curl.
  -od OUT_DIR, --out_dir OUT_DIR
                        Path to the directory the FTPs will be saved in, e.g. path/to/directory.
                        Default: Current working directory.
  -o OUT, --out OUT     Path to the file the results will be saved in, e.g. path/to/directory/results.json.
                        Default: Standard out.
  -q, --quiet           Does not print progress information.
  -s SPECIES_DEPRECATED, --species SPECIES_DEPRECATED
                        DEPRECATED - use positional argument instead. Species for which the FTPs will be fetched, e.g. homo_sapiens.
```


## gget_search

### Tool Description
Fetch gene and transcript IDs from Ensembl using free-form search terms.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget search [-h] -s SPECIES [-r RELEASE] [-t {gene,transcript}]
                   [-ao {and,or}] [-l LIMIT] [-csv] [-o OUT] [-q]
                   [-sw [SW_DEPRECATED ...]] [--seqtype SEQTYPE] [-j]
                   searchwords [searchwords ...]

Fetch gene and transcript IDs from Ensembl using free-form search terms.

positional arguments:
  searchwords           One or more free form search words, e.g. gaba, nmda.

optional arguments:
  -h, --help            show this help message and exit
  -s SPECIES, --species SPECIES
                        Species or database to be queried, e.g. 'homo_sapiens' or 'arabidopsis_thaliana'.
                        To pass a specific database, pass the name of the CORE database, e.g. 'mus_musculus_dba2j_core_105_1'.
                        All available core databases can be found here:
                        Vertebrates: http://ftp.ensembl.org/pub/current/mysql/
                        Invertebrates: http://ftp.ensemblgenomes.org/pub/current/ + kingdom + mysql/
                        Supported shortcuts: 'human', 'mouse'.
  -r RELEASE, --release RELEASE
                        Defines the Ensembl release number from which the files are fetched, e.g. 104.
                        Note: Does not apply to invertebrate species (you can pass a specific core database (which include a release number) to the species argument instead).
                        This argument is overwritten if a specific database (which includes a release number) is passed to the species argument.
                        Default: None -> latest Ensembl release is used.
  -t {gene,transcript}, --id_type {gene,transcript}
                        'gene': Returns genes that match the searchwords. (default).
                        'transcript': Returns transcripts that match the searchwords. (default: gene)
  -ao {and,or}, --andor {and,or}
                        'or': Gene descriptions must include at least one of the searchwords (default).
                        'and': Only return genes whose descriptions include all searchwords. (default: or)
  -l LIMIT, --limit LIMIT
                        Limits the number of results, e.g. 10 (default: None).
  -csv, --csv           Returns results in csv format instead of json.
  -o OUT, --out OUT     Path to the file the results will be saved in, e.g. path/to/directory/results.json.
                        Default: Standard out.
  -q, --quiet           Does not print progress information.
  -sw [SW_DEPRECATED ...], --searchwords [SW_DEPRECATED ...]
                        DEPRECATED - use positional argument instead. One or more free form search words, e.g. gaba, nmda.
  --seqtype SEQTYPE     DEPRECATED - use argument 'id_type' instead.
  -j, --json            DEPRECATED - json is now the default output format (convert to csv using flag [--csv]).
```


## gget_elm

### Tool Description
Locally predicts Eukaryotic Linear Motifs from an amino acid sequence or UniProt Acc using data from the ELM database (http://elm.eu.org/media/Elm_academic_license.pdf).

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget elm [-h] [-u]
                [-s {fast,mid-sensitive,sensitive,more-sensitive,very-sensitive,ultra-sensitive}]
                [-t THREADS] [-bin DIAMOND_BINARY] [-e] [-q] [-csv] [-o OUT]
                sequence

Locally predicts Eukaryotic Linear Motifs from an amino acid sequence or UniProt Acc using data from the ELM database (http://elm.eu.org/media/Elm_academic_license.pdf).

positional arguments:
  sequence              Amino acid sequence or Uniprot Acc. If Uniprot Acc, use flag '--uniprot'.

optional arguments:
  -h, --help            show this help message and exit
  -u, --uniprot         Use this flag if input is a Uniprot Acc instead of an amino acid sequence.
  -s {fast,mid-sensitive,sensitive,more-sensitive,very-sensitive,ultra-sensitive}, --sensitivity {fast,mid-sensitive,sensitive,more-sensitive,very-sensitive,ultra-sensitive}
                        Sensitivity of DIAMOND alignment. (default: very-sensitive)
  -t THREADS, --threads THREADS
                        Number of threads used in DIAMOND alignment. (default: 1)
  -bin DIAMOND_BINARY, --diamond_binary DIAMOND_BINARY
                        Path to DIAMOND binary. Default: None -> Uses DIAMOND binary installed with gget.
  -e, --expand          Expand the information returned in the regex data frame to include the protein names, organisms, and references that the motif was orignally validated on.
  -q, --quiet           Does not print progress information.
  -csv, --csv           Returns results in csv format instead of json.
  -o OUT, --out OUT     Path to folder to save results in, e.g. path/to/directory.
                        Default: Standard out.
```

## gget_diamond

### Tool Description
Align multiple protein or translated DNA sequences using DIAMOND.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget diamond [-h] -ref REFERENCE [REFERENCE ...] [-db DIAMOND_DB]
                    [-s {fast,mid-sensitive,sensitive,more-sensitive,very-sensitive,ultra-sensitive}]
                    [-t THREADS] [-bin DIAMOND_BINARY] [-q] [-csv] [-o OUT]
                    query [query ...]

Align multiple protein or translated DNA sequences using DIAMOND.

positional arguments:
  query                 Sequences (str or list) or path to FASTA file containing sequences to be aligned against the reference.

optional arguments:
  -h, --help            show this help message and exit
  -ref REFERENCE [REFERENCE ...], --reference REFERENCE [REFERENCE ...]
                        Reference sequences (str or list) or path to FASTA file containing reference sequences.
  -db DIAMOND_DB, --diamond_db DIAMOND_DB
                        Path to save DIAMOND database created from reference.
                        Default: None -> Temporary db file will be deleted after alignment or saved in 'out' if 'out' is provided.
  -s {fast,mid-sensitive,sensitive,more-sensitive,very-sensitive,ultra-sensitive}, --sensitivity {fast,mid-sensitive,sensitive,more-sensitive,very-sensitive,ultra-sensitive}
                        One of the following:'fast', 'mid-sensitive', 'sensitive', 'more-sensitive', 'very-sensitive' or 'ultra-sensitive'.
                        Sensitivity of DIAMOND alignment. Default: 'very-sensitive'. (default: very-sensitive)
  -t THREADS, --threads THREADS
                        Number of threads to use for alignment. (default: 1)
  -bin DIAMOND_BINARY, --diamond_binary DIAMOND_BINARY
                        Path to DIAMOND binary,  e.g. path/bins/Linux/diamond.
                        Default: None -> Uses DIAMOND binary installed with gget.
  -q, --quiet           Does not print progress information.
  -csv, --csv           Returns results in csv format instead of json.
  -o OUT, --out OUT     Path to folder to save DIAMOND results in, e.g. path/to/directory/results.json.
                        Default: Standard out, temporary files are deleted.
```

## gget_info

### Tool Description
Fetch gene and transcript metadata using Ensembl IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget info [-h] [-n] [-u] [-csv] [-pdb] [-q] [-o OUT] [-eo]
                 [-id ID_DEPRECATED [ID_DEPRECATED ...]] [-j] [-e]
                 ens_ids [ens_ids ...]

Fetch gene and transcript metadata using Ensembl IDs.

positional arguments:
  ens_ids               One or more Ensembl, WormBase, or FlyBase IDs.

optional arguments:
  -h, --help            show this help message and exit
  -n, --ncbi            TURN OFF results from NCBI database.
  -u, --uniprot         TURN OFF results from UniProt database.
  -csv, --csv           Returns results in csv format instead of json.
  -pdb, --pdb           Also returns PDB IDs (might increase run time).
  -q, --quiet           Does not print progress information.
  -o OUT, --out OUT     Path to file the results will be saved as, e.g. path/to/directory/results.json.
                        Default: Standard out.
  -eo, --ensembl_only   DEPRECATED - only returns results from Ensembl (excludes PDB, UniProt, and NCBI results).
  -id ID_DEPRECATED [ID_DEPRECATED ...], --ens_ids ID_DEPRECATED [ID_DEPRECATED ...]
                        DEPRECATED - use positional argument instead. One or more Ensembl, WormBase or FlyBase IDs).
  -j, --json            DEPRECATED - json is now the default output format (convert to csv using flag [--csv]).
  -e, --expand          DEPRECATED - gget info now always returns all available information.
```

## gget_seq

### Tool Description
Fetch nucleotide or amino acid sequence (FASTA) of a gene (and all isoforms) or transcript by Ensembl, WormBase or FlyBase ID.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget seq [-h] [-t] [-iso] [-o OUT] [-q]
                [-id ID_DEPRECATED [ID_DEPRECATED ...]] [--seqtype SEQTYPE]
                [--transcribe]
                ens_ids [ens_ids ...]

Fetch nucleotide or amino acid sequence (FASTA) of a gene (and all isoforms) or transcript by Ensembl, WormBase or FlyBase ID. 

positional arguments:
  ens_ids               One or more Ensembl, WormBase, or FlyBase IDs.

optional arguments:
  -h, --help            show this help message and exit
  -t, --translate       Returns amino acid sequences from UniProt. (Otherwise returns nucleotide sequences from Ensembl.)
  -iso, --isoforms      Returns sequences of all known transcripts (default: False). (Only for gene IDs.)
  -o OUT, --out OUT     Path to the FASTA file the results will be saved in, e.g. path/to/directory/results.fa.
                        Default: Standard out.
  -q, --quiet           Does not print progress information.
  -id ID_DEPRECATED [ID_DEPRECATED ...], --ens_ids ID_DEPRECATED [ID_DEPRECATED ...]
                        DEPRECATED - use positional argument instead. One or more Ensembl, WormBase or FlyBase IDs.
  --seqtype SEQTYPE     DEPRECATED - use True/False flag 'translate' instead.
  --transcribe          DEPRECATED - use True/False flag 'translate' instead.
```

## gget_muscle

### Tool Description
Align multiple nucleotide or amino acid sequences against each other (using the Muscle v5 algorithm).

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget muscle [-h] [-s5] [-o OUT] [-q] [-fa FASTA_DEPRECATED]
                   fasta [fasta ...]

Align multiple nucleotide or amino acid sequences against each other (using the Muscle v5 algorithm).

positional arguments:
  fasta                 List of sequences or path to fasta file containing the sequences to be aligned.

optional arguments:
  -h, --help            show this help message and exit
  -s5, --super5         If True, align input using Super5 algorithm instead of PPP algorithm to decrease time and memory. Use for large inputs (a few hundred sequences).
  -o OUT, --out OUT     Path to save an 'aligned FASTA' (.afa) file with the results, e.g. path/to/directory/results.afa.Default: 'None' -> Standard out in Clustal format.
  -q, --quiet           Does not print progress information.
  -fa FASTA_DEPRECATED, --fasta FASTA_DEPRECATED
                        DEPRECATED - use positional argument instead. Path to fasta file containing the sequences to be aligned.
```

## gget_blast

### Tool Description
BLAST a nucleotide or amino acid sequence against any BLAST database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget blast [-h] [-p {blastn,blastp,blastx,tblastn,tblastx}]
                  [-db {nt,nr,refseq_rna,refseq_protein,swissprot,pdbaa,pdbnt}]
                  [-l LIMIT] [-e EXPECT] [-lcf] [-mbo] [-q] [-csv] [-o OUT]
                  [-seq SEQ_DEPRECATED] [-j]
                  sequence

BLAST a nucleotide or amino acid sequence against any BLAST database.

positional arguments:
  sequence              Sequence (str) or path to fasta file.

optional arguments:
  -h, --help            show this help message and exit
  -p {blastn,blastp,blastx,tblastn,tblastx}, --program {blastn,blastp,blastx,tblastn,tblastx}
                        'blastn', 'blastp', 'blastx', 'tblastn', or 'tblastx'. Default: 'blastn' for nucleotide sequences; 'blastp' for amino acid sequences. (default: default)
  -db {nt,nr,refseq_rna,refseq_protein,swissprot,pdbaa,pdbnt}, --database {nt,nr,refseq_rna,refseq_protein,swissprot,pdbaa,pdbnt}
                        'nt', 'nr', 'refseq_rna', 'refseq_protein', 'swissprot', 'pdbaa', or 'pdbnt'. Default: 'nt' for nucleotide sequences; 'nr' for amino acid sequences. More info on BLAST databases: https://ncbi.github.io/blast-cloud/blastdb/available-blastdbs.html (default: default)
  -l LIMIT, --limit LIMIT
                        int or None. Limits number of hits to return. Default 50. (default: 50)
  -e EXPECT, --expect EXPECT
                        float or None. An expect value cutoff. Default 10.0. (default: 10.0)
  -lcf, --low_comp_filt
                        Turn on low complexity filter. Default off.
  -mbo, --megablast_off
                        Turn off MegaBLAST algorithm. Default on (blastn only).
  -q, --quiet           Do not print progress information.
  -csv, --csv           Returns results in csv format instead of json.
  -o OUT, --out OUT     Path to the file the results will be saved in, e.g. path/to/directory/results.json.
                        Default: Standard out.
  -seq SEQ_DEPRECATED, --sequence SEQ_DEPRECATED
                        DEPRECATED - use positional argument instead. Sequence (str) or path to fasta file.
  -j, --json            DEPRECATED - json is now the default output format (convert to csv using flag [--csv]).
```

## gget_blat

### Tool Description
BLAT a nucleotide or amino acid sequence against any BLAT UCSC assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget blat [-h] [-st {DNA,protein,translated%20RNA,translated%20DNA}]
                 [-a ASSEMBLY] [-csv] [-o OUT] [-q] [-seq SEQ_DEPRECATED] [-j]
                 sequence

BLAT a nucleotide or amino acid sequence against any BLAT UCSC assembly.

positional arguments:
  sequence              Sequence (str) or path to fasta file.

optional arguments:
  -h, --help            show this help message and exit
  -st {DNA,protein,translated%20RNA,translated%20DNA}, --seqtype {DNA,protein,translated%20RNA,translated%20DNA}
                        'DNA', 'protein', 'translated%20RNA', or 'translated%20DNA'. Default: 'DNA' for nucleotide sequences; 'protein' for amino acid sequences. (default: default)
  -a ASSEMBLY, --assembly ASSEMBLY
                        'human' (assembly hg38) (default), 'mouse' (assembly mm39), or any of the species assemblies available at https://genome.ucsc.edu/cgi-bin/hgBlat (use short assembly name as listed after the '/').  (default: human)
  -csv, --csv           Returns results in csv format instead of json.
  -o OUT, --out OUT     Path to the csv file the results will be saved in, e.g. path/to/directory/results.csv.Default: Standard out.
  -q, --quiet           Does not print progress information.
  -seq SEQ_DEPRECATED, --sequence SEQ_DEPRECATED
                        DEPRECATED - use positional argument instead. Sequence (str) or path to fasta file.
  -j, --json            DEPRECATED - json is now the default output format (convert to csv using flag [--csv]).
```

## gget_enrichr

### Tool Description
Perform an enrichment analysis on a list of genes using Enrichr.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget enrichr [-h] -db DATABASE [-s {human,mouse,fly,yeast,worm,fish}]
                    [-bkg_l [BACKGROUND_LIST ...]] [-bkg] [-e] [-e_b]
                    [-ko KEGG_OUT] [-kr KEGG_RANK] [-csv] [-o OUT] [-q]
                    [-g GENES_DEPRECATED [GENES_DEPRECATED ...]] [-j]
                    genes [genes ...]

Perform an enrichment analysis on a list of genes using Enrichr.

positional arguments:
  genes                 List of gene symbols or Ensembl gene IDs to perform enrichment analysis on.

optional arguments:
  -h, --help            show this help message and exit
  -db DATABASE, --database DATABASE
                        'pathway', 'transcription', 'ontology', 'diseases_drugs', 'celltypes', 'kinase_interactions'or any database listed at: https://maayanlab.cloud/Enrichr/#libraries or the species-specific libraries listed in the documentation
  -s {human,mouse,fly,yeast,worm,fish}, --species {human,mouse,fly,yeast,worm,fish}
                        Enrichr variant to query. Default: 'human'. (default: human)
  -bkg_l [BACKGROUND_LIST ...], --background_list [BACKGROUND_LIST ...]
                        List of gene names/Ensembl IDs to be used as background genes. ONLY SUPPORTED FOR HUMAN/MOUSE SPECIES
  -bkg, --background    If True, use set of >20,000 default background genes listed here: https://github.com/pachterlab/gget/blob/main/gget/constants/enrichr_bkg_genes.txt. ONLY SUPPORTED FOR HUMAN/MOUSE SPECIES
  -e, --ensembl         Add this flag if genes are given as Ensembl gene IDs.
  -e_b, --ensembl_bkg   Add this flag if background genes are given as Ensembl gene IDs.
  -ko KEGG_OUT, --kegg_out KEGG_OUT
                        Path to file to save the highlighted KEGG pathway image, e.g. path/to/folder/kegg_pathway.png.
  -kr KEGG_RANK, --kegg_rank KEGG_RANK
                        Candidate pathway rank to be plotted in KEGG pathway image. (default: 1)
  -csv, --csv           Returns results in csv format instead of json.
  -o OUT, --out OUT     Path to the csv file the results will be saved in, e.g. path/to/directory/results.csv.Default: Standard out.
  -q, --quiet           Does not print progress information.
  -g GENES_DEPRECATED [GENES_DEPRECATED ...], --genes GENES_DEPRECATED [GENES_DEPRECATED ...]
                        DEPRECATED - use positional argument instead. List of gene symbols or Ensembl gene IDs to perform enrichment analysis on.
  -j, --json            DEPRECATED - json is now the default output format (convert to csv using flag [--csv]).
```

## gget_archs4

### Tool Description
Find the most correlated genes or the tissue expression atlas of a gene using data from the human and mouse RNA-seq database ARCHS4 (https://maayanlab.cloud/archs4/).

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget archs4 [-h] [-e] [-w {correlation,tissue}] [-gc GENE_COUNT]
                   [-s {human,mouse}] [-csv] [-o OUT] [-q]
                   [-g GENE_DEPRECATED] [-j]
                   gene

Find the most correlated genes or the tissue expression atlas of a gene using data from the human and mouse RNA-seq database ARCHS4 (https://maayanlab.cloud/archs4/).

positional arguments:
  gene                  Gene symbol or Ensembl gene ID of gene of interest, e.g. 'STAT4'.

optional arguments:
  -h, --help            show this help message and exit
  -e, --ensembl         Add this flag if gene is given as an Ensembl gene ID.
  -w {correlation,tissue}, --which {correlation,tissue}
                        'correlation' (default) or 'tissue'.
                        - 'correlation' returns a gene correlation table that contains the 100 most correlated genes to the gene of interest. The Pearson correlation is calculated over all samples and tissues in ARCHS4.
                        - 'tissue' returns a tissue expression atlas calculated from human or mouse samples (as defined by 'species') in ARCHS4. (default: correlation)
  -gc GENE_COUNT, --gene_count GENE_COUNT
                        Number of correlated genes to return (default: 100).
                        (Only for gene correlation.) (default: 100)
  -s {human,mouse}, --species {human,mouse}
                        'human' (default) or 'mouse'. (Only for tissue expression atlas.) (default: human)
  -csv, --csv           Returns results in csv format instead of json.
  -o OUT, --out OUT     Path to the csv file the results will be saved in, e.g. path/to/directory/results.csv.
                        Default: Standard out.
  -q, --quiet           Does not print progress information.
  -g GENE_DEPRECATED, --gene GENE_DEPRECATED
                        DEPRECATED - use positional argument instead. Gene symbol or Ensembl gene ID of gene of interest (str), e.g. 'STAT4'.
  -j, --json            DEPRECATED - json is now the default output format (convert to csv using flag [--csv]).
```

## gget_alphafold

### Tool Description
Predicts the structure of a protein using a simplified version of AlphaFold v2.3.0 (https://doi.org/10.1038/s41586-021-03819-2).

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget alphafold [-h] [-mfm] [-mr MULTIMER_RECYCLES] [-r] [-o OUT] [-q]
                      sequence [sequence ...]

Predicts the structure of a protein using a simplified version of AlphaFold v2.3.0 (https://doi.org/10.1038/s41586-021-03819-2).

positional arguments:
  sequence              Sequence (str), list of sequences, or path to fasta file.

optional arguments:
  -h, --help            show this help message and exit
  -mfm, --multimer_for_monomer
                        Use multimer model for a monomer.
  -mr MULTIMER_RECYCLES, --multimer_recycles MULTIMER_RECYCLES
                        The multimer model will continue recycling until the predictions stop changing, up to the limit set here.
                        For higher accuracy, at the potential cost of longer inference times, set this to 20. (default: 3)
  -r, --relax           AMBER relax the best model.
  -o OUT, --out OUT     Path to folder the predicted aligned error (json) and the prediction (PDB) will be saved in.
                        Default: ./[date_time]_gget_alphafold_prediction
  -q, --quiet           Does not print progress information.
```

## gget_pdb

### Tool Description
Query RCSB PDB for the protein structutre/metadata of a given PDB ID.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget pdb [-h]
                [-r {pdb,entry,pubmed,assembly,branched_entity,nonpolymer_entity,polymer_entity,uniprot,branched_entity_instance,polymer_entity_instance,nonpolymer_entity_instance}]
                [-i IDENTIFIER] [-o OUT]
                pdb_id

Query RCSB PDB for the protein structutre/metadata of a given PDB ID.

positional arguments:
  pdb_id                PDB ID to be queried, e.g. '7S7U'.

optional arguments:
  -h, --help            show this help message and exit
  -r {pdb,entry,pubmed,assembly,branched_entity,nonpolymer_entity,polymer_entity,uniprot,branched_entity_instance,polymer_entity_instance,nonpolymer_entity_instance}, --resource {pdb,entry,pubmed,assembly,branched_entity,nonpolymer_entity,polymer_entity,uniprot,branched_entity_instance,polymer_entity_instance,nonpolymer_entity_instance}
                        Defines type of information to be returned.
                        
                        "pdb": Returns the protein structure in PDB format.
                        "entry": Information about PDB structures at the top level of PDB structure hierarchical data organization.
                        "pubmed": Get PubMed annotations (data integrated from PubMed) for a given entry's primary citation.
                        "assembly": Information about PDB structures at the quaternary structure level.
                        "branched_entity": Get branched entity description (define entity ID as "identifier").
                        "nonpolymer_entity": Get non-polymer entity data (define entity ID as "identifier").
                        "polymer_entity": Get polymer entity data (define entity ID as "identifier").
                        "uniprot": Get UniProt annotations for a given macromolecular entity (define entity ID as "identifier").
                        "branched_entity_instance": Get branched entity instance description (define chain ID as "identifier").
                        "polymer_entity_instance": Get polymer entity instance (a.k.a chain) data (define chain ID as "identifier").
                        "nonpolymer_entity_instance": Get non-polymer entity instance description (define chain ID as "identifier"). (default: pdb)
  -i IDENTIFIER, --identifier IDENTIFIER
                        Can be used to define assembly, entity or chain ID if applicable (default: None).
                        Assembly/entity IDs are numbers (e.g. 1), and chain IDs are letters (e.g. A).
  -o OUT, --out OUT     Path to the file the results will be saved in, e.g. path/to/directory/7S7U.pdb or path/to/directory/7S7U_entry.json.
                        Resource 'pdb' is returned in PDB format. All other resources are returned in JSON format.
                        Default: Standard out.
```

## gget_cellxgene

### Tool Description
Query data from CZ CELLxGENE Discover (https://cellxgene.cziscience.com/).

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget cellxgene [-h] -o OUT [-cv CENSUS_VERSION]
                      [-s {homo_sapiens,mus_musculus}] [-g GENE [GENE ...]]
                      [-e] [-cn COLUMN_NAMES [COLUMN_NAMES ...]] [-mo]
                      [--tissue TISSUE [TISSUE ...]]
                      [--cell_type CELL_TYPE [CELL_TYPE ...]]
                      [--development_stage DEVELOPMENT_STAGE [DEVELOPMENT_STAGE ...]]
                      [--disease DISEASE [DISEASE ...]] [--sex SEX [SEX ...]]
                      [-is] [--dataset_id DATASET_ID [DATASET_ID ...]]
                      [--tissue_general_ontology_term_id TISSUE_GENERAL_ONTOLOGY_TERM_ID [TISSUE_GENERAL_ONTOLOGY_TERM_ID ...]]
                      [--tissue_general TISSUE_GENERAL [TISSUE_GENERAL ...]]
                      [--tissue_ontology_term_id TISSUE_ONTOLOGY_TERM_ID [TISSUE_ONTOLOGY_TERM_ID ...]]
                      [--assay_ontology_term_id ASSAY_ONTOLOGY_TERM_ID [ASSAY_ONTOLOGY_TERM_ID ...]]
                      [--assay ASSAY [ASSAY ...]]
                      [--cell_type_ontology_term_id CELL_TYPE_ONTOLOGY_TERM_ID [CELL_TYPE_ONTOLOGY_TERM_ID ...]]
                      [--development_stage_ontology_term_id DEVELOPMENT_STAGE_ONTOLOGY_TERM_ID [DEVELOPMENT_STAGE_ONTOLOGY_TERM_ID ...]]
                      [--disease_ontology_term_id DISEASE_ONTOLOGY_TERM_ID [DISEASE_ONTOLOGY_TERM_ID ...]]
                      [--donor_id DONOR_ID [DONOR_ID ...]]
                      [--self_reported_ethnicity_ontology_term_id SELF_REPORTED_ETHNICITY_ONTOLOGY_TERM_ID [SELF_REPORTED_ETHNICITY_ONTOLOGY_TERM_ID ...]]
                      [--self_reported_ethnicity SELF_REPORTED_ETHNICITY [SELF_REPORTED_ETHNICITY ...]]
                      [--sex_ontology_term_id SEX_ONTOLOGY_TERM_ID [SEX_ONTOLOGY_TERM_ID ...]]
                      [--suspension_type SUSPENSION_TYPE [SUSPENSION_TYPE ...]]
                      [-q]

Query data from CZ CELLxGENE Discover (https://cellxgene.cziscience.com/).

optional arguments:
  -h, --help            show this help message and exit
  -o OUT, --out OUT     Path to save the generated AnnData .h5ad file (or .csv with --meta_only).
  -cv CENSUS_VERSION, --census_version CENSUS_VERSION
                        Census version, e.g. '2023-05-15' or 'latest' or 'stable'. (default: stable)
  -s {homo_sapiens,mus_musculus}, --species {homo_sapiens,mus_musculus}
                        Choice of 'homo_sapiens' or 'mus_musculus'. (default: homo_sapiens)
  -g GENE [GENE ...], --gene GENE [GENE ...]
                        Str or space-separated list of gene name(s) or Ensembl ID(s), e.g. ACE2 SLC5A1 or ENSG00000130234 ENSG00000100170NOTE: Set ensembl=True when providing Ensembl ID(s) instead of gene name(s).
  -e, --ensembl         Use this flag when genes are provided as Ensembl IDs.
  -cn COLUMN_NAMES [COLUMN_NAMES ...], --column_names COLUMN_NAMES [COLUMN_NAMES ...]
                        List of metadata columns to return (stored in .obs).
                        For more options see: https://api.cellxgene.cziscience.com/curation/ui/#/ -> Schemas -> dataset (default: ['dataset_id', 'assay', 'suspension_type', 'sex', 'tissue_general', 'tissue', 'cell_type'])
  -mo, --meta_only      Only returns metadata dataframe (corresponds to AnnData.obs).
  --tissue TISSUE [TISSUE ...]
                        Str or space-separated list of tissue(s), e.g. lung blood
  --cell_type CELL_TYPE [CELL_TYPE ...]
                        Str or space-separated list of cell_type(s), e.g. 'mucus secreting cell' 'neuroendocrine cell'
  --development_stage DEVELOPMENT_STAGE [DEVELOPMENT_STAGE ...]
                        Str or space-separated list of development_stage(s).
  --disease DISEASE [DISEASE ...]
                        Str or space-separated list of disease(s).
  --sex SEX [SEX ...]   Str or space-separated list of sex(es).
  -is, --include_secondary
                        Do not restrict results to the canonical instance of the cellular observation.
  --dataset_id DATASET_ID [DATASET_ID ...]
                        Str or space-separated list of CELLxGENE dataset ID(s).
  --tissue_general_ontology_term_id TISSUE_GENERAL_ONTOLOGY_TERM_ID [TISSUE_GENERAL_ONTOLOGY_TERM_ID ...]
                        Str or space-separated list of high-level tissue UBERON ID(s).Also see: https://github.com/chanzuckerberg/single-cell-data-portal/blob/9b94ccb0a2e0a8f6182b213aa4852c491f6f6aff/backend/wmg/data/tissue_mapper.py
  --tissue_general TISSUE_GENERAL [TISSUE_GENERAL ...]
                        Str or space-separated list of high-level tissue label(s).Also see: https://github.com/chanzuckerberg/single-cell-data-portal/blob/9b94ccb0a2e0a8f6182b213aa4852c491f6f6aff/backend/wmg/data/tissue_mapper.py
  --tissue_ontology_term_id TISSUE_ONTOLOGY_TERM_ID [TISSUE_ONTOLOGY_TERM_ID ...]
                        Str or space-separated list of tissue ontology term ID(s).
  --assay_ontology_term_id ASSAY_ONTOLOGY_TERM_ID [ASSAY_ONTOLOGY_TERM_ID ...]
                        Str or space-separated list of assay ontology term ID(s).
  --assay ASSAY [ASSAY ...]
                        Str or space-separated list of assay(s).
  --cell_type_ontology_term_id CELL_TYPE_ONTOLOGY_TERM_ID [CELL_TYPE_ONTOLOGY_TERM_ID ...]
                        Str or space-separated list of celltype ontology term ID(s).
  --development_stage_ontology_term_id DEVELOPMENT_STAGE_ONTOLOGY_TERM_ID [DEVELOPMENT_STAGE_ONTOLOGY_TERM_ID ...]
                        Str or space-separated list of development stage ontology term ID(s).
  --disease_ontology_term_id DISEASE_ONTOLOGY_TERM_ID [DISEASE_ONTOLOGY_TERM_ID ...]
                        Str or space-separated list of disease ontology term ID(s).
  --donor_id DONOR_ID [DONOR_ID ...]
                        Str or space-separated list of donor ID(s).
  --self_reported_ethnicity_ontology_term_id SELF_REPORTED_ETHNICITY_ONTOLOGY_TERM_ID [SELF_REPORTED_ETHNICITY_ONTOLOGY_TERM_ID ...]
                        Str or space-separated list of self reported ethnicity ontology ID(s).
  --self_reported_ethnicity SELF_REPORTED_ETHNICITY [SELF_REPORTED_ETHNICITY ...]
                        Str or space-separated list of self reported ethnicity.
  --sex_ontology_term_id SEX_ONTOLOGY_TERM_ID [SEX_ONTOLOGY_TERM_ID ...]
                        Str or space-separated list of sex ontology ID(s).
  --suspension_type SUSPENSION_TYPE [SUSPENSION_TYPE ...]
                        Str or space-separated list of suspension type(s).
  -q, --quiet           Do not print progress information.
```

## gget_cosmic

### Tool Description
Query information about genes, mutations, etc. associated with cancers from the COSMIC database.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget cosmic [-h]
                   [-e {mutations,genes,cancer,tumour_site,studies,pubmed,samples}]
                   [-l LIMIT] [-csv] [-d]
                   [-mc {cancer,cell_line,census,resistance,genome_screen,targeted_screen,cancer_example}]
                   [-cv COSMIC_VERSION] [-gv {37,38}] [-gm]
                   [--keep_genome_info] [--remove_duplicates] [-o OUT] [-q]
                   [searchterm]

Query information about genes, mutations, etc. associated with cancers from the COSMIC database.

positional arguments:
  searchterm            Search term, which can be a mutation, gene name (or Ensembl ID), sample, etc.
                        Examples for the searchterm and entitity arguments:
                        
                        | searchterm   | entity       |
                        |--------------|--------------|
                        | EGFR         | mutations    | -> Find mutations in the EGFR gene that are associated with cancer
                        | v600e        | mutations    | -> Find genes for which a v600e mutation is associated with cancer
                        | COSV57014428 | mutations    | -> Find mutations associated with this COSMIC mutations ID
                        | EGFR         | genes        | -> Get the number of samples, coding/simple mutations, and fusions observed in COSMIC for EGFR
                        | prostate     | cancer       | -> Get number of tested samples and mutations for prostate cancer
                        | prostate     | tumour_site  | -> Get number of tested samples, genes, mutations, fusions, etc. with 'prostate' as primary tissue site
                        | ICGC         | studies      | -> Get project code and descriptions for all studies from the ICGC (International Cancer Genome Consortium)
                        | EGFR         | pubmed       | -> Find PubMed publications on EGFR and cancer
                        | ICGC         | samples      | -> Get metadata on all samples from the ICGC (International Cancer Genome Consortium)
                        | COSS2907494  | samples      | -> Get metadata on this COSMIC sample ID (cancer type, tissue, # analyzed genes, # mutations, etc.)

optional arguments:
  -h, --help            show this help message and exit
  -e {mutations,genes,cancer,tumour_site,studies,pubmed,samples}, --entity {mutations,genes,cancer,tumour_site,studies,pubmed,samples}
                        Defines the type of the results to return. (default: mutations)
  -l LIMIT, --limit LIMIT
                        Number of hits to return. (default: 100)
  -csv, --csv           Returns results in csv format instead of json.
  -d, --download_cosmic
                        Switch into database download mode.
  -mc {cancer,cell_line,census,resistance,genome_screen,targeted_screen,cancer_example}, --mutation_class {cancer,cell_line,census,resistance,genome_screen,targeted_screen,cancer_example}
                        Type of COSMIC database to download (only for use with --download_cosmic). (default: cancer)
  -cv COSMIC_VERSION, --cosmic_version COSMIC_VERSION
                        Version of the COSMIC database (only for use with --download_cosmic). Default: None -> Defaults to latest version.
  -gv {37,38}, --grch_version {37,38}
                        Version of the human GRCh reference genome (only for use with --download_cosmic). (default: 37)
  -gm, --gget_mutate    Do NOT create a modified version of the database for use with gget mutate (only for use with --download_cosmic).
  --keep_genome_info    Whether to keep genome information (e.g. location of mutation in the genome) in the modified database for use with gget mutate (only for use with --download_cosmic).
  --remove_duplicates   Whether to remove duplicated rows from the modified database for use with gget mutate (only for use with --download_cosmic).
  -o OUT, --out OUT     Path to the file (or folder when downloading databases with the download_cosmic flag) the results will be saved in, e.g. path/to/results.json.
                        Default: None
                        -> When download_cosmic=False: Results will be returned to standard out
                        -> When download_cosmic=True: Database will be downloaded into current working directory
  -q, --quiet           Do not print progress information.
```

## gget_mutate

### Tool Description
Mutate nucleotide sequences based on provided mutations.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget mutate [-h] -m MUTATIONS [MUTATIONS ...] [-mc MUT_COLUMN]
                   [-sic SEQ_ID_COLUMN] [-mic MUT_ID_COLUMN] [-gtf GTF]
                   [-gtic GTF_TRANSCRIPT_ID_COLUMN] [-k K] [-msl MIN_SEQ_LEN]
                   [-ma MAX_AMBIGUOUS] [-ofr] [-rswk] [-mio] [-udf]
                   [-udf_o UPDATE_DF_OUT] [--translate] [-ts TRANSLATE_START]
                   [--translate_end TRANSLATE_END] [-sfs] [-o OUT] [-q]
                   sequences [sequences ...]

Mutate nucleotide sequences based on provided mutations.

positional arguments:
  sequences             (str) Path to the fasta file containing the sequences to be mutated, e.g., 'seqs.fa'.
                        Sequence identifiers following the '>' character must correspond to the identifiers
                        in the seq_ID column of 'mutations'.
                        NOTE: Only string until first space or dot will be used as sequence identifier
                        - Version numbers of Ensembl IDs will be ignored.
                        
                        Example:
                        >seq1 (or ENSG00000106443)
                        ACTGCGATAGACT
                        >seq2
                        AGATCGCTAG
                        
                        Alternatively: Input sequence(s) as a string or list, e.g. 'AGCTAGCT' or 'ACTGCTAGCT' 'AGCTAGCT'.

optional arguments:
  -h, --help            show this help message and exit
  -m MUTATIONS [MUTATIONS ...], --mutations MUTATIONS [MUTATIONS ...]
                        Path to csv or tsv file (e.g., 'mutations.csv') containing information about the mutations in the following format:
                        
                        | mutation             | mut_ID | seq_ID |
                        | c.1252C>T            | mut1   | seq1   | -> Apply mutation 1 to sequence 1
                        | c.2239_2253inv       | mut2   | seq2   | -> Apply mutation 2 to sequence 2
                        | c.2239_2253inv       | mut2   | seq3   | -> Apply mutation 2 to sequence 3
                        | c.2239_2253delinsAAT | mut3   | seq3   | -> Apply mutation 3 to sequence 3
                        | ...                  | ...    | ...    |
                        
                        'mutation' = Column containing the mutations to be performed written in standard mutation annotation (see below)
                        'mut_ID' = Column containing an identifier for each mutation (optional)
                        'seq_ID' = Column containing the identifiers of the sequences to be mutated
                        (sequence IDs must correspond to the string following the > character in the input fasta; do NOT include spaces or dots)
                        
                        Alternatively: Input mutation(s) as a string or list, e.g. 'c.2C>T' or 'c.2C>T' 'c.1A>C'
                        
                        NOTE: Enclose individual mutation annotations in quotation marks to prevent terminal parsing errors.
                        If a list is passed, the number of mutations must equal the number of input sequences.
  -mc MUT_COLUMN, --mut_column MUT_COLUMN
                        Name of the column containing the mutations to be performed in 'mutations'. (default: mutation)
  -sic SEQ_ID_COLUMN, --seq_id_column SEQ_ID_COLUMN
                        Name of the column containing the IDs of the sequences to be mutated in 'mutations'. (default: seq_ID)
  -mic MUT_ID_COLUMN, --mut_id_column MUT_ID_COLUMN
                        Name of the column containing the IDs of each mutation in 'mutations'. Default: Same as 'mut_column'.
  -gtf GTF, --gtf GTF   Path to a .gtf file. When providing a genome fasta file as input for 'sequences', you can provide a .gtf file here and the input sequences will be defined according to the transcript boundaries, e.g. 'path/to/genome_annotation.gtf'.
  -gtic GTF_TRANSCRIPT_ID_COLUMN, --gtf_transcript_id_column GTF_TRANSCRIPT_ID_COLUMN
                        Column name in the input 'mutations' file containing the transcript ID. In this case, column 'seq_id_column' should contain the chromosome number. Required when 'gtf' is provided.
  -k K, --k K           Length of sequences flanking the mutation. If k > total length of the sequence, the entire sequence will be kept. (default: 30)
  -msl MIN_SEQ_LEN, --min_seq_len MIN_SEQ_LEN
                        Minimum length of the mutant output sequence, e.g. 100. Mutant sequences smaller than this will be dropped.
  -ma MAX_AMBIGUOUS, --max_ambiguous MAX_AMBIGUOUS
                        Maximum number of 'N' (or 'n') characters allowed in the output sequence, e.g. 10. Default: None (no ambiguous character filter will be applied).
  -ofr, --optimize_flanking_regions
                        Removes nucleotides from either end of the mutant sequence to ensure (when possible) that the mutant sequence does not contain any k-mers also found in the wildtype/input sequence.
  -rswk, --remove_seqs_with_wt_kmers
                        Removes output sequences where at least one k-mer is also present in the wildtype/input sequence in the same region. When used with `--optimize_flanking_regions`, only sequences for which a wildtpye kmer is still present after optimization will be removed.
  -mio, --merge_identical_off
                        Do not merge identical mutant sequences in the output (by default, identical sequences will be merged by concatenating the sequence headers for all identical sequences).
  -udf, --update_df     Updates the input `mutations` DataFrame to include additional columns with the mutation type, wildtype nucleotide sequence, and mutant nucleotide sequence (only valid if `mutations` is a .csv or .tsv file).
  -udf_o UPDATE_DF_OUT, --update_df_out UPDATE_DF_OUT
                        Path to output csv file containing the updated DataFrame, e.g. 'path/to/mutations_updated.csv'. Only valid when used with `--update_df`. Default: None -> the new csv file will be saved in the same directory as the `mutations` DataFrame with appendix '_updated'.
  --translate           Adds additional columns to the updated `mutations` DataFrame containing the wildtype and mutant amino acid sequences. Only valid when used with `--store_full_sequences`.
  -ts TRANSLATE_START, --translate_start TRANSLATE_START
                        (int or str) The position in the input nucleotide sequence to start translating, e.g. 5. If a string is provided, it should correspond to a column name in `mutations` containing the open reading frame start positions for each sequence/mutation. Only valid when used with `--translate`. Default: translates from the beginning of each sequence.
  --translate_end TRANSLATE_END
                        (int or str) The position in the input nucleotide sequence to end translating, e.g. 35. If a string is provided, it should correspond to a column name in `mutations` containing the open reading frame end positions for each sequence/mutation. Only valid when used with `--translate`. Default: translates until the end of each sequence.
  -sfs, --store_full_sequences
                        Includes the complete wildtype and mutant sequences in the updated `mutations` DataFrame (not just the sub-sequence with k-length flanks). Only valid when used with `--update_df`.
  -o OUT, --out OUT     Path to output fasta file containing the mutated sequences, e.g., 'path/to/output_fasta.fa'.
                        Default: None -> returns a list of the mutated sequences to standard out.
                        The identifiers (following the '>') of the mutated sequences in the output fasta will be '>[seq_ID]_[mut_ID]'.
  -q, --quiet           Do not print progress information.
```

## gget_opentargets

### Tool Description
Query the Open Targets Platform with a gene for associated drugs, diseases, tractability stats, pharmacogenetic responses, expression data, DepMap effects, and protein-protein interaction data.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget opentargets [-h]
                        [-r {diseases,drugs,tractability,pharmacogenetics,expression,depmap,interactions}]
                        [-l LIMIT] [-o OUT]
                        [-fd FILTER_DISEASE [FILTER_DISEASE ...]]
                        [-fc FILTER_DRUG [FILTER_DRUG ...]]
                        [-ft FILTER_TISSUE [FILTER_TISSUE ...]]
                        [-fa FILTER_ANAT_SYS [FILTER_ANAT_SYS ...]]
                        [-fo FILTER_ORGAN [FILTER_ORGAN ...]]
                        [-fpa FILTER_PROTEIN_A [FILTER_PROTEIN_A ...]]
                        [-fpb FILTER_PROTEIN_B [FILTER_PROTEIN_B ...]]
                        [-fgb FILTER_GENE_B [FILTER_GENE_B ...]] [-csv] [-q]
                        [-or]
                        ens_id

Query the Open Targets Platform with a gene for associated drugs, diseases, tractability stats, pharmacogenetic responses, expression data, DepMap effects, and protein-protein interaction data.

positional arguments:
  ens_id                Ensembl gene ID, e.g. ENSG00000169194.

optional arguments:
  -h, --help            show this help message and exit
  -r {diseases,drugs,tractability,pharmacogenetics,expression,depmap,interactions}, --resource {diseases,drugs,tractability,pharmacogenetics,expression,depmap,interactions}
                        Type of information to be returned. (default: diseases)
  -l LIMIT, --limit LIMIT
                        Limits the number of results, e.g. 10 (default: None). Note: Not compatible with the 'tractability' and 'depmap' resources
  -o OUT, --out OUT     Path to the file the results will be saved in, e.g. path/to/directory/results.json.
                        Default: Standard out.
  -fd FILTER_DISEASE [FILTER_DISEASE ...], --filter_disease FILTER_DISEASE [FILTER_DISEASE ...]
                        Filter results by disease ID, e.g. 'EFO_0000274'.
                        Only valid for the 'drugs' resource.
  -fc FILTER_DRUG [FILTER_DRUG ...], --filter_drug FILTER_DRUG [FILTER_DRUG ...]
                        Filter results by drug ID, e.g. 'CHEMBL1743081'.
                        Only valid for the 'pharmacogenetics' resource.
  -ft FILTER_TISSUE [FILTER_TISSUE ...], --filter_tissue FILTER_TISSUE [FILTER_TISSUE ...]
                        Filter results by tissue ID, e.g. 'UBERON_0000473'.
                        Only valid for the following resources: 'expression', 'depmap'.
  -fa FILTER_ANAT_SYS [FILTER_ANAT_SYS ...], --filter_anat_sys FILTER_ANAT_SYS [FILTER_ANAT_SYS ...]
                        Filter results by anatomical system, e.g. 'nervous system'.
                        Only valid for the 'expression' resource.
  -fo FILTER_ORGAN [FILTER_ORGAN ...], --filter_organ FILTER_ORGAN [FILTER_ORGAN ...]
                        Filter results by organ, e.g. 'brain'.
                        Only valid for the 'expression' resource.
  -fpa FILTER_PROTEIN_A [FILTER_PROTEIN_A ...], --filter_protein_a FILTER_PROTEIN_A [FILTER_PROTEIN_A ...]
                        Filter results by protein A ID, e.g. 'ENSP00000304915'.
                        Only valid for the 'interactions' resource.
  -fpb FILTER_PROTEIN_B [FILTER_PROTEIN_B ...], --filter_protein_b FILTER_PROTEIN_B [FILTER_PROTEIN_B ...]
                        Filter results by protein B ID, e.g. 'ENSP00000379111'.
                        Only valid for the 'interactions' resource.
  -fgb FILTER_GENE_B [FILTER_GENE_B ...], --filter_gene_b FILTER_GENE_B [FILTER_GENE_B ...]
                        Filter results by gene B ID, e.g. 'ENSG00000077238'.
                        Only valid for the 'interactions' resource.
  -csv, --csv           Returns results in csv format instead of json.
  -q, --quiet           Does not print progress information.
  -or, --or             Use OR instead of AND logic for multiple filter IDs.
```

## gget_bgee

### Tool Description
Query the Bgee database for orthology and gene expression data using Ensembl IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget bgee [-h] -t {orthologs,expression} [-o OUT] [-csv] [-q] ens_id

Query the Bgee database for orthology and gene expression data using Ensembl IDs.

positional arguments:
  ens_id                Ensembl gene ID, e.g. ENSG00000169194 or ENSSSCG00000014725.

optional arguments:
  -h, --help            show this help message and exit
  -t {orthologs,expression}, --type {orthologs,expression}
                        Type of information to be returned.
  -o OUT, --out OUT     Path to the file the results will be saved in, e.g. path/to/directory/results.json.
                        Default: Standard out.
  -csv, --csv           Returns results in csv format instead of json.
  -q, --quiet           Does not print progress information.
```

## gget_cbio_search

### Tool Description
Search for genes in cBioPortal.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget cbio search [-h] keywords [keywords ...]

Search for genes in cBioPortal.

positional arguments:
  keywords    Keywords to search for in cBioPortal.

optional arguments:
  -h, --help  show this help message and exit
```

## gget_cbio_plot

### Tool Description
Plot a heatmap of cancer genomics data.

### Metadata
- **Docker Image**: quay.io/biocontainers/gget:0.29.0--pyhdfd78af_0
- **Homepage**: https://github.com/pachterlab/gget
- **Package**: https://anaconda.org/channels/bioconda/packages/gget/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gget cbio plot [-h] -s STUDY_IDS [STUDY_IDS ...] -g GENES [GENES ...]
                      [-st {tissue,cancer_type,cancer_type_detailed,study_id,sample}]
                      [-vt {mutation_occurrences,cna_nonbinary,sv_occurrences,cna_occurrences,Consequence}]
                      [-f FILTER] [-dd DATA_DIR] [-fd FIGURE_DIR]
                      [-fn FILENAME] [-t TITLE] [-dpi DPI] [-q] [-nc] [-sh]

Plot a heatmap of cancer genomics data.

optional arguments:
  -h, --help            show this help message and exit
  -s STUDY_IDS [STUDY_IDS ...], --study_ids STUDY_IDS [STUDY_IDS ...]
                        Space-separated list of cBioPortal study IDs, e.g. `msk_impact_2017 egc_msk_2023`
  -g GENES [GENES ...], --genes GENES [GENES ...]
                        Space-separated list of gene names or Ensembl IDs, e.g. `NOTCH3 ENSG00000108375`
  -st {tissue,cancer_type,cancer_type_detailed,study_id,sample}, --stratification {tissue,cancer_type,cancer_type_detailed,study_id,sample}
                        Column to stratify the heatmap by. (default: tissue)
  -vt {mutation_occurrences,cna_nonbinary,sv_occurrences,cna_occurrences,Consequence}, --variation_type {mutation_occurrences,cna_nonbinary,sv_occurrences,cna_occurrences,Consequence}
                        Type of variation to plot (default: mutation_occurrences)
  -f FILTER, --filter FILTER
                        Filter the heatmap by a specific value in a specific column, e.g. `tissue:intestine`
  -dd DATA_DIR, --data_dir DATA_DIR
                        Directory to store downloaded data (default: ./gget_cbio_cache) (default: gget_cbio_cache)
  -fd FIGURE_DIR, --figure_dir FIGURE_DIR
                        Directory to store generated figures (default: ./gget_cbio_figures) (default: gget_cbio_figures)
  -fn FILENAME, --filename FILENAME
                        Filename for the generated figure, relative to `figure_dir` (default: auto-generated)
  -t TITLE, --title TITLE
                        Title for the generated figure (default: auto-generated)
  -dpi DPI, --dpi DPI   DPI of the generated figures (default: 100) (default: 100)
  -q, --quiet           Does not print progress information.
  -nc, --no_confirm     Skip confirmation before downloading data.
  -sh, --show           Show the plot in a window
```

## Metadata
- **Skill**: generated
