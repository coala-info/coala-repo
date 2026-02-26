cwlVersion: v1.2
class: CommandLineTool
baseCommand: ezclermont
label: ezclermont
doc: "run a 'PCR' to get Clermont 2013 phylotypes\n\nTool homepage: https://github.com/nickp60/ezclermont"
inputs:
  - id: contigs
    type: File
    doc: FASTA formatted genome or set of contigs. If reading from stdin, use 
      '-'
    inputBinding:
      position: 1
  - id: experiment_name
    type:
      - 'null'
      - string
    doc: name of experiment; defaults to file name without extension. If reading
      from stdin, uses the first contig's ID
    inputBinding:
      position: 102
      prefix: --experiment_name
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimum contig length to consider
    default: 500
    inputBinding:
      position: 102
      prefix: --min_length
  - id: no_partial
    type:
      - 'null'
      - boolean
    doc: If scanning contigs, breaks between contigs could potentially contain 
      your sequence of interest. if --no_partial, these plausible partial 
      matches will NOT be reported; default behaviour is to consider partial 
      hits if the assembly has more than 4 sequnces
    inputBinding:
      position: 102
      prefix: --no_partial
outputs:
  - id: logfile
    type:
      - 'null'
      - File
    doc: send log messages to logfile instead stderr
    outputBinding:
      glob: $(inputs.logfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ezclermont:0.7.0--pyhdfd78af_0
