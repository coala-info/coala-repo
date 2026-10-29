cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_dcmedit
doc: "Edit DICOM file in-place\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [dcmedit]
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: file
    type: File
    doc: "the DICOM file to be edited."
    inputBinding:
      position: 10
  - id: anonymise
    type: ['null', boolean]
    doc: "remove any identifiable information, by replacing the following tags: - any tag with Value Representation PN will be replaced with 'anonymous' - tag (0010,0030) PatientBirthDate will be replaced with an empty string WARNING: there is no guarantee that this command will remove all identiable information, since such information may be contained in any number of private vendor-specific tags. You will need to double-check the results independently if you need to ensure anonymity."
    inputBinding:
      prefix: -anonymise
  - id: id
    type: ['null', string]
    doc: "replace all ID tags with string supplied. This consists of tags (0010, 0020) PatientID and (0010, 1000) OtherPatientIDs"
    inputBinding:
      prefix: -id
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
    doc: "replace specific tag. (multiple uses permitted in MRtrix3; this wrapper allows one use)"
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
  - id: edited_file
    type: File
    doc: The DICOM file edited in place.
    outputBinding:
      glob: $(inputs.file.basename)
