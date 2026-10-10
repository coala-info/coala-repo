cwlVersion: v1.2
class: CommandLineTool
baseCommand: meta-apo-calibrate
label: meta-apo_meta-apo-calibrate
doc: "Calibration of predicted gene profiles of amplicon microbiomes\n\nTool homepage:
  https://github.com/qibebt-bioinfo/meta-apo"
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
        (inputs.list_files || []).forEach(function (f) {
          l.push({entryname: f.basename, entry: f});
        });
        return l;
      }
inputs:
  - id: input_gene_profile
    type:
      - 'null'
      - File
    doc: Input a gene profile file for a single sample
    inputBinding:
      position: 1
      prefix: -i
  - id: input_files_list
    type:
      - 'null'
      - File
    doc: Input files list for multiple samples (each line, sample name and gene profile path)
    inputBinding:
      position: 2
      prefix: -l
  - id: list_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Gene profile files named in the list, staged in the working directory so the list paths resolve
  - id: files_path_prefix
    type:
      - 'null'
      - string
    doc: List files path prefix [Optional for -l]
    inputBinding:
      position: 3
      prefix: -p
  - id: input_ko_table
    type:
      - 'null'
      - File
    doc: Input KO table (*.ko.abd) for multiple samples
    inputBinding:
      position: 4
      prefix: -t
  - id: reversed_input_table
    type:
      - 'null'
      - string
    doc: If the input table is reversed, T(rue) or F(alse), default is false
      [Optional for -t]
    inputBinding:
      position: 5
      prefix: -R
  - id: input_model_file
    type: File
    doc: Input model file
    inputBinding:
      position: 6
      prefix: -m
  - id: output_path
    type: string
    default: functions.calibrated
    doc: Output path, default is "functions.calibrated" (a file for -i and -t, a folder plus <path>.list for -l)
    inputBinding:
      position: 7
      prefix: -o
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: calibrated
    type:
      - File
      - Directory
    doc: Calibrated gene profile table, file, or folder
    outputBinding:
      glob: $(inputs.output_path)
  - id: calibrated_list
    type:
      - 'null'
      - File
    doc: File list of the calibrated samples (list mode)
    outputBinding:
      glob: $(inputs.output_path).list
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-apo:1.1--h9f5acd7_4
stdout: meta-apo_meta-apo-calibrate.out
