# seedme CWL Generation Report

## seedme

### Tool Description
Upload content to SeedMe.org

### Metadata
- **Docker Image**: quay.io/biocontainers/seedme:1.2.4--py27_1
- **Homepage**: https://github.com/HackUCF/seedme
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seedme/overview
- **Total Downloads**: 12.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/HackUCF/seedme
- **Stars**: N/A
### Original Help Text
```text
usage: seedme [-h] [-o] [-a YOUR_APIKEY] [-ap AUTH_FILE_PATH]
              [-ca SSL_CERTIFICATE_PATH] [-k] [-cto CONNECT_TIMEOUT]
              [-rto read_TIMEOUT] [-up COLLECTION_ID] [-url URL]
              [-u YOUR_USER_NAME] [-v {INFO,WARNING,ERROR,CRITICAL,DEBUG}]
              [-V] [-post {curl,requests}] [-cp /usr/bin/curl] [-cmd] [-CMD]
              [-dry] [-s] [-lf FILE]
              [-del ['COLLECTION_ID', 'filenames|node_ids']
              [['COLLECTION_ID', 'filenames|node_ids'] ...]]
              [-q [COLLECTION_ID required with list args]]
              [-l {all,keyvalue,kv,tic,ticker,url}] [-ta LAST N ITEMS]
              [-dl ['ID', 'all|video|wildcard', 'DOWNLOAD_PATH', 'RETRY', 'INTERVAL']
              [['ID', 'all|video|wildcard', 'DOWNLOAD_PATH', 'RETRY', 'INTERVAL']
              ...]] [-p {private,group,public}] [-e EMAIL] [-n] [-t STRING]
              [-d STRING] [-tr EMAIL] [-tag STRING] [-kv "KEY:VALUE"]
              [-tic STRING] [-fp {FILE, PATH/abc*, DIR}] [-ft STRING]
              [-fd STRING] [-fo] [-fe] [-fn] [-fpp {FILE}]
              [-sp {DIR, PATH/vel*}] [-spp {FILE}] [-st STRING] [-sd STRING]
              [-sr 30.00] [-se] [-so]

Upload content to SeedMe.org

optional arguments:
  -a YOUR_APIKEY, -apikey YOUR_APIKEY
                        Specify your apikey at SeedMe.org
  -ap AUTH_FILE_PATH, -auth_path AUTH_FILE_PATH
                        Specify path to authorization file
                        (default file at ~/seedme.txt or ~/.seedme
                        is searched when this option not specified)
                        This file must contain the following
                        {"username" : "YourUserName", "apikey" : "YourApiKey"}
                        Download this file from https://www.seedme.org/user
  -ca SSL_CERTIFICATE_PATH, -cacert SSL_CERTIFICATE_PATH
                        Set path to SSL certificate
  -cmd, -show_curl_commands
                        Show curl command line options
  -CMD, -show_auth_in_curl_commands
                        Show auth in curl command line options
  -cto CONNECT_TIMEOUT, -connect_timeout CONNECT_TIMEOUT
                        Connection timeout duration in seconds
                        (default: 60
  -cp /usr/bin/curl, -curl_path /usr/bin/curl
                        Specify absolute path to curl executible
                        (default: environment path)
  -del ['COLLECTION_ID', 'filenames|node_ids'] [['COLLECTION_ID', 'filenames|node_ids'] ...], -delete ['COLLECTION_ID', 'filenames|node_ids'] [['COLLECTION_ID', 'filenames|node_ids'] ...]
                        Delete a collection or its content
                        Arguments: Collection_ID filenames|node_ids
                        filenames: comma seperated string * wildcard allowed
                        node_ids: comma seperated node_ids
  -d STRING, -description STRING
                        Specify description for the collection
  -dl ['ID', 'all|video|wildcard', 'DOWNLOAD_PATH', 'RETRY', 'INTERVAL'] [['ID', 'all|video|wildcard', 'DOWNLOAD_PATH', 'RETRY', 'INTERVAL'] ...], -download ['ID', 'all|video|wildcard', 'DOWNLOAD_PATH', 'RETRY', 'INTERVAL'] [['ID', 'all|video|wildcard', 'DOWNLOAD_PATH', 'RETRY', 'INTERVAL'] ...]
                        Download content from a collection
                        Arguments: ID  all|video|wildcard DOWNLOAD_PATH RETRY INTERVAL(Requires first two arguments)
                        (default DOWNLOAD_PATH: ~/Downloads )
                        (default RETRY: 3 )
                        (default INTERVAL: 60)
  -dry, -dry_run        Enable dry run execution mode to check all 
                        input except authorization
  -e EMAIL, -email EMAIL
                        Add emails to share a collection
                        (can be used multiple times)
  -fd STRING, -file_description STRING
                        Add file description
  -fn, -file_dont_encode, -file_dont_transcode
                        Do not trigger video transcoding
  -fo, -file_overwrite  Overwrite file if it exists
                        (default:False)
  -fp {FILE, PATH/abc*, DIR}, -file_path {FILE, PATH/abc*, DIR}
                        Specify FILE | PATH with * wildcard | DIR
  -fpp {FILE}, -file_poster_path {FILE}
                        Specify FILE PATH
  -ft STRING, -file_title STRING
                        Set file title
  -fe, -file_transcode  Trigger video transcoding to create videos
                        for different devices
  -h, --help            show this help message and exit
  -kv "KEY:VALUE", -keyvalue "KEY:VALUE"
                        Add key:value pairs to the collection
                        (can be used multiple times)
  -lf FILE, -logfile FILE
                        Appends output to specified log file
  -k, -insecure         Disable SSL communication
  -n, -notify           Send email to users about a shared collection
                        (default: False)
  -o, -overwrite        Overwrite existing files, if any
  -post {curl,requests}
                        Overide post method
                        (default: requests)
  -p {private,group,public}, -privacy {private,group,public}
                        Specify privacy to access the collection
                        (default: private)
  -q [COLLECTION_ID (required with list args)], -query [COLLECTION_ID (required with list args)]
                        Query your collections with optional ID
                        (default: Returns a list of ID and Title)
  -l {all,keyvalue,kv,tic,ticker,url}, -list {all,keyvalue,kv,tic,ticker,url}
                        list content for a collection(default: ticker)Must be used with -query ID option
  -rto read_TIMEOUT, -read_timeout read_TIMEOUT
                        Read timeout duration in seconds
                        (default: None
  -sd STRING, -sequence_description STRING
                        Add sequence description
  -se, -sequence_encode
                        Trigger video encoding to create a video
                        from image sequence
  -sr 30.00, -sequence_frame_rate 30.00
                        Specify sequence frame rate for video encoding
  -so, -sequence_overwrite
                        Overwrite sequence if it exists
                        (default:False)
  -sp {DIR, PATH/vel*}, -sequence_path {DIR, PATH/vel*}
                        Specify DIR | PATH with * wildcard
  -spp {FILE}, -sequence_poster_path {FILE}
                        Specify FILE PATH
  -st STRING, -sequence_title STRING
                        Set sequence title
                        (Required)
  -s, -silent           Silence all console output including errors
                        (Not recommended during collection creation)
  -tag STRING           Add tag to the collection
                        (can be used many times)
  -ta LAST N ITEMS, -tail LAST N ITEMS
                        Only list last n items to show. Must be used in conjunction with -list option
  -tic STRING, -ticker STRING
                        Add ticker text upto 128 char to the collection
  -t STRING, -title STRING
                        Specify title for the collection (Required)
  -tr EMAIL, -transfer EMAIL
                        Specify email to whom the collection ownership will be transferred
  -up COLLECTION_ID, -update COLLECTION_ID
                        Specify collection id for update or query
  -url URL              Overide default and set new webservices url
  -u YOUR_USER_NAME, -user YOUR_USER_NAME, -username YOUR_USER_NAME
                        Specify your username at SeedMe.org
  -v {INFO,WARNING,ERROR,CRITICAL,DEBUG}, -verbose {INFO,WARNING,ERROR,CRITICAL,DEBUG}
                        verbosity level(default: ERROR)
  -V, -version          Show Web API Version and Web Services URL

*******************************************************************************
Usage Examples:
You must download your authorization file from SeedMe.org
*******************************************************************************

==============================================================================
Create a collection
==============================================================================

Create a collection
% python seedme.py -t 'Test Title'

Note: Default authorization is read from either ~/seedme.txt or ~/.seedme file

-------------------------------------------------------------------------------

Create collection with title, using authorization file from custom path
% python seedme.py -ap '/custompath/my_auth_file' -t 'My Title'

-------------------------------------------------------------------------------

Create collection with several options
% python seedme.py -p 'public' \
                   -e 'one@example.com' -e 'two@example.com' \
                   -t 'CLI Test' \
                   -d 'Using CLI to interact with SeedMe.org' \
                   -kv 'pressure:10pa' -kv 'temperature:300K' \
                   -tag 'YT' -tag 'visualizations' \
                   -tic 't1 is 5%' -tic 't2 is 10%' \
                   -sp 'sample/sequences/plume_boundary/*' \
                   -st 'seq title' -sd 'desc of seq' -sr 5 -se \
                   -fp 'sample/videos/air.mp4' \
                   -ft 'video title' -fd 'desc of video' -fr 1

Notes: -sp option is a dir path, that scans the dir non-recursively and uploads
           all files from there
       -se option will trigger video creation from the uploaded sequence. The
           sequence itself is not automatically deleted from the collection.
      Default authorization is read from either ~/seedme.txt or ~/.seedme file

==============================================================================
Update a collection
==============================================================================

Update title for collection id 666:
 % python seedme.py -ap '~/.seedme' -up 666" -t 'New Title'

Notes: Update collection id -up 666 option is required to update a collection.
       If this is not provided a new collection will be created.

==============================================================================
Notify shared users
==============================================================================

Notify users with whom we shared collection id 666:
% python seedme.py -up 666 -n

Notes: Recall we added sharing emails to the collection earlier as:
       -e 'one@example.com' -e 'two@example.com'
       Notification is NOT automatic. You decide when share notification should
       be sent

==============================================================================
Upload files to a collection
==============================================================================

Add another file to collection id 666:
% python seedme.py -up 666 -fp 'sample/files/doc.pdf'

Note: Default authorization is read from either ~/seedme.txt or ~/.seedme file

-------------------------------------------------------------------------------

Upload multiple files and create a new collection with title 'Multi upload'
% python seedme.py -t 'Multi upload' -fp 'sample/files'

This will upload all files in sample/files directory (non-recursive)
Notes: When uploading multiple files omit other -f* options
       Default authorization is read from either ~/seedme.txt or ~/.seedme file

-------------------------------------------------------------------------------

Append an image to sequence titled 'my sequence title' at collection id 666:
% python seedme.py -up 666
                   -st 'my sequence title'
                   -sp 'sample/seqence/steam/steam_rotation0360.png'

Notes: Sequence title -st 'my sequence title' option is required to append to a
       sequence, as we need to identify the sequence where the image should be
       appended. If sequence title is not provided a new sequence is created.

-------------------------------------------------------------------------------

Add another video to collection id 666:
% python seedme.py -up 666 -fp 'sample/videos/quake.mp4'

Note: videos are always transcoded, to skip transcoding add -fn option

==============================================================================
Delete a collection or its content
==============================================================================

Delete a collection and all its content will be delete
% python seedme.py -del 666

-------------------------------------------------------------------------------

Delete specific file from a collection
% python seedme.py -del 666 doc.pdf

Notes: All occurences of doc.pdf from collection ID 666 will be deleted

-------------------------------------------------------------------------------

Delete files with wildcard from a collection
% python seedme.py -del 666 *.png

Notes: All png files in collection ID 666 will be deleted

-------------------------------------------------------------------------------

Delete a node id from a collection
% python seedme.py -del 666 9999

Notes: Deletes node ID 9999 from collection ID 666

==============================================================================
Downloading files from a collection
==============================================================================

Download all files from a specified collection
% python seedme.py -dl 666 all  "~/Desktop"

Notes: Default download location is ~/Downloads
       By default existing files are incremented not overwritten
       To overwrite add option -o

-------------------------------------------------------------------------------

Download files with wild card string from a specified collection
% python seedme.py -dl 666 *png  "~/Desktop"

Notes: Default download location is ~/Downloads
       By default existing files are incremented not overwritten
       To overwrite add option -o

-------------------------------------------------------------------------------

Download video files from a specified collection
% python seedme.py -dl 666 video "~/Desktop"

Notes: Default download location is ~/Downloads
       By default existing files are incremented not overwritten
       To overwrite add option -o

==============================================================================
Querying a collection
==============================================================================

Query to list all your collections
% python seedme.py -q

Add '-tail 5' to restrict the returned items to last 5

Note: Only the collections you own are returned

-------------------------------------------------------------------------------

Query to find collections that match all specified key value pairs

% python seedme.py -q -kv "ssid:expt11"

Add '-tail 5' to restrict the returned items to last 5

Notes: Only the collections you own are searched.
       Key value pair search is not case sensitive

-------------------------------------------------------------------------------

Query to list all contents for a specified collection
% python seedme.py -q 666

Above is same as
% python seedme.py -q 666 -l all

Add '-tail 5' to restrict the returned items to last 5

Notes: Any collections that you own or shared or public can be queried.
       Urls are only listed for public collections
       Query omits sequence information at present (Under development).

-------------------------------------------------------------------------------

Query to list key value pairs for a specified collection
% python seedme.py -q 666 -l kv

Add '-tail 5' to restrict the returned items to last 5

Note: Any collections that you own or shared or public can be queried

-------------------------------------------------------------------------------

Query to list file urls for a specified collection
% python seedme.py -q 666 -l url

Add '-tail 5' to restrict the returned items to last 5

Note: Any collections that you own or shared or public can be queried
      Urls are only listed for public collections
      Query omits sequence information at present (Under development).

-------------------------------------------------------------------------------

Query to list last 5 tickers for a specified collection
% python seedme.py -q 666 -l tic -ta 5

Note: Any collections that you own or shared or public can be queried

==============================================================================
Transferring a collection
==============================================================================

Create a new collection and assigns its ownership to another
user specified by the email
% python seedme.py -t "Dummy title" -tr one@example.com

Update an existing collection at ID '1234' and transfers its ownership to another
user specified by the email .
% python seedme.py -up 666 -tr one@example.com

Transfer rules
Transferring user will retain the ability to update the transferred collection.
Transferred collection's privacy is automatically restricted to private or group.
Transferring user cannot delete collection or its content after transfer.
Transferring user cannot rescind transferred collection.
Transferring user cannot send notifications to shared users, but recipient can.
Recipient can modify/delete the transferred collection

-------------------------------------------------------------------------------
Command Line Shortcuts
.-------------------.------------------.------------------.--------------------.
| Authorization (!) | Privacy/Sharing +| State           | Misc                |
|-------------------|------------------|-----------------|---------------------|
| -ap authfile path |-p permission     | -h help         | -ca SSL cert path   |
|  OR               |-e email          | -o overwrite    | -cp curl path       |
| -u username       |-n notify users   | -s silent       | -lf log file path   |
| -a apikey         |   with whom      | -k disable SSL  | -post curl/requests |
|                   |   collection is  | -V version info | -cto connect timeout|
|                   |   shared         |                 | -rto read timeout   |
|                   |                  |                 | -url alt REST url   |
|                   |                  |                 | -v verbosity: DEBUG |
|                   |                  |                 |     INFO, WARNING,  |
|                   |                  |                 |     ERROR, CRITICAL |
.-------------------.------------------.-----------------.---------------------.

.-------------------.-------------------------------.--------------------------.
| Create Collection | Update Collection             | Create/Update Metadata   |
|-------------------|-------------------------------|--------------------------|
| -t title !^       | -up ID, collection to update  | -d description ^         |
|                   |                               | -kv keyvalue &^          |
|                   |                               | -tag text +&             |
.-------------------.-------------------------------.--------------------------.

.-------------------.-------------------------------.--------------------------.
| Upload Ticker +   | Upload File +                 | Upload Sequence +        |
|-------------------|-------------------------------|--------------------------|
| -tic ticker &     | -fd file desc ^               | -sd seq desc ^           |
|                   | -fo file overwrite            | -se seq encode           |
|                   | -fp file path (!)             | -so seq overwrite        |
|                   | -ft file title ^              | -sp dir path OR path     |
|                   |                               |     with * wildcard (!)  |
|                   | Options for videos only       | -spp seq poster path     |
|                   | -fn video dont transcode      | -sr seq rate/fps         |
|                   | -fpp video poster path        | -st seq title !          |
|                   |                               |                          |
|                   | Upload multiple files         |                          |
|                   | -fp dir path OR path (!)      |                          |
|                   |     with * wildcard           |                          |
|                   | Must omit other options       |                          |
.-------------------.-------------------------------.--------------------------.

.--------------------------------------.---------------------------------------.
| Delete Content                       | Download Content                      |
|--------------------------------------|---------------------------------------|
| -del ID, collection to delete from   | -dl ID, collection to download from   |
|     wildcard-string  or node ID      |     [ wildcard-string, all, video,    |
|     (Requires ID arg)                |       original, native, highest, high,|
|                                      |       medium, low, lowest ]           |
|                                      |     downloadpath [default ~/Downloads]|
|                                      |     retry [default 1, max 9],         |
|                                      |     interval [>30 sec],               |
|                                      |     (Requires first 2)                |
|                                      | -o overwrite local files              |
.--------------------------------------.---------------------------------------.

.----------------------------.-------------------------.-----------------------.
| Query One Collection       | Query All Collections   |  Transfer Collection  |
|----------------------------| ------------------------|-----------------------|
| -q ID, collection to query | -q returns id and title | -tr email, assign     |
| -l list content choose one |    for all collections  |   collection ownership|
|    [all, kv, tic, url]     | -kv keyvalue returns    |   to someone, privacy |
|    (Requires -q ID option) |     id and title of     |   is modified to      |
| -ta tail n items, must be  |     collections where   |   private or group    |
|     used in conjunction    |     keyvalue is found   |                       |
|     (Requires -l option)   |     (Requires -q option)|                       |
.----------------------------.-------------------------.-----------------------.

 ! Required
 + Multiple allowed in collection
 & Multiple allowed in command line
 ^ Overwrites existing
 # Recommended to be set by user
--------------------------------------------------------------------------------
```

