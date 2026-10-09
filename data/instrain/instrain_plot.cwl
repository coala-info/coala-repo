cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - inStrain
  - plot
label: instrain_plot
doc: "Make figures from the results of profile or compare\n\nTool homepage: https://github.com/MrOlm/inStrain"
inputs:
  - id: IS
    type: Directory
    doc: An inStrain profile object (plots are written into its figures folder)
    inputBinding:
      position: 101
      prefix: --IS
  - id: plots
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Plots to make. Input ''all'' or ''a'' to plot all. 1) Coverage and breadth vs. read mismatches 2) Genome-wide microdiversity metrics 3) Read-level ANI distribution 4) Major allele frequencies 5) Linkage decay 6) Read filtering plots 7) Scaffold inspection plot (large) 8) Linkage with SNP type (genes required) 9) Gene histograms (genes required) 10) Compare dendrograms (run on compare, not profile) (default: a)'
    inputBinding:
      position: 101
      prefix: --plots
  - id: minimum_breadth
    type:
      - 'null'
      - float
    doc: 'Minimum breadth of coverage for genome to make it into plot (from 0-1) (default: 0.5)'
    inputBinding:
      position: 101
      prefix: --minimum_breadth
  - id: genomes
    type:
      - 'null'
      - type: array
        items: string
    doc: Only plot genomes with the names provided in this argument
    inputBinding:
      position: 101
      prefix: --genomes
  - id: processes
    type:
      - 'null'
      - int
    doc: 'Number of processes to use (default: 6)'
    inputBinding:
      position: 101
      prefix: --processes
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Make extra debugging output (default: False)'
    inputBinding:
      position: 101
      prefix: --debug
outputs:
  - id: plot_dir
    type: Directory
    doc: The inStrain object with the figures folder filled in
    outputBinding:
      glob: $(inputs.IS.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.IS)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/instrain:1.10.0--pyhdfd78af_0
