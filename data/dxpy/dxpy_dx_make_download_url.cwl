cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dx
  - make_download_url
label: dxpy_dx_make_download_url
doc: 'Creates a pre-authenticated link that can be used to download a file without
  logging in.


  Tool homepage: https://github.com/dnanexus/dx-toolkit'
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InlineJavascriptRequirement
  - class: EnvVarRequirement
    envDef:
      DX_SECURITY_CONTEXT: '{"auth_token_type": "Bearer", "auth_token": "$(inputs.auth_token)"}'
      DX_PROJECT_CONTEXT_ID: "$(inputs.project_context_id ? inputs.project_context_id\
        \ : '')"
inputs:
  - id: object_path
    type: string
    doc: Project-qualified data object ID or name, e.g. project-xxxx:file-yyyy, or
      project-xxxx:/path/to/file.txt
    inputBinding:
      position: 1
  - id: duration
    type:
      - 'null'
      - string
    doc: 'Time for which the URL will remain valid (in seconds, or use suffix s, m,
      h, d, w, M, y). Default: 1 day'
    inputBinding:
      position: 101
      prefix: --duration
  - id: filename
    type:
      - 'null'
      - string
    doc: Name that the server will instruct the client to save the file as (default
      is the filename)
    inputBinding:
      position: 101
      prefix: --filename
  - id: auth_token
    type: string
    doc: DNAnexus authentication token; passed in the DX_SECURITY_CONTEXT 
      environment variable (this command has no --auth-token option)
  - id: project_context_id
    type:
      - 'null'
      - string
    doc: Default project or project context ID; passed in the 
      DX_PROJECT_CONTEXT_ID environment variable
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
stdout: dxpy_dx_make_download_url.out
