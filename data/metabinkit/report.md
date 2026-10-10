# metabinkit CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metabinkit_metabin | PASS | output identical to the expected tests/test_files/out1.tsv |
| metabinkit_metabinkit_blast | PASS | main mode works on the repo test db and query; the -P and -N taxid filters fail because the image has no BLAST taxdb files |
| metabinkit_metabinkit_blastgendb | PASS | database built from the repo test fasta; the -c check option fails inside blastdbcheck while building works |

## metabinkit_metabin

### Tool Description
metabin

#

## metabinkit_metabinkit_blast

### Tool Description
BLAST a fasta file against a reference database and add taxonomy information.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabinkit:0.2.3--r44h1104d80_3
- **Homepage**: https://github.com/envmetagen/metabinkit
- **Package**: https://anaconda.org/channels/bioconda/packages/metabinkit/overview
- **Validation**: PASS

### Original Help Text
```text
metabinkit_blast -f fasta file -D reference_DB -o outfile [options]
 -f fasta_file 
 -D reference_db    - reference Blast indexed database
 -o outfile
 -O outformat       - output format (default: 6 qseqid evalue pident qcovs saccver staxid ssciname sseqid)
 -T taxdir          - folder with NCBI's taxonomy database (default:/usr/local/bin/../db/)
 -t threads         - maximum number of threads (default:2)
 -m max_hsps        - BLAST's max_hsps paramater (default:1)
 -w word_size       - BLAST's word_size paramater (default:6)
 -e evalue          - BLAST's evalue paramater (default:1)
 -I perc_identity   - BLAST's perc_identity paramater (default:50)
 -q qcov_hsp_perc   - BLAST's qcov_hsp_perc paramater (default:98)
 -G gapopen         - BLAST's gapopen paramater (default:0)
 -E gapextend       - BLAST's gapextend paramater (default:2)
 -X task            - BLAST's task parameter (default:blastn)
 -r reward	    - BLAST´s reward parameter (default:1)
 -p penalty	    - BLAST´s reward parameter (default:-1)
 -M max_target_seqs - BLAST´s max_target_seqs parameter (default:100)
 -N taxids_blacklist_files - restrict search to taxids not present in the files provided (separated by comma). This options is incompatible with -P.
 -P taxids_positive_files - restrict search to taxids present in the files provided (separated by comma). This option is incompatible with -N.
 -v                       - print metabinkit version and exits
 -h                 - provides usage information
```

## metabinkit_metabinkit_blastgendb

### Tool Description
Create a taxonomy-aware BLAST nucleotide database from a fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabinkit:0.2.3--r44h1104d80_3
- **Homepage**: https://github.com/envmetagen/metabinkit
- **Package**: https://anaconda.org/channels/bioconda/packages/metabinkit/overview
- **Validation**: PASS

### Original Help Text
```text
metabinkit_blastgendb -f fasta file -t taxid_map -o db [options]
 -f fasta_file 
 -T seqid_taxid_map - mapping between the sequence id and the taxid (tab separated). if none is found it will look for taxid=xxxx; in the fasta header after the first space and consider the word up to the first space or | as the sequence id.
 -o outfile
 -c                 - check database after creating it
 -t threads         - maximum number of threads (default:2)
 -v                 - print version and exit
 -h                 - provides usage information
```

## Metadata
- **Docker Image**: quay.io/biocontainers/metabinkit:0.2.3--r44h1104d80_3
- **Homepage**: https://github.com/envmetagen/metabinkit
- **Package**: https://anaconda.org/channels/bioconda/packages/metabinkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metabinkit/overview
- **Total Downloads**: 25.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/envmetagen/metabinkit
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/metabin [options]


Options:
	-i FILENAME, --input=FILENAME
		TSV file name

	-o FILENAME, --out=FILENAME
		output file prefix 

	-S DOUBLE, --Species=DOUBLE
		species %id threshold [default= 99]

	-G DOUBLE, --Genus=DOUBLE
		genus %id threshold [default= 97]

	-F DOUBLE, --Family=DOUBLE
		family %id threshold [default= 95]

	-A DOUBLE, --AboveF=DOUBLE
		above family %id threshold [default= 90]

	-D FOLDER, --db=FOLDER
		directory containing the taxonomy db (nodes.dmp and names.dmp) [default= /usr/local/bin/../db/]

	--SpeciesNegFilter=FILENAME
		negative filter (file with one word per line) [default= NULL]

	--SpeciesBL=FILENAME
		species blacklist (file with one taxid per line) [default= NULL]

	--GenusBL=FILENAME
		genera blacklist (file with one taxid per line) [default= NULL]

	--FamilyBL=FILENAME
		families blacklist (file with one taxid per line) [default= NULL]

	--FilterFile=FILENAME
		file name with the entries from the input to exclude (on entry per line)  [default= NULL]

	--FilterCol=COLUMN NAME
		Column name to look for the values found the the file provided in the --Filter parameter  [default= sseqid]

	--rm_predicted=COLNAME
		Where to look (column name) for in-silico 'predicted' entries (XM_,XR_, and XP_). If no column is given then  the filter is not applied.  [default= NULL]

	--TopSpecies=INTEGER
		 [default= 100]

	--TopGenus=INTEGER
		 [default= 100]

	--TopFamily=INTEGER
		 [default= 100]

	--TopAF=INTEGER
		 above family? [default= 100]

	-v, --version
		print version and exit

	-q, --quiet
		enable quiet mode (less messages are printed to stdout)

	--no_mbk
		Do not use mbk: codes in the output file to explain why a sequence was not binned at a given level (NA is used throughout)

	--sp_discard_sp
		Discard species with sp. in the name

	--sp_discard_mt2w
		Discard species with more than two words

	--sp_discard_num
		Discard species with numbers

	-M, --minimal_cols
		Include only the seqid and lineage information in the output table [FALSE]

	-h, --help
		Show this help message and exit
```

