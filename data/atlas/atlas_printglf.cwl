cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - atlas
  - printGLF
label: atlas_printglf
doc: "Printing a binary GLF file as text. The text file is written next to the GLF file as <name>.txt.\n\nTool homepage: https://bitbucket.org/wegmannlab/atlas"
inputs:
  - id: glf
    type: File
    doc: "Input GLF file (from ATLAS GLF)."
    secondaryFiles:
      - pattern: ^.idx
        required: false
    inputBinding:
      position: 1
      prefix: --glf
  - id: out_prefix
    type: string
    doc: "Prefix for all output files (ATLAS --out)."
    default: "atlas_printGLF"
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: log
    type: stdout
    doc: ATLAS progress report (standard output).
  - id: glf_text
    type: File
    doc: "Text GLF: chromosome, position, depth, RMS mapping quality and 10 phred-scaled genotype likelihoods."
    outputBinding:
      glob: $(inputs.glf.basename.replace(/\.gz$/, '').replace(/\.glf$/, '')).txt
  - id: parameters
    type:
      - 'null'
      - File
    doc: "Parameters used for the run."
    outputBinding:
      glob: $(inputs.out_prefix).parameters
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.glf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/atlas:2.0.1--hadca570_0
stdout: atlas_printglf.log
