cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - danpos.py
  - dpos
label: danpos_dpos
doc: "Analyze dynamics of nucleosome positions (DANPOS dpos): call positions and their occupancy, position and fuzziness changes between samples.\n\nTool homepage: https://sites.google.com/site/danposdoc/"
requirements:
  - class: InlineJavascriptRequirement
arguments:
  - position: 1
    valueFrom: |-
      ${ var r = [];
         for (var i = 0; i < inputs.input_paths.length; i++) {
           var s = inputs.input_paths[i].path;
           if (inputs.control_paths && inputs.control_paths[i]) { s += ":" + inputs.control_paths[i].path; }
           r.push(s); }
         return r.join(","); }
  - position: 2
    valueFrom: |-
      ${ if (!inputs.background_paths) { return null; }
         var r = [];
         for (var i = 0; i < inputs.input_paths.length; i++) {
           var b = inputs.background_paths[i];
           r.push(inputs.input_paths[i].path + ":" + (b ? b.path : "None")); }
         return ["--bg", r.join(",")]; }
inputs:
  - id: input_paths
    type:
      type: array
      items: File
    doc: Sequencing data sets (.sam or .bam recommended; .bed, .bowtie or .wig 
      also accepted), one per group. They are joined with ',' into the <path> 
      argument.
    secondaryFiles:
      - pattern: .bai
        required: false
  - id: control_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: Optional data sets to compare against, in the same order as 
      input_paths; each pair is written as <input>:<control> (input minus 
      control).
    secondaryFiles:
      - pattern: .bai
        required: false
  - id: background_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: Optional genomic background data set for each input (same order), 
      passed with --bg as <input>:<background>.
    secondaryFiles:
      - pattern: .bai
        required: false
  - id: out
    type:
      - 'null'
      - string
    doc: A name for the output directory.
    default: result
    inputBinding:
      position: 3
      prefix: --out
  - id: paired
    type:
      - 'null'
      - int
    doc: Set to 1 if the input data is mate-pair (paired-end) reads. Default 0.
    inputBinding:
      position: 3
      prefix: --paired
  - id: pheight
    type:
      - 'null'
      - double
    doc: Occupancy/intensity P value cutoff for calling individual peaks or positions. Default 1e-10.
    inputBinding:
      position: 3
      prefix: --pheight
  - id: height
    type:
      - 'null'
      - double
    doc: Occupancy/intensity cutoff for calling individual peaks or positions. Default 0.
    inputBinding:
      position: 3
      prefix: --height
  - id: testcut
    type:
      - 'null'
      - double
    doc: P value cutoff for calling differential peaks or positions between samples. Default 0.
    inputBinding:
      position: 3
      prefix: --testcut
  - id: fdr
    type:
      - 'null'
      - int
    doc: Set to 0 if FDR values need not be calculated (slow process). Default 1.
    inputBinding:
      position: 3
      prefix: --fdr
  - id: save
    type:
      - 'null'
      - int
    doc: Save middle stage files? 0 = no, 1 = yes. Default 0.
    inputBinding:
      position: 3
      prefix: --save
  - id: width
    type:
      - 'null'
      - int
    doc: Window size used for scanning for the summit of each potential position. Default 40.
    inputBinding:
      position: 3
      prefix: --width
  - id: distance
    type:
      - 'null'
      - int
    doc: Minimal center-to-center distance between positions; closer positions are merged. Default 100.
    inputBinding:
      position: 3
      prefix: --distance
  - id: position_reference
    type:
      - 'null'
      - File
    doc: Map each defined position to a reference position in this position file.
    inputBinding:
      position: 3
      prefix: --position_reference
  - id: ratio
    type:
      - 'null'
      - double
    doc: Ratio between minimal flanking occupancy and maximal occupancy of a position used for defining shift events. Default 0.9.
    inputBinding:
      position: 3
      prefix: --ratio
  - id: edge
    type:
      - 'null'
      - int
    doc: Set to 1 to detect edges for each position. Default 0.
    inputBinding:
      position: 3
      prefix: --edge
  - id: gapfill
    type:
      - 'null'
      - int
    doc: Set to 1 to fill the gap between two neighboring positions with an additional position. Default 0.
    inputBinding:
      position: 3
      prefix: --gapfill
  - id: count
    type:
      - 'null'
      - string
    doc: Count of reads to normalize to (e.g. 10000000), or per group as <file>:<count>,...
    inputBinding:
      position: 3
      prefix: --count
  - id: span
    type:
      - 'null'
      - int
    doc: Span or step size in the generated wiggle data. Default 10.
    inputBinding:
      position: 3
      prefix: --span
  - id: smooth_width
    type:
      - 'null'
      - int
    doc: Smooth width before calling, 0 for no smoothing. Default 20.
    inputBinding:
      position: 3
      prefix: --smooth_width
  - id: exclude_low_percent
    type:
      - 'null'
      - double
    doc: Percent of extremely low occupancy positions excluded when computing normalization factors. Default 0.
    inputBinding:
      position: 3
      prefix: --exclude_low_percent
  - id: exclude_high_percent
    type:
      - 'null'
      - double
    doc: Percent of extremely high occupancy positions excluded when computing normalization factors. Default 0.
    inputBinding:
      position: 3
      prefix: --exclude_high_percent
  - id: lmd
    type:
      - 'null'
      - int
    doc: Lambda width for smoothing background data before background subtraction. Default 300.
    inputBinding:
      position: 3
      prefix: --lmd
  - id: nor
    type:
      - 'null'
      - string
    doc: Normalization method, F (fold change), S (sampling) or N (none). Default F.
    inputBinding:
      position: 3
      prefix: --nor
  - id: nor_region_file
    type:
      - 'null'
      - File
    doc: A .wig file marking regions (1) used to calculate normalization factors.
    inputBinding:
      position: 3
      prefix: --nor_region_file
  - id: nonzero
    type:
      - 'null'
      - int
    doc: Set to 1 to normalize base pairs with non-zero values to the same average. Default 0.
    inputBinding:
      position: 3
      prefix: --nonzero
  - id: clonalcut
    type:
      - 'null'
      - double
    doc: Cutoff for adjusting clonal signal (P value or read count), 0 for no adjustment. Default 0.
    inputBinding:
      position: 3
      prefix: --clonalcut
  - id: frsz
    type:
      - 'null'
      - int
    doc: Average DNA fragment size. Detected automatically by default.
    inputBinding:
      position: 3
      prefix: --frsz
  - id: mifrsz
    type:
      - 'null'
      - int
    doc: Minimal DNA fragment size when detecting frsz. Default 50.
    inputBinding:
      position: 3
      prefix: --mifrsz
  - id: mafrsz
    type:
      - 'null'
      - int
    doc: Maximal DNA fragment size when detecting frsz. Default 300.
    inputBinding:
      position: 3
      prefix: --mafrsz
  - id: extend
    type:
      - 'null'
      - int
    doc: Size each fragment is adjusted to when converting reads to occupancy. Default 80.
    inputBinding:
      position: 3
      prefix: --extend
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory with pooled/diff wiggle tracks and the called 
      positions or peaks (.xls tables)
    outputBinding:
      glob: $(inputs.out)
  - id: stdout
    type: stdout
    doc: Standard output (run log)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/danpos:v2.2.2_cv3
stdout: danpos_dpos.out
