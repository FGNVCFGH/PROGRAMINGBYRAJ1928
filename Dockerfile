FROM python:3.10-slim

# Install Flask
RUN pip install flask

# Create simple Flask server
RUN echo "\
from flask import Flask, send_from_directory\n\
app = Flask(__name__, static_folder='.')\n\
@app.route('/')\n\
def home():\n\
    return send_from_directory('.', 'index.html')\n\
@app.route('/<path:path>')\n\
def static_proxy(path):\n\
    return send_from_directory('.', path)\n\
if __name__ == '__main__':\n\
    app.run(host='0.0.0.0', port=5000)\n\
" > app.py

EXPOSE 5000

CMD ["python", "app.py"]
