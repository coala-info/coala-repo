cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xsd
  - cxx-parser
label: xsd_cxx-parser
doc: "Generate the C++/Parser mapping from XML Schema (XSD) files\n\nTool homepage: https://www.codesynthesis.com/products/xsd/"
inputs:
  - id: type_map
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --type-map
    doc: 'Read XML Schema to C++ type mapping information from <mapfile>. May be given several times.'
    inputBinding:
      position: 1
  - id: xml_parser
    type:
      - 'null'
      - string
    doc: 'Use <parser> as the underlying XML parser.'
    inputBinding:
      position: 1
      prefix: --xml-parser
  - id: generate_validation
    type:
      - 'null'
      - boolean
    doc: 'Generate validation code.'
    inputBinding:
      position: 1
      prefix: --generate-validation
  - id: suppress_validation
    type:
      - 'null'
      - boolean
    doc: 'Suppress the generation of validation code.'
    inputBinding:
      position: 1
      prefix: --suppress-validation
  - id: generate_polymorphic
    type:
      - 'null'
      - boolean
    doc: 'Generate polymorphism-aware code.'
    inputBinding:
      position: 1
      prefix: --generate-polymorphic
  - id: generate_noop_impl
    type:
      - 'null'
      - boolean
    doc: 'Generate a sample parser implementation that does nothing (no operation).'
    inputBinding:
      position: 1
      prefix: --generate-noop-impl
  - id: generate_print_impl
    type:
      - 'null'
      - boolean
    doc: 'Generate a sample parser implementation that prints the XML data to ''STDOUT''.'
    inputBinding:
      position: 1
      prefix: --generate-print-impl
  - id: generate_test_driver
    type:
      - 'null'
      - boolean
    doc: 'Generate a test driver for the sample parser implementation.'
    inputBinding:
      position: 1
      prefix: --generate-test-driver
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: 'Force overwriting of the existing implementation and test driver files.'
    inputBinding:
      position: 1
      prefix: --force-overwrite
  - id: root_element_first
    type:
      - 'null'
      - boolean
    doc: 'Indicate that the first global element is the document root.'
    inputBinding:
      position: 1
      prefix: --root-element-first
  - id: root_element_last
    type:
      - 'null'
      - boolean
    doc: 'Indicate that the last global element is the document root.'
    inputBinding:
      position: 1
      prefix: --root-element-last
  - id: root_element
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --root-element
    doc: 'Indicate that <element> is the document root. May be given several times.'
    inputBinding:
      position: 1
  - id: skel_type_suffix
    type:
      - 'null'
      - string
    doc: 'Use the provided <suffix> instead of the default ''_pskel'' to construct the names of the generated parser skeletons.'
    inputBinding:
      position: 1
      prefix: --skel-type-suffix
  - id: skel_file_suffix
    type:
      - 'null'
      - string
    doc: 'Use the provided <suffix> instead of the default ''-pskel'' to construct the names of the generated parser skeleton files.'
    inputBinding:
      position: 1
      prefix: --skel-file-suffix
  - id: impl_type_suffix
    type:
      - 'null'
      - string
    doc: 'Use the provided <suffix> instead of the default ''_pimpl'' to construct the names of the parser implementations for the built-in XML Schema types as well as sample parser implementations.'
    inputBinding:
      position: 1
      prefix: --impl-type-suffix
  - id: impl_file_suffix
    type:
      - 'null'
      - string
    doc: 'Use the provided <suffix> instead of the default ''-pimpl'' to construct the names of the generated sample parser implementation files.'
    inputBinding:
      position: 1
      prefix: --impl-file-suffix
  - id: std
    type:
      - 'null'
      - string
    doc: 'Specify the C++ standard that the generated code should conform to.'
    inputBinding:
      position: 1
      prefix: --std
  - id: char_type
    type:
      - 'null'
      - string
    doc: 'Generate code using the provided character <type> instead of the default ''char''.'
    inputBinding:
      position: 1
      prefix: --char-type
  - id: char_encoding
    type:
      - 'null'
      - string
    doc: 'Specify the character encoding that should be used in the generated code.'
    inputBinding:
      position: 1
      prefix: --char-encoding
  - id: output_dir
    type:
      - 'null'
      - string
    doc: 'Write generated files to <dir> instead of the current directory.'
    inputBinding:
      position: 1
      prefix: --output-dir
  - id: generate_inline
    type:
      - 'null'
      - boolean
    doc: 'Generate simple functions inline.'
    inputBinding:
      position: 1
      prefix: --generate-inline
  - id: generate_xml_schema
    type:
      - 'null'
      - boolean
    doc: 'Generate a C++ header file as if the schema being compiled defines the XML Schema namespace.'
    inputBinding:
      position: 1
      prefix: --generate-xml-schema
  - id: extern_xml_schema
    type:
      - 'null'
      - File
    doc: 'Include a header file derived from <file> instead of generating the XML Schema namespace mapping inline.'
    inputBinding:
      position: 1
      prefix: --extern-xml-schema
  - id: namespace_map
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --namespace-map
    doc: 'Map XML Schema namespace <xns> to C++ namespace <cns>. May be given several times.'
    inputBinding:
      position: 1
  - id: namespace_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --namespace-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema namespace names to C++ namespace names. May be given several times.'
    inputBinding:
      position: 1
  - id: namespace_regex_trace
    type:
      - 'null'
      - boolean
    doc: 'Trace the process of applying regular expressions specified with the ''--namespace-regex'' option.'
    inputBinding:
      position: 1
      prefix: --namespace-regex-trace
  - id: reserved_name
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --reserved-name
    doc: 'Add name <n> to the list of names that should not be used as identifiers. May be given several times.'
    inputBinding:
      position: 1
  - id: include_with_brackets
    type:
      - 'null'
      - boolean
    doc: 'Use angle brackets (<>) instead of quotes ("") in generated ''#include'' directives.'
    inputBinding:
      position: 1
      prefix: --include-with-brackets
  - id: include_prefix
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --include-prefix
    doc: 'Add <prefix> to generated ''#include'' directive paths. May be given several times.'
    inputBinding:
      position: 1
  - id: include_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --include-regex
    doc: 'Add <regex> to the list of regular expressions used to transform ''#include'' directive paths. May be given several times.'
    inputBinding:
      position: 1
  - id: include_regex_trace
    type:
      - 'null'
      - boolean
    doc: 'Trace the process of applying regular expressions specified with the ''--include-regex'' option.'
    inputBinding:
      position: 1
      prefix: --include-regex-trace
  - id: guard_prefix
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --guard-prefix
    doc: 'Add <prefix> to generated header inclusion guards. May be given several times.'
    inputBinding:
      position: 1
  - id: hxx_suffix
    type:
      - 'null'
      - string
    doc: 'Use the provided <suffix> instead of the default ''.hxx'' to construct the name of the header file.'
    inputBinding:
      position: 1
      prefix: --hxx-suffix
  - id: ixx_suffix
    type:
      - 'null'
      - string
    doc: 'Use the provided <suffix> instead of the default ''.ixx'' to construct the name of the inline file.'
    inputBinding:
      position: 1
      prefix: --ixx-suffix
  - id: cxx_suffix
    type:
      - 'null'
      - string
    doc: 'Use the provided <suffix> instead of the default ''.cxx'' to construct the name of the source file.'
    inputBinding:
      position: 1
      prefix: --cxx-suffix
  - id: fwd_suffix
    type:
      - 'null'
      - string
    doc: 'Use the provided <suffix> instead of the default ''-fwd.hxx'' to construct the name of the forward declaration file.'
    inputBinding:
      position: 1
      prefix: --fwd-suffix
  - id: hxx_regex
    type:
      - 'null'
      - string
    doc: 'Use the provided expression to construct the name of the header file.'
    inputBinding:
      position: 1
      prefix: --hxx-regex
  - id: ixx_regex
    type:
      - 'null'
      - string
    doc: 'Use the provided expression to construct the name of the inline file.'
    inputBinding:
      position: 1
      prefix: --ixx-regex
  - id: cxx_regex
    type:
      - 'null'
      - string
    doc: 'Use the provided expression to construct the name of the source file.'
    inputBinding:
      position: 1
      prefix: --cxx-regex
  - id: fwd_regex
    type:
      - 'null'
      - string
    doc: 'Use the provided expression to construct the name of the forward declaration file.'
    inputBinding:
      position: 1
      prefix: --fwd-regex
  - id: hxx_prologue
    type:
      - 'null'
      - string
    doc: 'Insert <text> at the beginning of the header file.'
    inputBinding:
      position: 1
      prefix: --hxx-prologue
  - id: ixx_prologue
    type:
      - 'null'
      - string
    doc: 'Insert <text> at the beginning of the inline file.'
    inputBinding:
      position: 1
      prefix: --ixx-prologue
  - id: cxx_prologue
    type:
      - 'null'
      - string
    doc: 'Insert <text> at the beginning of the source file.'
    inputBinding:
      position: 1
      prefix: --cxx-prologue
  - id: fwd_prologue
    type:
      - 'null'
      - string
    doc: 'Insert <text> at the beginning of the forward declaration file.'
    inputBinding:
      position: 1
      prefix: --fwd-prologue
  - id: prologue
    type:
      - 'null'
      - string
    doc: 'Insert <text> at the beginning of each generated file for which there is no file-specific prologue.'
    inputBinding:
      position: 1
      prefix: --prologue
  - id: hxx_epilogue
    type:
      - 'null'
      - string
    doc: 'Insert <text> at the end of the header file.'
    inputBinding:
      position: 1
      prefix: --hxx-epilogue
  - id: ixx_epilogue
    type:
      - 'null'
      - string
    doc: 'Insert <text> at the end of the inline file.'
    inputBinding:
      position: 1
      prefix: --ixx-epilogue
  - id: cxx_epilogue
    type:
      - 'null'
      - string
    doc: 'Insert <text> at the end of the source file.'
    inputBinding:
      position: 1
      prefix: --cxx-epilogue
  - id: fwd_epilogue
    type:
      - 'null'
      - string
    doc: 'Insert <text> at the end of the forward declaration file.'
    inputBinding:
      position: 1
      prefix: --fwd-epilogue
  - id: epilogue
    type:
      - 'null'
      - string
    doc: 'Insert <text> at the end of each generated file for which there is no file-specific epilogue.'
    inputBinding:
      position: 1
      prefix: --epilogue
  - id: hxx_prologue_file
    type:
      - 'null'
      - File
    doc: 'Insert the content of the <file> at the beginning of the header file.'
    inputBinding:
      position: 1
      prefix: --hxx-prologue-file
  - id: ixx_prologue_file
    type:
      - 'null'
      - File
    doc: 'Insert the content of the <file> at the beginning of the inline file.'
    inputBinding:
      position: 1
      prefix: --ixx-prologue-file
  - id: cxx_prologue_file
    type:
      - 'null'
      - File
    doc: 'Insert the content of the <file> at the beginning of the source file.'
    inputBinding:
      position: 1
      prefix: --cxx-prologue-file
  - id: fwd_prologue_file
    type:
      - 'null'
      - File
    doc: 'Insert the content of the <file> at the beginning of the forward declaration file.'
    inputBinding:
      position: 1
      prefix: --fwd-prologue-file
  - id: prologue_file
    type:
      - 'null'
      - File
    doc: 'Insert the content of the <file> at the beginning of each generated file for which there is no file-specific prologue file.'
    inputBinding:
      position: 1
      prefix: --prologue-file
  - id: hxx_epilogue_file
    type:
      - 'null'
      - File
    doc: 'Insert the content of the <file> at the end of the header file.'
    inputBinding:
      position: 1
      prefix: --hxx-epilogue-file
  - id: ixx_epilogue_file
    type:
      - 'null'
      - File
    doc: 'Insert the content of the <file> at the end of the inline file.'
    inputBinding:
      position: 1
      prefix: --ixx-epilogue-file
  - id: cxx_epilogue_file
    type:
      - 'null'
      - File
    doc: 'Insert the content of the <file> at the end of the source file.'
    inputBinding:
      position: 1
      prefix: --cxx-epilogue-file
  - id: fwd_epilogue_file
    type:
      - 'null'
      - File
    doc: 'Insert the content of the <file> at the end of the forward declaration file.'
    inputBinding:
      position: 1
      prefix: --fwd-epilogue-file
  - id: epilogue_file
    type:
      - 'null'
      - File
    doc: 'Insert the content of the <file> at the end of each generated file for which there is no file-specific epilogue file.'
    inputBinding:
      position: 1
      prefix: --epilogue-file
  - id: export_symbol
    type:
      - 'null'
      - string
    doc: 'Insert <symbol> in places where DLL export/import control statements (''__declspec(dllexport/dllimport)'') are necessary.'
    inputBinding:
      position: 1
      prefix: --export-symbol
  - id: export_xml_schema
    type:
      - 'null'
      - boolean
    doc: 'Export/import types in the XML Schema namespace using the export symbol provided with the ''--export-symbol'' option.'
    inputBinding:
      position: 1
      prefix: --export-xml-schema
  - id: export_maps
    type:
      - 'null'
      - boolean
    doc: 'Export polymorphism support maps from a Win32 DLL into which this generated code is placed.'
    inputBinding:
      position: 1
      prefix: --export-maps
  - id: import_maps
    type:
      - 'null'
      - boolean
    doc: 'Import polymorphism support maps to a Win32 DLL or executable into which this generated code is linked.'
    inputBinding:
      position: 1
      prefix: --import-maps
  - id: generate_dep
    type:
      - 'null'
      - boolean
    doc: 'Generate ''make'' dependency information.'
    inputBinding:
      position: 1
      prefix: --generate-dep
  - id: generate_dep_only
    type:
      - 'null'
      - boolean
    doc: 'Generate ''make'' dependency information only.'
    inputBinding:
      position: 1
      prefix: --generate-dep-only
  - id: dep_phony
    type:
      - 'null'
      - boolean
    doc: 'Generate phony targets for included/imported schema files, causing each to depend on nothing.'
    inputBinding:
      position: 1
      prefix: --dep-phony
  - id: dep_target
    type:
      - 'null'
      - string
    doc: 'Change the target of the dependency rule.'
    inputBinding:
      position: 1
      prefix: --dep-target
  - id: dep_suffix
    type:
      - 'null'
      - string
    doc: 'Use the provided <suffix> instead of the default ''.d'' to construct the name of the dependency file.'
    inputBinding:
      position: 1
      prefix: --dep-suffix
  - id: dep_regex
    type:
      - 'null'
      - string
    doc: 'Use the provided expression to construct the name of the dependency file.'
    inputBinding:
      position: 1
      prefix: --dep-regex
  - id: disable_warning
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --disable-warning
    doc: 'Disable printing warning with id <warn>. May be given several times.'
    inputBinding:
      position: 1
  - id: options_file
    type:
      - 'null'
      - File
    doc: 'Read additional options from <file>.'
    inputBinding:
      position: 1
      prefix: --options-file
  - id: show_sloc
    type:
      - 'null'
      - boolean
    doc: 'Show the number of generated physical source lines of code (SLOC).'
    inputBinding:
      position: 1
      prefix: --show-sloc
  - id: sloc_limit
    type:
      - 'null'
      - int
    doc: 'Check that the number of generated physical source lines of code (SLOC) does not exceed <num>.'
    inputBinding:
      position: 1
      prefix: --sloc-limit
  - id: proprietary_license
    type:
      - 'null'
      - boolean
    doc: 'Indicate that the generated code is licensed under a proprietary license instead of the GPL.'
    inputBinding:
      position: 1
      prefix: --proprietary-license
  - id: custom_literals
    type:
      - 'null'
      - File
    doc: 'Load custom XML string to C++ literal mappings from <file>.'
    inputBinding:
      position: 1
      prefix: --custom-literals
  - id: preserve_anonymous
    type:
      - 'null'
      - boolean
    doc: 'Preserve anonymous types.'
    inputBinding:
      position: 1
      prefix: --preserve-anonymous
  - id: show_anonymous
    type:
      - 'null'
      - boolean
    doc: 'Show elements and attributes that are of anonymous types.'
    inputBinding:
      position: 1
      prefix: --show-anonymous
  - id: anonymous_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --anonymous-regex
    doc: 'Add <regex> to the list of regular expressions used to derive names for anonymous types from the enclosing attributes/elements. May be given several times.'
    inputBinding:
      position: 1
  - id: anonymous_regex_trace
    type:
      - 'null'
      - boolean
    doc: 'Trace the process of applying regular expressions specified with the ''--anonymous-regex'' option.'
    inputBinding:
      position: 1
      prefix: --anonymous-regex-trace
  - id: location_map
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --location-map
    doc: 'Map the original schema location <ol> that is specified in the XML Schema include or import elements to new schema location <nl>. May be given several times.'
    inputBinding:
      position: 1
  - id: location_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --location-regex
    doc: 'Add <regex> to the list of regular expressions used to map schema locations that are specified in the XML Schema include or import elements. May be given several times.'
    inputBinding:
      position: 1
  - id: location_regex_trace
    type:
      - 'null'
      - boolean
    doc: 'Trace the process of applying regular expressions specified with the ''--location-regex'' option.'
    inputBinding:
      position: 1
      prefix: --location-regex-trace
  - id: file_per_type
    type:
      - 'null'
      - boolean
    doc: 'Generate a separate set of C++ files for each type defined in XML Schema.'
    inputBinding:
      position: 1
      prefix: --file-per-type
  - id: type_file_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --type-file-regex
    doc: 'Add <regex> to the list of regular expressions used to translate type names to file names when the ''--file-per-type'' option is specified. May be given several times.'
    inputBinding:
      position: 1
  - id: type_file_regex_trace
    type:
      - 'null'
      - boolean
    doc: 'Trace the process of applying regular expressions specified with the ''--type-file-regex'' option.'
    inputBinding:
      position: 1
      prefix: --type-file-regex-trace
  - id: schema_file_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --schema-file-regex
    doc: 'Add <regex> to the list of regular expressions used to translate schema file names when the ''--file-per-type'' option is specified. May be given several times.'
    inputBinding:
      position: 1
  - id: schema_file_regex_trace
    type:
      - 'null'
      - boolean
    doc: 'Trace the process of applying regular expressions specified with the ''--schema-file-regex'' option.'
    inputBinding:
      position: 1
      prefix: --schema-file-regex-trace
  - id: fat_type_file
    type:
      - 'null'
      - boolean
    doc: 'Generate code corresponding to global elements into type files instead of schema files when the ''--type-file-regex'' option is specified.'
    inputBinding:
      position: 1
      prefix: --fat-type-file
  - id: file_list
    type:
      - 'null'
      - string
    doc: 'Write a list of generated C++ files to <file>.'
    inputBinding:
      position: 1
      prefix: --file-list
  - id: file_list_prologue
    type:
      - 'null'
      - string
    doc: 'Insert <text> at the beginning of the file list.'
    inputBinding:
      position: 1
      prefix: --file-list-prologue
  - id: file_list_epilogue
    type:
      - 'null'
      - string
    doc: 'Insert <text> at the end of the file list.'
    inputBinding:
      position: 1
      prefix: --file-list-epilogue
  - id: file_list_delim
    type:
      - 'null'
      - string
    doc: 'Delimit file names written to the file list with <text> instead of new lines.'
    inputBinding:
      position: 1
      prefix: --file-list-delim
  - id: schema_files
    type:
      type: array
      items: File
    doc: XML Schema (XSD) file(s) to compile.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (diagnostics, SLOC count, dependency output).
  - id: generated_files
    type:
      type: array
      items: File
    doc: Generated C++ files (header, inline, source, forward declaration, sample implementation and driver files).
    outputBinding:
      glob:
        - '*.?xx'
  - id: dependency_files
    type:
      type: array
      items: File
    doc: Generated make dependency files (with generate_dep).
    outputBinding:
      glob:
        - '*.d'
  - id: output_dir_files
    type:
      - 'null'
      - Directory
    doc: The output directory, when output_dir is given.
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.output_dir ? [{"entryname": inputs.output_dir, "entry": {"class": "Directory", "listing": []}, "writable": true}] : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsd:4.0.0_dep--h0a036d8_4
stdout: xsd_cxx-parser.out
