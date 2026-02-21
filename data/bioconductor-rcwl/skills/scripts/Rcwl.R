# Code example from 'Rcwl' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_knit$set(root.dir = tempdir())

## ----getPackage, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("Rcwl")

## ----getDevel, eval=FALSE-----------------------------------------------------
# BiocManager::install("rworkflow/Rcwl")

## ----Load, message=FALSE------------------------------------------------------
library(Rcwl)

## -----------------------------------------------------------------------------
input1 <- InputParam(id = "sth")

## -----------------------------------------------------------------------------
echo <- cwlProcess(baseCommand = "echo", inputs = InputParamList(input1))

## -----------------------------------------------------------------------------
echo
class(echo)
cwlClass(echo)
cwlVersion(echo)
baseCommand(echo)
inputs(echo)
outputs(echo)

## -----------------------------------------------------------------------------
echo$sth <- "Hello World!"
inputs(echo)

## -----------------------------------------------------------------------------
invisible(install_cwltool())

## -----------------------------------------------------------------------------
r1 <- runCWL(echo, outdir = tempdir())
r1
r1$command
readLines(r1$output)
r1$logs

## -----------------------------------------------------------------------------
r1 <- runCWL(echo, outdir = tempdir(), showLog = TRUE)

## -----------------------------------------------------------------------------
writeCWL(echo)

## -----------------------------------------------------------------------------
e1 <- InputParam(id = "flag", type = "boolean", prefix = "-f")
e2 <- InputParam(id = "string", type = "string", prefix = "-s")
e3 <- InputParam(id = "int", type = "int", prefix = "-i")
e4 <- InputParam(id = "file", type = "File", prefix = "--file=", separate = FALSE)
echoA <- cwlProcess(baseCommand = "echo",
                  inputs = InputParamList(e1, e2, e3, e4),
                  stdout = "output.txt")

## -----------------------------------------------------------------------------
echoA$flag <- TRUE
echoA$string <- "Hello"
echoA$int <- 1

tmpfile <- tempfile()
write("World", tmpfile)
echoA$file <- tmpfile

r2 <- runCWL(echoA, outdir = tempdir())
r2$command

## -----------------------------------------------------------------------------
a1 <- InputParam(id = "A", type = "string[]", prefix = "-A")
a2 <- InputParam(id = "B",
                 type = InputArrayParam(items = "string",
                                        prefix="-B=", separate = FALSE))
a3 <- InputParam(id = "C", type = "string[]", prefix = "-C=",
                 itemSeparator = ",", separate = FALSE)
echoB <- cwlProcess(baseCommand = "echo",
                 inputs = InputParamList(a1, a2, a3))

## -----------------------------------------------------------------------------
echoB$A <- letters[1:3]
echoB$B <- letters[4:6]
echoB$C <- letters[7:9]
echoB

## -----------------------------------------------------------------------------
r3 <- runCWL(echoB, outdir = tempdir())
r3$command

## -----------------------------------------------------------------------------
zzfil <- file.path(tempdir(), "sample.R.gz")
zz <- gzfile(zzfil, "w")
cat("sample(1:10, 5)", file = zz, sep = "\n")
close(zz)

## -----------------------------------------------------------------------------
ofile <- "sample.R"
z1 <- InputParam(id = "uncomp", type = "boolean", prefix = "-d")
z2 <- InputParam(id = "out", type = "boolean", prefix = "-c")
z3 <- InputParam(id = "zfile", type = "File")
o1 <- OutputParam(id = "rfile", type = "File", glob = ofile)
gz <- cwlProcess(baseCommand = "gzip",
               inputs = InputParamList(z1, z2, z3),
               outputs = OutputParamList(o1),
               stdout = ofile)

## -----------------------------------------------------------------------------
gz$uncomp <- TRUE
gz$out <- TRUE
gz$zfile <- zzfil
r4 <- runCWL(gz, outdir = tempdir())
r4$output

## -----------------------------------------------------------------------------
z1 <- InputParam(id = "zfile", type = "File")
o1 <- OutputParam(id = "rfile", type = "File", glob = ofile)
Gz <- cwlProcess(baseCommand = "gzip",
               arguments = list("-d", "-c"),
               inputs = InputParamList(z1),
               outputs = OutputParamList(o1),
               stdout = ofile)
Gz
Gz$zfile <- zzfil
r4a <- runCWL(Gz, outdir = tempdir())

## -----------------------------------------------------------------------------
pfile <- "$(inputs.zfile.path.split('/').slice(-1)[0].split('.').slice(0,-1).join('.'))"

## -----------------------------------------------------------------------------
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

## -----------------------------------------------------------------------------
a <- InputParam(id = "a", type = InputArrayParam(items = "string"))
b <- OutputParam(id = "b", type = OutputArrayParam(items = "File"),
                 glob = "*.txt")
touch <- cwlProcess(baseCommand = "touch", inputs = InputParamList(a),
                    outputs = OutputParamList(b))
touch$a <- c("a.txt", "b.log", "c.txt")
r5 <- runCWL(touch, outdir = tempdir())
r5$output

## -----------------------------------------------------------------------------
d1 <- InputParam(id = "rfile", type = "File")
req1 <- requireDocker("r-base")
doc <- cwlProcess(baseCommand = "Rscript",
                inputs = InputParamList(d1),
                stdout = "output.txt",
                hints = list(req1))
doc$rfile <- r4$output

## ----eval=FALSE---------------------------------------------------------------
# r6 <- runCWL(doc)

## -----------------------------------------------------------------------------
r6a <- runCWL(doc, docker = FALSE, outdir = tempdir(),
              cwlArgs = "--preserve-entire-environment")

## ----eval=FALSE---------------------------------------------------------------
# library(BiocParallel)
# sth.list <- as.list(LETTERS)
# names(sth.list) <- LETTERS
# 
# ## submit with multicore
# result1 <- runCWLBatch(cwl = echo, outdir = tempdir(), inputList = list(sth = sth.list),
#                        BPPARAM = MulticoreParam(26))
# 
# ## submit with SGE
# result2 <- runCWLBatch(cwl = echo, outdir = tempdir(), inputList = list(sth = sth.list),
#                        BPPARAM = BatchtoolsParam(workers = 26, cluster = "sge",
#                                                  resources = list(queue = "all.q")))

## -----------------------------------------------------------------------------
d1 <- InputParam(id = "rfile", type = "File")
Rs <- cwlProcess(baseCommand = "Rscript",
               inputs = InputParamList(d1))
Rs

## -----------------------------------------------------------------------------
Rs$rfile <- r4$output
tres <- runCWL(Rs, outdir = tempdir())
readLines(tres$output)

## -----------------------------------------------------------------------------
i1 <- InputParam(id = "cwl_zfile", type = "File")
s1 <- cwlStep(id = "Uncomp", run = GZ,
              In = list(zfile = "cwl_zfile"))
s2 <- cwlStep(id = "Compile", run = Rs,
              In = list(rfile = "Uncomp/rfile"))

## -----------------------------------------------------------------------------
o1 <- OutputParam(id = "cwl_cout", type = "File",
                  outputSource = "Compile/output")

## -----------------------------------------------------------------------------
cwl <- cwlWorkflow(inputs = InputParamList(i1),
                    outputs = OutputParamList(o1))
cwl <- cwl + s1 + s2
cwl

## -----------------------------------------------------------------------------
cwl$cwl_zfile <- zzfil
r7 <- runCWL(cwl, outdir = tempdir())
readLines(r7$output)

## -----------------------------------------------------------------------------
arguments(cwl, step = "Uncomp") <- list("-d", "-c", "-f")
runs(cwl)$Uncomp

## -----------------------------------------------------------------------------
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

## -----------------------------------------------------------------------------
cwl2$cwl_rfiles <- c(r4b$output, r4b$output)
r8 <- runCWL(cwl2, outdir = tempdir())
r8$output

## -----------------------------------------------------------------------------
plotCWL(cwl)

## -----------------------------------------------------------------------------
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

## ----eval=FALSE---------------------------------------------------------------
# inputList <- list(option = c("option1", "option2"))
# app <- cwlShiny(mulEcho, inputList, upload = TRUE)
# runApp(app)

## -----------------------------------------------------------------------------
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
readLines(r1$output)

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("rworkflow/RcwlPipelines")

## -----------------------------------------------------------------------------
sessionInfo()

