cwlVersion: v1.2
class: CommandLineTool
baseCommand: scandeps.pl
label: perl-module-scandeps
doc: "Scan Perl programs for dependencies\n\nTool homepage: https://metacpan.org/pod/Module::ScanDeps"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Perl scripts or modules to scan for dependencies
    inputBinding:
      position: 1
  - id: bundle
    type:
      - 'null'
      - boolean
    doc: Bundle dependencies
    inputBinding:
      position: 102
      prefix: --bundle
  - id: compile
    type:
      - 'null'
      - boolean
    doc: Compile the script to find dependencies
    inputBinding:
      position: 102
      prefix: --compile
  - id: eval
    type:
      - 'null'
      - string
    doc: Scan a string of Perl code
    inputBinding:
      position: 102
      prefix: --eval
  - id: execute
    type:
      - 'null'
      - boolean
    doc: Execute the script to find dependencies
    inputBinding:
      position: 102
      prefix: --execute
  - id: no_recurse
    type:
      - 'null'
      - boolean
    doc: Do not recurse into dependencies
    inputBinding:
      position: 102
      prefix: --no-recurse
  - id: print_tree
    type:
      - 'null'
      - boolean
    doc: Print dependency tree
    inputBinding:
      position: 102
      prefix: --print-tree
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-module-scandeps:1.37--pl5321hdfd78af_0
stdout: perl-module-scandeps.out
