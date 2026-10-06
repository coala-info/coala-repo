cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bigsi
  - build
label: bigsi_build
doc: "Build a BIGSI index from bloom filters. The index is written to the storage-config
  filename of the config file.\n\nTool homepage: https://github.com/Phelimb/BIGSI"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: bloomfilters
    type:
      type: array
      items: Directory
    doc: Bloom filter folders made by bigsi bloom
    inputBinding:
      position: 1
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --samples
    doc: Sample names, one per bloom filter, in the same order
    inputBinding:
      position: 102
  - id: config
    type: File
    loadContents: true
    doc: BIGSI configuration YAML file; its storage-config filename names the index
    inputBinding:
      position: 102
      prefix: --config
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
stdout: bigsi_build.out
