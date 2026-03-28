# gtotree CWL Generation Report

## gtotree_GToTree

### Tool Description
This program takes input genomes from various sources and ultimately produces a phylogenomic tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
- **Homepage**: https://github.com/AstrobioMike/GToTree/wiki/what-is-gtotree%3F
- **Package**: https://anaconda.org/channels/bioconda/packages/gtotree/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gtotree/overview
- **Total Downloads**: 23.4K
- **Last updated**: 2025-10-20
- **GitHub**: https://github.com/AstrobioMike/GToTree
- **Stars**: N/A
### Original Help Text
```text
GToTree v1.8.16
                         (github.com/AstrobioMike/GToTree)


 ----------------------------------  [0;33mHELP INFO[0m  ---------------------------------- 

  This program takes input genomes from various sources and ultimately produces
  a phylogenomic tree. You can find detailed usage information at:
                                  github.com/AstrobioMike/GToTree/wiki


 -------------------------------  [0;33mREQUIRED INPUTS[0m  ------------------------------- 

      1) Input genomes in one or any combination of the following formats:
        - [-a <file>] single-column file of NCBI assembly accessions
        - [-g <file>] single-column file with the paths to each GenBank file
        - [-f <file>] single-column file with the paths to each fasta file
        - [-A <file>] single-column file with the paths to each amino acid file,
                      each file should hold the coding sequences for just one genome

      2)  [-H <file>] location of the uncompressed target SCGs HMM file
                      being used, or just the HMM name if the 'GToTree_HMM_dir' env variable
                      is set to the appropriate location (which is done by conda install), run
                      'gtt-hmms' by itself to view the available gene-sets)


 -------------------------------  [0;33mOPTIONAL INPUTS[0m  ------------------------------- 


      [0;33mOutput directory specification:[0m

        - [-o <str>] default: GToTree_output
                  Specify the desired output directory.


      [0;33mUser-specified modification of genome labels:[0m

        - [-m <file>] mapping file specifying desired genome labels
                  A two- or three-column tab-delimited file where column 1 holds either
                  the file name or NCBI accession of the genome to name (depending
                  on the input source), column 2 holds the desired new genome label,
                  and column 3 holds something to be appended to either initial or
                  modified labels (e.g. useful for "tagging" genomes in the tree based
                  on some characteristic). Columns 2 or 3 can be empty, and the file does
                  not need to include all input genomes.


      [0;33mOptions for adding taxonomy information:[0m

        - [-t ] add NCBI taxonomy; default: false
                  Provide this flag with no arguments if you'd like to add NCBI taxonomy
                  info to the sequence headers for any genomes with NCBI taxids. This will
                  will largely be effective for input genomes provided as NCBI accessions
                  (provided to the `-a` argument), but any input GenBank files will also
                  be searched for an NCBI taxid. See `-L` argument for specifying desired
                  ranks.

        - [-D ] add GTDB taxonomy; default: false
                  Provide this flag with no arguments if you'd like to add taxonomy from the
                  Genome Taxonomy Database (GTDB; gtdb.ecogenomic.org). This will only be
                  effective for input genomes provided as NCBI accessions (provided to the
                  `-a` argument). This can be used in combination with the `-t` flag, in
                  which case any input accessions not represented in the GTDB will have NCBI
                  taxonomic infomation added (with '_NCBI' appended). See `-L` argument for
                  specifying desired ranks, and see helper script `gtt-get-accessions-from-GTDB`
                  for help getting input accessions based on GTDB taxonomy searches.

        - [-L <str>] specify wanted lineage ranks; default: Domain,Phylum,Class,Species,Strain
                  A comma-separated list of the taxonomic ranks you'd like added to
                  the labels if adding taxonomic information. E.g., all would be
                  "-L Domain,Phylum,Class,Order,Family,Genus,Species,Strain". Note that
                  strain-level information is available through NCBI, but not GTDB.


      [0;33mFiltering settings:[0m

        - [-c <float>] sequence length cutoff; default: 0.2
                  A float between 0-1 specifying the range about the median of
                  sequences to be retained. For example, if the median length of a
                  set of sequences is 100 AAs, those seqs longer than 120 or shorter
                  than 80 will be filtered out before alignment of that gene set
                  with the default 0.2 setting.

        - [-G <float>] genome hits cutoff; default: 0.5
                  A float between 0-1 specifying the minimum fraction of hits a
                  genome must have of the SCG-set. For example, if there are 100
                  target genes in the HMM profile, and Genome X only has hits to 49
                  of them, it will be removed from analysis with default value 0.5.

        - [-B ] best-hit mode; default: false
                  Provide this flag with no arguments if you'd like to run GToTree
                  in "best-hit" mode. By default, if a SCG has more than one hit
                  in a given genome, GToTree won't include a sequence for that target
                  from that genome in the final alignment. With this flag provided,
                  GToTree will use the best hit. See here for more discussion:
                  github.com/AstrobioMike/GToTree/wiki/things-to-consider


      [0;33mKO searching:[0m

        - [-K <file>] single-column file of KO targets to search each genome for
                  Table of hit counts, fastas of hit sequences, and files compatible
                  with the iToL web-based tree-viewer will be generated for each
                  target. See visualization of gene presence/absence example at
                  github.com/AstrobioMike/GToTree/wiki/example-usage for example.


      [0;33mPfam searching:[0m

        - [-p <file>] single-column file of Pfam targets to search each genome for
                  Table of hit counts, fastas of hit sequences, and files compatible
                  with the iToL web-based tree-viewer will be generated for each
                  target. See visualization of gene presence/absence example at
                  github.com/AstrobioMike/GToTree/wiki/example-usage for example.


      [0;33mGeneral run settings:[0m

        - [-z ] nucleotide mode; default: false
                  Make alignment and/or tree with nucleotide sequences instead of amino-acid
                  sequences. Note this mode can only accept NCBI accessions (passed to `-a`)
                  and genome fasta files (passed to `-f` as input sources. (GToTree still
                  finds target genes based on amino-acid HMM searches.)

        - [-N ] do not make a tree; default: false
                  No tree. Generate alignment only.

        - [-k ] keep individual target gene alignments; default: false
                  Keep individual alignment files.

        - [-T <str>] tree program to use; default: FastTreeMP if available, FastTree if not
                  Which program to use for tree generation. Currently supported are
                  "FastTree", "FastTreeMP", "VeryFastTree", and "IQ-TREE". These run with
                  default settings only (and IQ-TREE includes "-m MFP" and "-B 1000"). To
                  run any with more specific options (and there is a lot of room for
                  variation here), you can use the output alignment file from GToTree (and
                  the partitions file if wanted for mixed-model specification) as input into
                  a dedicated treeing program (the GToTree `-N` option will generate the alignment
                  only to skip internal treeing if wanted).

        - [-n <int> ] num cpus; default: 2
                  The number of cpus you'd like to use during the HMM search. (Given
                  these are individual small searches on single genomes, 2 is probably
                  always sufficient. Keep in mind this will be multiplied by the number of jobs
                  running concurrently if also modifying the `-j` parameter.)

        - [-M <int> ] num muscle threads; default: 5
                  The number of threads muscle will use during alignment. (Keep in mind
                  this will be multiplied by the number of jobs running concurrently
                  if also modifying the `-j` parameter.)

        - [-j ] num jobs; default: 1
                  The number of jobs you'd like to run in parallel during steps
                  that are parallelizable. This includes things like downloading input
                  accession genomes and running parallel alignments, and portions of the
                  tree step if using FastTreeMP or VeryFastTree.

                  Note that I've occassionally noticed NCBI not being happy with over ~50
                  downloads being attempted concurrently. So if using a `-j` setting around
                  there or higher, and GToTree is saying a lot of input accessions were not
                  successfully downloaded, consider trying with a lower `-j` setting.

        - [-X ] override super5 alignment; default: false
                  If working with greater than 1,000 target genomes, GToTree will by default
                  use the 'super5' muscle alignment algorithm to increase the speed of the alignments (see
                  github.com/AstrobioMike/GToTree/wiki/things-to-consider#working-with-many-genomes
                  for more details and the note just above there on using representative genomes).
                  Anyway, provide this flag with no arguments if you don't want to speed up
                  the alignments.

        - [-P ] use http instead of ftp; default: false
                  Provide this flag with no arguments if your system can't use ftp,
                  and you'd like to try using http.

        - [-F ] force overwrite; default: false
                  Provide this flag with no arguments if you'd like to force
                  overwriting the output directory if it exists.

        - [-d ] debug mode; default: false
                  Provide this flag with no arguments if you'd like to keep the
                  temporary directory. (Mostly useful for debugging.)


 --------------------------------  [0;33mEXAMPLE USAGE[0m  -------------------------------- 

	GToTree -a ncbi_accessions.txt -f fasta_files.txt -H Bacteria -D -j 4
```


## gtotree_gtt-hmms

### Tool Description
GToTree pre-packaged HMM SCG-sets. See github.com/AstrobioMike/GToTree/wiki/SCG-sets for more info

### Metadata
- **Docker Image**: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
- **Homepage**: https://github.com/AstrobioMike/GToTree/wiki/what-is-gtotree%3F
- **Package**: https://anaconda.org/channels/bioconda/packages/gtotree/overview
- **Validation**: PASS

### Original Help Text
```text
[0;33m                   GToTree pre-packaged HMM SCG-sets
[0m   See github.com/AstrobioMike/GToTree/wiki/SCG-sets for more info

   The environment variable [0;32mGToTree_HMM_dir[0m is set to:
     /usr/local/share/gtotree/hmm_sets/

   The 15 available pre-packaged HMM SCG-sets include:

	   Actinobacteria                    (138 genes)
	   Alphaproteobacteria               (117 genes)
	   Archaea                            (76 genes)
	   Bacteria                           (74 genes)
	   Bacteria_and_Archaea               (25 genes)
	   Bacteroidetes                      (90 genes)
	   Betaproteobacteria                (203 genes)
	   Chlamydiae                        (286 genes)
	   Cyanobacteria                     (251 genes)
	   Epsilonproteobacteria             (260 genes)
	   Firmicutes                        (119 genes)
	   Gammaproteobacteria               (172 genes)
	   Proteobacteria                    (119 genes)
	   Tenericutes                        (99 genes)
	   Universal-Hug-et-al                (16 genes)

   Details can be found in: 
     /usr/local/share/gtotree/hmm_sets/hmm-sources-and-info.tsv
```


## gtotree_gtt-get-accessions-from-GTDB

### Tool Description
This is a helper program to facilitate using taxonomy and genomes from the Genome Taxonomy Database (gtdb.ecogenomic.org) with GToTree. It primarily returns NCBI accessions and GTDB summary tables based on GTDB-taxonomy searches. It also currently has filtering capabilities built-in for specifying only GTDB representative species or RefSeq representative genomes (see help menu and links therein for explanations of what these are). For examples, please visit the GToTree wiki here: github.com/AstrobioMike/GToTree/wiki/example-usage

### Metadata
- **Docker Image**: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
- **Homepage**: https://github.com/AstrobioMike/GToTree/wiki/what-is-gtotree%3F
- **Package**: https://anaconda.org/channels/bioconda/packages/gtotree/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/etc/conda/activate.d/gtotree.sh: line 6: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
usage: gtt-get-accessions-from-GTDB [-h] [-t TARGET_TAXON] [-r TARGET_RANK]
                                    [--get-table] [--get-rank-counts]
                                    [--get-taxon-counts]
                                    [--GTDB-representatives-only]
                                    [--RefSeq-representatives-only]
                                    [--do-not-check-GTDB-version]
                                    [--store-GTDB-metadata-in-current-working-dir]
                                    [--use-ecogenomics]

This is a helper program to facilitate using taxonomy and genomes from the
Genome Taxonomy Database (gtdb.ecogenomic.org) with GToTree. It primarily
returns NCBI accessions and GTDB summary tables based on GTDB-taxonomy
searches. It also currently has filtering capabilities built-in for specifying
only GTDB representative species or RefSeq representative genomes (see help
menu and links therein for explanations of what these are). For examples,
please visit the GToTree wiki here:
github.com/AstrobioMike/GToTree/wiki/example-usage

options:
  -h, --help            show this help message and exit
  -t TARGET_TAXON, --target-taxon TARGET_TAXON
                        Target taxon (enter 'all' for all)
  -r TARGET_RANK, --target-rank TARGET_RANK
                        Target rank
  --get-table           Provide just this flag alone to download and parse a
                        GTDB metadata table. Archaea and Bacteria tables
                        pulled from here
                        (https://data.gtdb.ecogenomic.org/releases/latest/)
                        and combined, and the GTDB taxonomy column is split
                        for easier manual searching if wanted.
  --get-rank-counts     Provide just this flag alone to see counts of how many
                        unique taxa there are for each rank.
  --get-taxon-counts    Provide this flag along with a specified taxon to the
                        `-t` flag to see how many of that taxon are in the
                        database.
  --GTDB-representatives-only
                        Provide this flag along with a specified taxon to the
                        `-t` flag to pull accessions only for genomes
                        designated as GTDB species representatives (see e.g.: 
                        https://gtdb.ecogenomic.org/faq#gtdb_species_clusters)
                        .
  --RefSeq-representatives-only
                        Provide this flag along with a specified taxon to the
                        `-t` flag to pull accessions only for genomes
                        designated as RefSeq representative genomes (see e.g.:
                        https://www.ncbi.nlm.nih.gov/refseq/about/prokaryotes/
                        #representative_genomes). (Useful for subsetting a
                        view across a broad level of diversity, see also `gtt-
                        subset-GTDB-accessions`.)
  --do-not-check-GTDB-version
                        By default, this program checks if it is using the
                        latest version of the GTDB database. Provide this flag
                        to prevent this from occurring, using the version
                        already present.
  --store-GTDB-metadata-in-current-working-dir
                        By default, GToTree uses a system-wide variable to
                        know where to put and search the GTDB metadata.
                        Provide this flag to ignore that and store the master
                        table in the current working directory.
  --use-ecogenomics     By default, we try to pull the data from 'https://data
                        .ace.uq.edu.au/public/gtdb/data/releases/latest/'
                        instead of
                        'https://data.gtdb.ecogenomic.org/releases/latest/'.
                        Add this flag to try to pull from the ecogenomics site
                        (might be much slower depending on where you are).

Ex. usage: gtt-get-accessions-from-GTDB -t Archaea --GTDB-representatives-only
```


## gtotree_gtt-subset-GTDB-accessions

### Tool Description
This script is a helper program of GToTree (https://github.com/AstrobioMike/GToTree/wiki) to facilitate subsetting accessions pulled from the GTDB database (with 'gtt-get-accessions-from-GTDB' – the input file is the "*metadata.tsv" from that program). It is intended to help when wanting a tree to span the breadth of diversity we know about, while also helping to reduce over-representation of certain taxa. There are 2 primary methods for using it: 1) If a specific Class makes up > 0.05% (by default) of the total number of target genomes, the script will randomly subset that class down to 1% of what it was. So if there are 40,000 total target genomes, and Gammaproteobacteria make up 8,000 of them (20% of the total), the program will randomly select 80 Gammaproteobacteria to include (1% of 8,000). 2) Select 1 random genome from each taxa of the specified rank. It ultimately outputs a new subset accessions file ready for use with the main GToTree program.

### Metadata
- **Docker Image**: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
- **Homepage**: https://github.com/AstrobioMike/GToTree/wiki/what-is-gtotree%3F
- **Package**: https://anaconda.org/channels/bioconda/packages/gtotree/overview
- **Validation**: PASS

### Original Help Text
```text
/usr/local/etc/conda/activate.d/gtotree.sh: line 6: warning: setlocale: LC_ALL: cannot change locale (en_US.UTF-8): No such file or directory
usage: gtt-subset-GTDB-accessions [-h] -i GTDB_TABLE [-o OUTPUT_PREFIX]
                                  [-p CUTOFF_FRACTION] [-f FILTER_FRACTION]
                                  [--get-Order-representatives-only]
                                  [--get-only-individuals-for-the-rank {phylum,genus,class,species,family,order}]
                                  [--seed SEED]

This script is a helper program of GToTree
(https://github.com/AstrobioMike/GToTree/wiki) to facilitate subsetting
accessions pulled from the GTDB database (with 'gtt-get-accessions-from-GTDB'
– the input file is the "*metadata.tsv" from that program). It is intended to
help when wanting a tree to span the breadth of diversity we know about, while
also helping to reduce over-representation of certain taxa. There are 2
primary methods for using it: 1) If a specific Class makes up > 0.05% (by
default) of the total number of target genomes, the script will randomly
subset that class down to 1% of what it was. So if there are 40,000 total
target genomes, and Gammaproteobacteria make up 8,000 of them (20% of the
total), the program will randomly select 80 Gammaproteobacteria to include (1%
of 8,000). 2) Select 1 random genome from each taxa of the specified rank. It
ultimately outputs a new subset accessions file ready for use with the main
GToTree program.

options:
  -h, --help            show this help message and exit
  -o OUTPUT_PREFIX, --output-prefix OUTPUT_PREFIX
                        output prefix for output subset accessions (*.txt) and
                        GTDB taxonomy files (*.tsv) (default: "subset-
                        accessions")
  -p CUTOFF_FRACTION, --cutoff-fraction CUTOFF_FRACTION
                        Fraction of total target genomes that any given Class
                        must contribute in order for that class to be randomly
                        subset (default: 0.0005)
  -f FILTER_FRACTION, --fraction-to-subset FILTER_FRACTION
                        Fraction those that are filtered should be randomly
                        subset down to (default: 0.01)
  --get-Order-representatives-only
                        Provide this flag to simply get 1 random genome from
                        each Order in GTDB (same as if specifying `--get-only-
                        individuals-for-the-rank order`, but left here for
                        backwards-compatibility purposes)
  --get-only-individuals-for-the-rank {phylum,genus,class,species,family,order}
                        Use this option with a specified rank if wanting to
                        randomly subset such that we retain 1 genome from each
                        entry in a specific rank in GTDB
  --seed SEED           Specify the seed for random subsampling (default = 1)

required arguments:
  -i GTDB_TABLE, --GTDB-table GTDB_TABLE
                        GTDB metadata table produced with 'gtt-get-accessions-
                        from-GTDB'

Ex. usage: gtt-subset-GTDB-classes -i GTDB-arc-and-bac-refseq-rep-metadata.tsv
--get-only-individuals-for-the-rank order
```


## Metadata
- **Skill**: generated
