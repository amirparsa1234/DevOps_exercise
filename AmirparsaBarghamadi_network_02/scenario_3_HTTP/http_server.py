import http.server
import socketserver

PORT = 8080

class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        body = b"""<!doctype html>
<html>
<head><meta charset="utf-8"><title>HTTP Lab</title></head>
<body>
<h1>It works</h1>
<p>Simple HTTP page on port 8080.</p>
</body>
</html>
"""
        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print("http://localhost:8080")
    httpd.serve_forever()
