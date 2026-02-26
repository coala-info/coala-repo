# mdtraj CWL Generation Report

## mdtraj_mdconvert

### Tool Description
Convert molecular dynamics trajectories between formats. The DCD, XTC, TRR, PDB, binpos, NetCDF, binpos, LH5, and HDF5 formats are supported (.dcd, .xtc, .trr, .binpos, .nc, .netcdf, .h5, .lh5, .pdb)

### Metadata
- **Docker Image**: quay.io/biocontainers/mdtraj:1.9.9
- **Homepage**: https://github.com/mdtraj/mdtraj
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/conda-forge/packages/mdtraj/overview
- **Total Downloads**: 2.7M
- **Last updated**: 2026-01-22
- **GitHub**: https://github.com/mdtraj/mdtraj
- **Stars**: N/A
### Original Help Text
```text
usage: mdconvert [-h] -o OUTPUT [-c CHUNK] [-f] [-s STRIDE] [-i INDEX]
                 [-a ATOM_INDICES] [-t TOPOLOGY]
                 input [input ...]

Convert molecular dynamics trajectories between formats. The DCD, XTC, TRR,
PDB, binpos, NetCDF, binpos, LH5, and HDF5 formats are supported (.dcd, .xtc,
.trr, .binpos, .nc, .netcdf, .h5, .lh5, .pdb)

positional arguments:
  input                 path to one or more trajectory files. Multiple
                        trajectories, if supplied, will be concatenated
                        together in the output file in the order supplied. all
                        of the trajectories should be in the same format. the
                        format will be detected based on the file extension

required arguments:
  -o OUTPUT, --output OUTPUT
                        path to the save the output. the output format will
                        chosen based on the file extension (.dcd, .xtc, .trr,
                        .binpos, .nc, .netcdf, .h5, .lh5, .pdb)

options:
  -h, --help            show this help message and exit
  -c CHUNK, --chunk CHUNK
                        number of frames to read in at once. this determines
                        the memory requirements of this code. default=1000
  -f, --force           force overwrite if output already exsits
  -s STRIDE, --stride STRIDE
                        load only every stride-th frame from the input
                        file(s), to subsample.
  -i INDEX, --index INDEX
                        load a *specific* set of frames. flexible, but
                        inefficient for a large trajectory. specify your
                        selection using (pythonic) "slice notation" e.g. '-i
                        N' to load the the Nth frame, '-i -1' will load the
                        last frame, '-i N:M to load frames N to M, etc. see
                        http://bit.ly/143kloq for details on the notation
  -a ATOM_INDICES, --atom_indices ATOM_INDICES
                        load only specific atoms from the input file(s).
                        provide a path to file containing a space, tab or
                        newline separated list of the (zero-based) integer
                        indices corresponding to the atoms you wish to keep.
  -t TOPOLOGY, --topology TOPOLOGY
                        path to a PDB/prmtop file. this will be used to parse
                        the topology of the system. it's optional, but useful.
                        if specified, it enables you to output the coordinates
                        of your dcd/xtc/trr/netcdf/binpos as a PDB file. If
                        you're converting *to* .h5, the topology will be
                        stored inside the h5 file.
```

