cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deblur
  - remove-chimeras-denovo
label: deblur_remove-chimeras-denovo
doc: "Remove chimeras de novo using UCHIME (VSEARCH implementation)\n\nTool homepage:
  https://github.com/biocore/deblur"
inputs:
  - id: seqs_fp
    type: File
    doc: Input sequences file
    inputBinding:
      position: 1
  - id: output_fp
    type: string
    doc: Output path. deblur 1.1.1 uses it as a folder and writes 
      <input name>.no_chimeras inside it
    inputBinding:
      position: 2
  - id: log_file
    type:
      - 'null'
      - string
    doc: log file name
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - int
    doc: Level of messages for log file (range 1-debug to 5-critical)
    inputBinding:
      position: 102
      prefix: --log-level
outputs:
  - id: log
    type:
      - 'null'
      - File
    doc: Log file
    outputBinding:
      glob: "$(inputs.log_file ? inputs.log_file : 'deblur.log')"
  - id: out_output_fp
    type: File
    doc: Chimera-free sequences
    outputBinding:
      glob: $(inputs.output_fp)/$(inputs.seqs_fp.basename).no_chimeras
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: "$({class: 'Directory', basename: inputs.output_fp, listing: []})"
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
