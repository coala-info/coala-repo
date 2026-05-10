cwlVersion: v1.2
class: CommandLineTool
baseCommand: asntool
label: ncbi-util-legacy_asntool
doc: "AsnTool 7 arguments\n\nTool homepage: ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/"
inputs:
  - id: asn1_module_file_in
    type:
      - 'null'
      - File
    doc: ASN.1 Module File [File In]
    inputBinding:
      position: 101
      prefix: -m
  - id: asn1_module_filenames
    type:
      - 'null'
      - type: array
        items: File
    doc: ASN.1 module filenames, comma separated used for external refs from the
      'm', but no other action taken [File In]
    inputBinding:
      position: 101
      prefix: -M
  - id: binary_value_file_in
    type:
      - 'null'
      - File
    doc: Binary Value File (type required) [File In]
    inputBinding:
      position: 101
      prefix: -d
  - id: binary_value_type
    type:
      - 'null'
      - string
    doc: Binary Value Type [String]
    inputBinding:
      position: 101
      prefix: -t
  - id: bit_twiddle_optional_zero_slots
    type:
      - 'null'
      - boolean
    doc: Bit twiddle for optional zero value base slots [T/F]
    inputBinding:
      position: 101
      prefix: -Z
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Buffer Size [Integer]
    inputBinding:
      position: 101
      prefix: -b
  - id: debugging_level
    type:
      - 'null'
      - int
    doc: During code generation, debugging level 0 - No debugging 1 - Shallow 
      debugging 2 - Deep [Integer]
    inputBinding:
      position: 101
      prefix: -D
  - id: fix_non_printing_chars
    type:
      - 'null'
      - int
    doc: 'Fix Non-Printing Characters 0 - Replace with #, post ERROR 1 - Replace with
      # silently 2 - Pass through silently 3 - Replace with #, post FATAL [Integer]'
    inputBinding:
      position: 101
      prefix: -F
  - id: force_choice_use_structure
    type:
      - 'null'
      - boolean
    doc: Force choice to use structure instead of ValNodePtr [T/F]
    inputBinding:
      position: 101
      prefix: -V
  - id: force_included_asn_header_name
    type:
      - 'null'
      - string
    doc: 'In generated .c, forces name of #included asn header [String]'
    inputBinding:
      position: 101
      prefix: -K
  - id: generate_object_loader
    type:
      - 'null'
      - boolean
    doc: 'Generate object loader .c and .h files, if used, see below parameters: [T/F]'
    inputBinding:
      position: 101
      prefix: -G
  - id: include_filename_in_c
    type:
      - 'null'
      - string
    doc: 'In generated .c, add #include to this filename [String]'
    inputBinding:
      position: 101
      prefix: -I
  - id: label_for_registered_type
    type:
      - 'null'
      - string
    doc: Label for registered type [String]
    inputBinding:
      position: 101
      prefix: -L
  - id: print_value_file_in
    type:
      - 'null'
      - File
    doc: Print Value File [File In]
    inputBinding:
      position: 101
      prefix: -v
  - id: register_type_with_object_manager
    type:
      - 'null'
      - string
    doc: Register type with object manager [String]
    inputBinding:
      position: 101
      prefix: -J
  - id: use_quoted_syntax_for_includes
    type:
      - 'null'
      - boolean
    doc: Use quoted syntax form for generated include files [T/F]
    inputBinding:
      position: 101
      prefix: -Q
  - id: utf8_input_conversion
    type:
      - 'null'
      - int
    doc: UTF8 Input Conversion 0 - Convert silently 1 - Convert, post WARNING 
      first time 2 - Convert, post WARNING each time 3 - Do not convert 
      [Integer]
    inputBinding:
      position: 101
      prefix: -N
  - id: utf8_output_conversion
    type:
      - 'null'
      - int
    doc: UTF8 Output Conversion 0 - Convert silently 1 - Convert, post WARNING 
      first time 2 - Convert, post WARNING each time 3 - Do not convert 
      [Integer]
    inputBinding:
      position: 101
      prefix: -U
  - id: word_length_max_defines
    type:
      - 'null'
      - int
    doc: 'Word length maximum for #defines [Integer]'
    inputBinding:
      position: 101
      prefix: -w
  - id: xml_module_prefix_doctype
    type:
      - 'null'
      - string
    doc: XML module prefix for DOCTYPE [String]
    inputBinding:
      position: 101
      prefix: -P
  - id: asn1_module_file_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `asn1_module_file_out_path`
    inputBinding:
      position: 102
      prefix: --asn1-module-file-out
  - id: asn1_tree_dump_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `asn1_tree_dump_file_path`
    inputBinding:
      position: 103
      prefix: --asn1-tree-dump-file
  - id: base_for_generated_filename_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `base_for_generated_filename_path`
    inputBinding:
      position: 104
      prefix: --base-for-generated-filename
  - id: binary_value_file_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `binary_value_file_out_path`
    inputBinding:
      position: 105
      prefix: --binary-value-file-out
  - id: debugging_filename_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `debugging_filename_path`
    inputBinding:
      position: 106
      prefix: --debugging-filename
  - id: header_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `header_file_path`
    inputBinding:
      position: 107
      prefix: --header-file
  - id: loader_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `loader_file_path`
    inputBinding:
      position: 108
      prefix: --loader-file
  - id: print_value_file_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `print_value_file_out_path`
    inputBinding:
      position: 109
      prefix: --print-value-file-out
  - id: xml_data_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `xml_data_file_path`
    inputBinding:
      position: 110
      prefix: --xml-data-file
  - id: xml_dtd_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `xml_dtd_file_path`
    inputBinding:
      position: 111
      prefix: --xml-dtd-file
outputs:
  - id: asn1_module_file_out
    type:
      - 'null'
      - File
    doc: ASN.1 Module File [File Out]
    outputBinding:
      glob: $(inputs.asn1_module_file_out_path)
  - id: xml_dtd_file
    type:
      - 'null'
      - File
    doc: XML DTD File ("m" to print each module to a separate file) [File Out]
    outputBinding:
      glob: $(inputs.xml_dtd_file_path)
  - id: asn1_tree_dump_file
    type:
      - 'null'
      - File
    doc: ASN.1 Tree Dump File [File Out]
    outputBinding:
      glob: $(inputs.asn1_tree_dump_file_path)
  - id: print_value_file_out
    type:
      - 'null'
      - File
    doc: Print Value File [File Out]
    outputBinding:
      glob: $(inputs.print_value_file_out_path)
  - id: xml_data_file
    type:
      - 'null'
      - File
    doc: XML Data File [File Out]
    outputBinding:
      glob: $(inputs.xml_data_file_path)
  - id: binary_value_file_out
    type:
      - 'null'
      - File
    doc: Binary Value File [File Out]
    outputBinding:
      glob: $(inputs.binary_value_file_out_path)
  - id: header_file
    type:
      - 'null'
      - File
    doc: Header File [File Out]
    outputBinding:
      glob: $(inputs.header_file_path)
  - id: loader_file
    type:
      - 'null'
      - File
    doc: Loader File [File Out]
    outputBinding:
      glob: $(inputs.loader_file_path)
  - id: base_for_generated_filename
    type:
      - 'null'
      - File
    doc: Base for filename, without extensions, for generated objects and code 
      [File Out]
    outputBinding:
      glob: $(inputs.base_for_generated_filename_path)
  - id: debugging_filename
    type:
      - 'null'
      - File
    doc: Debugging filename [File Out]
    outputBinding:
      glob: $(inputs.debugging_filename_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbi-util-legacy:6.1--h0e27e84_3
