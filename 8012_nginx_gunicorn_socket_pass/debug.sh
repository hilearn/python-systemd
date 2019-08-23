set -e
set -x

gunicorn -w 1 hello:app --bind localhost:7999
