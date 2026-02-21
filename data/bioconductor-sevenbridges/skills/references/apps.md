# Describe and Execute CWL Tools/Workflows in R

#### 2025-10-30

# 1 Prerequisite

This tutorial assume you have basic knowledge about Docker concept.

**Note**: Right now we are supporting CWL draft 2 with SBG extension, but we will support CWL v1.0 soon.

# 2 Apps, Workflows, and Tools

In our terminology, a **workflow** is composed of one or more **tool**, both of them are just **app** to users. You can imagine some raw input data go through a pipeline with many nodes that each step perform a function on the data in the flow, and in the end, you got want you want: a fully processed data or result (plot, report, action).

Here are some key ideas:

* Tool is the unit or a single node of workflow, so different tools could be connected into a workflow. That’s how we achieve reusability of components.
* Tool is described with key components: input, output, parameters and requirements and more details. You understand the tool more like a black box (container) which digest some input(s) with specified setup and output another format.
* When input files matches output between two tools, they could be connected.
* Input is composed of files and parameters, we call it types: File, Enum, Integer, String and so on.
* App could be described in JSON/YAML format, following Common Workflow Language (CWL) open-source standard.
* CWL is just the collection of logic and schema. To execute this **pure text file**, we need executor in the cloud or local. With Seven Bridges platform, you can simply execute it at scale.

Looks like full of jargons and hard to understand. Here is an example. You have a csv table, full of missing value and you want to process it in 3 steps:

1. Replace missing value
2. Filtering out rows that column “age” is smaller than 10
3. Output 3 item: a processed table csv file, a plot and a summary report in PDF format.

You can describe each step into a single module or tool then connect them one by one to form a flow. You can put everything into one single “tool”, then downside is that other user cannot use your step1 for missing value problem. So it’s both art and sciense to leverage between flexibility and efficiency.

Why we are using CWL? Imagine a single file represeting a tool or workflow, could be executed anywhere in a reproducible manner and you don’t have to install anything because Docker container is imaged, that’s going to change the world of computational scientific research and how we do research and publish results. In this package we are trying to hide CWL details as much as possible, so user can just use it like a typical R function.

# 3 Describe Tools in R

`Tool` is the basic unit, and also your “lego brick” you usually start with. As developer you also want to provide those “lego” piecies to users to directly run it or make their own flow with it.

The main interface provided by `sevenbridges` package is `Tool` function, it’s much more straight forward to describe than composing your raw CWL JSON file from scratch. A “Tool” object in R could be exported into JSON or imported from a CWL JSON file.

I highly recommend going over documentation [The Tool Editor](http://docs.cancergenomicscloud.org/docs/the-tool-editor) chapter for the Cancer Genomics Cloud to understand how it works, and even try it on the platform with the GUI. This will help understand our R interface better.

## 3.1 Import from JSON file

Sometimes people share Tool in pure JSON text format. You can simply load it into R by using `convert_app` function, this will recognize your JSON file class (Tool or Workflow) automatically.

```
library("sevenbridges")
t1 <- system.file("extdata/app", "tool_star.json", package = "sevenbridges")
# # convert JSON file into a Tool object
t1 <- convert_app(t1)
# # try print it out
# t1
```

In this way, you can load it, revise it, use it with API or edit and export it back to JSON file. However, in this tutorial, the most important thing is that you learn how to desribe it directly in R.

## 3.2 Utilitites for Tool object

We provide couple utitlities to help construct your own CWL tool quickly in R. For all availale utiles please check out `help("Tool")`

Some utiles you will find it useful when you execute a task, you need to know what is the input type and what is the input id and if it’s required or not, so you can execute the task with parameters it need. Try play with `input_matrix` or `input_type` as shown below.

```
# get input type information
head(t1$input_type())
```

```
              reads  readMatesLengthsIn       readMapNumber   limitOutSJoneRead
          "File..."              "enum"               "int"               "int"
limitOutSJcollapsed    outReadsUnmapped
              "int"              "enum"
```

```
# get output type information
head(t1$output_type())
```

```
              aligned_reads transcriptome_aligned_reads
                     "File"                      "File"
             reads_per_gene                   log_files
                     "File"                   "File..."
           splice_junctions          chimeric_junctions
                     "File"                      "File"
```

```
# return a input matrix with more information
head(t1$input_matrix())
```

```
                     id                label    type required
1                #reads        Read sequence File...     TRUE
95         #sjdbGTFfile Splice junction file File...    FALSE
102             #genome         Genome files    File     TRUE
2   #readMatesLengthsIn        Reads lengths    enum    FALSE
3        #readMapNumber         Reads to map     int    FALSE
4    #limitOutSJoneRead Junctions max number     int    FALSE
                  prefix
1                   <NA>
95                  <NA>
102                 <NA>
2   --readMatesLengthsIn
3        --readMapNumber
4    --limitOutSJoneRead
                                                   fileTypes
1   FASTA, FASTQ, FA, FQ, FASTQ.GZ, FQ.GZ, FASTQ.BZ2, FQ.BZ2
95                                             GTF, GFF, TXT
102                                                      TAR
2                                                       null
3                                                       null
4                                                       null
```

```
# return only a few fields
head(t1$input_matrix(c("id", "type", "required")))
```

```
                     id    type required
1                #reads File...     TRUE
95         #sjdbGTFfile File...    FALSE
102             #genome    File     TRUE
2   #readMatesLengthsIn    enum    FALSE
3        #readMapNumber     int    FALSE
4    #limitOutSJoneRead     int    FALSE
```

```
# return only required
t1$input_matrix(required = TRUE)
```

```
         id         label    type required prefix
1    #reads Read sequence File...     TRUE   <NA>
102 #genome  Genome files    File     TRUE   <NA>
                                                   fileTypes
1   FASTA, FASTQ, FA, FQ, FASTQ.GZ, FQ.GZ, FASTQ.BZ2, FQ.BZ2
102                                                      TAR
```

```
# return a output matrix with more information
t1$output_matrix()
```

```
                            id                     label    type fileTypes
1               #aligned_reads           Aligned SAM/BAM    File  SAM, BAM
2 #transcriptome_aligned_reads  Transcriptome alignments    File       BAM
3              #reads_per_gene            Reads per gene    File       TAB
4                   #log_files                 Log files File...       OUT
5            #splice_junctions          Splice junctions    File       TAB
6          #chimeric_junctions        Chimeric junctions    File  JUNCTION
7              #unmapped_reads            Unmapped reads File...     FASTQ
8         #intermediate_genome Intermediate genome files    File       TAR
9         #chimeric_alignments       Chimeric alignments    File       SAM
```

```
# return only a few fields
t1$output_matrix(c("id", "type"))
```

```
                            id    type
1               #aligned_reads    File
2 #transcriptome_aligned_reads    File
3              #reads_per_gene    File
4                   #log_files File...
5            #splice_junctions    File
6          #chimeric_junctions    File
7              #unmapped_reads File...
8         #intermediate_genome    File
9         #chimeric_alignments    File
```

```
# get required input id
t1$get_required()
```

```
    reads    genome
"File..."    "File"
```

```
# set new required input with ID, # or without #
t1$set_required(c("#reads", "winFlankNbins"))
```

```
not implemented yet!
```

```
t1$get_required()
```

```
    reads    genome
"File..."    "File"
```

```
# turn off requirements for input node #reads
t1$set_required("reads", FALSE)
```

```
not implemented yet!
```

```
t1$get_required()
```

```
    reads    genome
"File..."    "File"
```

```
# get input id
head(t1$input_id())
```

```
                 #STAR                  #STAR                  #STAR
              "#reads"  "#readMatesLengthsIn"       "#readMapNumber"
                 #STAR                  #STAR                  #STAR
  "#limitOutSJoneRead" "#limitOutSJcollapsed"    "#outReadsUnmapped"
```

```
# get full input id with Tool name
head(t1$input_id(TRUE))
```

```
                    File...                        enum
              "#STAR.reads"  "#STAR.readMatesLengthsIn"
                        int                         int
      "#STAR.readMapNumber"   "#STAR.limitOutSJoneRead"
                        int                        enum
"#STAR.limitOutSJcollapsed"    "#STAR.outReadsUnmapped"
```

```
# get output id
head(t1$output_id())
```

```
                         #STAR                          #STAR
              "#aligned_reads" "#transcriptome_aligned_reads"
                         #STAR                          #STAR
             "#reads_per_gene"                   "#log_files"
                         #STAR                          #STAR
           "#splice_junctions"          "#chimeric_junctions"
```

```
# get full output id
head(t1$output_id(TRUE))
```

```
                               File                                File
              "#STAR.aligned_reads" "#STAR.transcriptome_aligned_reads"
                               File                             File...
             "#STAR.reads_per_gene"                   "#STAR.log_files"
                               File                                File
           "#STAR.splice_junctions"          "#STAR.chimeric_junctions"
```

```
# get input and output object
t1$get_input(id = "#winFlankNbins")
```

```
type:
- 'null'
- int
label: Flanking regions size
description: =log2(winFlank), where win Flank is the size of the left and right flanking
  regions for each window (int>0).
streamable: no
id: '#winFlankNbins'
inputBinding:
  position: 0
  prefix: --winFlankNbins
  separate: yes
  shellQuote: no
  sbg:cmdInclude: yes
  streamable: no
  separator: ' '
sbg:category: Windows, Anchors, Binning
sbg:toolDefaultValue: '4'
required: no
```

```
t1$get_input(name = "ins")
```

```
[[1]]
type:
- 'null'
- int
label: Max bins between anchors
description: Max number of bins between two anchors that allows aggregation of anchors
  into one window (int>0).
streamable: no
id: '#winAnchorDistNbins'
inputBinding:
  position: 0
  prefix: --winAnchorDistNbins
  separate: yes
  shellQuote: no
  sbg:cmdInclude: yes
  streamable: no
  separator: ' '
sbg:category: Windows, Anchors, Binning
sbg:toolDefaultValue: '9'
required: no

[[2]]
type:
- 'null'
- int
label: Max insert junctions
description: Maximum number of junction to be inserted to the genome on the fly at
  the mapping stage, including those from annotations and those detected in the 1st
  step of the 2-pass run.
streamable: no
id: '#limitSjdbInsertNsj'
inputBinding:
  position: 0
  prefix: --limitSjdbInsertNsj
  separate: yes
  shellQuote: no
  sbg:cmdInclude: yes
  streamable: no
  separator: ' '
sbg:category: Limits
sbg:toolDefaultValue: '1000000'
required: no
```

```
t1$get_output(id = "#aligned_reads")
```

```
type:
- 'null'
- File
label: Aligned SAM/BAM
description: Aligned sequence in SAM/BAM format.
streamable: no
id: '#aligned_reads'
outputBinding:
  glob:
    engine: '#cwl-js-engine'
    script: |-
      {
        if ($job.inputs.outSortingType == 'SortedByCoordinate') {
          sort_name = '.sortedByCoord'
        }
        else {
          sort_name = ''
        }
        if ($job.inputs.outSAMtype == 'BAM') {
          sam_name = "*.Aligned".concat( sort_name, '.out.bam')
        }
        else {
          sam_name = "*.Aligned.out.sam"
        }
        return sam_name
      }
    class: Expression
sbg:fileTypes: SAM, BAM
```

```
t1$get_output(name = "gene")
```

```
type:
- 'null'
- File
label: Reads per gene
description: File with number of reads per gene. A read is counted if it overlaps
  (1nt or more) one and only one gene.
streamable: no
id: '#reads_per_gene'
outputBinding:
  glob: '*ReadsPerGene*'
sbg:fileTypes: TAB
```

## 3.3 Create your own tool in R

### 3.3.1 Introduction

Before we continue, this is how it looks like for full tool description, you don’t always need to describe all those details, following section will walk you through simple examples to full examples like this one.

```
fl <- system.file("docker/rnaseqGene/rabix", "generator.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")
```

```
library("sevenbridges")

rbx <- Tool(
  id = "rnaseqGene",
  label = "rnaseqgene",
  description = "A RNA-seq Differiencial Expression Flow and Report",
  hints = requirements(docker(pull = "tengfei/rnaseqgene"), cpu(1), mem(2000)),
  baseCommand = "performDE.R",
  inputs = list(
    input(
      id = "bamfiles", label = "bam files",
      description = "a list of bam files",
      type = "File...", ## or type = ItemArray("File")
      prefix = "--bamfiles",
      required = TRUE,
      itemSeparator = ","
    ),
    input(
      id = "design", label = "design matrix",
      type = "File",
      required = TRUE,
      prefix = "--design"
    ),
    input(
      id = "gtffile", label = "gene feature files",
      type = "File",
      stageInput = "copy",
      required = TRUE,
      prefix = "--gtffile"
    ),
    input(
      id = "format", label = "report foramt html or pdf",
      type = enum("format", c("pdf", "html")),
      prefix = "--format"
    )
  ),
  outputs = list(
    output(
      id = "report", label = "report",
      description = "A reproducible report created by Rmarkdown",
      glob = Expression(
        engine = "#cwl-js-engine",
        script = "x = $job[['inputs']][['format']]; if(x == 'undefined' || x == null){x = 'html';}; 'rnaseqGene.' +  x"
      )
    ),
    output(
      id = "heatmap", label = "heatmap",
      description = "A heatmap plot to show the Euclidean distance between samples",
      glob = "heatmap.pdf"
    ),
    output(
      id = "count", label = "count",
      description = "Reads counts matrix",
      glob = "count.csv"
    ),
    output(
      id = "de", label = "Differential expression table",
      description = "Differential expression table",
      glob = "de.csv"
    )
  )
)

fl <- "inst/docker/rnaseqGene/rabix/rnaseqGene.json"
write(rbx$toJSON(pretty = TRUE), fl)
```

Now let’s break it down:

Some key arguments used in `Tool` function.

* **baseCommand**: Specifies the program to execute.
* **stdout**: Capture the command’s standard output stream to a file written to the designated output directory. You don’t need this, if you specify output files to collect.
* **inputs**: inputs for your command line
* **outputs**: outputs you want to collect
* **Requirements** and **hints**: in short, hints are not *required* for execution. We now accept following requirement items `cpu`, `mem`, `docker`, `fileDef`; and you can easily construct them via `requirements()` constructor. This is how you describe the resources you need to execute the tool, so the system knows what type of instances suit your case best.

To specify inputs and outpus, usually your command line interface accept extra arguments as input, for example, file(s), string, enum, int, float, boolean. So to specify that in your tool, you can use `input` function, then pass it to the `inputs` arguments as a list or single item. You can even construct them as data.frame with less flexibility. `input()` require arguments `id` and `type`. `output()` require arguments `id` because `type` by default is file.

There are some special type: ItemArray and enum. For ItemArray the type could be an array of single type, the most common case is that if your input is a list of files, you can do something like `type = ItemArray("File")` or as simple as `type = "File..."` to diffenciate from a single file input. When you add “…” suffix, R will know it’s an `ItemArray`.

We also provide an **enum** type, when you specify the enum, please pass the required name and symbols like this `type = enum("format", c("pdf", "html"))` then in the UI on the platform you will be poped with drop down when you execute the task.

Now let’s work though from simple case to most flexible case.

### 3.3.2 Using existing Docker images and command

If you already have a Docker image in mind that provide the functionality you need, you can just use it. The `baseCommand` is the command line you want to execute in that container. `stdout` specify the output file you want to capture the standard output and collect it on the platform.

In this simple example, we know Docker image `rocker/r-base` has a function called `runif` we can directly call in the command line with `Rscript -e`. Then we want the ouput to be collected in `stdout` and ask the file system to capture the output files that matches the pattern `*.txt`. Please pay attention to this, your tool may produce many intermediate files in the current folder, if you don’t tell which output you need, they will all be ignored, so make sure you collect those files via the `outputs` parameter.

```
library("sevenbridges")

rbx <- Tool(
  id = "runif",
  label = "runif",
  hints = requirements(docker(pull = "rocker/r-base")),
  baseCommand = "Rscript -e 'runif(100)'",
  stdout = "output.txt",
  outputs = output(id = "random", glob = "*.txt")
)

rbx
```

```
sbg:id: runif
id: '#runif'
inputs: []
outputs:
- type:
  - 'null'
  - File
  label: ''
  description: ''
  streamable: no
  default: ''
  id: '#random'
  outputBinding:
    glob: '*.txt'
requirements: []
hints:
- class: DockerRequirement
  dockerPull: rocker/r-base
label: runif
class: CommandLineTool
baseCommand:
- Rscript -e 'runif(100)'
arguments: []
stdout: output.txt
```

```
rbx$toJSON()
```

```
{"sbg:id":"runif","id":"#runif","inputs":[],"outputs":[{"type":["null","File"],"label":"","description":"","streamable":false,"default":"","id":"#random","outputBinding":{"glob":"*.txt"}}],"requirements":[],"hints":[{"class":"DockerRequirement","dockerPull":"rocker/r-base"}],"label":"runif","class":"CommandLineTool","baseCommand":["Rscript -e 'runif(100)'"],"arguments":[],"stdout":"output.txt"}
```

By default, the tool object shows YAML, but you can simply convert it to JSON and copy it to your seven bridges platform graphic editor by importing JSON.

```
rbx$toJSON()
```

```
{"sbg:id":"runif","id":"#runif","inputs":[],"outputs":[{"type":["null","File"],"label":"","description":"","streamable":false,"default":"","id":"#random","outputBinding":{"glob":"*.txt"}}],"requirements":[],"hints":[{"class":"DockerRequirement","dockerPull":"rocker/r-base"}],"label":"runif","class":"CommandLineTool","baseCommand":["Rscript -e 'runif(100)'"],"arguments":[],"stdout":"output.txt"}
```

```
rbx$toJSON(pretty = TRUE)
```

```
{
  "sbg:id": "runif",
  "id": "#runif",
  "inputs": [],
  "outputs": [
    {
      "type": ["null", "File"],
      "label": "",
      "description": "",
      "streamable": false,
      "default": "",
      "id": "#random",
      "outputBinding": {
        "glob": "*.txt"
      }
    }
  ],
  "requirements": [],
  "hints": [
    {
      "class": "DockerRequirement",
      "dockerPull": "rocker/r-base"
    }
  ],
  "label": "runif",
  "class": "CommandLineTool",
  "baseCommand": [
    "Rscript -e 'runif(100)'"
  ],
  "arguments": [],
  "stdout": "output.txt"
}
```

```
rbx$toYAML()
```

```
[1] "sbg:id: runif\nid: '#runif'\ninputs: []\noutputs:\n- type:\n  - 'null'\n  - File\n  label: ''\n  description: ''\n  streamable: no\n  default: ''\n  id: '#random'\n  outputBinding:\n    glob: '*.txt'\nrequirements: []\nhints:\n- class: DockerRequirement\n  dockerPull: rocker/r-base\nlabel: runif\nclass: CommandLineTool\nbaseCommand:\n- Rscript -e 'runif(100)'\narguments: []\nstdout: output.txt\n"
```

### 3.3.3 Add customized script to existing Docker image

Now you may want to run your own R script, but you still don’t want to create new command line and a new Docker image. You just want to run your script with new input files in existing container, it’s time to introduce `fileDef`. You can either directly write script as string or just import a R file to `content`. And provided as `requirements`.

```
# Make a new file
fd <- fileDef(
  name = "runif.R",
  content = "set.seed(1); runif(100)"
)

# read via reader
.srcfile <- system.file("docker/sevenbridges/src/runif.R", package = "sevenbridges")

fd <- fileDef(
  name = "runif.R",
  content = readr::read_file(.srcfile)
)

# add script to your tool
rbx <- Tool(
  id = "runif",
  label = "runif",
  hints = requirements(docker(pull = "rocker/r-base")),
  requirements = requirements(fd),
  baseCommand = "Rscript runif.R",
  stdout = "output.txt",
  outputs = output(id = "random", glob = "*.txt")
)
```

How about multiple script?

```
# or simply readLines
.srcfile <- system.file("docker/sevenbridges/src/runif.R", package = "sevenbridges")

fd1 <- fileDef(
  name = "runif.R",
  content = readr::read_file(.srcfile)
)
fd2 <- fileDef(
  name = "runif2.R",
  content = "set.seed(1); runif(100)"
)

rbx <- Tool(
  id = "runif_twoscript",
  label = "runif_twoscript",
  hints = requirements(docker(pull = "rocker/r-base")),
  requirements = requirements(fd1, fd2),
  baseCommand = "Rscript runif.R",
  stdout = "output.txt",
  outputs = output(id = "random", glob = "*.txt")
)
```

### 3.3.4 Create formal interface for your command line

All those examples above, many parameters are hard-coded in your script, you don’t have flexiblity to control how many numbers to generate. Most often, your tools or command line tools expose some inputs arguments to users. You need a better way to describe a command line with input/output.

Now we bring the example to next level. For example, we prepare a Docker image called `RFranklin/runif` on Docker Hub. This container has a exeutable command called `runif.R`, you don’t have to know what is inside, you only have to know when you run the command line in that container it looks like this

```
runif.R --n=100 --max=100 --min=1 --seed=123
```

This command outpus two files directly, so you don’t need standard output to capture random number.

* output.txt
* report.html

So the goal here is to describe this command and expose all input parameters and collect all two files.

To define input, you can specify

* `id` : unique identifier to this input node.
* `description`: description, also visible on UI.
* `type`: required to specify input types, files, integer, or character.
* `label`: human readable label for this input node.
* `prefix`: the prefix in command line for this input parameter.
* `default`: default value for this input.
* `required`: is this input parameter required or not. If required, when you execte the tool you have to provide a value for the parameter.
* `cmdInclude`: included in command line or not.

Output is similar, espeicaly when you want to collect file, you can use `glob` for pattern matching.

```
# pass a input list
in.lst <- list(
  input(
    id = "number",
    description = "number of observations",
    type = "integer",
    label = "number",
    prefix = "--n",
    default = 1,
    required = TRUE,
    cmdInclude = TRUE
  ),
  input(
    id = "min",
    description = "lower limits of the distribution",
    type = "float",
    label = "min",
    prefix = "--min",
    default = 0
  ),
  input(
    id = "max",
    description = "upper limits of the distribution",
    type = "float",
    label = "max",
    prefix = "--max",
    default = 1
  ),
  input(
    id = "seed",
    description = "seed with set.seed",
    type = "float",
    label = "seed",
    prefix = "--seed",
    default = 1
  )
)

# the same method for outputs
out.lst <- list(
  output(
    id = "random",
    type = "file",
    label = "output",
    description = "random number file",
    glob = "*.txt"
  ),
  output(
    id = "report",
    type = "file",
    label = "report",
    glob = "*.html"
  )
)

rbx <- Tool(
  id = "runif",
  label = "Random number generator",
  hints = requirements(docker(pull = "RFranklin/runif")),
  baseCommand = "runif.R",
  inputs = in.lst, # or ins.df
  outputs = out.lst
)
```

Alternatively you can use data.frame as example for input and output, but it’s less flexible.

```
in.df <- data.frame(
  id = c("number", "min", "max", "seed"),
  description = c(
    "number of observation",
    "lower limits of the distribution",
    "upper limits of the distribution",
    "seed with set.seed"
  ),
  type = c("integer", "float", "float", "float"),
  label = c("number", "min", "max", "seed"),
  prefix = c("--n", "--min", "--max", "--seed"),
  default = c(1, 0, 10, 123),
  required = c(TRUE, FALSE, FALSE, FALSE)
)

out.df <- data.frame(
  id = c("random", "report"),
  type = c("file", "file"),
  glob = c("*.txt", "*.html")
)

rbx <- Tool(
  id = "runif",
  label = "Random number generator",
  hints = requirements(docker(pull = "RFranklin/runif"), cpu(1), mem(2000)),
  baseCommand = "runif.R",
  inputs = in.df, # or ins.df
  outputs = out.df
)
```

### 3.3.5 Quick command line interface with `commandArgs` (position and named args)

Now you must be wondering, I have a Docker container with R, but I don’t have any existing command line that I could directly use. Can I provide a script with a formal and quick command line interface to make an App for existing container. The anwser is yes. When you add script to your tool, you can always use some trick to do so, one popular one you may already head of is `commandArgs`. More formal one is called “docopt” which I will show you later.

Suppose you have a R script “runif2spin.R” with three arguments using position mapping

1. `numbers`
2. `min`
3. `max`

My base command will be somethine like

```
Rscript runif2spin.R 10 30 50
```

This is how you do in your R script

```
fl <- system.file("docker/sevenbridges/src", "runif2spin.R",
  package = "sevenbridges"
)
cat(readLines(fl), sep = "\n")
```

```
#' ---
#' title: "Uniform random number generator example"
#' output:
#'     html_document:
#'     toc: true
#' number_sections: true
#' ---

#' # summary report
#'
#' This is a random number generator

#+
args = commandArgs(TRUE)

r = runif(n   = as.integer(args[1]),
          min = as.numeric(args[2]),
          max = as.numeric(args[3]))
head(r)
summary(r)
hist(r)
```

Ignore the comment part, I will introduce spin/stich later.

Then just describe my tool in this way, add your script as you learned in previous sections.

```
fd <- fileDef(
  name = "runif.R",
  content = readr::read_file(fl)
)

rbx <- Tool(
  id = "runif",
  label = "runif",
  hints = requirements(docker(pull = "rocker/r-base"), cpu(1), mem(2000)),
  requirements = requirements(fd),
  baseCommand = "Rscript runif.R",
  stdout = "output.txt",
  inputs = list(
    input(
      id = "number",
      type = "integer",
      position = 1
    ),
    input(
      id = "min",
      type = "float",
      position = 2
    ),
    input(
      id = "max",
      type = "float",
      position = 3
    )
  ),
  outputs = output(id = "random", glob = "output.txt")
)
```

How about named argumentments? I will still recommend use “docopt” package, but for simple way. You want command line looks like this

```
Rscript runif_args.R --n=10 --min=30 --max=50
```

Here is how you do in R script.

```
fl <- system.file("docker/sevenbridges/src", "runif_args.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")
```

```
#' ---
#' title: "Uniform random number generator example"
#' output:
#'     html_document:
#'     toc: true
#' number_sections: true
#' ---

#' # summary report
#'
#' This is a random number generator

#+
args <- commandArgs(TRUE)

## quick hack to split named arguments
splitArgs <- function(x) {
    res <- do.call(rbind, lapply(x, function(i){
        res <- strsplit(i, "=")[[1]]
        nm <- gsub("-+", "",res[1])
        c(nm, res[2])
    }))
    .r <- res[,2]
    names(.r) <- res[,1]
    .r
}
args <- splitArgs(args)

#+
r <- runif(n   = as.integer(args["n"]),
           min = as.numeric(args["min"]),
           max = as.numeric(args["max"]))
summary(r)
hist(r)
write.csv(r, file = "out.csv")
```

Then just describe my tool in this way, note, I use `separate=FALSE` and add `=` to my prefix as a hack.

```
fd <- fileDef(
  name = "runif.R",
  content = readr::read_file(fl)
)

rbx <- Tool(
  id = "runif",
  label = "runif",
  hints = requirements(docker(pull = "rocker/r-base"), cpu(1), mem(2000)),
  requirements = requirements(fd),
  baseCommand = "Rscript runif.R",
  stdout = "output.txt",
  inputs = list(
    input(
      id = "number",
      type = "integer",
      separate = FALSE,
      prefix = "--n="
    ),
    input(
      id = "min",
      type = "float",
      separate = FALSE,
      prefix = "--min="
    ),
    input(
      id = "max",
      type = "float",
      separate = FALSE,
      prefix = "--max="
    )
  ),
  outputs = output(id = "random", glob = "output.txt")
)
```

### 3.3.6 docopt: a better and formal way to make command line interface

### 3.3.7 Generate reports

**Quick report: Spin and Stich**

You can use spin/stich from knitr to generate report directly from a Rscript with special format. For example, let’s use above example

```
fl <- system.file("docker/sevenbridges/src", "runif_args.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")
```

```
#' ---
#' title: "Uniform random number generator example"
#' output:
#'     html_document:
#'     toc: true
#' number_sections: true
#' ---

#' # summary report
#'
#' This is a random number generator

#+
args <- commandArgs(TRUE)

## quick hack to split named arguments
splitArgs <- function(x) {
    res <- do.call(rbind, lapply(x, function(i){
        res <- strsplit(i, "=")[[1]]
        nm <- gsub("-+", "",res[1])
        c(nm, res[2])
    }))
    .r <- res[,2]
    names(.r) <- res[,1]
    .r
}
args <- splitArgs(args)

#+
r <- runif(n   = as.integer(args["n"]),
           min = as.numeric(args["min"]),
           max = as.numeric(args["max"]))
summary(r)
hist(r)
write.csv(r, file = "out.csv")
```

You command is something like this

```
Rscript -e "rmarkdown::render(knitr::spin('runif_args.R', FALSE))" --args --n=100 --min=30 --max=50
```

And so I describe my tool like this with Docker image `rocker/tidyverse` which contians the knitr and rmarkdown packages.

```
fd <- fileDef(
  name = "runif.R",
  content = readr::read_file(fl)
)

rbx <- Tool(
  id = "runif",
  label = "runif",
  hints = requirements(docker(pull = "rocker/tidyverse"), cpu(1), mem(2000)),
  requirements = requirements(fd),
  baseCommand = "Rscript -e \"rmarkdown::render(knitr::spin('runif.R', FALSE))\" --args",
  stdout = "output.txt",
  inputs = list(
    input(
      id = "number",
      type = "integer",
      separate = FALSE,
      prefix = "--n="
    ),
    input(
      id = "min",
      type = "float",
      separate = FALSE,
      prefix = "--min="
    ),
    input(
      id = "max",
      type = "float",
      separate = FALSE,
      prefix = "--max="
    )
  ),
  outputs = list(
    output(id = "stdout", type = "file", glob = "output.txt"),
    output(id = "random", type = "file", glob = "*.csv"),
    output(id = "report", type = "file", glob = "*.html")
  )
)
```

You will get a report in the end.

### 3.3.8 Misc

**Inherit metadata and additional metadata**

Sometimes if you want your output files inherit from particular input file, just use `inheritMetadataFrom` in your output() call and pass the input file id. If you want to add additional metadata, you could pass `metadata` a list in your output() function call. For example, I want my output report inherit all metadata from my “bam\_file” input node (which I don’t have in this example though) with two additional metadata fields.

```
out.lst <- list(
  output(
    id = "random",
    type = "file",
    label = "output",
    description = "random number file",
    glob = "*.txt"
  ),
  output(
    id = "report",
    type = "file",
    label = "report",
    glob = "*.html",
    inheritMetadataFrom = "bam_file",
    metadata = list(
      author = "RFranklin",
      sample = "random"
    )
  )
)
out.lst
```

```
[[1]]
type:
- 'null'
- File
label: output
description: random number file
streamable: no
default: ''
id: '#random'
outputBinding:
  glob: '*.txt'

[[2]]
type:
- 'null'
- File
label: report
description: ''
streamable: no
default: ''
id: '#report'
outputBinding:
  glob: '*.html'
  sbg:inheritMetadataFrom: '#bam_file'
  sbg:metadata:
    author: RFranklin
    sample: random
```

**Example with file/files as input node**

```
fl <- system.file("docker/rnaseqGene/rabix", "generator.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")
```

```
library("sevenbridges")

rbx <- Tool(
  id = "rnaseqGene",
  label = "rnaseqgene",
  description = "A RNA-seq Differiencial Expression Flow and Report",
  hints = requirements(docker(pull = "tengfei/rnaseqgene"), cpu(1), mem(2000)),
  baseCommand = "performDE.R",
  inputs = list(
    input(
      id = "bamfiles", label = "bam files",
      description = "a list of bam files",
      type = "File...", ## or type = ItemArray("File")
      prefix = "--bamfiles",
      required = TRUE,
      itemSeparator = ","
    ),
    input(
      id = "design", label = "design matrix",
      type = "File",
      required = TRUE,
      prefix = "--design"
    ),
    input(
      id = "gtffile", label = "gene feature files",
      type = "File",
      stageInput = "copy",
      required = TRUE,
      prefix = "--gtffile"
    ),
    input(
      id = "format", label = "report foramt html or pdf",
      type = enum("format", c("pdf", "html")),
      prefix = "--format"
    )
  ),
  outputs = list(
    output(
      id = "report", label = "report",
      description = "A reproducible report created by Rmarkdown",
      glob = Expression(
        engine = "#cwl-js-engine",
        script = "x = $job[['inputs']][['format']]; if(x == 'undefined' || x == null){x = 'html';}; 'rnaseqGene.' +  x"
      )
    ),
    output(
      id = "heatmap", label = "heatmap",
      description = "A heatmap plot to show the Euclidean distance between samples",
      glob = "heatmap.pdf"
    ),
    output(
      id = "count", label = "count",
      description = "Reads counts matrix",
      glob = "count.csv"
    ),
    output(
      id = "de", label = "Differential expression table",
      description = "Differential expression table",
      glob = "de.csv"
    )
  )
)

fl <- "inst/docker/rnaseqGene/rabix/rnaseqGene.json"
write(rbx$toJSON(pretty = TRUE), fl)
```

Note the stageInput example in the above script, you can set it to “copy” or “link”.

**Input node batch mode**

Batch by File (the long output has been omitted here):

```
f1 <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
f1 <- convert_app(f1)
f1$set_batch("sjdbGTFfile", type = "ITEM")
```

Batch by other critieria such as metadta, following example, is using `sample_id` and `library_id` (the long output has been omitted here):

```
f1 <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
f1 <- convert_app(f1)
f1$set_batch("sjdbGTFfile", c("metadata.sample_id", "metadata.library_id"))
```

```
criteria provided, convert type from ITEM to CRITERIA
```

When you push your app to the platform, you will see the batch available at task page or workflow editor.

# 4 Describe Wokrflow in R

**Note**: The [GUI Tool Editor](https://docs.sevenbridges.com/docs/the-tool-editor) on Seven Bridges Platform is more conventient for this purpose.

## 4.1 Import from a JSON file

Yes, you could use the same function `convert_app` to import JSON files.

```
f1 <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
f1 <- convert_app(f1)
# show it
# f1
```

## 4.2 Utilities for `Flow` objects

Just like `Tool` object, you also have convenient utils for it, especially useful when you execute task.

```
f1 <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
f1 <- convert_app(f1)
# input matrix
head(f1$input_matrix())
```

```
                               id               label    type required
1                    #sjdbGTFfile         sjdbGTFfile File...    FALSE
2                          #fastq               fastq File...     TRUE
3               #genomeFastaFiles    genomeFastaFiles    File     TRUE
4 #sjdbGTFtagExonParentTranscript Exons' parents name  string    FALSE
5       #sjdbGTFtagExonParentGene           Gene name  string    FALSE
6          #winAnchorMultimapNmax    Max loci anchors     int    FALSE
  fileTypes
1      null
2      null
3      null
4      null
5      null
6      null
```

```
# by name
head(f1$input_matrix(c("id", "type", "required")))
```

```
                               id    type required
1                    #sjdbGTFfile File...    FALSE
2                          #fastq File...     TRUE
3               #genomeFastaFiles    File     TRUE
4 #sjdbGTFtagExonParentTranscript  string    FALSE
5       #sjdbGTFtagExonParentGene  string    FALSE
6          #winAnchorMultimapNmax     int    FALSE
```

```
# return only required
head(f1$input_matrix(required = TRUE))
```

```
                 id            label    type required fileTypes
2            #fastq            fastq File...     TRUE      null
3 #genomeFastaFiles genomeFastaFiles    File     TRUE      null
```

```
# return everything
head(f1$input_matrix(NULL))
```

```
                               id    type required fileTypes
1                    #sjdbGTFfile File...    FALSE      null
2                          #fastq File...     TRUE      null
3               #genomeFastaFiles    File     TRUE      null
4 #sjdbGTFtagExonParentTranscript  string    FALSE      null
5       #sjdbGTFtagExonParentGene  string    FALSE      null
6          #winAnchorMultimapNmax     int    FALSE      null
                label                       category stageInput streamable
1         sjdbGTFfile                           null       null      FALSE
2               fastq                           null       null      FALSE
3    genomeFastaFiles                           null       null      FALSE
4 Exons' parents name Splice junctions db parameters       null      FALSE
5           Gene name Splice junctions db parameters       null      FALSE
6    Max loci anchors      Windows, Anchors, Binning       null      FALSE
   sbg.x    sbg.y sbg.includeInPorts
1 160.50 195.0833                 NA
2 164.25 323.7500               TRUE
3 167.75 469.9999                 NA
4 200.00 350.0000                 NA
5 200.00 400.0000                 NA
6 200.00 450.0000                 NA
                                                description
1                                                      <NA>
2                                                      <NA>
3                                                      <NA>
4         Tag name to be used as exons' transcript-parents.
5               Tag name to be used as exons' gene-parents.
6 Max number of loci anchors are allowed to map to (int>0).
  sbg.toolDefaultValue                                               link_to
1                 <NA> #STAR_Genome_Generate.sjdbGTFfile | #STAR.sjdbGTFfile
2                 <NA>                     #SBG_FASTQ_Quality_Detector.fastq
3                 <NA>                #STAR_Genome_Generate.genomeFastaFiles
4        transcript_id  #STAR_Genome_Generate.sjdbGTFtagExonParentTranscript
5              gene_id        #STAR_Genome_Generate.sjdbGTFtagExonParentGene
6                   50                           #STAR.winAnchorMultimapNmax
```

```
# return a output matrix with more information
head(f1$output_matrix())
```

```
                            id                       label    type fileTypes
1              #unmapped_reads              unmapped_reads File...      null
2 #transcriptome_aligned_reads transcriptome_aligned_reads    File      null
3            #splice_junctions            splice_junctions    File      null
4              #reads_per_gene              reads_per_gene    File      null
5                   #log_files                   log_files File...      null
6          #chimeric_junctions          chimeric_junctions    File      null
```

```
# return only a few fields
head(f1$output_matrix(c("id", "type")))
```

```
                            id    type
1              #unmapped_reads File...
2 #transcriptome_aligned_reads    File
3            #splice_junctions    File
4              #reads_per_gene    File
5                   #log_files File...
6          #chimeric_junctions    File
```

```
# return everything
head(f1$output_matrix(NULL))
```

```
                            id                       label    type fileTypes
1              #unmapped_reads              unmapped_reads File...      null
2 #transcriptome_aligned_reads transcriptome_aligned_reads    File      null
3            #splice_junctions            splice_junctions    File      null
4              #reads_per_gene              reads_per_gene    File      null
5                   #log_files                   log_files File...      null
6          #chimeric_junctions          chimeric_junctions    File      null
  required                            source streamable sbg.includeInPorts
1    FALSE              #STAR.unmapped_reads      FALSE               TRUE
2    FALSE #STAR.transcriptome_aligned_reads      FALSE               TRUE
3    FALSE            #STAR.splice_junctions      FALSE               TRUE
4    FALSE              #STAR.reads_per_gene      FALSE               TRUE
5    FALSE                   #STAR.log_files      FALSE               TRUE
6    FALSE          #STAR.chimeric_junctions      FALSE               TRUE
      sbg.x     sbg.y                           link_to
1  766.2498 159.58331              #STAR.unmapped_reads
2 1118.9998  86.58332 #STAR.transcriptome_aligned_reads
3 1282.3330 167.49998            #STAR.splice_junctions
4 1394.4164 245.74996              #STAR.reads_per_gene
5 1505.0830 322.99995                   #STAR.log_files
6 1278.7498 446.74996          #STAR.chimeric_junctions
```

```
# flow inputs
f1$input_type()
```

```
                   sjdbGTFfile                          fastq
                     "File..."                      "File..."
              genomeFastaFiles sjdbGTFtagExonParentTranscript
                        "File"                       "string"
      sjdbGTFtagExonParentGene          winAnchorMultimapNmax
                      "string"                          "int"
            winAnchorDistNbins
                         "int"
```

```
# flow outouts
f1$output_type()
```

```
             unmapped_reads transcriptome_aligned_reads
                  "File..."                      "File"
           splice_junctions              reads_per_gene
                     "File"                      "File"
                  log_files          chimeric_junctions
                  "File..."                      "File"
        intermediate_genome         chimeric_alignments
                     "File"                      "File"
                 sorted_bam                      result
                     "File"                      "File"
```

```
# list tools
f1$list_tool()
```

```
                       label
1       STAR Genome Generate
2 SBG FASTQ Quality Detector
3             Picard SortSam
4                       STAR
                                                  sbgid
1       sevenbridges/public-apps/star-genome-generate/1
2 sevenbridges/public-apps/sbg-fastq-quality-detector/3
3       sevenbridges/public-apps/picard-sortsam-1-140/2
4                       sevenbridges/public-apps/star/4
                           id
1       #STAR_Genome_Generate
2 #SBG_FASTQ_Quality_Detector
3             #Picard_SortSam
4                       #STAR
```

```
# f1$get_tool("STAR")
```

There are more utilities please check example at `help(Flow)`

## 4.3 Create your own flow in R

### 4.3.1 Introduction

To create a workflow, we provide simple interface to pipe your tool into a single workflow, it works under situation like

* Simple linear tool connection and chaining
* Connect flow with one or more tools

**Note**: for complicated workflow construction, I highly recommend just use our graphical interface to do it, there is no better way.

### 4.3.2 Connect simple linear tools

Let’s create tools from scratch to perform a simple task

1. Tool 1 output 1000 random number
2. Tool 2 take log on it
3. Tool 3 do a mean calculation of everything

```
library("sevenbridges")
# A tool that generates 100 random numbers
t1 <- Tool(
  id = "runif new test 3", label = "random number",
  hints = requirements(docker(pull = "rocker/r-base")),
  baseCommand = "Rscript -e 'x = runif(100); write.csv(x, file = 'random.txt', row.names = FALSE)'",
  outputs = output(
    id = "random",
    type = "file",
    glob = "random.txt"
  )
)

# A tool that takes log
fd <- fileDef(
  name = "log.R",
  content = "args = commandArgs(TRUE)
                         x = read.table(args[1], header = TRUE)[,'x']
                         x = log(x)
                         write.csv(x, file = 'random_log.txt', row.names = FALSE)
                         "
)

t2 <- Tool(
  id = "log new test 3", label = "get log",
  hints = requirements(docker(pull = "rocker/r-base")),
  requirements = requirements(fd),
  baseCommand = "Rscript log.R",
  inputs = input(
    id = "number",
    type = "file"
  ),
  outputs = output(
    id = "log",
    type = "file",
    glob = "*.txt"
  )
)

# A tool that do a mean
fd <- fileDef(
  name = "mean.R",
  content = "args = commandArgs(TRUE)
                         x = read.table(args[1], header = TRUE)[,'x']
                         x = mean(x)
                         write.csv(x, file = 'random_mean.txt', row.names = FALSE)"
)

t3 <- Tool(
  id = "mean new test 3", label = "get mean",
  hints = requirements(docker(pull = "rocker/r-base")),
  requirements = requirements(fd),
  baseCommand = "Rscript mean.R",
  inputs = input(
    id = "number",
    type = "file"
  ),
  outputs = output(
    id = "mean",
    type = "file",
    glob = "*.txt"
  )
)

f <- t1 %>>% t2
```

```
flow_output: #get_log.log
```

```
f <- link(t1, t2, "#random", "#number")
```

```
flow_output: #get_log.log
```

```
# # you cannot directly copy-paste it
# # please push it using API, we will register each tool for you
# clipr::write_clip(jsonlite::toJSON(f, pretty = TRUE))

t2 <- Tool(
  id = "log new test 3", label = "get log",
  hints = requirements(docker(pull = "rocker/r-base")),
  requirements = requirements(fd),
  baseCommand = "Rscript log.R",
  inputs = input(
    id = "number",
    type = "file",
    secondaryFiles = sevenbridges:::set_box(".bai")
  ),
  outputs = output(
    id = "log",
    type = "file",
    glob = "*.txt"
  )
)

# clipr::write_clip(jsonlite::toJSON(t2, pretty = TRUE))
```

**Note**: this workflow contains tools that do not exist on the platform, so if you copy and paste the JSON directly into the GUI, it won’t work properly. However, a simple way is to push your app to the platform via API. This will add new tools one by one to your project before add your workflow app on the platform. Alternatively, if you connect two tools you know that exist on the platform, you don’t need to do so.

```
# auto-check tool info and push new tools
p$app_add("new_flow_log", f)
```

### 4.3.3 Connecting tools by input and output id

Now let’s connect two tools

1. Unpakcing a compressed fastq files
2. STAR aligner

Checking potential mapping is easy with function `link_what`, it will print matched input and outputs. Then the generic function `link` will allow you to connect two `Tool` objects

If you don’t specify which input/ouput to expose at flow level for new `Flow` object, it will expose all availabl ones and print the message, otherwise, please provide parameters for `flow_input` and `flow_output` with full id.

```
t1 <- system.file("extdata/app", "tool_unpack_fastq.json",
  package = "sevenbridges"
)
t2 <- system.file("extdata/app", "tool_star.json",
  package = "sevenbridges"
)
t1 <- convert_app(t1)
t2 <- convert_app(t2)
# check possible link
link_what(t1, t2)
```

```
$File...
$File...$from
                   id              label    type fileTypes          full.name
1 #output_fastq_files Output FASTQ files File...     FASTQ #SBG_Unpack_FASTQs

$File...$to
             id                label    type required prefix
1        #reads        Read sequence File...     TRUE   <NA>
95 #sjdbGTFfile Splice junction file File...    FALSE   <NA>
                                                  fileTypes full.name
1  FASTA, FASTQ, FA, FQ, FASTQ.GZ, FQ.GZ, FASTQ.BZ2, FQ.BZ2     #STAR
95                                            GTF, GFF, TXT     #STAR
```

```
# link
f1 <- link(t1, t2, "output_fastq_files", "reads")
```

```
flow_input: #SBG_Unpack_FASTQs.input_archive_file / #STAR.sjdbGTFfile / #STAR.genome
```

```
flow_output: #STAR.aligned_reads / #STAR.transcriptome_aligned_reads / #STAR.reads_per_gene / #STAR.log_files / #STAR.splice_junctions / #STAR.chimeric_junctions / #STAR.unmapped_reads / #STAR.intermediate_genome / #STAR.chimeric_alignments
```

```
# link
t1$output_id(TRUE)
```

```
                                File...
"#SBG_Unpack_FASTQs.output_fastq_files"
```

```
t2$input_id(TRUE)
```

```
                                 File...
                           "#STAR.reads"
                                    enum
              "#STAR.readMatesLengthsIn"
                                     int
                   "#STAR.readMapNumber"
                                     int
               "#STAR.limitOutSJoneRead"
                                     int
             "#STAR.limitOutSJcollapsed"
                                    enum
                "#STAR.outReadsUnmapped"
                                     int
              "#STAR.outQSconversionAdd"
                                    enum
                      "#STAR.outSAMtype"
                                    enum
                  "#STAR.outSortingType"
                                    enum
                      "#STAR.outSAMmode"
                                    enum
               "#STAR.outSAMstrandField"
                                    enum
                "#STAR.outSAMattributes"
                                    enum
                  "#STAR.outSAMunmapped"
                                    enum
                     "#STAR.outSAMorder"
                                    enum
               "#STAR.outSAMprimaryFlag"
                                    enum
                    "#STAR.outSAMreadID"
                                     int
                "#STAR.outSAMmapqUnique"
                                     int
                    "#STAR.outSAMflagOR"
                                     int
                   "#STAR.outSAMflagAND"
                                  string
                  "#STAR.outSAMheaderHD"
                                  string
                  "#STAR.outSAMheaderPG"
                                  string
                   "#STAR.rg_seq_center"
                                  string
                   "#STAR.rg_library_id"
                                  string
                          "#STAR.rg_mfl"
                                    enum
                     "#STAR.rg_platform"
                                  string
             "#STAR.rg_platform_unit_id"
                                  string
                    "#STAR.rg_sample_id"
                                    enum
                   "#STAR.outFilterType"
                                     int
     "#STAR.outFilterMultimapScoreRange"
                                     int
           "#STAR.outFilterMultimapNmax"
                                     int
           "#STAR.outFilterMismatchNmax"
                                   float
      "#STAR.outFilterMismatchNoverLmax"
                                   float
  "#STAR.outFilterMismatchNoverReadLmax"
                                     int
               "#STAR.outFilterScoreMin"
                                   float
      "#STAR.outFilterScoreMinOverLread"
                                     int
              "#STAR.outFilterMatchNmin"
                                   float
     "#STAR.outFilterMatchNminOverLread"
                                    enum
           "#STAR.outFilterIntronMotifs"
                                    enum
                "#STAR.outSJfilterReads"
                                  int...
          "#STAR.outSJfilterOverhangMin"
                                  int...
       "#STAR.outSJfilterCountUniqueMin"
                                  int...
        "#STAR.outSJfilterCountTotalMin"
                                  int...
     "#STAR.outSJfilterDistToOtherSJmin"
                                  int...
     "#STAR.outSJfilterIntronMaxVsReadN"
                                     int
                        "#STAR.scoreGap"
                                     int
                  "#STAR.scoreGapNoncan"
                                     int
                    "#STAR.scoreGapGCAG"
                                     int
                    "#STAR.scoreGapATAC"
                                   float
     "#STAR.scoreGenomicLengthLog2scale"
                                     int
                    "#STAR.scoreDelOpen"
                                     int
                    "#STAR.scoreDelBase"
                                     int
                    "#STAR.scoreInsOpen"
                                     int
                    "#STAR.scoreInsBase"
                                     int
              "#STAR.scoreStitchSJshift"
                                     int
             "#STAR.seedSearchStartLmax"
                                   float
    "#STAR.seedSearchStartLmaxOverLread"
                                     int
                  "#STAR.seedSearchLmax"
                                     int
                "#STAR.seedMultimapNmax"
                                     int
                 "#STAR.seedPerReadNmax"
                                     int
               "#STAR.seedPerWindowNmax"
                                     int
           "#STAR.seedNoneLociPerWindow"
                                     int
                  "#STAR.alignIntronMin"
                                     int
                  "#STAR.alignIntronMax"
                                     int
                "#STAR.alignMatesGapMax"
                                     int
              "#STAR.alignSJoverhangMin"
                                     int
            "#STAR.alignSJDBoverhangMin"
                                     int
         "#STAR.alignSplicedMateMapLmin"
                                   float
"#STAR.alignSplicedMateMapLminOverLmate"
                                   float
         "#STAR.alignWindowsPerReadNmax"
                                     int
   "#STAR.alignTranscriptsPerWindowNmax"
                                     int
     "#STAR.alignTranscriptsPerReadNmax"
                                    enum
                   "#STAR.alignEndsType"
                                    enum
    "#STAR.alignSoftClipAtReferenceEnds"
                                     int
           "#STAR.winAnchorMultimapNmax"
                                     int
                     "#STAR.winBinNbits"
                                     int
              "#STAR.winAnchorDistNbins"
                                     int
                   "#STAR.winFlankNbins"
                                     int
                  "#STAR.chimSegmentMin"
                                     int
                    "#STAR.chimScoreMin"
                                     int
                "#STAR.chimScoreDropMax"
                                     int
             "#STAR.chimScoreSeparation"
                                     int
        "#STAR.chimScoreJunctionNonGTAG"
                                     int
         "#STAR.chimJunctionOverhangMin"
                                    enum
                       "#STAR.quantMode"
                                     int
                  "#STAR.twopass1readsN"
                                    enum
                     "#STAR.twopassMode"
                                  string
                   "#STAR.genomeDirName"
                                    enum
                  "#STAR.sjdbInsertSave"
                                  string
                "#STAR.sjdbGTFchrPrefix"
                                  string
              "#STAR.sjdbGTFfeatureExon"
                                  string
  "#STAR.sjdbGTFtagExonParentTranscript"
                                  string
        "#STAR.sjdbGTFtagExonParentGene"
                                     int
                    "#STAR.sjdbOverhang"
                                     int
                       "#STAR.sjdbScore"
                                 File...
                     "#STAR.sjdbGTFfile"
                                  int...
                    "#STAR.clip3pNbases"
                                  int...
                    "#STAR.clip5pNbases"
                               string...
                "#STAR.clip3pAdapterSeq"
                                float...
                "#STAR.clip3pAdapterMMp"
                                  int...
        "#STAR.clip3pAfterAdapterNbases"
                                    enum
                     "#STAR.chimOutType"
                                    File
                          "#STAR.genome"
                                     int
              "#STAR.limitSjdbInsertNsj"
                                    enum
           "#STAR.quantTranscriptomeBan"
                                     int
                 "#STAR.limitBAMsortRAM"
```

```
f2 <- link(t1, t2, "output_fastq_files", "reads",
  flow_input = "#SBG_Unpack_FASTQs.input_archive_file",
  flow_output = "#STAR.log_files"
)
```

```
flow_input: #SBG_Unpack_FASTQs.input_archive_file / #STAR.genome
```

```
flow_output: #STAR.log_files
```

```
# clipr::write_clip(jsonlite::toJSON(f2))
```

### 4.3.4 Connecting tool with workflow by input and output id

```
tool.in <- system.file("extdata/app", "tool_unpack_fastq.json", package = "sevenbridges")
flow.in <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")

t1 <- convert_app(tool.in)
f2 <- convert_app(flow.in)
# consulting link_what first
f2$link_map()
```

```
                                                     id
1  #STAR_Genome_Generate.sjdbGTFtagExonParentTranscript
2        #STAR_Genome_Generate.sjdbGTFtagExonParentGene
3                     #STAR_Genome_Generate.sjdbGTFfile
4                #STAR_Genome_Generate.genomeFastaFiles
5                     #SBG_FASTQ_Quality_Detector.fastq
6                             #Picard_SortSam.input_bam
7                           #STAR.winAnchorMultimapNmax
8                              #STAR.winAnchorDistNbins
9                                     #STAR.sjdbGTFfile
10                                          #STAR.reads
11                                         #STAR.genome
12                                      #unmapped_reads
13                         #transcriptome_aligned_reads
14                                    #splice_junctions
15                                      #reads_per_gene
16                                           #log_files
17                                  #chimeric_junctions
18                                 #intermediate_genome
19                                 #chimeric_alignments
20                                          #sorted_bam
21                                              #result
                               source   type
1     #sjdbGTFtagExonParentTranscript  input
2           #sjdbGTFtagExonParentGene  input
3                        #sjdbGTFfile  input
4                   #genomeFastaFiles  input
5                              #fastq  input
6                 #STAR.aligned_reads  input
7              #winAnchorMultimapNmax  input
8                 #winAnchorDistNbins  input
9                        #sjdbGTFfile  input
10 #SBG_FASTQ_Quality_Detector.result  input
11       #STAR_Genome_Generate.genome  input
12               #STAR.unmapped_reads output
13  #STAR.transcriptome_aligned_reads output
14             #STAR.splice_junctions output
15               #STAR.reads_per_gene output
16                    #STAR.log_files output
17           #STAR.chimeric_junctions output
18          #STAR.intermediate_genome output
19          #STAR.chimeric_alignments output
20         #Picard_SortSam.sorted_bam output
21 #SBG_FASTQ_Quality_Detector.result output
```

```
# then link

f3 <- link(t1, f2, c("output_fastq_files"), c("#SBG_FASTQ_Quality_Detector.fastq"))

link_what(f2, t1)
```

```
$File
$File$from
                             id                       label type required
2  #transcriptome_aligned_reads transcriptome_aligned_reads File    FALSE
3             #splice_junctions            splice_junctions File    FALSE
4               #reads_per_gene              reads_per_gene File    FALSE
6           #chimeric_junctions          chimeric_junctions File    FALSE
7          #intermediate_genome         intermediate_genome File    FALSE
8          #chimeric_alignments         chimeric_alignments File    FALSE
9                   #sorted_bam                  sorted_bam File    FALSE
10                      #result                      result File    FALSE
   fileTypes                            link_to
2       null  #STAR.transcriptome_aligned_reads
3       null             #STAR.splice_junctions
4       null               #STAR.reads_per_gene
6       null           #STAR.chimeric_junctions
7       null          #STAR.intermediate_genome
8       null          #STAR.chimeric_alignments
9       null         #Picard_SortSam.sorted_bam
10      null #SBG_FASTQ_Quality_Detector.result

$File$to
                   id              label type required               prefix
1 #input_archive_file Input archive file File     TRUE --input_archive_file
                                       fileTypes
1 TAR, TAR.GZ, TGZ, TAR.BZ2, TBZ2,  GZ, BZ2, ZIP
```

```
f4 <- link(f2, t1, c("#Picard_SortSam.sorted_bam", "#SBG_FASTQ_Quality_Detector.result"), c("#input_archive_file", "#input_archive_file"))
```

```
flow_input: #SBG_Unpack_FASTQs.input_archive_file
```

```
flow_output: #SBG_Unpack_FASTQs.output_fastq_files
```

```
# # TODO
# # all outputs
# # flow + flow
# # print message when name wrong
# clipr::write_clip(jsonlite::toJSON(f4))
```

### 4.3.5 Using pipe to construct complicated workflow

# 5 Execution

## 5.1 Execute the tool and flow in the cloud

With API function, you can directly load your Tool into the account. Run a task, for “how-to”, please check the complete guide for API client.

Here is a quick demo:

```
a <- Auth(platform = "platform_name", token = "your_token")
p <- a$project("demo")
app.runif <- p$app_add("runif555", rbx)
aid <- app.runif$id
tsk <- p$task_add(
  name = "Draft runif simple",
  description = "Description for runif",
  app = aid,
  inputs = list(min = 1, max = 10)
)
tsk$run()
```

## 5.2 Execute the tool in Rabix – test locally

**1. From CLI**

While developing tools it is useful to test them locally first. For that we can use rabix – reproducible analyses for bioinformatics, <https://github.com/rabix>. To test your tool with latest implementation of rabix in Java (called **bunny**) you could use the Docker image `RFranklin/testenv`:

```
docker pull RFranklin/testenv
```

Dump your rabix tool as JSON into dir which also contains input data. `write(rbx$toJSON, file="<data_dir>/<tool>.json")`. Make **inputs.json** file to declare input parameters in the same directory (you can use relative paths from inputs.json to data). Create container:

```
docker run --privileged --name bunny -v </path/to/data_dir>:/bunny_data -dit RFranklin/testenv
```

Execute tool

```
docker exec bunny bash -c 'cd /opt/bunny && ./rabix.sh -e /bunny_data /bunny_data/<tool>.json /bunny_data/inputs.json'
```

You’ll see running logs from within container, and also output dir inside  in home system.

* **Note 1**: `RFranklin/testenv` has R, Python, Java… so many tools can work without Docker requirement set. If you however set Docker requirement you need to pull image inside container first to run Docker container inside running bunny Docker.
* **Note 2**: inputs.json can also be inputs.yaml if you find it easier to declare inputs in YAML.

**2. From R**

```
library("sevenbridges")

in.df <- data.frame(
  id = c("number", "min", "max", "seed"),
  description = c(
    "number of observation",
    "lower limits of the distribution",
    "upper limits of the distribution",
    "seed with set.seed"
  ),
  type = c("integer", "float", "float", "float"),
  label = c("number", "min", "max", "seed"),
  prefix = c("--n", "--min", "--max", "--seed"),
  default = c(1, 0, 10, 123),
  required = c(TRUE, FALSE, FALSE, FALSE)
)
out.df <- data.frame(
  id = c("random", "report"),
  type = c("file", "file"),
  glob = c("*.txt", "*.html")
)
rbx <- Tool(
  id = "runif",
  label = "Random number generator",
  hints = requirements(docker(pull = "RFranklin/runif"), cpu(1), mem(2000)),
  baseCommand = "runif.R",
  inputs = in.df, # or ins.df
  outputs = out.df
)
params <- list(number = 3, max = 5)

set_test_env("RFranklin/testenv", "mount_dir")
test_tool(rbx, params)
```