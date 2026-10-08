cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_remove.groups
doc: "Removes sequences of specific groups from fasta, name, group, count, list, taxonomy, design, phylip, column or shared files.\n\nThe remove.groups command removes sequences from a specfic group or set of groups from the following file types: fasta, name, group, count, list, taxonomy, design, phylip, column or sharedfile.\nIt outputs a file containing the sequences NOT in the those specified groups, or with a sharedfile eliminates the groups you selected.\nThe remove.groups command parameters are accnos, fasta, name, group, list, taxonomy, shared, design, phylip, column, sets and groups. The group or count parameter is required, unless you have a current group or count file or are using a sharedfile.\nYou must also provide an accnos containing the list of groups to remove or set the groups or sets parameter to the groups you wish to remove.\nThe groups parameter allows you to specify which of the groups in your groupfile you would like removed.  You can separate group names with dashes.\nThe sets parameter allows you to specify which of the sets in your designfile you would like to remove.  You can separate set names with dashes.\nThe remove.groups command should be in the following format: remove.groups(accnos=yourAccnos, fasta=yourFasta, group=yourGroupFile).\nExample remove.groups(accnos=amazon.accnos, fasta=amazon.fasta, group=amazon.groups).\nor remove.groups(groups=pasture, fasta=amazon.fasta, amazon.groups).\n\nThe valid parameters are: fasta, shared, name, phylip, column, count, group, design, list, taxonomy, accnos, groups, sets, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.accnos ? inputs.accnos : [])"
      - "$(inputs.fasta ? inputs.fasta : [])"
      - "$(inputs.name ? inputs.name : [])"
      - "$(inputs.group ? inputs.group : [])"
      - "$(inputs.count ? inputs.count : [])"
      - "$(inputs.list ? inputs.list : [])"
      - "$(inputs.taxonomy ? inputs.taxonomy : [])"
      - "$(inputs.shared ? inputs.shared : [])"
      - "$(inputs.design ? inputs.design : [])"
      - "$(inputs.phylip ? inputs.phylip : [])"
      - "$(inputs.column ? inputs.column : [])"
inputs:
  - id: accnos
    type:
      - 'null'
      - File
    doc: "Accnos file listing the groups to remove (mothur parameter accnos=)"
  - id: groups
    type:
      - 'null'
      - string
    doc: "Groups to remove, separated by dashes (mothur parameter groups=)"
  - id: sets
    type:
      - 'null'
      - string
    doc: "Design-file sets to remove, separated by dashes (mothur parameter sets=)"
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Fasta file (mothur parameter fasta=)"
  - id: name
    type:
      - 'null'
      - File
    doc: "Names file (mothur parameter name=)"
  - id: group
    type:
      - 'null'
      - File
    doc: "Group file (mothur parameter group=)"
  - id: count
    type:
      - 'null'
      - File
    doc: "Count table (mothur parameter count=)"
  - id: list
    type:
      - 'null'
      - File
    doc: "OTU list file (mothur parameter list=)"
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: "Taxonomy file (mothur parameter taxonomy=)"
  - id: shared
    type:
      - 'null'
      - File
    doc: "Shared file (mothur parameter shared=)"
  - id: design
    type:
      - 'null'
      - File
    doc: "Design file (mothur parameter design=)"
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
        var params = [["accnos", "accnos"], ["groups", "groups"], ["sets", "sets"], ["fasta", "fasta"], ["name", "name"], ["group", "group"], ["count", "count"], ["list", "list"], ["taxonomy", "taxonomy"], ["shared", "shared"], ["design", "design"], ["phylip", "phylip"], ["column", "column"], ["seed", "seed"]];
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
        return '#remove.groups(' + opts.join(', ') + ')';
      }
outputs:
  - id: fasta_out
    type:
      - 'null'
      - File
    doc: "Picked fasta"
    outputBinding:
      glob: "$(inputs.fasta ? inputs.fasta.nameroot + '.pick' + inputs.fasta.nameext : [])"
  - id: name_out
    type:
      - 'null'
      - File
    doc: "Picked names"
    outputBinding:
      glob: "$(inputs.name ? inputs.name.nameroot + '.pick' + inputs.name.nameext : [])"
  - id: group_out
    type:
      - 'null'
      - File
    doc: "Picked groups"
    outputBinding:
      glob: "$(inputs.group ? inputs.group.nameroot + '.pick' + inputs.group.nameext : [])"
  - id: count_out
    type:
      - 'null'
      - File
    doc: "Picked count table"
    outputBinding:
      glob: "$(inputs.count ? inputs.count.nameroot + '.pick' + inputs.count.nameext : [])"
  - id: list_out
    type:
      type: array
      items: File
    doc: "Picked list files"
    outputBinding:
      glob: "$(inputs.list ? inputs.list.nameroot + '.*.pick' + inputs.list.nameext : [])"
  - id: taxonomy_out
    type:
      - 'null'
      - File
    doc: "Picked taxonomy"
    outputBinding:
      glob: "$(inputs.taxonomy ? inputs.taxonomy.nameroot + '.pick' + inputs.taxonomy.nameext : [])"
  - id: shared_out
    type:
      type: array
      items: File
    doc: "Picked shared files, one per label"
    outputBinding:
      glob: "$(inputs.shared ? inputs.shared.nameroot + '.*.pick' + inputs.shared.nameext : [])"
  - id: design_out
    type:
      - 'null'
      - File
    doc: "Picked design"
    outputBinding:
      glob: "$(inputs.design ? inputs.design.nameroot + '.pick' + inputs.design.nameext : [])"
  - id: phylip_out
    type:
      - 'null'
      - File
    doc: "Picked phylip matrix"
    outputBinding:
      glob: "$(inputs.phylip ? inputs.phylip.nameroot + '.pick' + inputs.phylip.nameext : [])"
  - id: column_out
    type:
      - 'null'
      - File
    doc: "Picked column matrix"
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
stdout: mothur_remove.groups.out
