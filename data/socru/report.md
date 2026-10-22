# socru CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| socru | PASS | E. coli K-12 MG1655 (NCBI efetch) is typed GS1.0 with all seven fragments; fixed output file inputs typed File and added outputs |
| socru_create | PASS | new CWL; E. coli K-12 MG1655 gives seven fragments and profile with GS1.0, dnaA fragment 3, dif fragment 1 |
| socru_rebuild_profile | PASS | new CWL; bundled E. coli profile is rebuilt and renumbered (13 rows, duplicate row merged) |
| socru_shrink_database | PASS | new CWL; bundled E. coli database shrunk with blast hits from E. coli K-12 into a new database with 7 fragments and profile |
| socru_species | PASS | new CWL; lists 433 species including Escherichia_coli |
| socru_update_profile | PASS | new CWL; E. coli K-12 result (known GS1.0) leaves the bundled profile unchanged, no novel profile tested |

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

## socru_species

### Tool Description
List all available species in the socru databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/socru
- **Package**: https://anaconda.org/channels/bioconda/packages/socru/overview
- **Validation**: PASS

### Original Help Text
```text
usage: socru_species [options]

List all available species

optional arguments:
  -h, --help      show this help message and exit
  --extended, -e  Extended information about the species databases (default:
                  False)
  --debug         Turn on debugging (default: False)
  --verbose, -v   Turn on verbose output (default: False)
  --version       show program's version number and exit
```

## socru_create

### Tool Description
Create genome arrangement type scheme from an assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/socru
- **Package**: https://anaconda.org/channels/bioconda/packages/socru/overview
- **Validation**: PASS

### Original Help Text
```text
usage: socru_create [options] output_directory assembly.fasta

Create genome arrangement type scheme. Please cite our paper, "Socru: Typing
of genome level order and orientation in bacteria", Andrew J Page, Gemma
Langridge, bioRxiv 543702; (2019) doi: https://doi.org/10.1101/543702

positional arguments:
  output_directory      Output directory
  input_file            Input FASTA file (optionally gzipped)

optional arguments:
  -h, --help            show this help message and exit
  --max_bases_from_ends MAX_BASES_FROM_ENDS, -m MAX_BASES_FROM_ENDS
                        Only look at this number of bases from start and end
                        of fragment (default: None)
  --threads THREADS, -t THREADS
                        No. of threads to use (default: 1)
  --fragment_order FRAGMENT_ORDER, -f FRAGMENT_ORDER
                        Order of fragments, you may need to change this,
                        example 1-2-3-4-5-6-7 (default: None)
  --dnaa_fasta DNAA_FASTA, -d DNAA_FASTA
                        Location of dnaA FASTA file, defaults to bundled
                        (default: None)
  --dif_fasta DIF_FASTA, -e DIF_FASTA
                        Location of dif FASTA file, defaults to bundled
                        (default: None)
  --debug               Turn on debugging (default: False)
  --verbose, -v         Turn on verbose output (default: False)
  --version             show program's version number and exit
```

## socru_rebuild_profile

### Tool Description
Admin utility which takes in an existing profile and rebuilds it.

### Metadata
- **Docker Image**: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/socru
- **Package**: https://anaconda.org/channels/bioconda/packages/socru/overview
- **Validation**: PASS

### Original Help Text
```text
usage: socru_rebuild_profile [options]

"Admin utility which will take in an existing profile and rebuild it. Please
cite our paper, Socru: Typing of genome level order and orientation in
bacteria", Andrew J Page, Gemma Langridge, bioRxiv 543702; (2019) doi:
https://doi.org/10.1101/543702

positional arguments:
  profile_filename      profile.txt from database

optional arguments:
  -h, --help            show this help message and exit
  --output_file OUTPUT_FILE, -o OUTPUT_FILE
                        Output filename (default: updated_profile.txt)
  --prefix PREFIX, -p PREFIX
                        Prefix (default: GS)
  --debug               Turn on debugging (default: False)
  --verbose, -v         Turn on verbose output (default: False)
  --version             show program's version number and exit
```

## socru_shrink_database

### Tool Description
Admin utility to take a database and blast results and create a new shrunk database.

### Metadata
- **Docker Image**: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/socru
- **Package**: https://anaconda.org/channels/bioconda/packages/socru/overview
- **Validation**: PASS

### Original Help Text
```text
usage: socru_shrink_database [options]

Admin utility take a database and blast results and create a new shrunk
database

positional arguments:
  blast_results         Blast results file from running socru -b xxx against
                        multiple assemblies
  input_database        Directory containing database to shrink
  output_database       Output directory for new database, it must not already
                        exist

optional arguments:
  -h, --help            show this help message and exit
  --min_fragment_size MIN_FRAGMENT_SIZE
                        Minimum fragment size in bases (default: 100000)
  --debug               Turn on debugging (default: False)
  --verbose, -v         Turn on verbose output (default: False)
  --version             show program's version number and exit
```

## socru_update_profile

### Tool Description
Admin utility to take the novel GS results and update the profile for the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/socru:2.2.5--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/socru
- **Package**: https://anaconda.org/channels/bioconda/packages/socru/overview
- **Validation**: PASS

### Original Help Text
```text
usage: socru_update_profile [options]

Admin utility to take the novel GS results and update the profile for the
database

positional arguments:
  socru_output_filename
                        Socru output file
  profile_filename      profile.txt from database

optional arguments:
  -h, --help            show this help message and exit
  --output_file OUTPUT_FILE, -o OUTPUT_FILE
                        Output filename (default: updated_profile.txt)
  --debug               Turn on debugging (default: False)
  --verbose, -v         Turn on verbose output (default: False)
  --version             show program's version number and exit
```

