cwlVersion: v1.2
class: CommandLineTool
baseCommand: h5dump
label: hdf5_h5dump
doc: "Print a usage message and exit\n\nTool homepage: https://github.com/HDFGroup/hdf5"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input HDF5 files
    inputBinding:
      position: 1
  - id: any_path
    type:
      - 'null'
      - string
    doc: Print any attribute, dataset, group, datatype, or link that matches P. 
      P can be the absolute path or just a relative path.
    inputBinding:
      position: 102
      prefix: --any_path
  - id: attribute
    type:
      - 'null'
      - string
    doc: Print the specified attribute. If an attribute name contains a slash 
      (/), escape the slash with a preceding backslash (\).
    inputBinding:
      position: 102
      prefix: --attribute
  - id: binary
    type:
      - 'null'
      - string
    doc: Binary file output, of form B
    inputBinding:
      position: 102
      prefix: --binary
  - id: block
    type:
      - 'null'
      - string
    doc: Size of block in hyperslab. Is a list of integers the number of which 
      are equal to the number of dimensions in the dataspace being queried.
    inputBinding:
      position: 102
      prefix: --block
  - id: contents
    type:
      - 'null'
      - boolean
    doc: Print a list of the file contents and exit. Optional value 1 also 
      prints attributes.
    inputBinding:
      position: 102
      prefix: --contents
  - id: count
    type:
      - 'null'
      - string
    doc: Number of blocks to include in selection. Is a list of integers the 
      number of which are equal to the number of dimensions in the dataspace 
      being queried.
    inputBinding:
      position: 102
      prefix: --count
  - id: dataset
    type:
      - 'null'
      - string
    doc: Print the specified dataset
    inputBinding:
      position: 102
      prefix: --dataset
  - id: datatype
    type:
      - 'null'
      - string
    doc: Print the specified named datatype
    inputBinding:
      position: 102
      prefix: --datatype
  - id: enable_error_stack
    type:
      - 'null'
      - boolean
    doc: Prints messages from the HDF5 error stack as they occur. Optional value
      2 also prints file open errors.
    inputBinding:
      position: 102
      prefix: --enable-error-stack
  - id: escape
    type:
      - 'null'
      - boolean
    doc: Escape non printing characters
    inputBinding:
      position: 102
      prefix: --escape
  - id: filedriver
    type:
      - 'null'
      - string
    doc: Specify which driver to open the file with
    inputBinding:
      position: 102
      prefix: --filedriver
  - id: format
    type:
      - 'null'
      - string
    doc: Set the floating point output format
    inputBinding:
      position: 102
      prefix: --format
  - id: group
    type:
      - 'null'
      - string
    doc: Print the specified group and all members
    inputBinding:
      position: 102
      prefix: --group
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print the header only; no data is displayed
    inputBinding:
      position: 102
      prefix: --header
  - id: no_compact_subset
    type:
      - 'null'
      - boolean
    doc: Disable compact form of subsetting and allow the use of "[" in dataset 
      names.
    inputBinding:
      position: 102
      prefix: --no-compact-subset
  - id: noindex
    type:
      - 'null'
      - boolean
    doc: Do not print array indices with the data
    inputBinding:
      position: 102
      prefix: --noindex
  - id: object_ids
    type:
      - 'null'
      - boolean
    doc: Print the object ids
    inputBinding:
      position: 102
      prefix: --object-ids
  - id: onlyattr
    type:
      - 'null'
      - boolean
    doc: Print the header and value of attributes. Optional value 0 suppresses 
      printing attributes.
    inputBinding:
      position: 102
      prefix: --onlyattr
  - id: packedbits
    type:
      - 'null'
      - string
    doc: Print packed bits as unsigned integers, using mask format L for an 
      integer dataset specified with option -d. L is a list of offset,length 
      values, separated by commas. Offset is the beginning bit in the data value
      and length is the number of bits of the mask.
    inputBinding:
      position: 102
      prefix: --packedbits
  - id: properties
    type:
      - 'null'
      - boolean
    doc: Print dataset filters, storage layout and fill value
    inputBinding:
      position: 102
      prefix: --properties
  - id: region
    type:
      - 'null'
      - boolean
    doc: Print dataset pointed by region references
    inputBinding:
      position: 102
      prefix: --region
  - id: soft_link
    type:
      - 'null'
      - string
    doc: Print the value(s) of the specified soft link
    inputBinding:
      position: 102
      prefix: --soft-link
  - id: sort_by
    type:
      - 'null'
      - string
    doc: Sort groups and attributes by index Q
    inputBinding:
      position: 102
      prefix: --sort_by
  - id: sort_order
    type:
      - 'null'
      - string
    doc: Sort groups and attributes by order Z
    inputBinding:
      position: 102
      prefix: --sort_order
  - id: start
    type:
      - 'null'
      - string
    doc: Offset of start of subsetting selection. Is a list of integers the 
      number of which are equal to the number of dimensions in the dataspace 
      being queried.
    inputBinding:
      position: 102
      prefix: --start
  - id: stride
    type:
      - 'null'
      - string
    doc: Hyperslab stride. Is a list of integers the number of which are equal 
      to the number of dimensions in the dataspace being queried.
    inputBinding:
      position: 102
      prefix: --stride
  - id: string
    type:
      - 'null'
      - boolean
    doc: Print 1-byte integer datasets as ASCII
    inputBinding:
      position: 102
      prefix: --string
  - id: superblock
    type:
      - 'null'
      - boolean
    doc: Print the content of the super block
    inputBinding:
      position: 102
      prefix: --superblock
  - id: use_dtd
    type:
      - 'null'
      - boolean
    doc: Output in XML using DTD
    inputBinding:
      position: 102
      prefix: --use-dtd
  - id: vds_gap_size
    type:
      - 'null'
      - int
    doc: Set the missing file gap size, N=non-negative integers
    inputBinding:
      position: 102
      prefix: --vds-gap-size
  - id: vds_view_first_missing
    type:
      - 'null'
      - boolean
    doc: Set the VDS bounds to first missing mapped elements.
    inputBinding:
      position: 102
      prefix: --vds-view-first-missing
  - id: width
    type:
      - 'null'
      - int
    doc: Set the number of columns of output. A value of 0 (zero) sets the 
      number of columns to the maximum (65535). Default width is 80 columns.
    default: 80
    inputBinding:
      position: 102
      prefix: --width
  - id: xml
    type:
      - 'null'
      - boolean
    doc: Output in XML using Schema
    inputBinding:
      position: 102
      prefix: --xml
  - id: xml_dtd
    type:
      - 'null'
      - string
    doc: Use the DTD or schema at U
    inputBinding:
      position: 102
      prefix: --xml-dtd
  - id: xml_ns
    type:
      - 'null'
      - string
    doc: '(XML Schema) Use qualified names n the XML ":" no namespace, default: "hdf5:"'
    inputBinding:
      position: 102
      prefix: --xml-ns
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output raw data into file F
    outputBinding:
      glob: $(inputs.output)
  - id: ddl
    type:
      - 'null'
      - File
    doc: Output ddl text into file F. Use blank(empty) filename F to suppress 
      ddl display
    outputBinding:
      glob: $(inputs.ddl)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hdf5:1.10.4
