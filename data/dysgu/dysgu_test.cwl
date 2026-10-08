cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dysgu
  - test
label: dysgu_test
doc: "Run dysgu tests\n\nTool homepage: https://github.com/kcleal/dysgu"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show output of test commands
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: test_log
    type: stderr
    doc: Test log with one PASS/FAIL line per test command
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dysgu:1.8.7--py311h8ddd9a4_0
stdout: dysgu_test.out
stderr: dysgu_test.log
