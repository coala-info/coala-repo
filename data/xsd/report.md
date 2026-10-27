# xsd CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| xsd_cxx-parser | PASS |  |
| xsd_cxx-tree | PASS |  |

## xsd_cxx-tree

### Tool Description
Generate the C++/Tree mapping from XML Schema (XSD) files

### Metadata
- **Docker Image**: quay.io/biocontainers/xsd:4.0.0_dep--h0a036d8_4
- **Homepage**: https://www.codesynthesis.com/products/xsd/
- **Package**: https://anaconda.org/channels/bioconda/packages/xsd/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: xsd cxx-tree [options] file [file ...]
Options:
--generate-polymorphic       Generate polymorphism-aware code.
--polymorphic-type <type>    Indicate that <type> is a root of a polymorphic
                             type hierarchy.
--polymorphic-type-all       Indicate that all types should be treated as
                             polymorphic.
--polymorphic-plate <num>    Specify the polymorphic map plate the generated
                             code should register on.
--ordered-type <type>        Indicate that element order in <type> is
                             significant.
--ordered-type-derived       Automatically treat types derived from ordered
                             bases as also ordered.
--ordered-type-mixed         Automatically treat complex types with mixed
                             content as ordered.
--ordered-type-all           Indicate that element order in all types is
                             significant.
--order-container <type>     Specify a custom class template that should be
                             used as a container for the content order in
                             ordered types instead of the default
                             'std::vector'.
--generate-serialization     Generate serialization functions.
--generate-ostream           Generate ostream insertion operators
                             ('operator<<') for generated types.
--generate-doxygen           Generate documentation comments suitable for
                             extraction by the Doxygen documentation system.
--generate-comparison        Generate comparison operators ('operator==' and
                             'operator!=') for complex types.
--generate-default-ctor      Generate default constructors even for types that
                             have required members.
--generate-from-base-ctor    Generate constructors that expect an instance of a
                             base type followed by all required members.
--suppress-assignment        Suppress the generation of copy assignment
                             operators for complex types.
--generate-detach            Generate detach functions for required elements
                             and attributes.
--generate-wildcard          Generate accessors and modifiers as well as
                             parsing and serialization code for XML Schema
                             wildcards ('any' and 'anyAttribute').
--generate-any-type          Extract and store content of the XML Schema
                             'anyType' type as a DOM fragment.
--generate-insertion <os>    Generate data representation stream insertion
                             operators for the <os> output stream type.
--generate-extraction <is>   Generate data representation stream extraction
                             constructors for the <is> input stream type.
--generate-forward           Generate a separate header file with forward
                             declarations for the types being generated.
--suppress-parsing           Suppress the generation of the parsing functions
                             and constructors.
--generate-element-type      Generate types instead of parsing and
                             serialization functions for root elements.
--generate-element-map       Generate a root element map that allows uniform
                             parsing and serialization of multiple root
                             elements.
--generate-intellisense      Generate workarounds for IntelliSense bugs in
                             Visual Studio 2005 (8.0).
--omit-default-attributes    Omit attributes with default and fixed values from
                             serialized XML documents.
--type-naming <style>        Specify the type naming convention that should be
                             used in the generated code.
--function-naming <style>    Specify the function naming convention that should
                             be used in the generated code.
--type-regex <regex>         Add <regex> to the list of regular expressions
                             used to translate XML Schema type names to C++
                             type names.
--accessor-regex <regex>     Add <regex> to the list of regular expressions
                             used to translate XML Schema names of
                             elements/attributes to C++ accessor function
                             names.
--one-accessor-regex <regex> Add <regex> to the list of regular expressions
                             used to translate XML Schema names of
                             elements/attributes with cardinality one to C++
                             accessor function names.
--opt-accessor-regex <regex> Add <regex> to the list of regular expressions
                             used to translate XML Schema names of
                             elements/attributes with cardinality optional to
                             C++ accessor function names.
--seq-accessor-regex <regex> Add <regex> to the list of regular expressions
                             used to translate XML Schema names of
                             elements/attributes with cardinality sequence to
                             C++ accessor function names.
--modifier-regex <regex>     Add <regex> to the list of regular expressions
                             used to translate XML Schema names of
                             elements/attributes to C++ modifier function
                             names.
--one-modifier-regex <regex> Add <regex> to the list of regular expressions
                             used to translate XML Schema names of
                             elements/attributes with cardinality one to C++
                             modifier function names.
--opt-modifier-regex <regex> Add <regex> to the list of regular expressions
                             used to translate XML Schema names of
                             elements/attributes with cardinality optional to
                             C++ modifier function names.
--seq-modifier-regex <regex> Add <regex> to the list of regular expressions
                             used to translate XML Schema names of
                             elements/attributes with cardinality sequence to
                             C++ modifier function names.
--parser-regex <regex>       Add <regex> to the list of regular expressions
                             used to translate XML Schema element names to C++
                             parsing function names.
--serializer-regex <regex>   Add <regex> to the list of regular expressions
                             used to translate XML Schema element names to C++
                             serialization function names.
--const-regex <regex>        Add <regex> to the list of regular expressions
                             used to translate XML Schema-derived names to C++
                             constant names.
--enumerator-regex <regex>   Add <regex> to the list of regular expressions
                             used to translate XML Schema enumeration values to
                             C++ enumerator names.
--element-type-regex <regex> Add <regex> to the list of regular expressions
                             used to translate XML Schema element names to C++
                             element type names.
--name-regex-trace           Trace the process of applying regular expressions
                             specified with the name transformation options.
--root-element-first         Treat only the first global element as a document
                             root.
--root-element-last          Treat only the last global element as a document
                             root.
--root-element-all           Treat all global elements as document roots.
--root-element-none          Do not treat any global elements as document
                             roots.
--root-element <element>     Treat only <element> as a document root.
--custom-type <map>          Use a custom C++ type instead of the generated
                             class.
--custom-type-regex <regex>  Use custom C++ types instead of the generated
                             classes.
--parts <num>                Split generated source code into <num> parts.
--parts-suffix <suffix>      Use <suffix> instead of the default ''-'' to
                             separate the file name from the part number.
--std <version>              Specify the C++ standard that the generated code
                             should conform to.
--char-type <type>           Generate code using the provided character <type>
                             instead of the default 'char'.
--char-encoding <enc>        Specify the character encoding that should be used
                             in the generated code.
--output-dir <dir>           Write generated files to <dir> instead of the
                             current directory.
--generate-inline            Generate simple functions inline.
--generate-xml-schema        Generate a C++ header file as if the schema being
                             compiled defines the XML Schema namespace.
--extern-xml-schema <file>   Include a header file derived from <file> instead
                             of generating the XML Schema namespace mapping
                             inline.
--namespace-map <xns>=<cns>  Map XML Schema namespace <xns> to C++ namespace
                             <cns>.
--namespace-regex <regex>    Add <regex> to the list of regular expressions
                             used to translate XML Schema namespace names to
                             C++ namespace names.
--namespace-regex-trace      Trace the process of applying regular expressions
                             specified with the '--namespace-regex' option.
--reserved-name <n>[=<r>]    Add name <n> to the list of names that should not
                             be used as identifiers.
--include-with-brackets      Use angle brackets (<>) instead of quotes ("") in
                             generated '#include' directives.
--include-prefix <prefix>    Add <prefix> to generated '#include' directive
                             paths.
--include-regex <regex>      Add <regex> to the list of regular expressions
                             used to transform '#include' directive paths.
--include-regex-trace        Trace the process of applying regular expressions
                             specified with the '--include-regex' option.
--guard-prefix <prefix>      Add <prefix> to generated header inclusion guards.
--hxx-suffix <suffix>        Use the provided <suffix> instead of the default
                             '.hxx' to construct the name of the header file.
--ixx-suffix <suffix>        Use the provided <suffix> instead of the default
                             '.ixx' to construct the name of the inline file.
--cxx-suffix <suffix>        Use the provided <suffix> instead of the default
                             '.cxx' to construct the name of the source file.
--fwd-suffix <suffix>        Use the provided <suffix> instead of the default
                             '-fwd.hxx' to construct the name of the forward
                             declaration file.
--hxx-regex <regex>          Use the provided expression to construct the name
                             of the header file.
--ixx-regex <regex>          Use the provided expression to construct the name
                             of the inline file.
--cxx-regex <regex>          Use the provided expression to construct the name
                             of the source file.
--fwd-regex <regex>          Use the provided expression to construct the name
                             of the forward declaration file.
--hxx-prologue <text>        Insert <text> at the beginning of the header file.
--ixx-prologue <text>        Insert <text> at the beginning of the inline file.
--cxx-prologue <text>        Insert <text> at the beginning of the source file.
--fwd-prologue <text>        Insert <text> at the beginning of the forward
                             declaration file.
--prologue <text>            Insert <text> at the beginning of each generated
                             file for which there is no file-specific prologue.
--hxx-epilogue <text>        Insert <text> at the end of the header file.
--ixx-epilogue <text>        Insert <text> at the end of the inline file.
--cxx-epilogue <text>        Insert <text> at the end of the source file.
--fwd-epilogue <text>        Insert <text> at the end of the forward
                             declaration file.
--epilogue <text>            Insert <text> at the end of each generated file
                             for which there is no file-specific epilogue.
--hxx-prologue-file <file>   Insert the content of the <file> at the beginning
                             of the header file.
--ixx-prologue-file <file>   Insert the content of the <file> at the beginning
                             of the inline file.
--cxx-prologue-file <file>   Insert the content of the <file> at the beginning
                             of the source file.
--fwd-prologue-file <file>   Insert the content of the <file> at the beginning
                             of the forward declaration file.
--prologue-file <file>       Insert the content of the <file> at the beginning
                             of each generated file for which there is no
                             file-specific prologue file.
--hxx-epilogue-file <file>   Insert the content of the <file> at the end of the
                             header file.
--ixx-epilogue-file <file>   Insert the content of the <file> at the end of the
                             inline file.
--cxx-epilogue-file <file>   Insert the content of the <file> at the end of the
                             source file.
--fwd-epilogue-file <file>   Insert the content of the <file> at the end of the
                             forward declaration file.
--epilogue-file <file>       Insert the content of the <file> at the end of
                             each generated file for which there is no
                             file-specific epilogue file.
--export-symbol <symbol>     Insert <symbol> in places where DLL export/import
                             control statements
                             ('__declspec(dllexport/dllimport)') are necessary.
--export-xml-schema          Export/import types in the XML Schema namespace
                             using the export symbol provided with the
                             '--export-symbol' option.
--export-maps                Export polymorphism support maps from a Win32 DLL
                             into which this generated code is placed.
--import-maps                Import polymorphism support maps to a Win32 DLL or
                             executable into which this generated code is
                             linked.
--generate-dep               Generate 'make' dependency information.
--generate-dep-only          Generate 'make' dependency information only.
--dep-phony                  Generate phony targets for included/imported
                             schema files, causing each to depend on nothing.
--dep-target <target>        Change the target of the dependency rule.
--dep-suffix <suffix>        Use the provided <suffix> instead of the default
                             '.d' to construct the name of the dependency file.
--dep-regex <regex>          Use the provided expression to construct the name
                             of the dependency file.
--disable-warning <warn>     Disable printing warning with id <warn>.
--options-file <file>        Read additional options from <file>.
--show-sloc                  Show the number of generated physical source lines
                             of code (SLOC).
--sloc-limit <num>           Check that the number of generated physical source
                             lines of code (SLOC) does not exceed <num>.
--proprietary-license        Indicate that the generated code is licensed under
                             a proprietary license instead of the GPL.
--custom-literals <file>     Load custom XML string to C++ literal mappings
                             from <file>.
--preserve-anonymous         Preserve anonymous types.
--show-anonymous             Show elements and attributes that are of anonymous
                             types.
--anonymous-regex <regex>    Add <regex> to the list of regular expressions
                             used to derive names for anonymous types from the
                             enclosing attributes/elements.
--anonymous-regex-trace      Trace the process of applying regular expressions
                             specified with the '--anonymous-regex' option.
--location-map <ol>=<nl>     Map the original schema location <ol> that is
                             specified in the XML Schema include or import
                             elements to new schema location <nl>.
--location-regex <regex>     Add <regex> to the list of regular expressions
                             used to map schema locations that are specified in
                             the XML Schema include or import elements.
--location-regex-trace       Trace the process of applying regular expressions
                             specified with the '--location-regex' option.
--file-per-type              Generate a separate set of C++ files for each type
                             defined in XML Schema.
--type-file-regex <regex>    Add <regex> to the list of regular expressions
                             used to translate type names to file names when
                             the '--file-per-type' option is specified.
--type-file-regex-trace      Trace the process of applying regular expressions
                             specified with the '--type-file-regex' option.
--schema-file-regex <regex>  Add <regex> to the list of regular expressions
                             used to translate schema file names when the
                             '--file-per-type' option is specified.
--schema-file-regex-trace    Trace the process of applying regular expressions
                             specified with the '--schema-file-regex' option.
--fat-type-file              Generate code corresponding to global elements
                             into type files instead of schema files when the
                             '--type-file-regex' option is specified.
--file-list <file>           Write a list of generated C++ files to <file>.
--file-list-prologue <text>  Insert <text> at the beginning of the file list.
--file-list-epilogue <text>  Insert <text> at the end of the file list.
--file-list-delim <text>     Delimit file names written to the file list with
                             <text> instead of new lines.
```

## xsd_cxx-parser

### Tool Description
Generate the C++/Parser mapping from XML Schema (XSD) files

### Metadata
- **Docker Image**: quay.io/biocontainers/xsd:4.0.0_dep--h0a036d8_4
- **Homepage**: https://www.codesynthesis.com/products/xsd/
- **Package**: https://anaconda.org/channels/bioconda/packages/xsd/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: xsd cxx-parser [options] file [file ...]
Options:
--type-map <mapfile>         Read XML Schema to C++ type mapping information
                             from <mapfile>.
--xml-parser <parser>        Use <parser> as the underlying XML parser.
--generate-validation        Generate validation code.
--suppress-validation        Suppress the generation of validation code.
--generate-polymorphic       Generate polymorphism-aware code.
--generate-noop-impl         Generate a sample parser implementation that does
                             nothing (no operation).
--generate-print-impl        Generate a sample parser implementation that
                             prints the XML data to 'STDOUT'.
--generate-test-driver       Generate a test driver for the sample parser
                             implementation.
--force-overwrite            Force overwriting of the existing implementation
                             and test driver files.
--root-element-first         Indicate that the first global element is the
                             document root.
--root-element-last          Indicate that the last global element is the
                             document root.
--root-element <element>     Indicate that <element> is the document root.
--skel-type-suffix <suffix>  Use the provided <suffix> instead of the default
                             '_pskel' to construct the names of the generated
                             parser skeletons.
--skel-file-suffix <suffix>  Use the provided <suffix> instead of the default
                             '-pskel' to construct the names of the generated
                             parser skeleton files.
--impl-type-suffix <suffix>  Use the provided <suffix> instead of the default
                             '_pimpl' to construct the names of the parser
                             implementations for the built-in XML Schema types
                             as well as sample parser implementations.
--impl-file-suffix <suffix>  Use the provided <suffix> instead of the default
                             '-pimpl' to construct the names of the generated
                             sample parser implementation files.
--std <version>              Specify the C++ standard that the generated code
                             should conform to.
--char-type <type>           Generate code using the provided character <type>
                             instead of the default 'char'.
--char-encoding <enc>        Specify the character encoding that should be used
                             in the generated code.
--output-dir <dir>           Write generated files to <dir> instead of the
                             current directory.
--generate-inline            Generate simple functions inline.
--generate-xml-schema        Generate a C++ header file as if the schema being
                             compiled defines the XML Schema namespace.
--extern-xml-schema <file>   Include a header file derived from <file> instead
                             of generating the XML Schema namespace mapping
                             inline.
--namespace-map <xns>=<cns>  Map XML Schema namespace <xns> to C++ namespace
                             <cns>.
--namespace-regex <regex>    Add <regex> to the list of regular expressions
                             used to translate XML Schema namespace names to
                             C++ namespace names.
--namespace-regex-trace      Trace the process of applying regular expressions
                             specified with the '--namespace-regex' option.
--reserved-name <n>[=<r>]    Add name <n> to the list of names that should not
                             be used as identifiers.
--include-with-brackets      Use angle brackets (<>) instead of quotes ("") in
                             generated '#include' directives.
--include-prefix <prefix>    Add <prefix> to generated '#include' directive
                             paths.
--include-regex <regex>      Add <regex> to the list of regular expressions
                             used to transform '#include' directive paths.
--include-regex-trace        Trace the process of applying regular expressions
                             specified with the '--include-regex' option.
--guard-prefix <prefix>      Add <prefix> to generated header inclusion guards.
--hxx-suffix <suffix>        Use the provided <suffix> instead of the default
                             '.hxx' to construct the name of the header file.
--ixx-suffix <suffix>        Use the provided <suffix> instead of the default
                             '.ixx' to construct the name of the inline file.
--cxx-suffix <suffix>        Use the provided <suffix> instead of the default
                             '.cxx' to construct the name of the source file.
--fwd-suffix <suffix>        Use the provided <suffix> instead of the default
                             '-fwd.hxx' to construct the name of the forward
                             declaration file.
--hxx-regex <regex>          Use the provided expression to construct the name
                             of the header file.
--ixx-regex <regex>          Use the provided expression to construct the name
                             of the inline file.
--cxx-regex <regex>          Use the provided expression to construct the name
                             of the source file.
--fwd-regex <regex>          Use the provided expression to construct the name
                             of the forward declaration file.
--hxx-prologue <text>        Insert <text> at the beginning of the header file.
--ixx-prologue <text>        Insert <text> at the beginning of the inline file.
--cxx-prologue <text>        Insert <text> at the beginning of the source file.
--fwd-prologue <text>        Insert <text> at the beginning of the forward
                             declaration file.
--prologue <text>            Insert <text> at the beginning of each generated
                             file for which there is no file-specific prologue.
--hxx-epilogue <text>        Insert <text> at the end of the header file.
--ixx-epilogue <text>        Insert <text> at the end of the inline file.
--cxx-epilogue <text>        Insert <text> at the end of the source file.
--fwd-epilogue <text>        Insert <text> at the end of the forward
                             declaration file.
--epilogue <text>            Insert <text> at the end of each generated file
                             for which there is no file-specific epilogue.
--hxx-prologue-file <file>   Insert the content of the <file> at the beginning
                             of the header file.
--ixx-prologue-file <file>   Insert the content of the <file> at the beginning
                             of the inline file.
--cxx-prologue-file <file>   Insert the content of the <file> at the beginning
                             of the source file.
--fwd-prologue-file <file>   Insert the content of the <file> at the beginning
                             of the forward declaration file.
--prologue-file <file>       Insert the content of the <file> at the beginning
                             of each generated file for which there is no
                             file-specific prologue file.
--hxx-epilogue-file <file>   Insert the content of the <file> at the end of the
                             header file.
--ixx-epilogue-file <file>   Insert the content of the <file> at the end of the
                             inline file.
--cxx-epilogue-file <file>   Insert the content of the <file> at the end of the
                             source file.
--fwd-epilogue-file <file>   Insert the content of the <file> at the end of the
                             forward declaration file.
--epilogue-file <file>       Insert the content of the <file> at the end of
                             each generated file for which there is no
                             file-specific epilogue file.
--export-symbol <symbol>     Insert <symbol> in places where DLL export/import
                             control statements
                             ('__declspec(dllexport/dllimport)') are necessary.
--export-xml-schema          Export/import types in the XML Schema namespace
                             using the export symbol provided with the
                             '--export-symbol' option.
--export-maps                Export polymorphism support maps from a Win32 DLL
                             into which this generated code is placed.
--import-maps                Import polymorphism support maps to a Win32 DLL or
                             executable into which this generated code is
                             linked.
--generate-dep               Generate 'make' dependency information.
--generate-dep-only          Generate 'make' dependency information only.
--dep-phony                  Generate phony targets for included/imported
                             schema files, causing each to depend on nothing.
--dep-target <target>        Change the target of the dependency rule.
--dep-suffix <suffix>        Use the provided <suffix> instead of the default
                             '.d' to construct the name of the dependency file.
--dep-regex <regex>          Use the provided expression to construct the name
                             of the dependency file.
--disable-warning <warn>     Disable printing warning with id <warn>.
--options-file <file>        Read additional options from <file>.
--show-sloc                  Show the number of generated physical source lines
                             of code (SLOC).
--sloc-limit <num>           Check that the number of generated physical source
                             lines of code (SLOC) does not exceed <num>.
--proprietary-license        Indicate that the generated code is licensed under
                             a proprietary license instead of the GPL.
--custom-literals <file>     Load custom XML string to C++ literal mappings
                             from <file>.
--preserve-anonymous         Preserve anonymous types.
--show-anonymous             Show elements and attributes that are of anonymous
                             types.
--anonymous-regex <regex>    Add <regex> to the list of regular expressions
                             used to derive names for anonymous types from the
                             enclosing attributes/elements.
--anonymous-regex-trace      Trace the process of applying regular expressions
                             specified with the '--anonymous-regex' option.
--location-map <ol>=<nl>     Map the original schema location <ol> that is
                             specified in the XML Schema include or import
                             elements to new schema location <nl>.
--location-regex <regex>     Add <regex> to the list of regular expressions
                             used to map schema locations that are specified in
                             the XML Schema include or import elements.
--location-regex-trace       Trace the process of applying regular expressions
                             specified with the '--location-regex' option.
--file-per-type              Generate a separate set of C++ files for each type
                             defined in XML Schema.
--type-file-regex <regex>    Add <regex> to the list of regular expressions
                             used to translate type names to file names when
                             the '--file-per-type' option is specified.
--type-file-regex-trace      Trace the process of applying regular expressions
                             specified with the '--type-file-regex' option.
--schema-file-regex <regex>  Add <regex> to the list of regular expressions
                             used to translate schema file names when the
                             '--file-per-type' option is specified.
--schema-file-regex-trace    Trace the process of applying regular expressions
                             specified with the '--schema-file-regex' option.
--fat-type-file              Generate code corresponding to global elements
                             into type files instead of schema files when the
                             '--type-file-regex' option is specified.
--file-list <file>           Write a list of generated C++ files to <file>.
--file-list-prologue <text>  Insert <text> at the beginning of the file list.
--file-list-epilogue <text>  Insert <text> at the end of the file list.
--file-list-delim <text>     Delimit file names written to the file list with
                             <text> instead of new lines.
```

