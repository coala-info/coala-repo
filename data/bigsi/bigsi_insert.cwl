cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bigsi
  - insert
label: bigsi_insert
doc: "Inserts a bloom filter into the graph e.g. bigsi insert ERR1010211.bloom\nERR1010211\n\
  \nTool homepage: https://github.com/Phelimb/BIGSI"
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
    doc: BIGSI configuration YAML file; its storage-config filename names the index
    inputBinding:
      position: 1
  - id: index
    type:
      - File
      - Directory
    doc: BIGSI index (file or folder) named in the config file; updated in place
  - id: bloomfilter
    type: Directory
    doc: Bloom filter folder made by bigsi bloom
    inputBinding:
      position: 2
  - id: sample
    type: string
    doc: Sample name
    inputBinding:
      position: 3
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
stdout: bigsi_insert.out
