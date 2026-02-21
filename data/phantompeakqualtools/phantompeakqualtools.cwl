cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Rscript
  - run_spp.R
label: phantompeakqualtools
doc: "Computes strand cross-correlation, NSC, RSC and estimates fragment length for
  ChIP-seq data quality control.\n\nTool homepage: https://github.com/kundajelab/phantompeakqualtools"
inputs:
  - id: control_bam
    type:
      - 'null'
      - File
    doc: Input control (Input/IgG) BAM or tagAlign file
    inputBinding:
      position: 101
      prefix: -i
  - id: input_bam
    type: File
    doc: Input ChIP-seq BAM or tagAlign file
    inputBinding:
      position: 101
      prefix: -c
  - id: num_peaks
    type:
      - 'null'
      - int
    doc: Number of peaks to use for cross-correlation
    default: 300000
    inputBinding:
      position: 101
      prefix: -npeak
  - id: rf
    type:
      - 'null'
      - boolean
    doc: Force rewrite of existing output files
    inputBinding:
      position: 101
      prefix: -rf
  - id: speak
    type:
      - 'null'
      - int
    doc: User-defined strand shift
    inputBinding:
      position: 101
      prefix: -speak
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of parallel processing threads
    default: 1
    inputBinding:
      position: 101
      prefix: -p
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_directory)
  - id: save_plot
    type:
      - 'null'
      - File
    doc: Save cross-correlation plot to this file
    outputBinding:
      glob: $(inputs.save_plot)
  - id: save_rdata
    type:
      - 'null'
      - File
    doc: Save Rdata file
    outputBinding:
      glob: $(inputs.save_rdata)
  - id: output_file
    type:
      - 'null'
      - File
    doc: Append peak quality metrics to this file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phantompeakqualtools:1.2.2--0
