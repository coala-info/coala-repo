cwlVersion: v1.2
class: CommandLineTool
baseCommand: mdconvert
label: mdtraj_mdconvert
doc: Convert molecular dynamics trajectories between formats. The DCD, XTC, TRR,
  PDB, binpos, NetCDF, binpos, LH5, and HDF5 formats are supported (.dcd, .xtc, 
  .trr, .binpos, .nc, .netcdf, .h5, .lh5, .pdb)
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: path to one or more trajectory files. Multiple trajectories, if 
      supplied, will be concatenated together in the output file in the order 
      supplied. all of the trajectories should be in the same format. the format
      will be detected based on the file extension
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: path to the save the output. the output format will chosen based on the
      file extension (.dcd, .xtc, .trr, .binpos, .nc, .netcdf, .h5, .lh5, .pdb)
    inputBinding:
      position: 102
      prefix: --output
  - id: chunk
    type:
      - 'null'
      - int
    doc: number of frames to read in at once. this determines the memory 
      requirements of this code.
    inputBinding:
      position: 102
      prefix: --chunk
  - id: force
    type:
      - 'null'
      - boolean
    doc: force overwrite if output already exsits
    inputBinding:
      position: 102
      prefix: --force
  - id: stride
    type:
      - 'null'
      - int
    doc: load only every stride-th frame from the input file(s), to subsample.
    inputBinding:
      position: 102
      prefix: --stride
  - id: index
    type:
      - 'null'
      - string
    doc: load a *specific* set of frames. flexible, but inefficient for a large 
      trajectory. specify your selection using (pythonic) "slice notation" e.g. 
      '-i N' to load the the Nth frame, '-i -1' will load the last frame, '-i 
      N:M to load frames N to M, etc.
    inputBinding:
      position: 102
      prefix: --index
  - id: atom_indices
    type:
      - 'null'
      - File
    doc: load only specific atoms from the input file(s). provide a path to file
      containing a space, tab or newline separated list of the (zero-based) 
      integer indices corresponding to the atoms you wish to keep.
    inputBinding:
      position: 102
      prefix: --atom_indices
  - id: topology
    type:
      - 'null'
      - File
    doc: path to a PDB/prmtop file. this will be used to parse the topology of 
      the system. it's optional, but useful. if specified, it enables you to 
      output the coordinates of your dcd/xtc/trr/netcdf/binpos as a PDB file.
    inputBinding:
      position: 102
      prefix: --topology
outputs:
  - id: output_output
    type: File
    doc: path to the save the output. the output format will chosen based on the
      file extension (.dcd, .xtc, .trr, .binpos, .nc, .netcdf, .h5, .lh5, .pdb)
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mdtraj:1.9.9
s:url: https://github.com/mdtraj/mdtraj
$namespaces:
  s: https://schema.org/
