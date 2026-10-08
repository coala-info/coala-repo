cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_indicator
doc: "Calculates the indicator value of each OTU for groups or tree nodes.\n\nThe indicator command can be run in 3 ways: with a shared or relabund file and a design file, or with a shared or relabund file and a tree file, or with a shared or relabund file, tree file and design file. \nThe indicator command outputs a .indicator.summary file and a .indicator.tre if a tree is given. \nThe new tree contains labels at each internal node.  The label is the node number so you can relate the tree to the summary file.\nThe summary file lists the indicator value for each OTU for each node.\nThe indicator command parameters are tree, groups, shared, relabund, design and label. \nThe design parameter allows you to relate the tree to the shared or relabund file, if your tree contains the grouping names, or if no tree is provided to group your groups into groupings.\nThe groups parameter allows you to specify which of the groups in your shared or relabund you would like analyzed, or if you provide a design file the groups in your design file.  The groups may be entered separated by dashes.\nThe label parameter indicates at what distance your tree relates to the shared or relabund.\nThe processors parameter allows you to specify how many processors you would like to use.  The default is 1. \nThe iters parameter allows you to set number of randomization for the P value.  The default is 1000.The indicator command should be used in the following format: indicator(tree=test.tre, shared=test.shared, label=0.03)\n\nThe valid parameters are: iters, design, shared, relabund, groups, label, tree, seed, inputdir, outputdir, and processors.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.shared ? inputs.shared : [])"
      - "$(inputs.relabund ? inputs.relabund : [])"
      - "$(inputs.design ? inputs.design : [])"
      - "$(inputs.tree ? inputs.tree : [])"
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
  - id: design
    type:
      - 'null'
      - File
    doc: "Design file grouping samples (mothur parameter design=)"
  - id: tree
    type:
      - 'null'
      - File
    doc: "Newick tree file (mothur parameter tree=)"
  - id: groups
    type:
      - 'null'
      - string
    doc: "Groups to analyze, separated by dashes (mothur parameter groups=)"
  - id: label
    type:
      - 'null'
      - string
    doc: "Distance level the tree relates to (mothur parameter label=)"
  - id: iters
    type:
      - 'null'
      - int
    doc: "Number of randomizations for the P value (default 1000) (mothur parameter iters=)"
  - id: processors
    type:
      - 'null'
      - int
    doc: "Number of processors to use (mothur default: all available) (mothur parameter processors=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["shared", "shared"], ["relabund", "relabund"], ["design", "design"], ["tree", "tree"], ["groups", "groups"], ["label", "label"], ["iters", "iters"], ["processors", "processors"], ["seed", "seed"]];
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
        return '#indicator(' + opts.join(', ') + ')';
      }
outputs:
  - id: summary
    type: File
    doc: "Indicator value per OTU"
    outputBinding:
      glob: "*.indicator.summary"
  - id: tree_out
    type:
      - 'null'
      - File
    doc: "Tree with node numbers as labels (when a tree is given)"
    outputBinding:
      glob: "*.indicator.tre"
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
stdout: mothur_indicator.out
