cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xsd
  - cxx-tree
label: xsd_cxx-tree
doc: "Generate the C++/Tree mapping from XML Schema (XSD) files\n\nTool homepage: https://www.codesynthesis.com/products/xsd/"
inputs:
  - id: generate_polymorphic
    type:
      - 'null'
      - boolean
    doc: 'Generate polymorphism-aware code.'
    inputBinding:
      position: 1
      prefix: --generate-polymorphic
  - id: polymorphic_type
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --polymorphic-type
    doc: 'Indicate that <type> is a root of a polymorphic type hierarchy. May be given several times.'
    inputBinding:
      position: 1
  - id: polymorphic_type_all
    type:
      - 'null'
      - boolean
    doc: 'Indicate that all types should be treated as polymorphic.'
    inputBinding:
      position: 1
      prefix: --polymorphic-type-all
  - id: polymorphic_plate
    type:
      - 'null'
      - int
    doc: 'Specify the polymorphic map plate the generated code should register on.'
    inputBinding:
      position: 1
      prefix: --polymorphic-plate
  - id: ordered_type
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --ordered-type
    doc: 'Indicate that element order in <type> is significant. May be given several times.'
    inputBinding:
      position: 1
  - id: ordered_type_derived
    type:
      - 'null'
      - boolean
    doc: 'Automatically treat types derived from ordered bases as also ordered.'
    inputBinding:
      position: 1
      prefix: --ordered-type-derived
  - id: ordered_type_mixed
    type:
      - 'null'
      - boolean
    doc: 'Automatically treat complex types with mixed content as ordered.'
    inputBinding:
      position: 1
      prefix: --ordered-type-mixed
  - id: ordered_type_all
    type:
      - 'null'
      - boolean
    doc: 'Indicate that element order in all types is significant.'
    inputBinding:
      position: 1
      prefix: --ordered-type-all
  - id: order_container
    type:
      - 'null'
      - string
    doc: 'Specify a custom class template that should be used as a container for the content order in ordered types instead of the default ''std::vector''.'
    inputBinding:
      position: 1
      prefix: --order-container
  - id: generate_serialization
    type:
      - 'null'
      - boolean
    doc: 'Generate serialization functions.'
    inputBinding:
      position: 1
      prefix: --generate-serialization
  - id: generate_ostream
    type:
      - 'null'
      - boolean
    doc: 'Generate ostream insertion operators (''operator<<'') for generated types.'
    inputBinding:
      position: 1
      prefix: --generate-ostream
  - id: generate_doxygen
    type:
      - 'null'
      - boolean
    doc: 'Generate documentation comments suitable for extraction by the Doxygen documentation system.'
    inputBinding:
      position: 1
      prefix: --generate-doxygen
  - id: generate_comparison
    type:
      - 'null'
      - boolean
    doc: 'Generate comparison operators (''operator=='' and ''operator!='') for complex types.'
    inputBinding:
      position: 1
      prefix: --generate-comparison
  - id: generate_default_ctor
    type:
      - 'null'
      - boolean
    doc: 'Generate default constructors even for types that have required members.'
    inputBinding:
      position: 1
      prefix: --generate-default-ctor
  - id: generate_from_base_ctor
    type:
      - 'null'
      - boolean
    doc: 'Generate constructors that expect an instance of a base type followed by all required members.'
    inputBinding:
      position: 1
      prefix: --generate-from-base-ctor
  - id: suppress_assignment
    type:
      - 'null'
      - boolean
    doc: 'Suppress the generation of copy assignment operators for complex types.'
    inputBinding:
      position: 1
      prefix: --suppress-assignment
  - id: generate_detach
    type:
      - 'null'
      - boolean
    doc: 'Generate detach functions for required elements and attributes.'
    inputBinding:
      position: 1
      prefix: --generate-detach
  - id: generate_wildcard
    type:
      - 'null'
      - boolean
    doc: 'Generate accessors and modifiers as well as parsing and serialization code for XML Schema wildcards (''any'' and ''anyAttribute'').'
    inputBinding:
      position: 1
      prefix: --generate-wildcard
  - id: generate_any_type
    type:
      - 'null'
      - boolean
    doc: 'Extract and store content of the XML Schema ''anyType'' type as a DOM fragment.'
    inputBinding:
      position: 1
      prefix: --generate-any-type
  - id: generate_insertion
    type:
      - 'null'
      - string
    doc: 'Generate data representation stream insertion operators for the <os> output stream type.'
    inputBinding:
      position: 1
      prefix: --generate-insertion
  - id: generate_extraction
    type:
      - 'null'
      - string
    doc: 'Generate data representation stream extraction constructors for the <is> input stream type.'
    inputBinding:
      position: 1
      prefix: --generate-extraction
  - id: generate_forward
    type:
      - 'null'
      - boolean
    doc: 'Generate a separate header file with forward declarations for the types being generated.'
    inputBinding:
      position: 1
      prefix: --generate-forward
  - id: suppress_parsing
    type:
      - 'null'
      - boolean
    doc: 'Suppress the generation of the parsing functions and constructors.'
    inputBinding:
      position: 1
      prefix: --suppress-parsing
  - id: generate_element_type
    type:
      - 'null'
      - boolean
    doc: 'Generate types instead of parsing and serialization functions for root elements.'
    inputBinding:
      position: 1
      prefix: --generate-element-type
  - id: generate_element_map
    type:
      - 'null'
      - boolean
    doc: 'Generate a root element map that allows uniform parsing and serialization of multiple root elements.'
    inputBinding:
      position: 1
      prefix: --generate-element-map
  - id: generate_intellisense
    type:
      - 'null'
      - boolean
    doc: 'Generate workarounds for IntelliSense bugs in Visual Studio 2005 (8.0).'
    inputBinding:
      position: 1
      prefix: --generate-intellisense
  - id: omit_default_attributes
    type:
      - 'null'
      - boolean
    doc: 'Omit attributes with default and fixed values from serialized XML documents.'
    inputBinding:
      position: 1
      prefix: --omit-default-attributes
  - id: type_naming
    type:
      - 'null'
      - string
    doc: 'Specify the type naming convention that should be used in the generated code.'
    inputBinding:
      position: 1
      prefix: --type-naming
  - id: function_naming
    type:
      - 'null'
      - string
    doc: 'Specify the function naming convention that should be used in the generated code.'
    inputBinding:
      position: 1
      prefix: --function-naming
  - id: type_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --type-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema type names to C++ type names. May be given several times.'
    inputBinding:
      position: 1
  - id: accessor_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --accessor-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema names of elements/attributes to C++ accessor function names. May be given several times.'
    inputBinding:
      position: 1
  - id: one_accessor_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --one-accessor-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema names of elements/attributes with cardinality one to C++ accessor function names. May be given several times.'
    inputBinding:
      position: 1
  - id: opt_accessor_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --opt-accessor-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema names of elements/attributes with cardinality optional to C++ accessor function names. May be given several times.'
    inputBinding:
      position: 1
  - id: seq_accessor_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --seq-accessor-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema names of elements/attributes with cardinality sequence to C++ accessor function names. May be given several times.'
    inputBinding:
      position: 1
  - id: modifier_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --modifier-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema names of elements/attributes to C++ modifier function names. May be given several times.'
    inputBinding:
      position: 1
  - id: one_modifier_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --one-modifier-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema names of elements/attributes with cardinality one to C++ modifier function names. May be given several times.'
    inputBinding:
      position: 1
  - id: opt_modifier_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --opt-modifier-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema names of elements/attributes with cardinality optional to C++ modifier function names. May be given several times.'
    inputBinding:
      position: 1
  - id: seq_modifier_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --seq-modifier-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema names of elements/attributes with cardinality sequence to C++ modifier function names. May be given several times.'
    inputBinding:
      position: 1
  - id: parser_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --parser-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema element names to C++ parsing function names. May be given several times.'
    inputBinding:
      position: 1
  - id: serializer_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --serializer-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema element names to C++ serialization function names. May be given several times.'
    inputBinding:
      position: 1
  - id: const_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --const-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema-derived names to C++ constant names. May be given several times.'
    inputBinding:
      position: 1
  - id: enumerator_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --enumerator-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema enumeration values to C++ enumerator names. May be given several times.'
    inputBinding:
      position: 1
  - id: element_type_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --element-type-regex
    doc: 'Add <regex> to the list of regular expressions used to translate XML Schema element names to C++ element type names. May be given several times.'
    inputBinding:
      position: 1
  - id: name_regex_trace
    type:
      - 'null'
      - boolean
    doc: 'Trace the process of applying regular expressions specified with the name transformation options.'
    inputBinding:
      position: 1
      prefix: --name-regex-trace
  - id: root_element_first
    type:
      - 'null'
      - boolean
    doc: 'Treat only the first global element as a document root.'
    inputBinding:
      position: 1
      prefix: --root-element-first
  - id: root_element_last
    type:
      - 'null'
      - boolean
    doc: 'Treat only the last global element as a document root.'
    inputBinding:
      position: 1
      prefix: --root-element-last
  - id: root_element_all
    type:
      - 'null'
      - boolean
    doc: 'Treat all global elements as document roots.'
    inputBinding:
      position: 1
      prefix: --root-element-all
  - id: root_element_none
    type:
      - 'null'
      - boolean
    doc: 'Do not treat any global elements as document roots.'
    inputBinding:
      position: 1
      prefix: --root-element-none
  - id: root_element
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --root-element
    doc: 'Treat only <element> as a document root. May be given several times.'
    inputBinding:
      position: 1
  - id: custom_type
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --custom-type
    doc: 'Use a custom C++ type instead of the generated class. May be given several times.'
    inputBinding:
      position: 1
  - id: custom_type_regex
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --custom-type-regex
    doc: 'Use custom C++ types instead of the generated classes. May be given several times.'
    inputBinding:
      position: 1
  - id: parts
    type:
      - 'null'
      - int
    doc: 'Split generated source code into <num> parts.'
    inputBinding:
      position: 1
      prefix: --parts
  - id: parts_suffix
    type:
      - 'null'
      - string
    doc: 'Use <suffix> instead of the default ''''-'''' to separate the file name from the part number.'
    inputBinding:
      position: 1
      prefix: --parts-suffix
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
  - id: file_list_out
    type:
      - 'null'
      - File
    doc: The file list written with file_list.
    outputBinding:
      glob: $(inputs.file_list)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.output_dir ? [{"entryname": inputs.output_dir, "entry": {"class": "Directory", "listing": []}, "writable": true}] : [])'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xsd:4.0.0_dep--h0a036d8_4
stdout: xsd_cxx-tree.out
