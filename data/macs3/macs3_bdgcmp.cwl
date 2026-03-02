cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - bdgcmp
label: macs3_bdgcmp
doc: "Deduct noise by comparing treatment and control bedGraph files using various
  methods.\n\nTool homepage: https://pypi.org/project/MACS3/"
inputs:
  - id: cfile
    type: File
    doc: Control bedGraph file, e.g. *_control_lambda.bdg from MACSv2. REQUIRED
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
      FE, logLR, slogLR, and max.'
    default: ppois
    inputBinding:
      position: 101
      prefix: --method
  - id: o_prefix
    type:
      - 'null'
      - string
    doc: The PREFIX of output bedGraph file to write scores. If it is given as 
      A, and method is 'ppois', output file will be A_ppois.bdg. Mutually 
      exclusive with -o/--ofile.
    inputBinding:
      position: 101
      prefix: --o-prefix
  - id: pseudocount
    type:
      - 'null'
      - float
    doc: The pseudocount used for calculating logLR, logFE or FE. The count will
      be applied after normalization of sequencing depth.
    default: 0.0
    inputBinding:
      position: 101
      prefix: --pseudocount
  - id: scaling_factor
    type:
      - 'null'
      - float
    doc: Scaling factor for treatment and control track. Keep it as 1.0 or 
      default in most cases. Set it ONLY while you have SPMR output from MACS3 
      callpeak, and plan to calculate scores as MACS3 callpeak module.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --scaling-factor
  - id: tfile
    type: File
    doc: Treatment bedGraph file, e.g. *_treat_pileup.bdg from MACSv2. REQUIRED
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
    dockerPull: quay.io/biocontainers/macs3:3.0.4--py310h5a5e57a_0
