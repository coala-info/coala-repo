Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[PopPUNK 2.7.0 documentation](index.html)

[![Logo](_static/poppunk_v2.png)

PopPUNK 2.7.0 documentation](index.html)

Contents:

* [PopPUNK documentation](index.html)
* [Installation](installation.html)
* [Overview](overview.html)
* [Sketching (`--create-db`)](sketching.html)
* [Data quality control (`--qc-db`)](qc.html)
* [Fitting new models (`--fit-model`)](model_fitting.html)
* [Distributing PopPUNK models](model_distribution.html)
* [Query assignment (`poppunk_assign`)](query_assignment.html)
* [Creating visualisations](visualisation.html)
* [Minimum spanning trees](mst.html)
* [Subclustering with PopPIPE](subclustering.html)
* [Using GPUs](gpu.html)
* [Troubleshooting](troubleshooting.html)
* [Scripts](scripts.html)
* [Iterative PopPUNK](poppunk_iterate.html)
* [Citing PopPUNK](citing.html)
* [Reference documentation](api.html)
* [Roadmap](roadmap.html)
* [Miscellaneous](miscellaneous.html)

Back to top

# Index

[**A**](#A) | [**B**](#B) | [**C**](#C) | [**D**](#D) | [**E**](#E) | [**F**](#F) | [**G**](#G) | [**H**](#H) | [**I**](#I) | [**J**](#J) | [**L**](#L) | [**M**](#M) | [**N**](#N) | [**O**](#O) | [**P**](#P) | [**Q**](#Q) | [**R**](#R) | [**S**](#S) | [**T**](#T) | [**U**](#U) | [**V**](#V) | [**W**](#W)

## A

|  |  |
| --- | --- |
| * [addQueryToNetwork() (in module PopPUNK.network)](api.html#PopPUNK.network.addQueryToNetwork) * [addRandom() (in module PopPUNK.sketchlib)](api.html#PopPUNK.sketchlib.addRandom) * [api() (in module PopPUNK.web)](api.html#PopPUNK.web.api) * [apply\_threshold() (PopPUNK.models.RefineFit method)](api.html#PopPUNK.models.RefineFit.apply_threshold) * [assign() (PopPUNK.models.BGMMFit method)](api.html#PopPUNK.models.BGMMFit.assign)   + [(PopPUNK.models.DBSCANFit method)](api.html#PopPUNK.models.DBSCANFit.assign)   + [(PopPUNK.models.LineageFit method)](api.html#PopPUNK.models.LineageFit.assign)   + [(PopPUNK.models.RefineFit method)](api.html#PopPUNK.models.RefineFit.assign) | * [assign\_query() (in module PopPUNK.assign)](api.html#PopPUNK.assign.assign_query) * [assign\_query\_hdf5() (in module PopPUNK.assign)](api.html#PopPUNK.assign.assign_query_hdf5) * [assign\_samples() (in module PopPUNK.models)](api.html#PopPUNK.models.assign_samples) |

## B

|  |
| --- |
| * [BGMMFit (class in PopPUNK.models)](api.html#PopPUNK.models.BGMMFit) |

## C

|  |  |
| --- | --- |
| * [calc\_prevalence() (in module PopPUNK.web)](api.html#PopPUNK.web.calc_prevalence) * [check\_and\_set\_gpu() (in module PopPUNK.utils)](api.html#PopPUNK.utils.check_and_set_gpu) * [check\_search\_range() (in module PopPUNK.refine)](api.html#PopPUNK.refine.check_search_range) * [checkNetworkVertexCount() (in module PopPUNK.network)](api.html#PopPUNK.network.checkNetworkVertexCount) * [checkSketchlibLibrary() (in module PopPUNK.sketchlib)](api.html#PopPUNK.sketchlib.checkSketchlibLibrary) * [checkSketchlibVersion() (in module PopPUNK.sketchlib)](api.html#PopPUNK.sketchlib.checkSketchlibVersion) * [cliquePrune() (in module PopPUNK.network)](api.html#PopPUNK.network.cliquePrune) * [ClusterFit (class in PopPUNK.models)](api.html#PopPUNK.models.ClusterFit) * [construct\_dense\_weighted\_network() (in module PopPUNK.network)](api.html#PopPUNK.network.construct_dense_weighted_network) | * [construct\_network\_from\_assignments() (in module PopPUNK.network)](api.html#PopPUNK.network.construct_network_from_assignments) * [construct\_network\_from\_df() (in module PopPUNK.network)](api.html#PopPUNK.network.construct_network_from_df) * [construct\_network\_from\_edge\_list() (in module PopPUNK.network)](api.html#PopPUNK.network.construct_network_from_edge_list) * [construct\_network\_from\_sparse\_matrix() (in module PopPUNK.network)](api.html#PopPUNK.network.construct_network_from_sparse_matrix) * [constructDatabase() (in module PopPUNK.sketchlib)](api.html#PopPUNK.sketchlib.constructDatabase) * [copy() (PopPUNK.models.ClusterFit method)](api.html#PopPUNK.models.ClusterFit.copy) * [createDatabaseDir() (in module PopPUNK.sketchlib)](api.html#PopPUNK.sketchlib.createDatabaseDir) * [createMicroreact() (in module PopPUNK.plot)](api.html#PopPUNK.plot.createMicroreact) * [cugraph\_to\_graph\_tool() (in module PopPUNK.network)](api.html#PopPUNK.network.cugraph_to_graph_tool) |

## D

|  |  |
| --- | --- |
| * [DBSCANFit (class in PopPUNK.models)](api.html#PopPUNK.models.DBSCANFit) * [decisionBoundary() (in module PopPUNK.utils)](api.html#PopPUNK.utils.decisionBoundary) * [distHistogram() (in module PopPUNK.plot)](api.html#PopPUNK.plot.distHistogram) | * [drawMST() (in module PopPUNK.plot)](api.html#PopPUNK.plot.drawMST) * [dtype (PopPUNK.models.NumpyShared attribute)](api.html#PopPUNK.models.NumpyShared.dtype)   + [(PopPUNK.refine.NumpyShared attribute)](api.html#PopPUNK.refine.NumpyShared.dtype) |

## E

|  |  |
| --- | --- |
| * [edge\_weights() (PopPUNK.models.LineageFit method)](api.html#PopPUNK.models.LineageFit.edge_weights) * [evaluate\_dbscan\_clusters() (in module PopPUNK.dbscan)](api.html#PopPUNK.dbscan.evaluate_dbscan_clusters) | * [expand\_cugraph\_network() (in module PopPUNK.refine)](api.html#PopPUNK.refine.expand_cugraph_network) * [extend() (PopPUNK.models.LineageFit method)](api.html#PopPUNK.models.LineageFit.extend) * [extractReferences() (in module PopPUNK.network)](api.html#PopPUNK.network.extractReferences) |

## F

|  |  |
| --- | --- |
| * [fastPrune() (in module PopPUNK.network)](api.html#PopPUNK.network.fastPrune) * [fetchNetwork() (in module PopPUNK.network)](api.html#PopPUNK.network.fetchNetwork) * [findBetweenLabel() (in module PopPUNK.dbscan)](api.html#PopPUNK.dbscan.findBetweenLabel) * [findBetweenLabel\_bgmm() (in module PopPUNK.bgmm)](api.html#PopPUNK.bgmm.findBetweenLabel_bgmm) * [findWithinLabel() (in module PopPUNK.bgmm)](api.html#PopPUNK.bgmm.findWithinLabel) * [fit() (PopPUNK.models.BGMMFit method)](api.html#PopPUNK.models.BGMMFit.fit)   + [(PopPUNK.models.ClusterFit method)](api.html#PopPUNK.models.ClusterFit.fit)   + [(PopPUNK.models.DBSCANFit method)](api.html#PopPUNK.models.DBSCANFit.fit)   + [(PopPUNK.models.LineageFit method)](api.html#PopPUNK.models.LineageFit.fit)   + [(PopPUNK.models.RefineFit method)](api.html#PopPUNK.models.RefineFit.fit) | * [fit2dMultiGaussian() (in module PopPUNK.bgmm)](api.html#PopPUNK.bgmm.fit2dMultiGaussian) * [fitDbScan() (in module PopPUNK.dbscan)](api.html#PopPUNK.dbscan.fitDbScan) * [fitKmerCurve() (in module PopPUNK.sketchlib)](api.html#PopPUNK.sketchlib.fitKmerCurve) |

## G

|  |  |
| --- | --- |
| * [generate\_cugraph() (in module PopPUNK.network)](api.html#PopPUNK.network.generate_cugraph) * [generate\_embedding() (in module PopPUNK.mandrake)](api.html#PopPUNK.mandrake.generate_embedding) * [generate\_minimum\_spanning\_tree() (in module PopPUNK.network)](api.html#PopPUNK.network.generate_minimum_spanning_tree) * [generate\_network\_from\_distances() (in module PopPUNK.network)](api.html#PopPUNK.network.generate_network_from_distances) * [get\_database\_statistics() (in module PopPUNK.sketchlib)](api.html#PopPUNK.sketchlib.get_database_statistics) * [get\_grid() (in module PopPUNK.plot)](api.html#PopPUNK.plot.get_grid) | * [get\_vertex\_list() (in module PopPUNK.network)](api.html#PopPUNK.network.get_vertex_list) * [getCliqueRefs() (in module PopPUNK.network)](api.html#PopPUNK.network.getCliqueRefs) * [getKmersFromReferenceDatabase() (in module PopPUNK.sketchlib)](api.html#PopPUNK.sketchlib.getKmersFromReferenceDatabase) * [getSeqsInDb() (in module PopPUNK.sketchlib)](api.html#PopPUNK.sketchlib.getSeqsInDb) * [getSketchSize() (in module PopPUNK.sketchlib)](api.html#PopPUNK.sketchlib.getSketchSize) * [graphml\_to\_json() (in module PopPUNK.web)](api.html#PopPUNK.web.graphml_to_json) * [growNetwork() (in module PopPUNK.refine)](api.html#PopPUNK.refine.growNetwork) |

## H

|  |
| --- |
| * [highlight\_cluster() (in module PopPUNK.web)](api.html#PopPUNK.web.highlight_cluster) |

## I

|  |  |
| --- | --- |
| * [isolateNameToLabel() (in module PopPUNK.utils)](api.html#PopPUNK.utils.isolateNameToLabel) | * [iterDistRows() (in module PopPUNK.utils)](api.html#PopPUNK.utils.iterDistRows) |

## J

|  |  |
| --- | --- |
| * [joinClusterDicts() (in module PopPUNK.utils)](api.html#PopPUNK.utils.joinClusterDicts) | * [joinDBs() (in module PopPUNK.sketchlib)](api.html#PopPUNK.sketchlib.joinDBs) |

## L

|  |  |
| --- | --- |
| * [likelihoodBoundary() (in module PopPUNK.refine)](api.html#PopPUNK.refine.likelihoodBoundary) * [LineageFit (class in PopPUNK.models)](api.html#PopPUNK.models.LineageFit) * [listDistInts() (in module PopPUNK.utils)](api.html#PopPUNK.utils.listDistInts) * [load() (PopPUNK.models.BGMMFit method)](api.html#PopPUNK.models.BGMMFit.load)   + [(PopPUNK.models.DBSCANFit method)](api.html#PopPUNK.models.DBSCANFit.load)   + [(PopPUNK.models.LineageFit method)](api.html#PopPUNK.models.LineageFit.load)   + [(PopPUNK.models.RefineFit method)](api.html#PopPUNK.models.RefineFit.load) | * [load\_network\_file() (in module PopPUNK.network)](api.html#PopPUNK.network.load_network_file) * [loadClusterFit() (in module PopPUNK.models)](api.html#PopPUNK.models.loadClusterFit) * [log\_likelihood() (in module PopPUNK.bgmm)](api.html#PopPUNK.bgmm.log_likelihood) * [log\_multivariate\_normal\_density() (in module PopPUNK.bgmm)](api.html#PopPUNK.bgmm.log_multivariate_normal_density) |

## M

|  |  |
| --- | --- |
| * [main() (in module PopPUNK.assign)](api.html#PopPUNK.assign.main)   + [(in module PopPUNK.visualise)](api.html#PopPUNK.visualise.main) * module   + [PopPUNK.assign](api.html#module-PopPUNK.assign)   + [PopPUNK.bgmm](api.html#module-PopPUNK.bgmm)   + [PopPUNK.dbscan](api.html#module-PopPUNK.dbscan)   + [PopPUNK.mandrake](api.html#module-PopPUNK.mandrake)   + [PopPUNK.models](api.html#module-PopPUNK.models)   + [PopPUNK.network](api.html#module-PopPUNK.network)   + [PopPUNK.plot](api.html#module-PopPUNK.plot)   + [PopPUNK.refine](api.html#module-PopPUNK.refine)   + [PopPUNK.sketchlib](api.html#module-PopPUNK.sketchlib)   + [PopPUNK.sparse\_mst](api.html#module-PopPUNK.sparse_mst)   + [PopPUNK.utils](api.html#module-PopPUNK.utils)   + [PopPUNK.visualise](api.html#module-PopPUNK.visualise)   + [PopPUNK.web](api.html#module-PopPUNK.web) | * [multi\_refine() (in module PopPUNK.refine)](api.html#PopPUNK.refine.multi_refine) |

## N

|  |  |
| --- | --- |
| * [name (PopPUNK.models.NumpyShared attribute)](api.html#PopPUNK.models.NumpyShared.name)   + [(PopPUNK.refine.NumpyShared attribute)](api.html#PopPUNK.refine.NumpyShared.name) * [network\_to\_edges() (in module PopPUNK.network)](api.html#PopPUNK.network.network_to_edges) * [networkSummary() (in module PopPUNK.network)](api.html#PopPUNK.network.networkSummary) | * [newNetwork() (in module PopPUNK.refine)](api.html#PopPUNK.refine.newNetwork) * [newNetwork2D() (in module PopPUNK.refine)](api.html#PopPUNK.refine.newNetwork2D) * [no\_scale() (PopPUNK.models.ClusterFit method)](api.html#PopPUNK.models.ClusterFit.no_scale) * [NumpyShared (class in PopPUNK.models)](api.html#PopPUNK.models.NumpyShared)   + [(class in PopPUNK.refine)](api.html#PopPUNK.refine.NumpyShared) |

## O

|  |  |
| --- | --- |
| * [outputsForCytoscape() (in module PopPUNK.plot)](api.html#PopPUNK.plot.outputsForCytoscape) * [outputsForGrapetree() (in module PopPUNK.plot)](api.html#PopPUNK.plot.outputsForGrapetree) | * [outputsForMicroreact() (in module PopPUNK.plot)](api.html#PopPUNK.plot.outputsForMicroreact) * [outputsForPhandango() (in module PopPUNK.plot)](api.html#PopPUNK.plot.outputsForPhandango) |

## P

|  |  |
| --- | --- |
| * [plot() (PopPUNK.models.BGMMFit method)](api.html#PopPUNK.models.BGMMFit.plot)   + [(PopPUNK.models.ClusterFit method)](api.html#PopPUNK.models.ClusterFit.plot)   + [(PopPUNK.models.DBSCANFit method)](api.html#PopPUNK.models.DBSCANFit.plot)   + [(PopPUNK.models.LineageFit method)](api.html#PopPUNK.models.LineageFit.plot)   + [(PopPUNK.models.RefineFit method)](api.html#PopPUNK.models.RefineFit.plot) * [plot\_contours() (in module PopPUNK.plot)](api.html#PopPUNK.plot.plot_contours) * [plot\_database\_evaluations() (in module PopPUNK.plot)](api.html#PopPUNK.plot.plot_database_evaluations) * [plot\_dbscan\_results() (in module PopPUNK.plot)](api.html#PopPUNK.plot.plot_dbscan_results) * [plot\_evaluation\_histogram() (in module PopPUNK.plot)](api.html#PopPUNK.plot.plot_evaluation_histogram) * [plot\_fit() (in module PopPUNK.plot)](api.html#PopPUNK.plot.plot_fit) * [plot\_refined\_results() (in module PopPUNK.plot)](api.html#PopPUNK.plot.plot_refined_results) * [plot\_results() (in module PopPUNK.plot)](api.html#PopPUNK.plot.plot_results) * [plot\_scatter() (in module PopPUNK.plot)](api.html#PopPUNK.plot.plot_scatter) * PopPUNK.assign   + [module](api.html#module-PopPUNK.assign) * PopPUNK.bgmm   + [module](api.html#module-PopPUNK.bgmm) * PopPUNK.dbscan   + [module](api.html#module-PopPUNK.dbscan) * PopPUNK.mandrake   + [module](api.html#module-PopPUNK.mandrake) * PopPUNK.models   + [module](api.html#module-PopPUNK.models) | * PopPUNK.network   + [module](api.html#module-PopPUNK.network) * PopPUNK.plot   + [module](api.html#module-PopPUNK.plot) * PopPUNK.refine   + [module](api.html#module-PopPUNK.refine) * PopPUNK.sketchlib   + [module](api.html#module-PopPUNK.sketchlib) * PopPUNK.sparse\_mst   + [module](api.html#module-PopPUNK.sparse_mst) * PopPUNK.utils   + [module](api.html#module-PopPUNK.utils) * PopPUNK.visualise   + [module](api.html#module-PopPUNK.visualise) * PopPUNK.web   + [module](api.html#module-PopPUNK.web) * [print\_network\_summary() (in module PopPUNK.network)](api.html#PopPUNK.network.print_network_summary) * [printClusters() (in module PopPUNK.network)](api.html#PopPUNK.network.printClusters) * [printExternalClusters() (in module PopPUNK.network)](api.html#PopPUNK.network.printExternalClusters) * [process\_previous\_network() (in module PopPUNK.network)](api.html#PopPUNK.network.process_previous_network) * [process\_weights() (in module PopPUNK.network)](api.html#PopPUNK.network.process_weights) * [prune\_graph() (in module PopPUNK.network)](api.html#PopPUNK.network.prune_graph) |

## Q

|  |
| --- |
| * [queryDatabase() (in module PopPUNK.sketchlib)](api.html#PopPUNK.sketchlib.queryDatabase) |

## R

|  |  |
| --- | --- |
| * [read\_rlist\_from\_distance\_pickle() (in module PopPUNK.utils)](api.html#PopPUNK.utils.read_rlist_from_distance_pickle) * [readDBParams() (in module PopPUNK.sketchlib)](api.html#PopPUNK.sketchlib.readDBParams) * [readIsolateTypeFromCsv() (in module PopPUNK.utils)](api.html#PopPUNK.utils.readIsolateTypeFromCsv) * [readManualStart() (in module PopPUNK.refine)](api.html#PopPUNK.refine.readManualStart) * [readPickle() (in module PopPUNK.utils)](api.html#PopPUNK.utils.readPickle) | * [readRfile() (in module PopPUNK.utils)](api.html#PopPUNK.utils.readRfile) * [RefineFit (class in PopPUNK.models)](api.html#PopPUNK.mode