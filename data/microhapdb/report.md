# microhapdb CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| microhapdb_frequency | PASS | marker, population and allele options return the expected frequencies |
| microhapdb_lookup | PASS | positions and rsIDs match the repo marker.csv |
| microhapdb_marker | PASS | region, panel, query and column options checked against marker.csv; fasta/detail/offsets formats need the GRCh38 genome download, not tested |
| microhapdb_population | PASS | ids and query options return the expected populations |
| microhapdb_summarize | PASS | counts (3053 alleles, 2413 loci) match marker.csv |

## microhapdb_lookup

### Tool Description
Retrieve marker or population records by name or identifier

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapdb:0.12--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapDB/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapdb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: microhapdb lookup [-h] id

Retrieve marker or population records by name or identifier

positional arguments:
  id          record identifier

options:
  -h, --help  show this help message and exit

Examples::

    microhapdb lookup rs10815466
    microhapdb lookup mh12KK-043
    microhapdb lookup Japanese
```

## microhapdb_marker

### Tool Description
Retrieve marker records by identifier or query

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapdb:0.12--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapDB/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapdb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: microhapdb marker [-h] [--ae-pop POP] [--panel FILE] [--region RGN]
                         [--query QRY] [--format {table,detail,fasta,offsets}]
                         [--columns C] [--delta D] [--min-length L]
                         [--extend-mode E] [--notrunc]
                         [id ...]

Retrieve marker records by identifier or query

Required Arguments:
  id                    one or more marker identifiers

Options:
  -h, --help            show this help message and exit

Data Retrieval:
  Configure how marker records are retrieved from the database.

  --ae-pop POP          specify the 1000 Genomes population from which to
                        report effective number of alleles in the "Ae" column;
                        by default, the Ae value averaged over all 26 1KGP
                        populations is reported
  --panel FILE          file containing a list of marker names/identifiers,
                        one per line
  --region RGN          restrict results to the specified genomic region;
                        format chrX:YYYY-ZZZZZ
  --query QRY           Retrieve records using a Pandas-style query

Formatting:
  Configure how results are formatted. Some formats include information for a 'target sequence' for each marker, representing what would be targeted by e.g. hybridization capture probes or PCR primers for amplicon sequencing. MicroHapDB computes the endpoints of these target sequences by extending `--delta=D` nucleotides beyond the first and last SNPs defining the marker, and then—if needed—extending further until `--min-length=L` is satisfied. Configuration of these and related parameters is described below.

  --format {table,detail,fasta,offsets}
  --columns C           string of column codes indicating which fields to
                        include in tabular output; n=NumVars x=Extent c=Chrom
                        s=Start e=End p=Positions q=Positions37 r=RSIDs a=Ae;
                        by default C=nxcsea
  --delta D             extend D nucleotides beyond the marker extent when
                        computing target sequence boundaries; by default D=10
  --min-length L        minimum length of the target sequence; by default L=80
  --extend-mode E       specify how the target sequence will be extended to
                        satisfy the minimum length criterion; use `5` to
                        extend only the 5' end, `3` to extend only the 3' end,
                        or `symmetric` to extend both ends equally; by
                        default, symmetric mode is used
  --notrunc             disable truncation of tabular results

Examples::

    microhapdb marker mh01NK-001
    microhapdb marker --format=fasta mh13KK-218 mh04CP-002 mh02AT-05
    microhapdb marker --format=fasta --panel mypanel.txt
    microhapdb marker --format=detail --min-length=125 --extend-mode=3 MHDBM-dc55cd9e
    microhapdb marker --region=chr18:1-25000000 --columns nxcqa
    microhapdb marker --query='Source == "ALFRED"' --ae-pop CEU
    microhapdb marker --query='Name.str.contains("PK")'
```

## microhapdb_population

### Tool Description
Retrieve population records by identifier or query

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapdb:0.12--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapDB/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapdb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: microhapdb population [-h] [--format {table,detail}] [--query STRING]
                             [id ...]

Retrieve population records by identifier or query

positional arguments:
  id                    population identifier(s)

options:
  -h, --help            show this help message and exit
  --format {table,detail}
  --query STRING        Retrieve records using a Pandas-style query

Examples::

    microhapdb population SA004244O
    microhapdb population Han Japanese Koreans
    microhapdb population --format=detail 'Melanesian, Nasioi'
    microhapdb population --query='Source == "10.1016/j.fsigen.2018.05.008"'
```

## microhapdb_frequency

### Tool Description
Retrieve population allele frequencies

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapdb:0.12--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapDB/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapdb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: microhapdb frequency [-h] [--format {table,mhpl8r,efm}]
                            [--marker ID [ID ...] | --panel FILE]
                            [--population ID [ID ...]] [--allele ID]

Retrieve population allele frequencies

options:
  -h, --help            show this help message and exit
  --format {table,mhpl8r,efm}
  --marker ID [ID ...]  restrict frequencies by marker
  --panel FILE          restrict frequencies to markers listed in FILE, one ID
                        per line
  --population ID [ID ...]
                        restrict frequencies by population
  --allele ID           restrict frequencies by allele

Examples::

    microhapdb frequency --marker=mh22KK-060 --population=SA000001B
    microhapdb frequency --marker=mh22KK-060 --allele='C|A'
```

## microhapdb_summarize

### Tool Description
Summarize MicroHapDB database contents

### Metadata
- **Docker Image**: quay.io/biocontainers/microhapdb:0.12--pyhdfd78af_0
- **Homepage**: https://github.com/bioforensics/MicroHapDB/
- **Package**: https://anaconda.org/channels/bioconda/packages/microhapdb/overview
- **Validation**: PASS

### Original Help Text
```text
usage: microhapdb summarize [-h]

Summarize MicroHapDB database contents

options:
  -h, --help  show this help message and exit
```

