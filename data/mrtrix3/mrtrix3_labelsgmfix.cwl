cwlVersion: v1.2
class: CommandLineTool
baseCommand: [labelsgmfix]
label: mrtrix3_labelsgmfix
doc: |-
  In a FreeSurfer parcellation image, replace the sub-cortical grey matter structure delineations using FSL FIRST

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: SchemaDefRequirement
    types:
      - name: labelsgmfix_continue_rec
        type: record
        fields:
          - name: ScratchDir
            type: string
            doc: <ScratchDir>
            inputBinding:
              position: 1
          - name: LastFile
            type: string
            doc: <LastFile>
            inputBinding:
              position: 2
inputs:
  - id: parc
    type: File
    doc: The input FreeSurfer parcellation image
    inputBinding:
      position: 1
  - id: t1
    type: File
    doc: The T1 image to be provided to FIRST
    inputBinding:
      position: 2
  - id: lut
    type: File
    doc: The lookup table file that the parcellated image is based on
    inputBinding:
      position: 3
  - id: output
    type: string
    doc: The output parcellation image
    inputBinding:
      position: 4
  - id: premasked
    type: ['null', boolean]
    doc: Indicate that brain masking has been applied to the T1 input image
    inputBinding:
      prefix: -premasked
  - id: sgm_amyg_hipp
    type: ['null', boolean]
    doc: Consider the amygdalae and hippocampi as sub-cortical grey matter structures, and also replace
      their estimates with those from FIRST
    inputBinding:
      prefix: -sgm_amyg_hipp
  - id: nocleanup
    type: ['null', boolean]
    doc: do not delete intermediate files during script execution, and do not delete scratch directory
      at script completion.
    inputBinding:
      prefix: -nocleanup
  - id: scratch
    type: ['null', string]
    doc: manually specify the path in which to generate the scratch directory.
    inputBinding:
      prefix: -scratch
  - id: continue
    type: ['null', labelsgmfix_continue_rec]
    doc: continue the script from a previous execution; must provide the scratch directory path, and the
      name of the last successfully-generated file.
    inputBinding:
      prefix: -continue
  - id: info
    type: ['null', boolean]
    doc: display information messages.
    inputBinding:
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: do not display information messages or progress status. Alternatively, this can be achieved by
      setting the MRTRIX_QUIET environment variable to a non-empty string.
    inputBinding:
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: display debugging messages.
    inputBinding:
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: force overwrite of output files.
    inputBinding:
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: use this number of threads in multi-threaded applications (set to 0 to disable multi-threading).
    inputBinding:
      prefix: -nthreads
outputs:
  - id: output_out
    type: File
    doc: The output parcellation image.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
