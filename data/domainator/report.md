# domainator CWL Generation Report

## domainator_domainate.py

### Tool Description
Annotate sequence files with hmm profiles

For each CDS or protein in the input file, run the hmmer3 against the target domain hmm database to annotate all the different known/detectable domains in the CDS.
Hits with E value lower than the threshold (default 10) will be added to the annotation in genbank output file as a new "feature"

### Metadata
- **Docker Image**: quay.io/biocontainers/domainator:0.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/nebiolabs/domainator
- **Package**: https://anaconda.org/channels/bioconda/packages/domainator/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/domainator/overview
- **Total Downloads**: 66
- **Last updated**: 2026-02-06
- **GitHub**: https://github.com/nebiolabs/domainator
- **Stars**: N/A
### Original Help Text
```text
usage: 
version: 0.8.1

Annotate sequence files with hmm profiles

For each CDS or protein in the input file, run the hmmer3 against the target domain hmm database to annotate all the different known/detectable domains in the CDS.
Hits with E value lower than the threshold (default 10) will be added to the annotation in genbank output file as a new "feature"

NOTES: genbank files that contain translation annotations in their CDS features will run much faster than those without translation annotations.
       domainate.py stores the entire reference set (usually the hmm database) in memory, so it is not suitable for cases where the reference 
       set is larger than your system memory (this may change in future versions).

       [-h] [-i INPUT [INPUT ...]] [--fasta_type {nucleotide,protein}]
       [-r REFERENCES [REFERENCES ...]] [--foldseek FOLDSEEK [FOLDSEEK ...]]
       [--esm2_3Di_weights ESM2_3DI_WEIGHTS]
       [--esm2_3Di_device ESM2_3DI_DEVICE] [-o OUTPUT] [-Z Z] [-e EVALUE]
       [--min_evalue MIN_EVALUE] [--max_domains MAX_DOMAINS] [--max_mode]
       [--include_taxids INCLUDE_TAXIDS [INCLUDE_TAXIDS ...]]
       [--exclude_taxids EXCLUDE_TAXIDS [EXCLUDE_TAXIDS ...]]
       [--ncbi_taxonomy_path NCBI_TAXONOMY_PATH] [--taxonomy_update]
       [--cpu CPU] [--max_overlap MAX_OVERLAP] [--overlap_by_db] [--hits_only]
       [--no_annotations] [--batch_size BATCH_SIZE] [--offset OFFSET]
       [--recs_to_read RECS_TO_READ] [--gene_call {all,unannotated}]
       [--config CONFIG] [--print_config [=flags]]

options:
  -h, --help            show this help message and exit
  -i, --input INPUT [INPUT ...]
                        the genbank or fasta files to annotate. Genbank files can be nucleotide (with CDS annotations) or peptide. Fasta files must be peptide. (default: None)
  --fasta_type {nucleotide,protein}
                        Whether the sequences in fasta files are protein or nucleotide sequences. (default: protein)
  -r, --references REFERENCES [REFERENCES ...]
                        the names of the HMM files with profiles to search. Or reference protein fasta files. (default: None)
  --foldseek FOLDSEEK [FOLDSEEK ...]
                        Foldseek database files. (default: None)
  --esm2_3Di_weights ESM2_3DI_WEIGHTS
                        checkpoint file for esm2_3Di model. (default: None)
  --esm2_3Di_device ESM2_3DI_DEVICE
                        device to use for esm2_3Di model. (default: cuda:0)
  -o, --output OUTPUT   output genbank filename. If not supplied, writes to stdout. (default: None)
  -Z Z                  Passed as the -Z parameter to hmmsearch: Assert that the total number of targets in your searches is <x>, for the purposes of per-sequence E-value calculations, rather than the actual number of targets seen. Default: 1000
                        Set to 0 to use the number actual target sequences (currently this does does not account for taxonomic filtering).Supplying -Z is recommended for most use cases of domainate, as it will speed up the search and make comparisons between searches more meaningful. (default: 1000)
  -e, --evalue EVALUE   threshold E value for the domain hit. Must be <=10. [default 0.001] (default: 0.001)
  --min_evalue MIN_EVALUE
                        hits with E value LOWER (as in BETTER) than this will be filtered out. NOT FREQUENTLY USED. Use only if you want to eliminate close matches. Must be >=0. [default 0] (default: 0.0)
  --max_domains MAX_DOMAINS
                        the maximum number of domains to be reported per CDS. If not specified, then no max_domains filter is applied. (default: 0)
  --max_mode            Run hmmsearch/phmmer in maximum sensitivity mode, which is much slower, but more sensitive. (default: False)
  --include_taxids INCLUDE_TAXIDS [INCLUDE_TAXIDS ...]
                        Space separated list of taxids to include. Contigs with taxonomy not in this list will be skipped. (default: None)
  --exclude_taxids EXCLUDE_TAXIDS [EXCLUDE_TAXIDS ...]
                        Space separated list of taxids to exclude. Contigs with taxonomy in this list will be skipped. (default: None)
  --ncbi_taxonomy_path NCBI_TAXONOMY_PATH
                        Path to NCBI taxonomy database directory. Will be created and downloaded if it does not exist. (default: /tmp/ncbi_taxonomy)
  --taxonomy_update     If taxonomy database exists, check it against the version on the ncbi server and update if there is a newer version. (default: False)
  --cpu CPU             the number of cores of the cpu which are used at a time to run the search [default: use all available cores] (default: 0)
  --max_overlap MAX_OVERLAP
                        the maximum fractional of overlap between domains to be included in the annotated genbank. If >= 1, then no overlap filtering will be done. (default: 1)
  --overlap_by_db       If activated, then overlap filtering will be done by database, rather than all together. (default: False)
  --hits_only           when activated, the ouptut will only have contigs with at least one domain annotation. In many cases, domain_search.py will be faster and more appropriate. (default: False)
  --no_annotations      when activated, new annotations will not be added to the file. This is useful if you are just trying to extract a set of contigs for annotation in a later step. (default: False)
  --batch_size BATCH_SIZE
                        How many protein sequences to search at one time in a batch. Increasing this number might improve speeds at the cost of memory. (default: 10000)
  --offset OFFSET       File offset to start reading records at. (Note that this usually only makes sense when there is just a single input file). Default: start at the top of the file (default: None)
  --recs_to_read RECS_TO_READ
                        Stop after reading this many records. Default: read all the records (default: None)
  --gene_call {all,unannotated}
                        When activated, new CDS annotations will be added with Prodigal in Metagenomic mode. If 'all', then any existing CDS annotations will be deleted and all contigs will be re-annotated. If 'unannotated', then only contigs without CDS annotations will be annotated. [default: None]. If you supply a nucleotide fasta file, be sure to also specify --fasta_type nucleotide. Note that if you do gene calling, it is STRONGLY recommended that you also supply -Z, because database size is pre-calcuated at the beginning of the execution, whereas gene-calling is done on the fly. Not supplying Z may become an error in the future. (default: None)
  --config CONFIG       Path to a configuration file. (default: None)
  --print_config [=flags]
                        Print the configuration after applying all other arguments and exit. The optional flags customizes the output and are one or more keywords separated by comma. The supported flags are: comments, skip_default, skip_null.
```


## domainator_domain_search.py

### Tool Description
Search for matches to hmm profiles

For searching large databases of sequences (genbank files or fasta files) with small numbers (< ~100) of queries (profiles or protein sequences).

Returns the contigs with hits, possibly truncated to the neighborhood around the hits.

When --max_hits is specified, it applies to the entire search, not individual queries. Thus if you supply 5 query profiles and --max_hits 100, 
at most 100 hits will be returned (not 500). 

When max_hits or pad are specified, hits will be sorted by best domain score and written after the entire search completes.
If neither is set, then hits will be written on the fly and not sorted.

### Metadata
- **Docker Image**: quay.io/biocontainers/domainator:0.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/nebiolabs/domainator
- **Package**: https://anaconda.org/channels/bioconda/packages/domainator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 
version: 0.8.1

Search for matches to hmm profiles

For searching large databases of sequences (genbank files or fasta files) with small numbers (< ~100) of queries (profiles or protein sequences).

Returns the contigs with hits, possibly truncated to the neighborhood around the hits.

When --max_hits is specified, it applies to the entire search, not individual queries. Thus if you supply 5 query profiles and --max_hits 100, 
at most 100 hits will be returned (not 500). 

When max_hits or pad are specified, hits will be sorted by best domain score and written after the entire search completes.
If neither is set, then hits will be written on the fly and not sorted.

       [-h] [-i INPUT [INPUT ...]] [--fasta_type {nucleotide,protein}]
       [-r REFERENCES [REFERENCES ...]] [-o OUTPUT] [-Z Z] [-e EVALUE]
       [--min_evalue MIN_EVALUE] [--max_mode] [--max_hits MAX_HITS]
       [--include_taxids INCLUDE_TAXIDS [INCLUDE_TAXIDS ...]]
       [--exclude_taxids EXCLUDE_TAXIDS [EXCLUDE_TAXIDS ...]]
       [--ncbi_taxonomy_path NCBI_TAXONOMY_PATH] [--taxonomy_update]
       [--decoys DECOYS [DECOYS ...]] [--decoys_file DECOYS_FILE] [--cpu CPU]
       [--max_overlap MAX_OVERLAP] [--add_annotations] [--deduplicate]
       [--max_region_overlap MAX_REGION_OVERLAP] [--translate]
       [--kb_range KB_RANGE] [--kb_up KB_UP] [--kb_down KB_DOWN]
       [--cds_range CDS_RANGE] [--cds_up CDS_UP] [--cds_down CDS_DOWN]
       [--whole_contig] [--strand {f,r}] [--pad] [--keep_direction]
       [--batch_size BATCH_SIZE] [--gene_call {unannotated,all}]
       [--config CONFIG] [--print_config [=flags]]

options:
  -h, --help            show this help message and exit
  -i, --input INPUT [INPUT ...]
                        the genbank or fasta files to annotate. Genbank files can be nucleotide (with CDS annotations) or peptide. Fasta files must be peptide. (default: None)
  --fasta_type {nucleotide,protein}
                        Whether the sequences in fasta files are protein or nucleotide sequences. (default: protein)
  -r, --references REFERENCES [REFERENCES ...]
                        the names of the HMM files with profiles to search. Or protein query files.  (default: None)
  -o, --output OUTPUT   output genbank filename. If not supplied, writes to stdout. (default: None)
  -Z Z                  Passed as the -Z parameter to hmmsearch: Assert that the total number of targets in your searches is <x>, for the purposes of per-sequence E-value calculations, rather than the actual number of targets seen. Default: 1000
                        Set to 0 to use the number actual target sequences (currently this does does not account for taxonomic filtering).Supplying -Z is recommended for most use cases of domainate, as it will speed up the search and make comparisons between searches more meaningful. (default: 1000)
  -e, --evalue EVALUE   threshold E value for the domain hit. Must be <=10. [default 0.001] (default: 0.001)
  --min_evalue MIN_EVALUE
                        hits with E value lower than this will be filtered out. Not frequently used. Use only if you want to eliminate close matches. Must be >=0. [default 0] (default: 0.0)
  --max_mode            Run hmmsearch/phmmer in maximum sensitivity mode, which is much slower, but more sensitive. (default: False)
  --max_hits MAX_HITS   the maximum number of CDSs returned by the search. Prioritized by bitscore of best scoring profile. [default: return all hits passing the evalue threshold] (default: None)
  --include_taxids INCLUDE_TAXIDS [INCLUDE_TAXIDS ...]
                        Space separated list of taxids to include (default: None)
  --exclude_taxids EXCLUDE_TAXIDS [EXCLUDE_TAXIDS ...]
                        Space separated list of taxids to exclude (default: None)
  --ncbi_taxonomy_path NCBI_TAXONOMY_PATH
                        Path to NCBI taxonomy database directory. Will be created and downloaded if it does not exist. (default: /tmp/ncbi_taxonomy)
  --taxonomy_update     If taxonomy database exists, check it against the version on the ncbi server and update if there is a newer version. (default: False)
  --decoys DECOYS [DECOYS ...]
                        Names of decoy domains. A decoy domain is a domain that is not expected to be found in the input sequences. If the best hit for a CDS/protein is a domain from the decoys list, it will be not be returned as a hit. (default: None)
  --decoys_file DECOYS_FILE
                        text file containing names of decoy domains. (default: None)
  --cpu CPU             the number of cores of the cpu which are used at a time to run the search [default: use all available cores] (default: 0)
  --max_overlap MAX_OVERLAP
                        the maximum fractional overlap between domains to be included in the annotated genbank. If >= 1, then no overlap filtering will be done. [default 1] (default: 1)
  --add_annotations     When activated, new domainator annotations will be added to the file, not just the domain_search annotations. Useful if you want to see what the non-best hits score. (default: False)
  --deduplicate         by default if the same region is extracted for multiple hits then both will be kept. Set this option to eliminate redundancies. (default: False)
  --max_region_overlap MAX_REGION_OVERLAP
                        the maximum fractional of overlap between any two output regions. If >= 1, then no overlap filtering will be done. Regions are output in a greedy fashion based on CDS start site. New regions are output if less than this fraction of them overlaps with any previously output region. (default: 1.0)
  --translate           by default, nucleotide databases will return nucleotide hits. When --translate is set, CDS hits will be translated before writing. Note that --translate is incompatble with neighborhood extraction. (default: False)
  --kb_range KB_RANGE   How many kb upstream and downstream of the selected CDS to extract. Starting from the ends of the CDS. (default: None)
  --kb_up KB_UP         How many kb upstream of the selected CDS to extract. Starting from the end of the CDS. (default: None)
  --kb_down KB_DOWN     How many kb downstream of the selected CDS to extract. Starting from the end of the CDS. (default: None)
  --cds_range CDS_RANGE
                        How many CDSs upstream and downstream of the selected CDS to extract. Example, 1 would mean to return contigs including the selected CDSs and the immediate upstream and downstream CDSs. (default: None)
  --cds_up CDS_UP       How many CDSs upstream of the selected CDS to extract. Example, 1 would mean to return contigs including the selected CDSs and the immediate upstream CDS. (default: None)
  --cds_down CDS_DOWN   How many CDSs downstream of the selected CDS to extract. Example, 1 would mean to return contigs including the selected CDSs and the immediate downstream CDS. (default: None)
  --whole_contig        If set, then return the entire matching contigs. (default: False)
  --strand {f,r}        Only extract regions around CDSs on the specified strand. (default: None)
  --pad                 If set, then ends of sequences will be padded so that the focus CDS aligns. (default: False)
  --keep_direction      by default extracted regions will be flipped so that the focus cds is on the forward strand. Setting this option will keep the focus cds on whatever strand it started on. (default: False)
  --batch_size BATCH_SIZE
                        Approximately how many protein sequences to search at one time in a batch. (default: 10000)
  --gene_call {unannotated,all}
                        When activated, new CDS annotations will be added with Prodigal in Metagenomic mode. If 'all', then any existing CDS annotations will be deleted and all contigs will be re-annotated. If 'unannotated', then only contigs without CDS annotations will be annotated. [default: None] Note that if you do gene calling, it is STRONGLY recommended that you also supply -Z, because database size is pre-calcuated at the beginning of the execution, whereas gene-calling is done on the fly. Not supplying Z may become an error in the future. (default: None)
  --config CONFIG       Path to a configuration file. (default: None)
  --print_config [=flags]
                        Print the configuration after applying all other arguments and exit. The optional flags customizes the output and are one or more keywords separated by comma. The supported flags are: comments, skip_default, skip_null.
```


## domainator_select_by_cds.py

### Tool Description
Extract contigs regions around selected CDSs

Takes a domain-annotated genbank file and extracts regions of contigs based on contig or CDS name or presence of specified domains within individual CDSs.

Specify a range to extract around selected CDSs, if no range is specified, then only the selected CDSs will be returned and not any of their neighbors.

if target_cdss, target_domains or domain_expr is specified then selection logic is:

    contigs & (target_cdss or target_domains or domain_expr or unannotated)

otherwise:
    return every cds in contigs

### Metadata
- **Docker Image**: quay.io/biocontainers/domainator:0.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/nebiolabs/domainator
- **Package**: https://anaconda.org/channels/bioconda/packages/domainator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 
version: 0.8.1

Extract contig regions around selected CDSs

Takes a domain-annotated genbank file and extracts regions of contigs based on contig or CDS name or presence of specified domains within individual CDSs.

Specify a range to extract around selected CDSs, if no range is specified, then only the selected CDSs will be returned and not any of their neighbors.

if target_cdss, target_domains or domain_expr is specified then selection logic is:

    contigs & (target_cdss or target_domains or domain_expr or unannotated)

otherwise:
    return every cds in contigs

       [-h] [-i INPUT [INPUT ...]] [-o OUTPUT] [--kb_range KB_RANGE]
       [--kb_up KB_UP] [--kb_down KB_DOWN] [--cds_range CDS_RANGE]
       [--cds_up CDS_UP] [--cds_down CDS_DOWN] [--whole_contig]
       [--contigs CONTIGS [CONTIGS ...]] [--contigs_file CONTIGS_FILE]
       [--cds CDS [CDS ...]] [--cds_file CDS_FILE]
       [--domains DOMAINS [DOMAINS ...]] [--domains_file DOMAINS_FILE]
       [--domain_expr DOMAIN_EXPR] [--databases DATABASES [DATABASES ...]]
       [--strand {f,r}] [--unannotated] [--search_hits] [--pad]
       [--keep_direction] [--skip_deduplicate]
       [--max_region_overlap MAX_REGION_OVERLAP] [-e EVALUE] [--invert]
       [--config CONFIG] [--print_config [=flags]]

options:
  -h, --help            show this help message and exit
  -i, --input INPUT [INPUT ...]
                        names of input genbank files. If not supplied, reads from stdin. (default: None)
  -o, --output OUTPUT   genbank output file name. If not supplied, writes to stdout. (default: None)
  --kb_range KB_RANGE   How many kb upstream and downstream of the selected CDS to extract. Starting from the ends of the CDS. (default: None)
  --kb_up KB_UP         How many kb upstream of the selected CDS to extract. Starting from the end of the CDS. (default: None)
  --kb_down KB_DOWN     How many kb downstream of the selected CDS to extract. Starting from the end of the CDS. (default: None)
  --cds_range CDS_RANGE
                        How many CDSs upstream and downstream of the selected CDS to extract. Example, 1 would mean to return contigs including the selected CDSs and the immediate upstream and downstream CDSs. (default: None)
  --cds_up CDS_UP       How many CDSs upstream of the selected CDS to extract. Example, 1 would mean to return contigs including the selected CDSs and the immediate upstream CDS. (default: None)
  --cds_down CDS_DOWN   How many CDSs downstream of the selected CDS to extract. Example, 1 would mean to return contigs including the selected CDSs and the immediate downstream CDS. (default: None)
  --whole_contig        If set, then return the entire matching contigs. (default: False)
  --contigs CONTIGS [CONTIGS ...]
                        Only extract regions from contigs with these names. (default: None)
  --contigs_file CONTIGS_FILE
                        text file containing names of contigs to extract from. (default: None)
  --cds CDS [CDS ...]   Include CDSs with these names (additive with --domains) (default: None)
  --cds_file CDS_FILE   text file containing names of CDSs to include. (default: None)
  --domains DOMAINS [DOMAINS ...]
                        Include domains with these names (default: None)
  --domains_file DOMAINS_FILE
                        text file containing names of domains to include. (default: None)
  --domain_expr DOMAIN_EXPR
                        a boolean expression using operators & (AND), | (OR), and ~(NOT), to specify a desired combination of domains (default: None)
  --databases DATABASES [DATABASES ...]
                        Consider only domains from these databases when filtering by domain. default: all databases. (default: None)
  --strand {f,r}        Only extract regions around CDSs on the specified strand. (default: None)
  --unannotated         Select contigs with no domain annotations. (default: False)
  --search_hits         Select CDSs that are marked as search hits (from domain_search.py). (default: False)
  --pad                 If set, then ends of sequences will be padded so that the focus CDS aligns. (default: False)
  --keep_direction      by default extracted regions will be flipped so that the focus cds is on the forward strand. Setting this option will keep the focus cds on whatever strand it started on. (default: False)
  --skip_deduplicate    by default if the same region is extracted for multiple hits, then only one will be kept. Set this option to retain redundancies (which might be useful if you are counting hits), but will result in duplicated contig names, which could be a problem for downstream domainator applications. (default: False)
  --max_region_overlap MAX_REGION_OVERLAP
                        the maximum fractional of overlap between any two output regions. If >= 1, then no overlap filtering will be done. Regions are output in a greedy fashion based on CDS start site. New regions are output if less than this fraction of them overlaps with any previously output region. (default: 1.0)
  -e, --evalue EVALUE   the evalue cutoff for domain annotations to be put onto the new genbank file (default: 100000000)
  --invert              Invert the CDS selection criteria. i.e. return CDSs that don't match the CDS selection criteria. (only applies to CDS selection, not neighborhoods or contigs). (default: False)
  --config CONFIG       Path to a configuration file. (default: None)
  --print_config [=flags]
                        Print the configuration after applying all other arguments and exit. The optional flags customizes the output and are one or more keywords separated by comma. The supported flags are: comments, skip_default, skip_null.
```


## domainator_deduplicate_genbank.py

### Tool Description
Remove redundant sequences from a genbank file

Runs a clustering algorithm, such as cdhit or usearch on sequences from a genbank (or fasta) file to reduce redundancy.
The "hash" algorithm is a faster way to deduplicate exact duplicates, by hashing the sequences and eliminating hash duplicates.

### Metadata
- **Docker Image**: quay.io/biocontainers/domainator:0.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/nebiolabs/domainator
- **Package**: https://anaconda.org/channels/bioconda/packages/domainator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 
version: 0.8.1

Remove redundant sequences from a genbank file

Runs a clustering algorithm, such as cdhit or usearch on sequences from a genbank (or fasta) file to reduce redundancy.
The "hash" algorithm is a faster way to deduplicate exact duplicates, by hashing the sequences and eliminating hash duplicates.

       [-h] [-i INPUT [INPUT ...]] [-o OUTPUT] [--log LOG]
       [--fasta_type {nucleotide,protein}] [--algorithm {cd-hit,hash,usearch}]
       [--bin_path BIN_PATH] [--id ID] [--prefix_count | --suffix_count]
       [--cpu CPU] [--params PARAMS] [--fasta_out] [--both_strands]
       [--cluster_table CLUSTER_TABLE] [--cluster_sep CLUSTER_SEP]
       [--config CONFIG] [--print_config [=flags]]

options:
  -h, --help            show this help message and exit
  -i, --input INPUT [INPUT ...]
                        Genbank or fasta filenames. (default: None)
  -o, --output OUTPUT   The name of the output file. If not supplied, writes to stdout. (default: None)
  --log LOG             The name of the log file. If not supplied, writes to stderr. (default: None)
  --fasta_type {nucleotide,protein}
                        Whether the sequences in fasta files are protein or nucleotide sequences. (default: protein)
  --algorithm {cd-hit,hash,usearch}
                        Which clustering algorithm to use. (default: cd-hit)
  --bin_path BIN_PATH   If the executable for the algorithm you're using isn't in the system path, you can provide the full path to the executable here. (default: None)
  --id ID               Identity threshold (between 0 and 1), passed to cd-hit as the -c parameter or to usearach as the -id parameter. (default: None)
  --prefix_count        In the output genbank file, will prepend X- to the names of contigs, where X is the number of contigs from the original file collapsed into this centroid. (default: False)
  --suffix_count        In the output genbank file, will append -X to the names of contigs, where X is the number of contigs from the original file collapsed into this centroid. (default: False)
  --cpu CPU             The number of threads to use for deduplication [default: use all available cores] (default: 0)
  --params PARAMS       string of parameters to pass to the clustering algorithm, in the form of a json dict in single quotes. example: '"-s":0.9'  (default: None)
  --fasta_out           makes output a fasta file when activated (default: False)
  --both_strands        When set for nucleotide inputs, consider both strands for clustering/hash deduplication. (default: False)
  --cluster_table CLUSTER_TABLE
                        If supplied, then write a tab separated table with columns: representative, contigs. (default: None)
  --cluster_sep CLUSTER_SEP
                        Separator to separate individual contig names in the second column of the cluster table. Default: ' ; ' (default:  ; )
  --config CONFIG       Path to a configuration file. (default: None)
  --print_config [=flags]
                        Print the configuration after applying all other arguments and exit. The optional flags customizes the output and are one or more keywords separated by comma. The supported flags are: comments, skip_default, skip_null.
```


## domainator_compare_contigs.py

### Tool Description
Calculates similarity metrics for gene neighborhoods

### Metadata
- **Docker Image**: quay.io/biocontainers/domainator:0.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/nebiolabs/domainator
- **Package**: https://anaconda.org/channels/bioconda/packages/domainator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 
version: 0.8.1

Calculates similarity metrics for gene neighborhoods

Takes a genbank file annotated with domainator and calculates similarities between contigs and writes reports.

ji, ai, and dss metrics are similar to and inspired by the metrics used in the BigScape method:
Navarro-Muñoz, Jorge C., Nelly Selem-Mojica, Michael W. Mullowney, Satria A. Kautsar, James H. Tryon, Elizabeth I. Parkinson, Emmanuel L. C. De Los Santos, et al. "A Computational Framework to Explore Large-Scale Biosynthetic Diversity from Large-Scale Genomic Data." Nature Chemical Biology 16, no. 1 (January 2020): 60–68. https://doi.org/10.1038/s41589-019-0400-9.

       [-h] [-i INPUT [INPUT ...]] [-o OUTPUT] [--name_by_order]
       [--contigs CONTIGS [CONTIGS ...]] [--contigs_file CONTIGS_FILE] [-k K]
       [--ji JI] [--ai AI] [--databases DATABASES [DATABASES ...]]
       [--dense DENSE] [--dense_text DENSE_TEXT] [--sparse SPARSE]
       [--config CONFIG] [--print_config [=flags]]

options:
  -h, --help            show this help message and exit
  -i, --input INPUT [INPUT ...]
                        Genbank filenames. (default: None)
  -o, --output OUTPUT   Name of genbank output, contigs will be sorted hierarchically within the output genbank. If not supplied then no genbank output will be generated. To write to stdout, use '-'. default: None (default: None)
  --name_by_order       Will rename contigs in the genbank file such that they have a prefix that can be sorted to restore the sorted order. (default: False)
  --contigs CONTIGS [CONTIGS ...]
                        only annotate contigs with ids in this list. Additive with --contigs_file. default: all contigs. (default: [])
  --contigs_file CONTIGS_FILE
                        only annotate contigs with ids listed in this file (one per line). Additive with --contigs. default: all contigs. (default: None)
  -k K                  for each metric, return scores for this many of the top hits, and consider all other hits to be zero. default: count all comparisons. (default: None)
  --ji JI               weighting for jaccard index metric, a comparison of all distinct types of domains in the contigs. When two contigs have no domains, their ji is 1.0. (default: 0.5)
  --ai AI               weighting for adjacency index metric, a comparison of shared domain pairs in the contigs. When two contigs have 0 or 1 domains, their ai is 1.0. (default: 0.5)
  --databases DATABASES [DATABASES ...]
                        Domain databases to use for domain content comparison. default: all databases. (default: None)
  --dense DENSE         Write a dense distance matrix hdf5 file to this path. (default: None)
  --dense_text DENSE_TEXT
                        Write a dense distance matrix tsv file to this path. (default: None)
  --sparse SPARSE       Write a sparse distance matrix hdf5 file to this path. (default: None)
  --config CONFIG       Path to a configuration file. (default: None)
  --print_config [=flags]
                        Print the configuration after applying all other arguments and exit. The optional flags customizes the output and are one or more keywords separated by comma. The supported flags are: comments, skip_default, skip_null.
```


## domainator_build_ssn.py

### Tool Description
Generates Sequence Similarity Networks
    
Build a sequence similarity network and do analysis related to that.

### Metadata
- **Docker Image**: quay.io/biocontainers/domainator:0.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/nebiolabs/domainator
- **Package**: https://anaconda.org/channels/bioconda/packages/domainator/overview
- **Validation**: PASS

### Original Help Text
```text
usage: build_ssn.py [-h] -i INPUT [--lb LB]
                    [--metadata METADATA [METADATA ...]] [--color_by COLOR_BY]
                    [--color_table COLOR_TABLE]
                    [--color_table_out COLOR_TABLE_OUT] [--xgmml XGMML]
                    [--cluster] [--cluster_tsv CLUSTER_TSV]
                    [--no_cluster_header] [--mst] [--config CONFIG]
                    [--print_config [=flags]]

version: 0.8.1

Generates Sequence Similarity Networks
    
Build a sequence similarity network and do analysis related to that.

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     pairwise similarity (or distance) scores. In the network, nodes will be derived from row and column names, and edges will be added between pairs of rows and columns meeting the threshold criteria. Format can be tab-separated text, or Domainator hdf5. (default: None)
  --lb LB               exclude all edges with weights less than or equal to this value. This should be >= 0. (default: 0)
  --metadata METADATA [METADATA ...]
                        tab separated files of sequence metadata. (default: None)
  --color_by COLOR_BY   Color the points in the output image based on this column of the metadata table. (default: None)
  --color_table COLOR_TABLE
                        tab separated file with two columns and no header, columns are: annotation, hex color. For example: CCDB   cc0000 (default: None)
  --color_table_out COLOR_TABLE_OUT
                        tab separated file with two columns and no header, columns are: annotation, hex color. Written after the color table is updated with new colors, for example if using --color_by, but not supplying an external color table. (default: None)
  --xgmml XGMML         write a cytoscape xgmml file of the projection. (default: None)
  --cluster             Creates a new metadata column called 'SSN_cluster', replacing that column from the metadata file if already present. Finds clusters by following connectivity, assigns each cluster a distinct integer, based on size rank, bigger clusters get smaller numbers. (default: False)
  --cluster_tsv CLUSTER_TSV
                        Path to write a tsv file will mapping each sequence to its cluster. If set, then --cluster is automatically activated. If --no_cluster_header not set, then the file will have header contig cluster. (default: None)
  --no_cluster_header   If set, then the tsv file will not have a header. Only relevant if --cluster_tsv is set. (default: False)
  --mst                 If set, then only include edges that are part of the maximum spanning tree of the graph. The clusters will be the same as the full graph, but the intra-cluster connections will be pruned to the minimum necessary to preserve the clusters. (default: False)
  --config CONFIG       Path to a configuration file. (default: None)
  --print_config [=flags]
                        Print the configuration after applying all other arguments and exit. The optional flags customizes the output and are one or more keywords separated by comma. The supported flags are: comments, skip_default, skip_null.
```


## Metadata
- **Skill**: generated
