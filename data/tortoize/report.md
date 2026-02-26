# tortoize CWL Generation Report

## tortoize

### Tool Description
Tortoize validates protein structure models by checking the Ramachandran plot and side-chain rotamer distributions. Quality Z-scores are given at the residue level and at the model level (ramachandran-z and torsions-z).

### Metadata
- **Docker Image**: quay.io/biocontainers/tortoize:2.0.16--haf24da9_0
- **Homepage**: https://github.com/PDB-REDO/tortoize
- **Package**: https://anaconda.org/channels/bioconda/packages/tortoize/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tortoize/overview
- **Total Downloads**: 965
- **Last updated**: 2025-11-24
- **GitHub**: https://github.com/PDB-REDO/tortoize
- **Stars**: N/A
### Original Help Text
```text
LIBCIFPP_DATA_DIR has been set to: /usr/local/share/libcifpp
LIBCIFPP_DATA_DIR has been set to: `/usr/local/share/libcifpp`
tortoize [options] input [output]
  -h [ --help ]     Display help message
  --version         Print version
  -v [ --verbose ]  verbose output
  --log arg         Write log to this file
  --dict arg        Dictionary file containing restraints for residues in this 
                    specific target, can be specified multiple times.


Tortoize validates protein structure models by checking the 
Ramachandran plot and side-chain rotamer distributions. Quality
Z-scores are given at the residue level and at the model level 
(ramachandran-z and torsions-z). Higher scores are better. To compare 
models or to describe the reliability of the model Z-scores jackknife-
based standard deviations are also reported (ramachandran-jackknife-sd 
and torsion-jackknife-sd).

References: 
- Sobolev et al. A Global Ramachandran Score Identifies Protein 
  Structures with Unlikely Stereochemistry, Structure (2020),
  DOI: https://doi.org/10.1016/j.str.2020.08.005
- Van Beusekom et al. Homology-based loop modeling yields more complete
  crystallographic  protein structures, IUCrJ (2018),
  DOI: https://doi.org/10.1107/S2052252518010552
- Hooft et al. Objectively judging the quality of a protein structure
  from a Ramachandran plot, CABIOS (1993),
  DOI: https://doi.org/10.1093/bioinformatics/13.4.425
```


## Metadata
- **Skill**: not generated
