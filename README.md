# Docker + [mitmproxy](https://mitmproxy.org/) = ❤️

[mitmproxy](https://mitmproxy.org/) is a very powerful interactive proxy for intercepting HTTP/HTTPS communication.

On this image, we change the behavior of creating a new CA on each startup. 
By doing this, any time you restart the container, the CA will remain the same.
This strategy is for development environment only! 

`You must import a certificate version from ca-fixed folder.`

Current CA Info:
```
Issued On	Tuesday, August 27, 2019 at 10:12:33 PM
Expires On	Saturday, August 28, 2021 at 10:12:33 PM
```

## Start the proxy

1. Clone this repository

```bash
git clone git@github.com:brunowdev/mitmproxy-docker.git
cd mitmproxy-docker
```

2. Start the Docker container and mount project root as a `/data` volume.

```bash
./run.sh
```

3. Open mitmproxy's web console in the browser: http://127.0.0.1:8081

4. Try it out

```
curl --proxy localhost:8080 -X GET http://old.host.com
```

## Example scripts
Scripts can be used for intercepting requests passing throught the proxy. In the [scripts](./scripts) directory you can find some basic examples ready for use.

You can point to the script (or multiple scripts) when starting the container and you can switch to another script any time later from the web console (in the Options). Scripts are also reloaded whenever you modify them.


1. [Redirecting requests](./scripts/redirect.py)
```python
"""
This example shows two ways to redirect flows to another server.
"""
from mitmproxy import http

def request(flow: http.HTTPFlow) -> None:
    # pretty_host takes the "Host" header of the request into account,
    # which is useful in transparent mode where we usually only have the IP
    # otherwise.
    if flow.request.pretty_host == "original.host.com":
        flow.request.host = "new.host.com"
```
2. [Response modification](./scripts/modify_response.py)

More examples are in mitmproxy's [GitHub repository]( https://github.com/mitmproxy/mitmproxy/tree/master/examples).