cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpanm
label: perl-test-output_cpanm
doc: "Get, unpack, build and install modules from CPAN\n\nTool homepage: https://github.com/briandfoy/test-output"
inputs:
  - id: module
    type:
      type: array
      items: string
    doc: Module name, distribution path, URL, or local file/directory
    inputBinding:
      position: 1
  - id: auto_cleanup
    type:
      - 'null'
      - int
    doc: Number of days that cpanm's work directories expire in.
    inputBinding:
      position: 102
      prefix: --auto-cleanup
  - id: force
    type:
      - 'null'
      - boolean
    doc: force install
    inputBinding:
      position: 102
      prefix: --force
  - id: from
    type:
      - 'null'
      - string
    doc: Use only this mirror base URL and its index file
    inputBinding:
      position: 102
      prefix: --from
  - id: info
    type:
      - 'null'
      - boolean
    doc: Displays distribution info on CPAN
    inputBinding:
      position: 102
      prefix: --info
  - id: installdeps
    type:
      - 'null'
      - boolean
    doc: Only install dependencies
    inputBinding:
      position: 102
      prefix: --installdeps
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: 'Turns on interactive configure (required for Task:: modules)'
    inputBinding:
      position: 102
      prefix: --interactive
  - id: local_lib
    type:
      - 'null'
      - Directory
    doc: Specify the install base to install modules
    inputBinding:
      position: 102
      prefix: --local-lib
  - id: local_lib_contained
    type:
      - 'null'
      - Directory
    doc: Specify the install base to install all non-core modules
    inputBinding:
      position: 102
      prefix: --local-lib-contained
  - id: look
    type:
      - 'null'
      - boolean
    doc: Opens the distribution with your SHELL
    inputBinding:
      position: 102
      prefix: --look
  - id: mirror
    type:
      - 'null'
      - string
    doc: Specify the base URL for the mirror (e.g. http://cpan.cpantesters.org/)
    inputBinding:
      position: 102
      prefix: --mirror
  - id: mirror_only
    type:
      - 'null'
      - boolean
    doc: Use the mirror's index file instead of the CPAN Meta DB
    inputBinding:
      position: 102
      prefix: --mirror-only
  - id: notest
    type:
      - 'null'
      - boolean
    doc: Do not run unit tests
    inputBinding:
      position: 102
      prefix: --notest
  - id: prompt
    type:
      - 'null'
      - boolean
    doc: Prompt when configure/build/test fails
    inputBinding:
      position: 102
      prefix: --prompt
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Turns off the most output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reinstall
    type:
      - 'null'
      - boolean
    doc: Reinstall the distribution even if you already have the latest version installed
    inputBinding:
      position: 102
      prefix: --reinstall
  - id: self_contained
    type:
      - 'null'
      - boolean
    doc: Install all non-core modules, even if they're already installed.
    inputBinding:
      position: 102
      prefix: --self-contained
  - id: self_upgrade
    type:
      - 'null'
      - boolean
    doc: upgrades itself
    inputBinding:
      position: 102
      prefix: --self-upgrade
  - id: showdeps
    type:
      - 'null'
      - boolean
    doc: Only display direct dependencies
    inputBinding:
      position: 102
      prefix: --showdeps
  - id: sudo
    type:
      - 'null'
      - boolean
    doc: sudo to run install commands
    inputBinding:
      position: 102
      prefix: --sudo
  - id: test_only
    type:
      - 'null'
      - boolean
    doc: Run tests only, do not install
    inputBinding:
      position: 102
      prefix: --test-only
  - id: uninstall
    type:
      - 'null'
      - boolean
    doc: Uninstalls the modules (EXPERIMENTAL)
    inputBinding:
      position: 102
      prefix: --uninstall
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turns on chatty output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-test-output:1.031--pl526_0
stdout: perl-test-output_cpanm.out
