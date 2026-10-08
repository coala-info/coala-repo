# emmtyper CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| emmtyper | PASS | two real Streptococcus pyogenes genomes from NCBI typed as EMM1 and EMM18 with the blast and pcr workflows |
| emmtyper_emmtyper-db | Failed | tool bug: emmtyper-db crashes at start in a container (read-only install folder gives OSError, setting EMM_DB gives TypeError), and the CDC FTP login also fails |

## emmtyper

### Tool Description
Welcome to emmtyper.

### emmtyper_emmtyper-db

### Tool Description
Update the EMM database used by emmtyper (EMAIL is needed to connect to the CDC FTP server)

### Metadata
- **Docker Image**: quay.io/biocontainers/emmtyper:0.2.0--py_0
- **Homepage**: https://github.com/MDUPHL/emmtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/emmtyper/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: emmtyper-db [OPTIONS] EMAIL

  EMAIL is needed to connect to CDC FTP server.

  By default, db_folder will be taken from EMM_DB environmental folder. If
  can't find the folder, will default to where emmtyper is installed. If it
  cannot write to the installation folder, it will make a suggestion in your
  /home folder.

Options:
  -d, --db_folder TEXT  Where to update the DB  [default:
                        /usr/local/lib/python3.7/site-packages/emmtyper/db]

  --help                Show this message and exit.
```

## Metadata
- **Docker Image**: quay.io/biocontainers/emmtyper:0.2.0--py_0
- **Homepage**: https://github.com/MDUPHL/emmtyper
- **Package**: https://anaconda.org/channels/bioconda/packages/emmtyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/emmtyper/overview
- **Total Downloads**: 7.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MDUPHL/emmtyper
- **Stars**: N/A
### Original Help Text
```text
Usage: emmtyper [OPTIONS] [FASTA]...

  Welcome to emmtyper.

  Usage:

  emmtyper *.fasta

Options:
  --version                       Show the version and exit.
  -w, --workflow [blast|pcr]      Choose workflow  [default: blast]
  -d, --blast_db TEXT             Path to EMM BLAST DB  [default:
                                  /usr/local/lib/python3.7/site-
                                  packages/emmtyper/db/emm.fna]

  -k, --keep                      Keep BLAST and isPcr output files.
                                  [default: False]

  -d, --cluster-distance INTEGER  Distance between cluster of matches to
                                  consider as different clusters.  [default:
                                  500]

  -o, --output TEXT               Output stream. Path to file for output to a
                                  file.  [default: stdout]

  -f, --output-format [short|verbose|visual]
                                  Output format.
  --dust [yes|no|level window linker]
                                  [BLAST] Filter query sequence with DUST.
                                  [default: no]

  --percent-identity INTEGER      [BLAST] Minimal percent identity of
                                  sequence.  [default: 95]

  --culling-limit INTEGER         [BLAST] Total hits to return in a position.
                                  [default: 5]

  --mismatch INTEGER              [BLAST] Threshold for number of mismatch to
                                  allow in BLAST hit.  [default: 4]

  --align-diff INTEGER            [BLAST] Threshold for difference between
                                  alignment length and subject length in BLAST
                                  hit.  [default: 5]

  --gap INTEGER                   [BLAST] Threshold gap to allow in BLAST hit.
                                  [default: 2]

  --blast-path TEXT               [BLAST] Specify full path to blastn
                                  executable.

  --primer-db TEXT                [isPcr] PCR primer. Text file with 3
                                  columns: Name, Forward Primer, Reverse
                                  Primer.  [default:
                                  /usr/local/lib/python3.7/site-
                                  packages/emmtyper/data/isPcrPrim.tsv]

  --min-perfect INTEGER           [isPcr] Minimum size of perfect match at 3'
                                  primer end.  [default: 15]

  --min-good INTEGER              [isPcr] Minimum size where there must be 2
                                  matches for each mismatch.  [default: 15]

  --max-size INTEGER              [isPcr] Maximum size of PCR product.
                                  [default: 2000]

  --ispcr-path TEXT               [isPcr] Specify full path to isPcr
                                  executable.

  --help                          Show this message and exit.
```

