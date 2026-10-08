cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_kruskal.wallis
doc: "Runs a Kruskal-Wallis test on each OTU of a shared file between the classes of a design file.\n\nThe kruskal.wallis command allows you to ....\nThe kruskal.wallis command parameters are: shared, design, class, label and classes.\nThe class parameter is used to indicate the which category you would like used for the Kruskal Wallis analysis. If none is provided first category is used.\nThe label parameter is used to indicate which distances in the shared file you would like to use. labels are separated by dashes.\nThe kruskal.wallis command should be in the following format: kruskal.wallis(shared=final.an.shared, design=final.design, class=treatment).\n\nThe valid parameters are: design, shared, class, label, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
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
    doc: "Design file (mothur parameter design=)"
  - id: design_class
    type:
      - 'null'
      - string
    doc: "Design category to use (default first category) (mothur parameter class=)"
  - id: label
    type:
      - 'null'
      - string
    doc: "Distance levels to use, separated by dashes (mothur parameter label=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["shared", "shared"], ["design", "design"], ["design_class", "class"], ["label", "label"], ["seed", "seed"]];
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
        return '#kruskal.wallis(' + opts.join(', ') + ')';
      }
outputs:
  - id: results
    type:
      type: array
      items: File
    doc: "Kruskal-Wallis results per label"
    outputBinding:
      glob: "*.kruskall_wallis"
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
stdout: mothur_kruskal.wallis.out
