# buildh CWL Generation Report

## buildh_buildH

### Tool Description
This program builds hydrogens and calculates the order parameters (OP) from a united-atom trajectory of lipids. If -opx is requested, pdb and xtc output files with hydrogens are created but OP calculation will be slow. If no trajectory output is requested (no use of flag -opx), it uses a fast procedure to build hydrogens and calculate the OP.

### Metadata
- **Docker Image**: quay.io/biocontainers/buildh:1.6.1--pyhdfd78af_0
- **Homepage**: https://github.com/patrickfuchs/buildH
- **Package**: https://anaconda.org/channels/bioconda/packages/buildh/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/buildh/overview
- **Total Downloads**: 10.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/patrickfuchs/buildH
- **Stars**: N/A
### Original Help Text
```text
usage: buildH [-h] [-v] -c COORD [-t TRAJ] -l LIPID
              [-lt LIPID_TOPOLOGY [LIPID_TOPOLOGY ...]] -d DEFOP
              [-opx OPDBXTC] [-o OUT] [-b BEGIN] [-e END] [-igch3]

This program builds hydrogens and calculates the order parameters (OP) from a
united-atom trajectory of lipids. If -opx is requested, pdb and xtc output
files with hydrogens are created but OP calculation will be slow. If no
trajectory output is requested (no use of flag -opx), it uses a fast procedure
to build hydrogens and calculate the OP.

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -c COORD, --coord COORD
                        Coordinate file (pdb or gro format).
  -t TRAJ, --traj TRAJ  Input trajectory file. Could be in XTC, TRR or DCD
                        format.
  -l LIPID, --lipid LIPID
                        Combinaison of ForceField name and residue name for
                        the lipid to calculate the OP on (e.g. Berger_POPC).It
                        must match with the internal topology files or the
                        one(s) supplied.A list of supported terms is printed
                        when calling the help.
  -lt LIPID_TOPOLOGY [LIPID_TOPOLOGY ...], --lipid_topology LIPID_TOPOLOGY [LIPID_TOPOLOGY ...]
                        User topology lipid json file(s).
  -d DEFOP, --defop DEFOP
                        Order parameter definition file. Can be found on https
                        ://github.com/patrickfuchs/buildH/tree/master/def_file
                        s.
  -opx OPDBXTC, --opdbxtc OPDBXTC
                        Base name for trajectory output with hydrogens. File
                        extension will be automatically added. For example
                        -opx trajH will generate trajH.pdb and trajH.xtc. So
                        far only xtc is supported.
  -o OUT, --out OUT     Output file name for storing order parameters. Default
                        name is OP_buildH.out.
  -b BEGIN, --begin BEGIN
                        The first frame (ps) to read from the trajectory.
  -e END, --end END     The last frame (ps) to read from the trajectory.
  -igch3, --ignore-CH3s
                        Ignore CH3s groups for the construction of hydrogens
                        and the calculation of the OP.

The list of supported lipids (-l option) are: GROMOSCKP_POPC, GROMOSCKP_POPS,
GROMOS53A6L_DPPC, CHARMM36UA_DPPC, CHARMM36UA_DPUC, Berger_POPE, Berger_DPPC,
Berger_CHOL, CHARMM36_POPC, Berger_DOPC, Berger_POPS, Berger_POP, Berger_PLA,
Berger_POPC. More documentation can be found at https://buildh.readthedocs.io.
```

