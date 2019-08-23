import argparse
import http.server
import socketserver
from http import HTTPStatus
from helpers import write_pid


class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(HTTPStatus.OK)
        self.end_headers()
        print('zkjlk')
        self.wfile.write(b'Hello world')



if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--port', type=int, default=8000)
    parser.add_argument('--pid', type=str, help='Location to store the pid.')
    args = parser.parse_args()

    if args.pid is not None:
        write_pid(args.pid)

    httpd = socketserver.TCPServer(('', args.port), Handler)
    httpd.serve_forever()
