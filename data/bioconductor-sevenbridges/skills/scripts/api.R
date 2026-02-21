# Code example from 'api' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(eval = FALSE)

## -----------------------------------------------------------------------------
# library("sevenbridges")
# a <- Auth(token = "your_token", platform = "aws-us")
# a$api(path = "projects", method = "GET")

## -----------------------------------------------------------------------------
# a$project()

## -----------------------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("sevenbridges")

## -----------------------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("sevenbridges", version = "devel")

## -----------------------------------------------------------------------------
# install.packages("devtools")

## -----------------------------------------------------------------------------
# install.packages("BiocManager")
# install.packages("readr")
# 
# devtools::install_github(
#   "sbg/sevenbridges-r",
#   repos = BiocManager::repositories(),
#   build_vignettes = TRUE, dependencies = TRUE
# )

## ----eval = TRUE, message = FALSE---------------------------------------------
library("sevenbridges")

## -----------------------------------------------------------------------------
# (a <- Auth(platform = "cgc", token = "your_token"))

## -----------------------------------------------------------------------------
# sbg_set_env("https://cgc-api.sbgenomics.com/v2", "your_token")

## -----------------------------------------------------------------------------
# a <- Auth(from = "env")

## -----------------------------------------------------------------------------
# a <- Auth(from = "file", profile_name = "aws-us-rfranklin")

## -----------------------------------------------------------------------------
# a <- Auth(from = "file")

## -----------------------------------------------------------------------------
# a$user()

## -----------------------------------------------------------------------------
# a$user(username = "RFranklin")

## -----------------------------------------------------------------------------
# a$rate_limit()

## -----------------------------------------------------------------------------
# # check your billing info
# a$billing()
# a$invoice()

## -----------------------------------------------------------------------------
# a$billing(id = "your_billing_id", breakdown = TRUE)

## -----------------------------------------------------------------------------
# # get billing group id
# bid <- a$billing()$id
# # create new project
# (p <- a$project_new(name = "api testing", bid, description = "Just a test"))

## -----------------------------------------------------------------------------
# # list first 100
# a$project()
# # list all
# a$project(complete = TRUE)
# # return all named match "demo"
# a$project(name = "demo", complete = TRUE)
# # get the project you want by id
# p <- a$project(id = "RFranklin/api-tutorial")

## -----------------------------------------------------------------------------
# # search by name matching, complete = TRUE search all apps,
# # not limited by offset or limit.
# a$public_app(name = "STAR", complete = TRUE)
# # search by id is accurate
# a$public_app(id = "admin/sbg-public-data/rna-seq-alignment-star/5")
# # you can also get everything
# a$public_app(complete = TRUE)
# # default limit = 100, offset = 0 which means the first 100
# a$public_app()

## -----------------------------------------------------------------------------
# # copy
# a$copy_app(
#   id = "admin/sbg-public-data/rna-seq-alignment-star/5",
#   project = "RFranklin/api-testing", name = "new copy of star"
# )
# # check if it is copied
# p <- a$project(id = "RFranklin/api-testing")
# # list apps your got in your project
# p$app()

## -----------------------------------------------------------------------------
# app <- a$public_app(id = "admin/sbg-public-data/rna-seq-alignment-star")
# app$copy_to(
#   project = "RFranklin/api-testing",
#   name = "copy of star"
# )

## -----------------------------------------------------------------------------
# # add an CWL file to your project
# f.star <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
# app <- p$app_add("starlocal", fl.runif)
# (aid <- app$id)

## ----comment = "", eval = TRUE------------------------------------------------
fl <- system.file("docker", "sevenbridges/rabix/generator.R",
  package = "sevenbridges"
)
cat(readLines(fl), sep = "\n")

## -----------------------------------------------------------------------------
# # rbx is the object returned by `Tool` function
# app <- p$app_add("runif", rbx)
# (aid <- app$id)

## -----------------------------------------------------------------------------
# app <- a$app(id = "RFranklin/api-testing-2/newcopyofstar")
# # get input matrix
# app$input_matrix()
# app$input_matrix(c("id", "label", "type"))
# # get required node only
# app$input_matrix(c("id", "label", "type"), required = TRUE)

## ----eval = TRUE--------------------------------------------------------------
f1 <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
app <- convert_app(f1)
# get input matrix
app$input_matrix()
app$input_matrix(c("id", "label", "type"))
app$input_matrix(c("id", "label", "type"), required = TRUE)

## -----------------------------------------------------------------------------
# tool.in <- system.file("extdata/app", "tool_unpack_fastq.json", package = "sevenbridges")
# flow.in <- system.file("extdata/app", "flow_star.json", package = "sevenbridges")
# input_matrix(tool.in)
# input_matrix(tool.in, required = TRUE)
# input_matrix(flow.in)
# input_matrix(flow.in, c("id", "type"))
# input_matrix(flow.in, required = TRUE)
# output_matrix(tool.in)
# output_matrix(flow.in)

## -----------------------------------------------------------------------------
# fastqs <- c("SRR1039508_1.fastq", "SRR1039508_2.fastq")
# 
# # get all 2 exact files
# fastq_in <- p$file(name = fastqs, exact = TRUE)
# 
# # get a single file
# fasta_in <- p$file(
#   name = "Homo_sapiens.GRCh38.dna.primary_assembly.fa",
#   exact = TRUE
# )
# # get all single file
# gtf_in <- p$file(
#   name = "Homo_sapiens.GRCh38.84.gtf",
#   exact = TRUE
# )

## -----------------------------------------------------------------------------
# # add new tasks
# taskName <- paste0("RFranklin-star-alignment ", date())
# 
# tsk <- p$task_add(
#   name = taskName,
#   description = "star test",
#   app = "RFranklin/api-testing-2/newcopyofstar/0",
#   inputs = list(
#     sjdbGTFfile = gtf_in,
#     fastq = fastq_in,
#     genomeFastaFiles = fasta_in
#   )
# )

## -----------------------------------------------------------------------------
# f1 <- p$file(name = "SRR1039508_1.fastq", exact = TRUE)
# f2 <- p$file(name = "SRR1039508_2.fastq", exact = TRUE)
# # get all 2 exact files
# fastq_in <- list(f1, f2)
# 
# # or if you know you only have 2 files whose names match SRR924146*.fastq
# fastq_in <- p$file(name = "SRR1039508*.fastq", complete = TRUE)

## -----------------------------------------------------------------------------
# fastqs <- c(
#   "SRR1039508_1.fastq", "SRR1039508_2.fastq", "SRR1039509_1.fastq",
#   "SRR1039509_2.fastq", "SRR1039512_1.fastq", "SRR1039512_2.fastq",
#   "SRR1039513_1.fastq", "SRR1039513_2.fastq"
# )
# 
# # get all 8 files
# fastq_in <- p$file(name = fastqs, exact = TRUE)
# # can also try to returned all SRR*.fastq files
# # fastq_in <- p$file(name= "SRR*.fastq", complete = TRUE)
# 
# tsk <- p$task_add(
#   name = taskName,
#   description = "Batch Star Test",
#   app = "RFranklin/api-testing-2/newcopyofstar/0",
#   batch = batch(
#     input = "fastq",
#     criteria = c("metadata.sample_id", "metadata.noexist_id")
#   ),
#   inputs = list(
#     sjdbGTFfile = gtf_in,
#     fastq = fastqs_in,
#     genomeFastaFiles = fasta_in
#   )
# )

## -----------------------------------------------------------------------------
# # run your task
# tsk$run()

## -----------------------------------------------------------------------------
# # # not run
# # tsk$delete()

## -----------------------------------------------------------------------------
# # abort your task
# tsk$abort()

## -----------------------------------------------------------------------------
# tsk$getInputs()
# # missing number input, only update number
# tsk$update(inputs = list(sjdbGTFfile = "some new file"))
# # double check
# tsk$getInputs()

## -----------------------------------------------------------------------------
# p <- a$project_new(
#   name = "spot-disabled-project", bid, description = "spot disabled project",
#   use_interruptible = FALSE
# )

## -----------------------------------------------------------------------------
# tsk <- p$task_add(
#   name = paste0("spot enabled task in a spot disabled project"),
#   description = "spot enabled task",
#   app = ...,
#   inputs = list(...),
#   use_interruptible_instances = TRUE
# )

## -----------------------------------------------------------------------------
# tsk <- p$task_add(
#   ...,
#   execution_settings = list(
#     instance_type = "c4.2xlarge;ebs-gp2;2000",
#     max_parallel_instances = 2
#   )
# )

## -----------------------------------------------------------------------------
# tsk$update()

## -----------------------------------------------------------------------------
# # Monitor your task (skip this part)
# # tsk$monitor()

## -----------------------------------------------------------------------------
# tsk$download("~/Downloads")

## ----eval = TRUE--------------------------------------------------------------
getTaskHook("completed")

## -----------------------------------------------------------------------------
# setTaskHook("completed", function() {
#   tsk$download("~/Downloads")
#   return(TRUE)
# })
# tsk$monitor()

## -----------------------------------------------------------------------------
# a <- Auth(
#   token = "your_token",
#   platform = "aws-us"
# )

## -----------------------------------------------------------------------------
# a <- Auth(
#   token = "your_token",
#   url = "https://gcp-api.sbgenomics.com/v2"
# )

## -----------------------------------------------------------------------------
# a <- Auth(token = "your_token")

## -----------------------------------------------------------------------------
# sbg_set_env(
#   url = "https://cgc-api.sbgenomics.com/v2",
#   token = "your_token"
# )

## -----------------------------------------------------------------------------
# sbg_get_env("SB_API_ENDPOINT")
# ## "https://cgc-api.sbgenomics.com/v2"
# sbg_get_env("SB_AUTH_TOKEN")
# ## "your_token"

## -----------------------------------------------------------------------------
# a <- Auth(from = "env")

## -----------------------------------------------------------------------------
# Sys.unsetenv("SB_API_ENDPOINT")
# Sys.unsetenv("SB_AUTH_TOKEN")

## -----------------------------------------------------------------------------
# a <- Auth(from = "file")

## -----------------------------------------------------------------------------
# a <- Auth(from = "file", profile_name = "aws-us-rfranklin")

## -----------------------------------------------------------------------------
# a <- Auth(
#   from = "file", config_file = "~/sevenbridges.cfg",
#   profile_name = "aws-us-rfranklin"
# )

## -----------------------------------------------------------------------------
# a$api()

## -----------------------------------------------------------------------------
# getOption("sevenbridges")$offset
# getOption("sevenbridges")$limit

## -----------------------------------------------------------------------------
# # first, search by id is fast
# x <- a$app(visibility = "public", id = "admin/sbg-public-data/sbg-ucsc-b37-bed-converter/1")
# 
# # show 100 items from public
# x <- a$app(visibility = "public")
# length(x) # 100
# 
# x <- a$app(visibility = "public", complete = TRUE)
# length(x) # 272 by Nov 2016
# # this return nothing, because it is not in the first 100 returned names
# a$app(visibility = "public", name = "bed converter")
# # this return an app, because it pulls *all* app names and did search
# a$app(visibility = "public", name = "bed converter", complete = TRUE)

## -----------------------------------------------------------------------------
# library("sevenbridges")
# getOption("sevenbridges")$advance_access

## -----------------------------------------------------------------------------
# req <- api(
#   token = "your_token", path = "genome/markers?file={bam_file_id}",
#   method = "GET"
# )
# 
# httr::content(req)$"message"

## -----------------------------------------------------------------------------
# opt <- getOption("sevenbridges")
# opt$advance_access <- TRUE
# options(sevenbridges = opt)

## -----------------------------------------------------------------------------
# getOption("sevenbridges")$advance_access

## -----------------------------------------------------------------------------
# req <- api(
#   token = "your_token", path = "genome/markers?file={bam_file_id}",
#   method = "GET"
# )

## -----------------------------------------------------------------------------
# httr::content(req)

## -----------------------------------------------------------------------------
# ## default fields id, name, project
# p$file()
# ## return file(s) with id, name, siae information
# p$file(fields = "id,name,size")
# ## return file(s) with all available info
# p$file(detail = TRUE)
# ## same as above
# p$file(fields = "_all")

## -----------------------------------------------------------------------------
# a$rate_limit()

## -----------------------------------------------------------------------------
# # return your information
# a$user()
# # return user RFranklin's information
# a$user("RFranklin")

## -----------------------------------------------------------------------------
# # return a BillingList object
# (b <- a$billing())
# a$billing(id = b$id, breakdown = TRUE)

## -----------------------------------------------------------------------------
# a$invoice()
# a$invoice(id = "your_id")

## -----------------------------------------------------------------------------
# a$project()

## -----------------------------------------------------------------------------
# a$project(owner = "RFranklin")
# a$project(owner = "Rosalind.Franklin")

## -----------------------------------------------------------------------------
# a$project(detail = TRUE)

## -----------------------------------------------------------------------------
# # want to return a project called
# a$project("hello")

## -----------------------------------------------------------------------------
# # return all projects matching the name "wgs"
# p <- a$project("wgs", complete = TRUE)
# 
# # filter by project creators
# creators <- sapply(p, "[[", "created_by")
# which(creator == "RFranklin")
# 
# # filter by project creation date
# create_date <- as.Date(sapply(p, "[[", "created_on"))
# which(as.Date(create_date) < as.Date("2019-01-01"))
# 
# # filter by project modification date
# modify_date <- as.Date(sapply(p, "[[", "modified_on"))
# which(as.Date(modify_date) < as.Date("2019-01-01"))

## -----------------------------------------------------------------------------
# a$project_new("api_testing_tcga", b$id,
#   description = "Test for API"
# )

## -----------------------------------------------------------------------------
# a$project_new("controlled_project", b$id,
#   description = "Test for API", tags = list("tcga")
# )

## -----------------------------------------------------------------------------
# # remove it, not run
# a$project("api_testing")$delete()
# # check
# # will delete all projects match the name
# delete(a$project("api_testing_donnot_delete_me"))

## -----------------------------------------------------------------------------
# a$project(id = "RFranklin/helloworld")
# a$project(id = "RFranklin/helloworld")$update(
#   name = "Hello World Update",
#   description = "Update description"
# )

## -----------------------------------------------------------------------------
# a$project(id = "RFranklin/demo-project")$member()

## -----------------------------------------------------------------------------
# m <- a$project(id = "RFranklin/demo-project")$
#   member_add(username = "Rosalind.Franklin")

## -----------------------------------------------------------------------------
# m <- a$project(id = "RFranklin/demo-project")$
#   member(username = "Rosalind.Franklin")
# m$update(copy = TRUE)

## -----------------------------------------------------------------------------
# m$delete()
# # confirm
# a$project(id = "RFranklin/demo-project")$member()

## -----------------------------------------------------------------------------
# p <- a$project(id = "RFranklin/demo-project")
# p$file()

## -----------------------------------------------------------------------------
# # first 100 files, default offset = 0, limit = 100
# p$file()
# # list all files
# p$file(complete = TRUE)

## -----------------------------------------------------------------------------
# a$file(project = p$id)
# a$file(name = "omni", project = p$id, detail = TRUE)

## -----------------------------------------------------------------------------
# p <- a$project(id = "RFranklin/demo")
# p$file(
#   metadata = list(
#     sample_id = "Sample1",
#     sample_id = "Sample2",
#     library_id = "EXAMPLE"
#   ),
#   tag = c("hello", "world")
# )

## -----------------------------------------------------------------------------
# # return single object id is "some_file_id"
# p$file(id = "some_file_id")
# # return a single object named a.fastq
# p$file(name = "a.fastq", exact = TRUE)
# # public file search using Auth object
# a$public_file(name = "ucsc.hg19.fasta.fai", exact = TRUE)
# a$public_file(id = "578cf94a507c17681a3117e8")

## -----------------------------------------------------------------------------
# # get two files
# p$file(name = c("test1.fastq", "test2.fastq"), exact = TRUE)
# # get two files from public files using shorthand
# a$public_file(
#   name = c("ucsc.hg19.fasta.fai", "ucsc.hg19.fasta"),
#   exact = TRUE
# )

## -----------------------------------------------------------------------------
# # get matchd the pattern for searching first 100 files
# p$file(name = c("gz", "fastq"))
# # get all matched files from the project
# p$file(name = c("gz", "fastq"), complete = TRUE)
# # get all files matched ucsc
# a$public_file(name = "ucsc.hg19", complete = TRUE)

## -----------------------------------------------------------------------------
# p <- a$project(id = "RFranklin/demo")
# p$file(metadata = list(
#   sample_id = "Sample1",
#   sample_id = "Sample2",
#   library_id = "EXAMPLE"
# ))

## -----------------------------------------------------------------------------
# p <- a$project(id = "RFranklin/demo")
# p$file(tag = c("s1", "s2"))

## -----------------------------------------------------------------------------
# # list all outputs file from a task id
# a$task(id = "53020538-6936-422f-80de-02fa65ae4b39")$file()
# 
# # OR
# p <- a$project(id = "RFranklin/demo")
# p$file(origin.task = "53020538-6936-422f-80de-02fa65ae4b39")

## -----------------------------------------------------------------------------
# # 1000G_omni2.5.b37.vcf
# fid <- "561e1b33e4b0aa6ec48167d7"
# fid2 <- "561e1b33e4b0aa6ec48167d3"
# pid <- a$project("demo")$id
# a$copyFile(c(fid, fid2), project = pid)
# a$project(id = pid)$file()

## -----------------------------------------------------------------------------
# a$project("hello")$file(id = fid)$copyTo(pid)

## -----------------------------------------------------------------------------
# a$project("demo")$file()[[1]]$delete()
# ## confirm the deletion
# a$project("demo")$file()

## -----------------------------------------------------------------------------
# ## return 5 files
# a$project("demo")$file("phase1")
# ## delete all of them
# delete(a$project("demo")$file("phase1"))
# a$project("demo")$file("phase1")

## -----------------------------------------------------------------------------
# a$project("demo")$file()[[1]]$download_url()

## -----------------------------------------------------------------------------
# fid <- a$project("demo")$file()[[1]]$id
# a$project("demo")$file(id = fid3)$download("~/Downloads/")

## -----------------------------------------------------------------------------
# fls <- a$project("demo")$file()
# download(fls, "~/Downloads/")

## -----------------------------------------------------------------------------
# a$project("demo")$download("~/Downloads")

## -----------------------------------------------------------------------------
# a <- Auth(username = "RFranklin", platform = "cgc")
# fl <- system.file("extdata", "sample1.fastq", package = "sevenbridges")
# 
# (p <- a$project(id = "RFranklin/quickstart"))
# 
# # by default load .meta for the file
# p$upload(fl, overwrite = TRUE)
# # pass metadata
# p$upload(fl, overwrite = TRUE, metadata = list(library_id = "testid2", platform = "Illumina x11"))
# # rename
# p$upload(fl,
#   overwrite = TRUE, name = "sample_new_name.fastq",
#   metadata = list(library_id = "new_id")
# )

## -----------------------------------------------------------------------------
# dir.ext <- system.file("extdata", package = "sevenbridges")
# list.files(dir.ext)
# p$upload(dir.ext, overwrite = TRUE)

## -----------------------------------------------------------------------------
# dir.ext <- system.file("extdata", package = "sevenbridges")
# # enable full name
# fls <- list.files(dir.ext, recursive = TRUE, full.names = TRUE)
# p$upload(fls, overwrite = TRUE)
# p$upload("~/Documents/Data/sbgtest/1000G_phase1.snps.high_confidence.b37.vcf")

## -----------------------------------------------------------------------------
# # upload all fiels and all metadata
# p$upload(manifest_file = "~/manifest.csv")
# 
# # verbal = TRUE, print single file level progress
# p$upload(manifest_file = "~/manifest.csv", overwrite = TRUE, verbal = TRUE)
# 
# # manifest_metadata = FALSE doens't attach any metadata
# p$upload(manifest_file = "~/manifest.csv", manifest_metadata = FALSE, overwrite = TRUE)
# 
# # filter files first, upload only files with score < 0.5
# p$upload(manifest_file = "~/manifest.csv", overwrite = TRUE, subset = score < 0.5)
# 
# # attach all meta except "bad_field" and "sample_id"
# p$upload(
#   manifest_file = "~/manifest.csv", overwrite = TRUE,
#   subset = score < 0.5, select = -c(bad_field, sample_id)
# )

## -----------------------------------------------------------------------------
# get_uploader("cgc", "~/Downloads/")

## -----------------------------------------------------------------------------
# cgc_token <- "your_cgc_token"
# cgc_uploader <- "~/Downloads/cgc-uploader/"
# 
# cli_list_projects(
#   token = cgc_token,
#   uploader = cgc_uploader
# )

## -----------------------------------------------------------------------------
# cli_list_tags(
#   token = cgc_token,
#   uploader = cgc_uploader,
#   project = "username/project-name"
# )

## -----------------------------------------------------------------------------
# cli_upload(
#   token = cgc_token,
#   uploader = cgc_uploader,
#   file = "~/example.fastq",
#   project = "username/project-name"
# )

## -----------------------------------------------------------------------------
# (fl <- a$project(id = "RFranklin/demo-project")$file(name = "sample.fastq"))

## -----------------------------------------------------------------------------
# # show metadata
# fl$meta()

## -----------------------------------------------------------------------------
# fl$update(
#   name = "sample.fastq",
#   metadata = list(
#     new_item1 = "item1",
#     new_item2 = "item2",
#     file_extension = "fastq"
#   )
# )
# # check it out
# fl$meta()

## -----------------------------------------------------------------------------
# # meta is pulling the latest information via API
# fl$meta()
# # field metadata saved the previously saved one
# fl$metadata

## -----------------------------------------------------------------------------
# fl$set_meta(new_item3 = "item3")
# fl
# # oops it removed rest of the meta
# fl$set_meta(new_item4 = "item4", overwrite = TRUE)
# fl

## -----------------------------------------------------------------------------
# # check which schema we have
# Metadata()$show(full = TRUE)
# # check details for each, play with it
# platform()
# paired_end()
# quality_scale()

## -----------------------------------------------------------------------------
# Metadata(
#   platform = "Affymetrix SNP Array 6.0",
#   paired_end = 1,
#   quality_scale = "sanger",
#   new_item = "new test"
# )

## -----------------------------------------------------------------------------
# p <- a$project(id = "RFranklin/s3tutorial")
# fl <- p$file("sample.bam", exact = TRUE)
# # show tags for single file
# fl$tag()
# # add new tags
# fl$add_tag("new tag")
# # equavilent to
# fl$set_tag("new tag 2", overwrite = FALSE)
# # set tags to overwrite existing
# x <- list("this", "is", 1234)
# fl$set_tag(x)
# # filter by tags
# p$file(tag = c("1234", "new"))
# p$file(tag = list("1234", "new"))
# p$file(tag = "1234")

## -----------------------------------------------------------------------------
# # work on a group of files
# # add tag "s2" to a group of files named with "Sample2" in it
# fl2 <- p$file("Sample2")
# add_tag(fl2, "s2")
# # add tag "s2" to a group of files named with "Sample1" in it
# fl1 <- p$file("Sample1")
# add_tag(fl1, "s1")
# # filter by tag s1 or s2
# p$file(tag = "s1")
# p$file(tag = "s2")
# # get files tagged with s2 and 1234
# p$file(tag = list("s2", "s1"))

## -----------------------------------------------------------------------------
# p <- a$project(id = "RFranklin/folders-api-testing")

## -----------------------------------------------------------------------------
# p$get_root_folder_id()

## -----------------------------------------------------------------------------
# (root_folder <- p$get_root_folder())

## -----------------------------------------------------------------------------
# folder1 <- root_folder$create_folder("folder1")

## -----------------------------------------------------------------------------
# folder2 <- folder1$create_folder("folder2")

## -----------------------------------------------------------------------------
# file_public <- a$public_file(name = "Homo_sapiens_assembly38.fasta", exact = TRUE)
# file1 <- file_public$copy_to_folder(root_folder$id)

## -----------------------------------------------------------------------------
# file2 <- file_public$copy_to_folder(root_folder$id, "ref_grch38.fasta")

## -----------------------------------------------------------------------------
# file1 <- file1$move_to_folder(folder1$id)

## -----------------------------------------------------------------------------
# (contents_root <- root_folder$list_folder_contents(complete = TRUE))

## -----------------------------------------------------------------------------
# root_folder$list_folder_contents(type = "file", complete = TRUE)
# root_folder$list_folder_contents(type = "folder", complete = TRUE)

## -----------------------------------------------------------------------------
# contents_root[[1]]$typeof()

## -----------------------------------------------------------------------------
# sapply(contents_root, function(x) x$typeof())

## -----------------------------------------------------------------------------
# contents_root[[1]]$get_parent_folder_id()

## -----------------------------------------------------------------------------
# contents_root[[1]]$get_parent_folder()

## -----------------------------------------------------------------------------
# file1$delete()

## -----------------------------------------------------------------------------
# file2 <- file2$move_to_folder(folder2$id)
# folder2$delete()

## -----------------------------------------------------------------------------
# file2$delete()
# folder2$delete()
# folder1$delete()

## -----------------------------------------------------------------------------
# a$app()
# # or show details
# a$app(detail = TRUE)

## -----------------------------------------------------------------------------
# # pattern match
# a$app(name = "STAR")
# # unique id
# aid <- a$app()[[1]]$id
# aid
# a$app(id = aid)
# # get a specific revision from an app
# a$app(id = aid, revision = 0)

## -----------------------------------------------------------------------------
# # my favorite, always
# a$project("demo")$app()
# 
# # or alternatviely
# pid <- a$project("demo")$id
# a$app(project = pid)

## -----------------------------------------------------------------------------
# # show 100 items from public
# x <- a$app(visibility = "public")
# length(x)
# x <- a$app(visibility = "public", complete = TRUE)
# length(x)
# x <- a$app(project = "RFranklin/helloworld", complete = TRUE)
# length(x)
# a$app(visibility = "public", limit = 5, offset = 150)

## -----------------------------------------------------------------------------
# a$app("STAR", visibility = "public", complete = TRUE)

## -----------------------------------------------------------------------------
# aid <- a$public_app()[[1]]$id
# a$copy_app(aid, project = pid, name = "copy-rename-test")
# # check if it is copied
# a$app(project = pid)

## -----------------------------------------------------------------------------
# app <- a$public_app(id = "admin/sbg-public-data/rna-seq-alignment-star")
# app$copy_to(
#   project = "RFranklin/api-testing",
#   name = "copy of star"
# )

## -----------------------------------------------------------------------------
# ap <- a$app(visibility = "public")[[1]]
# a$project("demo")$app("index")
# # get a specific revision
# a$project("demo")$app("index", revision = 0)

## -----------------------------------------------------------------------------
# cwl.fl <- system.file("extdata", "bam_index.json", package = "sevenbridges")
# a$project("demo")$app_add(short_name = "new_bam_index_app", filename = cwl.fl)
# a$project("demo")$app_add(short_name = "new_bam_index_app", revision = 2, filename = cwl.fl)

## -----------------------------------------------------------------------------
# rbx <- Tool(
#   id = "runif",
#   label = "Random number generator",
#   hints = requirements(
#     docker(pull = "RFranklin/runif"),
#     cpu(1), mem(2000)
#   ),
#   baseCommand = "runif.R",
#   inputs = in.lst,
#   outputs = out.lst,
#   "sbg:job" = list(
#     allocatedResources = list(mem = 9000, cpu = 1),
#     inputs = list(min = 1, max = 150)
#   )
# )
# p$app_add("random", rbx)

## -----------------------------------------------------------------------------
# rbx <- Tool(
#   id = "runif",
#   label = "Random number generator",
#   hints = requirements(
#     docker(pull = "RFranklin/runif"),
#     cpu(1), mem(2000)
#   ),
#   baseCommand = "runif.R",
#   inputs = in.lst,
#   outputs = out.lst
# )
# p$app_add("random", rbx, keep_test = TRUE)

## -----------------------------------------------------------------------------
# # all tasks
# a$task()
# # filter
# a$task(status = "completed")
# a$task(status = "running")

## -----------------------------------------------------------------------------
# # a better way
# a$project("demo")$task()
# 
# # alternatively
# pid <- a$project("demo")$id
# a$task(project = pid)

## -----------------------------------------------------------------------------
# p$task(id = "your task id here", detail = TRUE)
# p$task(detail = TRUE)

## -----------------------------------------------------------------------------
# p <- a$project(id = "RFranklin/demo")
# p$task(id = "2e1ebed1-c53e-4373-870d-4732acacbbbb")
# p$task(parent = "2e1ebed1-c53e-4373-870d-4732acacbbbb")
# p$task(parent = "2e1ebed1-c53e-4373-870d-4732acacbbbb", status = "completed")
# p$task(parent = "2e1ebed1-c53e-4373-870d-4732acacbbbb", status = "draft")

## -----------------------------------------------------------------------------
# # push an app first
# fl.runif <- system.file("extdata", "runif.json", package = "sevenbridges")
# a$project("demo")$app_add("runif_draft", fl.runif)
# runif_id <- "RFranklin/demo-project/runif_draft"
# # create a draft task
# a$project("demo")$task_add(
#   name = "Draft runif 3",
#   description = "Description for runif 3",
#   app = runif_id,
#   inputs = list(min = 1, max = 10)
# )
# # confirm
# a$project("demo")$task(status = "draft")

## -----------------------------------------------------------------------------
# # get the single task you want to update
# tsk <- a$project("demo")$task("Draft runif 3")
# tsk
# tsk$update(
#   name = "Draft runif update",
#   description = "draft 2",
#   inputs = list(max = 100)
# )
# # alternative way to check all inputs
# tsk$getInputs()

## -----------------------------------------------------------------------------
# tsk$run()
# # run update without information just return latest information
# tsk$update()

## -----------------------------------------------------------------------------
# tsk$monitor()

## -----------------------------------------------------------------------------
# getTaskHook("completed")
# getTaskHook("draft")
# setTaskHook("draft", function() {
#   message("never happens")
#   return(TRUE)
# })
# getTaskHook("draft")

## -----------------------------------------------------------------------------
# # abort
# tsk$abort()
# # check
# tsk$update()

## -----------------------------------------------------------------------------
# tsklst <- a$task(status = "draft")
# # delete a single task
# tsklst[[1]]$delete()
# # confirm
# a$task(status = "draft")
# # delete a list of tasks
# delete(tsklst)

## -----------------------------------------------------------------------------
# tsk$download("~/Downloads")

## -----------------------------------------------------------------------------
# # batch by items
# (tsk <- p$task_add(
#   name = "RNA DE report new batch 2",
#   description = "RNA DE analysis report",
#   app = rna.app$id,
#   batch = batch(input = "bamfiles"),
#   inputs = list(
#     bamfiles = bamfiles.in,
#     design = design.in,
#     gtffile = gtf.in
#   )
# ))
# 
# # batch by metadata, input files has to have metadata fields specified
# (tsk <- p$task_add(
#   name = "RNA DE report new batch 3",
#   description = "RNA DE analysis report",
#   app = rna.app$id,
#   batch = batch(
#     input = "fastq",
#     c("metadata.sample_id", "metadata.library_id")
#   ),
#   inputs = list(
#     bamfiles = bamfiles.in,
#     design = design.in,
#     gtffile = gtf.in
#   )
# ))

## -----------------------------------------------------------------------------
# batch_task <- p$task(parent = "<parent_task_id>")
# tsk_id <- sapply(batch_task, "[[", "id")
# for (i in 1:length(tsk_id)) {
#   tsk <- p$task(id = tsk_id[i])
#   tsk$file()
#   tsk$download()
# }

## -----------------------------------------------------------------------------
# a <- Auth(user = "RFranklin", platform = "aws-us")
# 
# a$add_volume(
#   name = "tutorial_volume",
#   type = "s3",
#   bucket = "RFranklin-demo",
#   prefix = "",
#   access_key_id = "your_access_key_id",
#   secret_access_key = "your_secret_access_key",
#   sse_algorithm = "AES256",
#   access_mode = "RW"
# )

## -----------------------------------------------------------------------------
# # list all volume
# a$volume()
# # get unique volume by id
# a$volume(id = "RFranklin/RFranklin_demo")
# # partial search by name
# a$volume(name = "demo")

## -----------------------------------------------------------------------------
# v <- a$volume()
# v[[1]]$detail()

## -----------------------------------------------------------------------------
# a$volume(id = "RFranklin/RFranklin_demo")$delete()

## -----------------------------------------------------------------------------
# v <- a$volume(id = "RFranklin/tutorial_volume")
# res <- v$import(
#   location = "A-RNA-File.bam.bai",
#   project = "RFranklin/s3tutorial",
#   name = "new.bam.bai",
#   overwrite = TRUE
# )
# 
# # get job status update
# # state will be "COMPLETED" when it's finished, otherwise "PENDING"
# v$get_import_job(res$id)
# v

## -----------------------------------------------------------------------------
# res <- v$export(
#   file = "579fb1c9e4b08370afe7903a",
#   volume = "RFranklin/tutorial_volume",
#   location = "", # when "" use old name
#   sse_algorithm = "AES256"
# )
# # get job status update
# # state will be "COMPLETED" when it's finished other wise "PENDING"
# v$get_export_job(res$id)
# v

## -----------------------------------------------------------------------------
# # list the first 100 files
# a$public_file()
# # list by offset and limit
# a$public_file(offset = 100, limit = 100)
# # simply list everything!
# a$public_file(complete = TRUE)
# # get exact file by id
# a$public_file(id = "5772b6f0507c175267448700")
# # get exact file by name with exact = TRUE
# a$public_file(name = "G20479.HCC1143.2.converted.pe_1_1Mreads.fastq", exact = TRUE)
# # with exact = FALSE by default search by name pattern
# a$public_file(name = "fastq")
# a$public_file(name = "G20479.HCC1143.2.converted.pe_1_1Mreads.fastq")

## -----------------------------------------------------------------------------
# # list for 100 apps
# a$public_app()
# # list by offset and limit
# a$public_app(offset = 100, limit = 50)
# # search by id
# a$public_app(id = "admin/sbg-public-data/control-freec-8-1/12")
# # search by name in ALL apps
# a$public_app(name = "STAR", complete = TRUE)
# # search by name with exact match
# a$public_app(name = "Control-FREEC", exact = TRUE, complete = TRUE)

## -----------------------------------------------------------------------------
# p <- a$project(id = "RFranklin/source-project")
# f <- p$file(complete = TRUE)
# # get all file IDs
# file_ids <- sapply(f, "[[", "id")
# # bulk copy files to the target project
# req <- a$bulk_file_copy(file_ids, "RFranklin/target-project")
# # print the response list
# (req <- unname(req))

## -----------------------------------------------------------------------------
# sapply(req, "[[", "status")

## -----------------------------------------------------------------------------
# sapply(req, "[[", "new_file_id")

## -----------------------------------------------------------------------------
# sapply(req, "[[", "new_file_name")

## -----------------------------------------------------------------------------
# a$send_feedback(
#   "This is a test for sending feedback via API. Please ignore this message.",
#   type = "thought"
# )

## -----------------------------------------------------------------------------
# a <- Auth(...)
# 
# a$division()

## -----------------------------------------------------------------------------
# (d <- a$division("the-division"))

## -----------------------------------------------------------------------------
# team1 <- d$create_team(name = "New Team 1")
# team2 <- d$create_team(name = "New Team 2")

## -----------------------------------------------------------------------------
# d$team(team1$id)

## -----------------------------------------------------------------------------
# team1$add_member("the-division/your_username")
# team1$add_member("the-division/another_username")
# 
# team2$add_member("the-division/your_username")

## -----------------------------------------------------------------------------
# (m1 <- team1$member())
# (m2 <- team2$member())

## -----------------------------------------------------------------------------
# team1$remove_member(m1[[1]]$username)

## -----------------------------------------------------------------------------
# team1$rename("Another Team Name")

## -----------------------------------------------------------------------------
# d$team()

## -----------------------------------------------------------------------------
# team1$delete()
# team2$delete()

## -----------------------------------------------------------------------------
# opt <- getOption("sevenbridges")
# opt$advance_access <- TRUE
# options(sevenbridges = opt)

## -----------------------------------------------------------------------------
# # locate the project
# p <- a$project(id = "RFranklin/api-markers")
# # search for files with `.bam` in their names
# f <- p$file(name = ".bam")
# # use the first BAM file
# f <- p$file(id = f[[1]]$id)
# 
# # create two markers
# m1 <- f$create_marker("The First Marker", start = 21631232, end = 21631232)
# m2 <- f$create_marker("The Second Marker", start = 21631156, end = 21631158, chromosome = "chr7", private = FALSE)

## -----------------------------------------------------------------------------
# f$marker()

## -----------------------------------------------------------------------------
# marker_id <- m1$id
# f$marker(id = marker_id)

## -----------------------------------------------------------------------------
# (m1 <- m1$modify(name = "New Marker Name", end = 21631233, private = FALSE))

## -----------------------------------------------------------------------------
# m1$delete()
# m2$delete()

## -----------------------------------------------------------------------------
# # 01 - Authentication ----------------------------------------------------------
# 
# getToken()
# 
# # authentication methods
# a <- Auth(token = token)
# a <- Auth(token = token, platform = "cgc")
# a <- Auth(from = "env")
# a <- Auth(from = "file", profile_name = "aws-us-user")
# 
# # list all API calls
# a$api()
# 
# # API rate limit
# a$rate_limit()
# 
# # 02 - User -------------------------------------------------------------------
# 
# a$user()
# a$user("RFranklin")
# 
# # 03 - Billing -----------------------------------------------------------------
# 
# a$billing()
# a$billing(id = ..., breakdown = TRUE)
# a$invoice()
# a$invoice(id = "your_id")
# 
# # 04 - Project -----------------------------------------------------------------
# 
# # create new project
# a$project_new(name = ..., billing_group_id = ..., description = ...)
# 
# # list all project owned by you
# a$project()
# a$project(owner = "Rosalind.Franklin")
# 
# # partial match
# p <- a$project(name = ..., id = ..., exact = TRUE)
# 
# # delete
# p$delete()
# 
# # update
# p$update(name = ..., description = ...)
# 
# # members
# p$member()
# p$member_add(username = ...)
# p$member(username = ...)$update(write = ..., copy = ..., execute = ...)
# p$memeber(usrname = ...)$delete()
# 
# # 05 - File --------------------------------------------------------------------
# 
# # list all files in this project
# p$file()
# 
# # list all public files
# a$file(visibility = "public")
# 
# # copy
# a$copyFile(c(fid, fid2), project = pid)
# 
# # delete
# p$file(id = fid)$delete()
# 
# # download
# p$file()[[1]]$download_url()
# p$file(id = fid3)$download("~/Downloads/")
# 
# # download all
# download(p$file())
# 
# # update a file
# fl$update(name = ..., metadata = list(a = ..., b = ..., ...))
# 
# # metadata
# fl$meta()
# fl$setMeta()
# fl$setMeta(..., overwrite = TRUE)
# 
# # 06 - App ---------------------------------------------------------------------
# 
# a$app()
# 
# # apps in a project
# p$app()
# p$app(name, id, revision = ...)
# a$copy_app(aid, project = pid, name = ...)
# 
# # add new app
# p$app_add(short_name = ..., filename = ...)
# 
# # 07 - Task --------------------------------------------------------------------
# 
# a$task()
# a$task(id = ...)
# a$task(status = ...)
# 
# p$task()
# p$task(id = ...)
# p$task(status = ...)
# 
# tsk <- p$task(id = ...)
# tsk$update()
# tsk$abort()
# tsk$run()
# tsk$download()
# tsk$detele()
# tsk$getInputs()
# tsk$monitor()
# 
# getTaskHook()
# setTaskHook(status = ..., fun = ...)

