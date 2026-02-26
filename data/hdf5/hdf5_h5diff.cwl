cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5diff
label: hdf5_h5diff
doc: "Compares HDF5 files and objects within them.\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: file1
    type: File
    doc: File name of the first HDF5 file
    inputBinding:
      position: 1
  - id: file2
    type: File
    doc: File name of the second HDF5 file
    inputBinding:
      position: 2
  - id: obj1
    type:
      - 'null'
      - string
    doc: Name of an HDF5 object, in absolute path
    inputBinding:
      position: 3
  - id: obj2
    type:
      - 'null'
      - string
    doc: Name of an HDF5 object, in absolute path
    inputBinding:
      position: 4
  - id: avoid_nan
    type:
      - 'null'
      - boolean
    doc: Avoid NaNs detection
    inputBinding:
      position: 105
      prefix: --nan
  - id: compare_incomparable
    type:
      - 'null'
      - boolean
    doc: List objects that are not comparable
    inputBinding:
      position: 105
      prefix: --compare
  - id: count_limit
    type:
      - 'null'
      - int
    doc: Print differences up to C. C must be a positive integer.
    inputBinding:
      position: 105
      prefix: --count
  - id: delta
    type:
      - 'null'
      - float
    doc: Print difference if (|a-b| > D). D must be a positive number. Where a 
      is the data point value in file1 and b is the data point value in file2. 
      Can not use with '-p' or '--use-system-epsilon'.
    inputBinding:
      position: 105
      prefix: --delta
  - id: enable_error_stack
    type:
      - 'null'
      - boolean
    doc: Prints messages from the HDF5 error stack as they occur.
    inputBinding:
      position: 105
      prefix: --enable-error-stack
  - id: exclude_path
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude the specified path to an object when comparing files or groups.
      If a group is excluded, all member objects will also be excluded. The 
      specified path is excluded wherever it occurs.
    inputBinding:
      position: 105
      prefix: --exclude-path
  - id: follow_symlinks
    type:
      - 'null'
      - boolean
    doc: Follow symbolic links (soft links and external links and compare the 
      links' target objects.
    inputBinding:
      position: 105
      prefix: --follow-symlinks
  - id: no_dangling_links
    type:
      - 'null'
      - boolean
    doc: Must be used with --follow-symlinks option; otherwise, h5diff shows 
      error message and returns an exit code of 2. Check for any symbolic links 
      (soft links or external links) that do not resolve to an existing object 
      (dataset, group, or named datatype). If any dangling link is found, this 
      situation is treated as an error and h5diff returns an exit code of 2.
    inputBinding:
      position: 105
      prefix: --no-dangling-links
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: Quiet mode. Do not produce output.
    inputBinding:
      position: 105
      prefix: --quiet
  - id: relative_delta
    type:
      - 'null'
      - float
    doc: Print difference if (|(a-b)/b| > R). R must be a positive number. Where
      a is the data point value in file1 and b is the data point value in file2.
      Can not use with '-d' or '--use-system-epsilon'.
    inputBinding:
      position: 105
      prefix: --relative
  - id: report_mode
    type:
      - 'null'
      - boolean
    doc: Report mode. Print differences.
    inputBinding:
      position: 105
      prefix: --report
  - id: use_system_epsilon
    type:
      - 'null'
      - boolean
    doc: "Print difference if (|a-b| > EPSILON), EPSILON is system defined value.
      Where a is the data point value in file1 and b is the data point value in file2.
      If the system epsilon is not defined,one of the following predefined values
      will be used: FLT_EPSILON = 1.19209E-07 for floating-point type DBL_EPSILON
      = 2.22045E-16 for double precision type Can not use with '-p' or '-d'."
    inputBinding:
      position: 105
      prefix: --use-system-epsilon
  - id: verbose
    type:
      - 'null'
      - string
    doc: Verbose mode. Print differences information and list of objects.
    inputBinding:
      position: 105
      prefix: --verbose
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: Verbose mode with level. Print differences and list of objects.
    inputBinding:
      position: 105
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5diff.out
