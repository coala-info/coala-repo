# galileo CWL Generation Report

## galileo_version

### Tool Description
synchronize Fitbit trackers with Fitbit web service

### Metadata
- **Docker Image**: biocontainers/galileo:v0.5.1-6-deb_cv1
- **Homepage**: https://github.com/JaredC01/Galileo2
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/galileo/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/JaredC01/Galileo2
- **Stars**: N/A
### Original Help Text
```text
usage: galileo [-h] [-c RCCONFIGNAME] [--dump-dir DUMP-DIR]
               [--daemon-period DAEMON-PERIOD] [-I ID [ID ...]]
               [-X ID [ID ...]] [-v | -d | -q] [--force | --no-force]
               [--dump | --no-dump] [--upload | --no-upload]
               [--https-only | --no-https-only] [-s FITBIT-SERVER]
               [--log-size LOG-SIZE] [--syslog | --no-syslog]
               [{version,sync,daemon,pair,firmware,interactive}]

synchronize Fitbit trackers with Fitbit web service

positional arguments:
  {version,sync,daemon,pair,firmware,interactive}
                        The mode to run (default to sync)

optional arguments:
  -h, --help            show this help message and exit
  -c RCCONFIGNAME, --config RCCONFIGNAME
                        use alternative configuration file (default to None)
  --dump-dir DUMP-DIR   directory for storing dumps (default to ~/.galileo)
  --daemon-period DAEMON-PERIOD
                        sleep time in msec between sync runs when in daemon
                        mode (default to 15000)
  -I ID [ID ...], --include ID [ID ...]
                        list of tracker IDs to sync (all if not specified)
  -X ID [ID ...], --exclude ID [ID ...]
                        list of tracker IDs to not sync
  -s FITBIT-SERVER, --fitbit-server FITBIT-SERVER
                        server used for synchronisation (default to
                        client.fitbit.com)
  --log-size LOG-SIZE   Amount of communication to display in case of error
                        (default to 10)

logging Verbosity:
  -v, --verbose         display synchronization progress
  -d, --debug           show internal activity (implies verbose)
  -q, --quiet           only show errors and summary (default)

  whether or not to synchronize even if tracker reports a recent sync

  --force
  --no-force            DEFAULT

  whether or not to enable saving of the megadump to file

  --dump                DEFAULT
  --no-dump

  whether or not to upload the dump to the server

  --upload              DEFAULT
  --no-upload

  whether or not to use http if https is not available

  --https-only          DEFAULT
  --no-https-only

  whether or not to send output to syslog instead of stderr

  --syslog
  --no-syslog           DEFAULT

Access your synchronized data at http://www.fitbit.com.
```


## galileo_sync

### Tool Description
synchronize Fitbit trackers with Fitbit web service

### Metadata
- **Docker Image**: biocontainers/galileo:v0.5.1-6-deb_cv1
- **Homepage**: https://github.com/JaredC01/Galileo2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: galileo [-h] [-c RCCONFIGNAME] [--dump-dir DUMP-DIR]
               [--daemon-period DAEMON-PERIOD] [-I ID [ID ...]]
               [-X ID [ID ...]] [-v | -d | -q] [--force | --no-force]
               [--dump | --no-dump] [--upload | --no-upload]
               [--https-only | --no-https-only] [-s FITBIT-SERVER]
               [--log-size LOG-SIZE] [--syslog | --no-syslog]
               [{version,sync,daemon,pair,firmware,interactive}]

synchronize Fitbit trackers with Fitbit web service

positional arguments:
  {version,sync,daemon,pair,firmware,interactive}
                        The mode to run (default to sync)

optional arguments:
  -h, --help            show this help message and exit
  -c RCCONFIGNAME, --config RCCONFIGNAME
                        use alternative configuration file (default to None)
  --dump-dir DUMP-DIR   directory for storing dumps (default to ~/.galileo)
  --daemon-period DAEMON-PERIOD
                        sleep time in msec between sync runs when in daemon
                        mode (default to 15000)
  -I ID [ID ...], --include ID [ID ...]
                        list of tracker IDs to sync (all if not specified)
  -X ID [ID ...], --exclude ID [ID ...]
                        list of tracker IDs to not sync
  -s FITBIT-SERVER, --fitbit-server FITBIT-SERVER
                        server used for synchronisation (default to
                        client.fitbit.com)
  --log-size LOG-SIZE   Amount of communication to display in case of error
                        (default to 10)

logging Verbosity:
  -v, --verbose         display synchronization progress
  -d, --debug           show internal activity (implies verbose)
  -q, --quiet           only show errors and summary (default)

  whether or not to synchronize even if tracker reports a recent sync

  --force
  --no-force            DEFAULT

  whether or not to enable saving of the megadump to file

  --dump                DEFAULT
  --no-dump

  whether or not to upload the dump to the server

  --upload              DEFAULT
  --no-upload

  whether or not to use http if https is not available

  --https-only          DEFAULT
  --no-https-only

  whether or not to send output to syslog instead of stderr

  --syslog
  --no-syslog           DEFAULT

Access your synchronized data at http://www.fitbit.com.
```


## galileo_daemon

### Tool Description
synchronize Fitbit trackers with Fitbit web service

### Metadata
- **Docker Image**: biocontainers/galileo:v0.5.1-6-deb_cv1
- **Homepage**: https://github.com/JaredC01/Galileo2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: galileo [-h] [-c RCCONFIGNAME] [--dump-dir DUMP-DIR]
               [--daemon-period DAEMON-PERIOD] [-I ID [ID ...]]
               [-X ID [ID ...]] [-v | -d | -q] [--force | --no-force]
               [--dump | --no-dump] [--upload | --no-upload]
               [--https-only | --no-https-only] [-s FITBIT-SERVER]
               [--log-size LOG-SIZE] [--syslog | --no-syslog]
               [{version,sync,daemon,pair,firmware,interactive}]

synchronize Fitbit trackers with Fitbit web service

positional arguments:
  {version,sync,daemon,pair,firmware,interactive}
                        The mode to run (default to sync)

optional arguments:
  -h, --help            show this help message and exit
  -c RCCONFIGNAME, --config RCCONFIGNAME
                        use alternative configuration file (default to None)
  --dump-dir DUMP-DIR   directory for storing dumps (default to ~/.galileo)
  --daemon-period DAEMON-PERIOD
                        sleep time in msec between sync runs when in daemon
                        mode (default to 15000)
  -I ID [ID ...], --include ID [ID ...]
                        list of tracker IDs to sync (all if not specified)
  -X ID [ID ...], --exclude ID [ID ...]
                        list of tracker IDs to not sync
  -s FITBIT-SERVER, --fitbit-server FITBIT-SERVER
                        server used for synchronisation (default to
                        client.fitbit.com)
  --log-size LOG-SIZE   Amount of communication to display in case of error
                        (default to 10)

logging Verbosity:
  -v, --verbose         display synchronization progress
  -d, --debug           show internal activity (implies verbose)
  -q, --quiet           only show errors and summary (default)

  whether or not to synchronize even if tracker reports a recent sync

  --force
  --no-force            DEFAULT

  whether or not to enable saving of the megadump to file

  --dump                DEFAULT
  --no-dump

  whether or not to upload the dump to the server

  --upload              DEFAULT
  --no-upload

  whether or not to use http if https is not available

  --https-only          DEFAULT
  --no-https-only

  whether or not to send output to syslog instead of stderr

  --syslog
  --no-syslog           DEFAULT

Access your synchronized data at http://www.fitbit.com.
```


## galileo_pair

### Tool Description
synchronize Fitbit trackers with Fitbit web service

### Metadata
- **Docker Image**: biocontainers/galileo:v0.5.1-6-deb_cv1
- **Homepage**: https://github.com/JaredC01/Galileo2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: galileo [-h] [-c RCCONFIGNAME] [--dump-dir DUMP-DIR]
               [--daemon-period DAEMON-PERIOD] [-I ID [ID ...]]
               [-X ID [ID ...]] [-v | -d | -q] [--force | --no-force]
               [--dump | --no-dump] [--upload | --no-upload]
               [--https-only | --no-https-only] [-s FITBIT-SERVER]
               [--log-size LOG-SIZE] [--syslog | --no-syslog]
               [{version,sync,daemon,pair,firmware,interactive}]

synchronize Fitbit trackers with Fitbit web service

positional arguments:
  {version,sync,daemon,pair,firmware,interactive}
                        The mode to run (default to sync)

optional arguments:
  -h, --help            show this help message and exit
  -c RCCONFIGNAME, --config RCCONFIGNAME
                        use alternative configuration file (default to None)
  --dump-dir DUMP-DIR   directory for storing dumps (default to ~/.galileo)
  --daemon-period DAEMON-PERIOD
                        sleep time in msec between sync runs when in daemon
                        mode (default to 15000)
  -I ID [ID ...], --include ID [ID ...]
                        list of tracker IDs to sync (all if not specified)
  -X ID [ID ...], --exclude ID [ID ...]
                        list of tracker IDs to not sync
  -s FITBIT-SERVER, --fitbit-server FITBIT-SERVER
                        server used for synchronisation (default to
                        client.fitbit.com)
  --log-size LOG-SIZE   Amount of communication to display in case of error
                        (default to 10)

logging Verbosity:
  -v, --verbose         display synchronization progress
  -d, --debug           show internal activity (implies verbose)
  -q, --quiet           only show errors and summary (default)

  whether or not to synchronize even if tracker reports a recent sync

  --force
  --no-force            DEFAULT

  whether or not to enable saving of the megadump to file

  --dump                DEFAULT
  --no-dump

  whether or not to upload the dump to the server

  --upload              DEFAULT
  --no-upload

  whether or not to use http if https is not available

  --https-only          DEFAULT
  --no-https-only

  whether or not to send output to syslog instead of stderr

  --syslog
  --no-syslog           DEFAULT

Access your synchronized data at http://www.fitbit.com.
```


## galileo_firmware

### Tool Description
synchronize Fitbit trackers with Fitbit web service

### Metadata
- **Docker Image**: biocontainers/galileo:v0.5.1-6-deb_cv1
- **Homepage**: https://github.com/JaredC01/Galileo2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: galileo [-h] [-c RCCONFIGNAME] [--dump-dir DUMP-DIR]
               [--daemon-period DAEMON-PERIOD] [-I ID [ID ...]]
               [-X ID [ID ...]] [-v | -d | -q] [--force | --no-force]
               [--dump | --no-dump] [--upload | --no-upload]
               [--https-only | --no-https-only] [-s FITBIT-SERVER]
               [--log-size LOG-SIZE] [--syslog | --no-syslog]
               [{version,sync,daemon,pair,firmware,interactive}]

synchronize Fitbit trackers with Fitbit web service

positional arguments:
  {version,sync,daemon,pair,firmware,interactive}
                        The mode to run (default to sync)

optional arguments:
  -h, --help            show this help message and exit
  -c RCCONFIGNAME, --config RCCONFIGNAME
                        use alternative configuration file (default to None)
  --dump-dir DUMP-DIR   directory for storing dumps (default to ~/.galileo)
  --daemon-period DAEMON-PERIOD
                        sleep time in msec between sync runs when in daemon
                        mode (default to 15000)
  -I ID [ID ...], --include ID [ID ...]
                        list of tracker IDs to sync (all if not specified)
  -X ID [ID ...], --exclude ID [ID ...]
                        list of tracker IDs to not sync
  -s FITBIT-SERVER, --fitbit-server FITBIT-SERVER
                        server used for synchronisation (default to
                        client.fitbit.com)
  --log-size LOG-SIZE   Amount of communication to display in case of error
                        (default to 10)

logging Verbosity:
  -v, --verbose         display synchronization progress
  -d, --debug           show internal activity (implies verbose)
  -q, --quiet           only show errors and summary (default)

  whether or not to synchronize even if tracker reports a recent sync

  --force
  --no-force            DEFAULT

  whether or not to enable saving of the megadump to file

  --dump                DEFAULT
  --no-dump

  whether or not to upload the dump to the server

  --upload              DEFAULT
  --no-upload

  whether or not to use http if https is not available

  --https-only          DEFAULT
  --no-https-only

  whether or not to send output to syslog instead of stderr

  --syslog
  --no-syslog           DEFAULT

Access your synchronized data at http://www.fitbit.com.
```


## galileo_interactive

### Tool Description
synchronize Fitbit trackers with Fitbit web service

### Metadata
- **Docker Image**: biocontainers/galileo:v0.5.1-6-deb_cv1
- **Homepage**: https://github.com/JaredC01/Galileo2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
usage: galileo [-h] [-c RCCONFIGNAME] [--dump-dir DUMP-DIR]
               [--daemon-period DAEMON-PERIOD] [-I ID [ID ...]]
               [-X ID [ID ...]] [-v | -d | -q] [--force | --no-force]
               [--dump | --no-dump] [--upload | --no-upload]
               [--https-only | --no-https-only] [-s FITBIT-SERVER]
               [--log-size LOG-SIZE] [--syslog | --no-syslog]
               [{version,sync,daemon,pair,firmware,interactive}]

synchronize Fitbit trackers with Fitbit web service

positional arguments:
  {version,sync,daemon,pair,firmware,interactive}
                        The mode to run (default to sync)

optional arguments:
  -h, --help            show this help message and exit
  -c RCCONFIGNAME, --config RCCONFIGNAME
                        use alternative configuration file (default to None)
  --dump-dir DUMP-DIR   directory for storing dumps (default to ~/.galileo)
  --daemon-period DAEMON-PERIOD
                        sleep time in msec between sync runs when in daemon
                        mode (default to 15000)
  -I ID [ID ...], --include ID [ID ...]
                        list of tracker IDs to sync (all if not specified)
  -X ID [ID ...], --exclude ID [ID ...]
                        list of tracker IDs to not sync
  -s FITBIT-SERVER, --fitbit-server FITBIT-SERVER
                        server used for synchronisation (default to
                        client.fitbit.com)
  --log-size LOG-SIZE   Amount of communication to display in case of error
                        (default to 10)

logging Verbosity:
  -v, --verbose         display synchronization progress
  -d, --debug           show internal activity (implies verbose)
  -q, --quiet           only show errors and summary (default)

  whether or not to synchronize even if tracker reports a recent sync

  --force
  --no-force            DEFAULT

  whether or not to enable saving of the megadump to file

  --dump                DEFAULT
  --no-dump

  whether or not to upload the dump to the server

  --upload              DEFAULT
  --no-upload

  whether or not to use http if https is not available

  --https-only          DEFAULT
  --no-https-only

  whether or not to send output to syslog instead of stderr

  --syslog
  --no-syslog           DEFAULT

Access your synchronized data at http://www.fitbit.com.
```


## Metadata
- **Skill**: generated
