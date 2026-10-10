# metabinner CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metabinner_Filter_tooshort.py | PASS |  |
| metabinner_gen_coverage_file.sh | PASS |  |
| metabinner_gen_kmer.py | PASS | real nf-core minigut assembly; output is the 136-column canonical 4-mer table |
| metabinner_run_metabinner.sh | Not completed | no real data big enough: on the small nf-core minigut assembly no marker seeds are found and the script stops in split_hhbins.py; its earlier steps ran |

## metabinner_Filter_tooshort.py

### Tool Description
Filters out short sequences from a FASTA file.

#

## metabinner_gen_coverage_file.sh

### Tool Description
Align reads to the assembly (bwa) and generate the coverage profile tables for MetaBinner.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
- **Homepage**: https://github.com/ziyewang/MetaBinner
- **Package**: https://anaconda.org/channels/bioconda/packages/metabinner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bash gen_coverage_file.sh [options] -a assembly.fa -o output_dir readsA_1.fastq readsA_2.fastq ... [readsX_1.fastq readsX_2.fastq]
Note1: Make sure to provide all your separately replicate read files, not the joined file.
Note2: You may provide single end or interleaved reads as well with the use of the correct option
Note3: If the output already has the .bam alignments files from previous runs, the module will skip re-aligning the reads

Options:

	-a STR    metagenomic assembly file
	-o STR    output directory (to save the coverage files)
	-b STR    directory for the bam files
	-t INT    number of threads (default=1)
	-m INT		amount of RAM available (default=4)
	-l INT		minimum contig length to bin (default=1000bp).
	--single-end	non-paired reads mode (provide *.fastq files)
	--interleaved	the input read files contain interleaved paired-end reads
	-f STR    Forward read suffix for paired reads (default=_1.fastq)
	-r STR    Reverse read suffix for paired reads (default=_2.fastq)
```

## Metadata
- **Docker Image**: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
- **Homepage**: https://github.com/ziyewang/MetaBinner
- **Package**: https://anaconda.org/channels/bioconda/packages/metabinner/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metabinner/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ziyewang/MetaBinner
- **Stars**: N/A
### Original Help Text
```text
Usage: Filter_tooshort.py [OPTIONS] INPUT_FILE K
Try 'Filter_tooshort.py --help' for help.

Error: no such option: --h  Did you mean --help?
```


## metabinner_gen_kmer.py

### Tool Description
Generates k-mers from input sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
- **Homepage**: https://github.com/ziyewang/MetaBinner
- **Package**: https://anaconda.org/channels/bioconda/packages/metabinner/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/gen_kmer.py", line 61, in <module>
    length_threshold = int(sys.argv[2])
IndexError: list index out of range
```


## metabinner_run_metabinner.sh

### Tool Description
Run the MetaBinner pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/metabinner:1.4.4--hdfd78af_1
- **Homepage**: https://github.com/ziyewang/MetaBinner
- **Package**: https://anaconda.org/channels/bioconda/packages/metabinner/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bash run_metabinner.sh [options] -a contig_file -o output_dir -d coverage_profile -k kmer_profile -p path_to_MetaBinner
Options:

  -a STR          metagenomic assembly file
  -o STR          output directory
  -d STR          coverage_profile.tsv; The coverage profiles, containing a table where each row correspond to a contig, and each column correspond to a sample. All values are separated with tabs.
  -k STR          kmer_profile.csv; The composition profiles, containing a table where each row correspond to a contig, and each column correspond to the kmer composition of particular kmer. All values are separated with comma.
  -p STR          path to MetaBinner; e.g. /home/wzy/MetaBinner
  -t INT          number of threads (default=1)
  -s STR          Dataset scale; eg. small,large,huge
```


## Metadata
- **Skill**: generated
