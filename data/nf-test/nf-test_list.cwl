cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nf-test, list]
label: nf-test_list
doc: "List all tests (or all tags) of an nf-test project\n\nTool homepage: https://code.askimed.com/nf-test/"
requirements:
  - class: InlineJavascriptRequirement
  - class: LoadListingRequirement
    loadListing: shallow_listing
  - class: InitialWorkDirRequirement
    listing: |
      ${
        return inputs.project_dir.listing.map(function (f) {
          return {"entry": f, "writable": true};
        });
      }
inputs:
  - id: project_dir
    type: Directory
    doc: "nf-test project directory (contains nf-test.config, made by nf-test init, and the Nextflow source files); its content is copied into the work directory"
  - id: debug
    type: ['null', boolean]
    doc: Show debugging infos
    inputBinding:
      position: 1
      prefix: --debug
  - id: format
    type: ['null', string]
    doc: "Output format (default: PRETTY)"
    inputBinding:
      position: 1
      prefix: --format=
      separate: false
  - id: log
    type: ['null', string]
    doc: "Filename for log file (default: .nf-test.log)"
    inputBinding:
      position: 1
      prefix: --log=
      separate: false
  - id: silent
    type: ['null', boolean]
    doc: Hide header and program version
    inputBinding:
      position: 1
      prefix: --silent
  - id: tags
    type: ['null', boolean]
    doc: Show all available tags
    inputBinding:
      position: 1
      prefix: --tags
  - id: test_paths
    type:
      - 'null'
      - type: array
        items: string
    doc: List the tests in these paths
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: List of tests
stdout: nf-test_list.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-test:0.9.4--h2a3209d_0
