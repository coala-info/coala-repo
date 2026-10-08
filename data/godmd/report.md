# godmd CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| godmd_discrete | PASS | Fixed the command to the real program 'discrete' and made the output files and alignment tables correct; on the GOdMD example the RMSD to the target fell from 4.70 to 0.45 A. |

## godmd_discrete

### Tool Description
Settings

### Metadata
- **Docker Image**: quay.io/biocontainers/godmd:1.8--hb569540_0
- **Homepage**: http://mmb.irbbarcelona.org/gitlab/adam/GOdMD
- **Package**: https://anaconda.org/channels/bioconda/packages/godmd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/godmd/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2026-02-12
- **GitHub**: https://github.com/mmb-irb/godmd
- **Stars**: N/A
### Original Help Text
```text
Usage:
  -i        param          Settings                                          
  -pdbin    raw PDB file   Initial PDB                                       
  -ener     energy         Energies                                          
  -trj      trajectory.pdb Trajectory (PDB)                                  
  -pdbtarg  target.pdb     Target PDB                                        
  -o        log            Calculation Log                                   
  -p1       same.dat       Table of same residues                            
  -p2       sametarget.dat Table of same residues target                     

STOP 1
```

