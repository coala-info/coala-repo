cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcov2perl
label: perl-devel-cover_gcov2perl
doc: "Convert gcov files to Devel::Cover databases.\n\nTool homepage: http://www.pjcj.net/perl.html"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: database
    type: string
    doc: Name of the Devel::Cover database directory to write (default cover_db)
    inputBinding:
      position: 1
      prefix: -db
  - id: gcov_files
    type: 'File[]'
    doc: gcov files (for example Mylib.xs.gcov) made by running gcov on code built with coverage options. The C or XS source files they name must be present beside them.
    inputBinding:
      position: 2
outputs:
  - id: coverage_database
    type: Directory
    doc: The Devel::Cover database written by gcov2perl
    outputBinding:
      glob: $(inputs.database)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-devel-cover:1.33--pl526h14c3975_0
