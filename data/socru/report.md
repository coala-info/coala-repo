# socru CWL Generation Report

## socru

### Tool Description
Typing of genome level order and orientation in bacteria

### Metadata
- **Docker Image**: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/socru
- **Package**: https://anaconda.org/channels/bioconda/packages/socru/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/socru/overview
- **Total Downloads**: 54.6K
- **Last updated**: 2025-07-14
- **GitHub**: https://github.com/quadram-institute-bioscience/socru
- **Stars**: N/A
### Original Help Text
```text
usage: socru [options] species assembly.fasta

Please cite our paper, "Socru: Typing of genome level order and orientation in
bacteria", Andrew J Page, Gemma Langridge, bioRxiv 543702; (2019) doi:
https://doi.org/10.1101/543702

positional arguments:
  species               Species name, use socru_species to see all available
  input_files           Input FASTA files (optionally gzipped)

optional arguments:
  -h, --help            show this help message and exit
  --db_dir DB_DIR, -d DB_DIR
                        Base directory for species databases, defaults to
                        bundled (default: None)
  --threads THREADS, -t THREADS
                        No. of threads to use (default: 1)
  --output_file OUTPUT_FILE, -o OUTPUT_FILE
                        Output filename, defaults to STDOUT (default: None)
  --output_plot_file OUTPUT_PLOT_FILE, -p OUTPUT_PLOT_FILE
                        Filename of plot of genome structure (default:
                        genome_structure.pdf)
  --novel_profiles NOVEL_PROFILES, -n NOVEL_PROFILES
                        Filename for novel profiles (default:
                        profile.txt.novel)
  --new_fragments NEW_FRAGMENTS, -f NEW_FRAGMENTS
                        Filename for novel fragments (default:
                        novel_fragments.fa)
  --top_blast_hits TOP_BLAST_HITS, -b TOP_BLAST_HITS
                        Filename for top blast hits (default: None)
  --output_operon_directions_file OUTPUT_OPERON_DIRECTIONS_FILE, -r OUTPUT_OPERON_DIRECTIONS_FILE
                        Filename of directions of operons (default:
                        operon_directions.txt)
  --max_bases_from_ends MAX_BASES_FROM_ENDS, -m MAX_BASES_FROM_ENDS
                        Only look at this number of bases from start and end
                        of fragment (default: None)
  --not_circular, -c    Assume chromosome is not circularised (default: False)
  --min_bit_score MIN_BIT_SCORE
                        Minimum bit score (default: 100)
  --min_alignment_length MIN_ALIGNMENT_LENGTH
                        Minimum alignment length (default: 100)
  --debug               Turn on debugging (default: False)
  --verbose, -v         Turn on verbose output (default: False)
  --version             show program's version number and exit
```

