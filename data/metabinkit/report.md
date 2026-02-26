# metabinkit CWL Generation Report

## metabinkit_metabin

### Tool Description
metabin

### Metadata
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

