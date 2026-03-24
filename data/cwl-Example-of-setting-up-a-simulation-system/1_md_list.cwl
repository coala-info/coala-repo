<!DOCTYPE html>

<!--
  ~ Licensed to the Apache Software Foundation (ASF) under one
  ~ or more contributor license agreements.  See the NOTICE file
  ~ distributed with this work for additional information
  ~ regarding copyright ownership.  The ASF licenses this file
  ~ to you under the Apache License, Version 2.0 (the
  ~ "License"); you may not use this file except in compliance
  ~ with the License.  You may obtain a copy of the License at
  ~
  ~   http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  -->

<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:site" content="@commonwl" />
    <meta name="twitter:title" content="CWL Workflow: Example of setting up a simulation system" />
    <meta name="twitter:description" content="CWL version of the md_list.cwl workflow for HPC.
" />
    <meta name="twitter:image" content="/graph/png/github.com/douglowe/biobb_hpc_cwl_md_list/blob/main/md_list.cwl" />
    <title>Example of setting up a simulation system - Common Workflow Language Viewer</title>
    <link rel="stylesheet" href="/bower_components/bootstrap/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/main-20180518.css" />
</head>
<body>

<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a href="/" class="navbar-left">
                <img id="logo" src="/img/CWL-Logo-nofonts.svg" />
            </a>
            <a href="/workflows" class="button navbar-toggle">Explore</a>
            <a href="/apidocs" class="button navbar-toggle">API</a>
            <a href="/about" class="button navbar-toggle">About</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/about">About</a></li>
                <li><a href="/apidocs">API</a></li>
                <li><a href="/workflows">Explore</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Modal for viewing DOT graph -->
<div class="modal fade" id="dotGraph" tabindex="-1" role="dialog" aria-labelledby="dotGraphLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="dotGraphLabel">Workflow DOT Graph</h4>
            </div>
            <div class="modal-body">
                <h4 id="modalTitle">Dot File Source:</h4>
<textarea id="dot" class="form-control" rows="15" name="visualisationDot">
digraph workflow {
  graph [
    bgcolor = &quot;#eeeeee&quot;
    color = &quot;black&quot;
    fontsize = &quot;10&quot;
    labeljust = &quot;left&quot;
    clusterrank = &quot;local&quot;
    ranksep = &quot;0.22&quot;
    nodesep = &quot;0.05&quot;
  ]
  node [
    fontname = &quot;Helvetica&quot;
    fontsize = &quot;10&quot;
    fontcolor = &quot;black&quot;
    shape = &quot;record&quot;
    height = &quot;0&quot;
    width = &quot;0&quot;
    color = &quot;black&quot;
    fillcolor = &quot;lightgoldenrodyellow&quot;
    style = &quot;filled&quot;
  ];
  edge [
    fontname=&quot;Helvetica&quot;
    fontsize=&quot;8&quot;
    fontcolor=&quot;black&quot;
    color=&quot;black&quot;
    arrowsize=&quot;0.7&quot;
  ];
  subgraph cluster_inputs {
    rank = &quot;same&quot;;
    style = &quot;dashed&quot;;
    label = &quot;Workflow Inputs&quot;;
    &quot;step6_grompp_min_config&quot; [fillcolor=&quot;#94DDF4&quot;,label=&quot;step6_grompp_min_config&quot;];
    &quot;step5_genion_config&quot; [fillcolor=&quot;#94DDF4&quot;,label=&quot;step5_genion_config&quot;];
    &quot;step9_grompp_nvt_config&quot; [fillcolor=&quot;#94DDF4&quot;,label=&quot;step9_grompp_nvt_config&quot;];
    &quot;step11_grompp_npt_config&quot; [fillcolor=&quot;#94DDF4&quot;,label=&quot;step11_grompp_npt_config&quot;];
    &quot;step13_grompp_md_config&quot; [fillcolor=&quot;#94DDF4&quot;,label=&quot;step13_grompp_md_config&quot;];
    &quot;step14_mdrun_md_config&quot; [fillcolor=&quot;#94DDF4&quot;,label=&quot;step14_mdrun_md_config&quot;];
    &quot;step8_make_ndx_config&quot; [fillcolor=&quot;#94DDF4&quot;,label=&quot;step8_make_ndx_config&quot;];
    &quot;step2_editconf_config&quot; [fillcolor=&quot;#94DDF4&quot;,label=&quot;step2_editconf_config&quot;];
    &quot;step4_grompp_genion_config&quot; [fillcolor=&quot;#94DDF4&quot;,label=&quot;step4_grompp_genion_config&quot;];
    &quot;step1_pdb_file&quot; [fillcolor=&quot;#94DDF4&quot;,label=&quot;step1_pdb_file&quot;];
  }
  subgraph cluster_outputs {
    rank = &quot;same&quot;;
    style = &quot;dashed&quot;;
    labelloc = &quot;b&quot;;
    label = &quot;Workflow Outputs&quot;;
    &quot;dir&quot; [fillcolor=&quot;#94DDF4&quot;,label=&quot;whole workflow output&quot;];
  }
  &quot;step14_mdrun_md&quot; [label=&quot;step14_mdrun_md&quot;];
  &quot;step11_grompp_npt&quot; [label=&quot;Wrapper of the GROMACS grompp module&quot;];
  &quot;step6_grompp_min&quot; [label=&quot;Wrapper of the GROMACS grompp module&quot;];
  &quot;step5_genion&quot; [label=&quot;step5_genion&quot;];
  &quot;step15_gather_outputs&quot; [label=&quot;step15_gather_outputs&quot;];
  &quot;step13_grompp_md&quot; [label=&quot;Wrapper of the GROMACS grompp module&quot;];
  &quot;step3_solvate&quot; [label=&quot;step3_solvate&quot;];
  &quot;step10_mdrun_nvt&quot; [label=&quot;step10_mdrun_nvt&quot;];
  &quot;step8_make_ndx&quot; [label=&quot;step8_make_ndx&quot;];
  &quot;step7_mdrun_min&quot; [label=&quot;step7_mdrun_min&quot;];
  &quot;step9_grompp_nvt&quot; [label=&quot;Wrapper of the GROMACS grompp module&quot;];
  &quot;step4_grompp_genion&quot; [label=&quot;Wrapper of the GROMACS grompp module&quot;];
  &quot;step12_mdrun_npt&quot; [label=&quot;step12_mdrun_npt&quot;];
  &quot;step1_pdb2gmx&quot; [label=&quot;step1_pdb2gmx&quot;];
  &quot;step2_editconf&quot; [label=&quot;step2_editconf&quot;];
  &quot;step13_grompp_md&quot; -&gt; &quot;step14_mdrun_md&quot; [label=&quot;input_tpr_path&quot;];
  &quot;step14_mdrun_md_config&quot; -&gt; &quot;step14_mdrun_md&quot; [label=&quot;config&quot;];
  &quot;step8_make_ndx&quot; -&gt; &quot;step11_grompp_npt&quot; [label=&quot;input_ndx_path&quot;];
  &quot;step5_genion&quot; -&gt; &quot;step11_grompp_npt&quot; [label=&quot;input_top_zip_path&quot;];
  &quot;step10_mdrun_nvt&quot; -&gt; &quot;step11_grompp_npt&quot; [label=&quot;input_gro_path&quot;];
  &quot;step10_mdrun_nvt&quot; -&gt; &quot;step11_grompp_npt&quot; [label=&quot;input_cpt_path&quot;];
  &quot;step11_grompp_npt_config&quot; -&gt; &quot;step11_grompp_npt&quot; [label=&quot;config&quot;];
  &quot;step5_genion&quot; -&gt; &quot;step6_grompp_min&quot; [label=&quot;input_top_zip_path&quot;];
  &quot;step5_genion&quot; -&gt; &quot;step6_grompp_min&quot; [label=&quot;input_gro_path&quot;];
  &quot;step6_grompp_min_config&quot; -&gt; &quot;step6_grompp_min&quot; [label=&quot;config&quot;];
  &quot;step3_solvate&quot; -&gt; &quot;step5_genion&quot; [label=&quot;input_top_zip_path&quot;];
  &quot;step5_genion_config&quot; -&gt; &quot;step5_genion&quot; [label=&quot;config&quot;];
  &quot;step4_grompp_genion&quot; -&gt; &quot;step5_genion&quot; [label=&quot;input_tpr_path&quot;];
  &quot;step14_mdrun_md&quot; -&gt; &quot;step15_gather_outputs&quot; [label=&quot;external_files&quot;];
  &quot;step14_mdrun_md&quot; -&gt; &quot;step15_gather_outputs&quot; [label=&quot;external_files&quot;];
  &quot;step14_mdrun_md&quot; -&gt; &quot;step15_gather_outputs&quot; [label=&quot;external_files&quot;];
  &quot;step5_genion&quot; -&gt; &quot;step15_gather_outputs&quot; [label=&quot;external_files&quot;];
  &quot;step13_grompp_md&quot; -&gt; &quot;step15_gather_outputs&quot; [label=&quot;external_files&quot;];
  &quot;step1_pdb_file&quot; -&gt; &quot;step15_gather_outputs&quot; [label=&quot;external_project_file&quot;];
  &quot;step5_genion&quot; -&gt; &quot;step13_grompp_md&quot; [label=&quot;input_top_zip_path&quot;];
  &quot;step13_grompp_md_config&quot; -&gt; &quot;step13_grompp_md&quot; [label=&quot;config&quot;];
  &quot;step12_mdrun_npt&quot; -&gt; &quot;step13_grompp_md&quot; [label=&quot;input_gro_path&quot;];
  &quot;step8_make_ndx&quot; -&gt; &quot;step13_grompp_md&quot; [label=&quot;input_ndx_path&quot;];
  &quot;step12_mdrun_npt&quot; -&gt; &quot;step13_grompp_md&quot; [label=&quot;input_cpt_path&quot;];
  &quot;step1_pdb2gmx&quot; -&gt; &quot;step3_solvate&quot; [label=&quot;input_top_zip_path&quot;];
  &quot;step2_editconf&quot; -&gt; &quot;step3_solvate&quot; [label=&quot;input_solute_gro_path&quot;];
  &quot;step9_grompp_nvt&quot; -&gt; &quot;step10_mdrun_nvt&quot; [label=&quot;input_tpr_path&quot;];
  &quot;step8_make_ndx_config&quot; -&gt; &quot;step8_make_ndx&quot; [label=&quot;config&quot;];
  &quot;step7_mdrun_min&quot; -&gt; &quot;step8_make_ndx&quot; [label=&quot;input_structure_path&quot;];
  &quot;step6_grompp_min&quot; -&gt; &quot;step7_mdrun_min&quot; [label=&quot;input_tpr_path&quot;];
  &quot;step7_mdrun_min&quot; -&gt; &quot;step9_grompp_nvt&quot; [label=&quot;input_gro_path&quot;];
  &quot;step9_grompp_nvt_config&quot; -&gt; &quot;step9_grompp_nvt&quot; [label=&quot;config&quot;];
  &quot;step8_make_ndx&quot; -&gt; &quot;step9_grompp_nvt&quot; [label=&quot;input_ndx_path&quot;];
  &quot;step5_genion&quot; -&gt; &quot;step9_grompp_nvt&quot; [label=&quot;input_top_zip_path&quot;];
  &quot;step3_solvate&quot; -&gt; &quot;step4_grompp_genion&quot; [label=&quot;input_top_zip_path&quot;];
  &quot;step3_solvate&quot; -&gt; &quot;step4_grompp_genion&quot; [label=&quot;input_gro_path&quot;];
  &quot;step4_grompp_genion_config&quot; -&gt; &quot;step4_grompp_genion&quot; [label=&quot;config&quot;];
  &quot;step11_grompp_npt&quot; -&gt; &quot;step12_mdrun_npt&quot; [label=&quot;input_tpr_path&quot;];
  &quot;step1_pdb_file&quot; -&gt; &quot;step1_pdb2gmx&quot; [label=&quot;input_pdb_path&quot;];
  &quot;step1_pdb2gmx&quot; -&gt; &quot;step2_editconf&quot; [label=&quot;input_gro_path&quot;];
  &quot;step15_gather_outputs&quot; -&gt; &quot;dir&quot;;
}
</textarea>
                <a id="download-link-dot" href="" download="workflow.dot"></a>
                <button id="download-dot" class="btn btn-primary" type="button">Download dot File</button>
                <a href="/graph/xdot/github.com/douglowe/biobb_hpc_cwl_md_list/blob/main/md_list.cwl" download="graph.dot" class="btn btn-primary" type="button">Download xdot File</a>
            </div>
        </div>
    </div>
</div>

<!-- Modal for viewing the graph in full screen -->
<div class="modal fade" id="fullScreenGraphModal" tabindex="-1" role="dialog" aria-labelledby="fullScreenGraphLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="fullScreenGraphLabel">Workflow Graph</h4>
            </div>
            <div class="modal-body">
                <span id="fullscreen-close" data-dismiss="modal" class="close glyphicon glyphicon-resize-small graphControl" data-tooltip="true" title="Close"></span>
                <object id="graphFullscreen" type="image/svg+xml" data="/graph/svg/github.com/douglowe/biobb_hpc_cwl_md_list/blob/main/md_list.cwl">
                    <img alt="fullscreen" src="/graph/png/github.com/douglowe/biobb_hpc_cwl_md_list/blob/main/md_list.cwl" />
                </object>
            </div>
        </div>
    </div>
</div>

<div class="container" role="main" id="main">
    <div class="row">
        <div class="col-md-12">
            <h2>Workflow: <span>Example of setting up a simulation system</span></h2>
        </div>
        <div class="col-md-6">
            <a href="https://github.com/douglowe/biobb_hpc_cwl_md_list/blob/main/md_list.cwl" rel="noopener" target="_blank" style="text-decoration:none;">
                <img id="gitLogo" src="/img/GitHub-Mark-32px.png" width="24" height="24" />
                
            </a>
        <i>Fetched <span>2021-01-29 13:47:55 GMT</span></i>
          <span class="hidden-print hidden-sm hidden-xs">
                
            <span id="generating" class="hide"> - Generating download link <img alt="loading" src="/img/loading.svg" width="20" height="20" /></span>
            <span id="generated">
                    - <a id="download" href="/robundle/github.com/douglowe/biobb_hpc_cwl_md_list/blob/main/md_list.cwl" download="bundle.zip">Download as Research Object Bundle</a>
                    <a href="http://www.researchobject.org/" rel="noopener" class="help" target="_blank">[?]</a>
                </span>
          </span>
        </div>
        <div class="col-md-6 text-right hidden-xs">
            <img class="verification_icon" src="/img/tick.svg" width="20" height="22" /> Verified with cwltool version <samp>3.0.20201203173111</samp>
        </div>

        <div class="col-md-12" style="margin-top:5px;">
            <p id="workflow-doc">CWL version of the md_list.cwl workflow for HPC.
</p>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-9 col-md-8 col-sm-6">
                <div class="permalink hidden-sm hidden-xs hidden-print">
                        Permalink:
                          <a href="https://w3id.org/cwl/view/" rel="noopener" class="help" target="_blank">[?]</a>
                          <a id="permalink" href="https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl">https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl</a>
                </div>

        </div>
        <div class="col-lg-3 col-md-4 col-sm-6 hidden-xs">
            <div class="graph-menu hidden-print" id="pull-right">
                <button id="view-dot" class="hidden-print hidden-sm-down btn btn-primary" type="button" data-toggle="modal" data-target="#dotGraph">View DOT</button>
                <div class="btn-group hidden-print">
                    <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Download Image <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a id="download-graph" download="graph.svg" href="/graph/svg/github.com/douglowe/biobb_hpc_cwl_md_list/blob/main/md_list.cwl">As .svg</a></li>
                        <li><a id="download-graph" download="graph.png" href="/graph/png/github.com/douglowe/biobb_hpc_cwl_md_list/blob/main/md_list.cwl">As .png</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="visualisation" class="jumbotron hidden-print">
                <span id="fullscreen-open" data-toggle="modal" data-target="#fullScreenGraphModal" data-tooltip="true" class="glyphicon glyphicon-resize-full graphControl" title="Expand"></span>
                <img id="selectChildren" class="graphControl" src="/img/children-logo.svg" alt="children" data-tooltip="true" title="Select All Children" />
                <img id="selectParents" class="graphControl" src="/img/parents-logo.svg" alt="parents" data-tooltip="true" title="Select All Parents" />
                <div id="graph" data-svgurl="/graph/svg/github.com/douglowe/biobb_hpc_cwl_md_list/blob/main/md_list.cwl"></div>
            </div>
            <img alt="Workflow as SVG" src="/graph/svg/github.com/douglowe/biobb_hpc_cwl_md_list/blob/main/md_list.cwl" class="visible-print-block" />
            <ul class="legend">
                <li><span class="selectednode hidden-print"></span> Selected</li>
                <li class="hidden-xs">|</li>
                <li><span class="defaults"></span> Default Values</li>
                <li><span class="nestedworkflows"></span> Nested Workflows</li>
                <li><span class="tools"></span> Tools</li>
                <li><span class="inputoutputs"></span> Inputs/Outputs</li>
            </ul>
            
            <div class="alert alert-success" role="alert">
            	<span class="hidden-xs">This workflow is Open Source and may be reused according to the terms of:</span>
            	<a href="https://raw.githubusercontent.com/douglowe/biobb_hpc_cwl_md_list/main/LICENSE" class="alert-link">
        						
        							<!-- TODO: Move license 'registry' to controller? -->
        							
        							
        							
        							
        							
        							
        							
									https://raw.githubusercontent.com/douglowe/biobb_hpc_cwl_md_list/main/LICENSE
        						
				</a>
				<div class="hidden-xs"><small>Note that the <em>tools</em> invoked by the workflow may have separate licenses.</small></div>
			</div>
			
            <h2>Inputs</h2>
            
            <div>
                <div class="table-responsive">
                    <table class="table table-striped table-hover input">
                        <thead>
                            <th>ID</th>
                            <th>Type</th>
                            <th>Title</th>
                            <th>Doc</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="id">step5_genion_config</td>
                                <td class="type">
                                    
                                    <span>String</span>
                                </td>
                                <td class="title"></td>
                                <td class="doc">
                                    
                                </td>
                            </tr>
                            <tr>
                                <td class="id">step11_grompp_npt_config</td>
                                <td class="type">
                                    
                                    <span>String</span>
                                </td>
                                <td class="title"></td>
                                <td class="doc">
                                    
                                </td>
                            </tr>
                            <tr>
                                <td class="id">step13_grompp_md_config</td>
                                <td class="type">
                                    
                                    <span>String</span>
                                </td>
                                <td class="title"></td>
                                <td class="doc">
                                    
                                </td>
                            </tr>
                            <tr>
                                <td class="id">step14_mdrun_md_config</td>
                                <td class="type">
                                    
                                    <span>String</span>
                                </td>
                                <td class="title"></td>
                                <td class="doc">
                                    
                                </td>
                            </tr>
                            <tr>
                                <td class="id">step2_editconf_config</td>
                                <td class="type">
                                    
                                    <span>String</span>
                                </td>
                                <td class="title"></td>
                                <td class="doc">
                                    
                                </td>
                            </tr>
                            <tr>
                                <td class="id">step4_grompp_genion_config</td>
                                <td class="type">
                                    
                                    <span>String</span>
                                </td>
                                <td class="title"></td>
                                <td class="doc">
                                    
                                </td>
                            </tr>
                            <tr>
                                <td class="id">step1_pdb_file</td>
                                <td class="type">
                                    
                                    <span>File</span>
                                </td>
                                <td class="title"></td>
                                <td class="doc">
                                    
                                </td>
                            </tr>
                            <tr>
                                <td class="id">step8_make_ndx_config</td>
                                <td class="type">
                                    
                                    <span>String</span>
                                </td>
                                <td class="title"></td>
                                <td class="doc">
                                    
                                </td>
                            </tr>
                            <tr>
                                <td class="id">step6_grompp_min_config</td>
                                <td class="type">
                                    
                                    <span>String</span>
                                </td>
                                <td class="title"></td>
                                <td class="doc">
                                    
                                </td>
                            </tr>
                            <tr>
                                <td class="id">step9_grompp_nvt_config</td>
                                <td class="type">
                                    
                                    <span>String</span>
                                </td>
                                <td class="title"></td>
                                <td class="doc">
                                    
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <h2>Steps</h2>
            
            <div>
                <div class="table-responsive">
                    <table class="table table-striped table-hover steps">
                        <thead>
	                        <th>ID</th>
	                        <th>Runs</th>
	                        <th>Label</th>
	                        <th>Doc</th>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="id">step2_editconf</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/editconf.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title"></td>
                            <td class="doc">
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step5_genion</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/genion.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title"></td>
                            <td class="doc">
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step13_grompp_md</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/grompp.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title">Wrapper of the GROMACS grompp module</td>
                            <td class="doc">
                                <p>The GROMACS preprocessor module needs to be feeded with the input system and
the dynamics parameters to create a portable binary run input file TPR. The
dynamics parameters are specified in the mdp section of the configuration YAML
file. The parameter names and defaults are the same as the ones in the
official MDP specification.
</p>
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step12_mdrun_npt</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/mdrun.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title"></td>
                            <td class="doc">
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step10_mdrun_nvt</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/mdrun.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title"></td>
                            <td class="doc">
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step15_gather_outputs</td>
                            <td class="run">
                                <div>
                                    
                                    <span>md_gather.cwl</span>
                                    (<span>ExpressionTool</span>)
                                </div>
                                
                            </td>
                            <td class="title"></td>
                            <td class="doc">
                                <p>This javascript takes two inputs, a list of 
files, a project file, and an optional string. 
It will create a directory named after the 
project file and optional string, populate
that directory with the files in the list, and
return the directory.
</p>
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step7_mdrun_min</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/mdrun.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title"></td>
                            <td class="doc">
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step8_make_ndx</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/make_ndx.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title"></td>
                            <td class="doc">
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step1_pdb2gmx</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/pdb2gmx.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title"></td>
                            <td class="doc">
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step4_grompp_genion</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/grompp.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title">Wrapper of the GROMACS grompp module</td>
                            <td class="doc">
                                <p>The GROMACS preprocessor module needs to be feeded with the input system and
the dynamics parameters to create a portable binary run input file TPR. The
dynamics parameters are specified in the mdp section of the configuration YAML
file. The parameter names and defaults are the same as the ones in the
official MDP specification.
</p>
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step6_grompp_min</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/grompp.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title">Wrapper of the GROMACS grompp module</td>
                            <td class="doc">
                                <p>The GROMACS preprocessor module needs to be feeded with the input system and
the dynamics parameters to create a portable binary run input file TPR. The
dynamics parameters are specified in the mdp section of the configuration YAML
file. The parameter names and defaults are the same as the ones in the
official MDP specification.
</p>
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step11_grompp_npt</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/grompp.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title">Wrapper of the GROMACS grompp module</td>
                            <td class="doc">
                                <p>The GROMACS preprocessor module needs to be feeded with the input system and
the dynamics parameters to create a portable binary run input file TPR. The
dynamics parameters are specified in the mdp section of the configuration YAML
file. The parameter names and defaults are the same as the ones in the
official MDP specification.
</p>
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step3_solvate</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/solvate.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title"></td>
                            <td class="doc">
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step14_mdrun_md</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/mdrun.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title"></td>
                            <td class="doc">
                                
                            </td>
                        </tr>
                        <tr>
                            <td class="id">step9_grompp_nvt</td>
                            <td class="run">
                                <div>
                                    
                                    <span>biobb/biobb_adapters/cwl/biobb_md/gromacs/grompp.cwl</span>
                                    (<span>CommandLineTool</span>)
                                </div>
                                
                            </td>
                            <td class="title">Wrapper of the GROMACS grompp module</td>
                            <td class="doc">
                                <p>The GROMACS preprocessor module needs to be feeded with the input system and
the dynamics parameters to create a portable binary run input file TPR. The
dynamics parameters are specified in the mdp section of the configuration YAML
file. The parameter names and defaults are the same as the ones in the
official MDP specification.
</p>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <h2>Outputs</h2>
            
            <div>
                <div class="table-responsive">
                    <table class="table table-striped table-hover output">
                        <thead>
                            <th>ID</th>
                            <th>Type</th>
                            <th>Label</th>
                            <th>Doc</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="id">dir</td>
                                <td class="type">
                                    
                                    <span>Directory</span>
                                </td>
                                <td class="title">whole workflow output</td>
                                <td class="doc">
                                    <p>outputs from the whole workflow, containing these optional files:
step14_mdrun_md/output_trr_file:   Raw trajectory from the free simulation step
step14_mdrun_md/output_gro_file:   Raw structure from the free simulation step.
step14_mdrun_md/output_cpt_file:   GROMACS portable checkpoint file, allowing to restore (continue) the
                                   simulation from the last step of the setup process.
step13_grompp_md/output_tpr_file:  GROMACS portable binary run input file, containing the starting structure
                                   of the simulation, the molecular topology and all the simulation parameters.
step5_genion/output_top_zip_file:  GROMACS topology file, containing the molecular topology in an ASCII
                                   readable format.
</p>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row hidden-print">
    	<div class="col-md-12 text-center" id="formats">
    	   <span>
            <a role="button" class="btn btn-default btn-sm" href="https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl?format=html" id="format-html">html</a>
           </span>
    	   <span>
            <a role="button" class="btn btn-default btn-sm" href="https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl?format=json" id="format-json">json</a>
           </span>
    	   <span>
            <a role="button" class="btn btn-default btn-sm" href="https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl?format=turtle" id="format-turtle">turtle</a>
           </span>
    	   <span>
            <a role="button" class="btn btn-default btn-sm" href="https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl?format=jsonld" id="format-jsonld">jsonld</a>
           </span>
    	   <span>
            <a role="button" class="btn btn-default btn-sm" href="https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl?format=rdfxml" id="format-rdfxml">rdfxml</a>
           </span>
    	   <span>
            <a role="button" class="btn btn-default btn-sm" href="https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl?format=svg" id="format-svg">svg</a>
           </span>
    	   <span>
            <a role="button" class="btn btn-default btn-sm" href="https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl?format=png" id="format-png">png</a>
           </span>
    	   <span>
            <a role="button" class="btn btn-default btn-sm" href="https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl?format=dot" id="format-dot">dot</a>
           </span>
    	   <span>
            <a role="button" class="btn btn-default btn-sm" href="https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl?format=zip" id="format-zip">zip</a>
           </span>
    	   <span>
            <a role="button" class="btn btn-default btn-sm" href="https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl?format=ro" id="format-ro">ro</a>
           </span>
    	   <span>
            <a role="button" class="btn btn-default btn-sm" href="https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl?format=yaml" id="format-yaml">yaml</a>
           </span>
    	   <span>
            <a role="button" class="btn btn-default btn-sm" href="https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl?format=raw" id="format-raw">raw</a>
           </span>
        </div>
    </div>
    <div class="visible-print-block">
      <address>Permalink:
      	<code>https://w3id.org/cwl/view/git/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl</code>
      </address>
    </div>
</div>

<div id="footer" class="container">
        <div class="row">
            <hr />
            <div class="col-lg-12 muted text-center">
                <a href="https://github.com/common-workflow-language/cwlviewer" rel="noopener" target="_blank">CWL Viewer</a>
                &copy; 2016-2018 <a href="https://www.commonwl.org/" rel="noopener" target="_blank">Common Workflow Language Project</a>
                and <a href="https://github.com/orgs/common-workflow-language/people" rel="noopener" target="_blank">contributors</a>.
                Distributed under <a href="https://www.apache.org/licenses/LICENSE-2.0" rel="noopener" target="_blank">Apache License, version 2.0</a>
                (required <a href="https://github.com/common-workflow-language/cwlviewer/blob/master/NOTICE.md" rel="noopener" target="_blank">attribution notices</a>).                
               	<br />
                <span>
                    <a href="https://github.com/douglowe/biobb_hpc_cwl_md_list/blob/95111f381617c8e63794eca42d06f10ed2605f4f/md_list.cwl" rel="noopener" target="_blank">Shown workflow</a> has separate copyright and license.
                </span>
                (<a href="/about#privacy">Privacy policy</a>)
            </div>
        </div>
        <div class="row logos">
          <div class="col-lg-12 muted text-center">
            <a href="https://www.commonwl.org/" rel="noopener" target="_blank"><img src="/img/CWL-Logo-nofonts.svg" alt="Common Workflow Language" /></a>
            <a href="https://www.esciencelab.org.uk/" rel="noopener" target="_blank"><img src="/img/manchester.svg" alt="The University of Manchester" title="eScienceLab, School of Computer Science, The University of Manchester" /></a>
            <a href="https://bioexcel.eu/" rel="noopener" target="_blank"><img src="/img/BioExcel_logo_cropped.svg" alt="BioExcel" title="BioExcel Center of Excellence for Computational Biomolecular Research" /></a>
            <a href="https://cordis.europa.eu/projects/675728" rel="noopener" target="_blank"><img src="/img/Flag_of_Europe.svg" alt="EU" title="European Commision grant 675728" /></a>
          </div>
        </div>
    </div>

<script src="/bower_components/requirejs/require.js" data-main="/js/workflow.js"></script>
</body>
</html>
