cwlVersion: v1.2
class: CommandLineTool
baseCommand: cpan
label: perl-cpan-meta-requirements_cpan
doc: "easily interact with CPAN from the command line\n\nTool homepage: https://github.com/Perl-Toolchain-Gang/CPAN-Meta-Requirements"
inputs:
  - id: modules
    type:
      - 'null'
      - type: array
        items: string
    doc: Modules to install or act upon
    inputBinding:
      position: 1
  - id: autobundle
    type:
      - 'null'
      - boolean
    doc: Creates a CPAN.pm autobundle with CPAN::Shell->autobundle.
    inputBinding:
      position: 102
      prefix: -a
  - id: changes
    type:
      - 'null'
      - type: array
        items: string
    doc: Show the Changes files for the specified modules
    inputBinding:
      position: 102
      prefix: -C
  - id: clean
    type:
      - 'null'
      - string
    doc: Runs a `make clean` in the specified module's directories.
    inputBinding:
      position: 102
      prefix: -c
  - id: config_file
    type:
      - 'null'
      - File
    doc: Load the file that has the CPAN configuration data.
    inputBinding:
      position: 102
      prefix: -j
  - id: detailed_info
    type:
      - 'null'
      - boolean
    doc: Print detailed information about the cpan client.
    inputBinding:
      position: 102
      prefix: -V
  - id: details
    type:
      - 'null'
      - type: array
        items: string
    doc: Show the module details. Prints out-of-date modules with local and CPAN versions.
    inputBinding:
      position: 102
      prefix: -D
  - id: download
    type:
      - 'null'
      - type: array
        items: string
    doc: Downloads to the current directory the latest distribution of the module.
    inputBinding:
      position: 102
      prefix: -g
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Do a dry run, but don't actually install anything. (unimplemented)
    inputBinding:
      position: 102
      prefix: -n
  - id: dump_config
    type:
      - 'null'
      - boolean
    doc: Dump the configuration in the same format that CPAN.pm uses.
    inputBinding:
      position: 102
      prefix: -J
  - id: dump_namespaces
    type:
      - 'null'
      - boolean
    doc: Dump all the namespaces to standard output.
    inputBinding:
      position: 102
      prefix: -X
  - id: find_best_mirrors
    type:
      - 'null'
      - boolean
    doc: Find the best mirrors you could be using and use them for the current session.
    inputBinding:
      position: 102
      prefix: -P
  - id: find_matches
    type:
      - 'null'
      - type: array
        items: string
    doc: Find close matches to the named modules that you think you might have mistyped.
    inputBinding:
      position: 102
      prefix: -x
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force the specified action, when it normally would have failed.
    inputBinding:
      position: 102
      prefix: -f
  - id: git_patch
    type:
      - 'null'
      - type: array
        items: string
    doc: 'UNIMPLEMENTED: Download, unpack, and create a git repository for each distribution.'
    inputBinding:
      position: 102
      prefix: -G
  - id: install
    type:
      - 'null'
      - type: array
        items: string
    doc: Install the specified modules.
    inputBinding:
      position: 102
      prefix: -i
  - id: list_by_author
    type:
      - 'null'
      - type: array
        items: string
    doc: List the modules by the specified authors.
    inputBinding:
      position: 102
      prefix: -L
  - id: list_installed
    type:
      - 'null'
      - boolean
    doc: List all installed modules with their versions
    inputBinding:
      position: 102
      prefix: -l
  - id: local_lib
    type:
      - 'null'
      - boolean
    doc: Load "local::lib".
    inputBinding:
      position: 102
      prefix: -I
  - id: maintainers
    type:
      - 'null'
      - type: array
        items: string
    doc: Shows the primary maintainers for the specified modules.
    inputBinding:
      position: 102
      prefix: -A
  - id: make
    type:
      - 'null'
      - type: array
        items: string
    doc: Make the specified modules.
    inputBinding:
      position: 102
      prefix: -m
  - id: mirrors
    type:
      - 'null'
      - string
    doc: A comma-separated list of mirrors to use for just this run.
    inputBinding:
      position: 102
      prefix: -M
  - id: no_lock
    type:
      - 'null'
      - boolean
    doc: Turn off CPAN.pm's attempts to lock anything.
    inputBinding:
      position: 102
      prefix: -F
  - id: no_test
    type:
      - 'null'
      - boolean
    doc: Do not test modules. Simply install them.
    inputBinding:
      position: 102
      prefix: -T
  - id: out_of_date
    type:
      - 'null'
      - boolean
    doc: Show the out-of-date modules.
    inputBinding:
      position: 102
      prefix: -O
  - id: ping_mirrors
    type:
      - 'null'
      - boolean
    doc: Ping the configured mirrors and print a report
    inputBinding:
      position: 102
      prefix: -p
  - id: recompile
    type:
      - 'null'
      - boolean
    doc: Recompiles dynamically loaded modules with CPAN::Shell->recompile.
    inputBinding:
      position: 102
      prefix: -r
  - id: shell
    type:
      - 'null'
      - boolean
    doc: Drop in the CPAN.pm shell.
    inputBinding:
      position: 102
      prefix: -s
  - id: test
    type:
      - 'null'
      - type: array
        items: string
    doc: Run a `make test` on the specified modules.
    inputBinding:
      position: 102
      prefix: -t
  - id: upgrade
    type:
      - 'null'
      - boolean
    doc: Upgrade all installed modules.
    inputBinding:
      position: 102
      prefix: -u
  - id: warnings
    type:
      - 'null'
      - boolean
    doc: 'UNIMPLEMENTED: Turn on cpan warnings.'
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-cpan-meta-requirements:2.143--pl5321hdfd78af_0
stdout: perl-cpan-meta-requirements_cpan.out
