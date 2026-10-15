# plasmidtron CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| plasmidtron | Failed | image problem: GNU parallel is missing in the image, so the k-mer counting step exits with status 127; rewrote the CWL from the real help (invented flags) |

## plasmidtron

### Tool Description
A tool to assemble parts of a genome responsible for a trait

### Metadata
- **Docker Image**: quay.io/biocontainers/plasmidtron:0.4.1--py36_1
- **Homepage**: https://github.com/sanger-pathogens/plasmidtron
- **Package**: https://anaconda.org/channels/bioconda/packages/plasmidtron/overview
- **Validation**: PASS

### Original Help Text
```text
usage: plasmidtron [options] output_directory file_of_traits file_of_nontraits

A tool to assemble parts of a genome responsible for a trait

positional arguments:
  output_directory      Output directory
  file_of_traits        File of filenames of trait (case) FASTQs
  file_of_nontraits     File of filenames of nontrait (control) FASTQs

optional arguments:
  -h, --help            show this help message and exit
  --action {intersection,union}, -a {intersection,union}
                        Control how the traits kmers are filtered for assembly
                        [union]
  --keep_files, -f      Keep intermediate files [False]
  --kmer KMER, -k KMER  Kmer to use, depends on read length [51]
  --min_contig_len MIN_CONTIG_LEN, -l MIN_CONTIG_LEN
                        Minimum contig length in final assembly [300]
  --min_spades_contig_coverage MIN_SPADES_CONTIG_COVERAGE, -c MIN_SPADES_CONTIG_COVERAGE
                        Filter out contigs with low coverage. Set to 0 to keep
                        all. [5]
  --max_spades_contig_coverage MAX_SPADES_CONTIG_COVERAGE, -e MAX_SPADES_CONTIG_COVERAGE
                        Filter out contigs with high coverage. Set to 0 to
                        keep all. [500]
  --min_kmers_threshold MIN_KMERS_THRESHOLD, -m MIN_KMERS_THRESHOLD
                        Exclude traits k-mers occurring less than this [10]
  --max_kmers_threshold MAX_KMERS_THRESHOLD, -x MAX_KMERS_THRESHOLD
                        Exclude traits k-mers occurring more than this [254]
  --min_controls_kmers_threshold MIN_CONTROLS_KMERS_THRESHOLD
                        Exclude nontraits k-mers occurring less than this [5]
  --max_controls_kmers_threshold MAX_CONTROLS_KMERS_THRESHOLD
                        Exclude nontraits k-mers occurring more than this
                        [254]
  --min_kmers_per_read MIN_KMERS_PER_READ, -r MIN_KMERS_PER_READ
                        Min percentage kmer coverage of read to keep it[0.2]
  --match_both_pairs, -d
                        Match both pairs to keep them in assembly [False]
  --plot_filename PLOT_FILENAME, -p PLOT_FILENAME
                        Kmer to use, depends on read length [kmerplot.png]
  --kmer_plot, -g       Create kmer plot [False]
  --spades_exec SPADES_EXEC, -s SPADES_EXEC
                        Set the SPAdes executable [spades.py]
  --threads THREADS, -t THREADS
                        Number of threads [1]
  --verbose, -v         Turn on debugging [0]
  --version             show program's version number and exit
```

## Metadata
- **Docker Image**: quay.io/biocontainers/plasmidtron:0.4.1--py36_1
- **Homepage**: https://github.com/sanger-pathogens/plasmidtron
- **Package**: https://anaconda.org/channels/bioconda/packages/plasmidtron/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plasmidtron/overview
- **Total Downloads**: 18.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/plasmidtron
- **Stars**: N/A
### Original Help Text
```text
Unable to find image 'quay.io/biocontainers/plasmidtron:0.4.1--py36_1' locally
0.4.1--py36_1: Pulling from biocontainers/plasmidtron
a3ed95caeb02: Already exists
b0dc45cd432d: Already exists
3aaade50789a: Already exists
ddd482ea7b54: Already exists
7ff999a2256f: Already exists
e7c454e5167d: Already exists
dfda3e01f2b6: Already exists
a3ed95caeb02: Already exists
10c3bb32200b: Already exists
7f439b17f505: Pulling fs layer
docker: write /var/lib/docker/tmp/GetImageBlob1459459677: no space left on device

Run 'docker run --help' for more information
```

