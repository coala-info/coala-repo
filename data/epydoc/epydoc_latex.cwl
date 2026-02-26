cwlVersion: v1.2
class: CommandLineTool
baseCommand: epydoc
label: epydoc_latex
doc: "epydoc\n\nTool homepage: https://github.com/nltk/epydoc"
inputs:
  - id: action
    type:
      - 'null'
      - string
    doc: Action to perform
    inputBinding:
      position: 1
  - id: names
    type:
      type: array
      items: string
    doc: Names to document
    inputBinding:
      position: 2
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check completeness of docs.
    inputBinding:
      position: 103
      prefix: --check
  - id: config
    type:
      - 'null'
      - type: array
        items: File
    doc: A configuration file, specifying additional OPTIONS and/or NAMES.
    inputBinding:
      position: 103
      prefix: --config
  - id: css_stylesheet
    type:
      - 'null'
      - string
    doc: The CSS stylesheet. STYLESHEET can be either a builtin stylesheet or 
      the name of a CSS file.
    inputBinding:
      position: 103
      prefix: --css
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Show full tracebacks for internal errors.
    inputBinding:
      position: 103
      prefix: --debug
  - id: docformat
    type:
      - 'null'
      - string
    doc: The default markup language for docstrings.
    default: epytext
    inputBinding:
      position: 103
      prefix: --docformat
  - id: dotpath
    type:
      - 'null'
      - File
    doc: The path to the Graphviz 'dot' executable.
    inputBinding:
      position: 103
      prefix: --dotpath
  - id: dvi
    type:
      - 'null'
      - boolean
    doc: Write DVI output.
    inputBinding:
      position: 103
      prefix: --dvi
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude modules whose dotted name matches the regular expression 
      PATTERN
    inputBinding:
      position: 103
      prefix: --exclude
  - id: exclude_introspect
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude introspection of modules whose dotted name matches the regular 
      expression PATTERN
    inputBinding:
      position: 103
      prefix: --exclude-introspect
  - id: exclude_parse
    type:
      - 'null'
      - type: array
        items: string
    doc: Exclude parsing of modules whose dotted name matches the regular 
      expression PATTERN
    inputBinding:
      position: 103
      prefix: --exclude-parse
  - id: external_api
    type:
      - 'null'
      - type: array
        items: string
    doc: Define a new API document. A new interpreted text role NAME will be 
      added.
    inputBinding:
      position: 103
      prefix: --external-api
  - id: external_api_file
    type:
      - 'null'
      - type: array
        items: string
    doc: Use records in FILENAME to resolve objects in the API named NAME.
    inputBinding:
      position: 103
      prefix: --external-api-file
  - id: external_api_root
    type:
      - 'null'
      - type: array
        items: string
    doc: Use STRING as prefix for the URL generated from the API NAME.
    inputBinding:
      position: 103
      prefix: --external-api-root
  - id: fail_on_docstring_warning
    type:
      - 'null'
      - boolean
    doc: Return a non-zero exit status, indicating failure, if any errors or 
      warnings are encountered (including docstring warnings).
    inputBinding:
      position: 103
      prefix: --fail-on-docstring-warning
  - id: fail_on_error
    type:
      - 'null'
      - boolean
    doc: Return a non-zero exit status, indicating failure, if any errors are 
      encountered.
    inputBinding:
      position: 103
      prefix: --fail-on-error
  - id: fail_on_warning
    type:
      - 'null'
      - boolean
    doc: Return a non-zero exit status, indicating failure, if any errors or 
      warnings are encountered (not including docstring warnings).
    inputBinding:
      position: 103
      prefix: --fail-on-warning
  - id: graph
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Include graphs of type GRAPHTYPE in the generated output. Graphs are generated
      using the Graphviz dot executable. If this executable is not on the path, then
      use --dotpath to specify its location. This option may be repeated to include
      multiple graph types in the output. GRAPHTYPE should be one of: all, classtree,
      callgraph, umlclasstree.'
    inputBinding:
      position: 103
      prefix: --graph
  - id: graph_font
    type:
      - 'null'
      - string
    doc: Specify the font used to generate Graphviz graphs. (e.g., helvetica or 
      times).
    inputBinding:
      position: 103
      prefix: --graph-font
  - id: graph_font_size
    type:
      - 'null'
      - int
    doc: Specify the font size used to generate Graphviz graphs, in points.
    inputBinding:
      position: 103
      prefix: --graph-font-size
  - id: help_file
    type:
      - 'null'
      - File
    doc: An alternate help file. FILE should contain the body of an HTML file --
      navigation bars will be added to it.
    inputBinding:
      position: 103
      prefix: --help-file
  - id: html
    type:
      - 'null'
      - boolean
    doc: Write HTML output.
    inputBinding:
      position: 103
      prefix: --html
  - id: include_log
    type:
      - 'null'
      - boolean
    doc: Include a page with the process log (epydoc-log.html)
    inputBinding:
      position: 103
      prefix: --include-log
  - id: inheritance
    type:
      - 'null'
      - string
    doc: 'The format for showing inheritance objects. STYLE should be one of: grouped,
      listed, included.'
    inputBinding:
      position: 103
      prefix: --inheritance
  - id: introspect_only
    type:
      - 'null'
      - boolean
    doc: Get all information from introspecting (don't parse)
    inputBinding:
      position: 103
      prefix: --introspect-only
  - id: latex
    type:
      - 'null'
      - boolean
    doc: Write LaTeX output.
    inputBinding:
      position: 103
      prefix: --latex
  - id: navlink_html
    type:
      - 'null'
      - string
    doc: HTML code for a navigation link to place in the navigation bar.
    inputBinding:
      position: 103
      prefix: --navlink
  - id: no_frames
    type:
      - 'null'
      - boolean
    doc: Do not include frames in the HTML output.
    inputBinding:
      position: 103
      prefix: --no-frames
  - id: no_imports
    type:
      - 'null'
      - boolean
    doc: Do not list each module's imports. (default)
    default: false
    inputBinding:
      position: 103
      prefix: --no-imports
  - id: no_private
    type:
      - 'null'
      - boolean
    doc: Do not include private variables in the output.
    inputBinding:
      position: 103
      prefix: --no-private
  - id: no_sourcecode
    type:
      - 'null'
      - boolean
    doc: Do not include source code with syntax highlighting in the HTML output.
    inputBinding:
      position: 103
      prefix: --no-sourcecode
  - id: parse_only
    type:
      - 'null'
      - boolean
    doc: Get all information from parsing (don't introspect)
    inputBinding:
      position: 103
      prefix: --parse-only
  - id: pdf
    type:
      - 'null'
      - boolean
    doc: Write PDF output.
    inputBinding:
      position: 103
      prefix: --pdf
  - id: pickle
    type:
      - 'null'
      - boolean
    doc: Write the documentation to a pickle file.
    inputBinding:
      position: 103
      prefix: --pickle
  - id: project_name
    type:
      - 'null'
      - string
    doc: The documented project's name (for the navigation bar).
    inputBinding:
      position: 103
      prefix: --name
  - id: project_url
    type:
      - 'null'
      - string
    doc: The documented project's URL (for the navigation bar).
    inputBinding:
      position: 103
      prefix: --url
  - id: ps
    type:
      - 'null'
      - boolean
    doc: Write Postscript output.
    inputBinding:
      position: 103
      prefix: --ps
  - id: pstat
    type:
      - 'null'
      - File
    doc: A pstat output file, to be used in generating call graphs.
    inputBinding:
      position: 103
      prefix: --pstat
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Decrease the verbosity.
    inputBinding:
      position: 103
      prefix: --quiet
  - id: redundant_details
    type:
      - 'null'
      - boolean
    doc: Include values in the details lists even if all info about them is 
      already provided by the summary table.
    inputBinding:
      position: 103
      prefix: --redundant-details
  - id: separate_classes
    type:
      - 'null'
      - boolean
    doc: When generating LaTeX or PDF output, list each class in its own 
      section, instead of listing them under their containing module.
    inputBinding:
      position: 103
      prefix: --separate-classes
  - id: show_frames
    type:
      - 'null'
      - boolean
    doc: Include frames in the HTML output. (default)
    default: true
    inputBinding:
      position: 103
      prefix: --show-frames
  - id: show_imports
    type:
      - 'null'
      - boolean
    doc: List each module's imports.
    inputBinding:
      position: 103
      prefix: --show-imports
  - id: show_private
    type:
      - 'null'
      - boolean
    doc: Include private variables in the output.
    default: true
    inputBinding:
      position: 103
      prefix: --show-private
  - id: show_sourcecode
    type:
      - 'null'
      - boolean
    doc: Include source code with syntax highlighting in the HTML output. 
      (default)
    default: true
    inputBinding:
      position: 103
      prefix: --show-sourcecode
  - id: simple_term
    type:
      - 'null'
      - boolean
    doc: Do not try to use color or cursor control when displaying the progress 
      bar, warnings, or errors.
    inputBinding:
      position: 103
      prefix: --simple-term
  - id: src_code_tab_width
    type:
      - 'null'
      - int
    doc: When generating HTML output, sets the number of spaces each tab in 
      source code listings is replaced with.
    inputBinding:
      position: 103
      prefix: --src-code-tab-width
  - id: text
    type:
      - 'null'
      - boolean
    doc: Write plaintext output. (not implemented yet)
    inputBinding:
      position: 103
      prefix: --text
  - id: top_page
    type:
      - 'null'
      - string
    doc: The "top" page for the HTML documentation. PAGE can be a URL, the name 
      of a module or class, or one of the special names "trees.html", 
      "indices.html", or "help.html"
    inputBinding:
      position: 103
      prefix: --top
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase the verbosity.
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_path
    type:
      - 'null'
      - Directory
    doc: The output directory. If PATH does not exist, then it will be created.
    outputBinding:
      glob: $(inputs.output_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epydoc:3.0.1--py27_0
