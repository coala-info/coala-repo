cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bigsi
  - merge
label: bigsi_merge
doc: "Merge the index of merge_config into the index of config.\n\nTool homepage:
  https://github.com/Phelimb/BIGSI"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.index)
        writable: true
      - entry: $(inputs.merge_index)
        writable: true
inputs:
  - id: config
    type: File
    loadContents: true
    doc: BIGSI configuration YAML file; its storage-config filename names the index
    inputBinding:
      position: 1
  - id: merge_config
    type: File
    loadContents: true
    doc: BIGSI configuration YAML file of the index to merge in
    inputBinding:
      position: 2
  - id: index
    type:
      - File
      - Directory
    doc: BIGSI index named in config; the merge result is written into it
  - id: merge_index
    type:
      - File
      - Directory
    doc: BIGSI index named in merge_config
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_out
    type:
      - File
      - Directory
    doc: BIGSI index named by storage-config filename in the config file
    outputBinding:
      glob: |-
        ${
          var m = inputs.config.contents.match(/filename:\s*(\S+)/);
          return m ? m[1].replace(/[\x22\x27]/g, "") : null;
        }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigsi:0.3.1--py_0
stdout: bigsi_merge.out
