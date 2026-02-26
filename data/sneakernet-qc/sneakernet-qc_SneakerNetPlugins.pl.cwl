cwlVersion: v1.2
class: CommandLineTool
baseCommand: SneakerNetPlugins.pl
label: sneakernet-qc_SneakerNetPlugins.pl
doc: "runs all SneakerNet plugins on a run directory\n\nTool homepage: https://github.com/lskatz/sneakernet"
inputs:
  - id: dirs
    type:
      type: array
      items: Directory
    doc: Run directory/directories
    inputBinding:
      position: 1
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Just print the plugin commands that would have been run
    inputBinding:
      position: 102
      prefix: --dry-run
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force operation
    inputBinding:
      position: 102
      prefix: --force
  - id: keep_going
    type:
      - 'null'
      - boolean
    doc: If a plugin has an error, move onto the next anyway
    inputBinding:
      position: 102
      prefix: --keep-going
  - id: noemail
    type:
      - 'null'
      - boolean
    doc: Do not send an email at the end.
    inputBinding:
      position: 102
      prefix: --noemail
  - id: numcpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    default: 1
    inputBinding:
      position: 102
      prefix: --numcpus
  - id: skip_plugins
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify a regex of which plugins to skip. Can provide multiple 
      instances. E.g., --no email --no transfer --no save. Case insensitive.
    inputBinding:
      position: 102
      prefix: --no
  - id: tempdir
    type:
      - 'null'
      - Directory
    doc: Force a temporary directory path to each plugin
    inputBinding:
      position: 102
      prefix: --tempdir
  - id: workflow
    type:
      - 'null'
      - string
    doc: Which workflow under plugins.conf should we follow? If not specified, 
      will look at snok.txt. If not snok.txt, will use 'default'
    inputBinding:
      position: 102
      prefix: --workflow
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sneakernet-qc:0.27.2--pl5321hdfd78af_0
stdout: sneakernet-qc_SneakerNetPlugins.pl.out
