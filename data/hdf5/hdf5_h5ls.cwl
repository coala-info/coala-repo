cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5ls
label: hdf5_h5ls
doc: "List the contents of an HDF5 file\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: files
    type:
      type: array
      items: string
    doc: HDF5 file name optionally followed by a slash and an object name within
      the file. The file name may include a printf(3C) integer format such as 
      "%05d" to open a file family.
    inputBinding:
      position: 1
  - id: address
    type:
      - 'null'
      - boolean
    doc: Print raw data address. If dataset is contiguous, address is offset in 
      file of beginning of raw data. If chunked, returned list of addresses 
      indicates offset of each chunk. Must be used with -v, --verbose option. 
      Provides no information for non-dataset objects.
    inputBinding:
      position: 102
      prefix: --address
  - id: data
    type:
      - 'null'
      - boolean
    doc: Print the values of datasets
    inputBinding:
      position: 102
      prefix: --data
  - id: enable_error_stack
    type:
      - 'null'
      - boolean
    doc: Prints messages from the HDF5 error stack as they occur.
    inputBinding:
      position: 102
      prefix: --enable-error-stack
  - id: errors
    type:
      - 'null'
      - boolean
    doc: Show all HDF5 error reporting. Replaced by --enable-error-stack.
    inputBinding:
      position: 102
      prefix: --errors
  - id: external
    type:
      - 'null'
      - boolean
    doc: Follow external links. Replaced by --follow-symlinks.
    inputBinding:
      position: 102
      prefix: --external
  - id: follow_symlinks
    type:
      - 'null'
      - boolean
    doc: Follow symbolic links (soft links and external links) to display target
      object information. Without this option, h5ls identifies a symbolic link 
      as a soft link or external link and prints the value assigned to the 
      symbolic link; it does not provide any information regarding the target 
      object or determine whether the link is a dangling link.
    inputBinding:
      position: 102
      prefix: --follow-symlinks
  - id: full
    type:
      - 'null'
      - boolean
    doc: Print full path names instead of base names
    inputBinding:
      position: 102
      prefix: --full
  - id: group
    type:
      - 'null'
      - boolean
    doc: Show information about a group, not its contents
    inputBinding:
      position: 102
      prefix: --group
  - id: hexdump
    type:
      - 'null'
      - boolean
    doc: Show raw data in hexadecimal format
    inputBinding:
      position: 102
      prefix: --hexdump
  - id: label
    type:
      - 'null'
      - boolean
    doc: Label members of compound datasets
    inputBinding:
      position: 102
      prefix: --label
  - id: no_dangling_links
    type:
      - 'null'
      - boolean
    doc: Must be used with --follow-symlinks option; otherwise, h5ls shows error
      message and returns an exit code of 1. Check for any symbolic links (soft 
      links or external links) that do not resolve to an existing object 
      (dataset, group, or named datatype). If any dangling link is found, this 
      situation is treated as an error and h5ls returns an exit code of 1.
    inputBinding:
      position: 102
      prefix: --no-dangling-links
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: List all groups recursively, avoiding cycles
    inputBinding:
      position: 102
      prefix: --recursive
  - id: simple
    type:
      - 'null'
      - boolean
    doc: Use a machine-readable output format
    inputBinding:
      position: 102
      prefix: --simple
  - id: string
    type:
      - 'null'
      - boolean
    doc: Print 1-byte integer datasets as ASCII
    inputBinding:
      position: 102
      prefix: --string
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Generate more verbose output
    inputBinding:
      position: 102
      prefix: --verbose
  - id: vfd
    type:
      - 'null'
      - string
    doc: Use the specified virtual file driver
    inputBinding:
      position: 102
      prefix: --vfd
  - id: width
    type:
      - 'null'
      - int
    doc: Set the number of columns of output
    inputBinding:
      position: 102
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
stdout: hdf5_h5ls.out
