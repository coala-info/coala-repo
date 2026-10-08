cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - epydoc
label: epydoc_pdf
doc: "Write LaTeX API documentation and convert it to PDF (api.pdf) in an output directory. Needs latex, makeindex, dvips and ps2pdf.\n\nTool homepage: https://github.com/nltk/epydoc"
arguments:
  - position: 0
    valueFrom: --pdf
inputs:
  - id: names
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: Python module files (.py) or package directories to document.
    inputBinding:
      position: 10
  - id: module_names
    type:
      - 'null'
      - type: array
        items: string
    doc: Dotted names of importable Python modules, packages or objects to document.
    inputBinding:
      position: 11
  - id: config
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --config
    doc: 'A configuration file, specifying additional OPTIONS and/or NAMES. This option may be repeated.'
    inputBinding:
      position: 1
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: 'Decrease the verbosity.'
    inputBinding:
      position: 1
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Increase the verbosity.'
    inputBinding:
      position: 1
      prefix: --verbose
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Show full tracebacks for internal errors.'
    inputBinding:
      position: 1
      prefix: --debug
  - id: simple_term
    type:
      - 'null'
      - boolean
    doc: 'Do not try to use color or cursor control when displaying the progress bar, warnings, or errors.'
    inputBinding:
      position: 1
      prefix: --simple-term
  - id: docformat
    type:
      - 'null'
      - string
    doc: 'The default markup language for docstrings. Defaults to "epytext".'
    inputBinding:
      position: 1
      prefix: --docformat
  - id: parse_only
    type:
      - 'null'
      - boolean
    doc: 'Get all information from parsing (don''t introspect).'
    inputBinding:
      position: 1
      prefix: --parse-only
  - id: introspect_only
    type:
      - 'null'
      - boolean
    doc: 'Get all information from introspecting (don''t parse).'
    inputBinding:
      position: 1
      prefix: --introspect-only
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude
    doc: 'Exclude modules whose dotted name matches the regular expression PATTERN.'
    inputBinding:
      position: 1
  - id: exclude_introspect
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude-introspect
    doc: 'Exclude introspection of modules whose dotted name matches the regular expression PATTERN.'
    inputBinding:
      position: 1
  - id: exclude_parse
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --exclude-parse
    doc: 'Exclude parsing of modules whose dotted name matches the regular expression PATTERN.'
    inputBinding:
      position: 1
  - id: inheritance
    type:
      - 'null'
      - string
    doc: 'The format for showing inheritance objects. STYLE should be one of: grouped, listed, included.'
    inputBinding:
      position: 1
      prefix: --inheritance
  - id: show_private
    type:
      - 'null'
      - boolean
    doc: 'Include private variables in the output. (default)'
    inputBinding:
      position: 1
      prefix: --show-private
  - id: no_private
    type:
      - 'null'
      - boolean
    doc: 'Do not include private variables in the output.'
    inputBinding:
      position: 1
      prefix: --no-private
  - id: show_imports
    type:
      - 'null'
      - boolean
    doc: 'List each module''s imports.'
    inputBinding:
      position: 1
      prefix: --show-imports
  - id: no_imports
    type:
      - 'null'
      - boolean
    doc: 'Do not list each module''s imports. (default)'
    inputBinding:
      position: 1
      prefix: --no-imports
  - id: redundant_details
    type:
      - 'null'
      - boolean
    doc: 'Include values in the details lists even if all info about them is already provided by the summary table.'
    inputBinding:
      position: 1
      prefix: --redundant-details
  - id: fail_on_error
    type:
      - 'null'
      - boolean
    doc: 'Return a non-zero exit status, indicating failure, if any errors are encountered.'
    inputBinding:
      position: 1
      prefix: --fail-on-error
  - id: fail_on_warning
    type:
      - 'null'
      - boolean
    doc: 'Return a non-zero exit status if any errors or warnings are encountered (not including docstring warnings).'
    inputBinding:
      position: 1
      prefix: --fail-on-warning
  - id: fail_on_docstring_warning
    type:
      - 'null'
      - boolean
    doc: 'Return a non-zero exit status if any errors or warnings are encountered (including docstring warnings).'
    inputBinding:
      position: 1
      prefix: --fail-on-docstring-warning
  - id: project_name
    type:
      - 'null'
      - string
    doc: 'The documented project''s name (for the navigation bar).'
    inputBinding:
      position: 1
      prefix: --name
  - id: graph
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --graph
    doc: 'Include graphs of type GRAPHTYPE in the generated output (all, classtree, callgraph, umlclasstree). Needs the Graphviz dot executable. May be repeated.'
    inputBinding:
      position: 1
  - id: dotpath
    type:
      - 'null'
      - File
    doc: 'The path to the Graphviz ''dot'' executable.'
    inputBinding:
      position: 1
      prefix: --dotpath
  - id: graph_font
    type:
      - 'null'
      - string
    doc: 'Specify the font used to generate Graphviz graphs (e.g., helvetica or times).'
    inputBinding:
      position: 1
      prefix: --graph-font
  - id: graph_font_size
    type:
      - 'null'
      - int
    doc: 'Specify the font size used to generate Graphviz graphs, in points.'
    inputBinding:
      position: 1
      prefix: --graph-font-size
  - id: pstat
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --pstat
    doc: 'A pstat output file, to be used in generating call graphs.'
    inputBinding:
      position: 1
  - id: separate_classes
    type:
      - 'null'
      - boolean
    doc: 'List each class in its own section, instead of listing them under their containing module.'
    inputBinding:
      position: 1
      prefix: --separate-classes
  - id: external_api
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --external-api
    doc: 'Define a new API document. A new interpreted text role NAME will be added.'
    inputBinding:
      position: 1
  - id: external_api_file
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --external-api-file
    doc: 'Use records in FILENAME (NAME:FILENAME) to resolve objects in the API named NAME.'
    inputBinding:
      position: 1
  - id: external_api_root
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --external-api-root
    doc: 'Use STRING (NAME:STRING) as prefix for the URL generated from the API NAME.'
    inputBinding:
      position: 1
  - id: output_dir
    type: string
    default: pdf
    doc: The output directory. If PATH does not exist, then it will be created.
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: out_dir
    type: Directory
    doc: The output directory with the generated documentation.
    outputBinding:
      glob: $(inputs.output_dir)
  - id: api_pdf
    type: File
    doc: The compiled document (api.pdf).
    outputBinding:
      glob: $(inputs.output_dir)/api.pdf
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epydoc:3.0.1--py27_0
