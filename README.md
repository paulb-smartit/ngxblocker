# Nginx with ngxblocker and goaccess

This project serves as an example for server and client caching.

Ngx Blocker blocks bad bots from accessing the web resources.

Go Access is an Nginx log file analyser/reporter.

When running you can visit [http://localhost:8080/goaccess](http://localhost:8080/goaccess) and see the real time go access report.

## Nginx

Nginx is configured to serve as a reverse proxy to an upstream server called `eight` on port 8081.

Caching examples allow `/document/downloads` to be cached at the server for 3 minutes

The server does NOT cache requests to `/`.

The specified static extensions are passed to the client and hte client is asked to cache them for 5 minutes.

If you watch the logs of the reverse proxy and the backend server (`eight`) you will see that the backend will not be asked for files in the `/document/downloads` path for 3 minutes, one the initial visit is served.

Then images an scrips are cached at the client, as evidenced in the header `Cache-Control: max-age=300`.
