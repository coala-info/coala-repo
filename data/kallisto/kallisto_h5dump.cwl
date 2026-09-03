cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kallisto
  - h5dump
label: kallisto_h5dump
doc: HDF5 dump tool to display HDF5 file contents
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: HDF5 files to be examined
    inputBinding:
      position: 1
  - id: enable_error_stack
    type:
      - 'null'
      - int
    doc: Prints messages from the HDF5 error stack as they occur. Optional value
      2 also prints file open errors.
    inputBinding:
      position: 102
      prefix: --enable-error-stack
  - id: contents
    type:
      - 'null'
      - int
    doc: Print a list of the file contents and exit. Optional value 1 also 
      prints attributes.
    inputBinding:
      position: 102
      prefix: --contents
  - id: superblock
    type:
      - 'null'
      - boolean
    doc: Print the content of the super block
    inputBinding:
      position: 102
      prefix: --superblock
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print the header only; no data is displayed
    inputBinding:
      position: 102
      prefix: --header
  - id: filedriver
    type:
      - 'null'
      - string
    doc: Specify which driver to open the file with (sec2, family, split, multi,
      direct, stream)
    inputBinding:
      position: 102
      prefix: --filedriver
  - id: output
    type: string
    doc: Output raw data into file F
    inputBinding:
      position: 102
      prefix: --output
  - id: binary
    type:
      - 'null'
      - string
    doc: Binary file output, of form B (NATIVE, FILE, LE, BE)
    inputBinding:
      position: 102
      prefix: --binary
  - id: ddl
    type: string
    doc: Output ddl text into file F
    inputBinding:
      position: 102
      prefix: --ddl
  - id: s3_cred
    type:
      - 'null'
      - string
    doc: Supply S3 authentication information to 'ros3' vfd
    inputBinding:
      position: 102
      prefix: --s3-cred
  - id: hdfs_attrs
    type:
      - 'null'
      - string
    doc: Supply configuration information for HDFS file access
    inputBinding:
      position: 102
      prefix: --hdfs-attrs
  - id: vol_value
    type:
      - 'null'
      - string
    doc: Value (ID) of the VOL connector to use
    inputBinding:
      position: 102
      prefix: --vol-value
  - id: vol_name
    type:
      - 'null'
      - string
    doc: Name of the VOL connector to use
    inputBinding:
      position: 102
      prefix: --vol-name
  - id: vol_info
    type:
      - 'null'
      - string
    doc: VOL-specific info to pass to the VOL connector
    inputBinding:
      position: 102
      prefix: --vol-info
  - id: vfd_value
    type:
      - 'null'
      - string
    doc: Value (ID) of the VFL driver to use
    inputBinding:
      position: 102
      prefix: --vfd-value
  - id: vfd_name
    type:
      - 'null'
      - string
    doc: Name of the VFL driver to use
    inputBinding:
      position: 102
      prefix: --vfd-name
  - id: vfd_info
    type:
      - 'null'
      - string
    doc: VFD-specific info to pass to the VFL driver
    inputBinding:
      position: 102
      prefix: --vfd-info
  - id: attribute
    type:
      - 'null'
      - string
    doc: Print the specified attribute
    inputBinding:
      position: 102
      prefix: --attribute
  - id: dataset
    type:
      - 'null'
      - string
    doc: Print the specified dataset
    inputBinding:
      position: 102
      prefix: --dataset
  - id: group
    type:
      - 'null'
      - string
    doc: Print the specified group and all members
    inputBinding:
      position: 102
      prefix: --group
  - id: soft_link
    type:
      - 'null'
      - string
    doc: Print the value(s) of the specified soft link
    inputBinding:
      position: 102
      prefix: --soft-link
  - id: datatype
    type:
      - 'null'
      - string
    doc: Print the specified named datatype
    inputBinding:
      position: 102
      prefix: --datatype
  - id: any_path
    type:
      - 'null'
      - string
    doc: Print any attribute, dataset, group, datatype, or link that matches P
    inputBinding:
      position: 102
      prefix: --any_path
  - id: onlyattr
    type:
      - 'null'
      - int
    doc: Print the header and value of attributes. Optional value 0 suppresses 
      printing attributes.
    inputBinding:
      position: 102
      prefix: --onlyattr
  - id: vds_view_first_missing
    type:
      - 'null'
      - boolean
    doc: Set the VDS bounds to first missing mapped elements
    inputBinding:
      position: 102
      prefix: --vds-view-first-missing
  - id: vds_gap_size
    type:
      - 'null'
      - int
    doc: Set the missing file gap size, N=non-negative integers
    inputBinding:
      position: 102
      prefix: --vds-gap-size
  - id: object_ids
    type:
      - 'null'
      - boolean
    doc: Print the object ids
    inputBinding:
      position: 102
      prefix: --object-ids
  - id: properties
    type:
      - 'null'
      - boolean
    doc: Print dataset filters, storage layout and fill value
    inputBinding:
      position: 102
      prefix: --properties
  - id: packedbits
    type:
      - 'null'
      - string
    doc: Print packed bits as unsigned integers, using mask format L 
      (offset,length)
    inputBinding:
      position: 102
      prefix: --packedbits
  - id: region
    type:
      - 'null'
      - boolean
    doc: Print dataset pointed by region references
    inputBinding:
      position: 102
      prefix: --region
  - id: escape
    type:
      - 'null'
      - boolean
    doc: Escape non printing characters
    inputBinding:
      position: 102
      prefix: --escape
  - id: string
    type:
      - 'null'
      - boolean
    doc: Print 1-byte integer datasets as ASCII
    inputBinding:
      position: 102
      prefix: --string
  - id: noindex
    type:
      - 'null'
      - boolean
    doc: Do not print array indices with the data
    inputBinding:
      position: 102
      prefix: --noindex
  - id: format
    type:
      - 'null'
      - string
    doc: Set the floating point output format
    inputBinding:
      position: 102
      prefix: --format
  - id: sort_by
    type:
      - 'null'
      - string
    doc: Sort groups and attributes by index Q (creation_order or name)
    inputBinding:
      position: 102
      prefix: --sort_by
  - id: sort_order
    type:
      - 'null'
      - string
    doc: Sort groups and attributes by order Z (descending or ascending)
    inputBinding:
      position: 102
      prefix: --sort_order
  - id: no_compact_subset
    type:
      - 'null'
      - boolean
    doc: Disable compact form of subsetting and allow the use of '[' in dataset 
      names
    inputBinding:
      position: 102
      prefix: --no-compact-subset
  - id: width
    type:
      - 'null'
      - int
    doc: Set the number of columns of output
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
  - id: use_dtd
    type:
      - 'null'
      - boolean
    doc: Output in XML using DTD
    inputBinding:
      position: 102
      prefix: --use-dtd
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
    doc: (XML Schema) Use qualified names in the XML
    inputBinding:
      position: 102
      prefix: --xml-ns
  - id: start
    type:
      - 'null'
      - string
    doc: Offset of start of subsetting selection (list of integers)
    inputBinding:
      position: 102
      prefix: --start
  - id: stride
    type:
      - 'null'
      - string
    doc: Hyperslab stride (list of integers)
    inputBinding:
      position: 102
      prefix: --stride
  - id: count_subset
    type:
      - 'null'
      - string
    doc: Number of blocks to include in selection (list of integers)
    inputBinding:
      position: 102
      prefix: --count
  - id: block
    type:
      - 'null'
      - string
    doc: Size of block in hyperslab (list of integers)
    inputBinding:
      position: 102
      prefix: --block
outputs:
  - id: output_output
    type:
      - 'null'
      - File
    doc: Output raw data into file F
    outputBinding:
      glob: $(inputs.output)
  - id: output_ddl
    type:
      - 'null'
      - File
    doc: Output ddl text into file F
    outputBinding:
      glob: $(inputs.ddl)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kallisto:0.52.0--h13ff97a_0
s:url: https://pachterlab.github.io/kallisto
$namespaces:
  s: https://schema.org/
