# nasp CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| nasp | Not completed | pipeline, skipped |
| nasp_convert_external_genome | PASS |  |
| nasp_duplicates | PASS | Synthetic data: planted 400 bp repeat; the delta from nasp_find_duplicates gave the two expected ranges (201-600 and 3978-4377). |
| nasp_export | Failed | tool bug: nasp export --type vcf (the default) writes GT 0 for the first sample although the matrix shows the same SNP call as the other sample; fasta export is correct |
| nasp_filter_matrix_by_coord | PASS |  |
| nasp_filter_matrix_by_distance | Failed | image problem: python module Bio (Biopython) is missing, so the script stops at import |
| nasp_filter_matrix_by_genome | PASS |  |
| nasp_find_duplicates | PASS | Synthetic data: planted 400 bp repeat; 800 positions marked as duplicated, as expected. |
| nasp_format_fasta | PASS |  |
| nasp_frankenfasta | PASS |  |
| nasp_matrix | PASS |  |
| nasp_matrix_to_fasta | PASS |  |
| nasp_report_single_snps_single_isolate | PASS |  |
| nasp_vcf_to_matrix | Failed | tool bug: --mode commandline crashes with AttributeError: no attribute filter_matrix_format |

## nasp

### Tool Description
This is the "Northern Arizona SNP Pipeline", version 1.2.0

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/nasp
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Total Downloads**: 32.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/TGenNorth/nasp
- **Stars**: N/A
### Original Help Text
```text
usage: nasp [-h] [--config CONFIG] [reference_fasta] [output_folder]

This is the "Northern Arizona SNP Pipeline", version 1.2.0

positional arguments:
  reference_fasta  Path to the reference fasta.
  output_folder    Folder to store the output files.

optional arguments:
  -h, --help       show this help message and exit
  --config CONFIG  Path to the configuration xml file.
```

## nasp_duplicates

### Tool Description
Identify duplicate regions in the reference genome from a nucmer delta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/NASP
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: duplicates --type [range|fasta] reference.delta > duplicates.txt

duplicates identifies duplicate regions in the reference genome contigs.

reference.delta is a delta encoded file from the nucmer aligner. It is created
by aligning a reference assembly against itself to identify duplicate regions.
	nucmer --maxmatch --nosimplify reference.fasta reference.fasta

The result is passed through the delta-filter pairing each position with its
best match.
	delta-filter -q -r out.delta > reference.delta

The --type flag sets the output type (default: fasta)

If --type is fasta, duplicates uses the delta to create a fasta-style output
where the nucleotide sequences are replaced with a binary sequence such that
'0' indicates a unique position and '1' indicates a potential duplicated position:

	>Contig Description
	00000000000000000000000000000000000000000000000000000000000000000000000000000000
	00000000000000000000000000000000000000000000000000000000000000000000000000000000
	00000000000000000000000000000000000000000000000000000000000000000000000000000000
	00000000000000000000000000000000000000000000000000000000000000000000000000000000
	00000000000000000000000000000000000000000000000000000000000000111111111111111111
	11111111111111111111111111111111111111111111111111111111111111111111111111111111
	11111111111111111111111111100

If --type is range, for each duplicate region duplicates outputs a line containing
the contig name, start position, and end position.

	ContigA_Description 203 847
	ContigA_Description 45678 49697
	ContigB_Description 483 503
```

## nasp_export

### Tool Description
Transform a NASP matrix to FASTA or VCF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/NASP
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: export --type [vcf|fasta] NASP_MATRIX > output

transform a NASP matrix to FASTA or VCF format

The --type flag sets the output type (default: vcf)
```

## nasp_frankenfasta

### Tool Description
Create a FASTA 1-to-1 position aligned with a reference FASTA from a nucmer delta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/NASP
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: frankenfasta [mummer deltas]

Frankenfasta creates a fasta 1-to-1 position aligned with a reference fasta
by combining a sample fasta with a nucmer alignment delta file.

How it works:

To start with, a list of reference fasta contigs and their lengths are read from
the delta file. This is used to create a fasta where all positions are masked
with 'X'.

	>Contig Description
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

The delta alignments are used to copy positions from the sample fasta into their
corresponding positions in the reference fasta.

	>Contig Description
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXAAAAAAAXAAXXAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
	AAAAAGTTACTTTCATTAATAGAGCAAAATTTATTAATTATACTTTTTACACAAAAAACAAAGAGAGGATCGACCTTTTC
	TATTCATTCTTTAAACTACAGATTCTTTATAAAAAAATTTAACGACGTTGAGAGTAGACATGAGCGAAAGCACGGGTAGT
	AGCACGCTTCAACTTGGATTGAGCGGCCTTGAGGTCATCAGCTTGAGCATCGTCAGCGGTGAGTTCCATCAATTCCATGG
	CTTCAGCGAGAGCAGTTTCAATGGCTTCACGGTCACCACGACGGAGCTTCATGTTGACGTTAGGGTCAGAGATGTTGTTC
	TCAACTTGGTAGACGTAAGATTCAAGATCTTGCTTGGCTTGTACAACGGCTTCACGTTGCTTGTCAGATTCAGCATTCTT
	TTCAGCATCTTGAACCATACGTTCGATATCAGCAGCAGAGAGACGAGTAGAGTTGGAGATGGTGACATCAGCCTTGCGAC
	CAGTGGTCTTGTCTTGAGCAGTGACCTTCAAGATACCATTGGCATCCAAGTCAAAGGTACAGAGAAGTTCAGGGGTACCA
	CGGGGAGCAGGGATAAGACCAGAGAGAGAGAACTCACCGAGAAGGTTGTTTTCCTTGGTCATCAAACGTTCACCTTCGTA
	GACAGGGAAAGTGACAGTGGTTXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

'X' indicates the absence of calls. Either no sequence aligned to the position,
or it was a deletion.

'N' indicates uncertain calls. Two alignments with different calls may have mapped
to the same position.

Pre-release versions of NASP used a '.' to differentiate deletions from
```

## nasp_matrix

### Tool Description
Aggregate the VCF and Frankenfasta files from the NASP pipeline into matrices and stats files.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/NASP
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: matrix --dto-file matrix_dto.xml

Matrix aggregates the VCF and Frankenfasta files from the NASP pipeline into .tsv matrix and stats file summaries
which may be parsed for further analysis.

Given the --dto-file flag, all other flags are optional overrides.
A reference fasta and vcf/frankenfasta files are always required, either from
the dto or listed on the command line.

--dto-file           Path to the matrix_dto.xml file
--num-threads        Max number of CPUs that can be executing simultaneously (default: all)
--reference-fasta    Path to the reference.fasta against which samples are compared
--reference-dups     Path to the duplicates.txt file marking duplicated positions
--stats-folder       Path to the output folder for statistics (default: ./)
--matrix-folder      Path to the output folder for matrices (default: ./)
--minimum-coverage   Filter positions below this coverage/depth threshold (default: 0)
--minimum-proportion Filter positions below this proportion threshold (default: 0.0)
--withallrefpos      Include the withallrefpos.tsv matrix
```

## nasp_convert_external_genome

### Tool Description
Convert an external genome assembly into a NASP frankenfasta.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/NASP
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: convert_external_genome [-h] [--nucmerpath NUCMERPATH]
                               [--nucmerargs NUCMERARGS]
                               [--deltafilterpath DELTAFILTERPATH]
                               [--deltafilterargs DELTAFILTERARGS] --reference
                               REFERENCE --external EXTERNAL [--name NAME]

Meant to be called from the pipeline automatically.

optional arguments:
  -h, --help            show this help message and exit
  --nucmerpath NUCMERPATH
                        Path to the 'nucmer' executable.
  --nucmerargs NUCMERARGS
                        Optional arguments to pass to the 'nucmer' executable.
  --deltafilterpath DELTAFILTERPATH
                        Path to the 'delta-filter' executable.
  --deltafilterargs DELTAFILTERARGS
                        Optional arguments to pass to the 'delta-filter'
                        executable.
  --reference REFERENCE
                        Path to the reference fasta file.
  --external EXTERNAL   Path to the external genome fasta file.
  --name NAME           Name of this external genome.
```

## nasp_find_duplicates

### Tool Description
Find duplicated regions in the reference by aligning it against itself.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/NASP
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: find_duplicates [-h] [--nucmerpath NUCMERPATH] --reference REFERENCE

Meant to be called from the pipeline automatically.

optional arguments:
  -h, --help            show this help message and exit
  --nucmerpath NUCMERPATH
                        Path to the 'nucmer' executable.
  --reference REFERENCE
                        Path to the reference fasta file.
```

## nasp_format_fasta

### Tool Description
Reformat a fasta to 80 characters per line.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/NASP
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: format_fasta [-h] --inputfasta INPUTFASTA --outputfasta OUTPUTFASTA

Reformats a fasta to be split 80 characters per line, with system line-
endings.

optional arguments:
  -h, --help            show this help message and exit
  --inputfasta INPUTFASTA
                        Path to input fasta.
  --outputfasta OUTPUTFASTA
                        Path to output fasta.
```

## nasp_vcf_to_matrix

### Tool Description
Convert VCF and Frankenfasta files into NASP matrices.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/NASP
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: vcf_to_matrix [-h] --mode {commandline,xml}
                     [--reference-fasta REFERENCE_FASTA]
                     [--reference-dups REFERENCE_DUPS]
                     [--input-files INPUT_FILES [INPUT_FILES ...]]
                     [--matrix-folder MATRIX_FOLDER]
                     [--stats-folder STATS_FOLDER]
                     [--minimum-coverage MINIMUM_COVERAGE]
                     [--minimum-proportion MINIMUM_PROPORTION]
                     [--num-threads NUM_THREADS] [--dto-file DTO_FILE]

Meant to be called from the pipeline automatically.

optional arguments:
  -h, --help            show this help message and exit
  --mode {commandline,xml}
                        Data passing mode, must be set to 'commandline' or
                        'xml'.
  --reference-fasta REFERENCE_FASTA
                        Path to input reference fasta file.
  --reference-dups REFERENCE_DUPS
                        Path to input reference dups file.
  --input-files INPUT_FILES [INPUT_FILES ...]
                        Path to input VCF/fasta files for matrix conversion.
  --matrix-folder MATRIX_FOLDER
                        Name of folder to write output matries to.
  --stats-folder STATS_FOLDER
                        Name of folder to write statistics files to.
  --minimum-coverage MINIMUM_COVERAGE
                        Minimum coverage depth at a position.
  --minimum-proportion MINIMUM_PROPORTION
                        Minimum proportion of reads that must match the call
                        at a position.
  --num-threads NUM_THREADS
                        Number of threads to use when processing input.
  --dto-file DTO_FILE   Path to a matrix_dto XML file that defines all the
                        parameters.
```

## nasp_matrix_to_fasta

### Tool Description
Convert a NASP matrix into FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/NASP
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: matrix_to_fasta.py [options]

Options:
  -h, --help            show this help message and exit
  -m MATRIX_IN, --input_matrix=MATRIX_IN
                        /path/to/NASP_matrix [REQUIRED]
  -p PREFIX, --output_prefix=PREFIX
                        prefix for outfiles [REQUIRED]
  -f FILTER_FREQUENCY, --filter_frequency=FILTER_FREQUENCY
                        filter out missing data if missing is greater than or
                        equal to given frequency, defaults to 1
```

## nasp_filter_matrix_by_coord

### Tool Description
Keep or remove listed SNPs of a NASP matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/NASP
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: filter_matrix_by_coord.py [options]

Options:
  -h, --help            show this help message and exit
  -i IN_MATRIX, --in_matrix=IN_MATRIX
                        /path/to/file [REQUIRED]
  -p PREFIX, --out_prefix=PREFIX
                        prefix for output files [REQUIRED]
  -c COORDS, --in_coords=COORDS
                        /path/to/file [REQUIRED]
  -a ACTION, --action=ACTION
                        action to perform: keep SNPs in range or remove?,
                        defaults to keep
```

## nasp_filter_matrix_by_genome

### Tool Description
Keep or remove genomes of a NASP matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/NASP
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: filter_matrix_by_genome.py [options]

Options:
  -h, --help            show this help message and exit
  -m IN_MATRIX, --in_matrix=IN_MATRIX
                        /path/to/NASP_matrix [REQUIRED]
  -p PREFIX, --out_prefix=PREFIX
                        prefix for output files [REQUIRED]
  -g GENOMES, --genomes=GENOMES
                        /path/to/genomes_file [new line delimited] [REQUIRED]
  -a ACTION, --actions=ACTION
                        action to perform (keep, remove), defaults to keep
```

## nasp_filter_matrix_by_distance

### Tool Description
Reduce a NASP matrix to SNPs far from each other.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/NASP
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_matrix_by_distance.py [-h] -m MATRIX -r REFERENCE -p PREFIX [-d DISTANCE]

Return a reduced matrix of SNPs that are distant from each other.

optional arguments:
  -h, --help            show this help message and exit
  -m MATRIX, --matrix MATRIX
                        Path to the starting SNP matrix.
  -r REFERENCE, --reference REFERENCE
                        Path to the reference fasta file.
  -p PREFIX, --prefix PREFIX
                        Prefix for output files (matrix and fasta).
  -d DISTANCE, --distance DISTANCE
                        Minimum distance two SNPs can be from each other. Default: 5000
```

## nasp_report_single_snps_single_isolate

### Tool Description
Find autapomorphic SNPs for a single isolate from a NASP matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/nasp:1.2.1--py37h732b199_1
- **Homepage**: https://github.com/TGenNorth/NASP
- **Package**: https://anaconda.org/channels/bioconda/packages/nasp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: report_single_snps_single_isolate.py [options]

Options:
  -h, --help            show this help message and exit
  -m MATRIX_IN, --input_matrix=MATRIX_IN
                        /path/to/NASP_matrix [REQUIRED]
  -g GENOME_NAME, --genome_name=GENOME_NAME
                        genome to look for singleton SNPs [REQUIRED]
```
