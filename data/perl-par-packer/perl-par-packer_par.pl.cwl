cwlVersion: v1.2
class: CommandLineTool
baseCommand: par.pl
label: perl-par-packer_par.pl
doc: "Make and run Perl Archives\n\nTool homepage: https://github.com/rschupp/PAR-Packer"
inputs:
  - id: src_par
    type:
      - 'null'
      - File
    doc: "Source PAR file (or a Perl program) to run or pack"
    inputBinding:
      position: 200
  - id: program_pl
    type:
      - 'null'
      - string
    doc: "Program inside the PAR archive to run (default main.pl)"
    inputBinding:
      position: 201
  - id: program_args
    type:
      - 'null'
      - type: array
        items: string
    doc: "Arguments passed to the program run from the PAR file"
    inputBinding:
      position: 202
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: "Make a self-contained script or executable with this name from the PAR file"
    inputBinding:
      position: 101
      prefix: -O
      separate: false
  - id: bundle_all
    type:
      - 'null'
      - boolean
    doc: "Embed the necessary non-core modules and shared objects for PAR's execution"
    inputBinding:
      position: 101
      prefix: -b
  - id: bundle_core
    type:
      - 'null'
      - boolean
    doc: "Embed core modules too"
    inputBinding:
      position: 101
      prefix: -B
  - id: lib_par
    type:
      - 'null'
      - File
    doc: "Use modules from this .par archive"
    inputBinding:
      position: 101
      prefix: -A
      separate: false
  - id: include_dir
    type:
      - 'null'
      - Directory
    doc: "Search for .par files in this directory"
    inputBinding:
      position: 101
      prefix: -I
      separate: false
  - id: module
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -M
          separate: false
    doc: "Load this module (for example from a .par archive)"
    inputBinding:
      position: 101
  - id: make_dist
    type:
      - 'null'
      - boolean
    doc: "Make a PAR distribution from a CPAN module distribution"
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file written with the output_file_path option
    outputBinding:
      glob: $(inputs.output_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-par-packer:1.036--pl5321h7b50bb2_6
stdout: perl-par-packer_par.pl.out
