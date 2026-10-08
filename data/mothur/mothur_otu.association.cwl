cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_otu.association
doc: "Calculates correlation coefficients between OTUs, or between OTUs and metadata.\n\nThe otu.association command reads a shared or relabund file and calculates the correlation coefficients between otus.\nIf you provide a metadata file, mothur will calculate te correlation bewteen the metadata and the otus.\nThe otu.association command parameters are shared, relabund, metadata, groups, method, cutoff and label.  The shared or relabund parameter is required.\nThe groups parameter allows you to specify which of the groups you would like included. The group names are separated by dashes.\nThe label parameter allows you to select what distances level you would like used, and are also separated by dashes.\nThe cutoff parameter allows you to set a pvalue at which the otu will be reported.\nThe method parameter allows you to select what method you would like to use. Options are pearson, spearman and kendall. Default=pearson.\nThe otu.association command should be in the following format: otu.association(shared=yourSharedFile, method=yourMethod).\nExample otu.association(shared=genus.pool.shared, method=kendall).\nThe otu.association command outputs a .otu.corr file.\n\nThe valid parameters are: shared, relabund, metadata, cutoff, label, groups, method, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.shared ? inputs.shared : [])"
      - "$(inputs.relabund ? inputs.relabund : [])"
      - "$(inputs.metadata ? inputs.metadata : [])"
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
  - id: metadata
    type:
      - 'null'
      - File
    doc: "Metadata file; correlations with the metadata are calculated (mothur parameter metadata=)"
  - id: cutoff
    type:
      - 'null'
      - float
    doc: "P-value cutoff for reported OTUs (mothur parameter cutoff=)"
  - id: label
    type:
      - 'null'
      - string
    doc: "Distance levels, separated by dashes (mothur parameter label=)"
  - id: groups
    type:
      - 'null'
      - string
    doc: "Groups to include, separated by dashes (mothur parameter groups=)"
  - id: method
    type:
      - 'null'
      - string
    doc: "pearson, spearman or kendall (default pearson) (mothur parameter method=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["shared", "shared"], ["relabund", "relabund"], ["metadata", "metadata"], ["cutoff", "cutoff"], ["label", "label"], ["groups", "groups"], ["method", "method"], ["seed", "seed"]];
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
        return '#otu.association(' + opts.join(', ') + ')';
      }
outputs:
  - id: corr
    type:
      type: array
      items: File
    doc: "Correlation coefficient files"
    outputBinding:
      glob: "*.otu.corr"
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
stdout: mothur_otu.association.out
