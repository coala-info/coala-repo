cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ariba
  - prepareref_tb
label: ariba_prepareref_tb
doc: "Prepare built-in TB reference data for running the pipeline with \"ariba run\"\n\nTool homepage: https://github.com/sanger-pathogens/ariba"
inputs:
  - id: outdir
    type: string
    doc: "Output directory (must not already exist)"
    default: prepareref_tb_out
    inputBinding:
      position: 10
outputs:
  - id: prepareref_dir
    type: Directory
    doc: Prepared TB reference directory, input to ariba run
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
