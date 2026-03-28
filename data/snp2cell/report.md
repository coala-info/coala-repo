# snp2cell CWL Generation Report

## snp2cell_create-gene2pos-mapping

### Tool Description
Create a gene to genomic position mapping.

### Metadata
- **Docker Image**: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Teichlab/snp2cell
- **Package**: https://anaconda.org/channels/bioconda/packages/snp2cell/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snp2cell/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Teichlab/snp2cell
- **Stars**: N/A
### Original Help Text
```text
[INFO - create_gene2pos_mapping - 2026-02-25 06:41:21,168]: query biomart host: elp
╭───────────────────── Traceback (most recent call last) ──────────────────────╮
│ /usr/local/lib/python3.11/site-packages/urllib3/connection.py:198 in         │
│ _new_conn                                                                    │
│                                                                              │
│    195 │   │   :return: New socket connection.                               │
│    196 │   │   """                                                           │
│    197 │   │   try:                                                          │
│ ❱  198 │   │   │   sock = connection.create_connection(                      │
│    199 │   │   │   │   (self._dns_host, self.port),                          │
│    200 │   │   │   │   self.timeout,                                         │
│    201 │   │   │   │   source_address=self.source_address,                   │
│                                                                              │
│ ╭────────────────────────────── locals ───────────────────────────────╮      │
│ │ self = <urllib3.connection.HTTPConnection object at 0x7537a5d14110> │      │
│ ╰─────────────────────────────────────────────────────────────────────╯      │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/urllib3/util/connection.py:60 in     │
│ create_connection                                                            │
│                                                                              │
│    57 │   except UnicodeError:                                               │
│    58 │   │   raise LocationParseError(f"'{host}', label empty or too long") │
│    59 │                                                                      │
│ ❱  60 │   for res in socket.getaddrinfo(host, port, family, socket.SOCK_STRE │
│    61 │   │   af, socktype, proto, canonname, sa = res                       │
│    62 │   │   sock = None                                                    │
│    63 │   │   try:                                                           │
│                                                                              │
│ ╭─────────────────── locals ────────────────────╮                            │
│ │        address = ('elp', 80)                  │                            │
│ │            err = None                         │                            │
│ │         family = <AddressFamily.AF_UNSPEC: 0> │                            │
│ │           host = 'elp'                        │                            │
│ │           port = 80                           │                            │
│ │ socket_options = [(6, 1, 1)]                  │                            │
│ │ source_address = None                         │                            │
│ │        timeout = None                         │                            │
│ ╰───────────────────────────────────────────────╯                            │
│                                                                              │
│ /usr/local/lib/python3.11/socket.py:974 in getaddrinfo                       │
│                                                                              │
│   971 │   # We override this function since we want to translate the numeric │
│   972 │   # and socket type values to enum constants.                        │
│   973 │   addrlist = []                                                      │
│ ❱ 974 │   for res in _socket.getaddrinfo(host, port, family, type, proto, fl │
│   975 │   │   af, socktype, proto, canonname, sa = res                       │
│   976 │   │   addrlist.append((_intenum_converter(af, AddressFamily),        │
│   977 │   │   │   │   │   │    _intenum_converter(socktype, SocketKind),     │
│                                                                              │
│ ╭──────────────── locals ─────────────────╮                                  │
│ │ addrlist = []                           │                                  │
│ │   family = <AddressFamily.AF_UNSPEC: 0> │                                  │
│ │    flags = 0                            │                                  │
│ │     host = 'elp'                        │                                  │
│ │     port = 80                           │                                  │
│ │    proto = 0                            │                                  │
│ │     type = <SocketKind.SOCK_STREAM: 1>  │                                  │
│ ╰─────────────────────────────────────────╯                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
gaierror: [Errno -2] Name or service not known

The above exception was the direct cause of the following exception:

╭───────────────────── Traceback (most recent call last) ──────────────────────╮
│ /usr/local/lib/python3.11/site-packages/urllib3/connectionpool.py:787 in     │
│ urlopen                                                                      │
│                                                                              │
│    784 │   │   │   response_conn = conn if not release_conn else None        │
│    785 │   │   │                                                             │
│    786 │   │   │   # Make the request on the HTTPConnection object           │
│ ❱  787 │   │   │   response = self._make_request(                            │
│    788 │   │   │   │   conn,                                                 │
│    789 │   │   │   │   method,                                               │
│    790 │   │   │   │   url,                                                  │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │     assert_same_host = False                                             │ │
│ │                 body = None                                              │ │
│ │             body_pos = None                                              │ │
│ │              chunked = False                                             │ │
│ │           clean_exit = False                                             │ │
│ │                 conn = None                                              │ │
│ │       decode_content = False                                             │ │
│ │   destination_scheme = None                                              │ │
│ │                  err = None                                              │ │
│ │              headers = {'User-Agent': 'python-requests/2.32.3',          │ │
│ │                        'Accept-Encoding': 'gzip, deflate, br, zstd',     │ │
│ │                        'Accept': '*/*', 'Connection': 'keep-alive'}      │ │
│ │ http_tunnel_required = False                                             │ │
│ │               method = 'GET'                                             │ │
│ │                new_e = NameResolutionError("<urllib3.connection.HTTPCon… │ │
│ │                        object at 0x7537a5d14110>: Failed to resolve      │ │
│ │                        'elp' ([Errno -2] Name or service not known)")    │ │
│ │           parsed_url = Url(                                              │ │
│ │                        │   scheme=None,                                  │ │
│ │                        │   auth=None,                                    │ │
│ │                        │   host=None,                                    │ │
│ │                        │   port=None,                                    │ │
│ │                        │   path='/biomart/martservice',                  │ │
│ │                        │   query='type=registry',                        │ │
│ │                        │   fragment=None                                 │ │
│ │                        )                                                 │ │
│ │         pool_timeout = None                                              │ │
│ │      preload_content = False                                             │ │
│ │             redirect = False                                             │ │
│ │         release_conn = False                                             │ │
│ │    release_this_conn = True                                              │ │
│ │        response_conn = <urllib3.connection.HTTPConnection object at      │ │
│ │                        0x7537a5d14110>                                   │ │
│ │          response_kw = {}                                                │ │
│ │              retries = Retry(total=0, connect=None, read=False,          │ │
│ │                        redirect=None, status=None)                       │ │
│ │                 self = <urllib3.connectionpool.HTTPConnectionPool object │ │
│ │                        at 0x7537b2769210>                                │ │
│ │              timeout = Timeout(connect=None, read=None, total=None)      │ │
│ │          timeout_obj = Timeout(connect=None, read=None, total=None)      │ │
│ │                  url = '/biomart/martservice?type=registry'              │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/urllib3/connectionpool.py:493 in     │
│ _make_request                                                                │
│                                                                              │
│    490 │   │   # conn.request() calls http.client.*.request, not the method  │
│    491 │   │   # urllib3.request. It also calls makefile (recv) on the socke │
│    492 │   │   try:                                                          │
│ ❱  493 │   │   │   conn.request(                                             │
│    494 │   │   │   │   method,                                               │
│    495 │   │   │   │   url,                                                  │
│    496 │   │   │   │   body=body,                                            │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │                   body = None                                            │ │
│ │                chunked = False                                           │ │
│ │                   conn = <urllib3.connection.HTTPConnection object at    │ │
│ │                          0x7537a5d14110>                                 │ │
│ │         decode_content = False                                           │ │
│ │ enforce_content_length = True                                            │ │
│ │                headers = {'User-Agent': 'python-requests/2.32.3',        │ │
│ │                          'Accept-Encoding': 'gzip, deflate, br, zstd',   │ │
│ │                          'Accept': '*/*', 'Connection': 'keep-alive'}    │ │
│ │                 method = 'GET'                                           │ │
│ │        preload_content = False                                           │ │
│ │          response_conn = <urllib3.connection.HTTPConnection object at    │ │
│ │                          0x7537a5d14110>                                 │ │
│ │                retries = Retry(total=0, connect=None, read=False,        │ │
│ │                          redirect=None, status=None)                     │ │
│ │                   self = <urllib3.connectionpool.HTTPConnectionPool      │ │
│ │                          object at 0x7537b2769210>                       │ │
│ │                timeout = Timeout(connect=None, read=None, total=None)    │ │
│ │            timeout_obj = Timeout(connect=None, read=None, total=None)    │ │
│ │                    url = '/biomart/martservice?type=registry'            │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/urllib3/connection.py:445 in request │
│                                                                              │
│    442 │   │   │   self.putheader("User-Agent", _get_default_user_agent())   │
│    443 │   │   for header, value in headers.items():                         │
│    444 │   │   │   self.putheader(header, value)                             │
│ ❱  445 │   │   self.endheaders()                                             │
│    446 │   │                                                                 │
│    447 │   │   # If we're given a body we start sending that in chunks.      │
│    448 │   │   if chunks is not None:                                        │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │                   body = None                                            │ │
│ │                chunked = False                                           │ │
│ │                 chunks = None                                            │ │
│ │          chunks_and_cl = ChunksAndContentLength(                         │ │
│ │                          │   chunks=None,                                │ │
│ │                          │   content_length=None                         │ │
│ │                          )                                               │ │
│ │         content_length = None                                            │ │
│ │         decode_content = False                                           │ │
│ │ enforce_content_length = True                                            │ │
│ │                 header = 'Connection'                                    │ │
│ │            header_keys = frozenset({                                     │ │
│ │                          │   'user-agent',                               │ │
│ │                          │   'connection',                               │ │
│ │                          │   'accept-encoding',                          │ │
│ │                          │   'accept'                                    │ │
│ │                          })                                              │ │
│ │                headers = {'User-Agent': 'python-requests/2.32.3',        │ │
│ │                          'Accept-Encoding': 'gzip, deflate, br, zstd',   │ │
│ │                          'Accept': '*/*', 'Connection': 'keep-alive'}    │ │
│ │                 method = 'GET'                                           │ │
│ │        preload_content = False                                           │ │
│ │                   self = <urllib3.connection.HTTPConnection object at    │ │
│ │                          0x7537a5d14110>                                 │ │
│ │   skip_accept_encoding = True                                            │ │
│ │              skip_host = False                                           │ │
│ │                    url = '/biomart/martservice?type=registry'            │ │
│ │                  value = 'keep-alive'                                    │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/http/client.py:1298 in endheaders                  │
│                                                                              │
│   1295 │   │   │   self.__state = _CS_REQ_SENT                               │
│   1296 │   │   else:                                                         │
│   1297 │   │   │   raise CannotSendHeader()                                  │
│ ❱ 1298 │   │   self._send_output(message_body, encode_chunked=encode_chunked │
│   1299 │                                                                     │
│   1300 │   def request(self, method, url, body=None, headers={}, *,          │
│   1301 │   │   │   │   encode_chunked=False):                                │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │ encode_chunked = False                                                   │ │
│ │   message_body = None                                                    │ │
│ │           self = <urllib3.connection.HTTPConnection object at            │ │
│ │                  0x7537a5d14110>                                         │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/http/client.py:1058 in _send_output                │
│                                                                              │
│   1055 │   │   self._buffer.extend((b"", b""))                               │
│   1056 │   │   msg = b"\r\n".join(self._buffer)                              │
│   1057 │   │   del self._buffer[:]                                           │
│ ❱ 1058 │   │   self.send(msg)                                                │
│   1059 │   │                                                                 │
│   1060 │   │   if message_body is not None:                                  │
│   1061                                                                       │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │ encode_chunked = False                                                   │ │
│ │   message_body = None                                                    │ │
│ │            msg = b'GET /biomart/martservice?type=registry                │ │
│ │                  HTTP/1.1\r\nHost: elp\r\nUser-Agent: python-r'+97       │ │
│ │           self = <urllib3.connection.HTTPConnection object at            │ │
│ │                  0x7537a5d14110>                                         │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/http/client.py:996 in send                         │
│                                                                              │
│    993 │   │                                                                 │
│    994 │   │   if self.sock is None:                                         │
│    995 │   │   │   if self.auto_open:                                        │
│ ❱  996 │   │   │   │   self.connect()                                        │
│    997 │   │   │   else:                                                     │
│    998 │   │   │   │   raise NotConnected()                                  │
│    999                                                                       │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │ data = b'GET /biomart/martservice?type=registry HTTP/1.1\r\nHost:        │ │
│ │        elp\r\nUser-Agent: python-r'+97                                   │ │
│ │ self = <urllib3.connection.HTTPConnection object at 0x7537a5d14110>      │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/urllib3/connection.py:276 in connect │
│                                                                              │
│    273 │   │   │   │   response.close()                                      │
│    274 │                                                                     │
│    275 │   def connect(self) -> None:                                        │
│ ❱  276 │   │   self.sock = self._new_conn()                                  │
│    277 │   │   if self._tunnel_host:                                         │
│    278 │   │   │   # If we're tunneling it means we're connected to our prox │
│    279 │   │   │   self._has_connected_to_proxy = True                       │
│                                                                              │
│ ╭────────────────────────────── locals ───────────────────────────────╮      │
│ │ self = <urllib3.connection.HTTPConnection object at 0x7537a5d14110> │      │
│ ╰─────────────────────────────────────────────────────────────────────╯      │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/urllib3/connection.py:205 in         │
│ _new_conn                                                                    │
│                                                                              │
│    202 │   │   │   │   socket_options=self.socket_options,                   │
│    203 │   │   │   )                                                         │
│    204 │   │   except socket.gaierror as e:                                  │
│ ❱  205 │   │   │   raise NameResolutionError(self.host, self, e) from e      │
│    206 │   │   except SocketTimeout as e:                                    │
│    207 │   │   │   raise ConnectTimeoutError(                                │
│    208 │   │   │   │   self,                                                 │
│                                                                              │
│ ╭────────────────────────────── locals ───────────────────────────────╮      │
│ │ self = <urllib3.connection.HTTPConnection object at 0x7537a5d14110> │      │
│ ╰─────────────────────────────────────────────────────────────────────╯      │
╰──────────────────────────────────────────────────────────────────────────────╯
NameResolutionError: <urllib3.connection.HTTPConnection object at 
0x7537a5d14110>: Failed to resolve 'elp' ([Errno -2] Name or service not known)

The above exception was the direct cause of the following exception:

╭───────────────────── Traceback (most recent call last) ──────────────────────╮
│ /usr/local/lib/python3.11/site-packages/requests/adapters.py:667 in send     │
│                                                                              │
│   664 │   │   │   timeout = TimeoutSauce(connect=timeout, read=timeout)      │
│   665 │   │                                                                  │
│   666 │   │   try:                                                           │
│ ❱ 667 │   │   │   resp = conn.urlopen(                                       │
│   668 │   │   │   │   method=request.method,                                 │
│   669 │   │   │   │   url=url,                                               │
│   670 │   │   │   │   body=request.body,                                     │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │    cert = None                                                           │ │
│ │ chunked = False                                                          │ │
│ │    conn = <urllib3.connectionpool.HTTPConnectionPool object at           │ │
│ │           0x7537b2769210>                                                │ │
│ │ proxies = OrderedDict()                                                  │ │
│ │ request = <PreparedRequest [GET]>                                        │ │
│ │    self = <requests.adapters.HTTPAdapter object at 0x7537a40d2050>       │ │
│ │  stream = False                                                          │ │
│ │ timeout = Timeout(connect=None, read=None, total=None)                   │ │
│ │     url = '/biomart/martservice?type=registry'                           │ │
│ │  verify = True                                                           │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/urllib3/connectionpool.py:841 in     │
│ urlopen                                                                      │
│                                                                              │
│    838 │   │   │   elif isinstance(new_e, (OSError, HTTPException)):         │
│    839 │   │   │   │   new_e = ProtocolError("Connection aborted.", new_e)   │
│    840 │   │   │                                                             │
│ ❱  841 │   │   │   retries = retries.increment(                              │
│    842 │   │   │   │   method, url, error=new_e, _pool=self, _stacktrace=sys │
│    843 │   │   │   )                                                         │
│    844 │   │   │   retries.sleep()                                           │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │     assert_same_host = False                                             │ │
│ │                 body = None                                              │ │
│ │             body_pos = None                                              │ │
│ │              chunked = False                                             │ │
│ │           clean_exit = False                                             │ │
│ │                 conn = None                                              │ │
│ │       decode_content = False                                             │ │
│ │   destination_scheme = None                                              │ │
│ │                  err = None                                              │ │
│ │              headers = {'User-Agent': 'python-requests/2.32.3',          │ │
│ │                        'Accept-Encoding': 'gzip, deflate, br, zstd',     │ │
│ │                        'Accept': '*/*', 'Connection': 'keep-alive'}      │ │
│ │ http_tunnel_required = False                                             │ │
│ │               method = 'GET'                                             │ │
│ │                new_e = NameResolutionError("<urllib3.connection.HTTPCon… │ │
│ │                        object at 0x7537a5d14110>: Failed to resolve      │ │
│ │                        'elp' ([Errno -2] Name or service not known)")    │ │
│ │           parsed_url = Url(                                              │ │
│ │                        │   scheme=None,                                  │ │
│ │                        │   auth=None,                                    │ │
│ │                        │   host=None,                                    │ │
│ │                        │   port=None,                                    │ │
│ │                        │   path='/biomart/martservice',                  │ │
│ │                        │   query='type=registry',                        │ │
│ │                        │   fragment=None                                 │ │
│ │                        )                                                 │ │
│ │         pool_timeout = None                                              │ │
│ │      preload_content = False                                             │ │
│ │             redirect = False                                             │ │
│ │         release_conn = False                                             │ │
│ │    release_this_conn = True                                              │ │
│ │        response_conn = <urllib3.connection.HTTPConnection object at      │ │
│ │                        0x7537a5d14110>                                   │ │
│ │          response_kw = {}                                                │ │
│ │              retries = Retry(total=0, connect=None, read=False,          │ │
│ │                        redirect=None, status=None)                       │ │
│ │                 self = <urllib3.connectionpool.HTTPConnectionPool object │ │
│ │                        at 0x7537b2769210>                                │ │
│ │              timeout = Timeout(connect=None, read=None, total=None)      │ │
│ │          timeout_obj = Timeout(connect=None, read=None, total=None)      │ │
│ │                  url = '/biomart/martservice?type=registry'              │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/urllib3/util/retry.py:519 in         │
│ increment                                                                    │
│                                                                              │
│   516 │   │                                                                  │
│   517 │   │   if new_retry.is_exhausted():                                   │
│   518 │   │   │   reason = error or ResponseError(cause)                     │
│ ❱ 519 │   │   │   raise MaxRetryError(_pool, url, reason) from reason  # typ │
│   520 │   │                                                                  │
│   521 │   │   log.debug("Incremented Retry for (url='%s'): %r", url, new_ret │
│   522                                                                        │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │             _pool = <urllib3.connectionpool.HTTPConnectionPool object at │ │
│ │                     0x7537b2769210>                                      │ │
│ │       _stacktrace = <traceback object at 0x7537a5a1e640>                 │ │
│ │             cause = 'unknown'                                            │ │
│ │           connect = None                                                 │ │
│ │             error = NameResolutionError("<urllib3.connection.HTTPConnec… │ │
│ │                     object at 0x7537a5d14110>: Failed to resolve 'elp'   │ │
│ │                     ([Errno -2] Name or service not known)")             │ │
│ │           history = (                                                    │ │
│ │                     │   RequestHistory(                                  │ │
│ │                     │   │   method='GET',                                │ │
│ │                     │   │   url='/biomart/martservice?type=registry',    │ │
│ │                     │   │                                                │ │
│ │                     error=NameResolutionError("<urllib3.connection.HTTP… │ │
│ │                     object at 0x7537a5d14110>: Failed to resolve 'elp'   │ │
│ │                     ([Errno -2] Name or service not known)"),            │ │
│ │                     │   │   status=None,                                 │ │
│ │                     │   │   redirect_location=None                       │ │
│ │                     │   ),                                               │ │
│ │                     )                                                    │ │
│ │            method = 'GET'                                                │ │
│ │         new_retry = Retry(total=-1, connect=None, read=False,            │ │
│ │                     redirect=None, status=None)                          │ │
│ │             other = None                                                 │ │
│ │              read = False                                                │ │
│ │            reason = NameResolutionError("<urllib3.connection.HTTPConnec… │ │
│ │                     object at 0x7537a5d14110>: Failed to resolve 'elp'   │ │
│ │                     ([Errno -2] Name or service not known)")             │ │
│ │          redirect = None                                                 │ │
│ │ redirect_location = None                                                 │ │
│ │          response = None                                                 │ │
│ │              self = Retry(total=0, connect=None, read=False,             │ │
│ │                     redirect=None, status=None)                          │ │
│ │            status = None                                                 │ │
│ │      status_count = None                                                 │ │
│ │             total = -1                                                   │ │
│ │               url = '/biomart/martservice?type=registry'                 │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
╰──────────────────────────────────────────────────────────────────────────────╯
MaxRetryError: HTTPConnectionPool(host='elp', port=80): Max retries exceeded 
with url: /biomart/martservice?type=registry (Caused by 
NameResolutionError("<urllib3.connection.HTTPConnection object at 
0x7537a5d14110>: Failed to resolve 'elp' ([Errno -2] Name or service not 
known)"))

During handling of the above exception, another exception occurred:

╭───────────────────── Traceback (most recent call last) ──────────────────────╮
│ /usr/local/lib/python3.11/site-packages/snp2cell/util.py:74 in wrapped       │
│                                                                              │
│    71 │   │   │                                                              │
│    72 │   │   │   if show_start_end:                                         │
│    73 │   │   │   │   log.debug(f"----- starting {func_name} -----")         │
│ ❱  74 │   │   │   │   r = f(*args, **kargs, log=log)                         │
│    75 │   │   │   │   log.debug(f"----- finished {func_name} -----")         │
│    76 │   │   │   else:                                                      │
│    77 │   │   │   │   r = f(*args, **kargs, log=log)                         │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │           args = ()                                                      │ │
│ │       c_format = <logging.Formatter object at 0x7537a5178f50>            │ │
│ │      c_handler = <StreamHandler <stderr> (INFO)>                         │ │
│ │      func_name = 'create_gene2pos_mapping'                               │ │
│ │          kargs = {                                                       │ │
│ │                  │   'pos2gene_csv': PosixPath('pos2gene.csv'),          │ │
│ │                  │   'host': 'elp'                                       │ │
│ │                  }                                                       │ │
│ │            log = <Logger create_gene2pos_mapping (DEBUG)>                │ │
│ │ show_start_end = True                                                    │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/snp2cell/cli.py:70 in                │
│ create_gene2pos_mapping                                                      │
│                                                                              │
│    67 │   """                                                                │
│    68 │   # query biomart to obtain genomic locations for genes              │
│    69 │   log.info(f"query biomart host: {host}")                            │
│ ❱  70 │   pos2gene = snp2cell.util.get_gene2pos_mapping(host=host, rev=True) │
│    71 │                                                                      │
│    72 │   # save to file                                                     │
│    73 │   log.info(f"save to file: {Path(pos2gene_csv).resolve()}")          │
│                                                                              │
│ ╭──────────────────────── locals ─────────────────────────╮                  │
│ │         host = 'elp'                                    │                  │
│ │          log = <Logger create_gene2pos_mapping (DEBUG)> │                  │
│ │ pos2gene_csv = PosixPath('pos2gene.csv')                │                  │
│ ╰─────────────────────────────────────────────────────────╯                  │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/snp2cell/util.py:202 in              │
│ get_gene2pos_mapping                                                         │
│                                                                              │
│   199 │                                                                      │
│   200 │   # load biomart dataset                                             │
│   201 │   server = pybiomart.Server(host=host)                               │
│ ❱ 202 │   mart = server["ENSEMBL_MART_ENSEMBL"]                              │
│   203 │   dataset = mart["hsapiens_gene_ensembl"]                            │
│   204 │                                                                      │
│   205 │   gene_df = dataset.query(                                           │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │   chrs = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', ... +12]    │ │
│ │   host = 'elp'                                                           │ │
│ │    rev = True                                                            │ │
│ │ server = <biomart.Server host='http://elp', path='/biomart/martservice', │ │
│ │          port=80>                                                        │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/pybiomart/server.py:55 in            │
│ __getitem__                                                                  │
│                                                                              │
│    52 │   │   self._marts = None                                             │
│    53 │                                                                      │
│    54 │   def __getitem__(self, name):                                       │
│ ❱  55 │   │   return self.marts[name]                                        │
│    56 │                                                                      │
│    57 │   @property                                                          │
│    58 │   def marts(self):                                                   │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │ name = 'ENSEMBL_MART_ENSEMBL'                                            │ │
│ │ self = <biomart.Server host='http://elp', path='/biomart/martservice',   │ │
│ │        port=80>                                                          │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/pybiomart/server.py:61 in marts      │
│                                                                              │
│    58 │   def marts(self):                                                   │
│    59 │   │   """List of available marts."""                                 │
│    60 │   │   if self._marts is None:                                        │
│ ❱  61 │   │   │   self._marts = self._fetch_marts()                          │
│    62 │   │   return self._marts                                             │
│    63 │                                                                      │
│    64 │   def list_marts(self):                                              │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │ self = <biomart.Server host='http://elp', path='/biomart/martservice',   │ │
│ │        port=80>                                                          │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/pybiomart/server.py:79 in            │
│ _fetch_marts                                                                 │
│                                                                              │
│    76 │   │   │   _row_gen(self.marts), columns=['name', 'display_name'])    │
│    77 │                                                                      │
│    78 │   def _fetch_marts(self):                                            │
│ ❱  79 │   │   response = self.get(type='registry')                           │
│    80 │   │                                                                  │
│    81 │   │   xml = xml_from_string(response.content)                        │
│    82 │   │   marts = [                                                      │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │ self = <biomart.Server host='http://elp', path='/biomart/martservice',   │ │
│ │        port=80>                                                          │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/pybiomart/base.py:107 in get         │
│                                                                              │
│   104 │   │                                                                  │
│   105 │   │   """                                                            │
│   106 │   │   if self._use_cache:                                            │
│ ❱ 107 │   │   │   r = requests.get(self.url, params=params)                  │
│   108 │   │   else:                                                          │
│   109 │   │   │   with requests_cache.disabled():                            │
│   110 │   │   │   │   r = requests.get(self.url, params=params)              │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │ params = {'type': 'registry'}                                            │ │
│ │   self = <biomart.Server host='http://elp', path='/biomart/martservice', │ │
│ │          port=80>                                                        │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/requests/api.py:73 in get            │
│                                                                              │
│    70 │   :rtype: requests.Response                                          │
│    71 │   """                                                                │
│    72 │                                                                      │
│ ❱  73 │   return request("get", url, params=params, **kwargs)                │
│    74                                                                        │
│    75                                                                        │
│    76 def options(url, **kwargs):                                            │
│                                                                              │
│ ╭─────────────────── locals ───────────────────╮                             │
│ │ kwargs = {}                                  │                             │
│ │ params = {'type': 'registry'}                │                             │
│ │    url = 'http://elp:80/biomart/martservice' │                             │
│ ╰──────────────────────────────────────────────╯                             │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/requests/api.py:59 in request        │
│                                                                              │
│    56 │   # avoid leaving sockets open which can trigger a ResourceWarning i │
│    57 │   # cases, and look like a memory leak in others.                    │
│    58 │   with sessions.Session() as session:                                │
│ ❱  59 │   │   return session.request(method=method, url=url, **kwargs)       │
│    60                                                                        │
│    61                                                                        │
│    62 def get(url, params=None, **kwargs):                                   │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │  kwargs = {'params': {'type': 'registry'}}                               │ │
│ │  method = 'get'                                                          │ │
│ │ session = <CachedSession(BaseCache('.pybiomart', ...),                   │ │
│ │           expire_after=None, allowable_methods=('GET',))>                │ │
│ │     url = 'http://elp:80/biomart/martservice'                            │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/requests_cache/core.py:122 in        │
│ request                                                                      │
│                                                                              │
│   119 │   │   return response                                                │
│   120 │                                                                      │
│   121 │   def request(self, method, url, params=None, data=None, **kwargs):  │
│ ❱ 122 │   │   response = super(CachedSession, self).request(                 │
│   123 │   │   │   method, url,                                               │
│   124 │   │   │   _normalize_parameters(params),                             │
│   125 │   │   │   _normalize_parameters(data),                               │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │   data = None                                                            │ │
│ │ kwargs = {}                                                              │ │
│ │ method = 'get'                                                           │ │
│ │ params = {'type': 'registry'}                                            │ │
│ │   self = <CachedSession(BaseCache('.pybiomart', ...), expire_after=None, │ │
│ │          allowable_methods=('GET',))>                                    │ │
│ │    url = 'http://elp:80/biomart/martservice'                             │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/requests/sessions.py:589 in request  │
│                                                                              │
│   586 │   │   │   "allow_redirects": allow_redirects,                        │
│   587 │   │   }                                                              │
│   588 │   │   send_kwargs.update(settings)                                   │
│ ❱ 589 │   │   resp = self.send(prep, **send_kwargs)                          │
│   590 │   │                                                                  │
│   591 │   │   return resp                                                    │
│   592                                                                        │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │ allow_redirects = True                                                   │ │
│ │            auth = None                                                   │ │
│ │            cert = None                                                   │ │
│ │         cookies = None                                                   │ │
│ │            data = None                                                   │ │
│ │           files = None                                                   │ │
│ │         headers = None                                                   │ │
│ │           hooks = None                                                   │ │
│ │            json = None                                                   │ │
│ │          method = 'get'                                                  │ │
│ │          params = [('type', 'registry')]                                 │ │
│ │            prep = <PreparedRequest [GET]>                                │ │
│ │         proxies = {}                                                     │ │
│ │             req = <Request [GET]>                                        │ │
│ │            self = <CachedSession(BaseCache('.pybiomart', ...),           │ │
│ │                   expire_after=None, allowable_methods=('GET',))>        │ │
│ │     send_kwargs = {                                                      │ │
│ │                   │   'timeout': None,                                   │ │
│ │                   │   'allow_redirects': True,                           │ │
│ │                   │   'proxies': OrderedDict(),                          │ │
│ │                   │   'stream': False,                                   │ │
│ │                   │   'verify': True,                                    │ │
│ │                   │   'cert': None                                       │ │
│ │                   }                                                      │ │
│ │        settings = {                                                      │ │
│ │                   │   'proxies': OrderedDict(),                          │ │
│ │                   │   'stream': False,                                   │ │
│ │                   │   'verify': True,                                    │ │
│ │                   │   'cert': None                                       │ │
│ │                   }                                                      │ │
│ │          stream = None                                                   │ │
│ │         timeout = None                                                   │ │
│ │             url = 'http://elp:80/biomart/martservice'                    │ │
│ │          verify = None                                                   │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/requests_cache/core.py:99 in send    │
│                                                                              │
│    96 │   │                                                                  │
│    97 │   │   response, timestamp = self.cache.get_response_and_time(cache_k │
│    98 │   │   if response is None:                                           │
│ ❱  99 │   │   │   return send_request_and_cache_response()                   │
│   100 │   │                                                                  │
│   101 │   │   if self._cache_expire_after is not None:                       │
│   102 │   │   │   is_expired = datetime.utcnow() - timestamp > self._cache_e │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │ cache_key = 'a0e18f40a37aabf1e20e7a1d6ed175ddb0423efdc8a734230acccffd66… │ │
│ │    kwargs = {                                                            │ │
│ │             │   'timeout': None,                                         │ │
│ │             │   'allow_redirects': True,                                 │ │
│ │             │   'proxies': OrderedDict(),                                │ │
│ │             │   'stream': False,                                         │ │
│ │             │   'verify': True,                                          │ │
│ │             │   'cert': None                                             │ │
│ │             }                                                            │ │
│ │   request = <PreparedRequest [GET]>                                      │ │
│ │  response = None                                                         │ │
│ │      self = <CachedSession(BaseCache('.pybiomart', ...),                 │ │
│ │             expire_after=None, allowable_methods=('GET',))>              │ │
│ │ timestamp = None                                                         │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/requests_cache/core.py:91 in         │
│ send_request_and_cache_response                                              │
│                                                                              │
│    88 │   │   cache_key = self.cache.create_key(request)                     │
│    89 │   │                                                                  │
│    90 │   │   def send_request_and_cache_response():                         │
│ ❱  91 │   │   │   response = super(CachedSession, self).send(request, **kwar │
│    92 │   │   │   if response.status_code in self._cache_allowable_codes:    │
│    93 │   │   │   │   self.cache.save_response(cache_key, response)          │
│    94 │   │   │   response.from_cache = False                                │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │ cache_key = 'a0e18f40a37aabf1e20e7a1d6ed175ddb0423efdc8a734230acccffd66… │ │
│ │    kwargs = {                                                            │ │
│ │             │   'timeout': None,                                         │ │
│ │             │   'allow_redirects': True,                                 │ │
│ │             │   'proxies': OrderedDict(),                                │ │
│ │             │   'stream': False,                                         │ │
│ │             │   'verify': True,                                          │ │
│ │             │   'cert': None                                             │ │
│ │             }                                                            │ │
│ │   request = <PreparedRequest [GET]>                                      │ │
│ │      self = <CachedSession(BaseCache('.pybiomart', ...),                 │ │
│ │             expire_after=None, allowable_methods=('GET',))>              │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/requests/sessions.py:703 in send     │
│                                                                              │
│   700 │   │   start = preferred_clock()                                      │
│   701 │   │                                                                  │
│   702 │   │   # Send the request                                             │
│ ❱ 703 │   │   r = adapter.send(request, **kwargs)                            │
│   704 │   │                                                                  │
│   705 │   │   # Total elapsed time of the request (approximately)            │
│   706 │   │   elapsed = preferred_clock() - start                            │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │         adapter = <requests.adapters.HTTPAdapter object at               │ │
│ │                   0x7537a40d2050>                                        │ │
│ │ allow_redirects = True                                                   │ │
│ │           hooks = {'response': []}                                       │ │
│ │          kwargs = {                                                      │ │
│ │                   │   'timeout': None,                                   │ │
│ │                   │   'proxies': OrderedDict(),                          │ │
│ │                   │   'stream': False,                                   │ │
│ │                   │   'verify': True,                                    │ │
│ │                   │   'cert': None                                       │ │
│ │                   }                                                      │ │
│ │         request = <PreparedRequest [GET]>                                │ │
│ │            self = <CachedSession(BaseCache('.pybiomart', ...),           │ │
│ │                   expire_after=None, allowable_methods=('GET',))>        │ │
│ │           start = 1772001681.1728415                                     │ │
│ │          stream = False                                                  │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
│                                                                              │
│ /usr/local/lib/python3.11/site-packages/requests/adapters.py:700 in send     │
│                                                                              │
│   697 │   │   │   │   # This branch is for urllib3 v1.22 and later.          │
│   698 │   │   │   │   raise SSLError(e, request=request)                     │
│   699 │   │   │                                                              │
│ ❱ 700 │   │   │   raise ConnectionError(e, request=request)                  │
│   701 │   │                                                                  │
│   702 │   │   except ClosedPoolError as e:                                   │
│   703 │   │   │   raise ConnectionError(e, request=request)                  │
│                                                                              │
│ ╭───────────────────────────────── locals ─────────────────────────────────╮ │
│ │    cert = None                                                           │ │
│ │ chunked = False                                                          │ │
│ │    conn = <urllib3.connectionpool.HTTPConnectionPool object at           │ │
│ │           0x7537b2769210>                                                │ │
│ │ proxies = OrderedDict()                                                  │ │
│ │ request = <PreparedRequest [GET]>                                        │ │
│ │    self = <requests.adapters.HTTPAdapter object at 0x7537a40d2050>       │ │
│ │  stream = False                                                          │ │
│ │ timeout = Timeout(connect=None, read=None, total=None)                   │ │
│ │     url = '/biomart/martservice?type=registry'                           │ │
│ │  verify = True                                                           │ │
│ ╰──────────────────────────────────────────────────────────────────────────╯ │
╰──────────────────────────────────────────────────────────────────────────────╯
ConnectionError: HTTPConnectionPool(host='elp', port=80): Max retries exceeded 
with url: /biomart/martservice?type=registry (Caused by 
NameResolutionError("<urllib3.connection.HTTPConnection object at 
0x7537a5d14110>: Failed to resolve 'elp' ([Errno -2] Name or service not 
known)"))
```


## snp2cell_export-locations

### Tool Description
Save the genomic locations of network nodes in the s2c object to a tsv file.

### Metadata
- **Docker Image**: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Teichlab/snp2cell
- **Package**: https://anaconda.org/channels/bioconda/packages/snp2cell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snp2cell export-locations [OPTIONS] S2C_OBJ                             
                                                                                
 Save the genomic locations of network nodes in the s2c object to a tsv file.   
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    s2c_obj      PATH  path to SNP2CELL object [default: None] [required]   │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --output    -o      PATH  output path for regions                            │
│                           [default: peak_locations.txt]                      │
│ --pos2gene  -p      PATH  csv file with no header and location               │
│                           (chrX:XXX-XXX) to gene symbol mapping. If not      │
│                           provided, no mapping will be done. If a path is    │
│                           provided the mapping will be read from the file.   │
│                           If a URL is provided, the mapping will be queried  │
│                           from biomart.                                      │
│                           [default: None]                                    │
│ --help                    Show this message and exit.                        │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## snp2cell_score-snp

### Tool Description
Add fGWAS scores for network nodes based on GWAS summary statistics. Then propagate the scores across the network and calculate statistics based on random permutations. All calculated information will be saved in the s2c object.

### Metadata
- **Docker Image**: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Teichlab/snp2cell
- **Package**: https://anaconda.org/channels/bioconda/packages/snp2cell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snp2cell score-snp [OPTIONS] S2C_OBJ FGWAS_OUTPUT_PATH REGION_LOC_PATH  
                                                                                
 Add fGWAS scores for network nodes based on GWAS summary statistics. Then      
 propagate the scores across the network and calculate statistics based on      
 random permutations. All calculated information will be saved in the s2c       
 object.                                                                        
 This assumes the nf-fgwas pipeline (https://github.com/cellgeni/nf-fgwas) has  
 been run. The nf-fgwas output file should then be in a folder like             
 `results/LDSC_results/<studyid>/input.gz`. The region location file (nf-fgwas  
 input) can be generated with `export_for_fgwas()`.                             
 Calculated Regional Bayes Factors (RBF) can be saved to a table by setting     
 --output-table. The columns in the output file correspond to: region ID, SNP   
 log BF, SNP log weight including distance and LD score.                        
 For the scores added to the snp2cell object, the region locations are expanded 
 to the full length of the region (`--lexpand` and `--rexpand`). This is        
 assuming that each region was represented by its center for the fgwas analysis 
 and that all regions have the same length (default 500bp). If this is not the  
 case, you can use the returned data frame and expand the regions manually.     
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    s2c_obj                PATH  path to SNP2CELL object [default: None]    │
│                                   [required]                                 │
│ *    fgwas_output_path      PATH  path to tsv.gz file with SNP Bayes factors │
│                                   and weights per region calculated by       │
│                                   nf-fgwas                                   │
│                                   [default: None]                            │
│                                   [required]                                 │
│ *    region_loc_path        PATH  path to tsv file with genomic locations of │
│                                   regions (result from `export_locations()`) │
│                                   [default: None]                            │
│                                   [required]                                 │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --output-table  -o      PATH     path for saving the Regional Bayes Factors  │
│                                  (RBF) as a table. If not provided, the      │
│                                  table will not be saved.                    │
│                                  [default: None]                             │
│ --save-key      -k      TEXT     name for saving scores in object            │
│                                  [default: snp_score]                        │
│ --lexpand       -l      INTEGER  number of base pairs to expand the region   │
│                                  to the left                                 │
│                                  [default: 250]                              │
│ --rexpand       -r      INTEGER  number of base pairs to expand the region   │
│                                  to the right                                │
│                                  [default: 250]                              │
│ --pos2gene      -p      PATH     csv file with no header and location        │
│                                  (chrX:XXX-XXX) to gene symbol mapping. If   │
│                                  not provided, no mapping will be done. If a │
│                                  path is provided the mapping will be read   │
│                                  from the file. If a URL is provided, the    │
│                                  mapping will be queried from biomart.       │
│                                  [default: None]                             │
│ --n-cpu                 INTEGER  number of cpus to use [default: None]       │
│ --help                           Show this message and exit.                 │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## snp2cell_add-score

### Tool Description
Add scores for network nodes to the s2c object and propagate the scores across the network.

### Metadata
- **Docker Image**: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Teichlab/snp2cell
- **Package**: https://anaconda.org/channels/bioconda/packages/snp2cell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snp2cell add-score [OPTIONS] S2C_OBJ SCORE_FILE                         
                                                                                
 Add scores for network nodes to the s2c object and propagate the scores across 
 the network.                                                                   
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    s2c_obj         PATH  path to SNP2CELL object [default: None]           │
│                            [required]                                        │
│ *    score_file      PATH  Path to tsv file with scores for network nodes.   │
│                            Assuming there is no header and the first column  │
│                            contains the node names, the second column the    │
│                            scores.                                           │
│                            [default: None]                                   │
│                            [required]                                        │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --save-key  -k      TEXT     name for saving scores in object                │
│                              [default: snp_score]                            │
│ --pos2gene  -p      PATH     csv file with no header and location            │
│                              (chrX:XXX-XXX) to gene symbol mapping. If not   │
│                              provided, no mapping will be done. If a path is │
│                              provided the mapping will be read from the      │
│                              file. If a URL is provided, the mapping will be │
│                              queried from biomart.                           │
│                              [default: None]                                 │
│ --n-cpu             INTEGER  number of cpus to use [default: None]           │
│ --help                       Show this message and exit.                     │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## snp2cell_contrast-scores

### Tool Description
Add a new score that is a contrast of two scores, propagate it across the network and calculate statistics based on random permutations.

### Metadata
- **Docker Image**: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Teichlab/snp2cell
- **Package**: https://anaconda.org/channels/bioconda/packages/snp2cell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snp2cell contrast-scores [OPTIONS] S2C_OBJ SCORE_KEY1 SCORE_KEY2        
                                                                                
 Add a new score that is a contrast of two scores, propagate it across the      
 network and calculate statistics based on random permutations.                 
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    s2c_obj         PATH  path to SNP2CELL object [default: None]           │
│                            [required]                                        │
│ *    score_key1      TEXT  key for scores stored in object (main)            │
│                            [default: None]                                   │
│                            [required]                                        │
│ *    score_key2      TEXT  key for scores stored in object (reference)       │
│                            [default: None]                                   │
│                            [required]                                        │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --save-key  -k      TEXT     name for saving scores in object; default:      │
│                              `(score_key1 - score_key2)`                     │
│                              [default: None]                                 │
│ --n-cpu             INTEGER  number of cpus to use [default: None]           │
│ --help                       Show this message and exit.                     │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## snp2cell_score-de

### Tool Description
Add an anndata object to the s2c object, find differentially expressed genes and propagate the gene scores across the network. Then the DE scores and previously computed SNP scores are combined and statistics are computed based on random permutations.

### Metadata
- **Docker Image**: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Teichlab/snp2cell
- **Package**: https://anaconda.org/channels/bioconda/packages/snp2cell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snp2cell score-de [OPTIONS] S2C_OBJ ANNDATA [GROUPBY]                   
                                                                                
 Add an anndata object to the s2c object, find differentially expressed genes   
 and propagate the gene scores across the network. Then the DE scores and       
 previously computed SNP scores are combined and statistics are computed based  
 on random permutations.                                                        
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    s2c_obj      PATH       path to SNP2CELL object [default: None]         │
│                              [required]                                      │
│ *    anndata      PATH       path to anndata object [default: None]          │
│                              [required]                                      │
│      groupby      [GROUPBY]  `ad.obs` column with annotation for computing   │
│                              differential expression                         │
│                              [default: annot]                                │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --run-lognorm        --no-run-lognorm                   log-normalise counts │
│                                                         [default:            │
│                                                         no-run-lognorm]      │
│ --use-raw            --no-use-raw                       use `ad.raw`         │
│                                                         attribute            │
│                                                         [default:            │
│                                                         no-use-raw]          │
│ --group          -g                      TEXT           restrict to groups   │
│                                                         of `groupby`; may be │
│                                                         set multiple times;  │
│                                                         default is to use    │
│                                                         all groups           │
│                                                         [default: None]      │
│ --reference                              TEXT           reference group to   │
│                                                         compare against;     │
│                                                         default is to        │
│                                                         compare against the  │
│                                                         rest                 │
│                                                         [default: rest]      │
│ --method                                 TEXT           method for DE        │
│                                                         calculation          │
│                                                         [default: wilcoxon]  │
│ --rank-by        -r                      [abs|up|down]  rank DE scores by    │
│                                                         absolute value, up-  │
│                                                         or downregulation;   │
│                                                         default:             │
│                                                         upregulation         │
│                                                         [default: up]        │
│ --snp-score-key  -k                      TEXT           key for accessing    │
│                                                         saved snp scores in  │
│                                                         object               │
│                                                         [default: snp_score] │
│ --n-cpu          -c                      INTEGER        number of cpus to    │
│                                                         use                  │
│                                                         [default: None]      │
│ --help                                                  Show this message    │
│                                                         and exit.            │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## snp2cell_combine-scores

### Tool Description
Assuming that both a SNP score and DE scores have been added to the s2c object, combine SNP score with DE scores and compute statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/snp2cell:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Teichlab/snp2cell
- **Package**: https://anaconda.org/channels/bioconda/packages/snp2cell/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: snp2cell combine-scores [OPTIONS] S2C_OBJ [GROUPBY] [SNP_SCORE_KEY]     
                                                                                
 Assuming that both a SNP score and DE scores have been added to the s2c        
 object, combine SNP score with DE scores and compute statistics.               
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    s2c_obj            PATH             path to SNP2CELL object             │
│                                          [default: None]                     │
│                                          [required]                          │
│      groupby            [GROUPBY]        `ad.obs` column with annotation     │
│                                          used for DE scores                  │
│                                          [default: annot]                    │
│      snp_score_key      [SNP_SCORE_KEY]  key for accessing saved snp scores  │
│                                          in object                           │
│                                          [default: snp_score]                │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help          Show this message and exit.                                  │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## Metadata
- **Skill**: generated
