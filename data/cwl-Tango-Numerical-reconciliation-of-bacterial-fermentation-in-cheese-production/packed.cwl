{
    "$graph": [
        {
            "class": "ExpressionTool",
            "doc": "Flatten a nested array of 'Any' type into an array.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "array",
                            "items": [
                                "null",
                                "Any"
                            ]
                        }
                    },
                    "id": "#flatten_array.cwl/nested"
                }
            ],
            "expression": "${\n  var flattened = [];\n  for (var i = 0; i < inputs.nested.length; i++) {\n    for (var j = 0; j < inputs.nested[i].length; j++) {\n      if (inputs.nested[i][j] != null) {\n        flattened.push(inputs.nested[i][j]);\n      }\n    }\n  }\n  return {\"flattened\": flattened};\n}\n",
            "id": "#flatten_array.cwl",
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "Any"
                    },
                    "id": "#flatten_array.cwl/flattened"
                }
            ]
        },
        {
            "class": "ExpressionTool",
            "doc": "Combine an array of Files into a single named directory. If\nfiles with duplicate basenames are provided, only the first\none is included, whether or not their contents are the same.\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "loadListing": "shallow_listing",
                    "class": "LoadListingRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        {
                            "type": "array",
                            "items": "File"
                        },
                        "Directory"
                    ],
                    "id": "#mkdir_files.cwl/file_list"
                },
                {
                    "type": "string",
                    "default": "results",
                    "id": "#mkdir_files.cwl/name"
                }
            ],
            "outputs": [
                {
                    "type": "Directory",
                    "id": "#mkdir_files.cwl/out_dir"
                }
            ],
            "expression": "${\n  var file_list = inputs.file_list\n  if (file_list.class == \"Directory\") {\n    file_list = file_list.listing\n  }\n  var flat = []\n  var seen = {}\n  for (var i=0; i<file_list.length; i++) {\n    var key = file_list[i].basename\n    if (!seen.hasOwnProperty(key)) {\n      flat = flat.concat(file_list[i])\n    }\n    seen[key] = true\n  }\n  return {\n    \"out_dir\": {\n      \"class\": \"Directory\",\n      \"basename\": inputs.name,\n      \"listing\": flat\n    }\n  }\n}\n",
            "id": "#mkdir_files.cwl"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "record",
                            "fields": [
                                {
                                    "type": {
                                        "type": "array",
                                        "items": "File"
                                    },
                                    "name": "#mkdir_models.cwl/community/models"
                                }
                            ]
                        }
                    },
                    "id": "#mkdir_models.cwl/community"
                },
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "record",
                            "fields": [
                                {
                                    "type": "string",
                                    "name": "#mkdir_models.cwl/pure_culture/freud_sim"
                                },
                                {
                                    "type": {
                                        "type": "array",
                                        "items": "File"
                                    },
                                    "name": "#mkdir_models.cwl/pure_culture/models"
                                }
                            ]
                        }
                    },
                    "id": "#mkdir_models.cwl/pure_culture"
                }
            ],
            "outputs": [
                {
                    "type": "Directory",
                    "outputSource": "#mkdir_models.cwl/mkdir_models/out_dir",
                    "id": "#mkdir_models.cwl/models_dir"
                }
            ],
            "steps": [
                {
                    "in": [
                        {
                            "source": [
                                "#mkdir_models.cwl/flatten_models/flattened"
                            ],
                            "id": "#mkdir_models.cwl/combine/nested"
                        }
                    ],
                    "out": [
                        "#mkdir_models.cwl/combine/flattened"
                    ],
                    "run": "#flatten_array.cwl",
                    "id": "#mkdir_models.cwl/combine"
                },
                {
                    "scatter": "#mkdir_models.cwl/flatten_models/nested",
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "source": [
                                "#mkdir_models.cwl/pure_culture",
                                "#mkdir_models.cwl/community"
                            ],
                            "valueFrom": "$([self.models])",
                            "linkMerge": "merge_flattened",
                            "id": "#mkdir_models.cwl/flatten_models/nested"
                        }
                    ],
                    "out": [
                        "#mkdir_models.cwl/flatten_models/flattened"
                    ],
                    "run": "#flatten_array.cwl",
                    "id": "#mkdir_models.cwl/flatten_models"
                },
                {
                    "in": [
                        {
                            "source": "#mkdir_models.cwl/combine/flattened",
                            "id": "#mkdir_models.cwl/mkdir_models/file_list"
                        },
                        {
                            "valueFrom": "models_dir",
                            "id": "#mkdir_models.cwl/mkdir_models/name"
                        }
                    ],
                    "out": [
                        "#mkdir_models.cwl/mkdir_models/out_dir"
                    ],
                    "run": "#mkdir_files.cwl",
                    "id": "#mkdir_models.cwl/mkdir_models"
                }
            ],
            "id": "#mkdir_models.cwl"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "record",
                            "fields": [
                                {
                                    "type": {
                                        "type": "array",
                                        "items": "File"
                                    },
                                    "name": "#tango_dynamics_wf.cwl/community/models"
                                }
                            ]
                        }
                    },
                    "id": "#tango_dynamics_wf.cwl/community"
                },
                {
                    "type": "File",
                    "id": "#tango_dynamics_wf.cwl/initial_res_optim"
                },
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "record",
                            "fields": [
                                {
                                    "type": "string",
                                    "name": "#tango_dynamics_wf.cwl/pure_culture/freud_sim"
                                },
                                {
                                    "type": {
                                        "type": "array",
                                        "items": "File"
                                    },
                                    "name": "#tango_dynamics_wf.cwl/pure_culture/models"
                                }
                            ]
                        }
                    },
                    "id": "#tango_dynamics_wf.cwl/pure_culture"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#tango_dynamics_wf.cwl/combine/flattened",
                    "id": "#tango_dynamics_wf.cwl/results"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#tango_dynamics_wf.cwl/combine_time_series/flattened",
                    "id": "#tango_dynamics_wf.cwl/time_series"
                }
            ],
            "doc": "For each model file in the input model_list, run an individual\nsimulation. For each collection of models into a community, run\na community simulation. Return both summary and time series\nsimulation results.",
            "steps": [
                {
                    "run": "#flatten_array.cwl",
                    "in": [
                        {
                            "source": [
                                "#tango_dynamics_wf.cwl/individual_each/results",
                                "#tango_dynamics_wf.cwl/community_together/results"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#tango_dynamics_wf.cwl/combine/nested"
                        }
                    ],
                    "out": [
                        "#tango_dynamics_wf.cwl/combine/flattened"
                    ],
                    "id": "#tango_dynamics_wf.cwl/combine"
                },
                {
                    "run": "#flatten_array.cwl",
                    "in": [
                        {
                            "source": [
                                "#tango_dynamics_wf.cwl/individual_each/time_series",
                                "#tango_dynamics_wf.cwl/community_together/time_series"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#tango_dynamics_wf.cwl/combine_time_series/nested"
                        }
                    ],
                    "out": [
                        "#tango_dynamics_wf.cwl/combine_time_series/flattened"
                    ],
                    "id": "#tango_dynamics_wf.cwl/combine_time_series"
                },
                {
                    "run": "#tango_models.cwl",
                    "scatter": [
                        "#tango_dynamics_wf.cwl/community_together/model",
                        "#tango_dynamics_wf.cwl/community_together/culture",
                        "#tango_dynamics_wf.cwl/community_together/dynamics",
                        "#tango_dynamics_wf.cwl/community_together/solver"
                    ],
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "valueFrom": "True",
                            "id": "#tango_dynamics_wf.cwl/community_together/community_scale"
                        },
                        {
                            "source": "#tango_dynamics_wf.cwl/community",
                            "valueFrom": "$(self.culture || null)",
                            "id": "#tango_dynamics_wf.cwl/community_together/culture"
                        },
                        {
                            "source": "#tango_dynamics_wf.cwl/community",
                            "valueFrom": "$(self.dynamics || null)",
                            "id": "#tango_dynamics_wf.cwl/community_together/dynamics"
                        },
                        {
                            "source": "#tango_dynamics_wf.cwl/initial_res_optim",
                            "id": "#tango_dynamics_wf.cwl/community_together/initial_res_optim"
                        },
                        {
                            "source": "#tango_dynamics_wf.cwl/community",
                            "valueFrom": "$(self.models)",
                            "id": "#tango_dynamics_wf.cwl/community_together/model"
                        },
                        {
                            "valueFrom": "False",
                            "id": "#tango_dynamics_wf.cwl/community_together/optimize"
                        },
                        {
                            "source": "#tango_dynamics_wf.cwl/community",
                            "valueFrom": "$(self.solver || null)",
                            "id": "#tango_dynamics_wf.cwl/community_together/solver"
                        }
                    ],
                    "out": [
                        "#tango_dynamics_wf.cwl/community_together/results",
                        "#tango_dynamics_wf.cwl/community_together/time_series"
                    ],
                    "id": "#tango_dynamics_wf.cwl/community_together"
                },
                {
                    "run": "#tango_models.cwl",
                    "scatter": [
                        "#tango_dynamics_wf.cwl/individual_each/model",
                        "#tango_dynamics_wf.cwl/individual_each/freud_sim"
                    ],
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "valueFrom": "False",
                            "id": "#tango_dynamics_wf.cwl/individual_each/community_scale"
                        },
                        {
                            "source": "#tango_dynamics_wf.cwl/pure_culture",
                            "valueFrom": "$(self.freud_sim)",
                            "id": "#tango_dynamics_wf.cwl/individual_each/freud_sim"
                        },
                        {
                            "source": "#tango_dynamics_wf.cwl/initial_res_optim",
                            "id": "#tango_dynamics_wf.cwl/individual_each/initial_res_optim"
                        },
                        {
                            "source": "#tango_dynamics_wf.cwl/pure_culture",
                            "valueFrom": "$([self.models[0]])",
                            "id": "#tango_dynamics_wf.cwl/individual_each/model"
                        },
                        {
                            "valueFrom": "False",
                            "id": "#tango_dynamics_wf.cwl/individual_each/optimize"
                        }
                    ],
                    "out": [
                        "#tango_dynamics_wf.cwl/individual_each/results",
                        "#tango_dynamics_wf.cwl/individual_each/time_series"
                    ],
                    "id": "#tango_dynamics_wf.cwl/individual_each"
                }
            ],
            "id": "#tango_dynamics_wf.cwl"
        },
        {
            "class": "CommandLineTool",
            "label": "Numerical reconciliation of bacterial fermentation in cheese production",
            "doc": "TANGO uses a numerical strategy to reconcile multi-omics data and\nmetabolic networks for characterising bacterial fermentation in\ncheese production composed of 3 species:\n*P. freudenreichii*, *L. lactis* and *L. plantarum*.",
            "requirements": [
                {
                    "listing": [
                        "$(inputs.data)",
                        "$(inputs.initial_res_optim)",
                        {
                            "basename": "results",
                            "class": "Directory",
                            "listing": []
                        },
                        {
                            "basename": "pipeline",
                            "class": "Directory",
                            "listing": []
                        }
                    ],
                    "class": "InitialWorkDirRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "NetworkAccess",
                    "networkAccess": true
                },
                {
                    "class": "ShellCommandRequirement"
                }
            ],
            "hints": [
                {
                    "dockerImageId": "tango_models",
                    "dockerFile": "FROM mambaorg/micromamba\nADD environment-minimal.yml .\n\nRUN micromamba install --yes \\\n      --name base -c bioconda -c conda-forge \\\n      -f environment-minimal.yml \\\n    micromamba clean --all --yes\n\nARG MAMBA_DOCKERFILE_ACTIVATE=1",
                    "class": "DockerRequirement"
                }
            ],
            "inputs": [
                {
                    "doc": "solver used for FBA computation by Cobra\n{glpk,glpk_exact,cplex,scipy}",
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#tango_models.cwl/cobra_solver/glpk",
                                "#tango_models.cwl/cobra_solver/glpk_exact",
                                "#tango_models.cwl/cobra_solver/cplex",
                                "#tango_models.cwl/cobra_solver/scipy"
                            ]
                        }
                    ],
                    "default": "glpk",
                    "inputBinding": {
                        "position": 5,
                        "prefix": "-CobraSolver"
                    },
                    "id": "#tango_models.cwl/cobra_solver"
                },
                {
                    "doc": "dFBA at the community scale {True,False}",
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#tango_models.cwl/community_scale/True",
                                "#tango_models.cwl/community_scale/False"
                            ]
                        }
                    ],
                    "default": "False",
                    "inputBinding": {
                        "position": 5,
                        "prefix": "-com"
                    },
                    "id": "#tango_models.cwl/community_scale"
                },
                {
                    "type": "File",
                    "format": "http://edamontology.org/format_3750",
                    "doc": "specific media and/or specif modification applied to the FBA\nmodels",
                    "default": {
                        "class": "File",
                        "location": "file:///opt/app-root/src/tango_models/pipeline/config_file/config_culture.yml",
                        "format": "http://edamontology.org/format_3750"
                    },
                    "inputBinding": {
                        "position": 2,
                        "prefix": "-cp"
                    },
                    "id": "#tango_models.cwl/culture"
                },
                {
                    "type": "Directory",
                    "doc": "Directory containing experimental data, referenced in optimize\nconfiguration",
                    "default": {
                        "class": "Directory",
                        "location": "file:///opt/app-root/src/tango_models/data"
                    },
                    "id": "#tango_models.cwl/data"
                },
                {
                    "type": "File",
                    "format": "http://edamontology.org/format_3750",
                    "doc": "specific paramters for your dFBA analysis",
                    "default": {
                        "class": "File",
                        "location": "file:///opt/app-root/src/tango_models/pipeline/config_file/config_dynamic.yml",
                        "format": "http://edamontology.org/format_3750"
                    },
                    "inputBinding": {
                        "position": 3,
                        "prefix": "-dp"
                    },
                    "id": "#tango_models.cwl/dynamics"
                },
                {
                    "doc": "different initial conditions for lactate where defined in the\nexperiments for growth and metabolite dosage => this parameter\nallows to switch between both situations {growth,metabolites}",
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#tango_models.cwl/freud_sim/growth",
                                "#tango_models.cwl/freud_sim/metabolites"
                            ]
                        }
                    ],
                    "default": "growth",
                    "inputBinding": {
                        "position": 5,
                        "prefix": "-fsim"
                    },
                    "id": "#tango_models.cwl/freud_sim"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Per-species optimization results",
                    "id": "#tango_models.cwl/initial_res_optim"
                },
                {
                    "doc": "lactic acid model use total if lactate represents total lactic\nacid concentration, or dissociated if lactate represents the\ndissociated lactic acid {total,dissociated} ",
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#tango_models.cwl/lactic_acid_model/total",
                                "#tango_models.cwl/lactic_acid_model/dissociated"
                            ]
                        }
                    ],
                    "default": "total",
                    "inputBinding": {
                        "position": 5,
                        "prefix": "-lam"
                    },
                    "id": "#tango_models.cwl/lactic_acid_model"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "format": "http://edamontology.org/format_2585",
                    "doc": "SBML model",
                    "inputBinding": {
                        "position": 1,
                        "prefix": "-mp"
                    },
                    "id": "#tango_models.cwl/model"
                },
                {
                    "doc": "activatee or not the optimization on parameters {True,False}",
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#tango_models.cwl/optimize/True",
                                "#tango_models.cwl/optimize/False"
                            ]
                        }
                    ],
                    "default": "False",
                    "inputBinding": {
                        "position": 5,
                        "prefix": "-optim"
                    },
                    "id": "#tango_models.cwl/optimize"
                },
                {
                    "doc": "activate or not recovery of the optimization on parameters\n{True,False}",
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#tango_models.cwl/recovery/True",
                                "#tango_models.cwl/recovery/False"
                            ]
                        }
                    ],
                    "default": "False",
                    "inputBinding": {
                        "position": 6,
                        "prefix": "-r"
                    },
                    "id": "#tango_models.cwl/recovery"
                },
                {
                    "type": "File",
                    "format": "http://edamontology.org/format_3750",
                    "doc": "configuration file for optimization",
                    "default": {
                        "class": "File",
                        "location": "file:///opt/app-root/src/tango_models/pipeline/config_file/config_optim.yml",
                        "format": "http://edamontology.org/format_3750"
                    },
                    "inputBinding": {
                        "position": 4,
                        "prefix": "-sp"
                    },
                    "id": "#tango_models.cwl/solver"
                },
                {
                    "doc": "active or not verbose reporting {True,False}",
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#tango_models.cwl/verbose/True",
                                "#tango_models.cwl/verbose/False"
                            ]
                        }
                    ],
                    "default": "False",
                    "inputBinding": {
                        "position": 6,
                        "prefix": "-v"
                    },
                    "id": "#tango_models.cwl/verbose"
                }
            ],
            "baseCommand": [
                "tango_models",
                "sim"
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "recover_optim*yml"
                    },
                    "doc": "Pickle file of recovery optimization",
                    "format": "http://edamontology.org/format_2333",
                    "id": "#tango_models.cwl/recovery_optimisation"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "res_optim.txt"
                    },
                    "doc": "optimization results",
                    "format": "http://edamontology.org/format_3475",
                    "id": "#tango_models.cwl/result_optimization"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputBinding": {
                        "glob": [
                            "results/*.pkz",
                            "results/*.csv"
                        ],
                        "outputEval": "${\n    return self.filter(function(i) { return -1 == i.basename.indexOf(\"_t_\") })\n}\n"
                    },
                    "doc": "Pickled Pandas data frames containing simulation results\n",
                    "format": "http://edamontology.org/format_2333",
                    "id": "#tango_models.cwl/results"
                },
                {
                    "type": "File",
                    "format": "http://edamontology.org/format_1964",
                    "id": "#tango_models.cwl/standard_error",
                    "outputBinding": {
                        "glob": "stderr.txt"
                    }
                },
                {
                    "type": "File",
                    "format": "http://edamontology.org/format_1964",
                    "id": "#tango_models.cwl/standard_output",
                    "outputBinding": {
                        "glob": "stdout.txt"
                    }
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputBinding": {
                        "glob": [
                            "results/*.pkz"
                        ],
                        "outputEval": "${\n    return self.filter(function(i) { return -1 != i.basename.indexOf(\"_t_\") })\n}\n"
                    },
                    "doc": "Pickled Pandas data frames containing time series of simulation results\n",
                    "format": "http://edamontology.org/format_2333",
                    "id": "#tango_models.cwl/time_series"
                }
            ],
            "stdout": "stdout.txt",
            "stderr": "stderr.txt",
            "id": "#tango_models.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "Simon Labarthe",
                    "https://schema.org/identifier": "https://orcid.org/0000-0003-2114-0697"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "Cl\u00e9mence Frioux",
                    "https://schema.org/identifier": "https://orcid.org/0000-0003-2114-0697"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "David James Sherman",
                    "https://schema.org/identifier": "https://orcid.org/0000-0002-2316-1005"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "Maxime Lecomte",
                    "https://schema.org/identifier": "https://orcid.org/0000-0002-4558-6151"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "H\u00e9l\u00e8ne Falentin",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-6254-5303"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "Julie Aubert",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-5203-5748"
                }
            ],
            "https://schema.org/citation": "https://doi.org/10.1016/j.ymben.2024.02.014",
            "https://schema.org/codeRepository": "https://forgemia.inra.fr/tango/tango_models.git",
            "https://schema.org/license": "https://spdx.org/licenses/LGPL-3.0-or-later",
            "https://schema.org/programmingLanguage": "Python",
            "https://schema.org/dateCreated": "2024-03-02"
        },
        {
            "class": "CommandLineTool",
            "label": "Plot TANGO results",
            "doc": "Use plot_* scripts to make figures from TANGO results.",
            "requirements": [
                {
                    "listing": [
                        {
                            "entry": "$(inputs.scripts)",
                            "entryname": "scripts"
                        },
                        {
                            "entry": "$(inputs.data)",
                            "entryname": "data"
                        },
                        {
                            "entry": "$(inputs.models)",
                            "entryname": "metabolic_models"
                        },
                        {
                            "entry": "$(inputs.results)",
                            "entryname": "results"
                        }
                    ],
                    "class": "InitialWorkDirRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "NetworkAccess",
                    "networkAccess": true
                },
                {
                    "class": "ShellCommandRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "Directory",
                    "doc": "Directory containing experimental data, referenced in optimize\nconfiguration",
                    "default": {
                        "class": "Directory",
                        "location": "file:///opt/app-root/src/tango_models/data"
                    },
                    "id": "#tango_one_plot.cwl/data"
                },
                {
                    "doc": "Which predefined figure to make\n{indiv,flux,com,goodness_of_fit,switch_pathways}",
                    "type": "string",
                    "default": "indiv",
                    "id": "#tango_one_plot.cwl/figure"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Directory containing experimental data, referenced in optimize\nconfiguration",
                    "id": "#tango_one_plot.cwl/models"
                },
                {
                    "type": "Directory",
                    "doc": "Array of TANGO result files",
                    "id": "#tango_one_plot.cwl/results"
                },
                {
                    "type": "Directory",
                    "doc": "Scripts for predefined figures",
                    "default": {
                        "class": "Directory",
                        "location": "file:///opt/app-root/src/tango_models/scripts"
                    },
                    "id": "#tango_one_plot.cwl/scripts"
                }
            ],
            "baseCommand": [
                "python",
                "-m"
            ],
            "arguments": [
                {
                    "valueFrom": "$(\"scripts.plot_\" + inputs.figure)"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputBinding": {
                        "glob": [
                            "*.pdf",
                            "*.svg"
                        ]
                    },
                    "doc": "Figure in PDF format",
                    "format": "http://edamontology.org/format_3508",
                    "id": "#tango_one_plot.cwl/plots"
                },
                {
                    "type": "File",
                    "format": "http://edamontology.org/format_1964",
                    "id": "#tango_one_plot.cwl/standard_error",
                    "outputBinding": {
                        "glob": "stderr.txt"
                    }
                },
                {
                    "type": "File",
                    "format": "http://edamontology.org/format_1964",
                    "id": "#tango_one_plot.cwl/standard_output",
                    "outputBinding": {
                        "glob": "stdout.txt"
                    }
                }
            ],
            "stdout": "stdout.txt",
            "stderr": "stderr.txt",
            "id": "#tango_one_plot.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "Simon Labarthe",
                    "https://schema.org/identifier": "https://orcid.org/0000-0003-2114-0697"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "Cl\u00e9mence Frioux",
                    "https://schema.org/identifier": "https://orcid.org/0000-0003-2114-0697"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "David James Sherman",
                    "https://schema.org/identifier": "https://orcid.org/0000-0002-2316-1005"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "Maxime Lecomte",
                    "https://schema.org/identifier": "https://orcid.org/0000-0002-4558-6151"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "H\u00e9l\u00e8ne Falentin",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-6254-5303"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "Julie Aubert",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-5203-5748"
                }
            ],
            "https://schema.org/dateCreated": "2024-03-04",
            "https://schema.org/license": "https://spdx.org/licenses/LGPL-3.0-or-later"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "record",
                            "fields": [
                                {
                                    "type": "string",
                                    "name": "#tango_optimization_wf.cwl/pure_culture/freud_sim"
                                },
                                {
                                    "type": {
                                        "type": "array",
                                        "items": "File"
                                    },
                                    "name": "#tango_optimization_wf.cwl/pure_culture/models"
                                }
                            ]
                        }
                    },
                    "id": "#tango_optimization_wf.cwl/pure_culture"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputSource": "#tango_optimization_wf.cwl/combine/result_optimization",
                    "id": "#tango_optimization_wf.cwl/result_optimization"
                }
            ],
            "doc": "For each model file in the input model_list, run an individual\noptimization to obtain lambda, k_lactate, vmax_lactose parameters\nas each model requires. Return a combined result_optimization.",
            "steps": [
                {
                    "in": [
                        {
                            "source": "#tango_optimization_wf.cwl/optimize_each/result_optimization",
                            "id": "#tango_optimization_wf.cwl/combine/file_list"
                        }
                    ],
                    "out": [
                        "#tango_optimization_wf.cwl/combine/result_optimization"
                    ],
                    "run": {
                        "class": "CommandLineTool",
                        "baseCommand": [
                            "cat"
                        ],
                        "inputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "File"
                                },
                                "inputBinding": {
                                    "position": 1
                                },
                                "id": "#tango_optimization_wf.cwl/combine/run/file_list"
                            }
                        ],
                        "outputs": [
                            {
                                "type": "File",
                                "streamable": true,
                                "outputBinding": {
                                    "glob": "res_optim.txt"
                                },
                                "id": "#tango_optimization_wf.cwl/combine/run/result_optimization"
                            }
                        ],
                        "stdout": "res_optim.txt"
                    },
                    "id": "#tango_optimization_wf.cwl/combine"
                },
                {
                    "run": "#tango_models.cwl",
                    "scatter": [
                        "#tango_optimization_wf.cwl/optimize_each/model",
                        "#tango_optimization_wf.cwl/optimize_each/freud_sim"
                    ],
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "valueFrom": "False",
                            "id": "#tango_optimization_wf.cwl/optimize_each/community_scale"
                        },
                        {
                            "source": "#tango_optimization_wf.cwl/pure_culture",
                            "valueFrom": "$(self.freud_sim)",
                            "id": "#tango_optimization_wf.cwl/optimize_each/freud_sim"
                        },
                        {
                            "source": "#tango_optimization_wf.cwl/pure_culture",
                            "valueFrom": "$([self.models[0]])",
                            "id": "#tango_optimization_wf.cwl/optimize_each/model"
                        },
                        {
                            "valueFrom": "True",
                            "id": "#tango_optimization_wf.cwl/optimize_each/optimize"
                        }
                    ],
                    "out": [
                        "#tango_optimization_wf.cwl/optimize_each/result_optimization"
                    ],
                    "id": "#tango_optimization_wf.cwl/optimize_each"
                }
            ],
            "id": "#tango_optimization_wf.cwl"
        },
        {
            "class": "Workflow",
            "label": "Plot TANGO results",
            "doc": "Assemble all figures requested by which_figures.",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "Directory",
                    "id": "#tango_plots.cwl/models"
                },
                {
                    "type": [
                        {
                            "type": "array",
                            "items": "File"
                        },
                        "Directory"
                    ],
                    "id": "#tango_plots.cwl/results"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "string"
                    },
                    "id": "#tango_plots.cwl/which_figures"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#tango_plots.cwl/flatten/flattened",
                    "id": "#tango_plots.cwl/figures"
                }
            ],
            "steps": [
                {
                    "in": [
                        {
                            "source": "#tango_plots.cwl/plot_figures/plots",
                            "id": "#tango_plots.cwl/flatten/nested"
                        }
                    ],
                    "out": [
                        "#tango_plots.cwl/flatten/flattened"
                    ],
                    "run": "#flatten_array.cwl",
                    "id": "#tango_plots.cwl/flatten"
                },
                {
                    "scatter": [
                        "#tango_plots.cwl/plot_figures/figure"
                    ],
                    "in": [
                        {
                            "source": "#tango_plots.cwl/which_figures",
                            "id": "#tango_plots.cwl/plot_figures/figure"
                        },
                        {
                            "source": "#tango_plots.cwl/models",
                            "id": "#tango_plots.cwl/plot_figures/models"
                        },
                        {
                            "source": "#tango_plots.cwl/prepare/out_dir",
                            "id": "#tango_plots.cwl/plot_figures/results"
                        }
                    ],
                    "out": [
                        "#tango_plots.cwl/plot_figures/plots"
                    ],
                    "run": "#tango_one_plot.cwl",
                    "id": "#tango_plots.cwl/plot_figures"
                },
                {
                    "in": [
                        {
                            "source": "#tango_plots.cwl/results",
                            "id": "#tango_plots.cwl/prepare/file_list"
                        },
                        {
                            "valueFrom": "results",
                            "id": "#tango_plots.cwl/prepare/name"
                        }
                    ],
                    "out": [
                        "#tango_plots.cwl/prepare/out_dir"
                    ],
                    "run": "#mkdir_files.cwl",
                    "id": "#tango_plots.cwl/prepare"
                }
            ],
            "id": "#tango_plots.cwl"
        },
        {
            "class": "Workflow",
            "label": "Numerical reconciliation of bacterial fermentation in cheese production",
            "doc": "Complete workflow for TANGO as reported in Lecomte et al (2024),\n\"Revealing the dynamics and mechanisms of bacterial interactions in\ncheese production with metabolic modelling\", Metabolic Eng. 83:24-38\nhttps://doi.org/10.1016/j.ymben.2024.02.014\n\n1. Parameters for individual models are obtained by optimization\n2. Individual dynamics and community dynamics are simulated\n3. Figures for the manuscript are assembled from the results.",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "inputs": [
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "record",
                            "fields": [
                                {
                                    "type": {
                                        "type": "array",
                                        "items": "File"
                                    },
                                    "name": "#main/community/models"
                                }
                            ]
                        }
                    },
                    "id": "#main/community"
                },
                {
                    "type": {
                        "type": "array",
                        "items": {
                            "type": "record",
                            "fields": [
                                {
                                    "type": "string",
                                    "name": "#main/pure_culture/freud_sim"
                                },
                                {
                                    "type": {
                                        "type": "array",
                                        "items": "File"
                                    },
                                    "name": "#main/pure_culture/models"
                                }
                            ]
                        }
                    },
                    "id": "#main/pure_culture"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "string"
                    },
                    "id": "#main/which_figures"
                }
            ],
            "outputs": [
                {
                    "type": "Directory",
                    "outputSource": "#main/mkdir_figures/out_dir",
                    "id": "#main/figures"
                },
                {
                    "type": "Directory",
                    "outputSource": "#main/mkdir_results/out_dir",
                    "id": "#main/results"
                }
            ],
            "steps": [
                {
                    "in": [
                        {
                            "source": "#main/community",
                            "id": "#main/dynamics/community"
                        },
                        {
                            "source": "#main/optimize/result_optimization",
                            "id": "#main/dynamics/initial_res_optim"
                        },
                        {
                            "source": "#main/pure_culture",
                            "id": "#main/dynamics/pure_culture"
                        }
                    ],
                    "out": [
                        "#main/dynamics/results",
                        "#main/dynamics/time_series"
                    ],
                    "run": "#tango_dynamics_wf.cwl",
                    "id": "#main/dynamics"
                },
                {
                    "in": [
                        {
                            "source": "#main/plot_figures/figures",
                            "id": "#main/mkdir_figures/file_list"
                        },
                        {
                            "valueFrom": "figures",
                            "id": "#main/mkdir_figures/name"
                        }
                    ],
                    "out": [
                        "#main/mkdir_figures/out_dir"
                    ],
                    "run": "#mkdir_files.cwl",
                    "id": "#main/mkdir_figures"
                },
                {
                    "in": [
                        {
                            "source": "#main/community",
                            "id": "#main/mkdir_models/community"
                        },
                        {
                            "source": "#main/pure_culture",
                            "id": "#main/mkdir_models/pure_culture"
                        }
                    ],
                    "out": [
                        "#main/mkdir_models/models_dir"
                    ],
                    "run": "#mkdir_models.cwl",
                    "id": "#main/mkdir_models"
                },
                {
                    "in": [
                        {
                            "source": "#main/dynamics/results",
                            "id": "#main/mkdir_results/file_list"
                        },
                        {
                            "valueFrom": "results",
                            "id": "#main/mkdir_results/name"
                        }
                    ],
                    "out": [
                        "#main/mkdir_results/out_dir"
                    ],
                    "run": "#mkdir_files.cwl",
                    "id": "#main/mkdir_results"
                },
                {
                    "in": [
                        {
                            "source": "#main/pure_culture",
                            "id": "#main/optimize/pure_culture"
                        }
                    ],
                    "out": [
                        "#main/optimize/result_optimization"
                    ],
                    "run": "#tango_optimization_wf.cwl",
                    "id": "#main/optimize"
                },
                {
                    "in": [
                        {
                            "source": "#main/mkdir_models/models_dir",
                            "id": "#main/plot_figures/models"
                        },
                        {
                            "source": [
                                "#main/dynamics/results",
                                "#main/dynamics/time_series"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/plot_figures/results"
                        },
                        {
                            "source": "#main/which_figures",
                            "id": "#main/plot_figures/which_figures"
                        }
                    ],
                    "out": [
                        "#main/plot_figures/figures"
                    ],
                    "run": "#tango_plots.cwl",
                    "id": "#main/plot_figures"
                }
            ],
            "id": "#main",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "Simon Labarthe",
                    "https://schema.org/identifier": "https://orcid.org/0000-0003-2114-0697"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "Cl\u00e9mence Frioux",
                    "https://schema.org/identifier": "https://orcid.org/0000-0003-2114-0697"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "David James Sherman",
                    "https://schema.org/identifier": "https://orcid.org/0000-0002-2316-1005"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "Maxime Lecomte",
                    "https://schema.org/identifier": "https://orcid.org/0000-0002-4558-6151"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "H\u00e9l\u00e8ne Falentin",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-6254-5303"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/name": "Julie Aubert",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-5203-5748"
                }
            ],
            "https://schema.org/citation": "https://doi.org/10.1016/j.ymben.2024.02.014",
            "https://schema.org/codeRepository": "https://forgemia.inra.fr/tango/tango_models.git",
            "https://schema.org/license": "https://spdx.org/licenses/LGPL-3.0-or-later",
            "https://schema.org/programmingLanguage": "Python",
            "https://schema.org/dateCreated": "2024-03-02"
        }
    ],
    "cwlVersion": "v1.2",
    "$schemas": [
        "http://edamontology.org/EDAM_1.23.owl",
        "https://schema.org/version/latest/schemaorg-current-http.rdf"
    ],
    "$namespaces": {
        "s": "https://schema.org/",
        "edam": "http://edamontology.org/"
    }
}