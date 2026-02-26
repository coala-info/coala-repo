cwlVersion: v1.2
class: CommandLineTool
baseCommand: qualimap clustering
label: qualimap_clustering
doc: "QualiMap v.2.3\n\nTool homepage: http://qualimap.bioinfo.cipf.es/"
inputs:
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Size of the bin
    default: 100
    inputBinding:
      position: 101
      prefix: --bin-size
  - id: clusters
    type:
      - 'null'
      - string
    doc: Comma-separated list of cluster sizes
    inputBinding:
      position: 101
      prefix: --clusters
  - id: control_bam_files
    type: string
    doc: Comma-separated list of control BAM files
    inputBinding:
      position: 101
      prefix: --control
  - id: downstream_offset
    type:
      - 'null'
      - int
    doc: Downstream offset
    default: 500
    inputBinding:
      position: 101
      prefix: -r
  - id: experiment_name
    type:
      - 'null'
      - string
    doc: Name of the experiment
    inputBinding:
      position: 101
      prefix: --expr
  - id: fragment_length
    type:
      - 'null'
      - int
    doc: Smoothing length of a fragment
    inputBinding:
      position: 101
      prefix: --fragment-length
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
    doc: Output file for PDF report
    default: report.pdf
    inputBinding:
      position: 101
      prefix: --outfile
  - id: output_format
    type:
      - 'null'
      - string
    doc: Format of the output report (PDF, HTML or both PDF:HTML, default is 
      HTML).
    default: HTML
    inputBinding:
      position: 101
      prefix: --outformat
  - id: regions_file
    type: File
    doc: Path to regions file
    inputBinding:
      position: 101
      prefix: --regions
  - id: replicate_names
    type:
      - 'null'
      - string
    doc: Comma-separated names of the replicates
    inputBinding:
      position: 101
      prefix: --name
  - id: rscript_path
    type:
      - 'null'
      - File
    doc: Path to Rscript executable (by default it is assumed to be available 
      from system $PATH)
    inputBinding:
      position: 101
      prefix: --rscriptpath
  - id: sample_bam_files
    type: string
    doc: Comma-separated list of sample BAM files
    inputBinding:
      position: 101
      prefix: --sample
  - id: upstream_offset
    type:
      - 'null'
      - int
    doc: Upstream offset
    default: 2000
    inputBinding:
      position: 101
      prefix: -l
  - id: visualization_type
    type:
      - 'null'
      - string
    doc: 'Visualization type: heatmap or line'
    inputBinding:
      position: 101
      prefix: --viz
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qualimap:2.3--hdfd78af_0
stdout: qualimap_clustering.out
