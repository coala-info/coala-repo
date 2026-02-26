# smetana CWL Generation Report

## smetana

### Tool Description
Calculate SMETANA scores for one or multiple microbial communities.

### Metadata
- **Docker Image**: quay.io/biocontainers/smetana:1.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/cdanielmachado/smetana
- **Package**: https://anaconda.org/channels/bioconda/packages/smetana/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/smetana/overview
- **Total Downloads**: 2.1K
- **Last updated**: 2025-05-07
- **GitHub**: https://github.com/cdanielmachado/smetana
- **Stars**: N/A
### Original Help Text
```text
usage: smetana [-h] [-c COMMUNITIES.TSV] [-o OUTPUT] [--flavor FLAVOR]
               [-m MEDIA] [--mediadb MEDIADB] [--aerobic | --anaerobic]
               [-g | -d | -a ABIOTIC | -ar ABIOTIC_RM | -b BIOTIC] [-p P]
               [-n N] [-v] [-z] [--solver SOLVER] [--molweight]
               [--exclude EXCLUDE] [--no-coupling]
               MODELS [MODELS ...]

Calculate SMETANA scores for one or multiple microbial communities.

positional arguments:
  MODELS                
                        Multiple single-species models (one or more files).
                        
                        You can use wild-cards, for example: models/*.xml, and optionally protect with quotes to avoid automatic bash
                        expansion (this will be faster for long lists): "models/*.xml". 

options:
  -h, --help            show this help message and exit
  -c COMMUNITIES.TSV, --communities COMMUNITIES.TSV
                        
                        Run SMETANA for multiple (sub)communities.
                        The communities must be specified in a two-column tab-separated file with community and organism identifiers.
                        The organism identifiers should match the file names in the SBML files (without extension).
                        
                        Example:
                            community1	organism1
                            community1	organism2
                            community2	organism1
                            community2	organism3
                        
  -o OUTPUT, --output OUTPUT
                        Prefix for output file(s).
  --flavor FLAVOR       Expected SBML flavor of the input files (cobra or fbc2).
  -m MEDIA, --media MEDIA
                        Run SMETANA for given media (comma-separated).
  --mediadb MEDIADB     Media database file
  --aerobic             Simulate an aerobic environment.
  --anaerobic           Simulate an anaerobic environment.
  -g, --global          Run global analysis with MIP/MRO (faster).
  -d, --detailed        Run detailed SMETANA analysis (slower).
  -a ABIOTIC, --abiotic ABIOTIC
                        Test abiotic perturbations with given list of compounds.
  -ar ABIOTIC_RM, --abiotic-rm ABIOTIC_RM
                        Test abiotic perturbations (removing compounds from media).
  -b BIOTIC, --biotic BIOTIC
                        Test biotic perturbations with given list of species.
  -p P                  Number of components to perturb simultaneously (default: 1).
  -n N                  
                        Number of random perturbation experiments per community (default: 1).
                        Selecting n = 0 will test all single species/compound perturbations exactly once.
  -v, --verbose         Switch to verbose mode
  -z, --zeros           Include entries with zero score.
  --solver SOLVER       Change default solver (current options: 'gurobi', 'cplex').
  --molweight           Use molecular weight minimization (recomended).
  --exclude EXCLUDE     List of compounds to exclude from calculations (e.g.: inorganic compounds).
  --no-coupling         Don't compute species coupling scores.
```

