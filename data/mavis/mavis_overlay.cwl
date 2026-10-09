cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mavis
  - overlay
label: mavis_overlay
doc: "Draws a gene and its surrounding genomic context, including read depth plots
  and markers.\n\nTool homepage: https://github.com/bcgsc/mavis.git"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.reference_files || [])
      - entryname: $(inputs.output_path)
        entry: "$({class: 'Directory', basename: inputs.output_path, listing: []})"
        writable: true
arguments:
  - position: 106
    valueFrom: |
      ${
        var out = [];
        (inputs.read_depth_plot || []).forEach(function (spec) {
          out.push('--read_depth_plot');
          spec.trim().split(/\s+/).forEach(function (w) { out.push(w); });
        });
        (inputs.marker || []).forEach(function (spec) {
          out.push('--marker');
          spec.trim().split(/\s+/).forEach(function (w) { out.push(w); });
        });
        return out;
      }
inputs:
  - id: gene_name
    type: string
    doc: Gene ID or gene alias to be drawn
    inputBinding:
      position: 1
  - id: buffer_length
    type:
      - 'null'
      - int
    doc: minimum genomic length to plot on either side of the target gene
    inputBinding:
      position: 102
      prefix: --buffer_length
  - id: config
    type: File
    doc: path to the JSON config file
    inputBinding:
      position: 102
      prefix: --config
  - id: reference_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files named in the config file or in read_depth_plot (annotations, BAM
      files and their indexes). They are staged in the working directory so
      relative paths resolve.
  - id: log
    type:
      - 'null'
      - string
    doc: redirect stdout to a log file
    inputBinding:
      position: 102
      prefix: --log
  - id: log_level
    type:
      - 'null'
      - string
    doc: level of logging to output
    inputBinding:
      position: 102
      prefix: --log_level
  - id: marker
    type:
      - 'null'
      - type: array
        items: string
    doc: "Marker on the diagram given by genomic position, May be a single position
      or a range. Each item is one marker written as 'label start [end]'; the
      option is repeated for each item. The label should be a short descriptor to
      avoid overlapping labels on the diagram"
  - id: read_depth_plot
    type:
      - 'null'
      - type: array
        items: string
    doc: "bam file to use as data for plotting read_depth. Each item is one plot
      written as 'axis_name bam_file [density] [ymax] [stranded]'; the option is
      repeated for each item. The BAM file name must be the name of a file in
      reference_files"
  - id: output_path
    type: string
    doc: path to the output directory
    inputBinding:
      position: 103
      prefix: --output
outputs:
  - id: output
    type: Directory
    doc: path to the output directory
    outputBinding:
      glob: $(inputs.output_path)
  - id: log_file
    type:
      - 'null'
      - File
    doc: log file
    outputBinding:
      glob: $(inputs.log)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mavis:3.1.2--pyhdfd78af_0
