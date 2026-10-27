cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xpore
  - postprocessing
label: xpore_postprocessing
doc: "Performs postprocessing steps for xpore-diffmod output.\n\nTool homepage: https://github.com/GoekeLab/xpore"
inputs:
  - id: diffmod_dir
    type: Directory
    doc: diffmod directory path, the output from xpore-diffmod.
    inputBinding:
      position: 101
      prefix: --diffmod_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: postprocessed_dir
    type: Directory
    doc: The diffmod directory with the added postprocessing result files.
    outputBinding:
      glob: $(inputs.diffmod_dir.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.diffmod_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xpore:2.1--pyh5e36f6f_0
stdout: xpore_postprocessing.out
