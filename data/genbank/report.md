# genbank CWL Generation Report

## genbank_genbank.py

### Tool Description
Processes genbank files.

### Metadata
- **Docker Image**: quay.io/biocontainers/genbank:0.121--py312h247cb63_2
- **Homepage**: https://github.com/deprekate/genbank
- **Package**: https://anaconda.org/channels/bioconda/packages/genbank/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/genbank/overview
- **Total Downloads**: 15.4K
- **Last updated**: 2026-02-25
- **GitHub**: https://github.com/deprekate/genbank
- **Stars**: N/A
### Original Help Text
```text
usage: /usr/local/bin/genbank.py [-opt1, [-opt2, ...]] infile

positional arguments:
  infile                input file in genbank format

options:
  -h, --help            show this help message and exit
  -o OUTFILE, --outfile OUTFILE
                        where to write output [stdout]
  -f {genbank,gff,gff3,tabular,fasta,fna,faa,bases,coverage,rarity,gc,gcfp,taxonomy,testcode,check}, --format {genbank,gff,gff3,tabular,fasta,fna,faa,bases,coverage,rarity,gc,gcfp,taxonomy,testcode,check}
                        Output the features in the specified format
  -s SLICE, --slice SLICE
                        This slices the infile at the specified coordinates. 
                        The range can be in one of three different formats:
                            -s 0-99      (zero based string indexing)
                            -s 1..100    (one based GenBank indexing)
                            -s 50:+10    (an index and size of slice)
  -g, --get
  -d, --divvy           used to divvy a File with multiple loci into individual files
  -r, --revcomp
  -a ADD, --add ADD     This adds features the shell input via < features.txt
  -e EDIT, --edit EDIT  This edits the given feature key with the value from the shell input via < new_keys.txt
  -k KEY, --key KEY     Print the given keys [and qualifiers]
  -c COMPARE, --compare COMPARE
                        Compares the CDS of two genbank files
```

