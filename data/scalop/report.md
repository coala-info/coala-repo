# scalop CWL Generation Report

## scalop_SCALOP

### Tool Description
Sequence-based antibody Canonical LOoP structure annotation

### Metadata
- **Docker Image**: quay.io/biocontainers/scalop:2021.01.27--py_0
- **Homepage**: https://github.com/oxpig/SCALOP
- **Package**: https://anaconda.org/channels/bioconda/packages/scalop/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scalop/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/oxpig/SCALOP
- **Stars**: N/A
### Original Help Text
```text
usage: SCALOP [-h] [--numbering_scheme {imgt,chothia}]
              [--cdr_definition {north,imgt,chothia}] [-i SEQ] [-o OUTPUTDIR]
              [-of OUTPUTFORMAT] [-dbv DBV] [-s STRUCTUREF] [--loopdb LOOPDB]
              [--hc HC] [--lc LC] [--update] [--dbdir DBDIR]
              [--struc_cutoff STRUC_CUTOFF] [--bfactor_cutoff BFACTOR]
              [--arma_inc ARMA_INC] [--sabdabscript SABDABDIR]
              [--pylib SABDABPYDIR] [--sabdabu SABDABU]

DESCRIPTION
 
    SCALOP
    Sequence-based antibody Canonical LOoP structure annotation
 
    o To setup paths etc on your machine run:
        python setup.py install

    o Python API
        o The SCALOP python package can be imported using:
        >>> from scalop.predict import assign
        
    o Command line 
        o To run SCALOP on a command line:
        $ SCALOP -i <input_sequence> --scheme <numbering_scheme> --definition <cdr_definition>
        
    o Pre-requisites:
        o SAbDab (for update)
        o HMMER 3.1b2 (February 2015); http://hmmer.org/
        o numpy v. 1.10+
        o pandas

optional arguments:
  -h, --help            show this help message and exit
  --numbering_scheme {imgt,chothia}, --scheme {imgt,chothia}
                        Antibody chain numbering scheme
  --cdr_definition {north,imgt,chothia}, --definition {north,imgt,chothia}
                        CDR region definition
  -i SEQ, --assign SEQ  Input sequence(s)
  -o OUTPUTDIR, --output OUTPUTDIR
                        Output directory (default = console output)
  -of OUTPUTFORMAT, --output_ext OUTPUTFORMAT
                        Output format
  -dbv DBV, --db_version DBV
                        Database version in YYYY-MM (e.g. '2017-07') or YYYY
                        for data included by the end of the year
  -s STRUCTUREF, --structure STRUCTUREF
                        Input framework structure
  --loopdb LOOPDB       Loop structures directory
  --hc HC               Heavy Chain ID
  --lc LC               Light Chain ID
  --update, -u          Perform an update to a copy of the database that you
                        have write permissions for
  --dbdir DBDIR         [for updater] Loop database directory
  --struc_cutoff STRUC_CUTOFF, --cutoff STRUC_CUTOFF
                        [for updater] Resolution of structures to be clustered
  --bfactor_cutoff BFACTOR, --bfactor BFACTOR
                        [for updater] Maximum B factor of backbone atoms in
                        the loop
  --arma_inc ARMA_INC, --armadillo_include ARMA_INC
                        [for updater] Resolution of structures to be clustered
  --sabdabscript SABDABDIR, --script SABDABDIR, --bin SABDABDIR, --sabdabdir SABDABDIR
                        [for updater] Location of SAbDab bin script (e.g.
                        ~/bin/)
  --pylib SABDABPYDIR, --sabdabpydir SABDABPYDIR
                        [for updater] Location of ABDB python module (e.g.
                        ~/bin/Python/ABDB)
  --sabdabu SABDABU     [for updater] Whether or not to update SAbDab
                        ([yes]/no)

AUTHORS
 
    2026
    Wing Ki Wong
    Dr. Jinwoo Leem
    Prof Charlotte M. Deane - Oxford Protein Informatics group.

    Contact: opig@stats.ox.ac.uk

Copyright (C) 2026 Oxford Protein Informatics Group (OPIG)
Freely distributed under the GNU General Public License (GPLv3).
```

