cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bppancestor
label: bppsuite_bppancestor
doc: "Bio++ Ancestral Sequence Reconstruction\n\nUsage: bppancestor parameter1_name=parameter1_value parameter2_name=parameter2_value
  ... param=option_file\n\nRefer to the Bio++ Program Suite Manual for a list of available
  options.\n\nTool homepage: https://github.com/BioPP/bppsuite"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '${ return inputs.input_files ? inputs.input_files : []; }'
inputs:
  - id: param
    type:
      - 'null'
      - File
    doc: Option file with name=value lines (param=option_file)
    inputBinding:
      position: 1
      prefix: param=
      separate: false
  - id: parameters
    type:
      - 'null'
      - type: array
        items: string
    doc: Options given as name=value pairs (parameter1_name=parameter1_value ...); they
      override the option file
    inputBinding:
      position: 2
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Data files named in the option file or the parameters (sequences, trees, parameter
      files); staged in the working directory so relative names resolve
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written by the program (names set by output.* options)
    outputBinding:
      glob: '*'
      outputEval: |-
        ${
          var skip = ["bppsuite_bppancestor.out"];
          (inputs.input_files || []).forEach(function(f){ skip.push(f.basename); });
          return self.filter(function(f){ return skip.indexOf(f.basename) < 0; });
        }
  - id: stdout
    type: stdout
    doc: Standard output (run log)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bppsuite:v2.4.1-1-deb_cv1
stdout: bppsuite_bppancestor.out
