cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_5ttgen_fsl
doc: "Use FSL commands to generate the 5TT image based on a T1-weighted image\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [5ttgen, fsl]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: input
    type: File
    doc: "The input T1-weighted image"
    inputBinding:
      position: 10
  - id: output
    type: string
    doc: "The output 5TT image"
    inputBinding:
      position: 11
  - id: t2
    type: ['null', File]
    doc: "Provide a T2-weighted image in addition to the default T1-weighted image; this will be used as a second input to FSL FAST"
    inputBinding:
      prefix: -t2
  - id: mask
    type: ['null', File]
    doc: "Manually provide a brain mask, rather than deriving one in the script"
    inputBinding:
      prefix: -mask
  - id: premasked
    type: ['null', boolean]
    doc: "Indicate that brain masking has already been applied to the input image"
    inputBinding:
      prefix: -premasked
  - id: nocrop
    type: ['null', boolean]
    doc: "Do NOT crop the resulting 5TT image to reduce its size (keep the same dimensions as the input image)"
    inputBinding:
      prefix: -nocrop
  - id: sgm_amyg_hipp
    type: ['null', boolean]
    doc: "Represent the amygdalae and hippocampi as sub-cortical grey matter in the 5TT image"
    inputBinding:
      prefix: -sgm_amyg_hipp
  - id: nocleanup
    type: ['null', boolean]
    doc: "do not delete intermediate files during script execution, and do not delete scratch directory at script completion."
    inputBinding:
      prefix: -nocleanup
  - id: scratch
    type: ['null', string]
    doc: "manually specify the path in which to generate the scratch directory."
    inputBinding:
      prefix: -scratch
  - id: continue
    type:
      - 'null'
      - type: array
        items: string
    doc: "continue the script from a previous execution; must provide the scratch directory path, and the name of the last successfully-generated file."
    inputBinding:
      prefix: -continue
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status. Alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non- empty string."
    inputBinding:
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files."
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
  - id: output_file
    type: File
    doc: "The output 5TT image"
    outputBinding:
      glob: $(inputs.output)
