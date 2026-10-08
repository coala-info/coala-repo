cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mothur
label: mothur_classify.otu
doc: "Gets a consensus taxonomy for each OTU in a list file.\n\nThe classify.otu command parameters are list, taxonomy, name, group, count, persample, cutoff, label, basis, relabund and probs.  The taxonomy and list parameters are required unless you have a valid current file.\nThe name parameter allows you add a names file with your taxonomy file.\nThe group parameter allows you provide a group file to use in creating the summary file breakdown.\nThe count parameter allows you add a count file associated with your list file. When using the count parameter mothur assumes your list file contains only uniques.\nThe basis parameter allows you indicate what you want the summary file to represent, options are otu and sequence. Default is otu.\nFor example consider the following basis=sequence could give Clostridiales\t3\t105\t16\t43\t46, where 105 is the total number of sequences whose otu classified to Clostridiales.\n16 is the number of sequences in the otus from groupA, 43 is the number of sequences in the otus from groupB, and 46 is the number of sequences in the otus from groupC.\nNow for basis=otu could give Clostridiales\t3\t7\t6\t1\t2, where 7 is the number of otus that classified to Clostridiales.\n6 is the number of otus containing sequences from groupA, 1 is the number of otus containing sequences from groupB, and 2 is the number of otus containing sequences from groupC.\nThe label parameter allows you to select what distance levels you would like a output files created for, and is separated by dashes.\nThe persample parameter allows you to find a consensus taxonomy for each group. Default=f\nThe relabund parameter allows you to indicate you want the summary file values to be relative abundances rather than raw abundances. Default=F. \nThe default value for label is all labels in your inputfile.\nThe output parameter allows you to specify format of your summary file. Options are simple and detail. The default is detail.\nThe printlevel parameter allows you to specify taxlevel of your summary file to print to. Options are 1 to the maz level in the file.  The default is -1, meaning max level.  If you select a level greater than the level your sequences classify to, mothur will print to the level your max level. \nThe cutoff parameter allows you to specify a consensus confidence threshold for your otu taxonomy output.  The default is 51, meaning 51%. Cutoff cannot be below 51.\nThe probs parameter shuts off the outputting of the consensus confidence results. The default is true, meaning you want the confidence to be shown.\nThe threshold parameter allows you to specify a cutoff for the taxonomy file that is being inputted. Once the classification falls below the threshold the mothur will refer to it as unclassified when calculating the concensus.  This feature is similar to adjusting the cutoff in classify.seqs. Default=0.\nThe classify.otu command should be in the following format: classify.otu(taxonomy=yourTaxonomyFile, list=yourListFile, name=yourNamesFile, label=yourLabels).\nExample classify.otu(taxonomy=abrecovery.silva.full.taxonomy, list=abrecovery.fn.list, label=0.10).\n\nThe valid parameters are: list, taxonomy, name, count, output, group, relabund, printlevel, persample, label, basis, cutoff, threshold, probs, seed, inputdir, and outputdir.\n\nTool homepage: https://www.mothur.org"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - "$(inputs.list ? inputs.list : [])"
      - "$(inputs.taxonomy ? inputs.taxonomy : [])"
      - "$(inputs.name ? inputs.name : [])"
      - "$(inputs.count ? inputs.count : [])"
      - "$(inputs.group ? inputs.group : [])"
inputs:
  - id: list
    type: File
    doc: "OTU list file (mothur parameter list=)"
  - id: taxonomy
    type: File
    doc: "Sequence taxonomy file (mothur parameter taxonomy=)"
  - id: name
    type:
      - 'null'
      - File
    doc: "Names file for the taxonomy file (mothur parameter name=)"
  - id: count
    type:
      - 'null'
      - File
    doc: "Count table for the list file (list must contain only uniques) (mothur parameter count=)"
  - id: group
    type:
      - 'null'
      - File
    doc: "Group file used for the summary file breakdown (mothur parameter group=)"
  - id: output
    type:
      - 'null'
      - string
    doc: "Format of the summary file: simple or detail (default detail) (mothur parameter output=)"
  - id: relabund
    type:
      - 'null'
      - boolean
    doc: "Report relative abundances in the summary file (default false) (mothur parameter relabund=)"
  - id: printlevel
    type:
      - 'null'
      - int
    doc: "Taxonomy level to print in the summary file (default -1, max level) (mothur parameter printlevel=)"
  - id: persample
    type:
      - 'null'
      - boolean
    doc: "Find a consensus taxonomy for each group (default false) (mothur parameter persample=)"
  - id: label
    type:
      - 'null'
      - string
    doc: "Distance levels to process, separated by dashes (default all) (mothur parameter label=)"
  - id: basis
    type:
      - 'null'
      - string
    doc: "What the summary file represents: otu or sequence (default otu) (mothur parameter basis=)"
  - id: cutoff
    type:
      - 'null'
      - int
    doc: "Consensus confidence threshold in percent (default 51) (mothur parameter cutoff=)"
  - id: threshold
    type:
      - 'null'
      - int
    doc: "Classifications below this confidence are treated as unclassified (default 0) (mothur parameter threshold=)"
  - id: probs
    type:
      - 'null'
      - boolean
    doc: "Show the consensus confidence values (default true) (mothur parameter probs=)"
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random number seed (mothur parameter seed=)"
arguments:
  - position: 1
    valueFrom: |-
      ${
        var params = [["list", "list"], ["taxonomy", "taxonomy"], ["name", "name"], ["count", "count"], ["group", "group"], ["output", "output"], ["relabund", "relabund"], ["printlevel", "printlevel"], ["persample", "persample"], ["label", "label"], ["basis", "basis"], ["cutoff", "cutoff"], ["threshold", "threshold"], ["probs", "probs"], ["seed", "seed"]];
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
        return '#classify.otu(' + opts.join(', ') + ')';
      }
outputs:
  - id: cons_taxonomy
    type:
      type: array
      items: File
    doc: "Consensus taxonomy per OTU, one file per label"
    outputBinding:
      glob: "*.cons.taxonomy"
  - id: cons_tax_summary
    type:
      type: array
      items: File
    doc: "Taxonomy summary, one file per label"
    outputBinding:
      glob: "*.cons.tax.summary"
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
stdout: mothur_classify.otu.out
