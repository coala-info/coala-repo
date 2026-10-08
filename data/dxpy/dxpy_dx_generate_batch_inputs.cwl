cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dx
  - generate_batch_inputs
label: dxpy_dx_generate_batch_inputs
doc: 'Generate a table of input files matching desired regular expressions for each
  input.


  Tool homepage: https://github.com/dnanexus/dx-toolkit'
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: EnvVarRequirement
    envDef:
      DX_SECURITY_CONTEXT: '{"auth_token_type": "Bearer", "auth_token": "$(inputs.auth_token)"}'
      DX_PROJECT_CONTEXT_ID: "$(inputs.project_context_id ? inputs.project_context_id\
        \ : '')"
  - class: InlineJavascriptRequirement
inputs:
  - id: inputs_spec
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --input
    doc: An input to be batch-processed "-i<input name>=<input pattern>" where <input_pattern>
      is a regular expression with a group corresponding to the desired region to
      match (e.g. "-iinputa=SRR(.*)_1.gz" "-iinputb=SRR(.*)_2.gz")
    inputBinding:
      position: 101
  - id: dx_path
    type:
      - 'null'
      - string
    doc: Project and/or folder to which the search for input files will be restricted
    inputBinding:
      position: 101
      prefix: --path
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for output file
    inputBinding:
      position: 101
      prefix: --output_prefix
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
  - id: batch_tsvs
    type:
      type: array
      items: File
    doc: Batch plan TSV files (<prefix>.NNNN.tsv)
    outputBinding:
      glob: '$(inputs.output_prefix ? inputs.output_prefix : ''dx_batch'').*.tsv'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dxpy:0.400.1--pyhdfd78af_0
stdout: dxpy_dx_generate_batch_inputs.out
