# enzymm CWL Generation Report

## enzymm

### Tool Description
The Enzyme Motif Miner - Geometric matching of catalytic motifs in protein structures

### Metadata
- **Docker Image**: quay.io/biocontainers/enzymm:0.3.1--pyhdfd78af_1
- **Homepage**: https://pypi.org/project/enzymm/
- **Package**: https://anaconda.org/channels/bioconda/packages/enzymm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/enzymm/overview
- **Total Downloads**: 70
- **Last updated**: 2026-01-23
- **GitHub**: https://github.com/RayHackett/enzymm
- **Stars**: N/A
### Original Help Text
```text
usage: 
            Minimal use: enzymm -i query.pdb -o result.tsv
            
            Recommended use: enzymm -l query_pdbs.list -o results.tsv -v --pdbs pdb_folder --include-query

            

EnzyMM - The Enzyme Motif Miner - version 0.3.1 Geometric matching of
catalytic motifs in protein structures MIT License Copyright (c) 2025 Raymund
Hackett <r.e.hackett@lumc.nl>

options:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit
  -j JOBS, --jobs JOBS  The number of threads to spawn for jobs in parallel.
                        Pass 0 to select all cores. Negative numbers: leave
                        this many cores free. (default: 20)

Mandatory Parameters:
  -o OUTPUT, --output OUTPUT
                        Output tsv file to which results should get written
                        (default: None)

Inputs - Use either or combine:
  -i FILES, --input FILES
                        File path to a PDB or mmCIF file to use as query
                        (default: [])
  -l FILES, --list FILES
                        File containing a list of PDB or mmCIF files to read
                        (default: None)

Optional Arguments:
  --pdbs PDBS           Output directory to which results should get written
                        (default: None)
  -p PARAMETERS PARAMETERS PARAMETERS, --parameters PARAMETERS PARAMETERS PARAMETERS
                        Fixed Jess parameters for all templates. Jess space
                        seperated parameters rmsd, distance,
                        max_dynamic_distance (default: None)
  -t TEMPLATE_DIR, --template-dir TEMPLATE_DIR
                        Path to directory containing jess templates. This
                        directory will be recursively searched. (default:
                        None)
  -c CONSERVATION_CUTOFF, --conservation-cutoff CONSERVATION_CUTOFF
                        Atoms with a value in the B-factor column below this
                        cutoff will be excluded form matching to the
                        templates. Useful for predicted structures. (default:
                        0)

Flags:
  -v, --verbose         If process information and time progress should be
                        printed to the command line (default: False)
  -w, --warn            If warings about bad template processing or suspicous
                        and missing annotations should be raised (default:
                        False)
  -q, --include-query   Include the query structure together with the hits in
                        the pdb output (default: False)
  --include-template    Include the template structure together with the hits
                        in the pdb output (default: False)
  -u, --unfiltered      If set, matches which logistic regression predicts as
                        false based on RMSD and resdiue orientation will be
                        retained. By default, matches predicted as false are
                        removed. (default: False)
  --transform           If set, one pdb file per matched template pdb with
                        will be written in the coordinate system of that
                        template (default: False)
  --skip-smaller-hits   If set, will not search with smaller templates if
                        larger templates have already found hits. (default:
                        False)
  --match-small-templates
                        If set, templates with less then 3 defined sidechain
                        residues will still be matched. (default: False)
  --skip-annotation     If set, M-CSA derived templates will NOT be annotated
                        with extra information. (default: False)
```


## Metadata
- **Skill**: generated
