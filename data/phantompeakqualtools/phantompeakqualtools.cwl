cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - run_spp.R
label: phantompeakqualtools
doc: "Computes strand cross-correlation, NSC, RSC and estimates fragment length for
  ChIP-seq data quality control, and calls peaks with SPP.\n\nTool homepage:
  https://github.com/kundajelab/phantompeakqualtools"
inputs:
  - id: chip_align_file
    type: File
    doc: "ChIP alignment file (tagAlign, tagAlign.gz, bam or bam.gz; the file extension must be one of these)"
    inputBinding:
      position: 1
      prefix: "-c="
      separate: false
  - id: input_align_file
    type:
      - 'null'
      - File
    doc: "Control (input) alignment file, mandatory for peak calling"
    inputBinding:
      position: 2
      prefix: "-i="
      separate: false
  - id: strand_shifts
    type:
      - 'null'
      - string
    doc: "strand shifts at which cross-correlation is evaluated, min:step:max (default -500:5:1500)"
    inputBinding:
      position: 3
      prefix: "-s="
      separate: false
  - id: speak
    type:
      - 'null'
      - int
    doc: "user-defined cross-correlation peak strand shift"
    inputBinding:
      position: 4
      prefix: "-speak="
      separate: false
  - id: exclude_shifts
    type:
      - 'null'
      - string
    doc: "strand shifts to exclude, min:max (default 10:(readlen+10))"
    inputBinding:
      position: 5
      prefix: "-x="
      separate: false
  - id: nodes
    type:
      - 'null'
      - int
    doc: "number of parallel processing nodes (default 0)"
    inputBinding:
      position: 6
      prefix: "-p="
      separate: false
  - id: fdr
    type:
      - 'null'
      - float
    doc: "false discovery rate threshold for peak calling"
    inputBinding:
      position: 7
      prefix: "-fdr="
      separate: false
  - id: npeak
    type:
      - 'null'
      - int
    doc: "threshold on number of peaks to call"
    inputBinding:
      position: 8
      prefix: "-npeak="
      separate: false
  - id: tmpdir
    type:
      - 'null'
      - string
    doc: "temporary directory (if not specified the R function tempdir() is used)"
    inputBinding:
      position: 9
      prefix: "-tmpdir="
      separate: false
  - id: filtchr
    type:
      - 'null'
      - string
    doc: "pattern to remove tags that map to specific chromosomes, for example _ removes all tags that map to chromosomes with _ in their name"
    inputBinding:
      position: 10
      prefix: "-filtchr="
      separate: false
  - id: savn
    type:
      - 'null'
      - string
    doc: "NarrowPeak file name (fixed width peaks), path as given (put it inside the output directory to collect it there)"
    inputBinding:
      position: 11
      prefix: "-savn="
      separate: false
  - id: savr
    type:
      - 'null'
      - string
    doc: "RegionPeak file name (variable width peaks with regions of enrichment), path as given (put it inside the output directory to collect it there)"
    inputBinding:
      position: 12
      prefix: "-savr="
      separate: false
  - id: savd
    type:
      - 'null'
      - string
    doc: "name of the Rdata file to save, path as given (put it inside the output directory to collect it there)"
    inputBinding:
      position: 13
      prefix: "-savd="
      separate: false
  - id: savp
    type:
      - 'null'
      - string
    doc: "name of the cross-correlation plot file to save, path as given (put it inside the output directory to collect it there)"
    inputBinding:
      position: 14
      prefix: "-savp="
      separate: false
  - id: out
    type:
      - 'null'
      - string
    doc: "append peakshift and phantomPeak results to this file (path as given (put it inside the output directory to collect it there))"
    inputBinding:
      position: 15
      prefix: "-out="
      separate: false
  - id: odir
    type: string
    doc: "name of the output directory (it is created before the run); without it the tool writes next to the ChIP file"
    inputBinding:
      position: 16
      prefix: "-odir="
      separate: false
  - id: rf
    type:
      - 'null'
      - boolean
    doc: "if the plot, Rdata or narrowPeak file exists, replace it"
    inputBinding:
      position: 17
      prefix: -rf
  - id: clean
    type:
      - 'null'
      - boolean
    doc: "remove the original chip and control files after reading them in (use only on temporary files)"
    inputBinding:
      position: 18
      prefix: -clean
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir
    type: Directory
    doc: Output directory with the plot, Rdata, peak files and the result table
    outputBinding:
      glob: $(inputs.odir)
  - id: narrowpeak_file
    type:
      - 'null'
      - File
    doc: NarrowPeak file written with savn (the tool adds .gz)
    outputBinding:
      glob: $(inputs.savn)*
  - id: regionpeak_file
    type:
      - 'null'
      - File
    doc: RegionPeak file written with savr (the tool adds .gz)
    outputBinding:
      glob: $(inputs.savr)*
  - id: rdata_file
    type:
      - 'null'
      - File
    doc: Rdata file written with savd
    outputBinding:
      glob: $(inputs.savd)
  - id: plot_file
    type:
      - 'null'
      - File
    doc: Cross-correlation plot written with savp
    outputBinding:
      glob: $(inputs.savp)
  - id: result_file
    type:
      - 'null'
      - File
    doc: Peakshift and phantomPeak results table written with out
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.odir)
        entry: '$({"class": "Directory", "basename": inputs.odir, "listing": []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phantompeakqualtools:1.2.2--0
stdout: phantompeakqualtools.out
