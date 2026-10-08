cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_classify.svm
doc: "Classifies samples in a shared file into the groups of a design file with a support vector machine and reports discriminating OTUs.\n\nThe classifysvm.shared command allows you to ....\nThe classifysvm.shared command parameters are: shared, design, label, groups.\nThe label parameter is used to analyze specific labels in your input.\nThe groups parameter allows you to specify which of the groups in your designfile you would like analyzed.\nThe classifysvm.shared should be in the following format: \nclassifysvm.shared(shared=yourSharedFile, design=yourDesignFile)\n\nThe valid parameters are: shared, design, mode, evaluationfolds, trainingfolds, smoc, kernel, transform, verbose, stdthreshold, groups, label, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.shared ? inputs.shared : [])"
      - "$(inputs.design ? inputs.design : [])"
inputs:
  - id: shared
    type: File
    doc: "Shared file (mothur parameter shared=)"
  - id: design
    type: File
    doc: "Design file assigning samples to classes (mothur parameter design=)"
  - id: mode
    type:
      - 'null'
      - string
    doc: "Classification mode: rfe or classify (default rfe) (mothur parameter mode=)"
  - id: evaluationfolds
    type:
      - 'null'
      - int
    doc: "Number of cross-validation folds for evaluation (default 3) (mothur parameter evaluationfolds=)"
  - id: trainingfolds
    type:
      - 'null'
      - int
    doc: "Number of cross-validation folds for training (default 10) (mothur parameter trainingfolds=)"
  - id: smoc
    type:
      - 'null'
      - int
    doc: "Smallest OTU count; OTUs below it are removed (mothur parameter smoc=)"
  - id: kernel
    type:
      - 'null'
      - string
    doc: "SVM kernels to try, separated by dashes: linear, rbf, polynomial, sigmoid (mothur parameter kernel=)"
  - id: transform
    type:
      - 'null'
      - string
    doc: "Data transformation: zeroone or zscore (default zeroone) (mothur parameter transform=)"
  - id: verbose
    type:
      - 'null'
      - int
    doc: "Verbosity level (default 0) (mothur parameter verbose=)"
  - id: stdthreshold
    type:
      - 'null'
      - float
    doc: "Remove OTUs with standard deviation below this threshold (mothur parameter stdthreshold=)"
  - id: groups
    type:
      - 'null'
      - string
    doc: "Groups of the design file to analyze, separated by dashes (mothur parameter groups=)"
  - id: label
    type:
      - 'null'
      - string
    doc: "Distance levels to analyze, separated by dashes (mothur parameter label=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["shared", "shared"], ["design", "design"], ["mode", "mode"], ["evaluationfolds", "evaluationfolds"], ["trainingfolds", "trainingfolds"], ["smoc", "smoc"], ["kernel", "kernel"], ["transform", "transform"], ["verbose", "verbose"], ["stdthreshold", "stdthreshold"], ["groups", "groups"], ["label", "label"]];
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
        return '#classify.svm(' + opts.join(', ') + ')';
      }
outputs:
  - id: results
    type:
      type: array
      items: File
    doc: "SVM result files"
    outputBinding:
      glob: "$(['*.svmrfe', '*.svm*'])"
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
stdout: mothur_classify.svm.out
