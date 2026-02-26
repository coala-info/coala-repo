cwlVersion: v1.2
class: CommandLineTool
baseCommand: snakedeploy update-snakemake-wrappers
label: snakedeploy_update-snakemake-wrappers
doc: "Update all snakemake wrappers in given Snakefiles to their latest versions.\n\
  \nTool homepage: https://github.com/snakemake/snakedeploy"
inputs:
  - id: snakefiles
    type:
      type: array
      items: File
    doc: Paths to Snakefiles which should be updated.
    inputBinding:
      position: 1
  - id: create_prs
    type:
      - 'null'
      - boolean
    doc: 'Create pull request for each updated snakefile. Requires GITHUB_TOKEN and
      GITHUB_REPOSITORY (the repo name) and one of GITHUB_REF_NAME or GITHUB_BASE_REF
      (preferring the latter, representing the target branch, e.g. main or master)
      environment variables to be set (the latter three are available when running
      as github action). In order to enable further actions (e.g. checks) to run on
      the generated PRs, the provided GITHUB_TOKEN may not be the default github actions
      token. See here for options: https://github.com/peter-evans/create-pull-request/blob/main/docs/concepts-guidelines.md#triggering-further-workflow-runs.'
    inputBinding:
      position: 102
      prefix: --create-prs
  - id: entity_regex
    type:
      - 'null'
      - string
    doc: Regular expression for deriving an entity name from the snakefile file 
      name (will be used for adding a label and for title and description). Has 
      to contain a group 'entity' (e.g. '(?P<entity>.+)/environment.yaml').
    inputBinding:
      position: 102
      prefix: --entity-regex
  - id: per_snakefile_prs
    type:
      - 'null'
      - boolean
    doc: Create one PR per Snakefile instead of a single PR for all.
    inputBinding:
      position: 102
      prefix: --per-snakefile-prs
  - id: pr_add_label
    type:
      - 'null'
      - boolean
    doc: Add a label to the PR. Has to be used in combination with 
      --entity-regex.
    inputBinding:
      position: 102
      prefix: --pr-add-label
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
stdout: snakedeploy_update-snakemake-wrappers.out
