[Cromwell Tools](../index.html)

latest

Overview

* [Cromwell-tools](../README_SYMLINK.html)

Tutorials

* [Cromwell-tools Python API Quickstart](../Tutorials/Quickstart/api_quickstart.html)
* [Cromwell-tools Command Line Interface Quickstart](../Tutorials/Quickstart/cli_quickstart.html)

API Documentation

* API Documentation
  + [cromwell\_tools.cromwell\_api](#module-cromwell_tools.cromwell_api)
  + [cromwell\_tools.cromwell\_auth](#module-cromwell_tools.cromwell_auth)
  + [cromwell\_tools.utilities](#module-cromwell_tools.utilities)
  + [cromwell\_tools.cli](#module-cromwell_tools.cli)

[Cromwell Tools](../index.html)

* [Docs](../index.html) »
* API Documentation
* [Edit on GitHub](https://github.com/broadinstitute/cromwell-tools/blob/master/docs/API/index.rst)

---

# API Documentation[¶](#api-documentation "Permalink to this headline")

Comprehensive reference material for most of the public API exposed by Cromwell-tools:

## cromwell\_tools.cromwell\_api[¶](#module-cromwell_tools.cromwell_api "Permalink to this headline")

TODO: add some module docs
TODO: once switched to support only Py3.7+, replace all ‘cls’
type annotations with the actual Types, rather than using the strings.
This in Py3.6(-) is limited by the lack of Postponed Evaluation of Annotations, see:
<https://www.python.org/dev/peps/pep-0563/>

*class* `cromwell_tools.cromwell_api.``CromwellAPI`[[source]](../_modules/cromwell_tools/cromwell_api.html#CromwellAPI)[¶](#cromwell_tools.cromwell_api.CromwellAPI "Permalink to this definition")
:   Contains a set of classmethods that implement interfaces to cromwell REST API endpoints.

    *classmethod* `abort`(*uuid: str*, *auth: cromwell\_tools.cromwell\_auth.CromwellAuth*, *raise\_for\_status: bool = False*) → requests.models.Response[[source]](../_modules/cromwell_tools/cromwell_api.html#CromwellAPI.abort)[¶](#cromwell_tools.cromwell_api.CromwellAPI.abort "Permalink to this definition")
    :   Request Cromwell to abort a running workflow by UUID.

        |  |  |
        | --- | --- |
        | Parameters: | * **uuid** – A Cromwell workflow UUID, which is the workflow identifier. * **auth** – The authentication class holding headers or auth   information to a Cromwell server. * **raise\_for\_status** – Whether to check and raise for status based on the response. |
        | Raises: | `requests.exceptions.HTTPError` – This will be raised when raise\_for\_status is True and Cromwell returns a response that satisfies 400 <= response.status\_code < 600. |
        | Returns: | HTTP response from Cromwell. |

    *classmethod* `health`(*auth: cromwell\_tools.cromwell\_auth.CromwellAuth*, *raise\_for\_status: bool = False*) → requests.models.Response[[source]](../_modules/cromwell_tools/cromwell_api.html#CromwellAPI.health)[¶](#cromwell_tools.cromwell_api.CromwellAPI.health "Permalink to this definition")
    :   Return the current health status of any monitored subsystems of the Cromwell Server.

        |  |  |
        | --- | --- |
        | Parameters: | * **auth** – authentication class holding headers or auth   information to a Cromwell server. * **raise\_for\_status** – Whether to check and raise for status based on the response. |
        | Raises: | `requests.exceptions.HTTPError` – This will be raised when raise\_for\_status is True and Cromwell returns a response that satisfies 400 <= response.status\_code < 600. |
        | Returns: | HTTP response from Cromwell. |

    *classmethod* `metadata`(*uuid: str, auth: cromwell\_tools.cromwell\_auth.CromwellAuth, includeKey: Union[List[str], str] = None, excludeKey: Union[List[str], str] = None, expandSubWorkflows: bool = False, raise\_for\_status: bool = False*) → requests.models.Response[[source]](../_modules/cromwell_tools/cromwell_api.html#CromwellAPI.metadata)[¶](#cromwell_tools.cromwell_api.CromwellAPI.metadata "Permalink to this definition")
    :   Retrieve the workflow and call-level metadata for a specified workflow by UUID.

        |  |  |
        | --- | --- |
        | Parameters: | * **uuid** – A Cromwell workflow UUID, which is the workflow identifier. * **auth** – The authentication class holding headers or auth   information to a Cromwell server. * **includeKey** – When specified key(s) to include from the metadata. Matches any key   starting with the value. May not be used with excludeKey. * **excludeKey** – When specified key(s) to exclude from the metadata. Matches any key   starting with the value. May not be used with includeKey. * **expandSubWorkflows** – When true, metadata for sub workflows will be fetched   and inserted automatically in the metadata response. * **raise\_for\_status** – Whether to check and raise for status based on the response. |
        | Raises: | `requests.exceptions.HTTPError` – This will be raised when raise\_for\_status is True and Cromwell returns a response that satisfies 400 <= response.status\_code < 600. |
        | Returns: | HTTP response from Cromwell. |

    *classmethod* `patch_labels`(*uuid: str, labels: Dict[str, str], auth: cromwell\_tools.cromwell\_auth.CromwellAuth, raise\_for\_status: bool = False*) → requests.models.Response[[source]](../_modules/cromwell_tools/cromwell_api.html#CromwellAPI.patch_labels)[¶](#cromwell_tools.cromwell_api.CromwellAPI.patch_labels "Permalink to this definition")
    :   Add new labels or patch existing labels for an existing workflow.

        |  |  |
        | --- | --- |
        | Parameters: | * **uuid** – A Cromwell workflow UUID, which is the workflow identifier. * **labels** – A dictionary representing the label key-value pairs. * **auth** – The authentication class holding headers or auth   information to a Cromwell server. * **raise\_for\_status** – Whether to check and raise for status based on the response. |
        | Raises: | `requests.exceptions.HTTPError` – This will be raised when raise\_for\_status is True and Cromwell returns a response that satisfies 400 <= response.status\_code < 600. |
        | Returns: | HTTP response from Cromwell. |

    *classmethod* `query`(*query\_dict: Dict[str, Union[str, List[str], Dict[str, str], bool]], auth: cromwell\_tools.cromwell\_auth.CromwellAuth, raise\_for\_status: bool = False*) → requests.models.Response[[source]](../_modules/cromwell_tools/cromwell_api.html#CromwellAPI.query)[¶](#cromwell_tools.cromwell_api.CromwellAPI.query "Permalink to this definition")
    :   Query for workflows.

        TODO: Given that Cromwell-as-a-Service blocks a set of features that are available in Cromwell, e.g. ‘labelor’,
        for security concerns, the first iteration of this API doesn’t come up with the advanced query keys of the
        Cromwell except a set of necessary ones. However, we need to implement this for completeness and keep an eye
        on the compatibility between CaaS and Cromwell.

        All of the query keys will be used in an OR manner, except the keys within labels, which are defined in
        an AND relation. For instance, [{‘status’: ‘Succeeded’}, {‘status’: ‘Failed’}] will give you all of the
        workflows that in either Succeeded or Failed statuses.

        |  |  |
        | --- | --- |
        | Parameters: | * **query\_dict** – A dictionary representing the query key-value paris. The keys should be accepted by the   Cromwell or they will get ignored. The values could be str, list or dict. * **auth** – The authentication class holding headers or auth   information to a Cromwell server. * **raise\_for\_status** – Whether to check and raise for status based on the response. |
        | Raises: | `requests.exceptions.HTTPError` – This will be raised when raise\_for\_status is True and Cromwell returns a response that satisfies 400 <= response.status\_code < 600. |
        | Returns: | HTTP response from Cromwell. |

    *classmethod* `release_hold`(*uuid: str*, *auth: cromwell\_tools.cromwell\_auth.CromwellAuth*, *raise\_for\_status: bool = False*) → requests.models.Response[[source]](../_modules/cromwell_tools/cromwell_api.html#CromwellAPI.release_hold)[¶](#cromwell_tools.cromwell_api.CromwellAPI.release_hold "Permalink to this definition")
    :   Request Cromwell to release the hold on a workflow.

        It will switch the status of a workflow from ‘On Hold’ to ‘Submitted’ so it can be picked for running. For
        a workflow that was not submitted with workflowOnHold = true, Cromwell will throw an error.

        |  |  |
        | --- | --- |
        | Parameters: | * **uuid** – A Cromwell workflow UUID, which is the workflow identifier. The workflow is expected to have   On Hold status. * **auth** – The authentication class holding headers or auth   information to a Cromwell server. * **raise\_for\_status** – Whether to check and raise for status based on the response. |
        | Raises: | `requests.exceptions.HTTPError` – This will be raised when raise\_for\_status is True and Cromwell returns a response that satisfies 400 <= response.status\_code < 600. |
        | Returns: | HTTP response from Cromwell. |

    *classmethod* `status`(*uuid: str*, *auth: cromwell\_tools.cromwell\_auth.CromwellAuth*, *raise\_for\_status: bool = False*) → requests.models.Response[[source]](../_modules/cromwell_tools/cromwell_api.html#CromwellAPI.status)[¶](#cromwell_tools.cromwell_api.CromwellAPI.status "Permalink to this definition")
    :   Retrieves the current state for a workflow by UUID.

        |  |  |
        | --- | --- |
        | Parameters: | * **uuid** – A Cromwell workflow UUID, which is the workflow identifier. * **auth** – The authentication class holding headers or auth   information to a Cromwell server. * **raise\_for\_status** – Whether to check and raise for status based on the response. |
        | Raises: | `requests.exceptions.HTTPError` – This will be raised when raise\_for\_status is True and Cromwell returns a response that satisfies 400 <= response.status\_code < 600. |
        | Returns: | HTTP response from Cromwell. |

    *classmethod* `submit`(*auth: cromwell\_tools.cromwell\_auth.CromwellAuth, wdl\_file: Union[str, \_io.BytesIO], inputs\_files: Union[List[Union[str, \_io.BytesIO]], str, \_io.BytesIO] = None, options\_file: Union[str, \_io.BytesIO] = None, dependencies: Union[str, List[str], \_io.BytesIO] = None, label\_file: Union[str, \_io.BytesIO] = None, collection\_name: str = None, on\_hold: bool = False, validate\_labels: bool = False, raise\_for\_status: bool = False*) → requests.models.Response[[source]](../_modules/cromwell_tools/cromwell_api.html#CromwellAPI.submit)[¶](#cromwell_tools.cromwell_api.CromwellAPI.submit "Permalink to this definition")
    :   Submits a workflow to Cromwell.

        |  |  |
        | --- | --- |
        | Parameters: | * **auth** – authentication class holding auth information to a   Cromwell server. * **wdl\_file** – The workflow source file to submit for execution. Could be either the   path to the file (str) or the file content in io.BytesIO. * **inputs\_files** – The input data in JSON   format. Could be either the path to the file (str) or the file content in io.BytesIO. This could also   be a list of unlimited input file paths/contents, each of them should have a type of   Union[str, io.BytesIO]. * **options\_file** – The Cromwell options file for workflows. Could be either   the path to the file (str) or the file content in io.BytesIO. * **dependencies** – Workflow dependency files. Could be the path to   the zipped file (str) containing dependencies, a list of paths(List[str]) to all dependency files to be   zipped or a zipped file in io.BytesIO. * **label\_file** – A collection of key/value pairs for workflow labels in JSON   format, could be either the path to the JSON file (str) or the file content in io.BytesIO. * **collection\_name** – Collection in SAM that the workflow should belong to, if use CaaS. * **on\_hold** – Whether to submit the workflow in “On Hold” status. * **validate\_labels** – If True, validate cromwell labels. * **raise\_for\_status** – Whether to check and raise for status based on the response. |
        | Raises: | `requests.exceptions.HTTPError` – This will be raised when raise\_for\_status is True and Cromwell returns a response that satisfies 400 <= response.status\_code < 600. |
        | Returns: | HTTP response from Cromwell. |

    *classmethod* `wait`(*workflow\_ids: List[str], auth: cromwell\_tools.cromwell\_auth.CromwellAuth, timeout\_minutes: int = 120, poll\_interval\_seconds: int = 30, verbose: bool = True*) → None[[source]](../_modules/cromwell_tools/cromwell_api.html#CromwellAPI.wait)[¶](#cromwell_tools.cromwell_api.CromwellAPI.wait "Permalink to this definition")
    :   Wait until cromwell returns successfully for each provided workflow

        Given a list of workflow ids, wait until cromwell returns successfully for each status, or
        one of the workflows fails or is aborted.

        |  |  |
        | --- | --- |
        | Parameters: | * **workflow\_ids** – A list of workflow ids to wait for terminal status. * **timeout\_minutes** – Maximum number of minutes to wait. * **auth** – Authentication class holding headers   or auth information to a Cromwell server. * **poll\_interval\_seconds** – Number of seconds between checks for workflow   completion. * **verbose** – If True, report to stdout when all workflows succeed. |

## cromwell\_tools.cromwell\_auth[¶](#module-cromwell_tools.cromwell_auth "Permalink to this headline")

TODO: add some module docs
TODO: once switched to support only Py3.7+, replace all ‘cls’
type annotations with the actual Types, rather than using the strings.
This in Py3.6(-) is limited by the lack of Postponed Evaluation of Annotations, see:
<https://www.python.org/dev/peps/pep-0563/>

## cromwell\_tools.utilities[¶](#module-cromwell_tools.utilities "Permalink to this headline")

`cromwell_tools.utilities.``compose_oauth_options_for_jes_backend_cromwell`(*auth: cromwell\_tools.cromwell\_auth.CromwellAuth*, *cromwell\_options\_file: \_io.BytesIO = None*, *execution\_bucket: str = None*) → \_io.BytesIO[[source]](../_modules/cromwell_tools/utilities.html#compose_oauth_options_for_jes_backend_cromwell)[¶](#cromwell_tools.utilities.compose_oauth_options_for_jes_backend_cromwell "Permalink to this definition")
:   Append special options that are required by JES(Google Job Execution Service) backend Cromwell.

    This helper function will append special options that are required by JES(Google Job Execution Service)
    backend Cromwell/Cromwell-as-a-Service to the default workflow options. Note: These options only work
    with Cromwell instances that use the Google Cloud Backend and allow user-service-account authentication.

    |  |  |
    | --- | --- |
    | Parameters: | * **auth** – authentication class holding auth information to a Cromwell server. * **cromwell\_options\_file** – Optional, contents of the options for a workflow in BytesIO format.   if not specified, this function will create an empty option stream and ad