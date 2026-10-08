cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_anosim
doc: "Non-parametric analysis of similarity (ANOSIM) between groups of samples in a distance matrix.\n\nReferenced: Clarke, K. R. (1993). Non-parametric multivariate analysis of changes in community structure.   _Australian Journal of Ecology_ 18, 117-143.\nThe anosim command outputs a .anosim file. \nThe anosim command parameters are phylip, iters, and alpha.  The phylip and design parameters are required, unless you have valid current files.\nThe design parameter allows you to assign your samples to groups when you are running anosim. It is required. \nThe design file looks like the group file.  It is a 2 column tab delimited file, where the first column is the sample name and the second column is the group the sample belongs to.\nThe iters parameter allows you to set number of randomization for the P value.  The default is 1000. \nThe anosim command should be in the following format: anosim(phylip=file.dist, design=file.design).\n\nThe valid parameters are: design, phylip, iters, alpha, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.phylip ? inputs.phylip : [])"
      - "$(inputs.design ? inputs.design : [])"
inputs:
  - id: phylip
    type: File
    doc: "Phylip-formatted distance matrix (mothur parameter phylip=)"
  - id: design
    type: File
    doc: "Design file: tab-delimited sample name and group columns (mothur parameter design=)"
  - id: iters
    type:
      - 'null'
      - int
    doc: "Number of randomizations for the P value (default 1000) (mothur parameter iters=)"
  - id: alpha
    type:
      - 'null'
      - float
    doc: "Significance level (default 0.05) (mothur parameter alpha=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["phylip", "phylip"], ["design", "design"], ["iters", "iters"], ["alpha", "alpha"], ["seed", "seed"]];
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
        return '#anosim(' + opts.join(', ') + ')';
      }
outputs:
  - id: anosim_out
    type: File
    doc: "ANOSIM results table"
    outputBinding:
      glob: "*.anosim"
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
stdout: mothur_anosim.out
