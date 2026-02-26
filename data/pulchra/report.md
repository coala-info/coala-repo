# pulchra CWL Generation Report

## pulchra

### Tool Description
PULCHRA Protein Chain Restoration Algorithm. The program default input is a PDB file. Output file <pdb_file.rebuild.pdb> will be created as a result.

### Metadata
- **Docker Image**: quay.io/biocontainers/pulchra:3.06--h031d066_4
- **Homepage**: https://www.pirx.com/pulchra/
- **Package**: https://anaconda.org/channels/bioconda/packages/pulchra/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pulchra/overview
- **Total Downloads**: 5.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
PULCHRA Protein Chain Restoration Algorithm version 3.06
Usage: pulchra [options] <pdb_file>
The program default input is a PDB file.
Output file <pdb_file.rebuild.pdb> will be created as a result.
Valid options are:

  -v : verbose output (default: off)
  -n : center chain (default: off)
  -x : time-seed random number generator (default: off)
  -g : use PDBSG as an input format (CA=C-alpha, SC or CM=side chain c.m.)

  -c : skip C-alpha positions optimization (default: on)
  -p : detect cis-prolins (default: off)
  -r : start from a random chain (default: off)
  -i pdbfile : read the initial C-alpha coordinates from a PDB file
  -t : save chain optimization trajectory to file <pdb_file.pdb.trajectory>
  -u value : maximum shift from the restraint coordinates (default: 0.5A)

  -e : rearrange backbone atoms (C, O are output after side chain) (default: off)
  -f : preserve initial coordinates (default: off, implies '-c' on and '-n' off)
  -b : skip backbone reconstruction (default: on)
  -q : optimize backbone hydrogen bonds pattern (default: off)
  -h : outputs hydrogen atoms (default: off)
  -s : skip side chains reconstruction (default: on)
  -o : don't attempt to fix excluded volume conflicts (default: on)
  -z : don't check amino acid chirality (default: on)
```


## Metadata
- **Skill**: not generated
