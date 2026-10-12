cwlVersion: v1.2
class: CommandLineTool
label: pandoc
doc: "Pandoc is a Haskell library for converting from one markup format to another,
  and a command-line tool that uses this library. The image entrypoint is pandoc, so
  there is no baseCommand.\n\nTool homepage: https://github.com/jgm/pandoc"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files to be converted. If no files are specified, input is read from stdin.
    inputBinding:
      position: 1
  - id: from
    type:
      - 'null'
      - string
    doc: "Specify input format (for example markdown, gfm, docx, html, latex, rst)."
    inputBinding:
      position: 102
      prefix: --from
  - id: to
    type:
      - 'null'
      - string
    doc: "Specify output format (for example html5, docx, pdf, latex, plain, epub)."
    inputBinding:
      position: 102
      prefix: --to
  - id: output_path
    type:
      - 'null'
      - string
    doc: "Write output to FILE instead of stdout."
    inputBinding:
      position: 102
      prefix: --output
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: "Specify the user data directory to search for pandoc data files."
    inputBinding:
      position: 102
      prefix: --data-dir
  - id: metadata
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --metadata
    doc: "Set the metadata field KEY to the value VALUE (KEY[=VALUE]). Can be repeated."
    inputBinding:
      position: 102
  - id: metadata_file
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --metadata-file
    doc: "Read metadata from a YAML or JSON file. Can be repeated."
    inputBinding:
      position: 102
  - id: defaults
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --defaults
    doc: "Read default options from a YAML or JSON defaults file. Can be repeated."
    inputBinding:
      position: 102
  - id: file_scope
    type:
      - 'null'
      - boolean
    doc: "Parse each file individually before combining."
    inputBinding:
      position: 102
      prefix: --file-scope
  - id: sandbox
    type:
      - 'null'
      - boolean
    doc: "Run pandoc in a sandbox, limiting IO operations in readers and writers to reading the files specified on the command line."
    inputBinding:
      position: 102
      prefix: --sandbox
  - id: standalone
    type:
      - 'null'
      - boolean
    doc: "Produce output with an appropriate header and footer."
    inputBinding:
      position: 102
      prefix: --standalone
  - id: template
    type:
      - 'null'
      - File
    doc: "Use FILE as a custom template for the generated document."
    inputBinding:
      position: 102
      prefix: --template
  - id: variable
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --variable
    doc: "Set the template variable KEY to VALUE (KEY[=VALUE]). Can be repeated."
    inputBinding:
      position: 102
  - id: variable_json
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --variable-json
    doc: "Set the template variable KEY to the JSON value (KEY[:JSON]). Can be repeated."
    inputBinding:
      position: 102
  - id: wrap
    type:
      - 'null'
      - string
    doc: "Text wrapping: auto, none or preserve."
    inputBinding:
      position: 102
      prefix: --wrap
  - id: ascii
    type:
      - 'null'
      - boolean
    doc: "Use only ASCII characters in output."
    inputBinding:
      position: 102
      prefix: --ascii
  - id: table_of_contents
    type:
      - 'null'
      - boolean
    doc: "Include an automatically generated table of contents."
    inputBinding:
      position: 102
      prefix: --toc
  - id: toc_depth
    type:
      - 'null'
      - int
    doc: "Specify the number of section levels to include in the table of contents."
    inputBinding:
      position: 102
      prefix: --toc-depth
  - id: list_of_figures
    type:
      - 'null'
      - boolean
    doc: "Include an automatically generated list of figures."
    inputBinding:
      position: 102
      prefix: --lof
  - id: list_of_tables
    type:
      - 'null'
      - boolean
    doc: "Include an automatically generated list of tables."
    inputBinding:
      position: 102
      prefix: --lot
  - id: number_sections
    type:
      - 'null'
      - boolean
    doc: "Number section headings in LaTeX, ConTeXt, HTML, or EPUB output."
    inputBinding:
      position: 102
      prefix: --number-sections
  - id: number_offset
    type:
      - 'null'
      - string
    doc: "Offsets for section heading numbers, as comma-separated numbers (for example 1,0)."
    inputBinding:
      position: 102
      prefix: --number-offset
  - id: top_level_division
    type:
      - 'null'
      - string
    doc: "Treat top-level headings as section, chapter or part."
    inputBinding:
      position: 102
      prefix: --top-level-division
  - id: extract_media
    type:
      - 'null'
      - string
    doc: "Extract images and other media contained in or linked from the source document to this path."
    inputBinding:
      position: 102
      prefix: --extract-media
  - id: resource_path
    type:
      - 'null'
      - string
    doc: "List of paths to search for images and other resources."
    inputBinding:
      position: 102
      prefix: --resource-path
  - id: include_in_header
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --include-in-header
    doc: "Include the contents of FILE at the end of the header. Can be repeated."
    inputBinding:
      position: 102
  - id: include_before_body
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --include-before-body
    doc: "Include the contents of FILE at the beginning of the document body. Can be repeated."
    inputBinding:
      position: 102
  - id: include_after_body
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --include-after-body
    doc: "Include the contents of FILE at the end of the document body. Can be repeated."
    inputBinding:
      position: 102
  - id: no_highlight
    type:
      - 'null'
      - boolean
    doc: "Disable syntax highlighting for code blocks and inlines."
    inputBinding:
      position: 102
      prefix: --no-highlight
  - id: highlight_style
    type:
      - 'null'
      - string
    doc: "Specify the coloring style to be used in highlighted source code (a style name or a theme file)."
    inputBinding:
      position: 102
      prefix: --highlight-style
  - id: syntax_definition
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --syntax-definition
    doc: "Load a KDE XML syntax definition file. Can be repeated."
    inputBinding:
      position: 102
  - id: syntax_highlighting
    type:
      - 'null'
      - string
    doc: "Syntax highlighting method: none, default, idiomatic, a style name or a theme path."
    inputBinding:
      position: 102
      prefix: --syntax-highlighting
  - id: dpi
    type:
      - 'null'
      - int
    doc: "Specify the default dpi (dots per inch) value for conversion from pixels to inch/centimeters and vice versa."
    inputBinding:
      position: 102
      prefix: --dpi
  - id: eol
    type:
      - 'null'
      - string
    doc: "Line endings in output: crlf, lf or native."
    inputBinding:
      position: 102
      prefix: --eol
  - id: columns
    type:
      - 'null'
      - int
    doc: "Length of lines in characters (for text wrapping)."
    inputBinding:
      position: 102
      prefix: --columns
  - id: preserve_tabs
    type:
      - 'null'
      - boolean
    doc: "Preserve tabs instead of converting them to spaces."
    inputBinding:
      position: 102
      prefix: --preserve-tabs
  - id: tab_stop
    type:
      - 'null'
      - int
    doc: "Specify the number of spaces per tab (default is 4)."
    inputBinding:
      position: 102
      prefix: --tab-stop
  - id: pdf_engine
    type:
      - 'null'
      - string
    doc: "Use the specified engine when producing PDF output (for example pdflatex, xelatex, lualatex, wkhtmltopdf, typst)."
    inputBinding:
      position: 102
      prefix: --pdf-engine
  - id: pdf_engine_opt
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --pdf-engine-opt
    doc: "Use the given string as a command-line argument to the PDF engine. Can be repeated."
    inputBinding:
      position: 102
  - id: reference_doc
    type:
      - 'null'
      - File
    doc: "Use the specified file as a style reference in producing a docx, ODT or pptx file."
    inputBinding:
      position: 102
      prefix: --reference-doc
  - id: self_contained
    type:
      - 'null'
      - boolean
    doc: "Produce a standalone HTML file with no external dependencies (deprecated, use embed_resources)."
    inputBinding:
      position: 102
      prefix: --self-contained
  - id: embed_resources
    type:
      - 'null'
      - boolean
    doc: "Produce a standalone HTML file with no external dependencies, using data: URIs to incorporate scripts, stylesheets, images and videos."
    inputBinding:
      position: 102
      prefix: --embed-resources
  - id: link_images
    type:
      - 'null'
      - boolean
    doc: "Link images in ODT output instead of embedding them."
    inputBinding:
      position: 102
      prefix: --link-images
  - id: request_header
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --request-header
    doc: "Set the request header NAME to the value VALUE when fetching resources from the web (NAME=VALUE). Can be repeated."
    inputBinding:
      position: 102
  - id: no_check_certificate
    type:
      - 'null'
      - boolean
    doc: "Disable the certificate verification to allow access to unsecure HTTP resources."
    inputBinding:
      position: 102
      prefix: --no-check-certificate
  - id: abbreviations
    type:
      - 'null'
      - File
    doc: "Specify a file with a list of abbreviations, one per line."
    inputBinding:
      position: 102
      prefix: --abbreviations
  - id: typst_input
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --typst-input
    doc: "Set a Typst input KEY=VALUE. Can be repeated."
    inputBinding:
      position: 102
  - id: indented_code_classes
    type:
      - 'null'
      - string
    doc: "Specify classes to use for indented code blocks (a comma-separated list)."
    inputBinding:
      position: 102
      prefix: --indented-code-classes
  - id: default_image_extension
    type:
      - 'null'
      - string
    doc: "Specify a default extension to use when image paths have no extension."
    inputBinding:
      position: 102
      prefix: --default-image-extension
  - id: filter
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --filter
    doc: "Specify an executable to be used as a filter transforming the pandoc AST. Can be repeated."
    inputBinding:
      position: 102
  - id: lua_filter
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --lua-filter
    doc: "Transform the document in a similar fashion as JSON filters, but use pandoc built-in Lua filtering. Can be repeated."
    inputBinding:
      position: 102
  - id: shift_heading_level_by
    type:
      - 'null'
      - int
    doc: "Shift heading levels by a positive or negative integer."
    inputBinding:
      position: 102
      prefix: --shift-heading-level-by
  - id: base_header_level
    type:
      - 'null'
      - int
    doc: "Specify the base level for headings (default 1)."
    inputBinding:
      position: 102
      prefix: --base-header-level
  - id: track_changes
    type:
      - 'null'
      - string
    doc: "How to handle insertions and deletions from Microsoft Word track changes: accept, reject or all."
    inputBinding:
      position: 102
      prefix: --track-changes
  - id: strip_comments
    type:
      - 'null'
      - boolean
    doc: "Strip out HTML comments in the Markdown or Textile source."
    inputBinding:
      position: 102
      prefix: --strip-comments
  - id: reference_links
    type:
      - 'null'
      - boolean
    doc: "Use reference-style links, rather than inline links, in writing Markdown or reStructuredText."
    inputBinding:
      position: 102
      prefix: --reference-links
  - id: reference_location
    type:
      - 'null'
      - string
    doc: "Where to put footnotes and references in Markdown output: block, section or document."
    inputBinding:
      position: 102
      prefix: --reference-location
  - id: figure_caption_position
    type:
      - 'null'
      - string
    doc: "Position of figure captions: above or below."
    inputBinding:
      position: 102
      prefix: --figure-caption-position
  - id: table_caption_position
    type:
      - 'null'
      - string
    doc: "Position of table captions: above or below."
    inputBinding:
      position: 102
      prefix: --table-caption-position
  - id: markdown_headings
    type:
      - 'null'
      - string
    doc: "Heading style in Markdown output: setext or atx."
    inputBinding:
      position: 102
      prefix: --markdown-headings
  - id: list_tables
    type:
      - 'null'
      - boolean
    doc: "Render tables as list tables in RST output."
    inputBinding:
      position: 102
      prefix: --list-tables
  - id: listings
    type:
      - 'null'
      - boolean
    doc: "Use the listings package for LaTeX code blocks."
    inputBinding:
      position: 102
      prefix: --listings
  - id: incremental
    type:
      - 'null'
      - boolean
    doc: "Make list items in slide shows display incrementally."
    inputBinding:
      position: 102
      prefix: --incremental
  - id: slide_level
    type:
      - 'null'
      - int
    doc: "Specify the heading level that defines slides in a slide show."
    inputBinding:
      position: 102
      prefix: --slide-level
  - id: section_divs
    type:
      - 'null'
      - boolean
    doc: "Wrap sections in section tags (or div tags for HTML4) and attach identifiers to the enclosing tags."
    inputBinding:
      position: 102
      prefix: --section-divs
  - id: html_q_tags
    type:
      - 'null'
      - boolean
    doc: "Use q tags for quotes in HTML."
    inputBinding:
      position: 102
      prefix: --html-q-tags
  - id: email_obfuscation
    type:
      - 'null'
      - string
    doc: "Method for obfuscating mailto links in HTML: none, javascript or references."
    inputBinding:
      position: 102
      prefix: --email-obfuscation
  - id: id_prefix
    type:
      - 'null'
      - string
    doc: "Specify a prefix to be added to all identifiers and internal links in HTML and DocBook output."
    inputBinding:
      position: 102
      prefix: --id-prefix
  - id: title_prefix
    type:
      - 'null'
      - string
    doc: "Specify STRING as a prefix at the beginning of the title that appears in the HTML header."
    inputBinding:
      position: 102
      prefix: --title-prefix
  - id: css
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --css
    doc: "Link to a CSS style sheet (URL). Can be repeated."
    inputBinding:
      position: 102
  - id: epub_subdirectory
    type:
      - 'null'
      - string
    doc: "Specify the subdirectory in the OCF container that holds the EPUB-specific contents."
    inputBinding:
      position: 102
      prefix: --epub-subdirectory
  - id: epub_cover_image
    type:
      - 'null'
      - File
    doc: "Use the specified image as the EPUB cover."
    inputBinding:
      position: 102
      prefix: --epub-cover-image
  - id: epub_title_page
    type:
      - 'null'
      - boolean
    doc: "Include a title page in EPUB output."
    inputBinding:
      position: 102
      prefix: --epub-title-page
  - id: epub_metadata
    type:
      - 'null'
      - File
    doc: "Look in the specified XML file for metadata for the EPUB."
    inputBinding:
      position: 102
      prefix: --epub-metadata
  - id: epub_embed_font
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --epub-embed-font
    doc: "Embed the specified font in the EPUB. Can be repeated."
    inputBinding:
      position: 102
  - id: split_level
    type:
      - 'null'
      - int
    doc: "Specify the heading level at which to split an EPUB or chunked HTML document into separate files."
    inputBinding:
      position: 102
      prefix: --split-level
  - id: chunk_template
    type:
      - 'null'
      - string
    doc: "Specify a template for the filenames in a chunkedhtml document."
    inputBinding:
      position: 102
      prefix: --chunk-template
  - id: epub_chapter_level
    type:
      - 'null'
      - int
    doc: "Deprecated synonym for split_level."
    inputBinding:
      position: 102
      prefix: --epub-chapter-level
  - id: ipynb_output
    type:
      - 'null'
      - string
    doc: "Determine how ipynb output cells are treated: all, none or best."
    inputBinding:
      position: 102
      prefix: --ipynb-output
  - id: citeproc
    type:
      - 'null'
      - boolean
    doc: "Process the citations in the file, replacing them with rendered citations and adding a bibliography."
    inputBinding:
      position: 102
      prefix: --citeproc
  - id: bibliography
    type:
      - 'null'
      - type: array
        items: File
        inputBinding:
          prefix: --bibliography
    doc: "Set the bibliography field in the document metadata. Can be repeated."
    inputBinding:
      position: 102
  - id: csl
    type:
      - 'null'
      - File
    doc: "Set the csl field in the document metadata to a citation style language file."
    inputBinding:
      position: 102
      prefix: --csl
  - id: citation_abbreviations
    type:
      - 'null'
      - File
    doc: "Set the citation-abbreviations field in the document metadata."
    inputBinding:
      position: 102
      prefix: --citation-abbreviations
  - id: natbib
    type:
      - 'null'
      - boolean
    doc: "Use natbib for citations in LaTeX output."
    inputBinding:
      position: 102
      prefix: --natbib
  - id: biblatex
    type:
      - 'null'
      - boolean
    doc: "Use biblatex for citations in LaTeX output."
    inputBinding:
      position: 102
      prefix: --biblatex
  - id: mathml
    type:
      - 'null'
      - boolean
    doc: "Convert TeX math to MathML."
    inputBinding:
      position: 102
      prefix: --mathml
  - id: webtex
    type:
      - 'null'
      - string
    doc: "Convert TeX formulas to image tags linked to an external converter, with an optional URL (joined as --webtex=URL)."
    inputBinding:
      position: 102
      prefix: --webtex=
      separate: false
  - id: mathjax
    type:
      - 'null'
      - string
    doc: "Use MathJax to display embedded TeX math in HTML output, with an optional URL (joined as --mathjax=URL)."
    inputBinding:
      position: 102
      prefix: --mathjax=
      separate: false
  - id: katex
    type:
      - 'null'
      - string
    doc: "Use KaTeX to display embedded TeX math in HTML output, with an optional URL (joined as --katex=URL)."
    inputBinding:
      position: 102
      prefix: --katex=
      separate: false
  - id: gladtex
    type:
      - 'null'
      - boolean
    doc: "Enclose TeX math in span tags for later processing by GladTeX."
    inputBinding:
      position: 102
      prefix: --gladtex
  - id: trace
    type:
      - 'null'
      - boolean
    doc: "Enable tracing output."
    inputBinding:
      position: 102
      prefix: --trace
  - id: dump_args
    type:
      - 'null'
      - boolean
    doc: "Print information about command-line arguments to stdout, then exit."
    inputBinding:
      position: 102
      prefix: --dump-args
  - id: ignore_args
    type:
      - 'null'
      - boolean
    doc: "Ignore command-line arguments (for use in wrapper scripts)."
    inputBinding:
      position: 102
      prefix: --ignore-args
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Give verbose debugging output."
    inputBinding:
      position: 102
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress warning messages."
    inputBinding:
      position: 102
      prefix: --quiet
  - id: fail_if_warnings
    type:
      - 'null'
      - boolean
    doc: "Exit with error status if there are any warnings."
    inputBinding:
      position: 102
      prefix: --fail-if-warnings
  - id: log
    type:
      - 'null'
      - string
    doc: "Write log messages in machine-readable JSON format to FILE."
    inputBinding:
      position: 102
      prefix: --log
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file written with --output.
    outputBinding:
      glob: $(inputs.output_path)
  - id: extracted_media
    type:
      - 'null'
      - Directory
    doc: Directory with the media extracted with --extract-media.
    outputBinding:
      glob: $(inputs.extract_media)
  - id: log_file
    type:
      - 'null'
      - File
    doc: JSON log written with --log.
    outputBinding:
      glob: $(inputs.log)
  - id: stdout
    type: stdout
    doc: Converted text when no output file is given.
hints:
  - class: DockerRequirement
    dockerPull: pandoc/latex:latest-ubuntu
stdout: pandoc.out
