cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ctseq
  - plot_multiple
label: ctseq_plot_multiple
doc: "Create plots for multiple samples combined.\n\nTool homepage: https://github.com/ryanhmiller/ctseq"
inputs:
  - id: run_dirs
    type: Directory[]
    doc: Directories with the results of each sequencing run to plot together 
      (each holds the *_totalMolecules.txt, *_methylatedMolecules.txt, 
      *_methylationRatio.txt and *_runStatistics.txt files). Their paths are 
      written to the '<name>_directories.txt' file that ctseq reads from 
      '--dir'.
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
arguments:
  - position: 100
    prefix: --dir
    valueFrom: $(runtime.outdir)
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: plots
    type: File[]
    doc: Combined plot PDF files
    outputBinding:
      glob: $(inputs.name)*.pdf
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.name)_directories.txt
        entry: |-
          ${
            return inputs.run_dirs.map(function(d) { return d.path; }).join("\n") + "\n";
          }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctseq:0.0.2--py_0
stdout: ctseq_plot_multiple.out
