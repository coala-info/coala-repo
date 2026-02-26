# protmapper CWL Generation Report

## protmapper

### Tool Description
Run Protmapper on a list of proteins with residues and sites provided in a text file.

### Metadata
- **Docker Image**: quay.io/biocontainers/protmapper:0.0.29--pyhdfd78af_0
- **Homepage**: https://github.com/indralab/protmapper
- **Package**: https://anaconda.org/channels/bioconda/packages/protmapper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/protmapper/overview
- **Total Downloads**: 22.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/indralab/protmapper
- **Stars**: N/A
### Original Help Text
```text
usage: protmapper [-h] [--peptide] [--no_methionine_offset]
                  [--no_orthology_mapping] [--no_isoform_mapping]
                  input output

Run Protmapper on a list of proteins with residues and sites provided in a
text file.

positional arguments:
  input                 Path to an input file. The input file is a text file
                        in which each row consists of four comma separated
                        values, with the first element being a protein ID, the
                        second, the namespace in which that ID is valid
                        (uniprot or hgnc),third, an amino acid represented as
                        a single capital letter, and fourth, a site position
                        on the protein.
  output                Path to the output file to be generated. Each line of
                        the output file corresponds to a line in the input
                        file. Each linerepresents a mapped site produced by
                        Protmapper.

options:
  -h, --help            show this help message and exit
  --peptide             If given, the third element of each row of the input
                        file is a peptide (amino acid sequence) rather than a
                        single amino acid residue. In this case, peptide-
                        oriented mappings are applied. In this mode the
                        following boolean arguments are ignored.
  --no_methionine_offset
                        If given, will not check for off-by-one errors in site
                        position (possibly) attributable to site numbering
                        from mature proteins after cleavage of the initial
                        methionine.
  --no_orthology_mapping
                        If given, will not check sequence positions for known
                        modification sites in mouse or rat sequences (based on
                        PhosphoSitePlus data).
  --no_isoform_mapping  If given, will not check sequence positions for known
                        modifications in other human isoforms of the protein
                        (based on PhosphoSitePlus data).
```

