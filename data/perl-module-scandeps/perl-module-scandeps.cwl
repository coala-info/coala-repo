cwlVersion: v1.2
class: CommandLineTool
baseCommand: scandeps.pl
label: perl-module-scandeps
doc: "Scan Perl programs for dependencies\n\nTool homepage: https://metacpan.org/pod/Module::ScanDeps"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Perl scripts or modules to scan for dependencies
    inputBinding:
      position: 200
  - id: bundle
    type:
      - 'null'
      - boolean
    doc: Include core modules in the output and the recursive search list
    inputBinding:
      position: 102
      prefix: --bundle
  - id: compile
    type:
      - 'null'
      - boolean
    doc: Compile the code and inspect its %INC, in addition to static scanning
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
    doc: Execute the code and inspect its %INC, in addition to static scanning
    inputBinding:
      position: 102
      prefix: --execute
  - id: no_recurse
    type:
      - 'null'
      - boolean
    doc: Only show dependencies found in the files listed and do not recurse
    inputBinding:
      position: 102
      prefix: --no-recurse
  - id: xargs
    type:
      - 'null'
      - string
    doc: If execute is given, splits this string with shellwords and passes the result as @ARGV when executing the code
    inputBinding:
      position: 102
      prefix: --xargs
  - id: cachedeps
    type:
      - 'null'
      - string
    doc: Name of a cache file to speed up the scanning process by caching dependencies; created if it does not exist
    inputBinding:
      position: 102
      prefix: --cachedeps
  - id: modtree
    type:
      - 'null'
      - boolean
    doc: Retrieve module information from CPAN if CPANPLUS is installed
    inputBinding:
      position: 102
      prefix: --modtree
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, output all files found during the process
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: cachedeps_out
    type:
      - 'null'
      - File
    doc: Cache file written with the cachedeps option
    outputBinding:
      glob: $(inputs.cachedeps)
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-module-scandeps:1.37--pl5321hdfd78af_0
stdout: perl-module-scandeps.out
