cwlVersion: v1.2
class: CommandLineTool
baseCommand: corelist
label: perl-module-corelist_corelist
doc: "A command-line interface to Module::CoreList, used to find which versions of
  modules shipped with which versions of perl.\n\nTool homepage: http://dev.perl.org/"
inputs:
  - id: module_name
    type:
      - 'null'
      - string
    doc: ModuleName or /ModuleRegex/ to search for
    inputBinding:
      position: 1
  - id: perl_version_diff_1
    type:
      - 'null'
      - string
    doc: First Perl version for --diff
    inputBinding:
      position: 2
  - id: utility_name
    type:
      - 'null'
      - type: array
        items: string
    doc: Utility name(s) to check with --utils
    inputBinding:
      position: 3
  - id: module_version
    type:
      - 'null'
      - type: array
        items: string
    doc: Module version to check
    inputBinding:
      position: 4
  - id: perl_version_diff_2
    type:
      - 'null'
      - string
    doc: Second Perl version for --diff
    inputBinding:
      position: 5
  - id: all_versions
    type:
      - 'null'
      - boolean
    doc: lists all versions of the given module in the perls Module::CoreList knows
      about
    inputBinding:
      position: 106
      prefix: -a
  - id: by_date
    type:
      - 'null'
      - boolean
    doc: finds the first perl version where a module has been released by date, and
      not by version number
    inputBinding:
      position: 106
      prefix: -d
  - id: diff
    type:
      - 'null'
      - boolean
    doc: Given two versions of perl, this prints a human-readable table of all module
      changes between the two
    inputBinding:
      position: 106
      prefix: --diff
  - id: feature
    type:
      - 'null'
      - type: array
        items: string
    doc: lists the first version bundle of each named feature given
    inputBinding:
      position: 106
      prefix: --feature
  - id: perl_version
    type:
      - 'null'
      - string
    doc: Lists all perl release versions, or if a version is passed, lists all modules
      in that version
    inputBinding:
      position: 106
      prefix: -v
  - id: release_dates
    type:
      - 'null'
      - string
    doc: lists all of the perl releases and when they were released. If a version
      is passed, returns the date for that version only
    inputBinding:
      position: 106
      prefix: -r
  - id: upstream
    type:
      - 'null'
      - string
    doc: Shows if the given module is primarily maintained in perl core or on CPAN
    inputBinding:
      position: 106
      prefix: --upstream
  - id: utils
    type:
      - 'null'
      - boolean
    doc: lists the first version of perl each named utility program was released with
    inputBinding:
      position: 106
      prefix: --utils
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-module-corelist:5.20260119--pl5321hdfd78af_0
stdout: perl-module-corelist_corelist.out
