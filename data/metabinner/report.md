# metabinner CWL Generation Report

## metabinner_Filter_tooshort.py

### Tool Description
Filters out short sequences from a FASTA file.

### Metadata
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

