# blast2galaxy CWL Generation Report

## blast2galaxy_blastn

### Tool Description
search nucleotide databases using a nucleotide query

### Metadata
- **Docker Image**: quay.io/biocontainers/blast2galaxy:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/IPK-BIT/blast2galaxy
- **Package**: https://anaconda.org/channels/bioconda/packages/blast2galaxy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blast2galaxy/overview
- **Total Downloads**: 1.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/IPK-BIT/blast2galaxy
- **Stars**: N/A
### Original Help Text
```text
Usage: blast2galaxy blastn [OPTIONS]

  search nucleotide databases using a nucleotide query

Options:
  --profile TEXT                  ID of the profile as defined in your config
                                  TOML. The profile consists of Galaxy server
                                  credentials and a Galaxy Tool-ID to be used
                                  for your BLAST call  [default: default]
  --query TEXT                    Path / filename of file with nucleotide
                                  query sequence(s)  [required]
  --task [megablast|blastn|blastn-short|dc-megablast]
                                  Task type  [default: megablast]
  --db TEXT                       Database name  [required]
  --evalue TEXT                   Expectation value cutoff  [default: 0.001]
  --out TEXT                      Path / filename of file to store the BLAST
                                  result
  --outfmt [0|2|4|5|6|ext|json]   Output format  [default: 6]
  --html                          Format output as HTML document
  --dust [yes|no]                 Filter out low complexity regions (with
                                  DUST)  [default: yes]
  --strand [both|plus|minus]      Query strand(s) to search against
                                  database/subject  [default: both]
  --max_hsps INTEGER              Maximum number of HSPs (alignments) to keep
                                  for any single query-subject pair
  --perc_identity FLOAT RANGE     Percent identity cutoff  [default: 0.0;
                                  0.0<=x<=100.0]
  --word_size INTEGER RANGE       Word size for wordfinder algorithm  [x>=2]
  --ungapped                      Perform ungapped alignment only?
  --parse_deflines                Should the query and subject defline(s) be
                                  parsed?
  --qcov_hsp_perc FLOAT RANGE     Minimum query coverage per hsp (percentage,
                                  0 to 100)  [default: 0.0; 0.0<=x<=100.0]
  --window_size INTEGER RANGE     Multiple hits window size: use 0 to specify
                                  1-hit algorithm, leave blank for default
                                  [x>=1]
  --gapopen INTEGER RANGE         Cost to open a gap  [x>=0]
  --gapextend INTEGER RANGE       Cost to extend a gap  [x>=0]
  --help                          Show this message and exit.
```


## blast2galaxy_blastp

### Tool Description
search protein databases using a protein query

### Metadata
- **Docker Image**: quay.io/biocontainers/blast2galaxy:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/IPK-BIT/blast2galaxy
- **Package**: https://anaconda.org/channels/bioconda/packages/blast2galaxy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: blast2galaxy blastp [OPTIONS]

  search protein databases using a protein query

Options:
  --profile TEXT                  ID of the profile as defined in your config
                                  TOML. The profile consists of Galaxy server
                                  credentials and a Galaxy Tool-ID to be used
                                  for your BLAST call  [default: default]
  --query TEXT                    Path / filename of file with nucleotide
                                  query sequence(s)  [required]
  --task [blastp|blastp-short|blastp-fast]
                                  Task type  [default: blastp]
  --db TEXT                       Database name  [required]
  --evalue TEXT                   Expectation value cutoff  [default: 0.001]
  --out TEXT                      Path / filename of file to store the BLAST
                                  result
  --outfmt [0|2|4|5|6|ext|json]   Output format  [default: 6]
  --html                          Format output as HTML document
  --seg [yes|no]                  Filter out low complexity regions (with SEG)
                                  [default: yes]
  --matrix TEXT                   Scoring matrix name (normally BLOSUM62)
  --max_target_seqs INTEGER RANGE
                                  Maximum number of aligned sequences to keep
                                  (value of 5 or more is recommended) Default
                                  = 500  [default: 500; x>=1]
  --num_descriptions INTEGER RANGE
                                  Number of database sequences to show one-
                                  line descriptions for. Not applicable for
                                  outfmt > 4. Default = 500 * Incompatible
                                  with:  max_target_seqs  [default: 500; x>=0]
  --num_alignments INTEGER RANGE  Number of database sequences to show
                                  alignments for. Default = 250 * Incompatible
                                  with:  max_target_seqs  [default: 250; x>=0]
  --threshold FLOAT RANGE         Minimum word score such that the word is
                                  added to the BLAST lookup table  [x>=0.0]
  --max_hsps INTEGER              Maximum number of HSPs (alignments) to keep
                                  for any single query-subject pair
  --word_size INTEGER RANGE       Word size for wordfinder algorithm  [x>=2]
  --ungapped                      Perform ungapped alignment only?
  --parse_deflines                Should the query and subject defline(s) be
                                  parsed?
  --qcov_hsp_perc FLOAT RANGE     Minimum query coverage per hsp (percentage,
                                  0 to 100)  [default: 0.0; 0.0<=x<=100.0]
  --window_size INTEGER RANGE     Multiple hits window size: use 0 to specify
                                  1-hit algorithm, leave blank for default
                                  [x>=1]
  --gapopen INTEGER RANGE         Cost to open a gap  [x>=0]
  --gapextend INTEGER RANGE       Cost to extend a gap  [x>=0]
  --comp_based_stats TEXT         Use composition-based statistics: D or d:
                                  default (equivalent to 2 ); 0 or F or f: No
                                  composition-based statistics; 1:
                                  Composition-based statistics as in NAR
                                  29:2994-3005, 2001; 2 or T or t :
                                  Composition-based score adjustment as in
                                  Bioinformatics 21:902-911, 2005, conditioned
                                  on sequence properties; 3: Composition-based
                                  score adjustment as in Bioinformatics
                                  21:902-911, 2005, unconditionally  [default:
                                  2]
  --use_sw_tback                  Compute locally optimal Smith-Waterman
                                  alignments?
  --help                          Show this message and exit.
```


## blast2galaxy_blastx

### Tool Description
search protein databases using a translated nucleotide query

### Metadata
- **Docker Image**: quay.io/biocontainers/blast2galaxy:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/IPK-BIT/blast2galaxy
- **Package**: https://anaconda.org/channels/bioconda/packages/blast2galaxy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: blast2galaxy blastx [OPTIONS]

  search protein databases using a translated nucleotide query

Options:
  --profile TEXT                  ID of the profile as defined in your config
                                  TOML. The profile consists of Galaxy server
                                  credentials and a Galaxy Tool-ID to be used
                                  for your BLAST call  [default: default]
  --query TEXT                    Path / filename of file with nucleotide
                                  query sequence(s)  [required]
  --task [blastx|blastx-fast]     Task type  [default: blastx]
  --db TEXT                       Database name  [required]
  --evalue TEXT                   Expectation value cutoff  [default: 0.001]
  --out TEXT                      Path / filename of file to store the BLAST
                                  result
  --outfmt [0|2|4|5|6|ext|json]   Output format  [default: 6]
  --html                          Format output as HTML document
  --seg [yes|no]                  Filter out low complexity regions (with SEG)
                                  [default: yes]
  --matrix TEXT                   Scoring matrix name (normally BLOSUM62)
  --max_target_seqs INTEGER RANGE
                                  Maximum number of aligned sequences to keep
                                  (value of 5 or more is recommended) Default
                                  = 500  [default: 500; x>=1]
  --num_descriptions INTEGER RANGE
                                  Number of database sequences to show one-
                                  line descriptions for. Not applicable for
                                  outfmt > 4. Default = 500 * Incompatible
                                  with:  max_target_seqs  [default: 500; x>=0]
  --num_alignments INTEGER RANGE  Number of database sequences to show
                                  alignments for. Default = 250 * Incompatible
                                  with:  max_target_seqs  [default: 250; x>=0]
  --threshold FLOAT RANGE         Minimum word score such that the word is
                                  added to the BLAST lookup table  [x>=0.0]
  --max_hsps INTEGER              Maximum number of HSPs (alignments) to keep
                                  for any single query-subject pair
  --word_size INTEGER RANGE       Word size for wordfinder algorithm  [x>=2]
  --ungapped                      Perform ungapped alignment only?
  --parse_deflines                Should the query and subject defline(s) be
                                  parsed?
  --qcov_hsp_perc FLOAT RANGE     Minimum query coverage per hsp (percentage,
                                  0 to 100)  [default: 0.0; 0.0<=x<=100.0]
  --window_size INTEGER RANGE     Multiple hits window size: use 0 to specify
                                  1-hit algorithm, leave blank for default
                                  [x>=1]
  --gapopen INTEGER RANGE         Cost to open a gap  [x>=0]
  --gapextend INTEGER RANGE       Cost to extend a gap  [x>=0]
  --comp_based_stats TEXT         Use composition-based statistics: D or d:
                                  default (equivalent to 2 ); 0 or F or f: No
                                  composition-based statistics; 1:
                                  Composition-based statistics as in NAR
                                  29:2994-3005, 2001; 2 or T or t :
                                  Composition-based score adjustment as in
                                  Bioinformatics 21:902-911, 2005, conditioned
                                  on sequence properties; 3: Composition-based
                                  score adjustment as in Bioinformatics
                                  21:902-911, 2005, unconditionally  [default:
                                  2]
  --help                          Show this message and exit.
```


## blast2galaxy_diamond-blastp

### Tool Description
search protein databases using a protein query with DIAMOND

### Metadata
- **Docker Image**: quay.io/biocontainers/blast2galaxy:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/IPK-BIT/blast2galaxy
- **Package**: https://anaconda.org/channels/bioconda/packages/blast2galaxy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: blast2galaxy diamond-blastp [OPTIONS]

  search protein databases using a protein query with DIAMOND

Options:
  --profile TEXT                  ID of the profile as defined in your config
                                  TOML. The profile consists of Galaxy server
                                  credentials and a Galaxy Tool-ID to be used
                                  for your BLAST call  [default: default]
  --query TEXT                    Path / filename of file with nucleotide
                                  query sequence(s)  [required]
  --task [blastp|blastp-short|blastp-fast]
                                  Task type  [default: blastp]
  --db TEXT                       Database name  [required]
  --evalue TEXT                   Expectation value cutoff  [default: 0.001]
  --out TEXT                      Path / filename of file to store the BLAST
                                  result
  --outfmt TEXT                   Output format  [default: 0]
  --faster
  --fast
  --mid-sensitive
  --sensitive
  --more-sensitive
  --very-sensitive
  --ultra-sensitive
  --strand [both|plus|minus]      Query strand(s) to search against
                                  database/subject  [default: both]
  --matrix TEXT                   Scoring matrix name (normally BLOSUM62)
                                  [default: BLOSUM62]
  --max-target-seqs INTEGER RANGE
                                  Maximum number of aligned sequences to keep
                                  (value of 5 or more is recommended) Default
                                  = 500  [default: 500; x>=1]
  --max-hsps INTEGER              Maximum number of HSPs (alignments) to keep
                                  for any single query-subject pair
  --window INTEGER RANGE          Multiple hits window size: use 0 to specify
                                  1-hit algorithm, leave blank for default
                                  [x>=1]
  --gapopen INTEGER RANGE         Cost to open a gap  [x>=0]
  --gapextend INTEGER RANGE       Cost to extend a gap  [x>=0]
  --comp-based-stats TEXT         Use composition-based statistics: D or d:
                                  default (equivalent to 2 ); 0 or F or f: No
                                  composition-based statistics; 1:
                                  Composition-based statistics as in NAR
                                  29:2994-3005, 2001; 2 or T or t :
                                  Composition-based score adjustment as in
                                  Bioinformatics 21:902-911, 2005, conditioned
                                  on sequence properties; 3: Composition-based
                                  score adjustment as in Bioinformatics
                                  21:902-911, 2005, unconditionally  [default:
                                  1]
  --help                          Show this message and exit.
```


## blast2galaxy_diamond-blastx

### Tool Description
search protein databases using a translated nucleotide query with DIAMOND

### Metadata
- **Docker Image**: quay.io/biocontainers/blast2galaxy:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/IPK-BIT/blast2galaxy
- **Package**: https://anaconda.org/channels/bioconda/packages/blast2galaxy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: blast2galaxy diamond-blastx [OPTIONS]

  search protein databases using a translated nucleotide query with DIAMOND

Options:
  --profile TEXT                  ID of the profile as defined in your config
                                  TOML. The profile consists of Galaxy server
                                  credentials and a Galaxy Tool-ID to be used
                                  for your BLAST call  [default: default]
  --query TEXT                    Path / filename of file with nucleotide
                                  query sequence(s)  [required]
  --task [blastp|blastp-short|blastp-fast]
                                  Task type  [default: blastp]
  --db TEXT                       Database name  [required]
  --evalue TEXT                   Expectation value cutoff  [default: 0.001]
  --out TEXT                      Path / filename of file to store the BLAST
                                  result
  --outfmt TEXT                   Output format  [default: 0]
  --faster
  --fast
  --mid-sensitive
  --sensitive
  --more-sensitive
  --very-sensitive
  --ultra-sensitive
  --strand [both|plus|minus]      Query strand(s) to search against
                                  database/subject  [default: both]
  --matrix TEXT                   Scoring matrix name (normally BLOSUM62)
                                  [default: BLOSUM62]
  --max-target-seqs INTEGER RANGE
                                  Maximum number of aligned sequences to keep
                                  (value of 5 or more is recommended) Default
                                  = 500  [default: 500; x>=1]
  --max-hsps INTEGER              Maximum number of HSPs (alignments) to keep
                                  for any single query-subject pair
  --window INTEGER RANGE          Multiple hits window size: use 0 to specify
                                  1-hit algorithm, leave blank for default
                                  [x>=1]
  --gapopen INTEGER RANGE         Cost to open a gap  [x>=0]
  --gapextend INTEGER RANGE       Cost to extend a gap  [x>=0]
  --comp-based-stats TEXT         Use composition-based statistics: D or d:
                                  default (equivalent to 2 ); 0 or F or f: No
                                  composition-based statistics; 1:
                                  Composition-based statistics as in NAR
                                  29:2994-3005, 2001; 2 or T or t :
                                  Composition-based score adjustment as in
                                  Bioinformatics 21:902-911, 2005, conditioned
                                  on sequence properties; 3: Composition-based
                                  score adjustment as in Bioinformatics
                                  21:902-911, 2005, unconditionally  [default:
                                  1]
  --help                          Show this message and exit.
```


## blast2galaxy_list-dbs

### Tool Description
list available databases of a BLAST+ or DIAMOND tool installed on a Galaxy server

### Metadata
- **Docker Image**: quay.io/biocontainers/blast2galaxy:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/IPK-BIT/blast2galaxy
- **Package**: https://anaconda.org/channels/bioconda/packages/blast2galaxy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: blast2galaxy list-dbs [OPTIONS]

  list available databases of a BLAST+ or DIAMOND tool installed on a Galaxy
  server

Options:
  --server TEXT  Server-ID as in your config TOML  [default: default]
  --tool TEXT    Tool-ID of a tool available on the Galaxy server  [required]
  --help         Show this message and exit.
```


## blast2galaxy_list-tools

### Tool Description
list available and compatible BLAST+ and DIAMOND tools installed on a Galaxy server

### Metadata
- **Docker Image**: quay.io/biocontainers/blast2galaxy:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/IPK-BIT/blast2galaxy
- **Package**: https://anaconda.org/channels/bioconda/packages/blast2galaxy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: blast2galaxy list-tools [OPTIONS]

  list available and compatible BLAST+ and DIAMOND tools installed on a Galaxy
  server

Options:
  --server TEXT                   Server-ID as in your config TOML  [default:
                                  default]
  --type [blastn|tblastn|blastp|blastx|diamond]
                                  Type of BLAST search
  --help                          Show this message and exit.
```


## blast2galaxy_show-config

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/blast2galaxy:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/IPK-BIT/blast2galaxy
- **Package**: https://anaconda.org/channels/bioconda/packages/blast2galaxy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: blast2galaxy show-config [OPTIONS]

  Show information about the currently available configuration loaded from a
  .blast2galaxy.toml file

Options:
  --help  Show this message and exit.
```


## blast2galaxy_tblastn

### Tool Description
search translated nucleotide databases using a protein query

### Metadata
- **Docker Image**: quay.io/biocontainers/blast2galaxy:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/IPK-BIT/blast2galaxy
- **Package**: https://anaconda.org/channels/bioconda/packages/blast2galaxy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: blast2galaxy tblastn [OPTIONS]

  search translated nucleotide databases using a protein query

Options:
  --profile TEXT                  ID of the profile as defined in your config
                                  TOML. The profile consists of Galaxy server
                                  credentials and a Galaxy Tool-ID to be used
                                  for your BLAST call  [default: default]
  --query TEXT                    Path / filename of file with nucleotide
                                  query sequence(s)  [required]
  --task [tblastn|tblastn-fast]   Task type  [default: tblastn]
  --db TEXT                       Database name  [required]
  --evalue TEXT                   Expectation value cutoff  [default: 0.001]
  --out TEXT                      Path / filename of file to store the BLAST
                                  result
  --outfmt [0|2|4|5|6|ext|json]   Output format  [default: 6]
  --html                          Format output as HTML document
  --seg [yes|no]                  Filter out low complexity regions (with SEG)
                                  [default: yes]
  --db_gencode INTEGER            Genetic code to use to translate
                                  database/subjects (see user manual for
                                  details)  [default: 1]
  --matrix TEXT                   Scoring matrix name (normally BLOSUM62)
  --max_target_seqs INTEGER RANGE
                                  Maximum number of aligned sequences to keep
                                  (value of 5 or more is recommended) Default
                                  = 500  [default: 500; x>=1]
  --num_descriptions INTEGER RANGE
                                  Number of database sequences to show one-
                                  line descriptions for. Not applicable for
                                  outfmt > 4. Default = 500 * Incompatible
                                  with:  max_target_seqs  [default: 500; x>=0]
  --num_alignments INTEGER RANGE  Number of database sequences to show
                                  alignments for. Default = 250 * Incompatible
                                  with:  max_target_seqs  [default: 250; x>=0]
  --threshold FLOAT RANGE         Minimum word score such that the word is
                                  added to the BLAST lookup table  [x>=0.0]
  --max_hsps INTEGER              Maximum number of HSPs (alignments) to keep
                                  for any single query-subject pair
  --word_size INTEGER RANGE       Word size for wordfinder algorithm  [x>=2]
  --ungapped                      Perform ungapped alignment only?
  --parse_deflines                Should the query and subject defline(s) be
                                  parsed?
  --qcov_hsp_perc FLOAT RANGE     Minimum query coverage per hsp (percentage,
                                  0 to 100)  [default: 0.0; 0.0<=x<=100.0]
  --window_size INTEGER RANGE     Multiple hits window size: use 0 to specify
                                  1-hit algorithm, leave blank for default
                                  [x>=1]
  --gapopen INTEGER RANGE         Cost to open a gap  [x>=0]
  --gapextend INTEGER RANGE       Cost to extend a gap  [x>=0]
  --comp_based_stats TEXT         Use composition-based statistics: D or d:
                                  default (equivalent to 2 ); 0 or F or f: No
                                  composition-based statistics; 1:
                                  Composition-based statistics as in NAR
                                  29:2994-3005, 2001; 2 or T or t :
                                  Composition-based score adjustment as in
                                  Bioinformatics 21:902-911, 2005, conditioned
                                  on sequence properties; 3: Composition-based
                                  score adjustment as in Bioinformatics
                                  21:902-911, 2005, unconditionally  [default:
                                  2]
  --help                          Show this message and exit.
```

