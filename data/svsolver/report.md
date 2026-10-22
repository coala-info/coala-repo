# svsolver CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| svsolver | Not completed | needs a SimVascular mesh and svpre output (geombc, restart files); no small real case is available |
| svsolver_svpost | Not completed | needs restart files from a real svsolver run; no small real case is available |
| svsolver_svpre | Not completed | needs a real SimVascular mesh-complete model and .svpre file; no small real case is available |

## svsolver

### Tool Description
Solver Input Files listed as below:

### Metadata
- **Docker Image**: quay.io/biocontainers/svsolver:2022.07.20--mpich_h7252990_0
- **Homepage**: https://simtk.org/projects/simvascular/
- **Package**: https://anaconda.org/channels/bioconda/packages/svsolver/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svsolver/overview
- **Total Downloads**: 2.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SimVascular/svSolver
- **Stars**: N/A
### Original Help Text
```text
The process ID for myrank (0) is (10).


The number of processes is 1.

Solver Input Files listed as below:
------------------------------------
 Local Config: solver.inp
```

## svsolver_svpre

### Tool Description
SimVascular svpre of the svSolver package

### Metadata
- **Docker Image**: quay.io/biocontainers/svsolver:2022.07.20--mpich_h7252990_0
- **Homepage**: https://simtk.org/projects/simvascular/
- **Package**: https://anaconda.org/channels/bioconda/packages/svsolver/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svpre <params_file>
```

## svsolver_svpost

### Tool Description
SimVascular svpost of the svSolver package

### Metadata
- **Docker Image**: quay.io/biocontainers/svsolver:2022.07.20--mpich_h7252990_0
- **Homepage**: https://simtk.org/projects/simvascular/
- **Package**: https://anaconda.org/channels/bioconda/packages/svsolver/overview
- **Validation**: PASS

### Original Help Text
```text

usage:
  postsolver -sn stepnumber ...

COMMAND-LINE ARGUMENT SUMMARY
  -h                  : Display usage and command-line argument summary
  -sn stepnumber      : Specify single step number to reduce
  -start stepnumber   : Specify starting step number
  -stop stepnumber    : Specify stopping step number
  -newsn stepnumber   : override step number in file
  -incr increment     : Specify increment between steps
  -ph                 : Write flowsolver-format file restart.<stepnumber>.0
  -laststep           : Only write last step to file restart.<stepnumber>.0
  -vis file_prefix    : Write Vis-format results file
  -vismesh filename   : Write Vis-format mesh file
  -vtu prefix or file : Write VTK XML UnstructuredGrid
  -vtp prefix or file : Write Surface Only VTK XML PolyData
  -vtkcombo           : Combine all VTK in single file
  -sol                : Reduce solution(pressure and velocity)
  -traction           : Reduce in-plane traction
  -disp               : Reduce displacements
  -wallprop           : Reduce wall properties
  -rho                : Fluid density
  -mu                 : Fluid viscosity
  -td                 : Reduce time-derivative field
  -wss                : Reduce Wall Shear Stress
  -wfilter filename   : output wall data only on specified wall
  -calcws             : Recalculate wall stress on specified wall
  -applywd            : Apply wall deformation during wall stress calculation
  -ybar               : Reduce average speed and pressure
  -yerror             : Reduce speed and pressure errors
  -nonbinary          : Read/Write files in ASCII format
  -all                : Reduce all available data
  -sim_units_mm       : set sim  units to mm
  -sim_units_cm       : set sim  units to cm (default)
  -indir              : directory containing restart files (default .)
  -outdir             : directory containing output files (default .)
  -res                : Compares residual profiles on histor.dat files
                        and writes a report to residualDiff.out
  -compare            : Compare pressures and velocities in result VTU files
                        and writes a report to vtuDiff.out
END COMMAND-LINE ARGUMENT SUMMARY

Will reduce all available data

Exiting before performing any of the above operations due to -h flag
```

