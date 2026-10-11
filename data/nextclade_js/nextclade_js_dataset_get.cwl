cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextclade, dataset, get]
label: nextclade_js_dataset_get
doc: "Download a Nextclade dataset.

Tool homepage: https://github.com/nextstrain/nextclade"
inputs:
  - id: name
    type:
      - 'null'
      - string
    doc: "Name of the dataset to download. Type `nextclade dataset list` to view available datasets"
    inputBinding:
      position: 10
      prefix: --name
  - id: tag
    type:
      - 'null'
      - string
    doc: "Version tag of the dataset to download."
    inputBinding:
      position: 11
      prefix: --tag
  - id: server
    type:
      - 'null'
      - string
    doc: "Use custom dataset server."
    inputBinding:
      position: 12
      prefix: --server
  - id: output_dir
    type:
      - 'null'
      - string
    doc: "Path to directory to write dataset files to."
    inputBinding:
      position: 13
      prefix: --output-dir
  - id: output_zip
    type:
      - 'null'
      - string
    doc: "Path to resulting dataset zip file."
    inputBinding:
      position: 14
      prefix: --output-zip
  - id: proxy
    type:
      - 'null'
      - string
    doc: "Pass all traffic over proxy server. HTTP, HTTPS, and SOCKS5 proxies are supported"
    inputBinding:
      position: 15
      prefix: --proxy
  - id: proxy_user
    type:
      - 'null'
      - string
    doc: "Username for basic authentication on proxy server, if applicable. Only valid when `--proxy` is also supplied. `--proxy-user` and `--proxy-pass` must be either both specified or both omitted"
    inputBinding:
      position: 16
      prefix: --proxy-user
  - id: proxy_pass
    type:
      - 'null'
      - string
    doc: "Password for basic authentication on proxy server, if applicable. Only valid when `--proxy` is also supplied. `--proxy-user` and `--proxy-pass` must be either both specified or both omitted"
    inputBinding:
      position: 17
      prefix: --proxy-pass
  - id: extra_ca_certs
    type:
      - 'null'
      - string
    doc: "Path to extra CA certificates as a PEM bundle."
    inputBinding:
      position: 18
      prefix: --extra-ca-certs
outputs:
  - id: dataset_dir
    type:
      - 'null'
      - Directory
    doc: Directory with the downloaded dataset files.
    outputBinding:
      glob: |-
        ${ return inputs.output_dir ? inputs.output_dir : null; }
  - id: dataset_zip
    type:
      - 'null'
      - File
    doc: Zip file with the downloaded dataset.
    outputBinding:
      glob: |-
        ${ return inputs.output_zip ? inputs.output_zip : null; }
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextclade:3.18.1--h9ee0642_0
stdout: nextclade_js_dataset_get.out
