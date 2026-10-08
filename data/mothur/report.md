# mothur CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| mothur_anosim | PASS | Galaxy amazon.dist with a header line added to amazon.design (mothur 1.48 needs it); A-B R and P values as in the Galaxy test |
| mothur_chimera.ccode | PASS | Galaxy Mock data; accnos matches the Galaxy expected file; fixed the chimera-free fasta glob and staged inputs (mothur splits paths on dashes) |
| mothur_chimera.check | PASS | Galaxy Mock data; chimeras report identical to the Galaxy expected file after staging inputs so the 7mer index can be written |
| mothur_classify.otu | PASS | Galaxy amazon list and taxonomy; consensus taxonomy and summary per label (mothur also writes the labels after the requested one) |
| mothur_classify.svm | Failed | tool bug: classify.svm segfaults (exit 139) in SVM-RFE round 1 on the Galaxy mouse shared file and on a 36-sample version of it |
| mothur_degap.seqs | PASS | Galaxy Mock alignment; degapped sequences match the Galaxy expected file (order differs with 2 processors) |
| mothur_heatmap.sim | PASS | Galaxy amazon.dist; SVG heatmap with the expected sample names |
| mothur_indicator | PASS | Galaxy mouse shared file with an early/late design; indicator summary with 2 OTUs significant for the early group |
| mothur_kruskal.wallis | PASS | Galaxy mouse shared file with an early/late design; KW statistic and P value per OTU are plausible |
| mothur_make.fastq | Failed | tool bug: mothur 1.48.5 reads the line after a .qual header with no description as part of the header, so the Galaxy Mock test stops and wrapped files lose scores; works on Fasting_Example1 |
| mothur_merge.count | Failed | tool bug: mothur 1.48.5 merge.count writes the rows of the first count table twice (Galaxy stool_small + amazon tables, and a 2-row test) |
| mothur_merge.files | PASS | Galaxy sample1-3.fa; merged file identical to the Galaxy expected output.fa |
| mothur_otu.association | PASS | Galaxy amazon.an.shared; 0.41 Pearson correlation file matches the Galaxy md5 |
| mothur_pca | PASS | Galaxy amazon.an.shared; 0.55 loadings match the Galaxy md5, 0.22 axes differ only in signs of zero |
| mothur_remove.dists | PASS | Galaxy 98_sq_phylip_amazon.dist; matrix shrinks to 90 names as in the Galaxy test |
| mothur_remove.groups | PASS | Galaxy amazon.an.shared; pasture removed from every label |
| mothur_remove.lineage | PASS | Galaxy abrecovery taxonomy; picked taxonomy matches the Galaxy md5 (Galaxy count table dropped: it names sequences missing from the taxonomy) |
| mothur_remove.otus | PASS | Galaxy amazon list and OTU accnos; only label 0.22 with the expected OTUs |
| mothur_remove.seqs | PASS | Galaxy Mock fasta; 3 accnos sequences removed, 22 of 25 left |
| mothur_rename.seqs | PASS | Galaxy amazon fasta, names and groups (CR line ends converted); names like 42_forest and a rename map written |
| mothur_sort.seqs | PASS | Galaxy amazon.fasta; sorted fasta matches the Galaxy md5 |

## mothur_merge.count

### Tool Description
Merges count tables into one file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The merge.count command takes a list of count files separated by dashes and merges them into one file.The merge.count command parameters are count and output.Example merge.count(count=final.count_table-new.count_table, output=complete.count_table).
The valid parameters are: count, output, seed, inputdir, and outputdir.
```

## mothur_merge.files

### Tool Description
Appends files into one file, or combines a fasta, taxonomy and name or count file into one table.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The merge.file command takes a list of files separated by dashes and appends them into one file. Altternatively, the merge file command can combine the data of several files. For example, you can combine a fasta, taxonomy and name or count field to achieve outputs like: GQY1XT001C44N8 3677 Bacteria;Bacteroidetes;Bacteroidia;Bacteroidales;Porphyromonadaceae;Porphyromonadaceae_unclassified; C-G--T-T--GA-A-A-C-T-G-G--CG-T-T-C--T-T-G-A-G-T-G-G-GC-GA-G-A-A-G-T-A--TG-C-GG-A-ATG-C-G-T-G-GT-GT-A-G-CGGT-G-AAA--...The merge.file command parameters are input and output or fasta, taxonomy, name and count.Example merge.file(input=small.fasta-large.fasta, output=all.fasta).Example merge.file(fasta=final.fasta, name=final.names, taxonomy=final.taxonomy).
The valid parameters are: input, output, seed, inputdir, outputdir, taxonomy, fasta, name, and count.
```

## mothur_remove.dists

### Tool Description
Removes distances from a phylip or column file for the sequences or groups in an accnos file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The remove.dists command removes distances from a phylip or column file related to groups or sequences listed in an accnos file.
The remove.dists command parameters are accnos, phylip and column.
The remove.dists command should be in the following format: get.dists(accnos=yourAccnos, phylip=yourPhylip).
Example remove.dists(accnos=final.accnos, phylip=final.an.thetayc.0.03.lt.ave.dist).

The valid parameters are: phylip, column, accnos, seed, inputdir, and outputdir.
```

## mothur_anosim

### Tool Description
Non-parametric analysis of similarity (ANOSIM) between groups of samples in a distance matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
Referenced: Clarke, K. R. (1993). Non-parametric multivariate analysis of changes in community structure.   _Australian Journal of Ecology_ 18, 117-143.
The anosim command outputs a .anosim file. 
The anosim command parameters are phylip, iters, and alpha.  The phylip and design parameters are required, unless you have valid current files.
The design parameter allows you to assign your samples to groups when you are running anosim. It is required. 
The design file looks like the group file.  It is a 2 column tab delimited file, where the first column is the sample name and the second column is the group the sample belongs to.
The iters parameter allows you to set number of randomization for the P value.  The default is 1000. 
The anosim command should be in the following format: anosim(phylip=file.dist, design=file.design).

The valid parameters are: design, phylip, iters, alpha, seed, inputdir, and outputdir.
```

## mothur_indicator

### Tool Description
Calculates the indicator value of each OTU for groups or tree nodes.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The indicator command can be run in 3 ways: with a shared or relabund file and a design file, or with a shared or relabund file and a tree file, or with a shared or relabund file, tree file and design file. 
The indicator command outputs a .indicator.summary file and a .indicator.tre if a tree is given. 
The new tree contains labels at each internal node.  The label is the node number so you can relate the tree to the summary file.
The summary file lists the indicator value for each OTU for each node.
The indicator command parameters are tree, groups, shared, relabund, design and label. 
The design parameter allows you to relate the tree to the shared or relabund file, if your tree contains the grouping names, or if no tree is provided to group your groups into groupings.
The groups parameter allows you to specify which of the groups in your shared or relabund you would like analyzed, or if you provide a design file the groups in your design file.  The groups may be entered separated by dashes.
The label parameter indicates at what distance your tree relates to the shared or relabund.
The processors parameter allows you to specify how many processors you would like to use.  The default is 1. 
The iters parameter allows you to set number of randomization for the P value.  The default is 1000.The indicator command should be used in the following format: indicator(tree=test.tre, shared=test.shared, label=0.03)

The valid parameters are: iters, design, shared, relabund, groups, label, tree, seed, inputdir, outputdir, and processors.
```

## mothur_kruskal.wallis

### Tool Description
Runs a Kruskal-Wallis test on each OTU of a shared file between the classes of a design file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The kruskal.wallis command allows you to ....
The kruskal.wallis command parameters are: shared, design, class, label and classes.
The class parameter is used to indicate the which category you would like used for the Kruskal Wallis analysis. If none is provided first category is used.
The label parameter is used to indicate which distances in the shared file you would like to use. labels are separated by dashes.
The kruskal.wallis command should be in the following format: kruskal.wallis(shared=final.an.shared, design=final.design, class=treatment).

The valid parameters are: design, shared, class, label, seed, inputdir, and outputdir.
```

## mothur_otu.association

### Tool Description
Calculates correlation coefficients between OTUs, or between OTUs and metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The otu.association command reads a shared or relabund file and calculates the correlation coefficients between otus.
If you provide a metadata file, mothur will calculate te correlation bewteen the metadata and the otus.
The otu.association command parameters are shared, relabund, metadata, groups, method, cutoff and label.  The shared or relabund parameter is required.
The groups parameter allows you to specify which of the groups you would like included. The group names are separated by dashes.
The label parameter allows you to select what distances level you would like used, and are also separated by dashes.
The cutoff parameter allows you to set a pvalue at which the otu will be reported.
The method parameter allows you to select what method you would like to use. Options are pearson, spearman and kendall. Default=pearson.
The otu.association command should be in the following format: otu.association(shared=yourSharedFile, method=yourMethod).
Example otu.association(shared=genus.pool.shared, method=kendall).
The otu.association command outputs a .otu.corr file.

The valid parameters are: shared, relabund, metadata, cutoff, label, groups, method, seed, inputdir, and outputdir.
```

## mothur_pca

### Tool Description
Principal component analysis of a shared or relabund file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The pca command parameters are shared, relabund, label, groups and metric.  shared or relabund is required unless you have a valid current file.The label parameter is used to analyze specific labels in your input. Default is the first label in your shared or relabund file. Multiple labels may be separated by dashes.
The groups parameter allows you to specify which groups you would like analyzed. Groupnames are separated by dashes.
The metric parameter allows you to indicate if would like the pearson correlation coefficient calculated. Default=TrueExample pca(groups=yourGroups).
Example pca(groups=A-B-C).

The valid parameters are: shared, relabund, groups, metric, label, seed, inputdir, and outputdir.
```

## mothur_classify.svm

### Tool Description
Classifies samples in a shared file into the groups of a design file with a support vector machine and reports discriminating OTUs.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The classifysvm.shared command allows you to ....
The classifysvm.shared command parameters are: shared, design, label, groups.
The label parameter is used to analyze specific labels in your input.
The groups parameter allows you to specify which of the groups in your designfile you would like analyzed.
The classifysvm.shared should be in the following format: 
classifysvm.shared(shared=yourSharedFile, design=yourDesignFile)

The valid parameters are: shared, design, mode, evaluationfolds, trainingfolds, smoc, kernel, transform, verbose, stdthreshold, groups, label, inputdir, and outputdir.
```

## mothur_heatmap.sim

### Tool Description
Creates SVG heatmaps of the similarity between samples from a shared file or a distance matrix.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The heatmap.sim command parameters are shared, phylip, column, name, count, groups, calc, fontsize and label.  shared or phylip or column and name are required unless valid current files exist.
There are two ways to use the heatmap.sim command. The first is with a shared file, and you may use the groups, label and calc parameter. 
The groups parameter allows you to specify which of the groups in your groupfile you would like included in your heatmap.
The group names are separated by dashes. The label parameter allows you to select what distance levels you would like a heatmap created for, and is also separated by dashes.
The fontsize parameter allows you to adjust the font size of the picture created, default=24.
The heatmap.sim command should be in the following format: heatmap.sim(groups=yourGroups, calc=yourCalc, label=yourLabels).
Example heatmap.sim(groups=A-B-C, calc=jabund).
The default value for groups is all the groups in your groupfile, and all labels in your inputfile will be used.
The available estimators for calc are braycurtis, jabund, jclass, jest, morisitahorn, sorabund, sorclass, sorest, thetan, thetayc
The default value for calc is jclass-thetayc.
The heatmap.sim command outputs a .svg file for each calculator you choose at each label you specify.
The second way to use the heatmap.sim command is with a distance file representing the distance bewteen your groups. 
Using the command this way, the phylip or column parameter are required, and only one may be used.  If you use a column file the name filename is required. 
The heatmap.sim command should be in the following format: heatmap.sim(phylip=yourDistanceFile).
Example heatmap.sim(phylip=amazonGroups.dist).

The valid parameters are: shared, phylip, name, count, column, groups, label, calc, fontsize, seed, inputdir, and outputdir.
```

## mothur_remove.groups

### Tool Description
Removes sequences of specific groups from fasta, name, group, count, list, taxonomy, design, phylip, column or shared files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The remove.groups command removes sequences from a specfic group or set of groups from the following file types: fasta, name, group, count, list, taxonomy, design, phylip, column or sharedfile.
It outputs a file containing the sequences NOT in the those specified groups, or with a sharedfile eliminates the groups you selected.
The remove.groups command parameters are accnos, fasta, name, group, list, taxonomy, shared, design, phylip, column, sets and groups. The group or count parameter is required, unless you have a current group or count file or are using a sharedfile.
You must also provide an accnos containing the list of groups to remove or set the groups or sets parameter to the groups you wish to remove.
The groups parameter allows you to specify which of the groups in your groupfile you would like removed.  You can separate group names with dashes.
The sets parameter allows you to specify which of the sets in your designfile you would like to remove.  You can separate set names with dashes.
The remove.groups command should be in the following format: remove.groups(accnos=yourAccnos, fasta=yourFasta, group=yourGroupFile).
Example remove.groups(accnos=amazon.accnos, fasta=amazon.fasta, group=amazon.groups).
or remove.groups(groups=pasture, fasta=amazon.fasta, amazon.groups).

The valid parameters are: fasta, shared, name, phylip, column, count, group, design, list, taxonomy, accnos, groups, sets, seed, inputdir, and outputdir.
```

## mothur_remove.otus

### Tool Description
Removes OTUs listed in an accnos file or selected by classify.otu, otu.association or corr.axes output from a list or shared file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The remove.otus command can be used to remove specific otus with the output from classify.otu, otu.association, or corr.axes. It can also be used to select a set of otus from a shared or list file.
The remove.otus parameters are: constaxonomy, otucorr, corraxes, shared, list, label and accnos.
The constaxonomy parameter is input the results of the classify.otu command.
The otucorr parameter is input the results of the otu.association command.
The corraxes parameter is input the results of the corr.axes command.
The label parameter is used to analyze specific labels in your input. 
The remove.otus commmand should be in the following format: 
remove.otus(accnos=yourListOfOTULabels, corraxes=yourCorrAxesFile)

The valid parameters are: accnos, constaxonomy, otucorr, corraxes, list, shared, label, seed, inputdir, and outputdir.
```

## mothur_classify.otu

### Tool Description
Gets a consensus taxonomy for each OTU in a list file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The classify.otu command parameters are list, taxonomy, name, group, count, persample, cutoff, label, basis, relabund and probs.  The taxonomy and list parameters are required unless you have a valid current file.
The name parameter allows you add a names file with your taxonomy file.
The group parameter allows you provide a group file to use in creating the summary file breakdown.
The count parameter allows you add a count file associated with your list file. When using the count parameter mothur assumes your list file contains only uniques.
The basis parameter allows you indicate what you want the summary file to represent, options are otu and sequence. Default is otu.
For example consider the following basis=sequence could give Clostridiales	3	105	16	43	46, where 105 is the total number of sequences whose otu classified to Clostridiales.
16 is the number of sequences in the otus from groupA, 43 is the number of sequences in the otus from groupB, and 46 is the number of sequences in the otus from groupC.
Now for basis=otu could give Clostridiales	3	7	6	1	2, where 7 is the number of otus that classified to Clostridiales.
6 is the number of otus containing sequences from groupA, 1 is the number of otus containing sequences from groupB, and 2 is the number of otus containing sequences from groupC.
The label parameter allows you to select what distance levels you would like a output files created for, and is separated by dashes.
The persample parameter allows you to find a consensus taxonomy for each group. Default=f
The relabund parameter allows you to indicate you want the summary file values to be relative abundances rather than raw abundances. Default=F. 
The default value for label is all labels in your inputfile.
The output parameter allows you to specify format of your summary file. Options are simple and detail. The default is detail.
The printlevel parameter allows you to specify taxlevel of your summary file to print to. Options are 1 to the maz level in the file.  The default is -1, meaning max level.  If you select a level greater than the level your sequences classify to, mothur will print to the level your max level. 
The cutoff parameter allows you to specify a consensus confidence threshold for your otu taxonomy output.  The default is 51, meaning 51%. Cutoff cannot be below 51.
The probs parameter shuts off the outputting of the consensus confidence results. The default is true, meaning you want the confidence to be shown.
The threshold parameter allows you to specify a cutoff for the taxonomy file that is being inputted. Once the classification falls below the threshold the mothur will refer to it as unclassified when calculating the concensus.  This feature is similar to adjusting the cutoff in classify.seqs. Default=0.
The classify.otu command should be in the following format: classify.otu(taxonomy=yourTaxonomyFile, list=yourListFile, name=yourNamesFile, label=yourLabels).
Example classify.otu(taxonomy=abrecovery.silva.full.taxonomy, list=abrecovery.fn.list, label=0.10).

The valid parameters are: list, taxonomy, name, count, output, group, relabund, printlevel, persample, label, basis, cutoff, threshold, probs, seed, inputdir, and outputdir.
```

## mothur_remove.lineage

### Tool Description
Removes sequences or OTUs that belong to given taxa from a taxonomy or constaxonomy file and related files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The remove.lineage command reads a taxonomy or constaxonomy file and any of the following file types: fasta, name, group, count, list, shared or alignreport file. The constaxonomy can only be used with a shared or list file.
It outputs a file containing only the sequences or OTUS from the taxonomy file that are not from the taxon you requested to be removed.
The remove.lineage command parameters are taxon, fasta, name, group, count, list, shared, taxonomy, alignreport, label and dups.  You must provide taxonomy or constaxonomy unless you have a valid current taxonomy file.
The dups parameter allows you to add the entire line from a name file if you add any name from the line. default=false. 
The taxon parameter allows you to select the taxons you would like to remove, and is required.
You may enter your taxons with confidence scores, doing so will remove only those sequences that belong to the taxonomy and whose cofidence scores fall below the scores you give.
If they belong to the taxonomy and have confidences above those you provide the sequence will not be removed.
The label parameter is used to analyze specific labels in your input. 
The remove.lineage command should be in the following format: remove.lineage(taxonomy=yourTaxonomyFile, taxon=yourTaxons).
Example remove.lineage(taxonomy=amazon.silva.taxonomy, taxon=Bacteria;Firmicutes;Bacilli;Lactobacillales;).
Note: If you are running mothur in script mode you must wrap the taxon in ' characters so mothur will ignore the ; in the taxon.
Example remove.lineage(taxonomy=amazon.silva.taxonomy, taxon='Bacteria;Firmicutes;Bacilli;Lactobacillales;').

The valid parameters are: fasta, name, count, group, list, shared, taxonomy, constaxonomy, alignreport, label, taxon, dups, seed, inputdir, and outputdir.
```

## mothur_chimera.ccode

### Tool Description
Reads a fasta file and reference file and outputs potentially chimeric sequences (Ccode algorithm).

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The chimera.ccode command reads a fastafile and referencefile and outputs potentially chimeric sequences.
This command was created using the algorithms described in the 'Evaluating putative chimeric sequences from PCR-amplified products' paper by Juan M. Gonzalez, Johannes Zimmerman and Cesareo Saiz-Jimenez.
The chimera.ccode command parameters are fasta, reference, filter, mask, processors, window and numwanted.
The fasta parameter allows you to enter the fasta file containing your potentially chimeric sequences, and is required unless you have a valid current fasta file. 
The reference parameter allows you to enter a reference file containing known non-chimeric sequences, and is required. 
The filter parameter allows you to specify if you would like to apply a vertical and 50% soft filter. 
The mask parameter allows you to specify a file containing one sequence you wish to use as a mask for the your sequences. 
The window parameter allows you to specify the window size for searching for chimeras. 
The numwanted parameter allows you to specify how many sequences you would each query sequence compared with.
The removechimeras parameter allows you to indicate you would like to automatically remove the sequences that are flagged as chimeric. Default=t.
The chimera.ccode command should be in the following format: 
chimera.ccode(fasta=yourFastaFile, reference=yourTemplate) 
Example: chimera.ccode(fasta=AD.align, reference=core_set_aligned.imputed.fasta) 

The valid parameters are: reference, fasta, filter, window, numwanted, mask, removechimeras, seed, inputdir, and outputdir.
```

## mothur_chimera.check

### Tool Description
Reads a fasta file and reference file and outputs potentially chimeric sequences (CHIMERA_CHECK algorithm).

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The chimera.check command reads a fastafile and referencefile and outputs potentially chimeric sequences.
This command was created using the algorithms described in CHIMERA_CHECK version 2.7 written by Niels Larsen. 
The chimera.check command parameters are fasta, reference, processors, ksize, increment, svg and name.
The fasta parameter allows you to enter the fasta file containing your potentially chimeric sequences, and is required unless you have a valid current fasta file. 
The reference parameter allows you to enter a reference file containing known non-chimeric sequences, and is required. 
The increment parameter allows you to specify how far you move each window while finding chimeric sequences, default is 10.
The ksize parameter allows you to input kmersize, default is 7. 
The svg parameter allows you to specify whether or not you would like a svg file outputted for each query sequence, default is False.
The name parameter allows you to enter a file containing names of sequences you would like .svg files for.
The chimera.check command should be in the following format: 
chimera.check(fasta=yourFastaFile, reference=yourTemplateFile, processors=yourProcessors, ksize=yourKmerSize) 
Example: chimera.check(fasta=AD.fasta, reference=core_set_aligned,imputed.fasta, processors=4, ksize=8) 

The valid parameters are: reference, fasta, name, svg, increment, ksize, seed, inputdir, and outputdir.
```

## mothur_degap.seqs

### Tool Description
Reads a fasta file and removes all gap characters.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The degap.seqs command reads a fastafile and removes all gap characters.
The degap.seqs command parameter are fasta and processors.
The fasta parameter allows you to enter the fasta file containing your sequences, and is required unless you have a valid current fasta file. 
The processors parameter allows you to enter the number of processors you would like to use. 
The degap.seqs command should be in the following format: 
degap.seqs(fasta=yourFastaFile) 
Example: degap.seqs(fasta=abrecovery.align) 

The valid parameters are: fasta, seed, processors, inputdir, and outputdir.
```

## mothur_make.fastq

### Tool Description
Reads a fasta and quality file and creates a fastq file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The make.fastq command reads a fasta and quality file and creates a fastq file.
The make.fastq command parameters are fasta, qfile and format.  fasta and qfile are required.
The format parameter is used to indicate whether your sequences are sanger, solexa, illumina1.8+ or illumina, default=illumina1.8+.
The make.fastq command should be in the following format: make.fastq(qfile=yourQualityFile, fasta=yourFasta).
Example make.fastq(fasta=amazon.fasta, qfile=amazon.qual).

The valid parameters are: fasta, qfile, format, seed, inputdir, and outputdir.
```

## mothur_remove.seqs

### Tool Description
Removes the sequences listed in an accnos file from fasta, name, group, count, list, taxonomy, quality, fastq, contigsreport or alignreport files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The remove.seqs command reads an .accnos file and at least one of the following file types: fasta, name, group, count, list, taxonomy, quality, fastq, contigsreport or alignreport file.
It outputs a file containing the sequences NOT in the .accnos file.
The remove.seqs command parameters are accnos, fasta, name, group, count, list, taxonomy, qfile, alignreport, contigsreport, fastq and dups.  You must provide accnos and at least one of the file parameters.
The format parameter is used to indicate whether your sequences are sanger, solexa, illumina1.8+ or illumina, default=illumina1.8+.
The dups parameter allows you to remove the entire line from a name file if you remove any name from the line. default=true. 
The remove.seqs command should be in the following format: remove.seqs(accnos=yourAccnos, fasta=yourFasta).
Example remove.seqs(accnos=amazon.accnos, fasta=amazon.fasta).

The valid parameters are: fastq, fasta, name, count, group, list, taxonomy, alignreport, contigsreport, qfile, accnos, dups, seed, format, inputdir, and outputdir.
```

## mothur_rename.seqs

### Tool Description
Renames sequences in the input files, using new names built from the inputs or a map file.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The rename.seqs command renames sequences in the input files. By default, mothur will generate new names based on your inputs. Alternatively, you can provide a map file.
The rename.seqs command parameters are contigsreport, count, delim, fasta, fastq, file, group, inputdir, list, map, name, outputdir, placement, qfile, seed, taxonomy.
The list parameter allows you to provide an associated list file.
The fasta parameter allows you to provide an associated fasta file.
The qfile parameter allows you to provide an associated quality file.
The taxonomy parameter allows you to provide an associated taxonomy file.
The contigsreport allows you to provide an associated contigsreport file.
The file parameter is 2, 3 or 4 column file containing the forward fastq files in the first column and their matching reverse fastq files in the second column, or a groupName then forward fastq file and reverse fastq file, or forward fastq file then reverse fastq then forward index and reverse index file.  If you only have one index file add 'none' for the other one.  Mothur will process each pair and create a renamed fastq and file file.
The placement parameter allows you to indicate whether you would like the group name appended to the front or back of the sequence number.  Options are front or back. Default=back.
The delim parameter allow you to enter the character or characters you would like to separate the sequence number from the group name. Default='_'.
The rename.seqs command should be in the following format: 
The rename.seqs command should be in the following format: 
rename.seqs(fasta=yourFastaFile, group=yourGroupFile) 
Example rename.seqs(fasta=abrecovery.unique.fasta, group=abrecovery.group).

The valid parameters are: file, map, fasta, fastq, list, qfile, contigsreport, taxonomy, name, count, group, delim, placement, seed, inputdir, and outputdir.
```

## mothur_sort.seqs

### Tool Description
Puts the sequences of accnos, fasta, name, taxonomy, flow or quality files in the same order.

### Metadata
- **Docker Image**: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
- **Homepage**: https://www.mothur.org
- **Package**: https://anaconda.org/channels/bioconda/packages/mothur/overview
- **Validation**: PASS

### Original Help Text
```text
The sort.seqs command puts the sequences in the same order for the following file types: accnos fasta, name, taxonomy, flow or quality file.
The sort.seqs command parameters are accnos, fasta, name, taxonomy, flow, qfile and large.
The accnos file allows you to specify the order you want the files in.  If none is provided, mothur will use the order of the first file it reads.
The large parameters is used to indicate your files are too large to fit in RAM.
The sort.seqs command should be in the following format: sort.seqs(fasta=yourFasta).
Example sort.seqs(fasta=amazon.fasta).

The valid parameters are: fasta, flow, name, taxonomy, qfile, large, accnos, seed, inputdir, and outputdir.
```

## Metadata
- **Skill**: generated
