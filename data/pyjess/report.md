# pyjess CWL Generation Report

## pyjess

### Tool Description
PyJess - Optimized Python bindings to Jess, a 3D template matching software.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyjess:0.9.1--py310h1fe012e_0
- **Homepage**: https://github.com/althonos/pyjess
- **Package**: https://anaconda.org/channels/bioconda/packages/pyjess/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyjess/overview
- **Total Downloads**: 22.0K
- **Last updated**: 2025-12-25
- **GitHub**: https://github.com/althonos/pyjess
- **Stars**: N/A
### Original Help Text
```text
usage: pyjess [-h] [-V] [-j JOBS] -T TEMPLATES -Q QUERIES -R RMSD -D
              DISTANCE_CUTOFF -M MAXIMUM_DISTANCE [-n] [-f] [-i]
              [--ignore-res-chain] [-q] [-e] [-c MAX_CANDIDATES]
              [--no-reorder] [-b]

PyJess - Optimized Python bindings to Jess, a 3D template matching software.

MIT License

Copyright (c) 2025 Martin Larralde <martin.larralde@embl.de>
Copyright (c) 2002 Jonathan Barker <jbarker@ebi.ac.uk>

options:
  -h, --help            Show this help message and exit.
  -V, --version         Show the version number and exit.
  -j JOBS, --jobs JOBS  The number of jobs to use for multithreading.
                        (default: 20)

Mandatory Parameters:
  -T TEMPLATES, --templates TEMPLATES
                        The path to the template list file. (default: None)
  -Q QUERIES, --queries QUERIES
                        The path to the query list file. (default: None)
  -R RMSD, --rmsd RMSD  The RMSD threshold. (default: None)
  -D DISTANCE_CUTOFF, --distance-cutoff DISTANCE_CUTOFF
                        The distance-cutoff. (default: None)
  -M MAXIMUM_DISTANCE, --maximum-distance MAXIMUM_DISTANCE
                        The maximum allowed template/query atom distance after
                        adding the global distance cutoff and the individual
                        atom distance cutoff defined in the temperature field
                        of the ATOM record in the template file. (default:
                        None)

Flags:
  -n, --no-transform    Do not transform coordinates of hit into the template
                        coordinate frame (default: True)
  -f, --filenames       Show PDB filenames in progress on stderr (default:
                        False)
  -i, --ignore-chain    Include matches composed of residues belonging to
                        multiple chains (if template is single-chain) or
                        matches with residues from a single chain (if template
                        has residues from multiple chains). (default: False)
  --ignore-res-chain    Include matches composed of residues belonging to
                        multiple chains but still enforce all atoms of a
                        residue to be part of the same chain. (default: False)
  -q, --query-filename  Write filename of query instead of PDB ID from HEADER
                        (default: False)
  -e, --ignore-endmdl   Parse atoms from all models separated by ENDMDL (use
                        with care). (default: False)
  -c MAX_CANDIDATES, --max-candidates MAX_CANDIDATES
                        Set a maximum number of candidates to return by
                        template. (default: None)
  --no-reorder          Disable template atom reordering in the matching
                        process, useful to enforce results to be returned
                        exactly in the same order as the original Jess, at the
                        cost of longer runtimes. (default: True)
  -b, --best-match      Return only the best match for each template/query
                        pair. (default: False)
```

