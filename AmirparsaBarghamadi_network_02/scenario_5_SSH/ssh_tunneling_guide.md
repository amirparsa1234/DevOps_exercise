SSH tunneling (simple)

1) Local port forwarding
Command:
  ssh -L 8080:localhost:80 user@server
Use case:
- You want to open a website on the server (port 80) from your own laptop (localhost:8080).

2) Remote port forwarding
Command:
  ssh -R 9000:localhost:3000 user@server
Use case:
- You run an app on your laptop (port 3000) and you want server users to reach it via server:9000.

3) Dynamic port forwarding (SOCKS proxy)
Command:
  ssh -D 1080 user@server
Use case:
- You need a simple proxy tunnel for browsing/testing through the server.
