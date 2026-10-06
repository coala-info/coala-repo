cwlVersion: v1.2
class: CommandLineTool
baseCommand: NBICseq-norm.pl
label: bicseq2-norm_BICseq2-norm.pl
doc: "BIC-seq2 normalization (NBICseq-norm.pl) for bias correction in NGS read
  counts. The config file is tab-separated with a header line and the columns
  chromName, faFile, MapFile, readPosFile, binFileNorm. Give the files it names
  in data_files and use their base names in the config.\n\nTool homepage: http://compbio.med.harvard.edu/BIC-seq/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.data_files)
inputs:
  - id: config_file
    type: File
    loadContents: true
    doc: Tab-separated configuration file (header line, then chromName, faFile,
      MapFile, readPosFile, binFileNorm per chromosome)
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - string
    doc: Output file that stores the parameter estimate of the Negative Binomial
      model (required unless bin_only is set)
    inputBinding:
      position: 2
  - id: data_files
    type:
      type: array
      items: File
    doc: FASTA, mappability and read position files named in the config file
  - id: read_length
    type:
      - 'null'
      - int
    doc: Read length
    inputBinding:
      position: 102
      prefix: -l
  - id: fragment_size
    type:
      - 'null'
      - int
    doc: Fragment size
    inputBinding:
      position: 102
      prefix: -s
  - id: subsample_percentage
    type:
      - 'null'
      - float
    doc: 'A subsample percentage: default 0.0002'
    inputBinding:
      position: 102
      prefix: -p
  - id: bin_size
    type:
      - 'null'
      - int
    doc: Bin the expected and observed as <int> bp bins; Default 100
    inputBinding:
      position: 102
      prefix: -b
  - id: gc_bin
    type:
      - 'null'
      - boolean
    doc: If specified, report the GC-content in the bins
    inputBinding:
      position: 102
      prefix: --gc_bin
  - id: no_map_bin
    type:
      - 'null'
      - boolean
    doc: If specified, do NOT bin the reads according to the mappability
    inputBinding:
      position: 102
      prefix: --NoMapBin
  - id: bin_only
    type:
      - 'null'
      - boolean
    doc: Only bin the reads without normalization
    inputBinding:
      position: 102
      prefix: --bin_only
  - id: fig
    type:
      - 'null'
      - string
    doc: Plot the read count VS GC figure in the specified file (in pdf format)
    inputBinding:
      position: 102
      prefix: --fig
  - id: title
    type:
      - 'null'
      - string
    doc: Title of the figure
    inputBinding:
      position: 102
      prefix: --title
  - id: tmp_dir
    type: string
    default: bicseq2_tmp
    doc: The tmp directory (the tool default inside the image is not writable)
    inputBinding:
      position: 102
      prefix: --tmp
outputs:
  - id: parameter_estimate
    type:
      - 'null'
      - File
    doc: Parameter estimate of the Negative Binomial model
    outputBinding:
      glob: $(inputs.output)
  - id: normalized_bins
    type:
      type: array
      items: File
    doc: Normalized bin files named in the binFileNorm column of the config file
    outputBinding:
      glob: |-
        ${
          var lines = inputs.config_file.contents.split(/\r?\n/).slice(1);
          var names = [];
          for (var i = 0; i < lines.length; i++) {
            var row = lines[i].split("\t");
            if (row.length == 5) { names.push(row[4]); }
          }
          return names;
        }
  - id: figure
    type:
      - 'null'
      - File
    doc: Read count VS GC figure
    outputBinding:
      glob: $(inputs.fig)
  - id: log
    type: stdout
    doc: Standard output with the commands run
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bicseq2-norm:0.2.4--h7b50bb2_6
stdout: bicseq2-norm.log
