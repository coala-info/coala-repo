cwlVersion: v1.2
class: CommandLineTool
baseCommand: par.pl
label: perl-par-packer_par.pl
doc: "PAR (Perl Archive Toolkit) command-line utility for creating and executing Perl
  archives.\n\nTool homepage: https://github.com/rschupp/PAR-Packer"
inputs:
  - id: src_par
    type:
      - 'null'
      - File
    doc: Source PAR file
    inputBinding:
      position: 1
  - id: program_pl
    type:
      - 'null'
      - File
    doc: Perl program file to execute or pack
    inputBinding:
      position: 2
  - id: bundle_all
    type:
      - 'null'
      - boolean
    doc: Bundle all used modules
    inputBinding:
      position: 103
      prefix: -b
  - id: bundle_core
    type:
      - 'null'
      - boolean
    doc: Bundle core modules
    inputBinding:
      position: 103
      prefix: -B
  - id: include_dir
    type:
      - 'null'
      - Directory
    doc: Specify search path for modules
    inputBinding:
      position: 103
      prefix: -I
  - id: lib_par
    type:
      - 'null'
      - File
    doc: Include a PAR library file
    inputBinding:
      position: 103
      prefix: -A
  - id: module
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify modules to include
    inputBinding:
      position: 103
      prefix: -M
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-par-packer:1.036--pl5321h7b50bb2_6
