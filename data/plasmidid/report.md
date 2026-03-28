# plasmidid CWL Generation Report

## plasmidid_download_plasmid_database.py

### Tool Description
Download up to date plasmid database from ncbi ftp

### Metadata
- **Docker Image**: quay.io/biocontainers/plasmidid:1.6.5--hdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/plasmidID
- **Package**: https://anaconda.org/channels/bioconda/packages/plasmidid/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plasmidid/overview
- **Total Downloads**: 14.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BU-ISCIII/plasmidID
- **Stars**: N/A
### Original Help Text
```text
usage: download_plasmid_database.py [-h] -o OUTPUT

Download up to date plasmid database from ncbi ftp

optional arguments:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        REQUIRED. Output directory to extract plasmid database
```


## plasmidid_plasmidID

### Tool Description
reconstruct and annotate the most likely plasmids present in one sample

### Metadata
- **Docker Image**: quay.io/biocontainers/plasmidid:1.6.5--hdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/plasmidID
- **Package**: https://anaconda.org/channels/bioconda/packages/plasmidid/overview
- **Validation**: PASS

### Original Help Text
```text
plasmidID is a computational pipeline tha reconstruct and annotate the most likely plasmids present in one sample

usage : /usr/local/bin/plasmidID <-1 R1> <-2 R2> <-d database(fasta)> <-s sample_name> [-g group_name] [options]

	Mandatory input data:
	-1 | --R1	<filename>	reads corresponding to paired-end R1 (mandatory)
	-2 | --R2	<filename>	reads corresponding to paired-end R2 (mandatory)
	-d | --database	<filename>	database to map and reconstruct (mandatory)
	-s | --sample	<string>	sample name (mandatory), less than 37 characters

	Optional input data:
	-g | --group	<string>	group name (optional). If unset, samples will be gathered in NO_GROUP group
	-c | --contigs	<filename>	file with contigs. If supplied, plasmidID will not assembly reads
	-a | --annotate <filename>	file with configuration file for specific annotation
	-o 		<output_dir>	output directory, by default is the current directory

	Pipeline options:
	--explore	Relaxes default parameters to find less reliable relationships within data supplied and database
	--only-reconstruct	Database supplied will not be filtered and all sequences will be used as scaffold
						This option does not require R1 and R2, instead a contig file can be supplied
	-w 			Undo winner takes it all algorithm when clustering by kmer - QUICKER MODE
	Trimming:
	--trimmomatic-directory Indicate directory holding trimmomatic .jar executable
	--no-trim	Reads supplied will not be quality trimmed

	Coverage and Clustering:
	-C | --coverage-cutoff	<int>	minimun coverage percentage to select a plasmid as scafold (0-100), default 80
	-S | --coverage-summary	<int>	minimun coverage percentage to include plasmids in summary image (0-100), default 90
	-f | --cluster	<int>	kmer identity to cluster plasmids into the same representative sequence (0 means identical) (0-1), default 0.5
	-k | --kmer	<int>	identity to filter plasmids from the database with kmer approach (0-1), default 0.95

	Contig local alignment
	-i | --alignment-identity <int>	minimun identity percentage aligned for a contig to annotate, default 90
	-l | --alignment-percentage <int>	minimun length percentage aligned for a contig to annotate, default 20
	-L | --length-total	<int>	minimun alignment length to filter blast analysis
	--extend-annotation <int>	look for annotation over regions with no homology found (base pairs), default 500bp

	Draw images:
	--config-directory <dir>	directory holding config files, default config_files/
	--config-file-individual <file-name> file name of the individual file used to reconstruct
	Additional options:

	-M | --memory	<int>	max memory allowed to use
	-T | --threads	<int>	number of threads
	-v | --version		version
	-h | --help		display usage message

example: ./plasmidID.sh -1 ecoli_R1.fastq.gz -2 ecoli_R2.fastq.gz -d database.fasta -s ECO_553 -G ENTERO
		./plasmidID.sh -1 ecoli_R1.fastq.gz -2 ecoli_R2.fastq.gz -d PacBio_sample.fasta -c scaffolds.fasta -C 60 -s ECO_60 -G ENTERO --no-trim
```


## plasmidid_summary_report_pid.py

### Tool Description
Creates a summary report in tsv and hml from plasmidID execution

### Metadata
- **Docker Image**: quay.io/biocontainers/plasmidid:1.6.5--hdfd78af_0
- **Homepage**: https://github.com/BU-ISCIII/plasmidID
- **Package**: https://anaconda.org/channels/bioconda/packages/plasmidid/overview
- **Validation**: PASS

### Original Help Text
```text
usage: summary_report_pid.py [-h] -i input_folder [-g]

Creates a summary report in tsv and hml from plasmidID execution

optional arguments:
  -h, --help            show this help message and exit
  -i input_folder, --input input_folder
                        REQUIRED.Input pID folder
  -g, --group           Creates a group report instead of individual (Default
                        True)
```


## Metadata
- **Skill**: generated
