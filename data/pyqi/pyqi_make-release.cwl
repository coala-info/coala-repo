cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyqi
  - make-release
label: pyqi_make-release
doc: "Do all the things for a release\n\nTool homepage: https://github.com/qir-alliance/pyqir"
inputs:
  - id: package_name
    type: string
    doc: The name of the package to release
    inputBinding:
      position: 101
      prefix: --package-name
  - id: real_run
    type:
      - 'null'
      - boolean
    doc: Perform a real run
    default: false
    inputBinding:
      position: 101
      prefix: --real-run
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyqi:0.3.2--py27_1
stdout: pyqi_make-release.out
