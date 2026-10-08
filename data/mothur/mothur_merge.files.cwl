cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_merge.files
doc: "Appends files into one file, or combines a fasta, taxonomy and name or count file into one table.\n\nThe merge.file command takes a list of files separated by dashes and appends them into one file. Altternatively, the merge file command can combine the data of several files. For example, you can combine a fasta, taxonomy and name or count field to achieve outputs like: GQY1XT001C44N8 3677 Bacteria;Bacteroidetes;Bacteroidia;Bacteroidales;Porphyromonadaceae;Porphyromonadaceae_unclassified; C-G--T-T--GA-A-A-C-T-G-G--CG-T-T-C--T-T-G-A-G-T-G-G-GC-GA-G-A-A-G-T-A--TG-C-GG-A-ATG-C-G-T-G-GT-GT-A-G-CGGT-G-AAA--...The merge.file command parameters are input and output or fasta, taxonomy, name and count.Example merge.file(input=small.fasta-large.fasta, output=all.fasta).Example merge.file(fasta=final.fasta, name=final.names, taxonomy=final.taxonomy).\nThe valid parameters are: input, output, seed, inputdir, outputdir, taxonomy, fasta, name, and count.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.input_files ? inputs.input_files : [])"
      - "$(inputs.fasta ? inputs.fasta : [])"
      - "$(inputs.taxonomy ? inputs.taxonomy : [])"
      - "$(inputs.name ? inputs.name : [])"
      - "$(inputs.count ? inputs.count : [])"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files to append into one file (mothur parameter input=)"
  - id: output
    type:
      - 'null'
      - string
    doc: "Name of the merged file (required with input) (mothur parameter output=)"
  - id: fasta
    type:
      - 'null'
      - File
    doc: "Fasta file to combine (mothur parameter fasta=)"
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: "Taxonomy file to combine (mothur parameter taxonomy=)"
  - id: name
    type:
      - 'null'
      - File
    doc: "Names file to combine (mothur parameter name=)"
  - id: count
    type:
      - 'null'
      - File
    doc: "Count table to combine (mothur parameter count=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["input_files", "input"], ["output", "output"], ["fasta", "fasta"], ["taxonomy", "taxonomy"], ["name", "name"], ["count", "count"], ["seed", "seed"]];
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
        return '#merge.files(' + opts.join(', ') + ')';
      }
outputs:
  - id: merged
    type:
      - 'null'
      - File
    doc: "Merged file"
    outputBinding:
      glob: "$(inputs.output ? inputs.output : '*.merge')"
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
stdout: mothur_merge.files.out
