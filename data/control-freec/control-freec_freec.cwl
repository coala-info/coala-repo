cwlVersion: v1.2
class: CommandLineTool
baseCommand: freec
label: control-freec_freec
doc: "a method for automatic detection of copy number alterations, subclones and for
  accurate estimation of contamination and main ploidy using deep-sequencing data\n\
  \nTool homepage: https://github.com/BoevaLab/FREEC"
inputs:
  - id: config_file
    type: File
    doc: config file (files it names, such as chrLenFile and chrFiles, can be 
      given in config_inputs and named by their base names)
    inputBinding:
      position: 101
      prefix: -conf
  - id: config_inputs
    type:
      - 'null'
      - type: array
        items:
          - File
          - Directory
    doc: Files and directories named in the config file (chrLenFile, chrFiles, 
      mateFile, gemMappabilityFile, SNPfile, captureRegions, ...); staged in the 
      working directory so that their base names resolve
  - id: control
    type:
      - 'null'
      - File
    doc: Control BAM file (freec 11.6 ignores this option; set mateFile in the 
      [control] section of the config file instead)
    inputBinding:
      position: 101
      prefix: -control
  - id: sample
    type:
      - 'null'
      - File
    doc: Sample BAM file
    inputBinding:
      position: 101
      prefix: -sample
outputs:
  - id: cnvs
    type:
      - 'null'
      - File
    doc: Predicted copy number alterations (<sample>_CNVs)
    outputBinding:
      glob: '*_CNVs'
  - id: ratio
    type:
      - 'null'
      - File
    doc: Ratios and predicted copy number per window (<sample>_ratio.txt)
    outputBinding:
      glob: '*_ratio.txt'
  - id: info
    type:
      - 'null'
      - File
    doc: 'Run information, including ploidy and contamination (<sample>_info.txt)'
    outputBinding:
      glob: '*_info.txt'
  - id: all_outputs
    type: File[]
    doc: All result files (CNVs, ratios, BAF, read counts, GC profile, 
      BedGraph)
    outputBinding:
      glob:
        - '*_CNVs'
        - '*_ratio.txt'
        - '*_info.txt'
        - '*_BAF.txt'
        - '*.cpn'
        - '*_subclones.txt'
        - '*.BedGraph'
        - GC_profile*
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "$(inputs.config_inputs ? inputs.config_inputs : [])"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/control-freec:11.6--hdbdd923_3
stdout: control-freec_freec.out
