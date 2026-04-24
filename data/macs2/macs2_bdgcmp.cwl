cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs2
  - bdgcmp
label: macs2_bdgcmp
doc: "Deduct noise by comparing treatment and control bedGraph files from MACS2\n\n\
  Tool homepage: https://pypi.org/project/MACS2/"
inputs:
  - id: cfile
    type: File
    doc: Control bedGraph file, e.g. *_control_lambda.bdg from MACSv2.
    inputBinding:
      position: 101
      prefix: --cfile
  - id: method
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Method to use while calculating a score in any bin by comparing treatment
      value and control value. Available choices are: ppois, qpois, subtract, logFE,
      logLR, slogLR, FE, and max.'
    inputBinding:
      position: 101
      prefix: --method
  - id: o_prefix
    type:
      - 'null'
      - string
    doc: The PREFIX of output bedGraph file to write scores. Mutually exclusive 
      with -o/--ofile.
    inputBinding:
      position: 101
      prefix: --o-prefix
  - id: pseudocount
    type:
      - 'null'
      - float
    doc: The pseudocount used for calculating logLR, logFE or FE. The count will
      be applied after normalization of sequencing depth.
    inputBinding:
      position: 101
      prefix: --pseudocount
  - id: scaling_factor
    type:
      - 'null'
      - float
    doc: Scaling factor for treatment and control track. Keep it as 1.0 or 
      default in most cases.
    inputBinding:
      position: 101
      prefix: --scaling-factor
  - id: tfile
    type: File
    doc: Treatment bedGraph file, e.g. *_treat_pileup.bdg from MACSv2.
    inputBinding:
      position: 101
      prefix: --tfile
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    outputBinding:
      glob: $(inputs.outdir)
  - id: ofile
    type:
      - 'null'
      - File
    doc: Output filename. Mutually exclusive with --o-prefix. The number and the
      order of arguments for --ofile must be the same as for -m.
    outputBinding:
      glob: $(inputs.ofile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs2:2.2.9.1--py310h1fe012e_5
