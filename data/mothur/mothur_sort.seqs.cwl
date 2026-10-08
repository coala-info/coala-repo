cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_sort.seqs
doc: "Puts the sequences of accnos, fasta, name, taxonomy, flow or quality files in the same order.\n\nThe sort.seqs command puts the sequences in the same order for the following file types: accnos fasta, name, taxonomy, flow or quality file.\nThe sort.seqs command parameters are accnos, fasta, name, taxonomy, flow, qfile and large.\nThe accnos file allows you to specify the order you want the files in.  If none is provided, mothur will use the order of the first file it reads.\nThe large parameters is used to indicate your files are too large to fit in RAM.\nThe sort.seqs command should be in the following format: sort.seqs(fasta=yourFasta).\nExample sort.seqs(fasta=amazon.fasta).\n\nThe valid parameters are: fasta, flow, name, taxonomy, qfile, large, accnos, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.fasta ? inputs.fasta : [])"
      - "$(inputs.flow ? inputs.flow : [])"
      - "$(inputs.name ? inputs.name : [])"
      - "$(inputs.taxonomy ? inputs.taxonomy : [])"
      - "$(inputs.qfile ? inputs.qfile : [])"
      - "$(inputs.accnos ? inputs.accnos : [])"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Fasta file (mothur parameter fasta=)"
  - id: flow
    type:
      - 'null'
      - File
    doc: "Flow file (mothur parameter flow=)"
  - id: name
    type:
      - 'null'
      - File
    doc: "Names file (mothur parameter name=)"
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: "Taxonomy file (mothur parameter taxonomy=)"
  - id: qfile
    type:
      - 'null'
      - File
    doc: "Quality file (mothur parameter qfile=)"
  - id: accnos
    type:
      - 'null'
      - File
    doc: "Accnos file giving the order (default: order of the first file read) (mothur parameter accnos=)"
  - id: large
    type:
      - 'null'
      - boolean
    doc: "Files are too large to fit in RAM (mothur parameter large=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["fasta", "fasta"], ["flow", "flow"], ["name", "name"], ["taxonomy", "taxonomy"], ["qfile", "qfile"], ["accnos", "accnos"], ["large", "large"], ["seed", "seed"]];
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
        return '#sort.seqs(' + opts.join(', ') + ')';
      }
outputs:
  - id: fasta_out
    type:
      - 'null'
      - File
    doc: "Sorted fasta"
    outputBinding:
      glob: "$(inputs.fasta ? inputs.fasta.nameroot + '.sorted' + inputs.fasta.nameext : [])"
  - id: flow_out
    type:
      - 'null'
      - File
    doc: "Sorted flow"
    outputBinding:
      glob: "$(inputs.flow ? inputs.flow.nameroot + '.sorted' + inputs.flow.nameext : [])"
  - id: name_out
    type:
      - 'null'
      - File
    doc: "Sorted names"
    outputBinding:
      glob: "$(inputs.name ? inputs.name.nameroot + '.sorted' + inputs.name.nameext : [])"
  - id: taxonomy_out
    type:
      - 'null'
      - File
    doc: "Sorted taxonomy"
    outputBinding:
      glob: "$(inputs.taxonomy ? inputs.taxonomy.nameroot + '.sorted' + inputs.taxonomy.nameext : [])"
  - id: qfile_out
    type:
      - 'null'
      - File
    doc: "Sorted quality file"
    outputBinding:
      glob: "$(inputs.qfile ? inputs.qfile.nameroot + '.sorted' + inputs.qfile.nameext : [])"
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
stdout: mothur_sort.seqs.out
