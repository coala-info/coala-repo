cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastaptamer_compare
label: fastaptamer_fastaptamer_compare
doc: "FASTAptamer-Compare facilitates statistical analysis of two populations by rapidly
  generating a tab-delimited output file that lists each unique sequence along with
  RPM (reads per million) in each population file (if available) and log(base 2) of
  the ratio of their RPM values in each population.\nRPM data for both populations
  can be utilized to generate an XY-scatter plot of sequence distribution across two
  populations. FASTAptamer-Compare also facilitates the generation of a histogram
  of the sequence distribution by creating 102 bins for the log(base2) values. This
  histogram can provide a quick visual comparison of the two populations: distributions
  centered around 0 indicate similar populations, while distributions shifted to the
  left or right indicate overall enrichment or depletion.\nInput for FASTAptamer-Compare
  MUST come from FASTAptamer-Count output files.\n\nTool homepage: http://burkelab.missouri.edu/fastaptamer.html"
inputs:
  - id: input_file_x
    type: File
    doc: Input file (from FASTAptamer-Count)
    inputBinding:
      position: 101
      prefix: -x
  - id: input_file_y
    type: File
    doc: Input file (from FASTAptamer-Count)
    inputBinding:
      position: 101
      prefix: -y
  - id: output_all_sequences
    type:
      - 'null'
      - boolean
    doc: Output all sequences, including those present in only one input file. 
      Default behavior suppresses output of sequences without a match.
    inputBinding:
      position: 101
      prefix: -a
  - id: quiet_mode
    type:
      - 'null'
      - boolean
    doc: Quiet mode. Suppresses standard output of file I/O and execution time.
    inputBinding:
      position: 101
      prefix: -q
outputs:
  - id: output_file
    type: File
    doc: Plain text output file with tab separated values
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastaptamer:1.0.16--hdfd78af_0
