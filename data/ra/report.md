# ra CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ra_consensus | Failed | tool bug: consensus segfaults on any input (map_reads resizes an array to zero size) |
| ra_depot_dump_overlaps | PASS |  |
| ra_depot_dump_reads | PASS |  |
| ra_depot_import_overlaps | PASS |  |
| ra_depot_import_reads | PASS |  |
| ra_fill_read_coverage | PASS |  |
| ra_filter_contained | PASS |  |
| ra_filter_erroneous_overlaps | PASS |  |
| ra_filter_transitive | PASS | ran on real MHAP overlaps of a real RNA-seq read set; removed 0 overlaps as transitive on this data |
| ra_overlap2dot | PASS |  |
| ra_ra_consensus | PASS |  |
| ra_to_afg | PASS |  |
| ra_unitigger | PASS |  |
| ra_widen_overlaps | PASS |  |
| ra_zoom | PASS |  |

## ra_to_afg

### Tool Description
[ERROR][IO]: missing option -i (reads file)

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
[ERROR][IO]: missing option -i (reads file)

usage: to_afg -i <reads file> [arguments ...]

arguments:
    -i, --reads <file>
        (required)
        input fasta/fastq reads file
    --fastq
        default: fasta format
        format of input reads file
    -o, --out <file>
        output afg reads file
    -h, -help
        prints out the help
```

## ra_ra_consensus

### Tool Description
[ERROR][IO]: missing option -i (reads file)

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
[ERROR][IO]: missing option -i (reads file)

usage: ra_layout -i <reads file> -j <overlaps file> [arguments ...]

arguments:
    -i, --reads <file>
        (required)
        input afg reads file
    -j, --contigs <file>
        (required)
        input afg contigs file
    -t, --threads <int>
        default: approx. number of processors/cores
        number of threads used
    -o, --out <file>
        default: cout
        output fasta transcripts file
    -h, -help
        prints out the help
```

## ra_consensus

### Tool Description
usage: consensus --reads=string --contigs=string [options] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: consensus --reads=string --contigs=string [options] ... 
options:
  -r, --reads      reads file (string)
  -c, --contigs    contigs file (string)
  -?, --help       print this message

undefined short option: -h
usage: consensus --reads=string --contigs=string [options] ... 
options:
  -r, --reads      reads file (string)
  -c, --contigs    contigs file (string)
  -?, --help       print this message
```

## ra_depot_import_reads

### Tool Description
usage: depot --depot=string [options] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: depot --depot=string [options] ... 
options:
  -d, --depot              depot path (string)
  -r, --reads              reads file (string [=])
  -x, --overlaps           overlaps file (string [=])
  -X, --overlaps_format    overlaps format; supported: mhap, radump (string [=mhap])
  -s, --reads_format       reads format; supported: fasta, fastq, afg (string [=fasta])
  -?, --help               print this message

undefined short option: -h
usage: depot --depot=string [options] ... 
options:
  -d, --depot              depot path (string)
  -r, --reads              reads file (string [=])
  -x, --overlaps           overlaps file (string [=])
  -X, --overlaps_format    overlaps format; supported: mhap, radump (string [=mhap])
  -s, --reads_format       reads format; supported: fasta, fastq, afg (string [=fasta])
  -?, --help               print this message
```

## ra_depot_import_overlaps

### Tool Description
usage: depot --depot=string [options] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: depot --depot=string [options] ... 
options:
  -d, --depot              depot path (string)
  -r, --reads              reads file (string [=])
  -x, --overlaps           overlaps file (string [=])
  -X, --overlaps_format    overlaps format; supported: mhap, radump (string [=mhap])
  -s, --reads_format       reads format; supported: fasta, fastq, afg (string [=fasta])
  -?, --help               print this message

undefined short option: -h
usage: depot --depot=string [options] ... 
options:
  -d, --depot              depot path (string)
  -r, --reads              reads file (string [=])
  -x, --overlaps           overlaps file (string [=])
  -X, --overlaps_format    overlaps format; supported: mhap, radump (string [=mhap])
  -s, --reads_format       reads format; supported: fasta, fastq, afg (string [=fasta])
  -?, --help               print this message
```

## ra_depot_dump_overlaps

### Tool Description
usage: depot --depot=string [options] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: depot --depot=string [options] ... 
options:
  -d, --depot              depot path (string)
  -r, --reads              reads file (string [=])
  -x, --overlaps           overlaps file (string [=])
  -X, --overlaps_format    overlaps format; supported: mhap, radump (string [=mhap])
  -s, --reads_format       reads format; supported: fasta, fastq, afg (string [=fasta])
  -?, --help               print this message

undefined short option: -h
usage: depot --depot=string [options] ... 
options:
  -d, --depot              depot path (string)
  -r, --reads              reads file (string [=])
  -x, --overlaps           overlaps file (string [=])
  -X, --overlaps_format    overlaps format; supported: mhap, radump (string [=mhap])
  -s, --reads_format       reads format; supported: fasta, fastq, afg (string [=fasta])
  -?, --help               print this message
```

## ra_depot_dump_reads

### Tool Description
usage: depot --depot=string [options] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: depot --depot=string [options] ... 
options:
  -d, --depot              depot path (string)
  -r, --reads              reads file (string [=])
  -x, --overlaps           overlaps file (string [=])
  -X, --overlaps_format    overlaps format; supported: mhap, radump (string [=mhap])
  -s, --reads_format       reads format; supported: fasta, fastq, afg (string [=fasta])
  -?, --help               print this message

undefined short option: -h
usage: depot --depot=string [options] ... 
options:
  -d, --depot              depot path (string)
  -r, --reads              reads file (string [=])
  -x, --overlaps           overlaps file (string [=])
  -X, --overlaps_format    overlaps format; supported: mhap, radump (string [=mhap])
  -s, --reads_format       reads format; supported: fasta, fastq, afg (string [=fasta])
  -?, --help               print this message
```

## ra_fill_read_coverage

### Tool Description
usage: fill_read_coverage --depot=string [options] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fill_read_coverage --depot=string [options] ... 
options:
  -d, --depot    depot path (string)
  -?, --help     print this message

undefined short option: -h
usage: fill_read_coverage --depot=string [options] ... 
options:
  -d, --depot    depot path (string)
  -?, --help     print this message
```

## ra_filter_contained

### Tool Description
usage: filter_contained --depot=string [options] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_contained --depot=string [options] ... 
options:
  -d, --depot    depot path (string)
  -?, --help     print this message

undefined short option: -h
usage: filter_contained --depot=string [options] ... 
options:
  -d, --depot    depot path (string)
  -?, --help     print this message
```

## ra_filter_transitive

### Tool Description
usage: filter_transitive --depot=string [options] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_transitive --depot=string [options] ... 
options:
  -d, --depot    depot path (string)
  -?, --help     print this message

undefined short option: -h
usage: filter_transitive --depot=string [options] ... 
options:
  -d, --depot    depot path (string)
  -?, --help     print this message
```

## ra_widen_overlaps

### Tool Description
usage: widen_overlaps --depot=string [options] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: widen_overlaps --depot=string [options] ... 
options:
  -d, --depot    depot path (string)
  -?, --help     print this message

undefined short option: -h
usage: widen_overlaps --depot=string [options] ... 
options:
  -d, --depot    depot path (string)
  -?, --help     print this message
```

## ra_filter_erroneous_overlaps

### Tool Description
usage: filter_erroneous_overlaps --depot=string [options] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter_erroneous_overlaps --depot=string [options] ... 
options:
  -d, --depot                depot path (string)
  -s, --spec_file            spec file path (string [=])
  -w, --working_directory    working directory (string [=.])
  -?, --help                 print this message

undefined short option: -h
usage: filter_erroneous_overlaps --depot=string [options] ... 
options:
  -d, --depot                depot path (string)
  -s, --spec_file            spec file path (string [=])
  -w, --working_directory    working directory (string [=.])
  -?, --help                 print this message
```

## ra_unitigger

### Tool Description
usage: unitigger --depot=string [options] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: unitigger --depot=string [options] ... 
options:
  -s, --spec_file            spec file (string [=])
  -d, --depot                depot path (string)
  -w, --working_directory    working directory (string [=.])
  -?, --help                 print this message

undefined short option: -h
usage: unitigger --depot=string [options] ... 
options:
  -s, --spec_file            spec file (string [=])
  -d, --depot                depot path (string)
  -w, --working_directory    working directory (string [=.])
  -?, --help                 print this message
```

## ra_zoom

### Tool Description
usage: zoom --root=int --depth=int --depot=string [options] ...

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
usage: zoom --root=int --depth=int --depot=string [options] ... 
options:
  -r, --root     root read (int)
  -n, --depth    neighborhood depth (int)
  -d, --depot    depot path (string)
  -?, --help     print this message

undefined short option: -h
usage: zoom --root=int --depth=int --depot=string [options] ... 
options:
  -r, --root     root read (int)
  -n, --depth    neighborhood depth (int)
  -d, --depot    depot path (string)
  -?, --help     print this message
```

## ra_overlap2dot

### Tool Description
Reads filename is not provided

### Metadata
- **Docker Image**: quay.io/biocontainers/ra:0.9--h503566f_8
- **Homepage**: https://github.com/mariokostelac/ra
- **Package**: https://anaconda.org/channels/bioconda/packages/ra/overview
- **Validation**: PASS

### Original Help Text
```text
Reads filename is not provided

undefined short option: -h
usage: overlap2dot [options] ... 
options:
  -r, --reads           reads file (string [=])
  -x, --overlaps        overlaps file (string [=])
  -s, --reads_format    reads format; supported: fasta, fastq, afg (string [=fasta])
  -?, --help            print this message
```

## Metadata
- **Skill**: not generated
