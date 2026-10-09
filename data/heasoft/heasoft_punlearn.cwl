cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/x86_64-pc-linux-gnu-libc2.17/bin/punlearn
label: heasoft_punlearn
doc: "Clobber a user (or local) parameter file by copying an unmodified (default) version from the system location.\n\nTool homepage: https://heasarc.gsfc.nasa.gov/lheasoft/"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force the next name to be treated as a parameter file name (not a tool name)
    inputBinding:
      position: 1
      prefix: -f
  - id: task_names
    type:
      type: array
      items: string
    doc: Names of the HEASoft tasks (or parameter files) whose parameters are reset.
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: pfiles
    type: Directory
    doc: User parameter file directory holding the reset parameter files
    outputBinding:
      glob: pfiles
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: '$({class: "Directory", basename: "pfiles", listing: []})'
        writable: true
  - class: EnvVarRequirement
    envDef:
      - envName: HEADAS
        envValue: /usr/local/x86_64-pc-linux-gnu-libc2.17
      - envName: LHEASOFT
        envValue: /usr/local/x86_64-pc-linux-gnu-libc2.17
      - envName: FTOOLS
        envValue: /usr/local/x86_64-pc-linux-gnu-libc2.17
      - envName: LHEA_DATA
        envValue: /usr/local/x86_64-pc-linux-gnu-libc2.17/refdata
      - envName: LHEA_HELP
        envValue: /usr/local/x86_64-pc-linux-gnu-libc2.17/help
      - envName: LD_LIBRARY_PATH
        envValue: /usr/local/x86_64-pc-linux-gnu-libc2.17/lib
      - envName: PATH
        envValue: /usr/local/x86_64-pc-linux-gnu-libc2.17/bin:/usr/local/bin:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin
      - envName: PFCLOBBER
        envValue: '1'
      - envName: PFILES
        envValue: $(runtime.outdir)/pfiles;/usr/local/x86_64-pc-linux-gnu-libc2.17/syspfiles
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/heasoft:6.35.2--hedafe93_1
stdout: heasoft_punlearn.out
