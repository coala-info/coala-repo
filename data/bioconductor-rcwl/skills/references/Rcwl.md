# Rcwl: An R interface to the Common Workflow Language (CWL)

Qiang Hu, Qian Liu

#### 2025-10-30

Here we introduce the *Bioconductor* toolchain for usage and development
of reproducible bioinformatics pipelines using packages of
[Rcwl](https://bioconductor.org/packages/Rcwl/) and
[RcwlPipelines](https://bioconductor.org/packages/RcwlPipelines/).

`Rcwl` provides a simple way to wrap command line tools and build CWL
data analysis pipelines programmatically within *R*. It increases the
ease of use, development, and maintenance of CWL
pipelines. `RcwlPipelines` manages a collection of more than a hundred
of pre-built and tested CWL tools and pipelines, which are highly
modularized with easy customization to meet different bioinformatics
data analysis needs.

In this vignette, we will introduce how to build and run CWL pipelines
within *R/Bioconductor* using `Rcwl`package. More details about CWL
can be found at <https://www.commonwl.org>.

# 1 Installation

1. Download and install the package.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Rcwl")
```

The development version with most up-to-date functionalities is also
available from GitHub.

```
BiocManager::install("rworkflow/Rcwl")
```

2. Load the package into *R* session.

```
library(Rcwl)
```

# 2 First Example

`cwlProcess` is the main constructor function to wrap a command line
tool into an *R* tool as a `cwlProcess` object (S4 class). Let’s
start with a simple example to wrap the `echo` command and execute
`echo hello world` in *R*.

First, we need to define the input parameter for the base command
`echo`, here it is a string without a prefix. An `id` argument is
required here.

```
input1 <- InputParam(id = "sth")
```

Second, we can construct a `cwlProcess` object by specifying the
`baseCommand` for the command line tool, and `InputParamList` for the
input parameters.

```
echo <- cwlProcess(baseCommand = "echo", inputs = InputParamList(input1))
```

Now we have converted the command line tool `echo` into an *R* tool:
an *R* object of class `cwlProcess` with the name of `echo`. We can
take a look at the this *R* object and use some utility functions to
extract specific information.

```
echo
```

```
## class: cwlProcess
##  cwlClass: CommandLineTool
##  cwlVersion: v1.0
##  baseCommand: echo
## inputs:
##   sth (string):
## outputs:
## output:
##   type: stdout
```

```
class(echo)
```

```
## [1] "cwlProcess"
## attr(,"package")
## [1] "Rcwl"
```

```
cwlClass(echo)
```

```
## [1] "CommandLineTool"
```

```
cwlVersion(echo)
```

```
## [1] "v1.0"
```

```
baseCommand(echo)
```

```
## [1] "echo"
```

```
inputs(echo)
```

```
## inputs:
##   sth (string):
```

```
outputs(echo)
```

```
## outputs:
## output:
##   type: stdout
```

The `inputs(echo)` will show the value once it is assigned in next
step. Since we didn’t define the outputs for this tool, it will stream
standard output to a temporary file by default.

The third step is to assign values (here is “Hello World!”) for the
input parameters.

```
echo$sth <- "Hello World!"
inputs(echo)
```

```
## inputs:
##   sth (string):  Hello World!
```

Now this *R* version of command line tool `echo` is ready to be
executed.

We can install `cwltool` first to make sure a `cwl-runner` is
available.

```
invisible(install_cwltool())
```

```
## Using Python: /home/biocbuild/.pyenv/versions/3.11.14/bin/python3.11
## Creating virtual environment '/var/cache/basilisk/1.22.0/Rcwl/1.26.0/env_Rcwl' ...
```

```
## + /home/biocbuild/.pyenv/versions/3.11.14/bin/python3.11 -m venv /var/cache/basilisk/1.22.0/Rcwl/1.26.0/env_Rcwl
```

```
## Done!
## Installing packages: pip, wheel, setuptools
```

```
## + /var/cache/basilisk/1.22.0/Rcwl/1.26.0/env_Rcwl/bin/python -m pip install --upgrade pip wheel setuptools
```

```
## Installing packages: 'cwltool==3.1.20230719185429'
```

```
## + /var/cache/basilisk/1.22.0/Rcwl/1.26.0/env_Rcwl/bin/python -m pip install --upgrade --no-user 'cwltool==3.1.20230719185429'
```

```
## Virtual environment '/var/cache/basilisk/1.22.0/Rcwl/1.26.0/env_Rcwl' successfully created.
```

The function `runCWL` runs the tools in *R* and returns a list of: 1)
actual command line that was executed, 2) filepath to the output, and
3) running logs. The output directory by default takes the working
directory, but can be specified in `outdir` argument.

```
r1 <- runCWL(echo, outdir = tempdir())
```

```
## }[1;30mINFO[0m Final process status is success
```

```
r1
```

```
## List of length 3
## names(3): command output logs
```

```
r1$command
```

```
## [1] "\033[1;30mINFO\033[0m [job echo.cwl] /tmp/yxj_g_px$ echo \\"
## [2] "    'Hello World!' > /tmp/yxj_g_px/d0dac7cf6866e58af39bcf7d176902d2cd814e60"
```

```
readLines(r1$output)
```

```
## [1] "Hello World!"
```

```
r1$logs
```

```
##  [1] "\033[1;30mINFO\033[0m /var/cache/basilisk/1.22.0/Rcwl/1.26.0/env_Rcwl/bin/cwltool 3.1.20230719185429"
##  [2] "\033[1;30mINFO\033[0m Resolved '/tmp/RtmpfU5DPe/file27a0c127bbd877/echo.cwl' to 'file:///tmp/RtmpfU5DPe/file27a0c127bbd877/echo.cwl'"
##  [3] "\033[1;30mINFO\033[0m [job echo.cwl] /tmp/yxj_g_px$ echo \\"
##  [4] "    'Hello World!' > /tmp/yxj_g_px/d0dac7cf6866e58af39bcf7d176902d2cd814e60"
##  [5] "\033[1;30mINFO\033[0m [job echo.cwl] completed success"
##  [6] "{"
##  [7] "    \"output\": {"
##  [8] "        \"location\": \"file:///tmp/RtmpfU5DPe/d0dac7cf6866e58af39bcf7d176902d2cd814e60\","
##  [9] "        \"basename\": \"d0dac7cf6866e58af39bcf7d176902d2cd814e60\","
## [10] "        \"class\": \"File\","
## [11] "        \"checksum\": \"sha1$a0b65939670bc2c010f4d5d6a0b3e4e4590fb92b\","
## [12] "        \"size\": 13,"
## [13] "        \"path\": \"/tmp/RtmpfU5DPe/d0dac7cf6866e58af39bcf7d176902d2cd814e60\""
## [14] "    }"
## [15] "}\033[1;30mINFO\033[0m Final process status is success"
```

Users can also have the log printed out by specifying `showLog = TRUE`.

```
r1 <- runCWL(echo, outdir = tempdir(), showLog = TRUE)
```

```
## }
```

A utility function `writeCWL` converts the `cwlProcess` object into 2
files: a `.cwl` file for the command and `.yml` file for the inputs,
which are the internal cwl files to be executed when `runCWL` is
invoked. The internal execution requires a `cwl-runner` (e.g.,
`cwltool`), which will be installed automatically with `runCWL`.

```
writeCWL(echo)
```

```
##                                        cwlout
## "/tmp/RtmpfU5DPe/file27a0c16cb8af0d/echo.cwl"
##                                        ymlout
## "/tmp/RtmpfU5DPe/file27a0c16cb8af0d/echo.yml"
```

# 3 Wrap command line tools

The package provides functions to define a CWL syntax for Command Line
Tools in an intuitive way. The functions were developed based on the
CWL Command Line Tool Description (v1.0). More details can be found in
the official document:
<https://www.commonwl.org/v1.0/CommandLineTool.html>.

## 3.1 Input Parameters

### 3.1.1 Essential Input parameters

For the input parameters, three options need to be defined usually,
*id*, *type*, and *prefix*. The type can be *string*, *int*, *long*,
*float*, *double*, and so on. More detail can be found at:
<https://www.commonwl.org/v1.0/CommandLineTool.html#CWLType>.

Here is an example from [CWL user
guide](http://www.commonwl.org/user_guide/03-input/). Here we defined
an `echo` with different type of input parameters by `InputParam`. The
`stdout` option can be used to capture the standard output stream to a
file.

```
e1 <- InputParam(id = "flag", type = "boolean", prefix = "-f")
e2 <- InputParam(id = "string", type = "string", prefix = "-s")
e3 <- InputParam(id = "int", type = "int", prefix = "-i")
e4 <- InputParam(id = "file", type = "File", prefix = "--file=", separate = FALSE)
echoA <- cwlProcess(baseCommand = "echo",
                  inputs = InputParamList(e1, e2, e3, e4),
                  stdout = "output.txt")
```

Then we give it a try by setting values for the inputs.

```
echoA$flag <- TRUE
echoA$string <- "Hello"
echoA$int <- 1

tmpfile <- tempfile()
write("World", tmpfile)
echoA$file <- tmpfile

r2 <- runCWL(echoA, outdir = tempdir())
```

```
## }[1;30mINFO[0m Final process status is success
```

```
r2$command
```

```
## [1] "\033[1;30mINFO\033[0m [job echoA.cwl] /tmp/5j_fbk6m$ echo \\"
## [2] "    --file=/tmp/uk85e3o8/stg7d7fef85-6537-4099-81bf-1498395ecf0c/file27a0c16837e2e5 \\"
## [3] "    -f \\"
## [4] "    -i \\"
## [5] "    1 \\"
## [6] "    -s \\"
## [7] "    Hello > /tmp/5j_fbk6m/output.txt"
```

The command shows the parameters work as we defined. The parameter
order is in alphabetical by default, but the option of “position” can
be used to fix the orders.

### 3.1.2 Array Inputs

A similar example to CWL user guide. We can define three different type of array as inputs.

```
a1 <- InputParam(id = "A", type = "string[]", prefix = "-A")
a2 <- InputParam(id = "B",
                 type = InputArrayParam(items = "string",
                                        prefix="-B=", separate = FALSE))
a3 <- InputParam(id = "C", type = "string[]", prefix = "-C=",
                 itemSeparator = ",", separate = FALSE)
echoB <- cwlProcess(baseCommand = "echo",
                 inputs = InputParamList(a1, a2, a3))
```

Then set values for the three inputs.

```
echoB$A <- letters[1:3]
echoB$B <- letters[4:6]
echoB$C <- letters[7:9]
echoB
```

```
## class: cwlProcess
##  cwlClass: CommandLineTool
##  cwlVersion: v1.0
##  baseCommand: echo
## inputs:
##   A (string[]): -A a b c
##   B:
##     type: array
##     prefix: -B= d e f
##   C (string[]): -C= g h i
## outputs:
## output:
##   type: stdout
```

Now we can check whether the command behaves as we expected.

```
r3 <- runCWL(echoB, outdir = tempdir())
```

```
## }[1;30mINFO[0m Final process status is success
```

```
r3$command
```

```
## [1] "\033[1;30mINFO\033[0m [job echoB.cwl] /tmp/19piopgz$ echo \\"
## [2] "    -A \\"
## [3] "    a \\"
## [4] "    b \\"
## [5] "    c \\"
## [6] "    -B=d \\"
## [7] "    -B=e \\"
## [8] "    -B=f \\"
## [9] "    -C=g,h,i > /tmp/19piopgz/efa53ef40bb809f497241e42d5adee27034693ab"
```

## 3.2 Output Parameters

### 3.2.1 Capturing Output

The outputs, similar to the inputs, is a list of output parameters. Three options *id*, *type* and *glob* can be defined. The glob option is used to define a pattern to find files relative to the output directory.

Here is an example to unzip a compressed `gz` file. First, we generate a compressed R script file.

```
zzfil <- file.path(tempdir(), "sample.R.gz")
zz <- gzfile(zzfil, "w")
cat("sample(1:10, 5)", file = zz, sep = "\n")
close(zz)
```

We define a `cwlProcess` object to use “gzip” to uncompress a input file.

```
ofile <- "sample.R"
z1 <- InputParam(id = "uncomp", type = "boolean", prefix = "-d")
z2 <- InputParam(id = "out", type = "boolean", prefix = "-c")
z3 <- InputParam(id = "zfile", type = "File")
o1 <- OutputParam(id = "rfile", type = "File", glob = ofile)
gz <- cwlProcess(baseCommand = "gzip",
               inputs = InputParamList(z1, z2, z3),
               outputs = OutputParamList(o1),
               stdout = ofile)
```

Now the `gz` object can be used to uncompress the previous generated compressed file.

```
gz$uncomp <- TRUE
gz$out <- TRUE
gz$zfile <- zzfil
r4 <- runCWL(gz, outdir = tempdir())
```

```
## }[1;30mINFO[0m Final process status is success
```

```
r4$output
```

```
## [1] "/tmp/RtmpfU5DPe/sample.R"
```

Or we can use `arguments` to set some default parameters.

```
z1 <- InputParam(id = "zfile", type = "File")
o1 <- OutputParam(id = "rfile", type = "File", glob = ofile)
Gz <- cwlProcess(baseCommand = "gzip",
               arguments = list("-d", "-c"),
               inputs = InputParamList(z1),
               outputs = OutputParamList(o1),
               stdout = ofile)
Gz
```

```
## class: cwlProcess
##  cwlClass: CommandLineTool
##  cwlVersion: v1.0
##  baseCommand: gzip
## arguments: -d -c
## inputs:
##   zfile (File):
## outputs:
## rfile:
##   type: File
##   outputBinding:
##     glob: sample.R
## stdout: sample.R
```

```
Gz$zfile <- zzfil
r4a <- runCWL(Gz, outdir = tempdir())
```

```
## }[1;30mINFO[0m Final process status is success
```

To make it for general usage, we can define a pattern with javascript
to glob the output, which require `node` from “nodejs” to be installed in your
system PATH.

```
pfile <- "$(inputs.zfile.path.split('/').slice(-1)[0].split('.').slice(0,-1).join('.'))"
```

Or we can use the CWL built in file property, `nameroot`, directly.

```
pfile <- "$(inputs.zfile.nameroot)"
o2 <- OutputParam(id = "rfile", type = "File", glob = pfile)
req1 <- requireJS()
GZ <- cwlProcess(baseCommand = "gzip",
               arguments = list("-d", "-c"),
               requirements = list(), ## assign list(req1) if node installed.
               inputs = InputParamList(z1),
               outputs = OutputParamList(o2),
               stdout = pfile)
GZ$zfile <- zzfil
r4b <- runCWL(GZ, outdir = tempdir())
```

```
## }[1;30mINFO[0m Final process status is success
```

### 3.2.2 Array Outputs

We can also capture multiple output files with `glob` pattern.

```
a <- InputParam(id = "a", type = InputArrayParam(items = "string"))
b <- OutputParam(id = "b", type = OutputArrayParam(items = "File"),
                 glob = "*.txt")
touch <- cwlProcess(baseCommand = "touch", inputs = InputParamList(a),
                    outputs = OutputParamList(b))
touch$a <- c("a.txt", "b.log", "c.txt")
r5 <- runCWL(touch, outdir = tempdir())
```

```
## }[1;30mINFO[0m Final process status is success
```

```
r5$output
```

```
## [1] "/tmp/RtmpfU5DPe/a.txt" "/tmp/RtmpfU5DPe/c.txt"
```

The “touch” command generates three files, but the output only collects
two files with “.txt” suffix as defined in the `OutputParam` using the
“glob” option.

# 4 Running Tools in Docker

The CWL can work with docker to simplify your software management and
communicate files between host and container. The docker container can
be defined by the `hints` or `requirements` option.

```
d1 <- InputParam(id = "rfile", type = "File")
req1 <- requireDocker("r-base")
doc <- cwlProcess(baseCommand = "Rscript",
                inputs = InputParamList(d1),
                stdout = "output.txt",
                hints = list(req1))
doc$rfile <- r4$output
```

```
r6 <- runCWL(doc)
```

The tools defined with docker requirements can also be run locally by
disabling the docker option. In case your `Rscript` depends some local
libraries to run, an option from `cwltools`,
“–preserve-entire-environment”, can be used to pass all environment
variables.

```
r6a <- runCWL(doc, docker = FALSE, outdir = tempdir(),
              cwlArgs = "--preserve-entire-environment")
```

```
## }[1;30mINFO[0m Final process status is success
```

# 5 Running Tools in Cluster server

The CWL can also work in high performance clusters with batch-queuing
system, such as SGE, PBS, SLURM and so on, using the Bioconductor
package `BiocParallel`. Here is an example to submit jobs with
“Multicore” and “SGE”.

```
library(BiocParallel)
sth.list <- as.list(LETTERS)
names(sth.list) <- LETTERS

## submit with multicore
result1 <- runCWLBatch(cwl = echo, outdir = tempdir(), inputList = list(sth = sth.list),
                       BPPARAM = MulticoreParam(26))

## submit with SGE
result2 <- runCWLBatch(cwl = echo, outdir = tempdir(), inputList = list(sth = sth.list),
                       BPPARAM = BatchtoolsParam(workers = 26, cluster = "sge",
                                                 resources = list(queue = "all.q")))
```

# 6 Writing Pipeline

We can connect multiple tools together into a pipeline. Here is an
example to uncompress an R script and execute it with `Rscript`.

Here we define a simple `Rscript` tool without using docker.

```
d1 <- InputParam(id = "rfile", type = "File")
Rs <- cwlProcess(baseCommand = "Rscript",
               inputs = InputParamList(d1))
Rs
```

```
## class: cwlProcess
##  cwlClass: CommandLineTool
##  cwlVersion: v1.0
##  baseCommand: Rscript
## inputs:
##   rfile (File):
## outputs:
## output:
##   type: stdout
```

Test run:

```
Rs$rfile <- r4$output
tres <- runCWL(Rs, outdir = tempdir())
```

```
## }[1;30mINFO[0m Final process status is success
```

```
readLines(tres$output)
```

```
## [1] "[1] 2 4 3 9 6"
```

The pipeline includes two steps, decompressing with predefined
`cwlProcess` of `GZ` and compiling with `cwlProcess` of `Rs`. The
input file is a compressed file for the first “Uncomp” step.

```
i1 <- InputParam(id = "cwl_zfile", type = "File")
s1 <- cwlStep(id = "Uncomp", run = GZ,
              In = list(zfile = "cwl_zfile"))
s2 <- cwlStep(id = "Compile", run = Rs,
              In = list(rfile = "Uncomp/rfile"))
```

In step 1 (‘s1’), the pipeline runs the `cwlProcess` of `GZ`, where
the input `zfile` is defined in ‘i1’ with id of “cwl\_zfile”. In step 2
(‘s2’), the pipeline runs the `cwlProcess` of `Rs`, where the input
`rfile` is from the output of the step 1 (“Uncomp/rfile”) using the
format of `<step>/<output>`.

The pipeline output will be defined as the output of the step 2
(“Compile/output”) using the format of `<step>/<output>` as shown
below.

```
o1 <- OutputParam(id = "cwl_cout", type = "File",
                  outputSource = "Compile/output")
```

The `cwlWorkflow` function is used to initiate the pipeline by
specifying the `inputs` and `outputs`. Then we can simply use `+` to
connect all steps to build the final pipeline.

```
cwl <- cwlWorkflow(inputs = InputParamList(i1),
                    outputs = OutputParamList(o1))
cwl <- cwl + s1 + s2
cwl
```

```
## class: cwlWorkflow
##  cwlClass: Workflow
##  cwlVersion: v1.0
## inputs:
##   cwl_zfile (File):
## outputs:
## cwl_cout:
##   type: File
##   outputSource: Compile/output
## steps:
## Uncomp:
##   run: Uncomp.cwl
##   in:
##     zfile: cwl_zfile
##   out:
##   - rfile
## Compile:
##   run: Compile.cwl
##   in:
##     rfile: Uncomp/rfile
##   out:
##   - output
```

Let’s run the pipeline.

```
cwl$cwl_zfile <- zzfil
r7 <- runCWL(cwl, outdir = tempdir())
```

```
## }[1;30mINFO[0m Final process status is success
```

```
readLines(r7$output)
```

```
## [1] "[1] 5 9 4 8 1"
```

Tips: Sometimes, we need to adjust some arguments of certain tools in
a pipeline besides of parameter inputs. The function `arguments` can
help to modify arguments for a tool, tool in a pipeline, or even tool
in a sub-workflow. For example,

```
arguments(cwl, step = "Uncomp") <- list("-d", "-c", "-f")
runs(cwl)$Uncomp
```

```
## class: cwlProcess
##  cwlClass: CommandLineTool
##  cwlVersion: v1.0
##  baseCommand: gzip
## arguments: -d -c -f
## inputs:
##   zfile (File):  /tmp/RtmpfU5DPe/sample.R.gz
## outputs:
## rfile:
##   type: File
##   outputBinding:
##     glob: $(inputs.zfile.nameroot)
## stdout: $(inputs.zfile.nameroot)
```

## 6.1 Scattering pipeline

The scattering feature can specifies the associated workflow step or
subworkflow to execute separately over a list of input elements. To
use this feature, `ScatterFeatureRequirement` must be specified in the
workflow requirements. Different `scatter` methods can be used in the
associated step to decompose the input into a discrete set of
jobs. More details can be found at:
<https://www.commonwl.org/v1.0/Workflow.html#WorkflowStep>.

Here is an example to execute multiple R scripts. First, we need to
set the input and output types to be array of “File”, and add the
requirements. In the “Compile” step, the scattering input is required
to be set with the `scatter` option.

```
i2 <- InputParam(id = "cwl_rfiles", type = "File[]")
o2 <- OutputParam(id = "cwl_couts", type = "File[]", outputSource = "Compile/output")
req1 <- requireScatter()
cwl2 <- cwlWorkflow(requirements = list(req1),
                    inputs = InputParamList(i2),
                    outputs = OutputParamList(o2))
s1 <- cwlStep(id = "Compile", run = Rs,
              In = list(rfile = "cwl_rfiles"),
              scatter = "rfile")
cwl2 <- cwl2 + s1
cwl2
```

```
## class: cwlWorkflow
##  cwlClass: Workflow
##  cwlVersion: v1.0
## requirements:
## - class: ScatterFeatureRequirement
## inputs:
##   cwl_rfiles (File[]):
## outputs:
## cwl_couts:
##   type: File[]
##   outputSource: Compile/output
## steps:
## Compile:
##   run: Compile.cwl
##   in:
##     rfile: cwl_rfiles
##   out:
##   - output
##   scatter: rfile
```

Multiple R scripts can be assigned to the workflow inputs and executed.

```
cwl2$cwl_rfiles <- c(r4b$output, r4b$output)
r8 <- runCWL(cwl2, outdir = tempdir())
```

```
## }[1;30mINFO[0m Final process status is success
```

```
r8$output
```

```
## [1] "/tmp/RtmpfU5DPe/3b683d4bb5fadd3d0207295a1ce0099b7269b751"
## [2] "/tmp/RtmpfU5DPe/3b683d4bb5fadd3d0207295a1ce0099b7269b751_2"
```

## 6.2 Pipeline plot

The function `plotCWL` can be used to visualize the relationship of
inputs, outputs and the analysis for a tool or pipeline.

```
plotCWL(cwl)
```

# 7 Web Application

## 7.1 cwlProcess example

Here we build a tool with different types of input parameters.

```
e1 <- InputParam(id = "flag", type = "boolean",
                 prefix = "-f", doc = "boolean flag")
e2 <- InputParam(id = "string", type = "string", prefix = "-s")
e3 <- InputParam(id = "option", type = "string", prefix = "-o")
e4 <- InputParam(id = "int", type = "int", prefix = "-i", default = 123)
e5 <- InputParam(id = "file", type = "File",
                 prefix = "--file=", separate = FALSE)
e6 <- InputParam(id = "array", type = "string[]", prefix = "-A",
                 doc = "separated by comma")
mulEcho <- cwlProcess(baseCommand = "echo", id = "mulEcho",
                 label = "Test parameter types",
                 inputs = InputParamList(e1, e2, e3, e4, e5, e6),
                 stdout = "output.txt")
mulEcho
```

```
## class: cwlProcess
##  cwlClass: CommandLineTool
##  cwlVersion: v1.0
##  baseCommand: echo
## inputs:
##   flag (boolean): -f
##   string (string): -s
##   option (string): -o
##   int (int): -i 123
##   file (File): --file=
##   array (string[]): -A
## outputs:
## output:
##   type: stdout
## stdout: output.txt
```

## 7.2 cwlProcess to Shiny App

Some input parameters can be predefined in a list, which will be
converted to select options in the webapp. An `upload` parameter can
be used to defined whether to generate an upload interface for the
file type option. If FALSE, the upload field will be text input (file
path) instead of file input.

```
inputList <- list(option = c("option1", "option2"))
app <- cwlShiny(mulEcho, inputList, upload = TRUE)
runApp(app)
```

![](data:image/png;base64...)

shinyApp

# 8 Working with R functions

We can wrap an R function to `cwlProcess` object by simply assigning the R function to `baseCommand`. This could be useful to summarize results from other tools in a pipeline. It can also be used to benchmark different parameters for a method written in R. Please note that this feature is only implemented by `Rcwl`, but not available in the common workflow language.

```
fun1 <- function(x)x*2
testFun <- function(a, b){
    cat(fun1(a) + b^2, sep="\n")
}
assign("fun1", fun1, envir = .GlobalEnv)
assign("testFun", testFun, envir = .GlobalEnv)
p1 <- InputParam(id = "a", type = "int", prefix = "a=", separate = F)
p2 <- InputParam(id = "b", type = "int", prefix = "b=", separate = F)
o1 <- OutputParam(id = "o", type = "File", glob = "rout.txt")
TestFun <- cwlProcess(baseCommand = testFun,
                    inputs = InputParamList(p1, p2),
                    outputs = OutputParamList(o1),
                    stdout = "rout.txt")
TestFun$a <- 1
TestFun$b <- 2
r1 <- runCWL(TestFun, cwlArgs = "--preserve-entire-environment")
```

```
## }[1;30mINFO[0m Final process status is success
```

```
readLines(r1$output)
```

```
## [1] "6"
```

The `runCWL` function wrote the `testFun` function and its
dependencies into an R script file automatically and call `Rscript` to
run the script with parameters. Each parameter requires a prefix from
corresponding argument in the R function with “=” and without a
separator. Here we assigned the R function and its dependencies into
the global environment because it will start a new environment when
the vignette is compiled.

# 9 Resources

## 9.1 RcwlPipelines

The `Rcwl` package can be utilized to develop pipelines for best
practices of reproducible research, especially for Bioinformatics
study. Multiple Bioinformatics pipelines, such as RNA-seq alignment,
quality control and quantification, DNA-seq alignment and variant
calling, have been developed based on the tool in an R package
`RcwlPipelines`, which contains the CWL recipes and the scripts to
create the pipelines. Examples to analyze real data are also included.

The package is currently available in GitHub.

* <https://github.com/rworkflow/RcwlPipelines>

To install the package.

```
BiocManager::install("rworkflow/RcwlPipelines")
```

The project website <https://rcwl.org/> serves as a central hub for all
related resources. It provides guidance for new users and tutorials
for both users and developers. Specific resources are listed below.

## 9.2 Tutorial book

The [tutorial book](https://rcwl.org/RcwlBook/) provides detailed
instructions for developing `Rcwl` tools/pipelines, and also includes
examples of some commonly-used tools and pipelines that covers a wide
range of Bioinformatics data analysis needs.

## 9.3 The *R* recipes and cwl scripts

The *R* scripts to build the CWL tools and pipelines are now residing
in a dedicated [GitHub
repository](https://github.com/rworkflow/RcwlRecipes), which is
intended to be a community effort to collect and contribute
Bioinformatics tools and pipelines using `Rcwl` and CWL.

## 9.4 Tool collections in CWL format

Plenty of Bioinformatics tools and workflows can be found from GitHub
in CWL format. They can be imported to `cwlProcess` object by
`readCWL` function, or can be used directly.

* <https://github.com/common-workflow-library/bio-cwl-tools>
* <https://github.com/Duke-GCB/GGR-cwl>
* <https://github.com/pitagora-network/pitagora-cwl>

## 9.5 Docker for Bioinformatics tools

Most of the Bioinformatics software are available in docker
containers, which can be very convenient to be adopted to build
portable CWL tools and pipelines.

* <https://dockstore.org>
* <https://biocontainers.pro>

# 10 SessionInfo

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] Rcwl_1.26.0         S4Vectors_0.48.0    BiocGenerics_0.56.0
## [4] generics_0.1.4      yaml_2.3.10         BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] dir.expiry_1.18.0   xfun_0.53           bslib_0.9.0
##  [4] htmlwidgets_1.6.4   visNetwork_2.1.4    lattice_0.22-7
##  [7] batchtools_0.9.18   vctrs_0.6.5         tools_4.5.1
## [10] base64url_1.4       parallel_4.5.1      tibble_3.3.0
## [13] pkgconfig_2.0.3     R.oo_1.27.1         Matrix_1.7-4
## [16] data.table_1.17.8   checkmate_2.3.3     RColorBrewer_1.1-3
## [19] lifecycle_1.0.4     compiler_4.5.1      stringr_1.5.2
## [22] progress_1.2.3      codetools_0.2-20    httpuv_1.6.16
## [25] htmltools_0.5.8.1   sass_0.4.10         later_1.4.4
## [28] pillar_1.11.1       crayon_1.5.3        jquerylib_0.1.4
## [31] R.utils_2.13.0      BiocParallel_1.44.0 cachem_1.1.0
## [34] mime_0.13           basilisk_1.22.0     brew_1.0-10
## [37] tidyselect_1.2.1    digest_0.6.37       stringi_1.8.7
## [40] purrr_1.1.0         dplyr_1.1.4         bookdown_0.45
## [43] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
## [46] magrittr_2.0.4      DiagrammeR_1.0.11   withr_3.0.2
## [49] prettyunits_1.2.0   filelock_1.0.3      promises_1.4.0
## [52] backports_1.5.0     rappdirs_0.3.3      rmarkdown_2.30
## [55] igraph_2.2.1        otel_0.2.0          reticulate_1.44.0
## [58] png_0.1-8           R.methodsS3_1.8.2   hms_1.1.4
## [61] shiny_1.11.1        evaluate_1.0.5      knitr_1.50
## [64] rlang_1.1.6         Rcpp_1.1.0          xtable_1.8-4
## [67] glue_1.8.0          BiocManager_1.30.26 rstudioapi_0.17.1
## [70] debugme_1.2.0       jsonlite_2.0.0      R6_2.6.1
```