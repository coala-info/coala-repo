# rnahybrid CWL Generation Report

## rnahybrid_RNAhybrid

### Tool Description
RNAhybrid finds potential hybridization sites of a query RNA sequence in a target RNA sequence.

### Metadata
- **Docker Image**: biocontainers/rnahybrid:v2.1.2-5-deb_cv1
- **Homepage**: https://bibiserv.cebitec.uni-bielefeld.de/rnahybrid
- **Package**: https://anaconda.org/channels/bioconda/packages/rnahybrid/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rnahybrid/overview
- **Total Downloads**: 4.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: RNAhybrid [options] [target sequence] [query sequence].

options:

  -b <number of hits per target>
  -c compact output
  -d <xi>,<theta>
  -f helix constraint
  -h help
  -m <max targetlength>
  -n <max query length>
  -u <max internal loop size (per side)>
  -v <max bulge loop size>
  -e <energy cut-off>
  -p <p-value cut-off>
  -s (3utr_fly|3utr_worm|3utr_human)
  -g (ps|png|jpg|all)
  -t <target file>
  -q <query file>

Either a target file has to be given (FASTA format)
or one target sequence directly.

Either a query file has to be given (FASTA format)
or one query sequence directly.

The helix constraint format is "from,to", eg. -f 2,7 forces
structures to have a helix from position 2 to 7 with respect to the query.

<xi> and <theta> are the position and shape parameters, respectively,
of the extreme value distribution assumed for p-value calculation.
If omitted, they are estimated from the maximal duplex energy of the query.
In that case, a data set name has to be given with the -s flag.


PNG and JPG graphical output not supported.
```

