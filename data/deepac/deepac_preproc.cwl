cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deepac
  - preproc
label: deepac_preproc
doc: "Preprocessing config file.\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs:
  - id: config
    type: File
    loadContents: true
    doc: Preprocessing config file.
    inputBinding:
      position: 1
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Read files (.fasta) named in the config file; staged in the working 
      directory so the relative names in the config resolve.
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Automatically trim the sequences to the read length specified in the 
      config file.
    inputBinding:
      position: 102
      prefix: --trim
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_data
    type:
      - File
      - Directory
    doc: Preprocessed data (OutData path in the config file)
    outputBinding:
      glob: |-
        ${
          var m = inputs.config.contents.match(/^\s*OutData\s*=\s*(\S+)/m);
          var p = m[1];
          return [p, p + ".gz"];
        }
  - id: out_labels
    type:
      - File
      - Directory
    doc: Labels of the preprocessed data (OutLabels path in the config file)
    outputBinding:
      glob: |-
        ${
          var m = inputs.config.contents.match(/^\s*OutLabels\s*=\s*(\S+)/m);
          var p = m[1];
          return [p, p + ".gz"];
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
stdout: deepac_preproc.out
