cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcs-oauth2-boto-plugin
label: gcs-oauth2-boto-plugin
doc: "Google Cloud Storage OAuth2 Boto Plugin\n\nTool homepage: https://github.com/GoogleCloudPlatform/gcs-oauth2-boto-plugin"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gcs-oauth2-boto-plugin:1.9--py27_1
stdout: gcs-oauth2-boto-plugin.out
