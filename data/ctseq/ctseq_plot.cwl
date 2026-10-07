cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ctseq
  - plot
label: ctseq_plot
doc: "Generate plots from CT-seq data.\n\nTool homepage: https://github.com/ryanhmiller/ctseq"
inputs:
  - id: directory
    type: Directory
    doc: Path to directory where you have your plot input files. If no '--dir' 
      is specified, ctseq will look in your current directory.
    inputBinding:
      position: 101
      prefix: --dir
  - id: frag_info
    type: File
    doc: Name of file containing your fragment info file for this sequencing 
      run. If not in same directory as your plot input files, please designate 
      full path to the 'fragInfo' file. See documentation for more info
    inputBinding:
      position: 101
      prefix: --fragInfo
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: Directory with the plot PDF files added
    outputBinding:
      glob: $(inputs.directory.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.directory)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctseq:0.0.2--py_0
stdout: ctseq_plot.out
