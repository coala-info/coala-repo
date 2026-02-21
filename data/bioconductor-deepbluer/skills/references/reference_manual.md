Package ‘DeepBlueR’

April 11, 2018

Title DeepBlueR

Type Package

Description Accessing the DeepBlue Epigenetics Data Server through R.

Version 1.4.1

Author Felipe Albrecht, Markus List

Maintainer Felipe Al-

brecht <felipe.albrecht@mpi-inf.mpg.de>, Markus List <markus.list@mpi-inf.mpg.de>

License GPL (>=2.0)

Imports GenomicRanges, data.table, stringr, diffr, dplyr, methods,

rjson, utils, R.utils, foreach, withr, rtracklayer,
GenomeInfoDb, settings, ﬁlehash

Depends R (>= 3.3), XML, RCurl

Collate options.R class_DeepBlueCommand.R deepblue.R

internalFunctions.R export.R liftover.R helperFunctions.R
methods_DeepBlueCommand.R zzz.R caching.R

BuildVignettes TRUE

RoxygenNote 6.0.1

Suggests knitr, rmarkdown, LOLA, Gviz, gplots, ggplot2, tidyr,

RColorBrewer, matrixStats

VignetteBuilder knitr

biocViews DataImport, DataRepresentation, ThirdPartyClient,

GeneRegulation, GenomeAnnotation, CpGIsland, DNAMethylation,
Epigenetics, Annotation, Preprocessing

NeedsCompilation no

R topics documented:

.

.

.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
DeepBlueCommand-class .
deepblue_aggregate .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
deepblue_batch_export_results . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
deepblue_binning .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
deepblue_cache_status
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
deepblue_cancel_request
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
deepblue_chromosomes .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
deepblue_clear_cache .

.
.
.
.
.

.

3
4
5
5
6
7
7
8

1

2

R topics documented:

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.
.

.
.

.
.

.
.
.

.
.
.

.
.
.

. .
.
.
.

8
deepblue_collection_experiments_count . . . . . . . . . . . . . . . . . . . . . . . . . .
deepblue_commands .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
deepblue_count_gene_ontology_terms . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
deepblue_count_regions
deepblue_coverage .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
.
deepblue_delete_request_from_cache . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
.
.
deepblue_diff
deepblue_distinct_column_values
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
deepblue_download_request_data . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 14
deepblue_download_request_data,DeepBlueCommand-method . . . . . . . . . . . . . . 15
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
.
deepblue_echo .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
deepblue_enrich_regions_fast
deepblue_enrich_regions_go_terms
. . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
deepblue_enrich_regions_overlap . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
.
deepblue_export_bed .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
deepblue_export_meta_data
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
.
deepblue_export_tab .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
.
deepblue_extend .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
.
deepblue_extract_ids .
deepblue_extract_names
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
.
deepblue_faceting_experiments . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
deepblue_ﬁlter_regions .
.
deepblue_ﬁnd_motif
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
.
.
deepblue_ﬂank .
deepblue_format_object_size . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
deepblue_get_biosource_children . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
deepblue_get_biosource_parents . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
deepblue_get_biosource_related . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
. . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
deepblue_get_biosource_synonyms
deepblue_get_db .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
deepblue_get_experiments_by_query . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
.
deepblue_get_regions .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
deepblue_get_request_data .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
.
deepblue_info .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
.
deepblue_input_regions .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
.
.
deepblue_intersection .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
.
.
deepblue_is_biosource .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
.
deepblue_liftover
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
.
deepblue_list_annotations .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
.
deepblue_list_biosources .
deepblue_list_cached_requests . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
deepblue_list_column_types . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
deepblue_list_epigenetic_marks
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
deepblue_list_experiments .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
.
deepblue_list_expressions
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
deepblue_list_genes .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
deepblue_list_gene_models .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
.
deepblue_list_genomes .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 43
.
.
deepblue_list_in_use .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
deepblue_list_projects
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
deepblue_list_recent_experiments
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
deepblue_list_requests

.
.
.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

DeepBlueCommand-class

3

.

.

.

.
.

.
.

.
.
.

.
.
.

.
.
.

deepblue_list_samples
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
deepblue_list_similar_biosources . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
deepblue_list_similar_epigenetic_marks . . . . . . . . . . . . . . . . . . . . . . . . . . 47
deepblue_list_similar_experiments . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
deepblue_list_similar_genomes . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
deepblue_list_similar_projects . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
deepblue_list_similar_techniques . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
deepblue_list_techniques .
deepblue_merge_queries .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
deepblue_meta_data_to_table . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
deepblue_name_to_id .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
.
deepblue_options .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
deepblue_overlap .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
deepblue_preview_experiment
deepblue_query_cache .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 55
deepblue_query_experiment_type . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 56
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57
deepblue_reset_options .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 58
deepblue_score_matrix .
deepblue_search .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 59
.
deepblue_select_annotations . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 59
deepblue_select_column .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 60
deepblue_select_experiments . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 61
deepblue_select_expressions . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63
deepblue_select_genes
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64
deepblue_select_regions
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 65
deepblue_tiling_regions .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66
.
deepblue_wait_request

.
.
.
.

.
.
.
.

.
.
.

.
.
.

.

.

.

.

.

.

.

Index

67

DeepBlueCommand-class DeepBlueCommand class

Description

An S4 class returned when calling a DeepBlue-R function. It holds information about the original
call, the query / request status, previous commands, the user_key, and results in GRanges format
once a request is downloaded.

Arguments

call
status
query_id
previous_commands

language
character
character

list
character
GRanges

user_key
result

Value

class for managin DeepBlue commands

4

deepblue_aggregate

deepblue_aggregate

aggregate

Description

Summarize the data_id content using the regions speciﬁed in ranges_id as boundaries. Use the ﬁelds
@AGG.MIN, @AGG.MAX, @AGG.SUM, @AGG.MEDIAN, @AGG.MEAN, @AGG.VAR, @AGG.SD,
@AGG.COUNT in ’get_regions’ command ’format’ parameter to retrieve the computed values
minimum, maximum, median, mean, variance, standard deviation and number of regions, respec-
tively.

Usage

deepblue_aggregate(data_id = NULL, ranges_id = NULL, column = NULL,

user_key = deepblue_options("user_key"))

Arguments

data_id

ranges_id

column

user_key

Value

- A string (id of the query with the data)

- A string (id of the query with the regions range)

- A string (name of the column that will be used in the aggregation)

- A string (users token key)

regions - A string (query id of this aggregation operation)

See Also

Other Operating on the data regions: deepblue_binning, deepblue_count_regions, deepblue_coverage,
deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions, deepblue_flank,
deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions, deepblue_intersection,
deepblue_merge_queries, deepblue_overlap, deepblue_query_cache, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

annotation_id = deepblue_select_annotations(

annotation_name="CpG Islands",
genome="hg19", chromosome="chr1")
data_id = deepblue_select_experiments(

experiment_name="E002-H3K9ac.narrowPeak.bed")

deepblue_aggregate(

data_id = data_id,
ranges_id=annotation_id,
column = "SCORE")

deepblue_batch_export_results

5

deepblue_batch_export_results

batch_export_results

Description

Write results from DeepBlue to disk as they become available

Usage

deepblue_batch_export_results(requests, target.directory = NULL,

suffix = "result", prefix = "DeepBlue", sleep.time = 1,
bed.format = TRUE, user_key = deepblue_options("user_key"))

Arguments

requests
target.directory

A list of request objects

Where the results should be saved

File names sufﬁx

File names preﬁx

How long this function will wait after the requests veriﬁcation

whether to store the results as BED ﬁles or tab delimited.

A string used to authenticate the user

suffix

prefix

sleep.time

bed.format

user_key

Value

A list containing the requests IDs data

Examples

data_id = deepblue_select_experiments(
experiment_name="E002-H3K9ac.narrowPeak.bed", chromosome="chr1")
request_id = deepblue_get_regions(query_id =data_id,

output_format = "CHROMOSOME,START,END")

request_data = deepblue_batch_export_results(list(request_id))

deepblue_binning

binning

Description

Bin results according to counts.

Usage

deepblue_binning(query_data_id = NULL, column = NULL, bins = NULL,

user_key = deepblue_options("user_key"))

6

Arguments

deepblue_cache_status

query_data_id

- A string (query data that will made by the binning.)

column

bins

user_key

Value

- A string (name of the column that will be used in the aggregation)

- A int (number of of bins)

- A string (users token key)

request_id - A string (Request ID - Use it to retrieve the result with info() and get_request_data())

See Also

Other Operating on the data regions: deepblue_aggregate, deepblue_count_regions, deepblue_coverage,
deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions, deepblue_flank,
deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions, deepblue_intersection,
deepblue_merge_queries, deepblue_overlap, deepblue_query_cache, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

experiment_id = deepblue_select_experiments(

experiment_name="S00XDKH1.ERX712765.H3K27ac.bwa.GRCh38.20150527.bed")

deepblue_binning (query_data_id=experiment_id,

column="SIGNAL_VALUE",
bins=40)

deepblue_cache_status Report on the cache size and status

Description

Report on the cache size and status

Usage

deepblue_cache_status()

Value

cache size in byte

Examples

deepblue_cache_status()

deepblue_cancel_request

7

deepblue_cancel_request

cancel_request

Description

Stop, cancel, and remove request data. The request processed data is remove if its processing was
ﬁnished.

Usage

deepblue_cancel_request(id = NULL, user_key = deepblue_options("user_key"))

Arguments

id

user_key

Value

- A string (Request ID to be canceled, stopped or removed.)

- A string (users token key)

id - A string (ID of the canceled request)

See Also

Other Commands for all types of data: deepblue_info, deepblue_is_biosource, deepblue_list_in_use,
deepblue_name_to_id, deepblue_search

Examples

deepblue_cancel_request(id = "r12345")

deepblue_chromosomes

chromosomes

Description

List the chromosomes of a given Genome.

Usage

deepblue_chromosomes(genome = NULL, user_key = deepblue_options("user_key"))

Arguments

genome

user_key

Value

- A string (the target genome)

- A string (users token key)

chromosomes - A array (A list containing all chromosomes, with theirs names and sizes)

8

See Also

deepblue_collection_experiments_count

Other Inserting and listing genomes: deepblue_list_genomes, deepblue_list_similar_genomes

Examples

deepblue_chromosomes(genome = "g1")

deepblue_clear_cache

Clear cache

Description

Clear cache

Usage

deepblue_clear_cache()

Value

TRUE if successful

Examples

deepblue_clear_cache()

deepblue_collection_experiments_count

collection_experiments_count

Description

Count the number of experiments that match the selection criteria in each term of the selected
controlled_vocabulary. The selection can be achieved through specifying a list of BioSources, ex-
perimental Techniques, Epigenetic Marks, Samples or Projects.

Usage

deepblue_collection_experiments_count(controlled_vocabulary = NULL,

genome = NULL, type = NULL, epigenetic_mark = NULL, biosource = NULL,
sample = NULL, technique = NULL, project = NULL,
user_key = deepblue_options("user_key"))

deepblue_commands

Arguments

controlled_vocabulary

9

- A string (controlled vocabulary name)

- A string or a vector of string (the target genome)

- A string or a vector of string (type of the experiment: peaks or signal)

genome

type
epigenetic_mark

- A string or a vector of string (name(s) of selected epigenetic mark(s))

- A string or a vector of string (name(s) of selected biosource(s))

- A string or a vector of string (id(s) of selected sample(s))

- A string or a vector of string (name(s) of selected technique(s))

- A string or a vector of string (name(s) of selected projects)

- A string (users token key)

biosource

sample

technique

project

user_key

Value

terms - A array (controlled_vocabulary terms with count)

See Also

Other Inserting and listing experiments: deepblue_faceting_experiments, deepblue_list_experiments,
deepblue_list_recent_experiments, deepblue_list_similar_experiments, deepblue_preview_experiment

Examples

deepblue_collection_experiments_count(
controlled_vocabulary="epigenetic_marks",
genome = "hg19", type = "peaks",
biosource = "blood")

deepblue_commands

commands

Description

List all available DeepBlue commands.

Usage

deepblue_commands()

Value

commands - A struct (command descriptions)

See Also

Other Checking DeepBlue status: deepblue_echo

10

Examples

deepblue_commands()

deepblue_count_gene_ontology_terms

deepblue_count_gene_ontology_terms

count_gene_ontology_terms

Description

Summarize the controlled_vocabulary ﬁelds, from experiments that match the selection criteria. It
is similar to the ’collection_experiments_count’ command, but this command return the summa-
rization for all controlled_vocabulary terms.

Usage

deepblue_count_gene_ontology_terms(genes = NULL, go_terms = NULL,
chromosome = NULL, start = NULL, end = NULL, gene_model = NULL,
user_key = deepblue_options("user_key"))

Arguments

genes

go_terms

chromosome

start

end

gene_model

user_key

Value

- A string or a vector of string (Name(s) or ENSEMBL ID (ENSGXXXXXXXXXXX.X
) of the gene(s).)

- A string or a vector of string (gene ontology terms - ID or label)

- A string or a vector of string (chromosome name(s))

- A int (minimum start region)

- A int (maximum end region)

- A string (the gene model)

- A string (users token key)

faceting - A struct (Map with the mandatory ﬁelds of the experiments metadata, where each contains
a list of terms that appears.)

See Also

Other Gene models and genes identiﬁers: deepblue_list_gene_models, deepblue_list_genes,
deepblue_select_genes

Examples

gene_names = c('CCR1', 'CD164', 'CD1D', 'CD2', 'CD34', 'CD3G', 'CD44')
deepblue_count_gene_ontology_terms (genes = gene_names, gene_model = "gencode v23")

deepblue_count_regions

11

deepblue_count_regions

count_regions

Description

Return the number of genomic regions present in the query.

Usage

deepblue_count_regions(query_id = NULL,

user_key = deepblue_options("user_key"))

Arguments

query_id

user_key

Value

- A string (Query ID)

- A string (users token key)

request_id - A string (Request ID - Use it to retrieve the result with info() and get_request_data())

See Also

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_coverage,
deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions, deepblue_flank,
deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions, deepblue_intersection,
deepblue_merge_queries, deepblue_overlap, deepblue_query_cache, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

data_id = deepblue_select_experiments(

experiment_name="E002-H3K9ac.narrowPeak.bed")

deepblue_count_regions(query_id = data_id)

deepblue_coverage

coverage

Description

Send a request to count the number of regions in the result of the given query.

Usage

deepblue_coverage(query_id = NULL, genome = NULL,

user_key = deepblue_options("user_key"))

12

Arguments

query_id

genome

user_key

Value

deepblue_delete_request_from_cache

- A string (Query ID)

- A string (Genome where the coverage will be calculated to)

- A string (users token key)

request_id - A string (Request ID - Use it to retrieve the result with info() and get_request_data())

See Also

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions, deepblue_flank,
deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions, deepblue_intersection,
deepblue_merge_queries, deepblue_overlap, deepblue_query_cache, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

data_id = deepblue_select_experiments(

experiment_name="E002-H3K9ac.narrowPeak.bed")
deepblue_coverage(query_id = data_id, genome="hg19")

deepblue_delete_request_from_cache

Delete a speciﬁc request from the cache

Description

Delete a speciﬁc request from the cache

Usage

deepblue_delete_request_from_cache(request_id)

Arguments

request_id

the request to delete from the cache

Value

TRUE if the request was successfully deleted, FALSE otherwise

Examples

deepblue_delete_request_from_cache("non-existing-request-id")
# returns FALSE

deepblue_diff

13

deepblue_diff

diff

Description

A utility command that creates a diff view of info for two DeepBlue ids

Usage

deepblue_diff(id1, id2, user_key = deepblue_options("user_key"))

Arguments

id1

id2

- A DeepBlue id

- Another DeepBlue id

user_key

- A string (users token key)

Value

None

See Also

Other Utilities for information processing: deepblue_select_column

Examples

deepblue_diff(

id1 = "e16918",
id2 = "e16919")

deepblue_distinct_column_values

distinct_column_values

Description

Obtain the distict values of the ﬁeld.

Usage

deepblue_distinct_column_values(query_id = NULL, field = NULL,

user_key = deepblue_options("user_key"))

Arguments

query_id

field

user_key

- A string (Query ID)

- A string (ﬁeld that is ﬁltered by)

- A string (users token key)

14

Value

id - A string (id of ﬁltered query)

See Also

deepblue_download_request_data

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_extend, deepblue_filter_regions, deepblue_flank, deepblue_get_experiments_by_query,
deepblue_get_regions, deepblue_input_regions, deepblue_intersection, deepblue_merge_queries,
deepblue_overlap, deepblue_query_cache, deepblue_query_experiment_type, deepblue_score_matrix,
deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

css_experiment <- deepblue_select_experiments ( "wgEncodeBroadHmmK562HMM")
distinct_names_request <- deepblue_distinct_column_values (css_experiment, "NAME")

deepblue_download_request_data

deepblue_download_request_data

Description

Returns the requested data as the expected type object. Expects two input parameters; Request infor-
mation and user key. It depends on outputs from several functions, namely; deepblue_get_request_data,
convert_to_df, and convert_to_grange.

Usage

deepblue_download_request_data(request_id,
user_key = deepblue_options("user_key"),
force_download = deepblue_options("force_download"),
do_not_cache = deepblue_options("do_not_cache"))

Arguments

request_id

user_key

- Id of the request that will be downloaded

A string

force_download forces DeepBlueR to download the request overwriting any results that might

already be in the cache

do_not_cache

whether to use local caching of requests

Value

grange_regions Final output in GRanges format or as data frame

deepblue_download_request_data,DeepBlueCommand-method

15

Examples

data_id = deepblue_select_experiments(
experiment_name="E002-H3K9ac.narrowPeak.bed", chromosome="chr1")
request_id = deepblue_get_regions(query_id =data_id,

output_format = "CHROMOSOME,START,END")

request_data = deepblue_download_request_data(request_id)

deepblue_download_request_data,DeepBlueCommand-method

deepblue_download_request_data

Description

Returns the requested data as the expected type object. Expects two input parameters; Request infor-
mation and user key. It depends on outputs from several functions, namely; deepblue_get_request_data,
convert_to_df, and convert_to_grange.

Usage

## S4 method for signature 'DeepBlueCommand'
deepblue_download_request_data(request_id)

Arguments

request_id

DeepBlueCommand object

Value

grange_regions Final output in GRanges format

deepblue_echo

echo

Description

Greet the user with the DeepBlue version.

Usage

deepblue_echo(user_key = deepblue_options("user_key"))

Arguments

user_key

Value

- A string (users token key)

message - A string (echo message including version)

deepblue_enrich_regions_fast

16

See Also

Other Checking DeepBlue status: deepblue_commands

Examples

deepblue_echo(user_key = "anonymous_key")

deepblue_enrich_regions_fast

enrich_regions_fast

Description

Enrich the regions based on regions bitmap signature comparison.

Usage

deepblue_enrich_regions_fast(query_id = NULL, genome = NULL,
epigenetic_mark = NULL, biosource = NULL, sample = NULL,
technique = NULL, project = NULL,
user_key = deepblue_options("user_key"))

Arguments

query_id

- A string (Query ID)

genome
epigenetic_mark

- A string or a vector of string (the target genome)

- A string or a vector of string (name(s) of selected epigenetic mark(s))

- A string or a vector of string (name(s) of selected biosource(s))

- A string or a vector of string (id(s) of selected sample(s))

- A string or a vector of string (name(s) of selected technique(s))

- A string or a vector of string (name(s) of selected projects)

- A string (users token key)

biosource

sample

technique

project

user_key

Value

request_id - A string (Request ID - Use it to retrieve the result with info() and get_request_data().
The result is a list containing the datasets that overlap with the query_id regions.)

See Also

Other Enrich the genome regions: deepblue_enrich_regions_go_terms, deepblue_enrich_regions_overlap

deepblue_enrich_regions_go_terms

17

deepblue_enrich_regions_go_terms

enrich_regions_go_terms

Description

Enrich the regions based on Gene Ontology terms.

Usage

deepblue_enrich_regions_go_terms(query_id = NULL, gene_model = NULL,

user_key = deepblue_options("user_key"))

Arguments

query_id

gene_model

user_key

Value

- A string (Query ID)

- A string (the gene model)

- A string (users token key)

request_id - A string (Request ID - Use it to retrieve the result with info() and get_request_data().
The result is a list containing the GO terms that overlap with the query_id regions.)

See Also

Other Enrich the genome regions: deepblue_enrich_regions_fast, deepblue_enrich_regions_overlap

Examples

data_id = deepblue_select_experiments(

experiment_name="E002-H3K9ac.narrowPeak.bed")

filtered_id = deepblue_filter_regions(query_id = data_id,

field = "VALUE",
operation = ">",
value = "100",
type = "number",
user_key = "anonymous_key")

deepblue_enrich_regions_go_terms(query_id = filtered_id,

gene_model = "gencode v23")

18

deepblue_enrich_regions_overlap

deepblue_enrich_regions_overlap

enrich_regions_overlap

Description

Enrich the regions based on regions overlap analysis.

Usage

deepblue_enrich_regions_overlap(query_id = NULL, background_query_id = NULL,
datasets = NULL, genome = NULL, user_key = deepblue_options("user_key"))

Arguments

query_id
background_query_id

- A string (Query ID)

- A string (query_id containing the regions that will be used as the background
data.)

- A struct (a map where each key is an identiﬁer and the value is a list containing
experiment names or query_ids (you can use both together).)

- A string (the target genome)

- A string (users token key)

datasets

genome

user_key

Value

request_id - A string (Request ID - Use it to retrieve the result with info() and get_request_data().
The result is a list containing the datasets that overlap with the query_id regions.)

See Also

Other Enrich the genome regions: deepblue_enrich_regions_fast, deepblue_enrich_regions_go_terms

Examples

query_id = deepblue_select_experiments(

experiment_name="S00VEQA1.hypo_meth.bs_call.GRCh38.20150707.bed")

filtered_query_id = deepblue_filter_regions(

query_id = query_id,
field = "AVG_METHYL_LEVEL",
operation = "<",
value = "0.0025",
type="number")

rg_10kb_tilling = deepblue_tiling_regions(

size = 1000,
genome = "hg19")

# We could have included more Epigenetic Marks here
epigenetic_marks <- c("h3k27ac", "H3K27me3", "H3K4me3")

deepblue_export_bed

19

histones_datasets = c()
for (i in 1:length(epigenetic_marks)) {

experiments_list <- deepblue_list_experiments(

epigenetic_mark=epigenetic_marks[[i]],
type="peaks",
genome="grch38",
project="BLUEPRINT Epigenome");

experiment_names = deepblue_extract_names(experiments_list)
histones_datasets[[epigenetic_marks[[i]]]] = experiment_names

}

deepblue_enrich_regions_overlap(
query_id=filtered_query_id,
background_query=rg_10kb_tilling,
datasets=histones_datasets,
genome="grch38")

deepblue_export_bed

Export GenomicRanges result as BED ﬁle

Description

Export GenomicRanges result as BED ﬁle

Usage

deepblue_export_bed(result, target.directory = "./", file.name,

score.field = NULL)

Arguments

result
target.directory

A result from a DeepBlue request such as a set of genomic regions.

file.name

score.field

The directory to save the ﬁle to

The name of the ﬁle without sufﬁx

Which column of the results should be used to populate the score column of the
BED ﬁle (optional)

Value

return value of write.table

Examples

query_id = deepblue_select_experiments (
experiment=c("GC_T14_10.CPG_methylation_calls.bs_call.GRCh38.20160531.wig"),
chromosome="chr1", start=0, end=50000000)
cpg_islands = deepblue_select_annotations(annotation_name="CpG Islands",
genome="GRCh38", chromosome="chr1", start=0, end=50000000)
overlapped = deepblue_aggregate (data_id=query_id, ranges_id=cpg_islands,

column="VALUE" )

20

deepblue_export_tab

request_id = deepblue_get_regions(query_id=overlapped,

output_format=

"CHROMOSOME,START,END,@AGG.MIN,@AGG.MAX,@AGG.MEAN,@AGG.VAR")

regions = deepblue_download_request_data(request_id=request_id)
temp_dir = tempdir()
deepblue_export_bed(regions, target.directory = temp_dir,

file.name = "GC_T14_10.CpG_islands")

deepblue_export_meta_data

Export meta data as tab delimited ﬁle

Description

Export meta data as tab delimited ﬁle

Usage

deepblue_export_meta_data(ids, target.directory = "./", file.name,

user_key = deepblue_options("user_key"))

Arguments

ids
target.directory

an id or a list of DeepBlue ids

where the meta data should be stored

file.name

user_key

name of the ﬁle

DeepBlue user key

Value

return value of write.table

Examples

deepblue_export_meta_data(list("e30035", "e30036"),
file.name = "test_export",
target.directory = tempdir())

deepblue_export_tab

Export a DeepBlue result as ordinary tab delimited ﬁle

Description

Export a DeepBlue result as ordinary tab delimited ﬁle

Usage

deepblue_export_tab(result, target.directory = "./", file.name)

deepblue_extend

Arguments

21

result
target.directory

A result from a DeepBlue request such as a set of genomic regions.

The directory to save the ﬁle to

file.name

The name of the ﬁle without sufﬁx

Value

return value of write.table

Examples

query_id = deepblue_select_experiments (
experiment=c("GC_T14_10.CPG_methylation_calls.bs_call.GRCh38.20160531.wig"),
chromosome="chr1", start=0, end=50000000)
cpg_islands = deepblue_select_annotations(annotation_name="CpG Islands",
genome="GRCh38", chromosome="chr1", start=0, end=50000000)
overlapped = deepblue_aggregate (data_id=query_id, ranges_id=cpg_islands,

request_id = deepblue_get_regions(query_id=overlapped,

column="VALUE" )

output_format=

"CHROMOSOME,START,END,@AGG.MIN,@AGG.MAX,@AGG.MEAN,@AGG.VAR")

regions = deepblue_download_request_data(request_id=request_id)
temp_dir = tempdir()
deepblue_export_tab(regions, target.directory = temp_dir,

file.name = "GC_T14_10.CpG_islands")

deepblue_extend

extend

Description

Extend the genomic regions included in the query. It is possible to extend downstream, upstream or
in both directions.

Usage

deepblue_extend(query_id = NULL, length = NULL, direction = NULL,
use_strand = NULL, user_key = deepblue_options("user_key"))

Arguments

query_id

length

direction

use_strand

user_key

- A string (Query ID)

- A int (The new region length)

- A string (The direction that the region will be extended: ’BACKWARD’,
’FORWARD’, ’BOTH’. (Empty value will be used for both direction.)

- A boolean (Use the region column STRAND to deﬁne the region direction)

- A string (users token key)

22

Value

id - A string (id of the new query)

See Also

deepblue_extract_ids

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_filter_regions, deepblue_flank,
deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions, deepblue_intersection,
deepblue_merge_queries, deepblue_overlap, deepblue_query_cache, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

annotation_id = deepblue_select_annotations(

annotation_name="CpG Islands",
genome="hg19", chromosome="chr1")
deepblue_extend(query_id = annotation_id,
length = 2000, direction = "BOTH",
use_strand = TRUE)

deepblue_extract_ids

extract_ids

Description

A utility command that returns a list of IDs extracted from a data frame of ID and names.

Usage

deepblue_extract_ids(df = NULL)

Arguments

df

Value

- A array of IDs and names

ids - A vector containing the extracted IDs)

See Also

Other Utilities for connecting operations: deepblue_extract_names

Examples

deepblue_extract_ids(

df = data.frame(id = c("a124", "a1235"),
name = c("Annotation 1", "Annotation 2")))

deepblue_extract_names

23

deepblue_extract_names

extract_names

Description

A utility command that returns a list of names extracted from a list of ID and names.

Usage

deepblue_extract_names(df = NULL)

Arguments

df

Value

- A array of IDs and Names

names - A vector containing the extracted names

See Also

Other Utilities for connecting operations: deepblue_extract_ids

Examples

deepblue_extract_ids(

df = data.frame(id = c("a124", "a1235"),
name = c("Annotation 1", "Annotation 2")))

deepblue_faceting_experiments

faceting_experiments

Description

Summarize the controlled_vocabulary ﬁelds, from experiments that match the selection criteria. It
is similar to the ’collection_experiments_count’ command, but this command return the summa-
rization for all controlled_vocabulary terms.

Usage

deepblue_faceting_experiments(genome = NULL, type = NULL,

epigenetic_mark = NULL, biosource = NULL, sample = NULL,
technique = NULL, project = NULL,
user_key = deepblue_options("user_key"))

24

Arguments

genome
type
epigenetic_mark

biosource
sample
technique
project
user_key

Value

deepblue_ﬁlter_regions

- A string or a vector of string (the target genome)
- A string or a vector of string (type of the experiment: peaks or signal)

- A string or a vector of string (name(s) of selected epigenetic mark(s))
- A string or a vector of string (name(s) of selected biosource(s))
- A string or a vector of string (id(s) of selected sample(s))
- A string or a vector of string (name(s) of selected technique(s))
- A string or a vector of string (name(s) of selected projects)
- A string (users token key)

faceting - A struct (Map with the mandatory ﬁelds of the experiments metadata, where each contains
a list of terms that appears.)

See Also

Other Inserting and listing experiments: deepblue_collection_experiments_count, deepblue_list_experiments,
deepblue_list_recent_experiments, deepblue_list_similar_experiments, deepblue_preview_experiment

Examples

deepblue_faceting_experiments(genome = "hg19",

type = "peaks",
biosource = "blood")

deepblue_filter_regions

ﬁlter_regions

Description

Filter the genomic regions by their content.

Usage

deepblue_filter_regions(query_id = NULL, field = NULL, operation = NULL,
value = NULL, type = NULL, user_key = deepblue_options("user_key"))

Arguments

query_id
field
operation

value
type
user_key

- A string (Query ID)
- A string (ﬁeld that is ﬁltered by)
- A string (operation used for ﬁltering. For ’string’ must be ’==’ or ’!=’ and for
’number’ must be one of these: ==,!=,>,>=,<,<=)
- A string (value the operator is applied to)
- A string (type of the value: ’number’ or ’string’ )
- A string (users token key)

deepblue_ﬁnd_motif

Value

id - A string (id of ﬁltered query)

See Also

25

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_flank,
deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions, deepblue_intersection,
deepblue_merge_queries, deepblue_overlap, deepblue_query_cache, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

deepblue_filter_regions(query_id = "q12345",

field = "VALUE",
operation = ">",
value = "100",
type = "number",
user_key = "anonymous_key")

deepblue_find_motif

ﬁnd_motif

Description

Find genomic regions based on a given motif that appears in the genomic sequence.

Usage

deepblue_find_motif(motif = NULL, genome = NULL, chromosomes = NULL,

start = NULL, end = NULL, overlap = NULL,
user_key = deepblue_options("user_key"))

Arguments

motif

genome

- A string (motif (PERL regular expression))

- A string (the target genome)

chromosomes

- A string or a vector of string (chromosome name(s))

start

end

overlap

user_key

Value

- A int (minimum start region)

- A int (maximum end region)

- A boolean (if the matching should do overlap search)

- A string (users token key)

id - A string (id of the annotation that contains the positions of the given motif)

26

See Also

Other Inserting and listing annotations: deepblue_list_annotations

Examples

deepblue_find_motif(motif = "C[GT]+C", chromosomes=c("chr11", "chr12"),

genome = "hg19", overlap = FALSE)

deepblue_ﬂank

deepblue_flank

ﬂank

Description

Create a set of genomic regions that ﬂank the query regions. The original regions are removed from
the query. Use the merge command to combine ﬂanking regions with the original query.

Usage

deepblue_flank(query_id = NULL, start = NULL, length = NULL,

use_strand = NULL, user_key = deepblue_options("user_key"))

Arguments

query_id
start

length
use_strand
user_key

Value

- A string (Query ID)
- A int (Number of base pairs after the end of the region. Use a negative number
to denote the number of base pairs before the start of the region.)
- A int (The new region length)
- A boolean (Use the region column STRAND to deﬁne the region direction)
- A string (users token key)

id - A string (id of the new query)

See Also

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions, deepblue_intersection,
deepblue_merge_queries, deepblue_overlap, deepblue_query_cache, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

annotation_id = deepblue_select_annotations(

annotation_name="CpG Islands",
genome="hg19", chromosome="chr1")
deepblue_flank(query_id = annotation_id,

start = 0, length = 2000,
use_strand = TRUE)

deepblue_format_object_size

27

deepblue_format_object_size

Format byte size as human readable units

Description

Format byte size as human readable units

Usage

deepblue_format_object_size(x, units = "b")

size in bytes

target unit or ’auto’

Arguments

x

units

Value

formatted size

Source

utils:::format.object_size

deepblue_get_biosource_children

get_biosource_children

Description

A BioSource refers to a term describing the origin of a given sample, such as a tissue or cell line.
These form a hierarchy in which children of a BioSource term can be fetched with this command.
Children terms are more speciﬁc terms that are deﬁned in the imported ontologies.

Usage

deepblue_get_biosource_children(biosource = NULL,

user_key = deepblue_options("user_key"))

Arguments

biosource

user_key

Value

- A string (biosource name)

- A string (users token key)

biosources - A array (related biosources)

28

See Also

deepblue_get_biosource_parents

Other Set the relationship between different biosources: deepblue_get_biosource_parents, deepblue_get_biosource_related,
deepblue_get_biosource_synonyms

Examples

deepblue_get_biosource_children(biosource = "Blood")

deepblue_get_biosource_parents

get_biosource_parents

Description

A BioSource refers to a term describing the origin of a given sample, such as a tissue or cell line.
These form a hierarchy in which the parent of a BioSource term can be fetched with this command.
Parent terms are more generic terms that are deﬁned in the imported ontologies.

Usage

deepblue_get_biosource_parents(biosource = NULL,

user_key = deepblue_options("user_key"))

Arguments

biosource

user_key

Value

- A string (biosource name)

- A string (users token key)

biosources - A array (parents biosources)

See Also

Other Set the relationship between different biosources: deepblue_get_biosource_children,
deepblue_get_biosource_related, deepblue_get_biosource_synonyms

Examples

deepblue_get_biosource_parents(biosource = "Blood")

deepblue_get_biosource_related

29

deepblue_get_biosource_related

get_biosource_related

Description

A BioSource refers to a term describing the origin of a given sample, such as a tissue or cell line.
These form a hierarchy in which the children of a BioSource term and its synonyms can be fetched
with this command. Children terms are more speciﬁc terms that are deﬁned in the imported ontolo-
gies. Synonyms are different aliases for the same biosource.

Usage

deepblue_get_biosource_related(biosource = NULL,

user_key = deepblue_options("user_key"))

Arguments

biosource

user_key

Value

- A string (biosource name)

- A string (users token key)

biosources - A array (related biosources)

See Also

Other Set the relationship between different biosources: deepblue_get_biosource_children,
deepblue_get_biosource_parents, deepblue_get_biosource_synonyms

Examples

deepblue_get_biosource_related(biosource = "Blood")

deepblue_get_biosource_synonyms

get_biosource_synonyms

Description

Obtain the synonyms of the speciﬁed biosource. Synonyms are different aliases for the same
biosource. A BioSource refers to a term describing the origin of a given sample, such as a tis-
sue or cell line.

Usage

deepblue_get_biosource_synonyms(biosource = NULL,

user_key = deepblue_options("user_key"))

deepblue_get_experiments_by_query

30

Arguments

biosource

user_key

Value

- A string (name of the biosource)

- A string (users token key)

synonyms - A array (synonyms of the biosource)

See Also

Other Set the relationship between different biosources: deepblue_get_biosource_children,
deepblue_get_biosource_parents, deepblue_get_biosource_related

Examples

deepblue_get_biosource_synonyms(biosource = "prostate gland")

deepblue_get_db

Sets up the DeepBlueR cache and returns a ﬁlehash db object

Description

Sets up the DeepBlueR cache and returns a ﬁlehash db object

Usage

deepblue_get_db()

Value

A ﬁlehash package database

deepblue_get_experiments_by_query

get_experiments_by_query

Description

List the experiments and annotations that have at least one genomic region in the ﬁnal query result.

Usage

deepblue_get_experiments_by_query(query_id = NULL,

user_key = deepblue_options("user_key"))

Arguments

query_id

user_key

- A string (Query ID)

- A string (users token key)

deepblue_get_regions

Value

experiments - A array (List containing experiments names and ids)

See Also

31

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_flank, deepblue_get_regions, deepblue_input_regions, deepblue_intersection,
deepblue_merge_queries, deepblue_overlap, deepblue_query_cache, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

deepblue_get_experiments_by_query(query_id = "q12345")

deepblue_get_regions

get_regions

Description

Trigger the processing of the query’s genomic regions. The output is a column based format with
columns as deﬁned in the ’output_format’ parameter. Use the command ’info’ for verifying the
processing status. The ’get_request_data’ command is used to download the regions using the
programmatic interface. Alternatively, results can be download using the URL: http://deepblue.mpi-
inf.mpg.de/download?r_id=<request_id>&key=<user_key>.

Usage

deepblue_get_regions(query_id = NULL, output_format = NULL,

user_key = deepblue_options("user_key"))

Arguments

query_id

- A string (Query ID)

output_format

- A string (Output format)

user_key

- A string (users token key)

Value

request_id - A string (Request ID - Use it to retrieve the result with info() and get_request_data())

See Also

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_flank, deepblue_get_experiments_by_query, deepblue_input_regions, deepblue_intersection,
deepblue_merge_queries, deepblue_overlap, deepblue_query_cache, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

32

Examples

data_id = deepblue_select_experiments(

experiment_name="E002-H3K9ac.narrowPeak.bed")

deepblue_get_regions(query_id =data_id,

output_format = "CHROMOSOME,START,END")

deepblue_get_request_data

deepblue_get_request_data

get_request_data

Description

Download the requested data. The output can be (i) a string (get_regions, score_matrix, and
count_regions), or (ii) a list of ID and names (get_experiments_by_query), or (iii) a struct (cov-
erage).

Usage

deepblue_get_request_data(request_id = NULL,
user_key = deepblue_options("user_key"))

Arguments

request_id

user_key

- A string (ID of the request)

- A string (users token key)

Value

data - A string or a vector of string (the request data)

See Also

Other Requests status information and results: deepblue_list_requests

Examples

data_id = deepblue_select_experiments(

experiment_name="E002-H3K9ac.narrowPeak.bed",
chromosome="chr1")

request_id = deepblue_get_regions(

query_id =data_id,
output_format = "CHROMOSOME,START,END")

deepblue_get_request_data(request_id = request_id)

deepblue_info

33

deepblue_info

info

Description

Information about a DeepBlue data identiﬁer (ID). Any DeepBlue data ID can be queried with this
command. For example, it is possible to obtain all available information about an Experiment using
its ID, to obtain the actual Request processing status or the information about a Sample. A user can
obtain information about him- or herself using the value ’me’ in the parameter ’id’. Multiple IDs
can be queried in the same operation.

Usage

deepblue_info(id = NULL, user_key = deepblue_options("user_key"))

Arguments

id

user_key

Value

- A string or a vector of string (ID or an array of IDs)

- A string (users token key)

information - A array or a vector of array (List of Maps, where each map contains the info of an
object.)

See Also

Other Commands for all types of data: deepblue_cancel_request, deepblue_is_biosource,
deepblue_list_in_use, deepblue_name_to_id, deepblue_search

Examples

deepblue_info(id = "e30035")

deepblue_input_regions

input_regions

Description

Upload a set of genomic regions that can be accessed through a query ID. An interesting use case
for this command is to upload a set of custom regions for intersecting with genomic regions in
DeepBlue to speciﬁcally select regions of interest.

Usage

deepblue_input_regions(genome = NULL, region_set = NULL,

user_key = deepblue_options("user_key"))

deepblue_intersection

- A string (the target genome)

- A string (Regions in CHROMOSOME START END format)

- A string (users token key)

34

Arguments

genome

region_set

user_key

Value

id - A string (query id)

See Also

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_flank, deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_intersection,
deepblue_merge_queries, deepblue_overlap, deepblue_query_cache, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

regions_set = "chr1 28735 29810
chr1 135124 135563
chr1 327790 328229
chr1 437151 438164
chr1 449273 450544
chr1 533219 534114
chr1 544738 546649
chr1 713984 714547
chr1 762416 763445
chr1 788863 789211"
deepblue_input_regions(genome = "hg19",

region_set = regions_set)

deepblue_intersection intersection

Description

Select genomic regions that intersect with at least one region of the second query. This command is
a simpliﬁed version of the ’overlap’ command.

Usage

deepblue_intersection(query_data_id = NULL, query_filter_id = NULL,

user_key = deepblue_options("user_key"))

deepblue_is_biosource

Arguments

query_data_id
query_filter_id

- A string (query data that will be ﬁltered.)

35

- A string (query containing the regions that the regions of the query_data_id
must overlap.)

user_key

- A string (users token key)

Value

id - A string (id of the new query)

See Also

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_flank, deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions,
deepblue_merge_queries, deepblue_overlap, deepblue_query_cache, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

annotation_id = deepblue_select_annotations(

annotation_name="CpG Islands",
genome="hg19", chromosome="chr1")
data_id = deepblue_select_experiments(

experiment_name="E002-H3K9ac.narrowPeak.bed")
deepblue_intersection(query_data_id = annotation_id,

query_filter_id = data_id)

deepblue_is_biosource is_biosource

Description

Verify if the name is an existing and valid DeepBlue BioSource name. A BioSource refers to a term
describing the origin of a given sample, such as a tissue or cell line.

Usage

deepblue_is_biosource(biosource = NULL,

user_key = deepblue_options("user_key"))

Arguments

biosource

user_key

Value

- A string (biosource name)

- A string (users token key)

information - A string or a vector of string (A string containing the biosource name)

36

See Also

deepblue_liftover

Other Commands for all types of data: deepblue_cancel_request, deepblue_info, deepblue_list_in_use,
deepblue_name_to_id, deepblue_search

Examples

deepblue_is_biosource(biosource = "blood")

deepblue_liftover

Lift over region results between Genome Assemblies used in DeepBlue

Description

This is a wrapper function for the liftOver function found in the rtracklayer package. For common
genome assemblies available in DeepBlue, this function automatically downloads the necessary
chain ﬁle and calls liftOver.

Usage

deepblue_liftover(regions, source = "hg19", target = "hg38",

collapse = TRUE)

Arguments

regions

source

target

collapse

Value

The GRanges object to lift over to another assembly

The source assembly version, e.g. hg38. If NULL, we try to read the genome
version from the GRanges object.

The target assembly version, e.g. hg19. Required.

Whether to return a single GRanges object or a list of GRanges (one per re-
gion in the input). The latter is the default behavior of liftOver since multiple
assignments are possible.

A GRanges object using the target chromosome positions

Examples

data_id = deepblue_select_experiments(
experiment_name="E002-H3K9ac.narrowPeak.bed", chromosome="chr1")
request_id = deepblue_get_regions(query_id =data_id,

request_data = deepblue_download_request_data(request_id)
deepblue_liftover(request_data, source = "hg38", target = "hg19")

output_format = "CHROMOSOME,START,END")

deepblue_list_annotations

37

deepblue_list_annotations

list_annotations

Description

List all annotations of genomic regions currently available in DeepBlue.

Usage

deepblue_list_annotations(genome = NULL,

user_key = deepblue_options("user_key"))

Arguments

genome

user_key

Value

- A string or a vector of string (the target genome)

- A string (users token key)

annotations - A array (annotations names and IDs)

See Also

Other Inserting and listing annotations: deepblue_find_motif

Examples

deepblue_list_annotations(genome = "hg19")

deepblue_list_biosources

list_biosources

Description

List BioSources included in DeepBlue. A BioSource refers to a term describing the origin of a given
sample, such as a tissue or cell line. It is possible to ﬁlter the BioSources by their extra_metadata
ﬁelds content. These ﬁelds vary depending on the original data source.

Usage

deepblue_list_biosources(extra_metadata = NULL,

user_key = deepblue_options("user_key"))

Arguments

extra_metadata - A struct (Metadata that must be matched)
user_key

- A string (users token key)

38

Value

deepblue_list_column_types

biosources - A array (biosources names and IDS)

See Also

Other Inserting and listing biosources: deepblue_list_similar_biosources

Examples

deepblue_list_biosources(extra_metadata = list(ontology_id = "UBERON:0002485"))

deepblue_list_cached_requests

List cached requests

Description

List cached requests

Usage

deepblue_list_cached_requests()

Value

list of request ids that are cached

Examples

deepblue_list_cached_requests()

deepblue_list_column_types

list_column_types

Description

Lists the ColumnTypes included in DeepBlue.

Usage

deepblue_list_column_types(user_key = deepblue_options("user_key"))

Arguments

user_key

Value

- A string (users token key)

column_types - A array (column types names and IDS)

deepblue_list_epigenetic_marks

39

Examples

deepblue_list_column_types()

deepblue_list_epigenetic_marks

list_epigenetic_marks

Description

List Epigenetic Marks included in DeepBlue. This includes histone marks, DNA methylation, DNA
sensitivity, etc. It is possible to ﬁlter the Epigenetic Marks by their extra_metadata ﬁeld content.

Usage

deepblue_list_epigenetic_marks(extra_metadata = NULL,

user_key = deepblue_options("user_key"))

Arguments

extra_metadata - A struct (Metadata that must be matched)
user_key

- A string (users token key)

Value

epigenetic_marks - A array (epigenetic mark names and IDS)

See Also

Other Inserting and listing epigenetic marks: deepblue_list_similar_epigenetic_marks

Examples

deepblue_list_epigenetic_marks()

deepblue_list_experiments

list_experiments

Description

List the DeepBlue Experiments that matches the search criteria deﬁned by this command parame-
ters.

Usage

deepblue_list_experiments(genome = NULL, type = NULL,

epigenetic_mark = NULL, biosource = NULL, sample = NULL,
technique = NULL, project = NULL,
user_key = deepblue_options("user_key"))

40

Arguments

genome

type
epigenetic_mark

biosource

sample

technique

project

user_key

Value

deepblue_list_expressions

- A string or a vector of string (the target genome)

- A string or a vector of string (type of the experiment: peaks or signal)

- A string or a vector of string (name(s) of selected epigenetic mark(s))

- A string or a vector of string (name(s) of selected biosource(s))

- A string or a vector of string (id(s) of selected sample(s))

- A string or a vector of string (name(s) of selected technique(s))

- A string or a vector of string (name(s) of selected projects)

- A string (users token key)

experiments - A array (experiment names and IDS)

See Also

Other Inserting and listing experiments: deepblue_collection_experiments_count, deepblue_faceting_experiments,
deepblue_list_recent_experiments, deepblue_list_similar_experiments, deepblue_preview_experiment

Examples

deepblue_list_experiments(genome = "hg19", type = "peaks",

epigenetic_mark = "H3K27ac", biosource = "blood")

deepblue_list_expressions

list_expressions

Description

List the Expression currently available in DeepBlue. A expression is a set of data with an identiﬁer
and an expression value.

Usage

deepblue_list_expressions(expression_type = NULL, sample_id = NULL,

replica = NULL, project = NULL, user_key = deepblue_options("user_key"))

Arguments

expression_type

sample_id

replica

project

user_key

- A string (expression type (supported: ’gene’))

- A string or a vector of string (sample ID(s))

- A int or a vector of int (replica(s))

- A string or a vector of string (project(s) name)

- A string (users token key)

41

deepblue_list_genes

Value

expressions - A array (expressions names and IDS)

See Also

Other Expression data: deepblue_select_expressions

Examples

deepblue_list_expressions(expression_type='gene')

deepblue_list_genes

list_genes

Description

List the Genes currently available in DeepBlue.

Usage

deepblue_list_genes(genes = NULL, go_terms = NULL, chromosome = NULL,

start = NULL, end = NULL, gene_model = NULL,
user_key = deepblue_options("user_key"))

Arguments

genes

go_terms
chromosome
start
end
gene_model
user_key

Value

- A string or a vector of string (Name(s) or ENSEMBL ID (ENSGXXXXXXXXXXX.X
) of the gene(s).)
- A string or a vector of string (gene ontology terms - ID or label)
- A string or a vector of string (chromosome name(s))
- A int (minimum start region)
- A int (maximum end region)
- A string (the gene model)
- A string (users token key)

genes - A array (genes names and its content)

See Also

Other Gene models and genes identiﬁers: deepblue_count_gene_ontology_terms, deepblue_list_gene_models,
deepblue_select_genes

Examples

deepblue_list_genes(

chromosome="chr20",
start=10000000,
end=21696620,

gene_model='Gencode v22')

42

deepblue_list_genomes

deepblue_list_gene_models

list_gene_models

Description

List all the Gene Models currently available in DeepBlue. A gene model is a set of genes usually
imported from GENCODE. For example Gencode v22.

Usage

deepblue_list_gene_models(user_key = deepblue_options("user_key"))

Arguments

user_key

Value

- A string (users token key)

gene_models - A array (gene models names and IDS)

See Also

Other Gene models and genes identiﬁers: deepblue_count_gene_ontology_terms, deepblue_list_genes,
deepblue_select_genes

Examples

deepblue_list_gene_models()

deepblue_list_genomes list_genomes

Description

List Genomes assemblies that are registered in DeepBlue.

Usage

deepblue_list_genomes(user_key = deepblue_options("user_key"))

Arguments

user_key

Value

- A string (users token key)

genomes - A array (genome names)

deepblue_list_in_use

See Also

43

Other Inserting and listing genomes: deepblue_chromosomes, deepblue_list_similar_genomes

Examples

deepblue_list_genomes()

deepblue_list_in_use

list_in_use

Description

List all terms used by the Experiments mandatory metadata that have at least one Experiment or
Annotation using them.

Usage

deepblue_list_in_use(controlled_vocabulary = NULL,

user_key = deepblue_options("user_key"))

Arguments

controlled_vocabulary

- A string (controlled vocabulary name)

user_key

- A string (users token key)

Value

terms - A array (controlled_vocabulary terms with count)

See Also

Other Commands for all types of data: deepblue_cancel_request, deepblue_info, deepblue_is_biosource,
deepblue_name_to_id, deepblue_search

Examples

deepblue_list_in_use(controlled_vocabulary = "biosources")

44

deepblue_list_recent_experiments

deepblue_list_projects

list_projects

Description

List Projects included in DeepBlue.

Usage

deepblue_list_projects(user_key = deepblue_options("user_key"))

Arguments

user_key

- A string (users token key)

Value

projects - A array (project names)

See Also

Other Inserting and listing projects: deepblue_list_similar_projects

Examples

deepblue_list_projects()

deepblue_list_recent_experiments

list_recent_experiments

Description

List the latest Experiments included in DeepBlue that match criteria deﬁned in the parameters. The
returned experiments are sorted by insertion date.

Usage

deepblue_list_recent_experiments(days = NULL, genome = NULL,
epigenetic_mark = NULL, sample = NULL, technique = NULL,
project = NULL, user_key = deepblue_options("user_key"))

deepblue_list_requests

Arguments

days

genome
epigenetic_mark

sample

technique

project

user_key

Value

45

- A double (maximum days ago the experiments were added)

- A string or a vector of string (the target genome)

- A string or a vector of string (name(s) of selected epigenetic mark(s))

- A string or a vector of string (id(s) of selected sample(s))

- A string or a vector of string (name(s) of selected technique(es))

- A string or a vector of string (name(s) of selected projects)

- A string (users token key)

experiments - A array (names of recent experiments)

See Also

Other Inserting and listing experiments: deepblue_collection_experiments_count, deepblue_faceting_experiments,
deepblue_list_experiments, deepblue_list_similar_experiments, deepblue_preview_experiment

Examples

deepblue_list_recent_experiments(days = 2, genome = "hg19")

deepblue_list_requests

list_requests

Description

List the Requests made by the user. It is possible to obtain only the requests of a given state.

Usage

deepblue_list_requests(request_state = NULL,
user_key = deepblue_options("user_key"))

Arguments

request_state

- A string (Name of the state to get requests for. The valid states are: new,
running, done, and failed.)

user_key

- A string (users token key)

Value

data_state - A array (Request-IDs and their state)

See Also

Other Requests status information and results: deepblue_get_request_data

46

Examples

deepblue_list_requests(request_state = 'running')

deepblue_list_similar_biosources

deepblue_list_samples list_samples

Description

List Samples included in DeepBlue. It is possible to ﬁlter by the BioSource and by extra_metadata
ﬁelds content.

Usage

deepblue_list_samples(biosource = NULL, extra_metadata = NULL,

user_key = deepblue_options("user_key"))

Arguments

biosource

- A string or a vector of string (name(s) of selected biosource(s))

extra_metadata - A struct (Metadata that must be matched)
user_key

- A string (users token key)

Value

samples - A array (samples id with their content)

Examples

deepblue_list_samples(biosource = "Blood")

deepblue_list_similar_biosources

list_similar_biosources

Description

List all BioSources that have a similar name compared to the provided name. A BioSource refers
to a term describing the origin of a given sample, such as a tissue or cell line. The similarity is
calculated using the Levenshtein method.

Usage

deepblue_list_similar_biosources(name = NULL,
user_key = deepblue_options("user_key"))

deepblue_list_similar_epigenetic_marks

47

Arguments

name

user_key

Value

- A string (biosource name)

- A string (users token key)

biosource - A string (biosource name)

See Also

Other Inserting and listing biosources: deepblue_list_biosources

Examples

deepblue_list_similar_biosources(name = "blood")

deepblue_list_similar_epigenetic_marks

list_similar_epigenetic_marks

Description

List all Epigenetic Marks that have a similar name compared to the provided name. The similarity
is calculated using the Levenshtein method.

Usage

deepblue_list_similar_epigenetic_marks(name = NULL,

user_key = deepblue_options("user_key"))

Arguments

name

user_key

Value

- A string (epigenetic mark name)

- A string (users token key)

epigenetic_marks - A array (similar epigenetic mark names)

See Also

Other Inserting and listing epigenetic marks: deepblue_list_epigenetic_marks

Examples

deepblue_list_similar_epigenetic_marks(name = "H3k27ac")

48

deepblue_list_similar_genomes

deepblue_list_similar_experiments

list_similar_experiments

Description

List all Experiments that have a similar name compared to the provided name. The similarity is
calculated using the Levenshtein method.

Usage

deepblue_list_similar_experiments(name = NULL, genome = NULL,

user_key = deepblue_options("user_key"))

Arguments

name

genome

user_key

Value

- A string (experiment name)

- A string or a vector of string (the target genome)

- A string (users token key)

experiments - A array (similar experiment names)

See Also

Other Inserting and listing experiments: deepblue_collection_experiments_count, deepblue_faceting_experiments,
deepblue_list_experiments, deepblue_list_recent_experiments, deepblue_preview_experiment

Examples

deepblue_list_similar_experiments(name = "blood", genome = "hg19")

deepblue_list_similar_genomes

list_similar_genomes

Description

Lists all Genomes that have a similar name compared to the provided name. The similarity is
calculated using the Levenshtein method.

Usage

deepblue_list_similar_genomes(name = NULL,
user_key = deepblue_options("user_key"))

deepblue_list_similar_projects

49

Arguments

name

user_key

Value

- A string (genome name)

- A string (users token key)

genomes - A array (similar genome names)

See Also

Other Inserting and listing genomes: deepblue_chromosomes, deepblue_list_genomes

Examples

deepblue_list_similar_genomes(name = "grc")

deepblue_list_similar_projects

list_similar_projects

Description

List Projects that have a similar name compared to the provided name. The similarity is calculated
using the Levenshtein method.

Usage

deepblue_list_similar_projects(name = NULL,
user_key = deepblue_options("user_key"))

Arguments

name

user_key

Value

- A string (project name)

- A string (users token key)

projects - A array (similar project names)

See Also

Other Inserting and listing projects: deepblue_list_projects

Examples

deepblue_list_similar_projects(name = "BLUEPRINT")

50

deepblue_list_techniques

deepblue_list_similar_techniques

list_similar_techniques

Description

List Techniques that have a similar name compared to the provided name. The similarity is calcu-
lated using the Levenshtein method.

Usage

deepblue_list_similar_techniques(name = NULL,
user_key = deepblue_options("user_key"))

Arguments

name

user_key

Value

- A string (technique name)

- A string (users token key)

techniques - A array (similar techniques)

See Also

Other Inserting and listing techniques: deepblue_list_techniques

Examples

deepblue_list_similar_techniques(name = "chip seq")

deepblue_list_techniques

list_techniques

Description

List the Techniques included in DeepBlue.

Usage

deepblue_list_techniques(user_key = deepblue_options("user_key"))

Arguments

user_key

Value

- A string (users token key)

techniques - A array (techniques)

deepblue_merge_queries

See Also

Other Inserting and listing techniques: deepblue_list_similar_techniques

Examples

deepblue_list_techniques()

51

deepblue_merge_queries

merge_queries

Description

Merge regions from two queries in a new query.

Usage

deepblue_merge_queries(query_a_id = NULL, query_b_id = NULL,

user_key = deepblue_options("user_key"))

Arguments

query_a_id

query_b_id

- A string (id of the ﬁrst query)

- A string or a vector of string (id of the second query (or use an array to include
multiple queries))

user_key

- A string (users token key)

Value

id - A string (new query id)

See Also

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_flank, deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions,
deepblue_intersection, deepblue_overlap, deepblue_query_cache, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

annotation_id = deepblue_select_annotations(

annotation_name="CpG Islands",
genome="hg19", chromosome="chr1")
data_id = deepblue_select_experiments(

experiment_name="E002-H3K9ac.narrowPeak.bed")

deepblue_merge_queries(

query_a_id = annotation_id,
query_b_id = data_id)

52

deepblue_name_to_id

deepblue_meta_data_to_table

Convert XML structured meta data to table format

Description

Convert XML structured meta data to table format

Usage

deepblue_meta_data_to_table(ids, user_key = deepblue_options("user_key"))

Arguments

ids

user_key

Value

an id or a list of ids

a DeepBlue user key (optional for public data)

a data frame with meta data

Examples

#works for sample ids
deepblue_meta_data_to_table(list("s2694", "s2695"))

#or experiment ids
deepblue_meta_data_to_table(list("e30035", "e30036"))

deepblue_name_to_id

name_to_id

Description

Obtain the data ID(s) from the informed data name(s).

Usage

deepblue_name_to_id(name = NULL, collection = NULL,

user_key = deepblue_options("user_key"))

Arguments

name

collection

user_key

Value

- A string or a vector of string (ID or an array of IDs)

- A string (Collection where the data name is in )

- A string (users token key)

information - A array or a vector of array (List of IDs.)

deepblue_options

See Also

53

Other Commands for all types of data: deepblue_cancel_request, deepblue_info, deepblue_is_biosource,
deepblue_list_in_use, deepblue_search

Examples

deepblue_name_to_id("E002-H3K9ac.narrowPeak.bed", "experiments")
deepblue_name_to_id("prostate duct", "biosources")
deepblue_name_to_id("DNA Methylation", "Epigenetic_marks")

deepblue_options

options

Description

options manager from the settings package

Usage

deepblue_options(..., .__defaults = FALSE, .__reset = FALSE)

Arguments

...

.__defaults

.__reset

Value

default options

list of new options

disallowed option

disallowed option

deepblue_overlap

overlap

Description

Select genomic regions that overlap or not overlap with with the speciﬁed number of regions of the
second query. Important: This command is still experimental and changes may occour.

Usage

deepblue_overlap(query_data_id = NULL, query_filter_id = NULL,

overlap = NULL, amount = NULL, amount_type = NULL,
user_key = deepblue_options("user_key"))

54

Arguments

query_data_id

query_filter_id

- A string (query data that will be ﬁltered.)

deepblue_preview_experiment

- A string (query containing the regions that the regions of the query_data_id
must overlap.)

- A boolean (True if must overlap, or false if must not overlap.)

- A int (Amount of regions that must overlap. Use the parameter ’amount_type’
(’bp’ or ’%’) to specify the unit. For example, use the value ’10’ with the
amount_type ’%’ to specify that 10% of the bases in both regions must over-
lap, or use ’10’ with the amount_type ’bp’ to specify that at least 10 bases must
or must not overlap.)

- A string (Type of the amount: ’bp’ for base pairs and ’%’ for percentage. )

- A string (users token key)

overlap

amount

amount_type

user_key

Value

id - A string (id of the new query)

See Also

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_flank, deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions,
deepblue_intersection, deepblue_merge_queries, deepblue_query_cache, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

annotation_id = deepblue_select_annotations(

annotation_name="CpG Islands",
genome="hg19", chromosome="chr1")

experiment_id = deepblue_select_experiments(

experiment_name="S00XDKH1.ERX712765.H3K27ac.bwa.GRCh38.20150527.bed")

deepblue_overlap(query_data_id = experiment_id, query_filter_id = annotation_id,

overlap = TRUE, amount=10, amount_type="%")

deepblue_preview_experiment

preview_experiment

Description

List the DeepBlue Experiments that matches the search criteria deﬁned by this command parame-
ters.

55

deepblue_query_cache

Usage

deepblue_preview_experiment(experiment_name = NULL,

user_key = deepblue_options("user_key"))

Arguments

experiment_name

- A string (name(s) of selected experiment(s))

user_key

- A string (users token key)

Value

experiment - A string (experiment’s regions)

See Also

Other Inserting and listing experiments: deepblue_collection_experiments_count, deepblue_faceting_experiments,
deepblue_list_experiments, deepblue_list_recent_experiments, deepblue_list_similar_experiments

Examples

deepblue_preview_experiment('S00JJRH1.ERX683143.H3K4me3.bwa.GRCh38.20150527.bed')

deepblue_query_cache

query_cache

Description

Cache a query result in DeepBlue memory. This command is useful when the same query ID is
used multiple times in different requests. The command is an advice for DeepBlue to cache the
query result and there is no guarantee that this query data access will be faster.

Usage

deepblue_query_cache(query_id = NULL, cache = NULL,

user_key = deepblue_options("user_key"))

Arguments

query_id

cache

user_key

Value

- A string (Query ID)

- A boolean (set or unset this query caching)

- A string (users token key)

information - A string (New query ID.)

56

See Also

deepblue_query_experiment_type

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_flank, deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions,
deepblue_intersection, deepblue_merge_queries, deepblue_overlap, deepblue_query_experiment_type,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

annotation_id = deepblue_select_annotations(

annotation_name="CpG Islands",
genome="hg19", chromosome="chr1")
data_id = deepblue_select_experiments(

experiment_name="E002-H3K9ac.narrowPeak.bed")

merged_regions = deepblue_merge_queries(

query_a_id = annotation_id,
query_b_id = data_id)

deepblue_query_cache(

query_id = merged_regions, cache = TRUE)

deepblue_query_experiment_type

query_experiment_type

Description

Filter the query ID for regions associated with experiments of a given type. For example, it is
possible to select only peaks using this command with the ’peaks’ parameter.

Usage

deepblue_query_experiment_type(query_id = NULL, type = NULL,

user_key = deepblue_options("user_key"))

Arguments

query_id

type

user_key

Value

- A string (Query ID)

- A string (experiment type (peaks or signal))

- A string (users token key)

information - A string (New query ID.)

deepblue_reset_options

See Also

57

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_flank, deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions,
deepblue_intersection, deepblue_merge_queries, deepblue_overlap, deepblue_query_cache,
deepblue_score_matrix, deepblue_select_annotations, deepblue_select_experiments, deepblue_select_regions,
deepblue_tiling_regions

Examples

h3k27ac_regions = deepblue_select_regions(

genome ='GRCh38',
epigenetic_mark ='H3k27ac',
project ='BLUEPRINT Epigenome',
chromosome ='chr1')

deepblue_query_experiment_type(
query_id = h3k27ac_regions,
type = "peaks")

deepblue_reset_options

Reset DeepBlueR options

Description

Reset DeepBlueR options

Usage

deepblue_reset_options(new_options = NULL)

Arguments

new_options

list of new options that should be used. default options if NULL

Value

new (default) options

Examples

deepblue_reset_options()

58

deepblue_score_matrix

deepblue_score_matrix score_matrix

Description

Build a matrix containing the aggregation result of the the experiments data by the aggregation
boundaries.

Usage

deepblue_score_matrix(experiments_columns = NULL,

aggregation_function = NULL, aggregation_regions_id = NULL,
user_key = deepblue_options("user_key"))

Arguments

experiments_columns

- A struct (map with experiments names and columns to be processed. Exam-
ple : ’wgEncodeBroadHistoneDnd41H3k27acSig.wig’:’VALUE’, ’wgEncode-
BroadHistoneCd20ro01794H3k27acSig.wig’:’VALUE’)

aggregation_function

- A string (aggregation function name: min, max, sum, mean, var, sd, median,
count, boolean)

aggregation_regions_id

- A string (query ID of the regions that will be used as the aggregation bound-
aries)

user_key

- A string (users token key)

Value

score_matrix - A string (the score matrix containing the summarized data)

See Also

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_flank, deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions,
deepblue_intersection, deepblue_merge_queries, deepblue_overlap, deepblue_query_cache,
deepblue_query_experiment_type, deepblue_select_annotations, deepblue_select_experiments,
deepblue_select_regions, deepblue_tiling_regions

Examples

tiling_regions = deepblue_tiling_regions(

size=100000, genome="mm10", chromosome="chr1")

deepblue_score_matrix(

experiments_columns =

list(ENCFF721EKA="VALUE", ENCFF781VVH="VALUE"),

aggregation_function = "mean",
aggregation_regions_id = tiling_regions)

deepblue_search

59

deepblue_search

search

Description

Search all data of all types for the given keyword. A minus (-) character in front of a keyword
searches for data without the given keyword. The search can be restricted to the following data
types are: Annotations, Biosources, Column_types, Epigenetic_marks, Experiments, Genomes,
Gene_models, Gene_expressions, Genes, Gene_ontology, Projects, Samples, Techniques, Tilings.

Usage

deepblue_search(keyword = NULL, type = NULL,
user_key = deepblue_options("user_key"))

Arguments

keyword

type

- A string (keyword to search by)

- A string or a vector of string (type of data to search for - Annotations, Biosources,
Column_types, Epigenetic_marks, Experiments, Genomes, Gene_models, Gene_expressions,
Genes, Gene_ontology, Projects, Samples, Techniques, Tilings)

user_key

- A string (users token key)

Value

results - A array (search results as [id, name, type])

See Also

Other Commands for all types of data: deepblue_cancel_request, deepblue_info, deepblue_is_biosource,
deepblue_list_in_use, deepblue_name_to_id

Examples

deepblue_search(keyword = "DNA Methylation BLUEPRINT",

type = "experiments")

deepblue_select_annotations

select_annotations

Description

Select regions from the Annotations that match the selection criteria.

Usage

deepblue_select_annotations(annotation_name = NULL, genome = NULL,

chromosome = NULL, start = NULL, end = NULL,
user_key = deepblue_options("user_key"))

60

Arguments

annotation_name

genome

chromosome

start

end

user_key

deepblue_select_column

- A string or a vector of string (name(s) of selected annotation(s))

- A string (the target genome)

- A string or a vector of string (chromosome name(s))

- A int (minimum start region)

- A int (maximum end region)

- A string (users token key)

Value

id - A string (query id)

See Also

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_flank, deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions,
deepblue_intersection, deepblue_merge_queries, deepblue_overlap, deepblue_query_cache,
deepblue_query_experiment_type, deepblue_score_matrix, deepblue_select_experiments,
deepblue_select_regions, deepblue_tiling_regions

Examples

deepblue_select_annotations(

annotation_name = "Cpg Islands",
genome = "hg19",
chromosome = "chr1",
start = 0,
end = 2000000)

deepblue_select_column

select column

Description

A utility command that creates a list of experiments in which a speciﬁc column is selected. Such a
list is needed as input for deepblue_score_matrix.

Usage

deepblue_select_column(experiments, column,
user_key = deepblue_options("user_key"))

Arguments

experiments

column

user_key

- A data frame with experiments obtained from deepblue_list_experiments

- The name of the column that is extracted from each experiment ﬁle

- A string (users token key)

deepblue_select_experiments

61

Value

A list of experiments with the selected column

See Also

deepblue_score_matrix

deepblue_list_experiments

Other Utilities for information processing: deepblue_diff

Examples

blueprint_DNA_meth <- deepblue_list_experiments(
genome = "GRCh38",
epigenetic_mark = "DNA Methylation",
technique = "Bisulfite-Seq",
project = "BLUEPRINT EPIGENOME")

blueprint_DNA_meth <- blueprint_DNA_meth[grep("bs_call",

deepblue_extract_names(blueprint_DNA_meth)),]

exp_columns <- deepblue_select_column(blueprint_DNA_meth, "VALUE")

deepblue_select_experiments

select_experiments

Description

Selects regions from Experiments by the experiments names.

Usage

deepblue_select_experiments(experiment_name = NULL, chromosome = NULL,
start = NULL, end = NULL, user_key = deepblue_options("user_key"))

Arguments

experiment_name

chromosome

start

end

user_key

- A string or a vector of string (name(s) of selected experiment(s))

- A string or a vector of string (chromosome name(s))

- A int (minimum start region)

- A int (maximum end region)

- A string (users token key)

Value

id - A string (query id)

62

See Also

deepblue_select_expressions

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_flank, deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions,
deepblue_intersection, deepblue_merge_queries, deepblue_overlap, deepblue_query_cache,
deepblue_query_experiment_type, deepblue_score_matrix, deepblue_select_annotations,
deepblue_select_regions, deepblue_tiling_regions

Examples

deepblue_select_experiments(
experiment_name = c("E002-H3K9ac.narrowPeak.bed",
"E001-H3K4me3.gappedPeak.bed")
)

deepblue_select_expressions

select_expressions

Description

Select expressions (by their name or ID) as genomic regions from the speciﬁed model.

Usage

deepblue_select_expressions(expression_type = NULL, sample_ids = NULL,

replicas = NULL, identifiers = NULL, projects = NULL,
gene_model = NULL, user_key = deepblue_options("user_key"))

Arguments

expression_type

sample_ids

replicas

identifiers

projects

gene_model

user_key

- A string (expression type (supported: ’gene’))

- A string or a vector of string (id(s) of selected sample(s))

- A int or a vector of int (replica(s))

- A string or a vector of string (identiﬁer(s) (for genes: ensembl ID or ENSB
name).)

- A string or a vector of string (projects(s))

- A string (gene model name)

- A string (users token key)

Value

id - A string (query id)

See Also

Other Expression data: deepblue_list_expressions

deepblue_select_genes

Examples

genes_names =

c('CCR1', 'CD164', 'CD1D', 'CD2', 'CD34', 'CD3G', 'CD44')

deepblue_select_expressions(
expression_type="gene",
sample_ids="s10205",
identifiers = genes_names,
gene_model = "gencode v23")

63

deepblue_select_genes select_genes

Description

Select genes (by their name or ID) as genomic regions from the speciﬁed gene model.

Usage

deepblue_select_genes(genes = NULL, go_terms = NULL, gene_model = NULL,

chromosome = NULL, start = NULL, end = NULL,
user_key = deepblue_options("user_key"))

Arguments

genes

go_terms

gene_model

chromosome

start

end

user_key

- A string or a vector of string (Name(s) or ENSEMBL ID (ENSGXXXXXXXXXXX.X
) of the gene(s).)

- A string or a vector of string (gene ontology terms - ID or label)

- A string (the gene model)

- A string or a vector of string (chromosome name(s))

- A int (minimum start region)

- A int (maximum end region)

- A string (users token key)

Value

id - A string (query id)

See Also

Other Gene models and genes identiﬁers: deepblue_count_gene_ontology_terms, deepblue_list_gene_models,
deepblue_list_genes

Examples

genes_names =

c('CCR1', 'CD164', 'CD1D', 'CD2', 'CD34', 'CD3G', 'CD44')

deepblue_select_genes(

genes = genes_names,
gene_model = "gencode v23")

64

deepblue_select_regions

deepblue_select_regions

select_regions

Description

Selects Experiment regions that matches the criteria informed by the operation parameters.

Usage

deepblue_select_regions(experiment_name = NULL, genome = NULL,
epigenetic_mark = NULL, sample_id = NULL, technique = NULL,
project = NULL, chromosomes = NULL, start = NULL, end = NULL,
user_key = deepblue_options("user_key"))

Arguments

experiment_name

genome
epigenetic_mark

sample_id

technique

project

chromosomes

start

end

user_key

- A string or a vector of string (name(s) of selected experiment(s))

- A string or a vector of string (the target genome)

- A string or a vector of string (name(s) of selected epigenetic mark(s))

- A string or a vector of string (id(s) of selected sample(s))

- A string or a vector of string (name(s) of selected technique(es))

- A string or a vector of string (name(s) of selected projects)

- A string or a vector of string (chromosome name(s))

- A int (minimum start region)

- A int (maximum end region)

- A string (users token key)

Value

id - A string (query id)

See Also

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_flank, deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions,
deepblue_intersection, deepblue_merge_queries, deepblue_overlap, deepblue_query_cache,
deepblue_query_experiment_type, deepblue_score_matrix, deepblue_select_annotations,
deepblue_select_experiments, deepblue_tiling_regions

Examples

deepblue_select_regions(
genome="hg19",
epigenetic_mark = "H3K27ac",
project = " BLUEPRINT Epigenome")

deepblue_tiling_regions

65

deepblue_tiling_regions

tiling_regions

Description

Generate tiling regions across the genome chromosomes. The idea is to "bin" genomic regions sys-
tematically in order to obtain discrete regions over which one can aggregate. Using the ’score_matrix’
command, these bins (tiles) can be compared directly across experiments.

Usage

deepblue_tiling_regions(size = NULL, genome = NULL, chromosome = NULL,

user_key = deepblue_options("user_key"))

Arguments

size

genome

chromosome

user_key

Value

- A int (tiling size)

- A string (the target genome)

- A string or a vector of string (chromosome name(s))

- A string (users token key)

id - A string (query id)

See Also

Other Operating on the data regions: deepblue_aggregate, deepblue_binning, deepblue_count_regions,
deepblue_coverage, deepblue_distinct_column_values, deepblue_extend, deepblue_filter_regions,
deepblue_flank, deepblue_get_experiments_by_query, deepblue_get_regions, deepblue_input_regions,
deepblue_intersection, deepblue_merge_queries, deepblue_overlap, deepblue_query_cache,
deepblue_query_experiment_type, deepblue_score_matrix, deepblue_select_annotations,
deepblue_select_experiments, deepblue_select_regions

Examples

deepblue_tiling_regions(

size = 10000,
genome = "hg19",
chromosome = "chr1")

66

deepblue_wait_request

deepblue_wait_request deepblue_wait_request

Description

Process the user request. Takes in three parameters; requested regions, sleep time, and user key.

Usage

deepblue_wait_request(request_id, sleep_time = 1,

user_key = deepblue_options("user_key"))

Arguments

request_id

sleep_time

user_key

Value

request_id info

A string with the request_id

An integer with default value 1s

A string

Index

deepblue_aggregate, 4, 6, 11, 12, 14, 22, 25,
26, 31, 34, 35, 51, 54, 56–58, 60, 62,
64, 65

deepblue_batch_export_results, 5
deepblue_binning, 4, 5, 11, 12, 14, 22, 25,

26, 31, 34, 35, 51, 54, 56–58, 60, 62,
64, 65
deepblue_cache_status, 6
deepblue_cancel_request, 7, 33, 36, 43, 53,

59

deepblue_chromosomes, 7, 43, 49
deepblue_clear_cache, 8
deepblue_collection_experiments_count,

8, 24, 40, 45, 48, 55

deepblue_commands, 9, 16
deepblue_count_gene_ontology_terms, 10,

41, 42, 63

deepblue_count_regions, 4, 6, 11, 12, 14,

22, 25, 26, 31, 34, 35, 51, 54, 56–58,
60, 62, 64, 65

deepblue_coverage, 4, 6, 11, 11, 14, 22, 25,
26, 31, 34, 35, 51, 54, 56–58, 60, 62,
64, 65

deepblue_delete_request_from_cache, 12
deepblue_diff, 13, 61
deepblue_distinct_column_values, 4, 6,

11, 12, 13, 22, 25, 26, 31, 34, 35, 51,
54, 56–58, 60, 62, 64, 65

deepblue_extract_ids, 22, 23
deepblue_extract_names, 22, 23
deepblue_faceting_experiments, 9, 23, 40,

45, 48, 55

deepblue_filter_regions, 4, 6, 11, 12, 14,
22, 24, 26, 31, 34, 35, 51, 54, 56–58,
60, 62, 64, 65
deepblue_find_motif, 25, 37
deepblue_flank, 4, 6, 11, 12, 14, 22, 25, 26,
31, 34, 35, 51, 54, 56–58, 60, 62, 64,
65

deepblue_format_object_size, 27
deepblue_get_biosource_children, 27,

28–30

deepblue_get_biosource_parents, 28, 28,

29, 30

deepblue_get_biosource_related, 28, 29,

30

deepblue_get_biosource_synonyms, 28, 29,

29
deepblue_get_db, 30
deepblue_get_experiments_by_query, 4, 6,
11, 12, 14, 22, 25, 26, 30, 31, 34, 35,
51, 54, 56–58, 60, 62, 64, 65

deepblue_get_regions, 4, 6, 11, 12, 14, 22,
25, 26, 31, 31, 34, 35, 51, 54, 56–58,
60, 62, 64, 65

deepblue_get_request_data, 32, 45
deepblue_info, 7, 33, 36, 43, 53, 59
deepblue_input_regions, 4, 6, 11, 12, 14,

deepblue_download_request_data, 14
deepblue_download_request_data,DeepBlueCommand-method,

15
deepblue_echo, 9, 15
deepblue_enrich_regions_fast, 16, 17, 18
deepblue_enrich_regions_go_terms, 16,

17, 18

deepblue_enrich_regions_overlap, 16, 17,

18

deepblue_export_bed, 19
deepblue_export_meta_data, 20
deepblue_export_tab, 20
deepblue_extend, 4, 6, 11, 12, 14, 21, 25, 26,
31, 34, 35, 51, 54, 56–58, 60, 62, 64,
65

22, 25, 26, 31, 33, 35, 51, 54, 56–58,
60, 62, 64, 65

deepblue_intersection, 4, 6, 11, 12, 14, 22,
25, 26, 31, 34, 34, 51, 54, 56–58, 60,
62, 64, 65

deepblue_is_biosource, 7, 33, 35, 43, 53, 59
deepblue_liftover, 36
deepblue_list_annotations, 26, 37
deepblue_list_biosources, 37, 47
deepblue_list_cached_requests, 38
deepblue_list_column_types, 38
deepblue_list_epigenetic_marks, 39, 47
deepblue_list_experiments, 9, 24, 39, 45,

67

68

INDEX

deepblue_select_genes, 10, 41, 42, 63
deepblue_select_regions, 4, 6, 11, 12, 14,
22, 25, 26, 31, 34, 35, 51, 54, 56–58,
60, 62, 64, 65

deepblue_tiling_regions, 4, 6, 11, 12, 14,
22, 25, 26, 31, 34, 35, 51, 54, 56–58,
60, 62, 64, 65

deepblue_wait_request, 66
DeepBlueCommand

(DeepBlueCommand-class), 3

DeepBlueCommand-class, 3

48, 55, 61

deepblue_list_expressions, 40, 62
deepblue_list_gene_models, 10, 41, 42, 63
deepblue_list_genes, 10, 41, 42, 63
deepblue_list_genomes, 8, 42, 49
deepblue_list_in_use, 7, 33, 36, 43, 53, 59
deepblue_list_projects, 44, 49
deepblue_list_recent_experiments, 9, 24,

40, 44, 48, 55
deepblue_list_requests, 32, 45
deepblue_list_samples, 46
deepblue_list_similar_biosources, 38,

46

deepblue_list_similar_epigenetic_marks,

39, 47

deepblue_list_similar_experiments, 9,

24, 40, 45, 48, 55

deepblue_list_similar_genomes, 8, 43, 48
deepblue_list_similar_projects, 44, 49
deepblue_list_similar_techniques, 50,

51

deepblue_list_techniques, 50, 50
deepblue_merge_queries, 4, 6, 11, 12, 14,

22, 25, 26, 31, 34, 35, 51, 54, 56–58,
60, 62, 64, 65

deepblue_meta_data_to_table, 52
deepblue_name_to_id, 7, 33, 36, 43, 52, 59
deepblue_options, 53
deepblue_overlap, 4, 6, 11, 12, 14, 22, 25,

26, 31, 34, 35, 51, 53, 56–58, 60, 62,
64, 65

deepblue_preview_experiment, 9, 24, 40,

45, 48, 54

deepblue_query_cache, 4, 6, 11, 12, 14, 22,
25, 26, 31, 34, 35, 51, 54, 55, 57, 58,
60, 62, 64, 65

deepblue_query_experiment_type, 4, 6, 11,
12, 14, 22, 25, 26, 31, 34, 35, 51, 54,
56, 56, 58, 60, 62, 64, 65

deepblue_reset_options, 57
deepblue_score_matrix, 4, 6, 11, 12, 14, 22,
25, 26, 31, 34, 35, 51, 54, 56, 57, 58,
60–62, 64, 65

deepblue_search, 7, 33, 36, 43, 53, 59
deepblue_select_annotations, 4, 6, 11, 12,

14, 22, 25, 26, 31, 34, 35, 51, 54,
56–58, 59, 62, 64, 65

deepblue_select_column, 13, 60
deepblue_select_experiments, 4, 6, 11, 12,

14, 22, 25, 26, 31, 34, 35, 51, 54,
56–58, 60, 61, 64, 65
deepblue_select_expressions, 41, 62

