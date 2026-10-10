cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta-apo-train
label: meta-apo_meta-apo-train
doc: "Model training using gene profiles of paired WGS-amplicon microbiomes\n\nTool
  homepage: https://github.com/qibebt-bioinfo/meta-apo"
requirements:
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      - envName: MetaApo
        envValue: /usr/local/share/meta-apo-1.1
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        (inputs.wgs_list_files || []).concat(inputs.amplicon_list_files || []).forEach(function (f) {
          l.push({entryname: f.basename, entry: f});
        });
        return l;
      }
inputs:
  - id: input_wgs_list
    type:
      - 'null'
      - File
    doc: Input files list of training WGS samples (each line, sample name and gene profile path)
    inputBinding:
      position: 1
      prefix: -L
  - id: input_amplicon_list
    type:
      - 'null'
      - File
    doc: Input files list of training amplicon samples (each line, sample name and gene profile path)
    inputBinding:
      position: 2
      prefix: -l
  - id: wgs_list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Gene profile files named in the WGS list, staged in the working directory so the list paths resolve
  - id: amplicon_list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Gene profile files named in the amplicon list, staged in the working directory so the list paths resolve
  - id: files_path_prefix
    type:
      - 'null'
      - string
    doc: List files path prefix [Optional for -l and -L]
    inputBinding:
      position: 3
      prefix: -p
  - id: input_wgs_ko_table
    type:
      - 'null'
      - File
    doc: Input KO table (*.ko.abd) of training WGS samples
    inputBinding:
      position: 4
      prefix: -T
  - id: input_amplicon_ko_table
    type:
      - 'null'
      - File
    doc: Input KO table (*.ko.abd) of training amplicon samples
    inputBinding:
      position: 5
      prefix: -t
  - id: is_input_table_reversed
    type:
      - 'null'
      - string
    doc: If the input table is reversed, T(rue) or F(alse), default is false
      [Optional for -T and -t]
    inputBinding:
      position: 6
      prefix: -R
  - id: output_mode_file
    type: string
    default: meta-apo.model
    doc: Output model file, default is "meta-apo.model"
    inputBinding:
      position: 7
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_mode_file_out
    type: File
    doc: Output model file
    outputBinding:
      glob: $(inputs.output_mode_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-apo:1.1--h9f5acd7_4
stdout: meta-apo_meta-apo-train.out
