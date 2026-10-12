cwlVersion: v1.2
class: CommandLineTool
baseCommand: enc2xs
label: perl-encode_enc2xs
doc: "Perl Encode module generator: build a Perl extension for Encode from Unicode Character Mapping files (.ucm) or Tcl Encoding Files (.enc).\n\nTool homepage: http://metacpan.org/pod/Encode"
inputs:
  - id: module_name
    type:
      - 'null'
      - string
    doc: Generate the files of a new encoding module with this name (Makefile.PL, <Name>.pm, README, Changes, t/<Name>.t)
    inputBinding:
      position: 1
      prefix: -M
  - id: configlocal
    type:
      - 'null'
      - boolean
    doc: Update Encode::ConfigLocal to add your encodings to the demand-loading list
    inputBinding:
      position: 1
      prefix: -C
  - id: fail_on_conflicts
    type:
      - 'null'
      - boolean
    doc: Fail when mapping conflicts are found
    inputBinding:
      position: 1
      prefix: -S
  - id: quick
    type:
      - 'null'
      - boolean
    doc: Quick mode, do not spot duplicate mappings
    inputBinding:
      position: 1
      prefix: -Q
  - id: no_comments
    type:
      - 'null'
      - boolean
    doc: Do not write comments into the generated files
    inputBinding:
      position: 1
      prefix: -q
  - id: optimize
    type:
      - 'null'
      - boolean
    doc: Optimize the generated tables
    inputBinding:
      position: 1
      prefix: -O
  - id: output_name
    type:
      - 'null'
      - string
    doc: Name of the generated C file (the .h and .exh files take the same base name)
    inputBinding:
      position: 1
      prefix: -o
  - id: feature_file
    type:
      - 'null'
      - File
    doc: File that lists the mapping files to compile
    inputBinding:
      position: 1
      prefix: -f
  - id: name
    type:
      - 'null'
      - string
    doc: Name to use for the encoding instead of the code set name in the mapping file
    inputBinding:
      position: 1
      prefix: -n
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 1
      prefix: -v
  - id: mapfiles
    type:
      - 'null'
      - type: array
        items: File
    doc: Unicode Character Mapping files (.ucm) or Tcl Encoding Files (.enc)
    inputBinding:
      position: 10
outputs:
  - id: generated_files
    type: 'File[]'
    doc: Files generated in the working directory
    outputBinding:
      glob:
        - '*.c'
        - '*.h'
        - '*.exh'
        - '*.fnm'
        - '*.pm'
        - Makefile.PL
        - README
        - Changes
        - t/*.t
  - id: stdout
    type: stdout
    doc: Standard output
stdout: perl-encode_enc2xs.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-encode:3.19--pl5321hec16e2b_1
