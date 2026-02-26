cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kipoi
  - test-source
label: kipoi_test-source
doc: "Test models in model source\n\nTool homepage: https://github.com/kipoi/kipoi"
inputs:
  - id: source
    type: string
    doc: Which source to test
    inputBinding:
      position: 1
  - id: all
    type:
      - 'null'
      - boolean
    doc: Test all models in the source
    inputBinding:
      position: 102
      prefix: --all
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Batch size
    inputBinding:
      position: 102
      prefix: --batch_size
  - id: clean_env
    type:
      - 'null'
      - boolean
    doc: clean the environment after running.
    inputBinding:
      position: 102
      prefix: --clean_env
  - id: common_env
    type:
      - 'null'
      - boolean
    doc: Test models in common environments.
    inputBinding:
      position: 102
      prefix: --common_env
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Dont run model testing
    inputBinding:
      position: 102
      prefix: --dry_run
  - id: exitfirst
    type:
      - 'null'
      - boolean
    doc: exit instantly on first error or failed test.
    inputBinding:
      position: 102
      prefix: --exitfirst
  - id: git_range
    type:
      - 'null'
      - type: array
        items: string
    doc: "Git range (e.g. commits or something like \"master\n                   \
      \     HEAD\" to check commits in HEAD vs master, or just\n                 \
      \       \"HEAD\" to include uncommitted changes). All models\n             \
      \           modified within this range will be tested."
    inputBinding:
      position: 102
      prefix: --git-range
  - id: k
    type:
      - 'null'
      - string
    doc: "only run tests which match the given substring\n                       \
      \ expression"
    inputBinding:
      position: 102
      prefix: -k
  - id: num_of_shards
    type:
      - 'null'
      - int
    doc: Number of shards
    inputBinding:
      position: 102
      prefix: --num_of_shards
  - id: shard_id
    type:
      - 'null'
      - int
    doc: Shard id
    inputBinding:
      position: 102
      prefix: --shard_id
  - id: singularity
    type:
      - 'null'
      - boolean
    doc: Test models within their singularity containers
    inputBinding:
      position: 102
      prefix: --singularity
  - id: vep
    type:
      - 'null'
      - string
    doc: "This argument is deprecated. Please use\n                        https://github.com/kipoi/kipoi-veff2
      directly"
    inputBinding:
      position: 102
      prefix: --vep
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase output verbosity. Show conda stdout during\n                  \
      \      env installation."
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kipoi:0.8.6--pyh5e36f6f_0
stdout: kipoi_test-source.out
