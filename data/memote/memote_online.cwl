cwlVersion: v1.2
class: CommandLineTool
baseCommand: memote online
label: memote_online
doc: "Upload the repository to GitHub and create a gh-pages branch.\n\nTool homepage:
  https://memote.readthedocs.io/"
inputs:
  - id: deployment
    type:
      - 'null'
      - string
    doc: Deployment branch to be pushed. Usually this is configured for you.
    inputBinding:
      position: 101
      prefix: --deployment
  - id: github_repository
    type:
      - 'null'
      - string
    doc: The repository name on GitHub. Usually this is configured for you.
    inputBinding:
      position: 101
      prefix: --github_repository
  - id: github_token
    type:
      - 'null'
      - string
    doc: Personal access token on GitHub.
    inputBinding:
      position: 101
      prefix: --github-token
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/memote:0.17.0--pyhdfd78af_0
stdout: memote_online.out
