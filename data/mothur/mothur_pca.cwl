cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_pca
doc: "Principal component analysis of a shared or relabund file.\n\nThe pca command parameters are shared, relabund, label, groups and metric.  shared or relabund is required unless you have a valid current file.The label parameter is used to analyze specific labels in your input. Default is the first label in your shared or relabund file. Multiple labels may be separated by dashes.\nThe groups parameter allows you to specify which groups you would like analyzed. Groupnames are separated by dashes.\nThe metric parameter allows you to indicate if would like the pearson correlation coefficient calculated. Default=TrueExample pca(groups=yourGroups).\nExample pca(groups=A-B-C).\n\nThe valid parameters are: shared, relabund, groups, metric, label, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.shared ? inputs.shared : [])"
      - "$(inputs.relabund ? inputs.relabund : [])"
inputs:
  - id: shared
    type:
      - 'null'
      - File
    doc: "Shared file (shared or relabund is required) (mothur parameter shared=)"
  - id: relabund
    type:
      - 'null'
      - File
    doc: "Relabund file (mothur parameter relabund=)"
  - id: groups
    type:
      - 'null'
      - string
    doc: "Groups to analyze, separated by dashes (mothur parameter groups=)"
  - id: label
    type:
      - 'null'
      - string
    doc: "Labels to analyze, separated by dashes (default first label) (mothur parameter label=)"
  - id: metric
    type:
      - 'null'
      - boolean
    doc: "Calculate the Pearson correlation coefficient (default true) (mothur parameter metric=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["shared", "shared"], ["relabund", "relabund"], ["groups", "groups"], ["label", "label"], ["metric", "metric"], ["seed", "seed"]];
        var opts = [];
        params.forEach(function (p) {
          var v = inputs[p[0]];
          if (v === null || v === undefined) { return; }
          if (Array.isArray(v)) { v = v.map(function (f) { return f.basename; }).join('-'); }
          else if (typeof v === 'object') { v = v.basename; }
          else if (typeof v === 'boolean') { v = v ? 'T' : 'F'; }
          opts.push(p[1] + '=' + v);
        });
        opts.push('outputdir=' + runtime.outdir + '/');
        return '#pca(' + opts.join(', ') + ')';
      }
outputs:
  - id: axes
    type:
      type: array
      items: File
    doc: "PCA axes per label"
    outputBinding:
      glob: "*.pca.axes"
  - id: loadings
    type:
      type: array
      items: File
    doc: "PCA loadings per label"
    outputBinding:
      glob: "*.pca.loadings"
  - id: logfile
    type:
      - 'null'
      - File
    doc: mothur log file
    outputBinding:
      glob: mothur.*.logfile
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
stdout: mothur_pca.out
