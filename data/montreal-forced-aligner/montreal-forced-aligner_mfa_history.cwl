cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mfa
  - history
label: montreal-forced-aligner_mfa_history
doc: "Show previously run mfa commands.\n\nTool homepage: https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: MFA_ROOT_DIR
        envValue: $(runtime.outdir)/mfa_root
  - class: InitialWorkDirRequirement
    listing:
      - entryname: mfa_root
        entry: $(inputs.mfa_root_directory)
        writable: true
inputs:
  - id: mfa_root_directory
    type: Directory
    doc: MFA root directory (MFA_ROOT_DIR) that holds command_history.yaml from earlier mfa runs.
  - id: depth
    type:
      - 'null'
      - int
    doc: "Number of commands to list, defaults to 10"
    inputBinding:
      position: 1
      prefix: --depth
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Output debug messages, default is False"
    inputBinding:
      position: 100
      valueFrom: '$(self === null ? null : (self ? "--verbose" : "--no_verbose"))'
outputs:
  - id: stdout
    type: stdout
    doc: List of previously run mfa commands.
hints:
  - class: DockerRequirement
    dockerPull: mmcauliffe/montreal-forced-aligner:v3.4.3
stdout: montreal-forced-aligner_mfa_history.out
