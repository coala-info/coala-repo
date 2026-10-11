cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nextclade, dataset, list]
label: nextclade_js_dataset_list
doc: "List available Nextclade datasets.

Tool homepage: https://github.com/nextstrain/nextclade"
inputs:
  - id: name
    type:
      - 'null'
      - string
    doc: "Restrict list to datasets with this *exact* name."
    inputBinding:
      position: 10
      prefix: --name
  - id: search
    type:
      - 'null'
      - string
    doc: "Search datasets by name or by reference."
    inputBinding:
      position: 11
      prefix: --search
  - id: tag
    type:
      - 'null'
      - string
    doc: "Restrict list to datasets with this exact version tag"
    inputBinding:
      position: 12
      prefix: --tag
  - id: include_incompatible
    type:
      - 'null'
      - boolean
    doc: "Include dataset versions that are incompatible with this version of Nextclade CLI"
    inputBinding:
      position: 13
      prefix: --include-incompatible
  - id: include_deprecated
    type:
      - 'null'
      - boolean
    doc: "Include deprecated datasets."
    inputBinding:
      position: 14
      prefix: --include-deprecated
  - id: no_experimental
    type:
      - 'null'
      - boolean
    doc: "Exclude experimental datasets."
    inputBinding:
      position: 15
      prefix: --no-experimental
  - id: no_community
    type:
      - 'null'
      - boolean
    doc: "Exclude community datasets and only show official datasets."
    inputBinding:
      position: 16
      prefix: --no-community
  - id: json
    type:
      - 'null'
      - boolean
    doc: "Print output in JSON format."
    inputBinding:
      position: 17
      prefix: --json
  - id: only_names
    type:
      - 'null'
      - boolean
    doc: "Print only names of the datasets, without any other details"
    inputBinding:
      position: 18
      prefix: --only-names
  - id: server
    type:
      - 'null'
      - string
    doc: "Use custom dataset server."
    inputBinding:
      position: 19
      prefix: --server
  - id: proxy
    type:
      - 'null'
      - string
    doc: "Pass all traffic over proxy server. HTTP, HTTPS, and SOCKS5 proxies are supported"
    inputBinding:
      position: 20
      prefix: --proxy
  - id: proxy_user
    type:
      - 'null'
      - string
    doc: "Username for basic authentication on proxy server, if applicable. Only valid when `--proxy` is also supplied. `--proxy-user` and `--proxy-pass` must be either both specified or both omitted"
    inputBinding:
      position: 21
      prefix: --proxy-user
  - id: proxy_pass
    type:
      - 'null'
      - string
    doc: "Password for basic authentication on proxy server, if applicable. Only valid when `--proxy` is also supplied. `--proxy-user` and `--proxy-pass` must be either both specified or both omitted"
    inputBinding:
      position: 22
      prefix: --proxy-pass
  - id: extra_ca_certs
    type:
      - 'null'
      - string
    doc: "Path to extra CA certificates as a PEM bundle."
    inputBinding:
      position: 23
      prefix: --extra-ca-certs
outputs:
  - id: stdout
    type: stdout
    doc: List of datasets (text, or JSON with --json).
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nextclade:3.18.1--h9ee0642_0
stdout: nextclade_js_dataset_list.out
