cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_remove.dists
doc: "Removes distances from a phylip or column file for the sequences or groups in an accnos file.\n\nThe remove.dists command removes distances from a phylip or column file related to groups or sequences listed in an accnos file.\nThe remove.dists command parameters are accnos, phylip and column.\nThe remove.dists command should be in the following format: get.dists(accnos=yourAccnos, phylip=yourPhylip).\nExample remove.dists(accnos=final.accnos, phylip=final.an.thetayc.0.03.lt.ave.dist).\n\nThe valid parameters are: phylip, column, accnos, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.accnos ? inputs.accnos : [])"
      - "$(inputs.phylip ? inputs.phylip : [])"
      - "$(inputs.column ? inputs.column : [])"
inputs:
  - id: accnos
    type: File
    doc: "Accnos file of names to remove (mothur parameter accnos=)"
  - id: phylip
    type:
      - 'null'
      - File
    doc: "Phylip distance matrix (mothur parameter phylip=)"
  - id: column
    type:
      - 'null'
      - File
    doc: "Column distance matrix (mothur parameter column=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["accnos", "accnos"], ["phylip", "phylip"], ["column", "column"], ["seed", "seed"]];
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
        return '#remove.dists(' + opts.join(', ') + ')';
      }
outputs:
  - id: phylip_out
    type:
      - 'null'
      - File
    doc: "Phylip matrix without the removed names"
    outputBinding:
      glob: "$(inputs.phylip ? inputs.phylip.nameroot + '.pick' + inputs.phylip.nameext : [])"
  - id: column_out
    type:
      - 'null'
      - File
    doc: "Column matrix without the removed names"
    outputBinding:
      glob: "$(inputs.column ? inputs.column.nameroot + '.pick' + inputs.column.nameext : [])"
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
stdout: mothur_remove.dists.out
