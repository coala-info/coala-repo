cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -scene-file-merge
label: connectome-workbench_wb_command_scene-file-merge
doc: 'Takes one or more scene files and constructs a new scene file by concatenating
  specified scenes from them.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var seen = {};
        var out = [];
        (inputs.scene_file || []).forEach(function (r) {
          if (!seen[r.scene_file.basename]) {
            seen[r.scene_file.basename] = true;
            out.push(r.scene_file);
          }
        });
        return out;
      }
  - class: SchemaDefRequirement
    types:
      - name: scene_file_scene_up_to_rec
        type: record
        fields:
          - name: last_column
            type: string
            doc: the number or name of the last scene to include
            inputBinding:
              position: 1
          - name: reverse
            type:
              - 'null'
              - boolean
            doc: use the range in reverse order
            inputBinding:
              position: 2
              prefix: -reverse
      - name: scene_file_scene_rec
        type: record
        fields:
          - name: scene
            type: string
            doc: the scene number or name
            inputBinding:
              position: 1
          - name: up_to
            type:
              - 'null'
              - scene_file_scene_up_to_rec
            doc: use an inclusive range of scenes
            inputBinding:
              position: 2
              prefix: -up-to
      - name: scene_file_rec
        type: record
        fields:
          - name: scene_file
            type: File
            doc: the input scene file
            inputBinding:
              position: 1
          - name: scene
            type:
              - 'null'
              - type: array
                items: scene_file_scene_rec
                inputBinding:
                  prefix: -scene
            doc: specify a scene to use
            inputBinding:
              position: 2
inputs:
  - id: scene_file_out
    type: string
    doc: output - the output scene file
    inputBinding:
      position: 1
  - id: scene_file
    type:
      - 'null'
      - type: array
        items: scene_file_rec
        inputBinding:
          prefix: -scene-file
    doc: specify a scene file to use scenes from
    inputBinding:
      position: 2
outputs:
  - id: scene_file_out_file
    type: File
    doc: the output scene file
    outputBinding:
      glob: $(inputs.scene_file_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
