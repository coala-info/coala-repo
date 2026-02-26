# beem-bio CWL Generation Report

## beem-bio_BeEM

### Tool Description
convert PDBx/mmCIF format input file 'input.cif' to Best Effort/Minimal PDB files. Output results to *-pdb-bundle*

### Metadata
- **Docker Image**: quay.io/biocontainers/beem-bio:1.0.1--h9948957_0
- **Homepage**: https://github.com/kad-ecoli/BeEM
- **Package**: https://anaconda.org/channels/bioconda/packages/beem-bio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/beem-bio/overview
- **Total Downloads**: 257
- **Last updated**: 2025-06-09
- **GitHub**: https://github.com/kad-ecoli/BeEM
- **Stars**: N/A
### Original Help Text
```text
BeEM input.cif
    convert PDBx/mmCIF format input file 'input.cif' to Best Effort/Minimal
    PDB files. Output results to *-pdb-bundle*

option:
    -p=xxxx          prefix of output file.
                     default is the PDB ID read from the input
    -seqres={0,1}    whether to convert SEQRES record
                     0 - (default) do not convert SEQRES
                     1 - convert SEQRES
    -dbref={0,1}     whether to convert dbref record
                     0 - (default) do not convert DBREF
                     1 - convert DBREF
    -gzip={0,1}      whether to perform gzip compression
                     0 - (default) do not perform compression
                     1 - perform compression if tar and gzip are available
    -upper={0,1,2}   whether to convert PDB header text to upper case
                     0 - do not convert to upper case
                     1 - (default) only convert header text of single PDB
                         file to upper case; allow lower case header for
                         Best Effort/Minimal PDB bundle
                     2 - convert all PDB text to upper case
    -maxatom=99999   maximum number of atoms in a file. default is 99999.
                     no limit on number of atoms if maxatom<=0
 -outfmt={0,1,2,3,4} output format
                     0 - (default) output a single PDB file if possible;
                         otherwise, output Best Effort/Minimal PDB bundle
                     1 - always output Best Effort/Minimal PDB bundle
                     2 - output one chain per PDB file
                     3 - always output a single PDB file
                     4 - output FASTA sequence converted from coordinate
   -chain=A,B        comma seperated list of chains to output
                     default is to output all chains
   -idmap={txt,tsv}  format of chain ID mapping file
                     txt - (default) space-justified text
                     tsv - tab-delimited tabular text
   -ccd5={map,trim}  how to handle expanded chemical component ID >3 characters
                     map  - (default) map the residue name to reserved set of 
                            chemical component IDs: 01 - 99, DRG, INH, LIG
                     trim - trim the residue name to keep only the first three
                            characters
```

