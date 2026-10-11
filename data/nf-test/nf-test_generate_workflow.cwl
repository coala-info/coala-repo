cwlVersion: v1.2
class: CommandLineTool
baseCommand: [nf-test, generate, workflow]
label: nf-test_generate_workflow
doc: "Generate nf-test test files for Nextflow workflows in the given source files\n\nTool homepage: https://code.askimed.com/nf-test/"
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
  - id: source_files
    type:
      type: array
      items: string
    doc: Nextflow source files (relative to the project directory)
    inputBinding:
      position: 1
outputs:
  - id: tests_dir
    type: Directory
    doc: The tests directory with the generated .nf.test files
    outputBinding:
      glob: tests
  - id: stdout
    type: stdout
    doc: Standard output
stdout: nf-test_generate_workflow.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nf-test:0.9.4--h2a3209d_0
