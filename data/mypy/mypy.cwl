cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - python3
  - -m
  - mypy
label: mypy
doc: "Mypy is an optional static type checker for Python that aims to combine the
  benefits of dynamic (or \"duck\") typing and static typing. Exit code 1 means type
  errors were found.\n\nTool homepage: https://github.com/python/mypy"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Type-check given files or directories
    inputBinding:
      position: 1
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "More verbose messages"
    inputBinding:
      position: 102
      prefix: "--verbose"
  - id: config_file
    type:
      - 'null'
      - File
    doc: "Configuration file, must have a [mypy] section"
    inputBinding:
      position: 102
      prefix: "--config-file"
  - id: warn_unused_configs
    type:
      - 'null'
      - boolean
    doc: "Warn about unused '[mypy-<pattern>]' config sections"
    inputBinding:
      position: 102
      prefix: "--warn-unused-configs"
  - id: ignore_missing_imports
    type:
      - 'null'
      - boolean
    doc: "Silently ignore imports of missing modules"
    inputBinding:
      position: 102
      prefix: "--ignore-missing-imports"
  - id: follow_imports
    type:
      - 'null'
      - string
    doc: "How to treat imports: normal, silent, skip or error (default normal)"
    inputBinding:
      position: 102
      prefix: "--follow-imports"
  - id: no_site_packages
    type:
      - 'null'
      - boolean
    doc: "Do not search for installed PEP 561 compliant packages"
    inputBinding:
      position: 102
      prefix: "--no-site-packages"
  - id: namespace_packages
    type:
      - 'null'
      - boolean
    doc: "Support namespace packages (PEP 420, __init__.py-less)"
    inputBinding:
      position: 102
      prefix: "--namespace-packages"
  - id: python_version
    type:
      - 'null'
      - string
    doc: "Type check code assuming it will be running on Python x.y"
    inputBinding:
      position: 102
      prefix: "--python-version"
  - id: py2
    type:
      - 'null'
      - boolean
    doc: "Use Python 2 mode (same as --python-version 2.7)"
    inputBinding:
      position: 102
      prefix: "--py2"
  - id: platform
    type:
      - 'null'
      - string
    doc: "Type check special-cased code for the given OS platform (defaults to sys.platform)"
    inputBinding:
      position: 102
      prefix: "--platform"
  - id: disallow_any_unimported
    type:
      - 'null'
      - boolean
    doc: "Disallow Any types resulting from unfollowed imports"
    inputBinding:
      position: 102
      prefix: "--disallow-any-unimported"
  - id: disallow_subclassing_any
    type:
      - 'null'
      - boolean
    doc: "Disallow subclassing values of type 'Any' when defining classes"
    inputBinding:
      position: 102
      prefix: "--disallow-subclassing-any"
  - id: disallow_any_expr
    type:
      - 'null'
      - boolean
    doc: "Disallow all expressions that have type Any"
    inputBinding:
      position: 102
      prefix: "--disallow-any-expr"
  - id: disallow_any_decorated
    type:
      - 'null'
      - boolean
    doc: "Disallow functions that have Any in their signature after decorator transformation"
    inputBinding:
      position: 102
      prefix: "--disallow-any-decorated"
  - id: disallow_any_explicit
    type:
      - 'null'
      - boolean
    doc: "Disallow explicit Any in type positions"
    inputBinding:
      position: 102
      prefix: "--disallow-any-explicit"
  - id: disallow_any_generics
    type:
      - 'null'
      - boolean
    doc: "Disallow usage of generic types that do not specify explicit type parameters"
    inputBinding:
      position: 102
      prefix: "--disallow-any-generics"
  - id: disallow_untyped_calls
    type:
      - 'null'
      - boolean
    doc: "Disallow calling functions without type annotations from functions with type annotations"
    inputBinding:
      position: 102
      prefix: "--disallow-untyped-calls"
  - id: disallow_untyped_defs
    type:
      - 'null'
      - boolean
    doc: "Disallow defining functions without type annotations or with incomplete type annotations"
    inputBinding:
      position: 102
      prefix: "--disallow-untyped-defs"
  - id: disallow_incomplete_defs
    type:
      - 'null'
      - boolean
    doc: "Disallow defining functions with incomplete type annotations"
    inputBinding:
      position: 102
      prefix: "--disallow-incomplete-defs"
  - id: check_untyped_defs
    type:
      - 'null'
      - boolean
    doc: "Type check the interior of functions without type annotations"
    inputBinding:
      position: 102
      prefix: "--check-untyped-defs"
  - id: disallow_untyped_decorators
    type:
      - 'null'
      - boolean
    doc: "Disallow decorating typed functions with untyped decorators"
    inputBinding:
      position: 102
      prefix: "--disallow-untyped-decorators"
  - id: no_implicit_optional
    type:
      - 'null'
      - boolean
    doc: "Don't assume arguments with default values of None are Optional"
    inputBinding:
      position: 102
      prefix: "--no-implicit-optional"
  - id: no_strict_optional
    type:
      - 'null'
      - boolean
    doc: "Disable strict Optional checks"
    inputBinding:
      position: 102
      prefix: "--no-strict-optional"
  - id: warn_redundant_casts
    type:
      - 'null'
      - boolean
    doc: "Warn about casting an expression to its inferred type"
    inputBinding:
      position: 102
      prefix: "--warn-redundant-casts"
  - id: warn_unused_ignores
    type:
      - 'null'
      - boolean
    doc: "Warn about unneeded '# type: ignore' comments"
    inputBinding:
      position: 102
      prefix: "--warn-unused-ignores"
  - id: no_warn_no_return
    type:
      - 'null'
      - boolean
    doc: "Do not warn about functions that end without returning"
    inputBinding:
      position: 102
      prefix: "--no-warn-no-return"
  - id: warn_return_any
    type:
      - 'null'
      - boolean
    doc: "Warn about returning values of type Any from non-Any typed functions"
    inputBinding:
      position: 102
      prefix: "--warn-return-any"
  - id: allow_untyped_globals
    type:
      - 'null'
      - boolean
    doc: "Suppress toplevel errors caused by missing annotations"
    inputBinding:
      position: 102
      prefix: "--allow-untyped-globals"
  - id: allow_redefinition
    type:
      - 'null'
      - boolean
    doc: "Allow unconditional variable redefinition with a new type"
    inputBinding:
      position: 102
      prefix: "--allow-redefinition"
  - id: strict
    type:
      - 'null'
      - boolean
    doc: "Strict mode; enables several additional checks"
    inputBinding:
      position: 102
      prefix: "--strict"
  - id: no_incremental
    type:
      - 'null'
      - boolean
    doc: "Disable module cache"
    inputBinding:
      position: 102
      prefix: "--no-incremental"
  - id: cache_dir
    type:
      - 'null'
      - string
    doc: "Store module cache info in the given folder in incremental mode (defaults to '.mypy_cache')"
    inputBinding:
      position: 102
      prefix: "--cache-dir"
  - id: show_traceback
    type:
      - 'null'
      - boolean
    doc: "Show traceback on fatal error"
    inputBinding:
      position: 102
      prefix: "--show-traceback"
  - id: show_error_context
    type:
      - 'null'
      - boolean
    doc: "Precede errors with \"note:\" messages explaining context"
    inputBinding:
      position: 102
      prefix: "--show-error-context"
  - id: show_column_numbers
    type:
      - 'null'
      - boolean
    doc: "Show column numbers in error messages"
    inputBinding:
      position: 102
      prefix: "--show-column-numbers"
  - id: scripts_are_modules
    type:
      - 'null'
      - boolean
    doc: "Script x becomes module x instead of __main__"
    inputBinding:
      position: 102
      prefix: "--scripts-are-modules"
  - id: module
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: "--module"
    doc: "Type-check module; can repeat for more modules"
    inputBinding:
      position: 102
  - id: package
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: "--package"
    doc: "Type-check package recursively; can be repeated"
    inputBinding:
      position: 102
  - id: command
    type:
      - 'null'
      - string
    doc: "Type-check program passed in as string"
    inputBinding:
      position: 102
      prefix: "--command"
  - id: txt_report
    type:
      - 'null'
      - string
    doc: Generate a text report in the given folder
    inputBinding:
      position: 102
      prefix: --txt-report
  - id: junit_xml
    type:
      - 'null'
      - string
    doc: Write junit.xml to the given file
    inputBinding:
      position: 102
      prefix: --junit-xml
outputs:
  - id: stdout
    type: stdout
    doc: Type-check messages
  - id: txt_report_dir
    type:
      - 'null'
      - Directory
    doc: Text report folder
    outputBinding:
      glob: $(inputs.txt_report)
  - id: junit_xml_file
    type:
      - 'null'
      - File
    doc: junit.xml report
    outputBinding:
      glob: $(inputs.junit_xml)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mypy:v0.670-2-deb-py3_cv1
stdout: mypy.out
successCodes:
  - 0
  - 1
