# perl-gfacs CWL Generation Report

## perl-gfacs_gFACs.pl

### Tool Description
gFACs, the one stop destination to understand what your annotation or alignment is secretly telling you. The script gFACs.pl is a task-assigning script that calls upon many different scripts to analyze your .gff3, .gff, or .gtf files by creating a median format called gene_table.txt. From here, statisitcs can be calculated and distribution tables created. Mutliple filter paramteters can be used to create an annotation or alignment you can be proud of.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-gfacs:1.1.1--hdfd78af_1
- **Homepage**: https://gitlab.com/PlantGenomicsLab/gFACs
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-gfacs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-gfacs/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
gFACs.pl
Contact:	Madison.Caballero@uconn.edu

Version: 1.1.2 (07/17/2020)
-------------------------------------------------------------GFACS MANUAL-------------------------------------------------------------

   Welcome to gFACs, the one stop destination to understand what your annotation or alignment is secretly telling you. The script gFACs.pl 
is a task-assigning script that calls upon many different scripts to analyze your .gff3, .gff, or .gtf files by creating a median format 
called gene_table.txt. From here, statisitcs can be calculated and distribution tables created. Mutliple filter paramteters can be used to 
create an annotation or alignment you can be proud of.

To run this script:
	gFACs.pl -f <format> [options] -O <output directory> <input_file>

Mandatory inputs:
	-f <format>		
	-O <output directory>	
	<input_file>	 .gff3, .gtf, or .gff as the LAST argument.

Default output files:
	gFACs_log.txt
	gene_table.txt


Supported formats:

	-f [format]	Specifying a format: A mandatory step to call upon the right script.

	Available formats:
		Braker format augustus.gff/gff3/gft:
			braker_2.0_gtf
			braker_2.0_gff
			braker_2.0_gff3
			braker_2.05_gff3
			braker_2.05_gff
			braker_2.05_gtf
			braker_2.1.2_gtf - Works for 2.1.0-2.1.5

		Braker format braker.gtf:
			braker_2.1.5_gtf

		maker_2.31.9_gff
		prokka_1.11_gff
		gmap_2017_03_17_gff3
		genomethreader_1.6.6_gff3
		stringtie_1.3.4_gtf
		gffread_0.9.12_gff3
		exonerate_2.4.0_gff
		EVM_1.1.1_gff3
		CoGe_1.0_gff
		gFACs_gene_table
		gFACs_gtf
		refseq_gff


Additional parameters you can include:

Flag descriptions: https://gfacs.readthedocs.io/en/latest/

	-p [prefix]

	--false-run
	--statistics
	--statistics-at-every-step
	--no-processing
	--no-gene-redefining
	--rem-5prime-incompletes
	--rem-3prime-incompletes
	--rem-5prime-3prime-incompletes
	--rem-all-incompletes
	--rem-monoexonics
	--rem-multiexonics
	--min-exon-size [nt number]
	--min-intron-size [nt number]
	--min-CDS-size [nt number]
	--unique-genes-only
	--sort-by-chromosome

Flags that require that you input an entap tsv file:

	--entap-annotation [/path/to/your/entap/annotation.tsv]
	Flags you can include once entap table is specified:
		--annotated-ss-genes-only
		--annotated-all-genes-only	

Flags that require that you input a fasta file because seqeunce is being involved:
***NOTE: DO NOT RUN FASTA FLAGS WITH --no-processing. Genetic coordinates may disrupt bioperl commands!***

	--fasta [/path/to/your/nucleotide/fasta.fasta]
	Flags you can include once fasta is specified:

		--splice-table		
		--canonical-only	
		--rem-genes-without-start-codon
		--allow-alternate-starts
		--rem-genes-without-stop-codon
		--rem-genes-without-start-and-stop-codon
		--allowed-inframe-stop-codons [number]
		--nt-content
		--get-fasta
		--get-protein-fasta
		--create-gtf
		--create-simple-gtf
		--create-gff3

Output compatibility options (requires fasta):
	Things compatible by default with --create-gtf : Jbrowse
	--compatibility [option] [option] etc... 
		SnpEff
		EVM_1.1.1_gene_prediction	
		EVM_1.1.1_alignment	
		stringtie_1.3.6_gtf	

Distribution table creation:
	--distributions [option] [option] etc...	
	Available distribution options are:
		exon_lengths	
		intron_lengths	
		CDS_lengths	
		gene_lengths	
		exon_position	
		exon_position_data	
		intron_position	
		intron_position_data	
	Advanced: To control step level on distributions after exon_lengths, intron_lengths, CDS_lengths, and gene_lengths can be added.
		Example: exon_lengths 10


###

2018 Madison Caballero - University of Connecticut. This file is part of gFACs.
	gFACs is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or (at your option) any later version. gFACs is distributed in the hope that
	it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
	See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with gFACs.
	If not, see <https://www.gnu.org/licenses/>.
```

