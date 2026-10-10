cwlVersion: v1.2
class: CommandLineTool
baseCommand: fix_swath_windows.py
label: msproteomicstools_fix_swath_windows.py
doc: "Fix SWATH mzXML files by adding the precursor isolation window information
  into the file. The parameter file is a tab-delimited file with the start and end
  m/z in the 1st and 2nd column and one row per window.\n\nTool homepage: https://github.com/msproteomicstools/msproteomicstools"
inputs:
  - id: mzxml_file
    type: File
    doc: Input mzXML file (the file name must end in .mzXML)
    inputBinding:
      position: 1
  - id: paramfilename
    type: File
    doc: Parameter file containing SWATH window information (start and end m/z
      in the 1st and 2nd column, one row per window).
    inputBinding:
      position: 2
  - id: output_filename
    type: string
    doc: Output mzXML file with the fixed SWATH windows.
    inputBinding:
      position: 3
outputs:
  - id: output_file
    type: File
    doc: Output mzXML file with the fixed SWATH windows.
    outputBinding:
      glob: $(inputs.output_filename)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msproteomicstools:0.11.0--py27h6d73bfa_0
