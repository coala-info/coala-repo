cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpancover
label: perl-devel-cover_cpancover
doc: "Report coverage statistics on CPAN modules: collect coverage for unpacked CPAN distributions and create HTML, CSV and JSON output.\n\nTool homepage: http://www.pjcj.net/perl.html"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: directory
    type: Directory
    doc: Location of the modules (unpacked distributions)
    inputBinding:
      prefix: -directory
  - id: modules
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -modules
    doc: Modules to use (default all in the directory)
    inputBinding:
      position: 1
  - id: collect
    type:
      - 'null'
      - boolean
    doc: Collect coverage from modules (on)
    inputBinding:
      prefix: -collect
  - id: dryrun
    type:
      - 'null'
      - boolean
    doc: Do not execute (for some commands)
    inputBinding:
      prefix: -dryrun
  - id: force
    type:
      - 'null'
      - boolean
    doc: Recollect coverage
    inputBinding:
      prefix: -force
  - id: outputdir
    type:
      - 'null'
      - string
    doc: Where to store the output (default the directory)
    inputBinding:
      prefix: -outputdir
  - id: outputfile
    type:
      - 'null'
      - string
    doc: Top level index file (default coverage.html)
    inputBinding:
      prefix: -outputfile
  - id: redo_cpancover_html
    type:
      - 'null'
      - boolean
    doc: Do not set default modules
    inputBinding:
      prefix: -redo_cpancover_html
  - id: redo_html
    type:
      - 'null'
      - boolean
    doc: Force HTML generation for modules
    inputBinding:
      prefix: -redo_html
  - id: report
    type:
      - 'null'
      - string
    doc: Report to use (default html_basic)
    inputBinding:
      prefix: -report
  - id: generate_html
    type:
      - 'null'
      - boolean
    doc: Generate HTML
    inputBinding:
      prefix: -generate_html
  - id: compress_old_versions
    type:
      - 'null'
      - int
    doc: Compress data older than this number of versions (default 3)
    inputBinding:
      prefix: -compress_old_versions
  - id: local
    type:
      - 'null'
      - boolean
    doc: Use local (uninstalled) code
    inputBinding:
      prefix: -local
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
stdout: cpancover.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-cover:1.33--pl526h14c3975_0
