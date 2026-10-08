# flams CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| flams | PASS |  |

## flams

### Tool Description
Find Lysine Acylations & other Modification Sites.

### Metadata
- **Docker Image**: quay.io/biocontainers/flams:1.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/hannelorelongin/FLAMS
- **Package**: https://anaconda.org/channels/bioconda/packages/flams/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flams/overview
- **Total Downloads**: 9.8K
- **Last updated**: 2026-02-04
- **GitHub**: https://github.com/hannelorelongin/FLAMS
- **Stars**: N/A
### Original Help Text
```text
usage: FLAMS [-h]
             (--in inputFilePath | --id UniProtID | --batch batchFilePath)
             [-p position] [--range errorRange] [-o outputFilePath]
             [-d dataDir] [-t threadsBLAST] [-e evalueBLAST]
             [-m modification [modification ...]]

Find Lysine Acylations & other Modification Sites.

options:
  -h, --help            show this help message and exit
  --in inputFilePath    Path to input .fasta file.
  --id UniProtID        UniProt ID of input protein.
  --batch batchFilePath
                        Path to tab seperated input file for batch processing
                        (1st column UniProt ID, 2nd column position). One
                        query (UniProtID + position) per line.
  -p position, --pos position
                        Position in input protein that will be searched for
                        conserved modifications.
  --range errorRange    Allowed error range for position. [default: 0]
  -o outputFilePath, --output outputFilePath
                        Path to output .tsv file. [default: out.tsv] If FLAMS
                        is run with --batch, the specified -o/--output is used
                        as preposition, followed by
                        '_$UniProtID_$position.tsv'. [default: '']
  -d dataDir, --data_dir dataDir
                        Path to directory where intermediate files should be
                        saved. [default: $PWD/data]
  -t threadsBLAST, --num_threads threadsBLAST
                        Number of threads to run BLAST with. [default: 1]
  -e evalueBLAST, --evalue evalueBLAST
                        Desired E-value of BLAST run. [default: 0.01]
  -m modification [modification ...], --modification modification [modification ...]
                        Space-seperated list of modifications (all lower case)
                        to search for at the given position. Possible values
                        are any (combinations) of the CPLM, dbPTM and SCOP3P
                        modifications. We also provide aggregated combinations
                        for each amino acid (AA-All), and the CPLM
                        combinations. For a full list of all supported PTMs,
                        and how they are named, see the Supported PTM types
                        section of the README. In general, PTMs are written
                        all lowercase, and spaces within a PTM name are
                        replaced by underscores. [default: K-All]
```

