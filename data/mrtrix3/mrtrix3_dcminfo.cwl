cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dcminfo
doc: "Output DICOM fields in human-readable format\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dcminfo]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stdout: dcminfo.txt
inputs:
  - id: file
    type: File
    doc: "the DICOM file to be scanned."
    inputBinding:
      position: 10
  - id: all
    type: ['null', boolean]
    doc: "print all DICOM fields."
    inputBinding:
      prefix: -all
  - id: csa
    type: ['null', boolean]
    doc: "print all Siemens CSA fields (excluding Phoenix unless requested)"
    inputBinding:
      prefix: -csa
  - id: phoenix
    type: ['null', boolean]
    doc: "print Siemens Phoenix protocol information"
    inputBinding:
      prefix: -phoenix
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
    doc: "print field specified by the group & element tags supplied. Tags should be supplied as Hexadecimal (i.e. as they appear in the -all listing). (multiple uses permitted in MRtrix3; this wrapper allows one use)"
    inputBinding:
      prefix: -tag
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status; alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non-empty string."
    inputBinding:
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files (caution: using the same file as input and output might cause unexpected behaviour)."
    inputBinding:
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: "use this number of threads in multi-threaded applications (set to 0 to disable multi-threading)."
    inputBinding:
      prefix: -nthreads
  - id: config
    type:
      - 'null'
      - type: array
        items: string
    doc: "temporarily set the value of an MRtrix config file entry."
    inputBinding:
      prefix: -config
outputs:
  - id: stdout_text
    type: stdout
    doc: Text printed by the command.
