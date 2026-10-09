cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/x86_64-pc-linux-gnu-libc2.17/bin/fkeyprint
label: heasoft_fkeyprint
doc: "Display the value of a keyword (and its comment) in the header of a FITS file. Parameters are given as name=value pairs, as for all HEASoft tasks.\n\nTool homepage: https://heasarc.gsfc.nasa.gov/lheasoft/"
inputs:
  - id: infile
    type: File
    doc: 'Name of the FITS file; add an extension in brackets with infile_extension.'
    inputBinding:
      position: 1
      prefix: infile=
      separate: false
      valueFrom: '$(self.path)$(inputs.infile_extension ? inputs.infile_extension : "")'
  - id: infile_extension
    type:
      - 'null'
      - string
    doc: 'Optional extension of the FITS file, for example [1] or [EVENTS], appended to infile.'
  - id: keynam
    type: string
    doc: Enter the keyname (8 characters or less)
    inputBinding:
      position: 2
      prefix: keynam=
      separate: false
  - id: exact
    type:
      - 'null'
      - boolean
    doc: Exact string or not (default no)
    inputBinding:
      position: 4
      valueFrom: '$(self ? "exact=yes" : "exact=no")'
  - id: clobber
    type:
      - 'null'
      - boolean
    doc: Overwrite existing output file? (default no)
    inputBinding:
      position: 5
      valueFrom: '$(self ? "clobber=yes" : "clobber=no")'
  - id: mode
    type:
      - 'null'
      - string
    doc: Query mode of the parameters (ql, h or a combination; default ql)
    inputBinding:
      position: 6
      prefix: mode=
      separate: false
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: Name of optional output file (default STDOUT, which prints to the standard output)
    inputBinding:
      position: 3
      prefix: outfile=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the keyword lines when outfile is STDOUT)
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file with the keyword lines, when outfile_path is given
    outputBinding:
      glob: $(inputs.outfile_path)
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
stdout: heasoft_fkeyprint.out
