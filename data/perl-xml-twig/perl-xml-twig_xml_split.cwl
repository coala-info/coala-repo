cwlVersion: v1.2
class: CommandLineTool
baseCommand: xml_split
label: perl-xml-twig_xml_split
doc: "Split an XML file into several smaller files\n\nTool homepage: http://metacpan.org/pod/XML-Twig"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: XML files to split
    inputBinding:
      position: 200
  - id: base
    type:
      - 'null'
      - string
    doc: Base name for the output, files are named BASE-NN.ext
    inputBinding:
      position: 102
      prefix: -b
  - id: cond
    type:
      - 'null'
      - string
    doc: Generate a file for each element that passes the condition (XPath-like,
      for example section)
    inputBinding:
      position: 102
      prefix: -c
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug mode
    inputBinding:
      position: 102
      prefix: -d
  - id: ext
    type:
      - 'null'
      - string
    doc: Extension to use for generated files
    inputBinding:
      position: 102
      prefix: -e
  - id: in_place
    type:
      - 'null'
      - boolean
    doc: Use XInclude elements instead of processing instructions to mark where
      sub files need to be included
    inputBinding:
      position: 102
      prefix: -i
  - id: level
    type:
      - 'null'
      - int
    doc: Level to cut at; 1 generates a file for each child of the root, 2 for
      each grand child (default 1)
    inputBinding:
      position: 102
      prefix: -l
  - id: nb
    type:
      - 'null'
      - int
    doc: Number of digits in the split file names
    inputBinding:
      position: 102
      prefix: -n
  - id: nb_grouped
    type:
      - 'null'
      - int
    doc: Group this many elements in a single file; used with -l
    inputBinding:
      position: 102
      prefix: -g
  - id: plugin
    type:
      - 'null'
      - string
    doc: Plugin to use for splitting
    inputBinding:
      position: 102
      prefix: -p
  - id: plugin_dir
    type:
      - 'null'
      - Directory
    doc: Directory where plugins are located
    inputBinding:
      position: 102
      prefix: -I
  - id: size
    type:
      - 'null'
      - string
    doc: Generate files of approximately this size (bytes, Kb, Mb or Gb); used
      with -l
    inputBinding:
      position: 102
      prefix: -s
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: split_files
    type:
      type: array
      items: File
    doc: Generated files BASE-NN.ext; NN = 00 holds the main document
    outputBinding:
      glob: '*-[0-9]*'
requirements:
  - class: InitialWorkDirRequirement
    listing: $(inputs.files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-xml-twig:3.52--pl526_1
stdout: perl-xml-twig_xml_split.out
