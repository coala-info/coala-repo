cwlVersion: v1.2
class: CommandLineTool
baseCommand: qualimap multi-bamqc
label: qualimap_multi-bamqc
doc: "Multi-sample BAM quality control analysis\n\nTool homepage: http://qualimap.bioinfo.cipf.es/"
inputs:
  - id: data
    type: File
    doc: 'File describing the input data. Format of the file is a 2- or 3-column tab-delimited
      table. Column 1: sample name Column 2: either path to the BAM QC result or path
      to BAM file (-r mode) Column 3: group name (activates sample group marking)'
    inputBinding:
      position: 101
      prefix: --data
  - id: feature_file
    type:
      - 'null'
      - File
    doc: Only for -r mode. Feature file with regions of interest in GFF/GTF or 
      BED format
    inputBinding:
      position: 101
      prefix: --feature-file
  - id: homopolymer_min_size
    type:
      - 'null'
      - int
    doc: Only for -r mode. Minimum size for a homopolymer to be considered in 
      indel analysis (default is 3)
    inputBinding:
      position: 101
      prefix: --hm
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output folder for HTML report and raw data.
    inputBinding:
      position: 101
      prefix: --outdir
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for PDF report (default value is report.pdf).
    inputBinding:
      position: 101
      prefix: --outfile
  - id: output_format
    type:
      - 'null'
      - string
    doc: Format of the output report (PDF, HTML or both PDF:HTML, default is 
      HTML).
    inputBinding:
      position: 101
      prefix: --outformat
  - id: paint_chromosome_limits
    type:
      - 'null'
      - boolean
    doc: Only for -r mode. Paint chromosome limits inside charts
    inputBinding:
      position: 101
      prefix: --paint-chromosome-limits
  - id: reads_analyzed_chunk
    type:
      - 'null'
      - int
    doc: Only for -r mode. Number of reads analyzed in a chunk (default is 1000)
    inputBinding:
      position: 101
      prefix: --nr
  - id: run_bamqc
    type:
      - 'null'
      - boolean
    doc: Raw BAM files are provided as input. If this option is activated BAM QC
      process first will be run for each sample, then multi-sample analysis will
      be performed.
    inputBinding:
      position: 101
      prefix: --run-bamqc
  - id: sequencing_protocol
    type:
      - 'null'
      - string
    doc: 'Only for -r mode. Sequencing library protocol: strand-specific-forward,
      strand-specific-reverse or non-strand-specific (default)'
    inputBinding:
      position: 101
      prefix: --sequencing-protocol
  - id: windows
    type:
      - 'null'
      - int
    doc: Only for -r mode. Number of windows (default is 400)
    inputBinding:
      position: 101
      prefix: --nw
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qualimap:2.3--hdfd78af_0
stdout: qualimap_multi-bamqc.out
