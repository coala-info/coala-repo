cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyhmmsearch_serialize_hmm_models
label: pyhmmsearch_serialize_hmm_models
doc: "Serialize HMM models using pyhmmsearch. (Note: The provided help text contains
  only container build logs and no usage information.)\n\nTool homepage: https://github.com/new-atlantis-labs/pyhmmsearch-stable"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyhmmsearch:2025.10.23.post1--pyh7e72e81_0
stdout: pyhmmsearch_serialize_hmm_models.out
