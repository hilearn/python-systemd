import argparse
import http.server
import socketserver
from http import HTTPStatus


class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(HTTPStatus.OK)
        self.end_headers()
        self.wfile.write(b'Hello world')



if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--socket-path', type=str, required=True)
    args = parser.parse_args()
    print(args.socket_path)
    httpd = socketserver.UnixStreamServer(args.socket_path,
                                          Handler)
    httpd.serve_forever()
