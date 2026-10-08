cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_remove.otus
doc: "Removes OTUs listed in an accnos file or selected by classify.otu, otu.association or corr.axes output from a list or shared file.\n\nThe remove.otus command can be used to remove specific otus with the output from classify.otu, otu.association, or corr.axes. It can also be used to select a set of otus from a shared or list file.\nThe remove.otus parameters are: constaxonomy, otucorr, corraxes, shared, list, label and accnos.\nThe constaxonomy parameter is input the results of the classify.otu command.\nThe otucorr parameter is input the results of the otu.association command.\nThe corraxes parameter is input the results of the corr.axes command.\nThe label parameter is used to analyze specific labels in your input. \nThe remove.otus commmand should be in the following format: \nremove.otus(accnos=yourListOfOTULabels, corraxes=yourCorrAxesFile)\n\nThe valid parameters are: accnos, constaxonomy, otucorr, corraxes, list, shared, label, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.accnos ? inputs.accnos : [])"
      - "$(inputs.constaxonomy ? inputs.constaxonomy : [])"
      - "$(inputs.otucorr ? inputs.otucorr : [])"
      - "$(inputs.corraxes ? inputs.corraxes : [])"
      - "$(inputs.list ? inputs.list : [])"
      - "$(inputs.shared ? inputs.shared : [])"
inputs:
  - id: accnos
    type:
      - 'null'
      - File
    doc: "Accnos file of OTU labels (mothur parameter accnos=)"
  - id: constaxonomy
    type:
      - 'null'
      - File
    doc: "classify.otu consensus taxonomy output (mothur parameter constaxonomy=)"
  - id: otucorr
    type:
      - 'null'
      - File
    doc: "otu.association output (mothur parameter otucorr=)"
  - id: corraxes
    type:
      - 'null'
      - File
    doc: "corr.axes output (mothur parameter corraxes=)"
  - id: list
    type:
      - 'null'
      - File
    doc: "OTU list file (mothur parameter list=)"
  - id: shared
    type:
      - 'null'
      - File
    doc: "Shared file (mothur parameter shared=)"
  - id: label
    type:
      - 'null'
      - string
    doc: "Label to analyze (mothur parameter label=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["accnos", "accnos"], ["constaxonomy", "constaxonomy"], ["otucorr", "otucorr"], ["corraxes", "corraxes"], ["list", "list"], ["shared", "shared"], ["label", "label"], ["seed", "seed"]];
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
        return '#remove.otus(' + opts.join(', ') + ')';
      }
outputs:
  - id: list_out
    type:
      type: array
      items: File
    doc: "Picked list file"
    outputBinding:
      glob: "$(inputs.list ? inputs.list.nameroot + '.*.pick' + inputs.list.nameext : [])"
  - id: shared_out
    type:
      type: array
      items: File
    doc: "Picked shared file"
    outputBinding:
      glob: "$(inputs.shared ? inputs.shared.nameroot + '.*.pick' + inputs.shared.nameext : [])"
  - id: constaxonomy_out
    type:
      - 'null'
      - File
    doc: "Picked constaxonomy"
    outputBinding:
      glob: "$(inputs.constaxonomy ? inputs.constaxonomy.nameroot + '.pick' + inputs.constaxonomy.nameext : [])"
  - id: otucorr_out
    type:
      - 'null'
      - File
    doc: "Picked otu.corr"
    outputBinding:
      glob: "$(inputs.otucorr ? inputs.otucorr.nameroot + '.pick' + inputs.otucorr.nameext : [])"
  - id: corraxes_out
    type:
      - 'null'
      - File
    doc: "Picked corr.axes"
    outputBinding:
      glob: "$(inputs.corraxes ? inputs.corraxes.nameroot + '.pick' + inputs.corraxes.nameext : [])"
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
stdout: mothur_remove.otus.out
