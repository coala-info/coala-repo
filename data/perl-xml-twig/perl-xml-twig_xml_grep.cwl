cwlVersion: v1.2
class: CommandLineTool
baseCommand: xml_grep
label: perl-xml-twig_xml_grep
doc: "Search for and extract XML chunks from files using XPath-like expressions.\n
  \nTool homepage: http://metacpan.org/pod/XML-Twig"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: XML files to search
    inputBinding:
      position: 1
  - id: by_file
    type:
      - 'null'
      - boolean
    doc: output only <nb> results by file
    inputBinding:
      position: 102
      prefix: --by_file
  - id: cond
    type:
      - 'null'
      - type: array
        items: string
    doc: return the chunks (or file names) only if they contain elements matching
      <cond>. Several can be provided (OR'ed).
    inputBinding:
      position: 102
      prefix: --cond
  - id: count
    type:
      - 'null'
      - boolean
    doc: return only the number of matches in each file
    inputBinding:
      position: 102
      prefix: --count
  - id: date
    type:
      - 'null'
      - boolean
    doc: when on (by default) the wrapping element get a 'date' attribute that gives
      the date the tool was run.
    inputBinding:
      position: 102
      prefix: --date
  - id: descr
    type:
      - 'null'
      - string
    doc: attributes of the wrap tag
    inputBinding:
      position: 102
      prefix: --descr
  - id: encoding
    type:
      - 'null'
      - string
    doc: encoding of the xml output
    inputBinding:
      position: 102
      prefix: --encoding
  - id: exclude
    type:
      - 'null'
      - string
    doc: the elements that match the condition are excluded from the result
    inputBinding:
      position: 102
      prefix: --exclude
  - id: files_only
    type:
      - 'null'
      - boolean
    doc: return only file names (do not generate an XML output)
    inputBinding:
      position: 102
      prefix: --files
  - id: group_by_file
    type:
      - 'null'
      - string
    doc: wrap results for each files into a separate element (default name 'file').
    inputBinding:
      position: 102
      prefix: --group_by_file
  - id: html
    type:
      - 'null'
      - boolean
    doc: Allow HTML input, files are converted using HTML::TreeBuilder
    inputBinding:
      position: 102
      prefix: --html
  - id: nb_results
    type:
      - 'null'
      - int
    doc: output only <nb> results
    inputBinding:
      position: 102
      prefix: --nb_results
  - id: nowrap
    type:
      - 'null'
      - boolean
    doc: the xml result is not wrapped.
    inputBinding:
      position: 102
      prefix: --nowrap
  - id: pretty_print
    type:
      - 'null'
      - string
    doc: pretty print the output using XML::Twig styles ('indented', 'record' or 'record_c')
    inputBinding:
      position: 102
      prefix: --pretty_print
  - id: root
    type:
      - 'null'
      - type: array
        items: string
    doc: look for and return xml chunks matching <cond>. Several can be provided.
    inputBinding:
      position: 102
      prefix: --root
  - id: strict
    type:
      - 'null'
      - boolean
    doc: without this option parsing errors are reported to STDOUT and the file skipped
    inputBinding:
      position: 102
      prefix: --strict
  - id: text_only
    type:
      - 'null'
      - boolean
    doc: Displays the text of the results, one by line.
    inputBinding:
      position: 102
      prefix: --text_only
  - id: tidy
    type:
      - 'null'
      - boolean
    doc: Allow HTML input, files are converted using HTML::Tidy
    inputBinding:
      position: 102
      prefix: --Tidy
  - id: wrap
    type:
      - 'null'
      - string
    doc: wrap the xml result in the provided tag
    inputBinding:
      position: 102
      prefix: --wrap
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-twig:3.52--pl526_1
stdout: perl-xml-twig_xml_grep.out
