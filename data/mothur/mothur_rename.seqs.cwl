cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_rename.seqs
doc: "Renames sequences in the input files, using new names built from the inputs or a map file.\n\nThe rename.seqs command renames sequences in the input files. By default, mothur will generate new names based on your inputs. Alternatively, you can provide a map file.\nThe rename.seqs command parameters are contigsreport, count, delim, fasta, fastq, file, group, inputdir, list, map, name, outputdir, placement, qfile, seed, taxonomy.\nThe list parameter allows you to provide an associated list file.\nThe fasta parameter allows you to provide an associated fasta file.\nThe qfile parameter allows you to provide an associated quality file.\nThe taxonomy parameter allows you to provide an associated taxonomy file.\nThe contigsreport allows you to provide an associated contigsreport file.\nThe file parameter is 2, 3 or 4 column file containing the forward fastq files in the first column and their matching reverse fastq files in the second column, or a groupName then forward fastq file and reverse fastq file, or forward fastq file then reverse fastq then forward index and reverse index file.  If you only have one index file add 'none' for the other one.  Mothur will process each pair and create a renamed fastq and file file.\nThe placement parameter allows you to indicate whether you would like the group name appended to the front or back of the sequence number.  Options are front or back. Default=back.\nThe delim parameter allow you to enter the character or characters you would like to separate the sequence number from the group name. Default='_'.\nThe rename.seqs command should be in the following format: \nThe rename.seqs command should be in the following format: \nrename.seqs(fasta=yourFastaFile, group=yourGroupFile) \nExample rename.seqs(fasta=abrecovery.unique.fasta, group=abrecovery.group).\n\nThe valid parameters are: file, map, fasta, fastq, list, qfile, contigsreport, taxonomy, name, count, group, delim, placement, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.fasta ? inputs.fasta : [])"
      - "$(inputs.fastq ? inputs.fastq : [])"
      - "$(inputs.fastq_file_list ? inputs.fastq_file_list : [])"
      - "$(inputs.map_file ? inputs.map_file : [])"
      - "$(inputs.name ? inputs.name : [])"
      - "$(inputs.count ? inputs.count : [])"
      - "$(inputs.group ? inputs.group : [])"
      - "$(inputs.list ? inputs.list : [])"
      - "$(inputs.qfile ? inputs.qfile : [])"
      - "$(inputs.taxonomy ? inputs.taxonomy : [])"
      - "$(inputs.contigsreport ? inputs.contigsreport : [])"
inputs:
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Fasta file (mothur parameter fasta=)"
  - id: fastq
    type:
      - 'null'
      - File
    doc: "FASTQ file (mothur parameter fastq=)"
  - id: fastq_file_list
    type:
      - 'null'
      - File
    doc: "2, 3 or 4 column file of fastq file pairs (and group names / index files) (mothur parameter file=)"
  - id: map_file
    type:
      - 'null'
      - File
    doc: "Map file of old and new names (mothur parameter map=)"
  - id: name
    type:
      - 'null'
      - File
    doc: "Names file (mothur parameter name=)"
  - id: count
    type:
      - 'null'
      - File
    doc: "Count table (mothur parameter count=)"
  - id: group
    type:
      - 'null'
      - File
    doc: "Group file (mothur parameter group=)"
  - id: list
    type:
      - 'null'
      - File
    doc: "OTU list file (mothur parameter list=)"
  - id: qfile
    type:
      - 'null'
      - File
    doc: "Quality file (mothur parameter qfile=)"
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: "Taxonomy file (mothur parameter taxonomy=)"
  - id: contigsreport
    type:
      - 'null'
      - File
    doc: "Contigs report file (mothur parameter contigsreport=)"
  - id: delim
    type:
      - 'null'
      - string
    doc: "Characters between the sequence number and group name (default _) (mothur parameter delim=)"
  - id: placement
    type:
      - 'null'
      - string
    doc: "Put the group name at the front or back of the number (default back) (mothur parameter placement=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["fasta", "fasta"], ["fastq", "fastq"], ["fastq_file_list", "file"], ["map_file", "map"], ["name", "name"], ["count", "count"], ["group", "group"], ["list", "list"], ["qfile", "qfile"], ["taxonomy", "taxonomy"], ["contigsreport", "contigsreport"], ["delim", "delim"], ["placement", "placement"], ["seed", "seed"]];
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
        return '#rename.seqs(' + opts.join(', ') + ')';
      }
outputs:
  - id: fasta_out
    type:
      - 'null'
      - File
    doc: "Renamed fasta"
    outputBinding:
      glob: "$(inputs.fasta ? inputs.fasta.nameroot + '.renamed' + inputs.fasta.nameext : [])"
  - id: fastq_out
    type:
      - 'null'
      - File
    doc: "Renamed fastq"
    outputBinding:
      glob: "$(inputs.fastq ? inputs.fastq.nameroot + '.renamed' + inputs.fastq.nameext : [])"
  - id: name_out
    type:
      - 'null'
      - File
    doc: "Renamed names"
    outputBinding:
      glob: "$(inputs.name ? inputs.name.nameroot + '.renamed' + inputs.name.nameext : [])"
  - id: count_out
    type:
      - 'null'
      - File
    doc: "Renamed count table"
    outputBinding:
      glob: "$(inputs.count ? inputs.count.nameroot + '.renamed' + inputs.count.nameext : [])"
  - id: group_out
    type:
      - 'null'
      - File
    doc: "Renamed groups"
    outputBinding:
      glob: "$(inputs.group ? inputs.group.nameroot + '.renamed' + inputs.group.nameext : [])"
  - id: list_out
    type:
      - 'null'
      - File
    doc: "Renamed list"
    outputBinding:
      glob: "$(inputs.list ? inputs.list.nameroot + '.renamed' + inputs.list.nameext : [])"
  - id: qfile_out
    type:
      - 'null'
      - File
    doc: "Renamed quality file"
    outputBinding:
      glob: "$(inputs.qfile ? inputs.qfile.nameroot + '.renamed' + inputs.qfile.nameext : [])"
  - id: taxonomy_out
    type:
      - 'null'
      - File
    doc: "Renamed taxonomy"
    outputBinding:
      glob: "$(inputs.taxonomy ? inputs.taxonomy.nameroot + '.renamed' + inputs.taxonomy.nameext : [])"
  - id: contigsreport_out
    type:
      - 'null'
      - File
    doc: "Renamed contigs report"
    outputBinding:
      glob: "$(inputs.contigsreport ? inputs.contigsreport.nameroot + '.renamed' + inputs.contigsreport.nameext : [])"
  - id: rename_map
    type:
      - 'null'
      - File
    doc: "Map of new to old sequence names"
    outputBinding:
      glob: "*.renamed_map"
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
stdout: mothur_rename.seqs.out
