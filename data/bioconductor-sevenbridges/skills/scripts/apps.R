# Code example from 'apps' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(comment = "")

## -----------------------------------------------------------------------------
library("sevenbridges")
t1 <- system.file("extdata/app", "tool_star.json", package = "sevenbridges")
# # convert JSON file into a Tool object
t1 <- convert_app(t1)
# # try print it out
# t1

## -----------------------------------------------------------------------------
# get input type information
head(t1$input_type())
# get output type information
head(t1$output_type())
# return a input matrix with more information
head(t1$input_matrix())
# return only a few fields
head(t1$input_matrix(c("id", "type", "required")))
# return only required
t1$input_matrix(required = TRUE)
# return a output matrix with more information
t1$output_matrix()
# return only a few fields
t1$output_matrix(c("id", "type"))
# get required input id
t1$get_required()
# set new required input with ID, # or without #
t1$set_required(c("#reads", "winFlankNbins"))
t1$get_required()
# turn off requirements for input node #reads
t1$set_required("reads", FALSE)
t1$get_required()
# get input id
head(t1$input_id())
# get full input id with Tool name
head(t1$input_id(TRUE))
# get output id
head(t1$output_id())
# get full output id
head(t1$output_id(TRUE))
# get input and output object
t1$get_input(id = "#winFlankNbins")
t1$get_input(name = "ins")
t1$get_output(id = "#aligned_reads")
t1$get_output(name = "gene")

## ----eval = TRUE, comment=''--------------------------------------------------
fl <- system.file("docker/rnaseqGene/rabix", "generator.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")

## -----------------------------------------------------------------------------
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
rbx$toJSON()

## -----------------------------------------------------------------------------
rbx$toJSON()
rbx$toJSON(pretty = TRUE)
rbx$toYAML()

## -----------------------------------------------------------------------------
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

## -----------------------------------------------------------------------------
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

## -----------------------------------------------------------------------------
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

## -----------------------------------------------------------------------------
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

## ----eval = TRUE, comment = ""------------------------------------------------
fl <- system.file("docker/sevenbridges/src", "runif2spin.R",
  package = "sevenbridges"
)
cat(readLines(fl), sep = "\n")

## -----------------------------------------------------------------------------
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

## ----eval = TRUE, comment=''--------------------------------------------------
fl <- system.file("docker/sevenbridges/src", "runif_args.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")

## -----------------------------------------------------------------------------
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

## ----eval = TRUE, comment=''--------------------------------------------------
fl <- system.file("docker/sevenbridges/src", "runif_args.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")

## -----------------------------------------------------------------------------
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

## -----------------------------------------------------------------------------
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

## ----eval = TRUE, comment=''--------------------------------------------------
fl <- system.file("docker/rnaseqGene/rabix", "generator.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")

## ----results = 'hide'---------------------------------------------------------
f1 <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
f1 <- convert_app(f1)
f1$set_batch("sjdbGTFfile", type = "ITEM")

## ----results = 'hide'---------------------------------------------------------
f1 <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
f1 <- convert_app(f1)
f1$set_batch("sjdbGTFfile", c("metadata.sample_id", "metadata.library_id"))

## -----------------------------------------------------------------------------
f1 <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
f1 <- convert_app(f1)
# show it
# f1

## -----------------------------------------------------------------------------
f1 <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
f1 <- convert_app(f1)
# input matrix
head(f1$input_matrix())
# by name
head(f1$input_matrix(c("id", "type", "required")))
# return only required
head(f1$input_matrix(required = TRUE))
# return everything
head(f1$input_matrix(NULL))
# return a output matrix with more information
head(f1$output_matrix())
# return only a few fields
head(f1$output_matrix(c("id", "type")))
# return everything
head(f1$output_matrix(NULL))
# flow inputs
f1$input_type()
# flow outouts
f1$output_type()
# list tools
f1$list_tool()
# f1$get_tool("STAR")

## -----------------------------------------------------------------------------
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
f <- link(t1, t2, "#random", "#number")

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

## ----eval = FALSE-------------------------------------------------------------
# # auto-check tool info and push new tools
# p$app_add("new_flow_log", f)

## -----------------------------------------------------------------------------
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
# link
f1 <- link(t1, t2, "output_fastq_files", "reads")
# link
t1$output_id(TRUE)
t2$input_id(TRUE)
f2 <- link(t1, t2, "output_fastq_files", "reads",
  flow_input = "#SBG_Unpack_FASTQs.input_archive_file",
  flow_output = "#STAR.log_files"
)

# clipr::write_clip(jsonlite::toJSON(f2))

## -----------------------------------------------------------------------------
tool.in <- system.file("extdata/app", "tool_unpack_fastq.json", package = "sevenbridges")
flow.in <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")

t1 <- convert_app(tool.in)
f2 <- convert_app(flow.in)
# consulting link_what first
f2$link_map()
# then link

f3 <- link(t1, f2, c("output_fastq_files"), c("#SBG_FASTQ_Quality_Detector.fastq"))

link_what(f2, t1)
f4 <- link(f2, t1, c("#Picard_SortSam.sorted_bam", "#SBG_FASTQ_Quality_Detector.result"), c("#input_archive_file", "#input_archive_file"))

# # TODO
# # all outputs
# # flow + flow
# # print message when name wrong
# clipr::write_clip(jsonlite::toJSON(f4))

## -----------------------------------------------------------------------------


## ----eval = FALSE-------------------------------------------------------------
# a <- Auth(platform = "platform_name", token = "your_token")
# p <- a$project("demo")
# app.runif <- p$app_add("runif555", rbx)
# aid <- app.runif$id
# tsk <- p$task_add(
#   name = "Draft runif simple",
#   description = "Description for runif",
#   app = aid,
#   inputs = list(min = 1, max = 10)
# )
# tsk$run()

## ----eval = FALSE-------------------------------------------------------------
# library("sevenbridges")
# 
# in.df <- data.frame(
#   id = c("number", "min", "max", "seed"),
#   description = c(
#     "number of observation",
#     "lower limits of the distribution",
#     "upper limits of the distribution",
#     "seed with set.seed"
#   ),
#   type = c("integer", "float", "float", "float"),
#   label = c("number", "min", "max", "seed"),
#   prefix = c("--n", "--min", "--max", "--seed"),
#   default = c(1, 0, 10, 123),
#   required = c(TRUE, FALSE, FALSE, FALSE)
# )
# out.df <- data.frame(
#   id = c("random", "report"),
#   type = c("file", "file"),
#   glob = c("*.txt", "*.html")
# )
# rbx <- Tool(
#   id = "runif",
#   label = "Random number generator",
#   hints = requirements(docker(pull = "RFranklin/runif"), cpu(1), mem(2000)),
#   baseCommand = "runif.R",
#   inputs = in.df, # or ins.df
#   outputs = out.df
# )
# params <- list(number = 3, max = 5)
# 
# set_test_env("RFranklin/testenv", "mount_dir")
# test_tool(rbx, params)

