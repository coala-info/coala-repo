cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaphor_test
label: metaphor_test
doc: "Run Metaphor tests.\n\nTool homepage: https://github.com/vinisalazar/metaphor"
inputs:
  - id: coassembly
    type:
      - 'null'
      - boolean
    doc: Whether to run tests in coassembly mode, i.e. all samples are pooled 
      together and assembled.
    inputBinding:
      position: 101
      prefix: --coassembly
  - id: confirm
    type:
      - 'null'
      - boolean
    doc: Don't ask for confirmation when running tests.
    inputBinding:
      position: 101
      prefix: --confirm
  - id: cores
    type:
      - 'null'
      - int
    doc: Number of processors to use in tests.
    inputBinding:
      position: 101
      prefix: --cores
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Directory to run tests.
    inputBinding:
      position: 101
      prefix: --directory
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: Whether to run tests as a dry-run only (used for CI).
    inputBinding:
      position: 101
      prefix: --dry-run
  - id: extras
    type:
      - 'null'
      - string
    doc: String of extra arguments to be passed on to Snakemake.
    inputBinding:
      position: 101
      prefix: --extras
  - id: join_units
    type:
      - 'null'
      - boolean
    doc: Also known as 'run merging' in some workflows. If this option is on, 
      files with the same preffix but with S001, S002, S00N distinctions in the 
      filenames will be treated as different units of the same sample, i.e. they
      will be joined into a single file. This is useful for multiple sequencing 
      lanes for the same sample.
    inputBinding:
      position: 101
      prefix: --join-units
  - id: max_mb
    type:
      - 'null'
      - int
    doc: Amount of RAM to use in tests.
    inputBinding:
      position: 101
      prefix: --max_mb
  - id: profile
    type:
      - 'null'
      - string
    doc: Profile to be used to run Metaphor.
    inputBinding:
      position: 101
      prefix: --profile
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphor:1.7.14--pyhdfd78af_0
stdout: metaphor_test.out
