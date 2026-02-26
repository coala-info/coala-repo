cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ctseq
  - plot_multiple
label: ctseq_plot_multiple
doc: "Create plots for multiple samples combined.\n\nTool homepage: https://github.com/ryanhmiller/ctseq"
inputs:
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Path to directory where you want your plots to be created. If no path 
      is given, ctseq will create the plots in your current working directory. 
      Remember to include a file ending in '_directories.txt' containing the 
      paths of the directories containing the data you want to plot
    inputBinding:
      position: 101
      prefix: --dir
  - id: frag_info
    type: File
    doc: Name of file containing your fragment info file for these combined 
      plots. If not in same directory as your current working directory, please 
      designate full path to the 'fragInfo' file. See documentation for more 
      info
    inputBinding:
      position: 101
      prefix: --fragInfo
  - id: name
    type: string
    doc: Desired name to be used as the prefix for the file names of these plots
    inputBinding:
      position: 101
      prefix: --name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctseq:0.0.2--py_0
stdout: ctseq_plot_multiple.out
