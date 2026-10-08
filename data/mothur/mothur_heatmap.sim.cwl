cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_heatmap.sim
doc: "Creates SVG heatmaps of the similarity between samples from a shared file or a distance matrix.\n\nThe heatmap.sim command parameters are shared, phylip, column, name, count, groups, calc, fontsize and label.  shared or phylip or column and name are required unless valid current files exist.\nThere are two ways to use the heatmap.sim command. The first is with a shared file, and you may use the groups, label and calc parameter. \nThe groups parameter allows you to specify which of the groups in your groupfile you would like included in your heatmap.\nThe group names are separated by dashes. The label parameter allows you to select what distance levels you would like a heatmap created for, and is also separated by dashes.\nThe fontsize parameter allows you to adjust the font size of the picture created, default=24.\nThe heatmap.sim command should be in the following format: heatmap.sim(groups=yourGroups, calc=yourCalc, label=yourLabels).\nExample heatmap.sim(groups=A-B-C, calc=jabund).\nThe default value for groups is all the groups in your groupfile, and all labels in your inputfile will be used.\nThe available estimators for calc are braycurtis, jabund, jclass, jest, morisitahorn, sorabund, sorclass, sorest, thetan, thetayc\nThe default value for calc is jclass-thetayc.\nThe heatmap.sim command outputs a .svg file for each calculator you choose at each label you specify.\nThe second way to use the heatmap.sim command is with a distance file representing the distance bewteen your groups. \nUsing the command this way, the phylip or column parameter are required, and only one may be used.  If you use a column file the name filename is required. \nThe heatmap.sim command should be in the following format: heatmap.sim(phylip=yourDistanceFile).\nExample heatmap.sim(phylip=amazonGroups.dist).\n\nThe valid parameters are: shared, phylip, name, count, column, groups, label, calc, fontsize, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.shared ? inputs.shared : [])"
      - "$(inputs.phylip ? inputs.phylip : [])"
      - "$(inputs.column ? inputs.column : [])"
      - "$(inputs.name ? inputs.name : [])"
      - "$(inputs.count ? inputs.count : [])"
inputs:
  - id: shared
    type:
      - 'null'
      - File
    doc: "Shared file (mothur parameter shared=)"
  - id: phylip
    type:
      - 'null'
      - File
    doc: "Phylip-formatted distance matrix (mothur parameter phylip=)"
  - id: column
    type:
      - 'null'
      - File
    doc: "Column-formatted distance matrix (needs name or count) (mothur parameter column=)"
  - id: name
    type:
      - 'null'
      - File
    doc: "Names file for a column distance matrix (mothur parameter name=)"
  - id: count
    type:
      - 'null'
      - File
    doc: "Count table for a column distance matrix (mothur parameter count=)"
  - id: groups
    type:
      - 'null'
      - string
    doc: "Groups to include, separated by dashes (default all) (mothur parameter groups=)"
  - id: label
    type:
      - 'null'
      - string
    doc: "Distance levels, separated by dashes (default all) (mothur parameter label=)"
  - id: calc
    type:
      - 'null'
      - string
    doc: "Calculators separated by dashes, e.g. jclass-thetayc (default) (mothur parameter calc=)"
  - id: fontsize
    type:
      - 'null'
      - int
    doc: "Font size of the picture (default 24) (mothur parameter fontsize=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["shared", "shared"], ["phylip", "phylip"], ["column", "column"], ["name", "name"], ["count", "count"], ["groups", "groups"], ["label", "label"], ["calc", "calc"], ["fontsize", "fontsize"], ["seed", "seed"]];
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
        return '#heatmap.sim(' + opts.join(', ') + ')';
      }
outputs:
  - id: heatmaps
    type:
      type: array
      items: File
    doc: "Heatmap SVG files"
    outputBinding:
      glob: "*.svg"
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
stdout: mothur_heatmap.sim.out
