# CDN (simple)

CDN = many servers in many places.

Goal:
- faster load for users
- less load on the main server (origin)

Origin:
- the main server (real source)

Edge:
- CDN server close to user
- can cache files

Quick check (example):
curl -I https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js

In headers you may see:
- via
- age
- x-cache
- cf-cache-status

Sample headers (cdn.jsdelivr.net):
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
HTTP/2 200 
date: Fri, 02 Jan 2026 19:16:45 GMT
content-type: application/javascript; charset=utf-8
cf-ray: 9b7c97ba3d6ad38c-FRA
access-control-allow-origin: *
access-control-expose-headers: *
timing-allow-origin: *
cache-control: public, max-age=31536000, s-maxage=31536000, immutable
cross-origin-resource-policy: cross-origin
x-content-type-options: nosniff
strict-transport-security: max-age=31536000; includeSubDomains; preload
x-jsd-version: 3.6.0
x-jsd-version-type: version
etag: W/"15d9d-uC0jjU4x/fYYuuisEabIEsA90NQ"
age: 921618
x-served-by: cache-fra-eddf8230072-FRA
x-cache: HIT
vary: Accept-Encoding
alt-svc: h3=":443"; ma=86400
cf-cache-status: HIT
report-to: {"endpoints":[{"url":"https:\/\/a.nel.cloudflare.com\/report\/v4?s=0DhCjqrubV4QopeuO4SIyvF7rHEPWCeusJ10As5kQa9m5e6UTytRZWpOQ1oQT42ZR9fTrYO0%2BCGMYMEeOwclbSAV%2BKwL8VA4wnWRpZgZuH5ymEAfxUIhL1Ta7UDxBVeZw6s%3D"}],"group":"cf-nel","max_age":604800}
nel: {"success_fraction":0.01,"report_to":"cf-nel","max_age":604800}
server: cloudflare

```
