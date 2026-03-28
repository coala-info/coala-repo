# contigtax CWL Generation Report

## contigtax_valid

### Tool Description
A tool for taxonomic assignment of contigs.

### Metadata
- **Docker Image**: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
- **Homepage**: https://github.com/NBISweden/contigtax
- **Package**: https://anaconda.org/channels/bioconda/packages/contigtax/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/contigtax/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/NBISweden/contigtax
- **Stars**: N/A
### Original Help Text
```text
usage: contigtax [-h] [-v]
                 {download,format,update,build,search,assign,transfer} ...
contigtax: error: invalid choice: 'valid' (choose from 'download', 'format', 'update', 'build', 'search', 'assign', 'transfer')
```


## contigtax_download

### Tool Description
Download contigtax databases

### Metadata
- **Docker Image**: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
- **Homepage**: https://github.com/NBISweden/contigtax
- **Package**: https://anaconda.org/channels/bioconda/packages/contigtax/overview
- **Validation**: PASS

### Original Help Text
```text
usage: contigtax download [-h] [-d DLDIR] [--tmpdir TMPDIR] [-t TAXDIR]
                          [--sqlitedb SQLITEDB] [-f] [--skip_check]
                          [--skip_idmap]
                          {uniref100,uniref90,uniref50,nr,taxonomy,idmap}

positional arguments:
  {uniref100,uniref90,uniref50,nr,taxonomy,idmap}
                        Database to download. Defaults to 'uniref100'

optional arguments:
  -h, --help            show this help message and exit
  -d DLDIR, --dldir DLDIR
                        Write files to this directory. Defaults to db name in
                        current directory. Will be created if missing.
  --tmpdir TMPDIR       Temporary directory for downloading files
  -t TAXDIR, --taxdir TAXDIR
                        Directory to store NCBI taxdump files. Defaults to
                        'taxonomy/' in current directory
  --sqlitedb SQLITEDB   Name of ete3 sqlite file to be created within
                        --taxdir. Defaults to 'taxonomy.sqlite'
  -f, --force           Overwrite downloaded files
  --skip_check          Skip check of downloaded fasta file. Default: False
  --skip_idmap          Skip download of seqid->taxid mapfile (only applies to
                        'nr' database).
```


## contigtax_format

### Tool Description
Reformat a protein fasta file for contigtax.

### Metadata
- **Docker Image**: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
- **Homepage**: https://github.com/NBISweden/contigtax
- **Package**: https://anaconda.org/channels/bioconda/packages/contigtax/overview
- **Validation**: PASS

### Original Help Text
```text
usage: contigtax format [-h] [-f] [--forceidmap] [-m TAXIDMAP]
                        [--maxidlen MAXIDLEN] [--tmpdir TMPDIR]
                        fastafile reformatted

positional arguments:
  fastafile             Specify protein fasta to reformat
  reformatted           Path to reformatted fastafile

optional arguments:
  -h, --help            show this help message and exit
  -f, --force           Force overwrite of existing reformatted fastafile
  --forceidmap          Force overwrite of existing accession2taxid mapfile
  -m TAXIDMAP, --taxidmap TAXIDMAP
                        Protein accession to taxid mapfile. For UniRef this
                        file is created from information in the fasta headers
                        and stored in a file named prot.accession2taxid.gz in
                        the same directory as the reformatted fasta file.
                        Specify another path here.
  --maxidlen MAXIDLEN   Maximum allowed length of sequence ids. Defaults to 14
                        (required by diamond for adding taxonomy info to
                        database). Ids longer than this are written to a file
                        with the original id
  --tmpdir TMPDIR       Temporary directory for writing fasta files
```


## contigtax_map

### Tool Description
A tool for taxonomic assignment of contigs.

### Metadata
- **Docker Image**: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
- **Homepage**: https://github.com/NBISweden/contigtax
- **Package**: https://anaconda.org/channels/bioconda/packages/contigtax/overview
- **Validation**: PASS

### Original Help Text
```text
usage: contigtax [-h] [-v]
                 {download,format,update,build,search,assign,transfer} ...
contigtax: error: invalid choice: 'map' (choose from 'download', 'format', 'update', 'build', 'search', 'assign', 'transfer')
```


## contigtax_update

### Tool Description
Update a prot.accession2taxid.gz file with new sequence IDs.

### Metadata
- **Docker Image**: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
- **Homepage**: https://github.com/NBISweden/contigtax
- **Package**: https://anaconda.org/channels/bioconda/packages/contigtax/overview
- **Validation**: PASS

### Original Help Text
```text
usage: contigtax update [-h] taxonmap idfile newfile

positional arguments:
  taxonmap    Existing prot.accession2taxid.gz file
  idfile      File mapping long sequence ids to new ids
  newfile     Updated mapfile

optional arguments:
  -h, --help  show this help message and exit
```


## contigtax_build

### Tool Description
Builds a Diamond database and taxon mapping for contigs.

### Metadata
- **Docker Image**: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
- **Homepage**: https://github.com/NBISweden/contigtax
- **Package**: https://anaconda.org/channels/bioconda/packages/contigtax/overview
- **Validation**: PASS

### Original Help Text
```text
usage: contigtax build [-h] [-d DBFILE] [-p CPUS]
                       fastafile taxonmap taxonnodes

positional arguments:
  fastafile             Specify (reformatted) fasta file
  taxonmap              Protein accession to taxid mapfile (must be gzipped)
  taxonnodes            nodes.dmp file from NCBI taxonomy database

optional arguments:
  -h, --help            show this help message and exit
  -d DBFILE, --dbfile DBFILE
                        Name of diamond database file. Defaults to
                        diamond.dmnd in same directory as the protein fasta
                        file
  -p CPUS, --cpus CPUS  Number of cpus to use when building (defaults to 1)
```


## contigtax_search

### Tool Description
Search for contigs in a Diamond database and assign taxonomy.

### Metadata
- **Docker Image**: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
- **Homepage**: https://github.com/NBISweden/contigtax
- **Package**: https://anaconda.org/channels/bioconda/packages/contigtax/overview
- **Validation**: PASS

### Original Help Text
```text
usage: contigtax search [-h] [-m {blastx,blastp}] [-p CPUS] [-b BLOCKSIZE]
                        [-c CHUNKS] [-T TOP] [-e EVALUE] [-l MINLEN]
                        [-t TMPDIR] [--taxonmap TAXONMAP]
                        query dbfile outfile

positional arguments:
  query                 Query contig nucleotide file
  dbfile                Diamond database file
  outfile               Diamond output file

optional arguments:
  -h, --help            show this help message and exit
  -m {blastx,blastp}, --mode {blastx,blastp}
                        Choice of search mode for diamond: 'blastx' (default)
                        for DNA query sequences or 'blastp' for amino acid
                        query sequences
  -p CPUS, --cpus CPUS  Number of cpus to use for diamond
  -b BLOCKSIZE, --blocksize BLOCKSIZE
                        Sequence block size in billions of letters
                        (default=2.0). Set to 20 on clusters
  -c CHUNKS, --chunks CHUNKS
                        Number of chunks for index processing (default=4)
  -T TOP, --top TOP     Report alignments within this percentage range of top
                        bitscore (default=10)
  -e EVALUE, --evalue EVALUE
                        maximum e-value to report alignments (default=0.001)
  -l MINLEN, --minlen MINLEN
                        Minimum length of queries. Shorter queries will be
                        filtered prior to search.
  -t TMPDIR, --tmpdir TMPDIR
                        directory for temporary files
  --taxonmap TAXONMAP   Protein accession to taxid mapfile (must be gzipped).
                        Only required for searchingif diamond version <0.9.19
```


## contigtax_assign

### Tool Description
Assigns taxonomy to contigs based on Diamond blastx results.

### Metadata
- **Docker Image**: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
- **Homepage**: https://github.com/NBISweden/contigtax
- **Package**: https://anaconda.org/channels/bioconda/packages/contigtax/overview
- **Validation**: PASS

### Original Help Text
```text
usage: contigtax assign [-h] [--format {contigtax,blast}]
                        [--taxidmap TAXIDMAP] [-t TAXDIR]
                        [--sqlitedb SQLITEDB] [-m {rank_lca,rank_vote,score}]
                        [--assignranks ASSIGNRANKS [ASSIGNRANKS ...]]
                        [--reportranks REPORTRANKS [REPORTRANKS ...]]
                        [--rank_thresholds RANK_THRESHOLDS [RANK_THRESHOLDS ...]]
                        [--vote_threshold VOTE_THRESHOLD] [-T TOP] [-e EVALUE]
                        [-p CPUS] [-c CHUNKSIZE] [--blobout BLOBOUT]
                        [--taxidout TAXIDOUT]
                        diamond_results outfile

positional arguments:
  diamond_results       Diamond blastx results
  outfile               Output file

optional arguments:
  -h, --help            show this help message and exit

input:
  --format {contigtax,blast}
                        Type of file format for diamond results. blast=blast
                        tabular output, 'contigtax'=blast tabular output with
                        taxid in 12th column
  --taxidmap TAXIDMAP   Provide custom protein to taxid mapfile.
  -t TAXDIR, --taxdir TAXDIR
                        Directory specified during 'contigtax download
                        taxonomy'. Defaults to taxonomy/.
  --sqlitedb SQLITEDB   Name of ete3 sqlite file to be created within
                        --taxdir. Defaults to 'taxonomy.sqlite'

output:
  --blobout BLOBOUT     Output hits.tsv table compatible with blobtools
  --taxidout TAXIDOUT   Write output with taxonomy ids instead of taxonomy
                        names to file

run_mode:
  -m {rank_lca,rank_vote,score}, --mode {rank_lca,rank_vote,score}
                        Mode to use for parsing taxonomy: 'rank_lca'
                        (default), 'rank_vote' or 'score'
  --assignranks ASSIGNRANKS [ASSIGNRANKS ...]
                        Ranks to use when assigning taxa. Defaults to phylum
                        genus species
  --reportranks REPORTRANKS [REPORTRANKS ...]
                        Ranks to report in output. Defaults to superkingom
                        phylum class order family genus species
  --rank_thresholds RANK_THRESHOLDS [RANK_THRESHOLDS ...]
                        Rank-specific thresholds corresponding to percent
                        identity of a hit. Defaults to 45 (phylum), 60 (genus)
                        and 85 (species)
  --vote_threshold VOTE_THRESHOLD
                        Minimum fraction required when voting on rank
                        assignments.
  -T TOP, --top TOP     Top percent of best score to consider hits for
                        (default=5)
  -e EVALUE, --evalue EVALUE
                        Maximum e-value to store hits. Default 0.001

performance:
  -p CPUS, --cpus CPUS  Number of cpus to use. Defaults to 1.
  -c CHUNKSIZE, --chunksize CHUNKSIZE
                        Size of chunks sent to process pool. For large input
                        files using a large chunksize can make the job
                        complete much faster than using the default value of 1
```


## contigtax_transfer

### Tool Description
Assigns taxonomy to contigs based on ORF taxonomy and GFF file.

### Metadata
- **Docker Image**: quay.io/biocontainers/contigtax:0.5.10--pyhdfd78af_0
- **Homepage**: https://github.com/NBISweden/contigtax
- **Package**: https://anaconda.org/channels/bioconda/packages/contigtax/overview
- **Validation**: PASS

### Original Help Text
```text
usage: contigtax transfer [-h] [--ignore_unc_rank IGNORE_UNC_RANK]
                          [--orf_tax_out ORF_TAX_OUT] [-p CPUS] [-c CHUNKSIZE]
                          orf_taxonomy gff contig_taxonomy

positional arguments:
  orf_taxonomy          Taxonomy assigned to ORFs (ORF ids in first column)
  gff                   GFF or file with contig id in first column and ORF id
                        in second column
  contig_taxonomy       Output file with assigned taxonomy for contigs

optional arguments:
  -h, --help            show this help message and exit
  --ignore_unc_rank IGNORE_UNC_RANK
                        Ignore ORFs unclassified at <rank>
  --orf_tax_out ORF_TAX_OUT
                        Also transfer taxonomy back to ORFs and output to file
  -p CPUS, --cpus CPUS  Number of cpus to use when transferring taxonomy to
                        contigs
  -c CHUNKSIZE, --chunksize CHUNKSIZE
                        Size of chunks sent to process pool. For large input
                        files using a large chunksize can make the job
                        complete much faster than using the default value of
                        1.
```


## Metadata
- **Skill**: generated
