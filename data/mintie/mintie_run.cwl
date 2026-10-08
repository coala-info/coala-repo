cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mintie
  - -w
label: mintie_run
doc: "MINTIE wrapper script. Invokes the MINTIE bpipe pipeline (Method for Inferring\
  \ Novel Transcripts and Isoforms using Equivalence classes) on case and control\
  \ FASTQ files.\n\nusage (wrapper): mintie -w -p [params.txt] cases/*.fastq.gz controls/*.fastq.gz\n\
  \nTool homepage: https://github.com/Oshlack/MINTIE"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: cases
        entry: "$({class: 'Directory', listing: inputs.case_fastqs})"
      - entryname: controls
        entry: "$({class: 'Directory', listing: inputs.control_fastqs})"
inputs:
  - id: params_file
    type: File
    doc: MINTIE parameter file (bpipe -p lines, as in params.txt), passed with -p
    inputBinding:
      position: 1
      prefix: -p
  - id: case_fastqs
    type:
      type: array
      items: File
    doc: Case sample FASTQ files (staged in cases/)
  - id: control_fastqs
    type:
      type: array
      items: File
    doc: Control sample FASTQ files (staged in controls/)
arguments:
  - position: 2
    valueFrom: "$(inputs.case_fastqs.map(function(f){return 'cases/' + f.basename}))"
  - position: 3
    valueFrom: "$(inputs.control_fastqs.map(function(f){return 'controls/' + f.basename}))"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: final_results
    type:
      - 'null'
      - Directory
    doc: MINTIE final output directory
    outputBinding:
      glob: final
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mintie:0.4.3--hdfd78af_0
stdout: mintie_run.out
