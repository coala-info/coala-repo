cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bigsi
  - delete
label: bigsi_delete
doc: "Deletes a BigSI index (the berkeleydb/rocksdb storage is removed and recreated
  empty).\n\nTool homepage: https://github.com/Phelimb/BIGSI"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.index)
        writable: true
inputs:
  - id: config
    type: File
    loadContents: true
    doc: Path to the BigSI configuration file.
    inputBinding:
      position: 101
      prefix: --config
  - id: index
    type:
      - File
      - Directory
    doc: BIGSI index (file or folder) named in the config file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_out
    type:
      - 'null'
      - File
      - Directory
    doc: Emptied index left by the tool
    outputBinding:
      glob: |-
        ${
          var m = inputs.config.contents.match(/filename:\s*(\S+)/);
          return m ? m[1].replace(/[\x22\x27]/g, "") : null;
        }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigsi:0.3.1--py_0
stdout: bigsi_delete.out
