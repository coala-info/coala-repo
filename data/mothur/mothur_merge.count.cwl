cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_merge.count
doc: "Merges count tables into one file.\n\nThe merge.count command takes a list of count files separated by dashes and merges them into one file.The merge.count command parameters are count and output.Example merge.count(count=final.count_table-new.count_table, output=complete.count_table).\nThe valid parameters are: count, output, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.count ? inputs.count : [])"
inputs:
  - id: count
    type:
      type: array
      items: File
    doc: "Count tables to merge (mothur parameter count=)"
  - id: output
    type: string
    doc: "Name of the merged count table (mothur parameter output=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["count", "count"], ["output", "output"], ["seed", "seed"]];
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
        return '#merge.count(' + opts.join(', ') + ')';
      }
outputs:
  - id: merged
    type: File
    doc: "Merged count table"
    outputBinding:
      glob: "$(inputs.output)"
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
stdout: mothur_merge.count.out
